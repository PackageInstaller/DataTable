return {
	Play1102201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_4_0.name = "ST22"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22

				arg_1_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22" then
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

			local var_4_9 = arg_1_1.actors_.ui_story

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_10 and arg_1_1.time_ < 2 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.6

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1102201001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 24 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 24)

				if (24 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 24)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1102201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.325

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1102201002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 53 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 53)

				if (53 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 53)) > 0 and var_12_0 < var_12_3 then
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
	Play1102201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102201003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.475

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1102201003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 59 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 59)

				if (59 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 59)) > 0 and var_16_0 < var_16_3 then
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
	Play1102201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.425

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1102201004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 57 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 57)

				if (57 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 57)) > 0 and var_20_0 < var_20_3 then
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
	Play1102201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102201005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.9

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1102201005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 36 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 36)

				if (36 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 36)) > 0 and var_24_0 < var_24_3 then
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
	Play1102201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102201006
		arg_25_1.duration_ = 10.3

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.F01a == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01a")
				var_28_0.name = "F01a"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.F01a = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.F01a

				arg_25_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "F01a" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 4

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_4 + 0.3 and arg_25_1.time_ < var_28_4 + 0.3 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_5 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_6 = 2

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_5) / var_28_6)
				arg_25_1.mask_.color = var_28_7
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 then
				local var_28_8 = Color.New(0, 0, 0)

				var_28_8.a = 1
				arg_25_1.mask_.color = var_28_8
			end

			local var_28_9 = 1.999999999999

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_10 = 2

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 then
				local var_28_11 = Color.New(0, 0, 0)

				var_28_11.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_9) / var_28_10)
				arg_25_1.mask_.color = var_28_11
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 then
				local var_28_12 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_12.a = 0
				arg_25_1.mask_.color = var_28_12
			end

			if 0.233333333333333 < arg_25_1.time_ and arg_25_1.time_ <= 0.233333333333333 + arg_28_0 then
				arg_25_1:AudioAction("stop", "effect", "se_story_side_1022", "se_story_side_1022_crowd02", "")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_28_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_25_1.bgmTxt_.text ~= var_28_16 and arg_25_1.bgmTxt_.text ~= "" then
						if arg_25_1.bgmTxt2_.text ~= "" then
							arg_25_1.bgmTxt_.text = arg_25_1.bgmTxt2_.text
						end

						arg_25_1.bgmTxt2_.text = var_28_16

						arg_25_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_25_1.bgmTxt_.text = var_28_16
						arg_25_1.bgmTxt2_.text = var_28_16
					end

					if arg_25_1.bgmTimer then
						arg_25_1.bgmTimer:Stop()

						arg_25_1.bgmTimer = nil
					end

					if arg_25_1.settingData.show_music_name == 1 then
						arg_25_1.musicController:SetSelectedState("show")
						arg_25_1.musicAnimator_:Play("open", 0, 0)

						if arg_25_1.settingData.music_time ~= 0 then
							arg_25_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_25_1.settingData.music_time), function()
								if arg_25_1 == nil or isNil(arg_25_1.bgmTxt_) then
									return
								end

								arg_25_1.musicController:SetSelectedState("hide")
								arg_25_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.63333333333333 < arg_25_1.time_ and arg_25_1.time_ <= 1.63333333333333 + arg_28_0 then
				arg_25_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_28_19 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_25_1.bgmTxt_.text ~= var_28_19 and arg_25_1.bgmTxt_.text ~= "" then
						if arg_25_1.bgmTxt2_.text ~= "" then
							arg_25_1.bgmTxt_.text = arg_25_1.bgmTxt2_.text
						end

						arg_25_1.bgmTxt2_.text = var_28_19

						arg_25_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_25_1.bgmTxt_.text = var_28_19
						arg_25_1.bgmTxt2_.text = var_28_19
					end

					if arg_25_1.bgmTimer then
						arg_25_1.bgmTimer:Stop()

						arg_25_1.bgmTimer = nil
					end

					if arg_25_1.settingData.show_music_name == 1 then
						arg_25_1.musicController:SetSelectedState("show")
						arg_25_1.musicAnimator_:Play("open", 0, 0)

						if arg_25_1.settingData.music_time ~= 0 then
							arg_25_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_25_1.settingData.music_time), function()
								if arg_25_1 == nil or isNil(arg_25_1.bgmTxt_) then
									return
								end

								arg_25_1.musicController:SetSelectedState("hide")
								arg_25_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_25_1.time_ and arg_25_1.time_ <= 1.53333333333333 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_21 = 3.999999999999
			local var_28_22 = 0.9

			if 3.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_23 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_23:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_25_1.dialogCg_.alpha = arg_31_0
				end))
				var_28_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_24 = arg_25_1:GetWordFromCfg(1102201006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_27 = 36 <= 0 and var_28_22 or var_28_22 * (utf8.len(var_28_25) / 36)

				if (36 <= 0 and var_28_22 or var_28_22 * (utf8.len(var_28_25) / 36)) > 0 and var_28_22 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27
					var_28_21 = var_28_21 + 0.3

					if var_28_27 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201006", "story_v_side_new_1102201.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201006", "story_v_side_new_1102201.awb") / 1000

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_side_new_1102201", "1102201006", "story_v_side_new_1102201.awb")

						arg_25_1:RecordAudio("1102201006", var_28_29)
						arg_25_1:RecordAudio("1102201006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201006", "story_v_side_new_1102201.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201006", "story_v_side_new_1102201.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = var_28_21 + 0.3
			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_31 and arg_25_1.time_ < var_28_30 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102201007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102201007
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102201008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1102201007).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 22 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 22)

				if (22 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 22)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1102201008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102201008
		arg_37_1.duration_ = 5.1

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102201009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(1102201008)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 25 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 25)

				if (25 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 25)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201008", "story_v_side_new_1102201.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201008", "story_v_side_new_1102201.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_side_new_1102201", "1102201008", "story_v_side_new_1102201.awb")

						arg_37_1:RecordAudio("1102201008", var_40_6)
						arg_37_1:RecordAudio("1102201008", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201008", "story_v_side_new_1102201.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201008", "story_v_side_new_1102201.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1102201009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102201009
		arg_41_1.duration_ = 9

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102201010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.ST27 == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27")
				var_44_0.name = "ST27"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.ST27 = var_44_0
			end

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= 2 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.ST27

				arg_41_1.bgs_.ST27.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "ST27" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 3.999999999999

			if 3.999999999999 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
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

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_13 = 3.999999999999
			local var_44_14 = 1.925

			if 3.999999999999 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_15 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_15:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1102201009).content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_18 = 77 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 77)

				if (77 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 77)) > 0 and var_44_14 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18
					var_44_13 = var_44_13 + 0.3

					if var_44_18 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = var_44_13 + 0.3
			local var_44_20 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_19) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102201010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1102201010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1102201011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.775

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1102201010).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 31 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 31)

				if (31 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 31)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1102201011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1102201011
		arg_51_1.duration_ = 3.53

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1102201012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(1102201011)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)

				if (18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201011", "story_v_side_new_1102201.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201011", "story_v_side_new_1102201.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_side_new_1102201", "1102201011", "story_v_side_new_1102201.awb")

						arg_51_1:RecordAudio("1102201011", var_54_6)
						arg_51_1:RecordAudio("1102201011", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201011", "story_v_side_new_1102201.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201011", "story_v_side_new_1102201.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1102201012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1102201012
		arg_55_1.duration_ = 5.77

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1102201013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.525

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(1102201012)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 21 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 21)

				if (21 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 21)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201012", "story_v_side_new_1102201.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201012", "story_v_side_new_1102201.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_side_new_1102201", "1102201012", "story_v_side_new_1102201.awb")

						arg_55_1:RecordAudio("1102201012", var_58_6)
						arg_55_1:RecordAudio("1102201012", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201012", "story_v_side_new_1102201.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201012", "story_v_side_new_1102201.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1102201013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1102201013
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1102201014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1102201013).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 11 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 11)

				if (11 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 11)) > 0 and var_62_0 < var_62_3 then
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
	Play1102201014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1102201014
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1102201015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.bgs_.ST21 == nil then
				local var_66_0 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21")
				var_66_0.name = "ST21"
				var_66_0.transform.parent = arg_63_1.stage_.transform
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_.ST21 = var_66_0
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_1 = arg_63_1.bgs_.ST21

				arg_63_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_2 = var_66_1:GetComponent("SpriteRenderer")

				if var_66_2 and var_66_2.sprite then
					local var_66_3 = 2 * (var_66_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_1.transform.localScale = Vector3.New(var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "ST21" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_4 = 3.999999999999

			if 3.999999999999 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_4 + 0.3 and arg_63_1.time_ < var_66_4 + 0.3 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_5 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_6 = 2

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_5) / var_66_6)
				arg_63_1.mask_.color = var_66_7
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 then
				local var_66_8 = Color.New(0, 0, 0)

				var_66_8.a = 1
				arg_63_1.mask_.color = var_66_8
			end

			local var_66_9 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_10 = 2

			if var_66_9 <= arg_63_1.time_ and arg_63_1.time_ < var_66_9 + var_66_10 then
				local var_66_11 = Color.New(0, 0, 0)

				var_66_11.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_9) / var_66_10)
				arg_63_1.mask_.color = var_66_11
			end

			if arg_63_1.time_ >= var_66_9 + var_66_10 and arg_63_1.time_ < var_66_9 + var_66_10 + arg_66_0 then
				local var_66_12 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_12.a = 0
				arg_63_1.mask_.color = var_66_12
			end

			if 3.66666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 3.66666666666667 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_130", "se_story_130__knock", "")
			end

			if 0.8 < arg_63_1.time_ and arg_63_1.time_ <= 0.8 + arg_66_0 then
				arg_63_1:AudioAction("stop", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_15 = 3.999999999999
			local var_66_16 = 1.75

			if 3.999999999999 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_17 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_17:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_18 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1102201014).content)

				arg_63_1.text_.text = var_66_18

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_20 = 70 <= 0 and var_66_16 or var_66_16 * (utf8.len(var_66_18) / 70)

				if (70 <= 0 and var_66_16 or var_66_16 * (utf8.len(var_66_18) / 70)) > 0 and var_66_16 < var_66_20 then
					arg_63_1.talkMaxDuration = var_66_20
					var_66_15 = var_66_15 + 0.3

					if var_66_20 + var_66_15 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_20 + var_66_15
					end
				end

				arg_63_1.text_.text = var_66_18
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = var_66_15 + 0.3
			local var_66_22 = math.max(var_66_16, arg_63_1.talkMaxDuration)

			if var_66_15 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_21) / var_66_22

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1102201015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1102201015
		arg_69_1.duration_ = 3.43

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1102201016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1022ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1022ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1022ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1022ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1022ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1022ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1022ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1022ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1022ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1022ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1022ui_story, Vector3.New(0, -1.08, -6), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -1.08, -6)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1022ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1022ui_story == nil then
				arg_69_1.var_.characterEffect1022ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1022ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1022ui_story then
				arg_69_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_72_8 = 0
			local var_72_9 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(1102201015)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 14 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 14)

				if (14 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 14)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201015", "story_v_side_new_1102201.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201015", "story_v_side_new_1102201.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_side_new_1102201", "1102201015", "story_v_side_new_1102201.awb")

						arg_69_1:RecordAudio("1102201015", var_72_15)
						arg_69_1:RecordAudio("1102201015", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201015", "story_v_side_new_1102201.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201015", "story_v_side_new_1102201.awb")
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
				actorName = "1022ui_story",
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
	Play1102201016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1102201016
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1102201017(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1022ui_story"]) and arg_73_1.var_.characterEffect1022ui_story == nil then
				arg_73_1.var_.characterEffect1022ui_story = arg_73_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1022ui_story"]) then
				if arg_73_1.var_.characterEffect1022ui_story and not isNil(arg_73_1.actors_["1022ui_story"]) then
					arg_73_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1022ui_story"]) and arg_73_1.var_.characterEffect1022ui_story then
				arg_73_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 1.325

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

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1102201016).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 53 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 53)

				if (53 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 53)) > 0 and var_76_2 < var_76_5 then
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
	Play1102201017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1102201017
		arg_77_1.duration_ = 4.77

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1102201018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1022ui_story"]) and arg_77_1.var_.characterEffect1022ui_story == nil then
				arg_77_1.var_.characterEffect1022ui_story = arg_77_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1022ui_story"]) then
				if arg_77_1.var_.characterEffect1022ui_story and not isNil(arg_77_1.actors_["1022ui_story"]) then
					arg_77_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1022ui_story"]) and arg_77_1.var_.characterEffect1022ui_story then
				arg_77_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_2 = 0
			local var_80_3 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(1102201017)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 16 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 16)

				if (16 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 16)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201017", "story_v_side_new_1102201.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201017", "story_v_side_new_1102201.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_side_new_1102201", "1102201017", "story_v_side_new_1102201.awb")

						arg_77_1:RecordAudio("1102201017", var_80_9)
						arg_77_1:RecordAudio("1102201017", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201017", "story_v_side_new_1102201.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201017", "story_v_side_new_1102201.awb")
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
	Play1102201018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1102201018
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1102201019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1022ui_story"]) and arg_81_1.var_.characterEffect1022ui_story == nil then
				arg_81_1.var_.characterEffect1022ui_story = arg_81_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1022ui_story"]) then
				if arg_81_1.var_.characterEffect1022ui_story and not isNil(arg_81_1.actors_["1022ui_story"]) then
					arg_81_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1022ui_story"]) and arg_81_1.var_.characterEffect1022ui_story then
				arg_81_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_81_1.time_ and arg_81_1.time_ <= 0.1 + arg_84_0 then
				arg_81_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_water", "")
			end

			local var_84_2 = 0
			local var_84_3 = 1.1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1102201018).content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 44 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 44)

				if (44 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_4) / 44)) > 0 and var_84_3 < var_84_6 then
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
	Play1102201019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1102201019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1102201020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.4

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
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

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1102201019).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 16)

				if (16 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 16)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1102201020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1102201020
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1102201021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1022ui_story"]) and arg_89_1.var_.characterEffect1022ui_story == nil then
				arg_89_1.var_.characterEffect1022ui_story = arg_89_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1022ui_story"]) then
				if arg_89_1.var_.characterEffect1022ui_story and not isNil(arg_89_1.actors_["1022ui_story"]) then
					arg_89_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1022ui_story"]) and arg_89_1.var_.characterEffect1022ui_story then
				arg_89_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_92_2 = 0
			local var_92_3 = 1.05

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(1102201020)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 42 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 42)

				if (42 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 42)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201020", "story_v_side_new_1102201.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201020", "story_v_side_new_1102201.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_side_new_1102201", "1102201020", "story_v_side_new_1102201.awb")

						arg_89_1:RecordAudio("1102201020", var_92_9)
						arg_89_1:RecordAudio("1102201020", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201020", "story_v_side_new_1102201.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201020", "story_v_side_new_1102201.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1102201021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1102201021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1102201022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1022ui_story"]) and arg_93_1.var_.characterEffect1022ui_story == nil then
				arg_93_1.var_.characterEffect1022ui_story = arg_93_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1022ui_story"]) then
				if arg_93_1.var_.characterEffect1022ui_story and not isNil(arg_93_1.actors_["1022ui_story"]) then
					arg_93_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1022ui_story"]) and arg_93_1.var_.characterEffect1022ui_story then
				arg_93_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.55

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

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1102201021).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 22 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 22)

				if (22 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 22)) > 0 and var_96_2 < var_96_5 then
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
	Play1102201022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1102201022
		arg_97_1.duration_ = 3.07

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1102201023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1022ui_story"]) and arg_97_1.var_.characterEffect1022ui_story == nil then
				arg_97_1.var_.characterEffect1022ui_story = arg_97_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1022ui_story"]) then
				if arg_97_1.var_.characterEffect1022ui_story and not isNil(arg_97_1.actors_["1022ui_story"]) then
					arg_97_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1022ui_story"]) and arg_97_1.var_.characterEffect1022ui_story then
				arg_97_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_2 = 0
			local var_100_3 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(1102201022)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 13 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 13)

				if (13 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 13)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201022", "story_v_side_new_1102201.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201022", "story_v_side_new_1102201.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_side_new_1102201", "1102201022", "story_v_side_new_1102201.awb")

						arg_97_1:RecordAudio("1102201022", var_100_9)
						arg_97_1:RecordAudio("1102201022", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201022", "story_v_side_new_1102201.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201022", "story_v_side_new_1102201.awb")
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
	Play1102201023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1102201023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1102201024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1022ui_story"]) and arg_101_1.var_.characterEffect1022ui_story == nil then
				arg_101_1.var_.characterEffect1022ui_story = arg_101_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1022ui_story"]) then
				if arg_101_1.var_.characterEffect1022ui_story and not isNil(arg_101_1.actors_["1022ui_story"]) then
					arg_101_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1022ui_story"]) and arg_101_1.var_.characterEffect1022ui_story then
				arg_101_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.5

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1102201023).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 20 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 20)

				if (20 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 20)) > 0 and var_104_2 < var_104_5 then
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
	Play1102201024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1102201024
		arg_105_1.duration_ = 8.6

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1102201025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1022ui_story"]) and arg_105_1.var_.characterEffect1022ui_story == nil then
				arg_105_1.var_.characterEffect1022ui_story = arg_105_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1022ui_story"]) then
				if arg_105_1.var_.characterEffect1022ui_story and not isNil(arg_105_1.actors_["1022ui_story"]) then
					arg_105_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1022ui_story"]) and arg_105_1.var_.characterEffect1022ui_story then
				arg_105_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_108_2 = 0
			local var_108_3 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(1102201024)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 27 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 27)

				if (27 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 27)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201024", "story_v_side_new_1102201.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201024", "story_v_side_new_1102201.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_new_1102201", "1102201024", "story_v_side_new_1102201.awb")

						arg_105_1:RecordAudio("1102201024", var_108_9)
						arg_105_1:RecordAudio("1102201024", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201024", "story_v_side_new_1102201.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201024", "story_v_side_new_1102201.awb")
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
	Play1102201025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1102201025
		arg_109_1.duration_ = 5.9

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1102201026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_112_0 = 0
			local var_112_1 = 0.625

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(1102201025)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 25 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 25)

				if (25 <= 0 and var_112_1 or var_112_1 * (utf8.len(var_112_3) / 25)) > 0 and var_112_1 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201025", "story_v_side_new_1102201.awb") ~= 0 then
					local var_112_6 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201025", "story_v_side_new_1102201.awb") / 1000

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end

					if var_112_2.prefab_name ~= "" and arg_109_1.actors_[var_112_2.prefab_name] ~= nil then
						local var_112_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_2.prefab_name].transform, "story_v_side_new_1102201", "1102201025", "story_v_side_new_1102201.awb")

						arg_109_1:RecordAudio("1102201025", var_112_7)
						arg_109_1:RecordAudio("1102201025", var_112_7)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201025", "story_v_side_new_1102201.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201025", "story_v_side_new_1102201.awb")
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
	Play1102201026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1102201026
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1102201027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1022ui_story"]) and arg_113_1.var_.characterEffect1022ui_story == nil then
				arg_113_1.var_.characterEffect1022ui_story = arg_113_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1022ui_story"]) then
				if arg_113_1.var_.characterEffect1022ui_story and not isNil(arg_113_1.actors_["1022ui_story"]) then
					arg_113_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1022ui_story"]) and arg_113_1.var_.characterEffect1022ui_story then
				arg_113_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.825

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

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1102201026).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 33 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 33)

				if (33 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 33)) > 0 and var_116_2 < var_116_5 then
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
	Play1102201027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1102201027
		arg_117_1.duration_ = 7.17

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1102201028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1022ui_story"]) and arg_117_1.var_.characterEffect1022ui_story == nil then
				arg_117_1.var_.characterEffect1022ui_story = arg_117_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1022ui_story"]) then
				if arg_117_1.var_.characterEffect1022ui_story and not isNil(arg_117_1.actors_["1022ui_story"]) then
					arg_117_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1022ui_story"]) and arg_117_1.var_.characterEffect1022ui_story then
				arg_117_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 0.775

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(1102201027)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 31 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 31)

				if (31 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 31)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201027", "story_v_side_new_1102201.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201027", "story_v_side_new_1102201.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_new_1102201", "1102201027", "story_v_side_new_1102201.awb")

						arg_117_1:RecordAudio("1102201027", var_120_9)
						arg_117_1:RecordAudio("1102201027", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201027", "story_v_side_new_1102201.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201027", "story_v_side_new_1102201.awb")
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
	Play1102201028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1102201028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1102201029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1022ui_story"]) and arg_121_1.var_.characterEffect1022ui_story == nil then
				arg_121_1.var_.characterEffect1022ui_story = arg_121_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1022ui_story"]) then
				if arg_121_1.var_.characterEffect1022ui_story and not isNil(arg_121_1.actors_["1022ui_story"]) then
					arg_121_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1022ui_story"]) and arg_121_1.var_.characterEffect1022ui_story then
				arg_121_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 1.925

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

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1102201028).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 77 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 77)

				if (77 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 77)) > 0 and var_124_2 < var_124_5 then
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
	Play1102201029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1102201029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1102201030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1102201029).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 21)

				if (21 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 21)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1102201030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1102201030
		arg_129_1.duration_ = 4.7

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1102201031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1022ui_story"]) and arg_129_1.var_.characterEffect1022ui_story == nil then
				arg_129_1.var_.characterEffect1022ui_story = arg_129_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1022ui_story"]) then
				if arg_129_1.var_.characterEffect1022ui_story and not isNil(arg_129_1.actors_["1022ui_story"]) then
					arg_129_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1022ui_story"]) and arg_129_1.var_.characterEffect1022ui_story then
				arg_129_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			local var_132_2 = 0
			local var_132_3 = 0.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(1102201030)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 18 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 18)

				if (18 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 18)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201030", "story_v_side_new_1102201.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201030", "story_v_side_new_1102201.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_side_new_1102201", "1102201030", "story_v_side_new_1102201.awb")

						arg_129_1:RecordAudio("1102201030", var_132_9)
						arg_129_1:RecordAudio("1102201030", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201030", "story_v_side_new_1102201.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201030", "story_v_side_new_1102201.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1102201031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1102201031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1102201032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1022ui_story"]) and arg_133_1.var_.characterEffect1022ui_story == nil then
				arg_133_1.var_.characterEffect1022ui_story = arg_133_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1022ui_story"]) then
				if arg_133_1.var_.characterEffect1022ui_story and not isNil(arg_133_1.actors_["1022ui_story"]) then
					arg_133_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1022ui_story"]) and arg_133_1.var_.characterEffect1022ui_story then
				arg_133_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.475

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

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1102201031).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 19 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 19)

				if (19 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 19)) > 0 and var_136_2 < var_136_5 then
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
	Play1102201032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1102201032
		arg_137_1.duration_ = 6.6

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1102201033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1022ui_story"]) and arg_137_1.var_.characterEffect1022ui_story == nil then
				arg_137_1.var_.characterEffect1022ui_story = arg_137_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1022ui_story"]) then
				if arg_137_1.var_.characterEffect1022ui_story and not isNil(arg_137_1.actors_["1022ui_story"]) then
					arg_137_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1022ui_story"]) and arg_137_1.var_.characterEffect1022ui_story then
				arg_137_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_140_2 = 0
			local var_140_3 = 0.675

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(1102201032)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)

				if (27 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 27)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201032", "story_v_side_new_1102201.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201032", "story_v_side_new_1102201.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_side_new_1102201", "1102201032", "story_v_side_new_1102201.awb")

						arg_137_1:RecordAudio("1102201032", var_140_9)
						arg_137_1:RecordAudio("1102201032", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201032", "story_v_side_new_1102201.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201032", "story_v_side_new_1102201.awb")
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
	Play1102201033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1102201033
		arg_141_1.duration_ = 4.47

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1102201034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_144_0 = 0
			local var_144_1 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(1102201033)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 21 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 21)

				if (21 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 21)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201033", "story_v_side_new_1102201.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201033", "story_v_side_new_1102201.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_side_new_1102201", "1102201033", "story_v_side_new_1102201.awb")

						arg_141_1:RecordAudio("1102201033", var_144_7)
						arg_141_1:RecordAudio("1102201033", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201033", "story_v_side_new_1102201.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201033", "story_v_side_new_1102201.awb")
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
	Play1102201034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1102201034
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1102201035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1022ui_story"]) and arg_145_1.var_.characterEffect1022ui_story == nil then
				arg_145_1.var_.characterEffect1022ui_story = arg_145_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1022ui_story"]) then
				if arg_145_1.var_.characterEffect1022ui_story and not isNil(arg_145_1.actors_["1022ui_story"]) then
					arg_145_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1022ui_story"]) and arg_145_1.var_.characterEffect1022ui_story then
				arg_145_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1022ui_story.fillRatio = 0.5
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

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1102201034).content)

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
	Play1102201035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1102201035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1102201036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.75

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1102201035).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 70 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 70)

				if (70 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 70)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1102201036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1102201036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1102201037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.65

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

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1102201036).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 26)

				if (26 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 26)) > 0 and var_156_0 < var_156_3 then
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
	Play1102201037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1102201037
		arg_157_1.duration_ = 5.5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1102201038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1022ui_story"]) and arg_157_1.var_.characterEffect1022ui_story == nil then
				arg_157_1.var_.characterEffect1022ui_story = arg_157_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1022ui_story"]) then
				if arg_157_1.var_.characterEffect1022ui_story and not isNil(arg_157_1.actors_["1022ui_story"]) then
					arg_157_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1022ui_story"]) and arg_157_1.var_.characterEffect1022ui_story then
				arg_157_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_160_2 = 0
			local var_160_3 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_2 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_4 = arg_157_1:GetWordFromCfg(1102201037)
				local var_160_5 = arg_157_1:FormatText(var_160_4.content)

				arg_157_1.text_.text = var_160_5

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_7 = 20 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 20)

				if (20 <= 0 and var_160_3 or var_160_3 * (utf8.len(var_160_5) / 20)) > 0 and var_160_3 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_2
					end
				end

				arg_157_1.text_.text = var_160_5
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201037", "story_v_side_new_1102201.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201037", "story_v_side_new_1102201.awb") / 1000

					if var_160_8 + var_160_2 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_2
					end

					if var_160_4.prefab_name ~= "" and arg_157_1.actors_[var_160_4.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_4.prefab_name].transform, "story_v_side_new_1102201", "1102201037", "story_v_side_new_1102201.awb")

						arg_157_1:RecordAudio("1102201037", var_160_9)
						arg_157_1:RecordAudio("1102201037", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201037", "story_v_side_new_1102201.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201037", "story_v_side_new_1102201.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_3, arg_157_1.talkMaxDuration)

			if var_160_2 <= arg_157_1.time_ and arg_157_1.time_ < var_160_2 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_2) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_2 + var_160_10 and arg_157_1.time_ < var_160_2 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1102201038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1102201038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1102201039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1022ui_story = arg_161_1.actors_["1022ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1022ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1022ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).z)
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles = arg_161_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1022ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1022ui_story"].transform.position).z)
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1022ui_story"].transform.localEulerAngles = arg_161_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1022ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1022ui_story == nil then
				arg_161_1.var_.characterEffect1022ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1022ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1022ui_story then
				arg_161_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_164_3 = 0
			local var_164_4 = 1.975

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1102201038).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 79 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 79)

				if (79 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 79)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
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
	Play1102201039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1102201039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1102201040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1102201039).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 45 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 45)

				if (45 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 45)) > 0 and var_168_0 < var_168_3 then
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
	Play1102201040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1102201040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1102201041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.35

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

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1102201040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 14 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 14)

				if (14 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 14)) > 0 and var_172_0 < var_172_3 then
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
	Play1102201041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1102201041
		arg_173_1.duration_ = 2.1

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1102201042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1022ui_story = arg_173_1.actors_["1022ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1022ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1022ui_story, Vector3.New(0, -1.08, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).z)
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles = arg_173_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1022ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_173_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1022ui_story"].transform.position).z)
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1022ui_story"].transform.localEulerAngles = arg_173_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1022ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1022ui_story == nil then
				arg_173_1.var_.characterEffect1022ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1022ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1022ui_story then
				arg_173_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(1102201041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 10 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 10)

				if (10 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 10)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201041", "story_v_side_new_1102201.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201041", "story_v_side_new_1102201.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_side_new_1102201", "1102201041", "story_v_side_new_1102201.awb")

						arg_173_1:RecordAudio("1102201041", var_176_11)
						arg_173_1:RecordAudio("1102201041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201041", "story_v_side_new_1102201.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201041", "story_v_side_new_1102201.awb")
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
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play1102201042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1102201042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1102201043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1022ui_story"]) and arg_177_1.var_.characterEffect1022ui_story == nil then
				arg_177_1.var_.characterEffect1022ui_story = arg_177_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1022ui_story"]) then
				if arg_177_1.var_.characterEffect1022ui_story and not isNil(arg_177_1.actors_["1022ui_story"]) then
					arg_177_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1022ui_story"]) and arg_177_1.var_.characterEffect1022ui_story then
				arg_177_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.7

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
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

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1102201042).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 28 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 28)

				if (28 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 28)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1102201043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1102201043
		arg_181_1.duration_ = 8.17

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1102201044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1022ui_story"]) and arg_181_1.var_.characterEffect1022ui_story == nil then
				arg_181_1.var_.characterEffect1022ui_story = arg_181_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1022ui_story"]) then
				if arg_181_1.var_.characterEffect1022ui_story and not isNil(arg_181_1.actors_["1022ui_story"]) then
					arg_181_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1022ui_story"]) and arg_181_1.var_.characterEffect1022ui_story then
				arg_181_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_184_2 = 0
			local var_184_3 = 0.875

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(1102201043)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 35 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 35)

				if (35 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 35)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201043", "story_v_side_new_1102201.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201043", "story_v_side_new_1102201.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_side_new_1102201", "1102201043", "story_v_side_new_1102201.awb")

						arg_181_1:RecordAudio("1102201043", var_184_9)
						arg_181_1:RecordAudio("1102201043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201043", "story_v_side_new_1102201.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201043", "story_v_side_new_1102201.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1102201044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1102201044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1102201045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1022ui_story"]) and arg_185_1.var_.characterEffect1022ui_story == nil then
				arg_185_1.var_.characterEffect1022ui_story = arg_185_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1022ui_story"]) then
				if arg_185_1.var_.characterEffect1022ui_story and not isNil(arg_185_1.actors_["1022ui_story"]) then
					arg_185_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1022ui_story"]) and arg_185_1.var_.characterEffect1022ui_story then
				arg_185_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_188_1 = 0
			local var_188_2 = 1.55

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1102201044).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 62 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 62)

				if (62 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 62)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1102201045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1102201045
		arg_189_1.duration_ = 10.23

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1102201046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1022ui_story"]) and arg_189_1.var_.characterEffect1022ui_story == nil then
				arg_189_1.var_.characterEffect1022ui_story = arg_189_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1022ui_story"]) then
				if arg_189_1.var_.characterEffect1022ui_story and not isNil(arg_189_1.actors_["1022ui_story"]) then
					arg_189_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1022ui_story"]) and arg_189_1.var_.characterEffect1022ui_story then
				arg_189_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_2 = 0
			local var_192_3 = 1.05

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:GetWordFromCfg(1102201045)
				local var_192_5 = arg_189_1:FormatText(var_192_4.content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 42 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 42)

				if (42 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_5) / 42)) > 0 and var_192_3 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201045", "story_v_side_new_1102201.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201045", "story_v_side_new_1102201.awb") / 1000

					if var_192_8 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_2
					end

					if var_192_4.prefab_name ~= "" and arg_189_1.actors_[var_192_4.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_4.prefab_name].transform, "story_v_side_new_1102201", "1102201045", "story_v_side_new_1102201.awb")

						arg_189_1:RecordAudio("1102201045", var_192_9)
						arg_189_1:RecordAudio("1102201045", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201045", "story_v_side_new_1102201.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201045", "story_v_side_new_1102201.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_10 and arg_189_1.time_ < var_192_2 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1102201046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1102201046
		arg_193_1.duration_ = 8.13

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1102201047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.875

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(1102201046)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 35 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 35)

				if (35 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 35)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201046", "story_v_side_new_1102201.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201046", "story_v_side_new_1102201.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_side_new_1102201", "1102201046", "story_v_side_new_1102201.awb")

						arg_193_1:RecordAudio("1102201046", var_196_6)
						arg_193_1:RecordAudio("1102201046", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201046", "story_v_side_new_1102201.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201046", "story_v_side_new_1102201.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1102201047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1102201047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1102201048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1022ui_story"]) and arg_197_1.var_.characterEffect1022ui_story == nil then
				arg_197_1.var_.characterEffect1022ui_story = arg_197_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1022ui_story"]) then
				if arg_197_1.var_.characterEffect1022ui_story and not isNil(arg_197_1.actors_["1022ui_story"]) then
					arg_197_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1022ui_story"]) and arg_197_1.var_.characterEffect1022ui_story then
				arg_197_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_200_1 = 0
			local var_200_2 = 0.525

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

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1102201047).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 21 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 21)

				if (21 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 21)) > 0 and var_200_2 < var_200_5 then
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
	Play1102201048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1102201048
		arg_201_1.duration_ = 8.47

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1102201049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1022ui_story"]) and arg_201_1.var_.characterEffect1022ui_story == nil then
				arg_201_1.var_.characterEffect1022ui_story = arg_201_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1022ui_story"]) then
				if arg_201_1.var_.characterEffect1022ui_story and not isNil(arg_201_1.actors_["1022ui_story"]) then
					arg_201_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1022ui_story"]) and arg_201_1.var_.characterEffect1022ui_story then
				arg_201_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			local var_204_2 = 0
			local var_204_3 = 0.825

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(1102201048)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 33 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 33)

				if (33 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 33)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201048", "story_v_side_new_1102201.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201048", "story_v_side_new_1102201.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_side_new_1102201", "1102201048", "story_v_side_new_1102201.awb")

						arg_201_1:RecordAudio("1102201048", var_204_9)
						arg_201_1:RecordAudio("1102201048", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201048", "story_v_side_new_1102201.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201048", "story_v_side_new_1102201.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1102201049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1102201049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1102201050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1022ui_story"]) and arg_205_1.var_.characterEffect1022ui_story == nil then
				arg_205_1.var_.characterEffect1022ui_story = arg_205_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1022ui_story"]) then
				if arg_205_1.var_.characterEffect1022ui_story and not isNil(arg_205_1.actors_["1022ui_story"]) then
					arg_205_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1022ui_story"]) and arg_205_1.var_.characterEffect1022ui_story then
				arg_205_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.65

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
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

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1102201049).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 26 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 26)

				if (26 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 26)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1102201050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1102201050
		arg_209_1.duration_ = 8.3

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1102201051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1022ui_story"]) and arg_209_1.var_.characterEffect1022ui_story == nil then
				arg_209_1.var_.characterEffect1022ui_story = arg_209_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1022ui_story"]) then
				if arg_209_1.var_.characterEffect1022ui_story and not isNil(arg_209_1.actors_["1022ui_story"]) then
					arg_209_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1022ui_story"]) and arg_209_1.var_.characterEffect1022ui_story then
				arg_209_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_2")
			end

			local var_212_2 = 0
			local var_212_3 = 0.825

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(1102201050)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 33 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 33)

				if (33 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 33)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201050", "story_v_side_new_1102201.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201050", "story_v_side_new_1102201.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_side_new_1102201", "1102201050", "story_v_side_new_1102201.awb")

						arg_209_1:RecordAudio("1102201050", var_212_9)
						arg_209_1:RecordAudio("1102201050", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201050", "story_v_side_new_1102201.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201050", "story_v_side_new_1102201.awb")
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
	Play1102201051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1102201051
		arg_213_1.duration_ = 6.13

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1102201052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.6

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(1102201051)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 24 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 24)

				if (24 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 24)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201051", "story_v_side_new_1102201.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201051", "story_v_side_new_1102201.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_side_new_1102201", "1102201051", "story_v_side_new_1102201.awb")

						arg_213_1:RecordAudio("1102201051", var_216_6)
						arg_213_1:RecordAudio("1102201051", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201051", "story_v_side_new_1102201.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201051", "story_v_side_new_1102201.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1102201052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1102201052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1102201053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1022ui_story"]) and arg_217_1.var_.characterEffect1022ui_story == nil then
				arg_217_1.var_.characterEffect1022ui_story = arg_217_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1022ui_story"]) then
				if arg_217_1.var_.characterEffect1022ui_story and not isNil(arg_217_1.actors_["1022ui_story"]) then
					arg_217_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1022ui_story"]) and arg_217_1.var_.characterEffect1022ui_story then
				arg_217_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.475

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
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

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1102201052).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 19 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 19)

				if (19 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 19)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1102201053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1102201053
		arg_221_1.duration_ = 10

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1102201054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1022ui_story"]) and arg_221_1.var_.characterEffect1022ui_story == nil then
				arg_221_1.var_.characterEffect1022ui_story = arg_221_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1022ui_story"]) then
				if arg_221_1.var_.characterEffect1022ui_story and not isNil(arg_221_1.actors_["1022ui_story"]) then
					arg_221_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1022ui_story"]) and arg_221_1.var_.characterEffect1022ui_story then
				arg_221_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_224_2 = 0
			local var_224_3 = 0.975

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(1102201053)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 39 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 39)

				if (39 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 39)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201053", "story_v_side_new_1102201.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201053", "story_v_side_new_1102201.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_side_new_1102201", "1102201053", "story_v_side_new_1102201.awb")

						arg_221_1:RecordAudio("1102201053", var_224_9)
						arg_221_1:RecordAudio("1102201053", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201053", "story_v_side_new_1102201.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201053", "story_v_side_new_1102201.awb")
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
	Play1102201054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1102201054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1102201055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1022ui_story"]) and arg_225_1.var_.characterEffect1022ui_story == nil then
				arg_225_1.var_.characterEffect1022ui_story = arg_225_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1022ui_story"]) then
				if arg_225_1.var_.characterEffect1022ui_story and not isNil(arg_225_1.actors_["1022ui_story"]) then
					arg_225_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1022ui_story"]) and arg_225_1.var_.characterEffect1022ui_story then
				arg_225_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 1.025

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
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

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1102201054).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 41 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 41)

				if (41 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 41)) > 0 and var_228_2 < var_228_5 then
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
	Play1102201055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1102201055
		arg_229_1.duration_ = 10.57

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1102201056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1022ui_story"]) and arg_229_1.var_.characterEffect1022ui_story == nil then
				arg_229_1.var_.characterEffect1022ui_story = arg_229_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1022ui_story"]) then
				if arg_229_1.var_.characterEffect1022ui_story and not isNil(arg_229_1.actors_["1022ui_story"]) then
					arg_229_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1022ui_story"]) and arg_229_1.var_.characterEffect1022ui_story then
				arg_229_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_232_2 = 0
			local var_232_3 = 1.075

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(1102201055)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 43 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 43)

				if (43 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 43)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201055", "story_v_side_new_1102201.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201055", "story_v_side_new_1102201.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_new_1102201", "1102201055", "story_v_side_new_1102201.awb")

						arg_229_1:RecordAudio("1102201055", var_232_9)
						arg_229_1:RecordAudio("1102201055", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201055", "story_v_side_new_1102201.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201055", "story_v_side_new_1102201.awb")
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
	Play1102201056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1102201056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1102201057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1022ui_story"]) and arg_233_1.var_.characterEffect1022ui_story == nil then
				arg_233_1.var_.characterEffect1022ui_story = arg_233_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1022ui_story"]) then
				if arg_233_1.var_.characterEffect1022ui_story and not isNil(arg_233_1.actors_["1022ui_story"]) then
					arg_233_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1022ui_story"]) and arg_233_1.var_.characterEffect1022ui_story then
				arg_233_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.55

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

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1102201056).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 22 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 22)

				if (22 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 22)) > 0 and var_236_2 < var_236_5 then
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
	Play1102201057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1102201057
		arg_237_1.duration_ = 9.13

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1102201058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1022ui_story"]) and arg_237_1.var_.characterEffect1022ui_story == nil then
				arg_237_1.var_.characterEffect1022ui_story = arg_237_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1022ui_story"]) then
				if arg_237_1.var_.characterEffect1022ui_story and not isNil(arg_237_1.actors_["1022ui_story"]) then
					arg_237_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1022ui_story"]) and arg_237_1.var_.characterEffect1022ui_story then
				arg_237_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_240_2 = 0
			local var_240_3 = 1

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(1102201057)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 40 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 40)

				if (40 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 40)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201057", "story_v_side_new_1102201.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201057", "story_v_side_new_1102201.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_side_new_1102201", "1102201057", "story_v_side_new_1102201.awb")

						arg_237_1:RecordAudio("1102201057", var_240_9)
						arg_237_1:RecordAudio("1102201057", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201057", "story_v_side_new_1102201.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201057", "story_v_side_new_1102201.awb")
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
	Play1102201058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1102201058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1102201059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1022ui_story"]) and arg_241_1.var_.characterEffect1022ui_story == nil then
				arg_241_1.var_.characterEffect1022ui_story = arg_241_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1022ui_story"]) then
				if arg_241_1.var_.characterEffect1022ui_story and not isNil(arg_241_1.actors_["1022ui_story"]) then
					arg_241_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1022ui_story"]) and arg_241_1.var_.characterEffect1022ui_story then
				arg_241_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.75

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
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

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1102201058).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 30 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 30)

				if (30 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 30)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1102201059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1102201059
		arg_245_1.duration_ = 7.57

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1102201060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1022ui_story"]) and arg_245_1.var_.characterEffect1022ui_story == nil then
				arg_245_1.var_.characterEffect1022ui_story = arg_245_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1022ui_story"]) then
				if arg_245_1.var_.characterEffect1022ui_story and not isNil(arg_245_1.actors_["1022ui_story"]) then
					arg_245_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1022ui_story"]) and arg_245_1.var_.characterEffect1022ui_story then
				arg_245_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_248_2 = 0
			local var_248_3 = 0.725

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:GetWordFromCfg(1102201059)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 29 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 29)

				if (29 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 29)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201059", "story_v_side_new_1102201.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201059", "story_v_side_new_1102201.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_side_new_1102201", "1102201059", "story_v_side_new_1102201.awb")

						arg_245_1:RecordAudio("1102201059", var_248_9)
						arg_245_1:RecordAudio("1102201059", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201059", "story_v_side_new_1102201.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201059", "story_v_side_new_1102201.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1102201060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1102201060
		arg_249_1.duration_ = 1

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"

			SetActive(arg_249_1.choicesGo_, true)

			for iter_250_0, iter_250_1 in ipairs(arg_249_1.choices_) do
				SetActive(iter_250_1.go, iter_250_0 <= 2)
			end

			arg_249_1.choices_[1].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1119].name)
			arg_249_1.choices_[2].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1120].name)
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1102201061(arg_249_1)
			end

			if arg_251_0 == 2 then
				arg_249_0:Play1102201062(arg_249_1)
			end

			arg_249_1:RecordChoiceLog(1102201060, 1119, 1120)
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1022ui_story"]) and arg_249_1.var_.characterEffect1022ui_story == nil then
				arg_249_1.var_.characterEffect1022ui_story = arg_249_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1022ui_story"]) then
				if arg_249_1.var_.characterEffect1022ui_story and not isNil(arg_249_1.actors_["1022ui_story"]) then
					arg_249_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1022ui_story"]) and arg_249_1.var_.characterEffect1022ui_story then
				arg_249_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			if arg_249_1.time_ >= var_252_1 + 0.5 and arg_249_1.time_ < var_252_1 + 0.5 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1102201061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1102201061
		arg_253_1.duration_ = 2.73

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1102201065(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1022ui_story"]) and arg_253_1.var_.characterEffect1022ui_story == nil then
				arg_253_1.var_.characterEffect1022ui_story = arg_253_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1022ui_story"]) then
				if arg_253_1.var_.characterEffect1022ui_story and not isNil(arg_253_1.actors_["1022ui_story"]) then
					arg_253_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1022ui_story"]) and arg_253_1.var_.characterEffect1022ui_story then
				arg_253_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_256_2 = 0
			local var_256_3 = 0.3

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(1102201061)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 12 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 12)

				if (12 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 12)) > 0 and var_256_3 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201061", "story_v_side_new_1102201.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201061", "story_v_side_new_1102201.awb") / 1000

					if var_256_8 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_2
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_side_new_1102201", "1102201061", "story_v_side_new_1102201.awb")

						arg_253_1:RecordAudio("1102201061", var_256_9)
						arg_253_1:RecordAudio("1102201061", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201061", "story_v_side_new_1102201.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201061", "story_v_side_new_1102201.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_10 and arg_253_1.time_ < var_256_2 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1102201065 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1102201065
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1102201066(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				local var_260_0 = arg_257_1.bgs_.ST21

				arg_257_1.bgs_.ST21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_1 = var_260_0:GetComponent("SpriteRenderer")

				if var_260_1 and var_260_1.sprite then
					local var_260_2 = 2 * (var_260_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_0.transform.localScale = Vector3.New(var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "ST21" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_3 = 3.96666666666667

			if 3.96666666666667 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.allBtn_.enabled = false
			end

			if arg_257_1.time_ >= var_260_3 + 0.3 and arg_257_1.time_ < var_260_3 + 0.3 + arg_260_0 then
				arg_257_1.allBtn_.enabled = true
			end

			local var_260_4 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_5 = 2

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_5 then
				local var_260_6 = Color.New(0, 0, 0)

				var_260_6.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_4) / var_260_5)
				arg_257_1.mask_.color = var_260_6
			end

			if arg_257_1.time_ >= var_260_4 + var_260_5 and arg_257_1.time_ < var_260_4 + var_260_5 + arg_260_0 then
				local var_260_7 = Color.New(0, 0, 0)

				var_260_7.a = 1
				arg_257_1.mask_.color = var_260_7
			end

			local var_260_8 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_9 = 2

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 then
				local var_260_10 = Color.New(0, 0, 0)

				var_260_10.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_8) / var_260_9)
				arg_257_1.mask_.color = var_260_10
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 then
				local var_260_11 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_11.a = 0
				arg_257_1.mask_.color = var_260_11
			end

			local var_260_12 = arg_257_1.actors_["1022ui_story"].transform

			if 1.96599999815226 < arg_257_1.time_ and arg_257_1.time_ <= 1.96599999815226 + arg_260_0 then
				arg_257_1.var_.moveOldPos1022ui_story = var_260_12.localPosition
			end

			local var_260_13 = 0.001

			if 1.96599999815226 <= arg_257_1.time_ and arg_257_1.time_ < 1.96599999815226 + var_260_13 then
				var_260_12.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1022ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 1.96599999815226) / var_260_13)
				var_260_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_12.position).x, (manager.ui.mainCamera.transform.position - var_260_12.position).y, (manager.ui.mainCamera.transform.position - var_260_12.position).z)
				var_260_12.localEulerAngles.z = 0
				var_260_12.localEulerAngles.x = 0
				var_260_12.localEulerAngles = var_260_12.localEulerAngles
			end

			if arg_257_1.time_ >= 1.96599999815226 + var_260_13 and arg_257_1.time_ < 1.96599999815226 + var_260_13 + arg_260_0 then
				var_260_12.localPosition = Vector3.New(0, 100, 0)
				var_260_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_12.position).x, (manager.ui.mainCamera.transform.position - var_260_12.position).y, (manager.ui.mainCamera.transform.position - var_260_12.position).z)
				var_260_12.localEulerAngles.z = 0
				var_260_12.localEulerAngles.x = 0
				var_260_12.localEulerAngles = var_260_12.localEulerAngles
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_14 = 4
			local var_260_15 = 1.1

			if 4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_14 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_16 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_16:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

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

				local var_260_17 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1102201065).content)

				arg_257_1.text_.text = var_260_17

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_19 = 44 <= 0 and var_260_15 or var_260_15 * (utf8.len(var_260_17) / 44)

				if (44 <= 0 and var_260_15 or var_260_15 * (utf8.len(var_260_17) / 44)) > 0 and var_260_15 < var_260_19 then
					arg_257_1.talkMaxDuration = var_260_19
					var_260_14 = var_260_14 + 0.3

					if var_260_19 + var_260_14 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_14
					end
				end

				arg_257_1.text_.text = var_260_17
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_20 = var_260_14 + 0.3
			local var_260_21 = math.max(var_260_15, arg_257_1.talkMaxDuration)

			if var_260_14 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_20 + var_260_21 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_20) / var_260_21

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_20 + var_260_21 and arg_257_1.time_ < var_260_20 + var_260_21 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1102201066 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1102201066
		arg_263_1.duration_ = 3.6

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1102201067(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1022ui_story = arg_263_1.actors_["1022ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1022ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1022ui_story, Vector3.New(0, -1.08, -6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).z)
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles = arg_263_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1022ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_263_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1022ui_story"].transform.position).z)
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1022ui_story"].transform.localEulerAngles = arg_263_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1022ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1022ui_story == nil then
				arg_263_1.var_.characterEffect1022ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1022ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1022ui_story then
				arg_263_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_266_4 = 0
			local var_266_5 = 0.475

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(1102201066)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 19 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 19)

				if (19 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 19)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201066", "story_v_side_new_1102201.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201066", "story_v_side_new_1102201.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_side_new_1102201", "1102201066", "story_v_side_new_1102201.awb")

						arg_263_1:RecordAudio("1102201066", var_266_11)
						arg_263_1:RecordAudio("1102201066", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201066", "story_v_side_new_1102201.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201066", "story_v_side_new_1102201.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1102201067 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102201067
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102201068(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1022ui_story"]) and arg_267_1.var_.characterEffect1022ui_story == nil then
				arg_267_1.var_.characterEffect1022ui_story = arg_267_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1022ui_story"]) then
				if arg_267_1.var_.characterEffect1022ui_story and not isNil(arg_267_1.actors_["1022ui_story"]) then
					arg_267_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1022ui_story"]) and arg_267_1.var_.characterEffect1022ui_story then
				arg_267_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 1.95

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1102201067).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 78 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 78)

				if (78 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 78)) > 0 and var_270_2 < var_270_5 then
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
	Play1102201068 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1102201068
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1102201069(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.675

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

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1102201068).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 27 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 27)

				if (27 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 27)) > 0 and var_274_0 < var_274_3 then
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
	Play1102201069 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1102201069
		arg_275_1.duration_ = 6.27

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1102201070(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1022ui_story"]) and arg_275_1.var_.characterEffect1022ui_story == nil then
				arg_275_1.var_.characterEffect1022ui_story = arg_275_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1022ui_story"]) then
				if arg_275_1.var_.characterEffect1022ui_story and not isNil(arg_275_1.actors_["1022ui_story"]) then
					arg_275_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1022ui_story"]) and arg_275_1.var_.characterEffect1022ui_story then
				arg_275_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_278_2 = 0
			local var_278_3 = 0.5

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(1102201069)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 20 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 20)

				if (20 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 20)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201069", "story_v_side_new_1102201.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201069", "story_v_side_new_1102201.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_side_new_1102201", "1102201069", "story_v_side_new_1102201.awb")

						arg_275_1:RecordAudio("1102201069", var_278_9)
						arg_275_1:RecordAudio("1102201069", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201069", "story_v_side_new_1102201.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201069", "story_v_side_new_1102201.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1102201070 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1102201070
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1102201071(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1022ui_story"]) and arg_279_1.var_.characterEffect1022ui_story == nil then
				arg_279_1.var_.characterEffect1022ui_story = arg_279_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1022ui_story"]) then
				if arg_279_1.var_.characterEffect1022ui_story and not isNil(arg_279_1.actors_["1022ui_story"]) then
					arg_279_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1022ui_story"]) and arg_279_1.var_.characterEffect1022ui_story then
				arg_279_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			if 0.866666666666667 < arg_279_1.time_ and arg_279_1.time_ <= 0.866666666666667 + arg_282_0 then
				arg_279_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_finger", "")
			end

			local var_282_2 = 0
			local var_282_3 = 0.925

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1102201070).content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 37 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 37)

				if (37 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 37)) > 0 and var_282_3 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_7 and arg_279_1.time_ < var_282_2 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1102201071 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1102201071
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1102201072(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.875

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

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1102201071).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 35 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 35)

				if (35 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 35)) > 0 and var_286_0 < var_286_3 then
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
	Play1102201072 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1102201072
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1102201073(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.825

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1102201072).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 33)

				if (33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 33)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1102201073 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1102201073
		arg_291_1.duration_ = 6

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1102201074(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1022ui_story"]) and arg_291_1.var_.characterEffect1022ui_story == nil then
				arg_291_1.var_.characterEffect1022ui_story = arg_291_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1022ui_story"]) then
				if arg_291_1.var_.characterEffect1022ui_story and not isNil(arg_291_1.actors_["1022ui_story"]) then
					arg_291_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1022ui_story"]) and arg_291_1.var_.characterEffect1022ui_story then
				arg_291_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_294_2 = 0
			local var_294_3 = 0.475

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(1102201073)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201073", "story_v_side_new_1102201.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201073", "story_v_side_new_1102201.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_side_new_1102201", "1102201073", "story_v_side_new_1102201.awb")

						arg_291_1:RecordAudio("1102201073", var_294_9)
						arg_291_1:RecordAudio("1102201073", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201073", "story_v_side_new_1102201.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201073", "story_v_side_new_1102201.awb")
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
	Play1102201074 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1102201074
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1102201075(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1022ui_story"]) and arg_295_1.var_.characterEffect1022ui_story == nil then
				arg_295_1.var_.characterEffect1022ui_story = arg_295_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1022ui_story"]) then
				if arg_295_1.var_.characterEffect1022ui_story and not isNil(arg_295_1.actors_["1022ui_story"]) then
					arg_295_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1022ui_story"]) and arg_295_1.var_.characterEffect1022ui_story then
				arg_295_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.475

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
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

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1102201074).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 19 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 19)

				if (19 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 19)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1102201075 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1102201075
		arg_299_1.duration_ = 4.6

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1102201076(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1022ui_story"]) and arg_299_1.var_.characterEffect1022ui_story == nil then
				arg_299_1.var_.characterEffect1022ui_story = arg_299_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1022ui_story"]) then
				if arg_299_1.var_.characterEffect1022ui_story and not isNil(arg_299_1.actors_["1022ui_story"]) then
					arg_299_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1022ui_story"]) and arg_299_1.var_.characterEffect1022ui_story then
				arg_299_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1022ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			local var_302_2 = 0
			local var_302_3 = 0.45

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:GetWordFromCfg(1102201075)
				local var_302_5 = arg_299_1:FormatText(var_302_4.content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 18 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 18)

				if (18 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 18)) > 0 and var_302_3 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201075", "story_v_side_new_1102201.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201075", "story_v_side_new_1102201.awb") / 1000

					if var_302_8 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_2
					end

					if var_302_4.prefab_name ~= "" and arg_299_1.actors_[var_302_4.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_4.prefab_name].transform, "story_v_side_new_1102201", "1102201075", "story_v_side_new_1102201.awb")

						arg_299_1:RecordAudio("1102201075", var_302_9)
						arg_299_1:RecordAudio("1102201075", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201075", "story_v_side_new_1102201.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201075", "story_v_side_new_1102201.awb")
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
	Play1102201076 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1102201076
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1102201077(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1022ui_story = arg_303_1.actors_["1022ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1022ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1022ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).z)
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles = arg_303_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1022ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_303_1.actors_["1022ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1022ui_story"].transform.position).z)
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1022ui_story"].transform.localEulerAngles = arg_303_1.actors_["1022ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1022ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1022ui_story == nil then
				arg_303_1.var_.characterEffect1022ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1022ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_2)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1022ui_story then
				arg_303_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_306_3 = 0
			local var_306_4 = 1.35

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_3 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_5 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1102201076).content)

				arg_303_1.text_.text = var_306_5

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_7 = 54 <= 0 and var_306_4 or var_306_4 * (utf8.len(var_306_5) / 54)

				if (54 <= 0 and var_306_4 or var_306_4 * (utf8.len(var_306_5) / 54)) > 0 and var_306_4 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_3 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_3
					end
				end

				arg_303_1.text_.text = var_306_5
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_4, arg_303_1.talkMaxDuration)

			if var_306_3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_3 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_3) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_3 + var_306_8 and arg_303_1.time_ < var_306_3 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play1102201077 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1102201077
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1102201078(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.3

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

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1102201077).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 12 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 12)

				if (12 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 12)) > 0 and var_310_0 < var_310_3 then
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
	Play1102201078 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1102201078
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1102201079(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.55

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
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

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1102201078).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 22 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 22)

				if (22 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 22)) > 0 and var_314_0 < var_314_3 then
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
	Play1102201079 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1102201079
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1102201080(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 1.4

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1102201079).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 56 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 56)

				if (56 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 56)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1102201080 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1102201080
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1102201081(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.275

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1102201080).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 51 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 51)

				if (51 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 51)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1102201081 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1102201081
		arg_323_1.duration_ = 8.17

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1102201082(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if arg_323_1.bgs_.ST21a == nil then
				local var_326_0 = Object.Instantiate(arg_323_1.paintGo_)

				var_326_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST21a")
				var_326_0.name = "ST21a"
				var_326_0.transform.parent = arg_323_1.stage_.transform
				var_326_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.bgs_.ST21a = var_326_0
			end

			if 3 < arg_323_1.time_ and arg_323_1.time_ <= 3 + arg_326_0 then
				local var_326_1 = arg_323_1.bgs_.ST21a

				arg_323_1.bgs_.ST21a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_326_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_326_2 = var_326_1:GetComponent("SpriteRenderer")

				if var_326_2 and var_326_2.sprite then
					local var_326_3 = 2 * (var_326_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_326_1.transform.localScale = Vector3.New(var_326_3 / var_326_2.sprite.bounds.size.y < var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x and var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x or var_326_3 / var_326_2.sprite.bounds.size.y, var_326_3 / var_326_2.sprite.bounds.size.y < var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x and var_326_3 * manager.ui.mainCameraCom_.aspect / var_326_2.sprite.bounds.size.x or var_326_3 / var_326_2.sprite.bounds.size.y, 0)
				end

				for iter_326_0, iter_326_1 in pairs(arg_323_1.bgs_) do
					if iter_326_0 ~= "ST21a" then
						iter_326_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_326_4 = 5

			if 5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.allBtn_.enabled = false
			end

			if arg_323_1.time_ >= var_326_4 + 0.3 and arg_323_1.time_ < var_326_4 + 0.3 + arg_326_0 then
				arg_323_1.allBtn_.enabled = true
			end

			local var_326_5 = 0

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_6 = 3

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_6 then
				local var_326_7 = Color.New(0, 0, 0)

				var_326_7.a = Mathf.Lerp(0, 1, (arg_323_1.time_ - var_326_5) / var_326_6)
				arg_323_1.mask_.color = var_326_7
			end

			if arg_323_1.time_ >= var_326_5 + var_326_6 and arg_323_1.time_ < var_326_5 + var_326_6 + arg_326_0 then
				local var_326_8 = Color.New(0, 0, 0)

				var_326_8.a = 1
				arg_323_1.mask_.color = var_326_8
			end

			local var_326_9 = 3

			if 3 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = true

				arg_323_1:SetGaussion(false)
			end

			local var_326_10 = 2

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_10 then
				local var_326_11 = Color.New(0, 0, 0)

				var_326_11.a = Mathf.Lerp(1, 0, (arg_323_1.time_ - var_326_9) / var_326_10)
				arg_323_1.mask_.color = var_326_11
			end

			if arg_323_1.time_ >= var_326_9 + var_326_10 and arg_323_1.time_ < var_326_9 + var_326_10 + arg_326_0 then
				local var_326_12 = Color.New(0, 0, 0)

				arg_323_1.mask_.enabled = false
				var_326_12.a = 0
				arg_323_1.mask_.color = var_326_12
			end

			local var_326_13 = arg_323_1.actors_["1022ui_story"].transform

			if 2.96599999815226 < arg_323_1.time_ and arg_323_1.time_ <= 2.96599999815226 + arg_326_0 then
				arg_323_1.var_.moveOldPos1022ui_story = var_326_13.localPosition
			end

			local var_326_14 = 0.001

			if 2.96599999815226 <= arg_323_1.time_ and arg_323_1.time_ < 2.96599999815226 + var_326_14 then
				var_326_13.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1022ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 2.96599999815226) / var_326_14)
				var_326_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_13.position).x, (manager.ui.mainCamera.transform.position - var_326_13.position).y, (manager.ui.mainCamera.transform.position - var_326_13.position).z)
				var_326_13.localEulerAngles.z = 0
				var_326_13.localEulerAngles.x = 0
				var_326_13.localEulerAngles = var_326_13.localEulerAngles
			end

			if arg_323_1.time_ >= 2.96599999815226 + var_326_14 and arg_323_1.time_ < 2.96599999815226 + var_326_14 + arg_326_0 then
				var_326_13.localPosition = Vector3.New(0, 100, 0)
				var_326_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_13.position).x, (manager.ui.mainCamera.transform.position - var_326_13.position).y, (manager.ui.mainCamera.transform.position - var_326_13.position).z)
				var_326_13.localEulerAngles.z = 0
				var_326_13.localEulerAngles.x = 0
				var_326_13.localEulerAngles = var_326_13.localEulerAngles
			end

			local var_326_15 = "102201ui_story"

			if arg_323_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_326_16 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_323_1.stage_.transform)

				var_326_16.name = var_326_15
				var_326_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_[var_326_15] = var_326_16

				local var_326_17 = var_326_16:GetComponentInChildren(typeof(CharacterEffect))

				var_326_17.enabled = true

				local var_326_18 = GameObjectTools.GetOrAddComponent(var_326_16, typeof(DynamicBoneHelper))

				if var_326_18 then
					var_326_18:EnableDynamicBone(false)
				end

				arg_323_1:ShowWeapon(var_326_17.transform, false)

				arg_323_1.var_[var_326_15 .. "Animator"] = var_326_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_323_1.var_[var_326_15 .. "Animator"].applyRootMotion = true
				arg_323_1.var_[var_326_15 .. "LipSync"] = var_326_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_326_19 = arg_323_1.actors_["102201ui_story"].transform

			if 4.8 < arg_323_1.time_ and arg_323_1.time_ <= 4.8 + arg_326_0 then
				arg_323_1.var_.moveOldPos102201ui_story = var_326_19.localPosition
			end

			local var_326_20 = 0.001

			if 4.8 <= arg_323_1.time_ and arg_323_1.time_ < 4.8 + var_326_20 then
				var_326_19.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_323_1.time_ - 4.8) / var_326_20)
				var_326_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_19.position).x, (manager.ui.mainCamera.transform.position - var_326_19.position).y, (manager.ui.mainCamera.transform.position - var_326_19.position).z)
				var_326_19.localEulerAngles.z = 0
				var_326_19.localEulerAngles.x = 0
				var_326_19.localEulerAngles = var_326_19.localEulerAngles
			end

			if arg_323_1.time_ >= 4.8 + var_326_20 and arg_323_1.time_ < 4.8 + var_326_20 + arg_326_0 then
				var_326_19.localPosition = Vector3.New(0, -1.08, -6)
				var_326_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_19.position).x, (manager.ui.mainCamera.transform.position - var_326_19.position).y, (manager.ui.mainCamera.transform.position - var_326_19.position).z)
				var_326_19.localEulerAngles.z = 0
				var_326_19.localEulerAngles.x = 0
				var_326_19.localEulerAngles = var_326_19.localEulerAngles
			end

			local var_326_21 = arg_323_1.actors_["102201ui_story"]

			if 4.8 < arg_323_1.time_ and arg_323_1.time_ <= 4.8 + arg_326_0 and not isNil(var_326_21) and arg_323_1.var_.characterEffect102201ui_story == nil then
				arg_323_1.var_.characterEffect102201ui_story = var_326_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_22 = 0.200000002980232

			if 4.8 <= arg_323_1.time_ and arg_323_1.time_ < 4.8 + var_326_22 and not isNil(var_326_21) then
				if arg_323_1.var_.characterEffect102201ui_story and not isNil(var_326_21) then
					arg_323_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 4.8 + var_326_22 and arg_323_1.time_ < 4.8 + var_326_22 + arg_326_0 and not isNil(var_326_21) and arg_323_1.var_.characterEffect102201ui_story then
				arg_323_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 4.8 < arg_323_1.time_ and arg_323_1.time_ <= 4.8 + arg_326_0 then
				arg_323_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_1")
			end

			if 4.8 < arg_323_1.time_ and arg_323_1.time_ <= 4.8 + arg_326_0 then
				arg_323_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_326_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_323_1.bgmTxt_.text ~= var_326_26 and arg_323_1.bgmTxt_.text ~= "" then
						if arg_323_1.bgmTxt2_.text ~= "" then
							arg_323_1.bgmTxt_.text = arg_323_1.bgmTxt2_.text
						end

						arg_323_1.bgmTxt2_.text = var_326_26

						arg_323_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_323_1.bgmTxt_.text = var_326_26
						arg_323_1.bgmTxt2_.text = var_326_26
					end

					if arg_323_1.bgmTimer then
						arg_323_1.bgmTimer:Stop()

						arg_323_1.bgmTimer = nil
					end

					if arg_323_1.settingData.show_music_name == 1 then
						arg_323_1.musicController:SetSelectedState("show")
						arg_323_1.musicAnimator_:Play("open", 0, 0)

						if arg_323_1.settingData.music_time ~= 0 then
							arg_323_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_323_1.settingData.music_time), function()
								if arg_323_1 == nil or isNil(arg_323_1.bgmTxt_) then
									return
								end

								arg_323_1.musicController:SetSelectedState("hide")
								arg_323_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.1 < arg_323_1.time_ and arg_323_1.time_ <= 2.1 + arg_326_0 then
				arg_323_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_326_29 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_323_1.bgmTxt_.text ~= var_326_29 and arg_323_1.bgmTxt_.text ~= "" then
						if arg_323_1.bgmTxt2_.text ~= "" then
							arg_323_1.bgmTxt_.text = arg_323_1.bgmTxt2_.text
						end

						arg_323_1.bgmTxt2_.text = var_326_29

						arg_323_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_323_1.bgmTxt_.text = var_326_29
						arg_323_1.bgmTxt2_.text = var_326_29
					end

					if arg_323_1.bgmTimer then
						arg_323_1.bgmTimer:Stop()

						arg_323_1.bgmTimer = nil
					end

					if arg_323_1.settingData.show_music_name == 1 then
						arg_323_1.musicController:SetSelectedState("show")
						arg_323_1.musicAnimator_:Play("open", 0, 0)

						if arg_323_1.settingData.music_time ~= 0 then
							arg_323_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_323_1.settingData.music_time), function()
								if arg_323_1 == nil or isNil(arg_323_1.bgmTxt_) then
									return
								end

								arg_323_1.musicController:SetSelectedState("hide")
								arg_323_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_323_1.frameCnt_ <= 1 then
				arg_323_1.dialog_:SetActive(false)
			end

			local var_326_30 = 5
			local var_326_31 = 0.275

			if 5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_30 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_32 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_32:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_323_1.dialogCg_.alpha = arg_329_0
				end))
				var_326_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_33 = arg_323_1:GetWordFromCfg(1102201081)
				local var_326_34 = arg_323_1:FormatText(var_326_33.content)

				arg_323_1.text_.text = var_326_34

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_36 = 11 <= 0 and var_326_31 or var_326_31 * (utf8.len(var_326_34) / 11)

				if (11 <= 0 and var_326_31 or var_326_31 * (utf8.len(var_326_34) / 11)) > 0 and var_326_31 < var_326_36 then
					arg_323_1.talkMaxDuration = var_326_36
					var_326_30 = var_326_30 + 0.3

					if var_326_36 + var_326_30 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_36 + var_326_30
					end
				end

				arg_323_1.text_.text = var_326_34
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201081", "story_v_side_new_1102201.awb") ~= 0 then
					local var_326_37 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201081", "story_v_side_new_1102201.awb") / 1000

					if var_326_37 + var_326_30 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_37 + var_326_30
					end

					if var_326_33.prefab_name ~= "" and arg_323_1.actors_[var_326_33.prefab_name] ~= nil then
						local var_326_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_33.prefab_name].transform, "story_v_side_new_1102201", "1102201081", "story_v_side_new_1102201.awb")

						arg_323_1:RecordAudio("1102201081", var_326_38)
						arg_323_1:RecordAudio("1102201081", var_326_38)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201081", "story_v_side_new_1102201.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201081", "story_v_side_new_1102201.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_39 = var_326_30 + 0.3
			local var_326_40 = math.max(var_326_31, arg_323_1.talkMaxDuration)

			if var_326_30 + 0.3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_39 + var_326_40 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_39) / var_326_40

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_39 + var_326_40 and arg_323_1.time_ < var_326_39 + var_326_40 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1022ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1102201082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1102201082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1102201083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["102201ui_story"]) and arg_331_1.var_.characterEffect102201ui_story == nil then
				arg_331_1.var_.characterEffect102201ui_story = arg_331_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["102201ui_story"]) then
				if arg_331_1.var_.characterEffect102201ui_story and not isNil(arg_331_1.actors_["102201ui_story"]) then
					arg_331_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_331_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["102201ui_story"]) and arg_331_1.var_.characterEffect102201ui_story then
				arg_331_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_331_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 1.625

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1102201082).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 65 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 65)

				if (65 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 65)) > 0 and var_334_2 < var_334_5 then
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
	Play1102201083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1102201083
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1102201084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.675

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(1102201083).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 27 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 27)

				if (27 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 27)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1102201084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1102201084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1102201085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.75

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
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

				local var_342_1 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1102201084).content)

				arg_339_1.text_.text = var_342_1

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_3 = 30 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 30)

				if (30 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_1) / 30)) > 0 and var_342_0 < var_342_3 then
					arg_339_1.talkMaxDuration = var_342_3

					if var_342_3 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_3 + 0
					end
				end

				arg_339_1.text_.text = var_342_1
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_4 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_4

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1102201085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1102201085
		arg_343_1.duration_ = 5.03

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1102201086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["102201ui_story"]) and arg_343_1.var_.characterEffect102201ui_story == nil then
				arg_343_1.var_.characterEffect102201ui_story = arg_343_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["102201ui_story"]) then
				if arg_343_1.var_.characterEffect102201ui_story and not isNil(arg_343_1.actors_["102201ui_story"]) then
					arg_343_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["102201ui_story"]) and arg_343_1.var_.characterEffect102201ui_story then
				arg_343_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_346_2 = 0
			local var_346_3 = 0.525

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:GetWordFromCfg(1102201085)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_7 = 21 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 21)

				if (21 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 21)) > 0 and var_346_3 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201085", "story_v_side_new_1102201.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201085", "story_v_side_new_1102201.awb") / 1000

					if var_346_8 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_2
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_side_new_1102201", "1102201085", "story_v_side_new_1102201.awb")

						arg_343_1:RecordAudio("1102201085", var_346_9)
						arg_343_1:RecordAudio("1102201085", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201085", "story_v_side_new_1102201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201085", "story_v_side_new_1102201.awb")
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
	Play1102201086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1102201086
		arg_347_1.duration_ = 1

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"

			SetActive(arg_347_1.choicesGo_, true)

			for iter_348_0, iter_348_1 in ipairs(arg_347_1.choices_) do
				SetActive(iter_348_1.go, iter_348_0 <= 2)
			end

			arg_347_1.choices_[1].txt.text = arg_347_1:FormatText(StoryChoiceCfg[1121].name)
			arg_347_1.choices_[2].txt.text = arg_347_1:FormatText(StoryChoiceCfg[1122].name)
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1102201087(arg_347_1)
			end

			if arg_349_0 == 2 then
				arg_347_0:Play1102201088(arg_347_1)
			end

			arg_347_1:RecordChoiceLog(1102201086, 1121, 1122)
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["102201ui_story"]) and arg_347_1.var_.characterEffect102201ui_story == nil then
				arg_347_1.var_.characterEffect102201ui_story = arg_347_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["102201ui_story"]) then
				if arg_347_1.var_.characterEffect102201ui_story and not isNil(arg_347_1.actors_["102201ui_story"]) then
					arg_347_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_347_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["102201ui_story"]) and arg_347_1.var_.characterEffect102201ui_story then
				arg_347_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_347_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.allBtn_.enabled = false
			end

			if arg_347_1.time_ >= var_350_1 + 0.5 and arg_347_1.time_ < var_350_1 + 0.5 + arg_350_0 then
				arg_347_1.allBtn_.enabled = true
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1102201087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1102201087
		arg_351_1.duration_ = 3.27

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1102201089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["102201ui_story"]) and arg_351_1.var_.characterEffect102201ui_story == nil then
				arg_351_1.var_.characterEffect102201ui_story = arg_351_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["102201ui_story"]) then
				if arg_351_1.var_.characterEffect102201ui_story and not isNil(arg_351_1.actors_["102201ui_story"]) then
					arg_351_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["102201ui_story"]) and arg_351_1.var_.characterEffect102201ui_story then
				arg_351_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			local var_354_2 = 0
			local var_354_3 = 0.35

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(1102201087)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 14 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 14)

				if (14 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 14)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201087", "story_v_side_new_1102201.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201087", "story_v_side_new_1102201.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_side_new_1102201", "1102201087", "story_v_side_new_1102201.awb")

						arg_351_1:RecordAudio("1102201087", var_354_9)
						arg_351_1:RecordAudio("1102201087", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201087", "story_v_side_new_1102201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201087", "story_v_side_new_1102201.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1102201089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1102201089
		arg_355_1.duration_ = 3.9

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1102201090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_358_0 = 0
			local var_358_1 = 0.475

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_2 = arg_355_1:GetWordFromCfg(1102201089)
				local var_358_3 = arg_355_1:FormatText(var_358_2.content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 19 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_3) / 19)

				if (19 <= 0 and var_358_1 or var_358_1 * (utf8.len(var_358_3) / 19)) > 0 and var_358_1 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201089", "story_v_side_new_1102201.awb") ~= 0 then
					local var_358_6 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201089", "story_v_side_new_1102201.awb") / 1000

					if var_358_6 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_0
					end

					if var_358_2.prefab_name ~= "" and arg_355_1.actors_[var_358_2.prefab_name] ~= nil then
						local var_358_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_2.prefab_name].transform, "story_v_side_new_1102201", "1102201089", "story_v_side_new_1102201.awb")

						arg_355_1:RecordAudio("1102201089", var_358_7)
						arg_355_1:RecordAudio("1102201089", var_358_7)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201089", "story_v_side_new_1102201.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201089", "story_v_side_new_1102201.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_8 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_8 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_8

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_8 and arg_355_1.time_ < var_358_0 + var_358_8 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1102201090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1102201090
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1102201091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["102201ui_story"]) and arg_359_1.var_.characterEffect102201ui_story == nil then
				arg_359_1.var_.characterEffect102201ui_story = arg_359_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["102201ui_story"]) then
				if arg_359_1.var_.characterEffect102201ui_story and not isNil(arg_359_1.actors_["102201ui_story"]) then
					arg_359_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_359_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_0)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["102201ui_story"]) and arg_359_1.var_.characterEffect102201ui_story then
				arg_359_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_359_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_362_1 = 0
			local var_362_2 = 0.7

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

				local var_362_3 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1102201090).content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 28 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 28)

				if (28 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_3) / 28)) > 0 and var_362_2 < var_362_5 then
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
	Play1102201091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1102201091
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1102201092(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.825

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

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1102201091).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 33 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 33)

				if (33 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 33)) > 0 and var_366_0 < var_366_3 then
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
	Play1102201092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1102201092
		arg_367_1.duration_ = 2.6

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1102201093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["102201ui_story"]) and arg_367_1.var_.characterEffect102201ui_story == nil then
				arg_367_1.var_.characterEffect102201ui_story = arg_367_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_0 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["102201ui_story"]) then
				if arg_367_1.var_.characterEffect102201ui_story and not isNil(arg_367_1.actors_["102201ui_story"]) then
					arg_367_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["102201ui_story"]) and arg_367_1.var_.characterEffect102201ui_story then
				arg_367_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_370_2 = 0
			local var_370_3 = 0.325

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_4 = arg_367_1:GetWordFromCfg(1102201092)
				local var_370_5 = arg_367_1:FormatText(var_370_4.content)

				arg_367_1.text_.text = var_370_5

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 13 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 13)

				if (13 <= 0 and var_370_3 or var_370_3 * (utf8.len(var_370_5) / 13)) > 0 and var_370_3 < var_370_7 then
					arg_367_1.talkMaxDuration = var_370_7

					if var_370_7 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_7 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_5
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201092", "story_v_side_new_1102201.awb") ~= 0 then
					local var_370_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201092", "story_v_side_new_1102201.awb") / 1000

					if var_370_8 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_8 + var_370_2
					end

					if var_370_4.prefab_name ~= "" and arg_367_1.actors_[var_370_4.prefab_name] ~= nil then
						local var_370_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_4.prefab_name].transform, "story_v_side_new_1102201", "1102201092", "story_v_side_new_1102201.awb")

						arg_367_1:RecordAudio("1102201092", var_370_9)
						arg_367_1:RecordAudio("1102201092", var_370_9)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201092", "story_v_side_new_1102201.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201092", "story_v_side_new_1102201.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_10 = math.max(var_370_3, arg_367_1.talkMaxDuration)

			if var_370_2 <= arg_367_1.time_ and arg_367_1.time_ < var_370_2 + var_370_10 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_2) / var_370_10

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_2 + var_370_10 and arg_367_1.time_ < var_370_2 + var_370_10 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1102201093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1102201093
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1102201094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["102201ui_story"]) and arg_371_1.var_.characterEffect102201ui_story == nil then
				arg_371_1.var_.characterEffect102201ui_story = arg_371_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["102201ui_story"]) then
				if arg_371_1.var_.characterEffect102201ui_story and not isNil(arg_371_1.actors_["102201ui_story"]) then
					arg_371_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_371_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["102201ui_story"]) and arg_371_1.var_.characterEffect102201ui_story then
				arg_371_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_371_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.375

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1102201093).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 15 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 15)

				if (15 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 15)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_6 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_6

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_6 and arg_371_1.time_ < var_374_1 + var_374_6 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1102201094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1102201094
		arg_375_1.duration_ = 9

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1102201095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if arg_375_1.bgs_.STblack == nil then
				local var_378_0 = Object.Instantiate(arg_375_1.paintGo_)

				var_378_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_378_0.name = "STblack"
				var_378_0.transform.parent = arg_375_1.stage_.transform
				var_378_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_375_1.bgs_.STblack = var_378_0
			end

			if 2 < arg_375_1.time_ and arg_375_1.time_ <= 2 + arg_378_0 then
				local var_378_1 = arg_375_1.bgs_.STblack

				arg_375_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_378_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_378_2 = var_378_1:GetComponent("SpriteRenderer")

				if var_378_2 and var_378_2.sprite then
					local var_378_3 = 2 * (var_378_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_378_1.transform.localScale = Vector3.New(var_378_3 / var_378_2.sprite.bounds.size.y < var_378_3 * manager.ui.mainCameraCom_.aspect / var_378_2.sprite.bounds.size.x and var_378_3 * manager.ui.mainCameraCom_.aspect / var_378_2.sprite.bounds.size.x or var_378_3 / var_378_2.sprite.bounds.size.y, var_378_3 / var_378_2.sprite.bounds.size.y < var_378_3 * manager.ui.mainCameraCom_.aspect / var_378_2.sprite.bounds.size.x and var_378_3 * manager.ui.mainCameraCom_.aspect / var_378_2.sprite.bounds.size.x or var_378_3 / var_378_2.sprite.bounds.size.y, 0)
				end

				for iter_378_0, iter_378_1 in pairs(arg_375_1.bgs_) do
					if iter_378_0 ~= "STblack" then
						iter_378_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_378_4 = 4

			if 4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			if arg_375_1.time_ >= var_378_4 + 0.3 and arg_375_1.time_ < var_378_4 + 0.3 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			local var_378_5 = 0

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_6 = 2

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_6 then
				local var_378_7 = Color.New(0, 0, 0)

				var_378_7.a = Mathf.Lerp(0, 1, (arg_375_1.time_ - var_378_5) / var_378_6)
				arg_375_1.mask_.color = var_378_7
			end

			if arg_375_1.time_ >= var_378_5 + var_378_6 and arg_375_1.time_ < var_378_5 + var_378_6 + arg_378_0 then
				local var_378_8 = Color.New(0, 0, 0)

				var_378_8.a = 1
				arg_375_1.mask_.color = var_378_8
			end

			local var_378_9 = 2

			if 2 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_10 = 2

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_10 then
				local var_378_11 = Color.New(0, 0, 0)

				var_378_11.a = Mathf.Lerp(1, 0, (arg_375_1.time_ - var_378_9) / var_378_10)
				arg_375_1.mask_.color = var_378_11
			end

			if arg_375_1.time_ >= var_378_9 + var_378_10 and arg_375_1.time_ < var_378_9 + var_378_10 + arg_378_0 then
				local var_378_12 = Color.New(0, 0, 0)

				arg_375_1.mask_.enabled = false
				var_378_12.a = 0
				arg_375_1.mask_.color = var_378_12
			end

			local var_378_13 = arg_375_1.actors_["102201ui_story"].transform

			if 1.96599999815226 < arg_375_1.time_ and arg_375_1.time_ <= 1.96599999815226 + arg_378_0 then
				arg_375_1.var_.moveOldPos102201ui_story = var_378_13.localPosition
			end

			local var_378_14 = 0.001

			if 1.96599999815226 <= arg_375_1.time_ and arg_375_1.time_ < 1.96599999815226 + var_378_14 then
				var_378_13.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 1.96599999815226) / var_378_14)
				var_378_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_13.position).x, (manager.ui.mainCamera.transform.position - var_378_13.position).y, (manager.ui.mainCamera.transform.position - var_378_13.position).z)
				var_378_13.localEulerAngles.z = 0
				var_378_13.localEulerAngles.x = 0
				var_378_13.localEulerAngles = var_378_13.localEulerAngles
			end

			if arg_375_1.time_ >= 1.96599999815226 + var_378_14 and arg_375_1.time_ < 1.96599999815226 + var_378_14 + arg_378_0 then
				var_378_13.localPosition = Vector3.New(0, 100, 0)
				var_378_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_13.position).x, (manager.ui.mainCamera.transform.position - var_378_13.position).y, (manager.ui.mainCamera.transform.position - var_378_13.position).z)
				var_378_13.localEulerAngles.z = 0
				var_378_13.localEulerAngles.x = 0
				var_378_13.localEulerAngles = var_378_13.localEulerAngles
			end

			if arg_375_1.frameCnt_ <= 1 then
				arg_375_1.dialog_:SetActive(false)
			end

			local var_378_15 = 4
			local var_378_16 = 2.05

			if 4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_17 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_17:setOnUpdate(LuaHelper.FloatAction(function(arg_379_0)
					arg_375_1.dialogCg_.alpha = arg_379_0
				end))
				var_378_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1102201094).content)

				arg_375_1.text_.text = var_378_18

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 82 <= 0 and var_378_16 or var_378_16 * (utf8.len(var_378_18) / 82)

				if (82 <= 0 and var_378_16 or var_378_16 * (utf8.len(var_378_18) / 82)) > 0 and var_378_16 < var_378_20 then
					arg_375_1.talkMaxDuration = var_378_20
					var_378_15 = var_378_15 + 0.3

					if var_378_20 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_20 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_18
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_21 = var_378_15 + 0.3
			local var_378_22 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 + 0.3 <= arg_375_1.time_ and arg_375_1.time_ < var_378_21 + var_378_22 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_21) / var_378_22

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_21 + var_378_22 and arg_375_1.time_ < var_378_21 + var_378_22 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1102201095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1102201095
		arg_381_1.duration_ = 2.83

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1102201096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["102201ui_story"]) and arg_381_1.var_.characterEffect102201ui_story == nil then
				arg_381_1.var_.characterEffect102201ui_story = arg_381_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["102201ui_story"]) then
				if arg_381_1.var_.characterEffect102201ui_story and not isNil(arg_381_1.actors_["102201ui_story"]) then
					arg_381_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["102201ui_story"]) and arg_381_1.var_.characterEffect102201ui_story then
				arg_381_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_384_2 = 0
			local var_384_3 = 0.275

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102201")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_4 = arg_381_1:GetWordFromCfg(1102201095)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 11 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 11)

				if (11 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 11)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201095", "story_v_side_new_1102201.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201095", "story_v_side_new_1102201.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_side_new_1102201", "1102201095", "story_v_side_new_1102201.awb")

						arg_381_1:RecordAudio("1102201095", var_384_9)
						arg_381_1:RecordAudio("1102201095", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201095", "story_v_side_new_1102201.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201095", "story_v_side_new_1102201.awb")
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
	Play1102201096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1102201096
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1102201097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["102201ui_story"]) and arg_385_1.var_.characterEffect102201ui_story == nil then
				arg_385_1.var_.characterEffect102201ui_story = arg_385_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["102201ui_story"]) then
				if arg_385_1.var_.characterEffect102201ui_story and not isNil(arg_385_1.actors_["102201ui_story"]) then
					arg_385_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_385_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["102201ui_story"]) and arg_385_1.var_.characterEffect102201ui_story then
				arg_385_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_385_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 0.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(1102201096).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)

				if (13 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 13)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1102201097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1102201097
		arg_389_1.duration_ = 3.77

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1102201098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["102201ui_story"]) and arg_389_1.var_.characterEffect102201ui_story == nil then
				arg_389_1.var_.characterEffect102201ui_story = arg_389_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["102201ui_story"]) then
				if arg_389_1.var_.characterEffect102201ui_story and not isNil(arg_389_1.actors_["102201ui_story"]) then
					arg_389_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["102201ui_story"]) and arg_389_1.var_.characterEffect102201ui_story then
				arg_389_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_392_2 = 0
			local var_392_3 = 0.425

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102201")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_4 = arg_389_1:GetWordFromCfg(1102201097)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 17 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 17)

				if (17 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 17)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201097", "story_v_side_new_1102201.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201097", "story_v_side_new_1102201.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_side_new_1102201", "1102201097", "story_v_side_new_1102201.awb")

						arg_389_1:RecordAudio("1102201097", var_392_9)
						arg_389_1:RecordAudio("1102201097", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201097", "story_v_side_new_1102201.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201097", "story_v_side_new_1102201.awb")
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
	Play1102201098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1102201098
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1102201099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["102201ui_story"]) and arg_393_1.var_.characterEffect102201ui_story == nil then
				arg_393_1.var_.characterEffect102201ui_story = arg_393_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["102201ui_story"]) then
				if arg_393_1.var_.characterEffect102201ui_story and not isNil(arg_393_1.actors_["102201ui_story"]) then
					arg_393_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_393_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["102201ui_story"]) and arg_393_1.var_.characterEffect102201ui_story then
				arg_393_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_393_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.425

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1102201098).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 17 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 17)

				if (17 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 17)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1102201099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1102201099
		arg_397_1.duration_ = 3.7

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1102201100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["102201ui_story"]) and arg_397_1.var_.characterEffect102201ui_story == nil then
				arg_397_1.var_.characterEffect102201ui_story = arg_397_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["102201ui_story"]) then
				if arg_397_1.var_.characterEffect102201ui_story and not isNil(arg_397_1.actors_["102201ui_story"]) then
					arg_397_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["102201ui_story"]) and arg_397_1.var_.characterEffect102201ui_story then
				arg_397_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_400_2 = 0
			local var_400_3 = 0.475

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102201")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_4 = arg_397_1:GetWordFromCfg(1102201099)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 19 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 19)

				if (19 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 19)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201099", "story_v_side_new_1102201.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201099", "story_v_side_new_1102201.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_side_new_1102201", "1102201099", "story_v_side_new_1102201.awb")

						arg_397_1:RecordAudio("1102201099", var_400_9)
						arg_397_1:RecordAudio("1102201099", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201099", "story_v_side_new_1102201.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201099", "story_v_side_new_1102201.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1102201100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1102201100
		arg_401_1.duration_ = 2.83

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1102201101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.35

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102201")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(1102201100)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 14 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 14)

				if (14 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 14)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201100", "story_v_side_new_1102201.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201100", "story_v_side_new_1102201.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_side_new_1102201", "1102201100", "story_v_side_new_1102201.awb")

						arg_401_1:RecordAudio("1102201100", var_404_6)
						arg_401_1:RecordAudio("1102201100", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201100", "story_v_side_new_1102201.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201100", "story_v_side_new_1102201.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1102201101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1102201101
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1102201102(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["102201ui_story"]) and arg_405_1.var_.characterEffect102201ui_story == nil then
				arg_405_1.var_.characterEffect102201ui_story = arg_405_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["102201ui_story"]) then
				if arg_405_1.var_.characterEffect102201ui_story and not isNil(arg_405_1.actors_["102201ui_story"]) then
					arg_405_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_405_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["102201ui_story"]) and arg_405_1.var_.characterEffect102201ui_story then
				arg_405_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_405_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 1.425

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1102201101).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 57 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 57)

				if (57 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 57)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1102201102 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1102201102
		arg_409_1.duration_ = 8

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1102201103(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if arg_409_1.bgs_.ST27a == nil then
				local var_412_0 = Object.Instantiate(arg_409_1.paintGo_)

				var_412_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27a")
				var_412_0.name = "ST27a"
				var_412_0.transform.parent = arg_409_1.stage_.transform
				var_412_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.bgs_.ST27a = var_412_0
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				local var_412_1 = arg_409_1.bgs_.ST27a

				arg_409_1.bgs_.ST27a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_412_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_412_2 = var_412_1:GetComponent("SpriteRenderer")

				if var_412_2 and var_412_2.sprite then
					local var_412_3 = 2 * (var_412_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_412_1.transform.localScale = Vector3.New(var_412_3 / var_412_2.sprite.bounds.size.y < var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x and var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x or var_412_3 / var_412_2.sprite.bounds.size.y, var_412_3 / var_412_2.sprite.bounds.size.y < var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x and var_412_3 * manager.ui.mainCameraCom_.aspect / var_412_2.sprite.bounds.size.x or var_412_3 / var_412_2.sprite.bounds.size.y, 0)
				end

				for iter_412_0, iter_412_1 in pairs(arg_409_1.bgs_) do
					if iter_412_0 ~= "ST27a" then
						iter_412_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_412_4 = 3

			if 3 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.allBtn_.enabled = false
			end

			if arg_409_1.time_ >= var_412_4 + 0.3 and arg_409_1.time_ < var_412_4 + 0.3 + arg_412_0 then
				arg_409_1.allBtn_.enabled = true
			end

			local var_412_5 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_6 = 3

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_6 then
				local var_412_7 = Color.New(0, 0, 0)

				var_412_7.a = Mathf.Lerp(1, 0, (arg_409_1.time_ - var_412_5) / var_412_6)
				arg_409_1.mask_.color = var_412_7
			end

			if arg_409_1.time_ >= var_412_5 + var_412_6 and arg_409_1.time_ < var_412_5 + var_412_6 + arg_412_0 then
				local var_412_8 = Color.New(0, 0, 0)

				arg_409_1.mask_.enabled = false
				var_412_8.a = 0
				arg_409_1.mask_.color = var_412_8
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_9 = 3
			local var_412_10 = 0.325

			if 3 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_11 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_11:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

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

				local var_412_12 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1102201102).content)

				arg_409_1.text_.text = var_412_12

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_14 = 13 <= 0 and var_412_10 or var_412_10 * (utf8.len(var_412_12) / 13)

				if (13 <= 0 and var_412_10 or var_412_10 * (utf8.len(var_412_12) / 13)) > 0 and var_412_10 < var_412_14 then
					arg_409_1.talkMaxDuration = var_412_14
					var_412_9 = var_412_9 + 0.3

					if var_412_14 + var_412_9 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_14 + var_412_9
					end
				end

				arg_409_1.text_.text = var_412_12
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_15 = var_412_9 + 0.3
			local var_412_16 = math.max(var_412_10, arg_409_1.talkMaxDuration)

			if var_412_9 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_16 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_16

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_16 and arg_409_1.time_ < var_412_15 + var_412_16 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1102201103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1102201103
		arg_415_1.duration_ = 6.83

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1102201104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos102201ui_story = arg_415_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).z)
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles = arg_415_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_415_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["102201ui_story"].transform.position).z)
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["102201ui_story"].transform.localEulerAngles = arg_415_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["102201ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect102201ui_story == nil then
				arg_415_1.var_.characterEffect102201ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect102201ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect102201ui_story then
				arg_415_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_418_4 = 0
			local var_418_5 = 0.65

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(1102201103)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 26 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 26)

				if (26 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 26)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201103", "story_v_side_new_1102201.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201103", "story_v_side_new_1102201.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_side_new_1102201", "1102201103", "story_v_side_new_1102201.awb")

						arg_415_1:RecordAudio("1102201103", var_418_11)
						arg_415_1:RecordAudio("1102201103", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201103", "story_v_side_new_1102201.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201103", "story_v_side_new_1102201.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1102201104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1102201104
		arg_419_1.duration_ = 1

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"

			SetActive(arg_419_1.choicesGo_, true)

			for iter_420_0, iter_420_1 in ipairs(arg_419_1.choices_) do
				SetActive(iter_420_1.go, iter_420_0 <= 2)
			end

			arg_419_1.choices_[1].txt.text = arg_419_1:FormatText(StoryChoiceCfg[1123].name)
			arg_419_1.choices_[2].txt.text = arg_419_1:FormatText(StoryChoiceCfg[1124].name)
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1102201105(arg_419_1)
			end

			if arg_421_0 == 2 then
				arg_419_0:Play1102201107(arg_419_1)
			end

			arg_419_1:RecordChoiceLog(1102201104, 1123, 1124)
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["102201ui_story"]) and arg_419_1.var_.characterEffect102201ui_story == nil then
				arg_419_1.var_.characterEffect102201ui_story = arg_419_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["102201ui_story"]) then
				if arg_419_1.var_.characterEffect102201ui_story and not isNil(arg_419_1.actors_["102201ui_story"]) then
					arg_419_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_419_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_0)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["102201ui_story"]) and arg_419_1.var_.characterEffect102201ui_story then
				arg_419_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_419_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_422_1 = 0

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.allBtn_.enabled = false
			end

			if arg_419_1.time_ >= var_422_1 + 0.5 and arg_419_1.time_ < var_422_1 + 0.5 + arg_422_0 then
				arg_419_1.allBtn_.enabled = true
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1102201105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1102201105
		arg_423_1.duration_ = 5.27

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1102201106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["102201ui_story"]) and arg_423_1.var_.characterEffect102201ui_story == nil then
				arg_423_1.var_.characterEffect102201ui_story = arg_423_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["102201ui_story"]) then
				if arg_423_1.var_.characterEffect102201ui_story and not isNil(arg_423_1.actors_["102201ui_story"]) then
					arg_423_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["102201ui_story"]) and arg_423_1.var_.characterEffect102201ui_story then
				arg_423_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_2")
			end

			local var_426_2 = 0
			local var_426_3 = 0.5

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_4 = arg_423_1:GetWordFromCfg(1102201105)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 20 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 20)

				if (20 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 20)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201105", "story_v_side_new_1102201.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201105", "story_v_side_new_1102201.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_side_new_1102201", "1102201105", "story_v_side_new_1102201.awb")

						arg_423_1:RecordAudio("1102201105", var_426_9)
						arg_423_1:RecordAudio("1102201105", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201105", "story_v_side_new_1102201.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201105", "story_v_side_new_1102201.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_10 and arg_423_1.time_ < var_426_2 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1102201106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1102201106
		arg_427_1.duration_ = 6.07

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1102201109(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.625

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:GetWordFromCfg(1102201106)
				local var_430_2 = arg_427_1:FormatText(var_430_1.content)

				arg_427_1.text_.text = var_430_2

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 25 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 25)

				if (25 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_2) / 25)) > 0 and var_430_0 < var_430_4 then
					arg_427_1.talkMaxDuration = var_430_4

					if var_430_4 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_4 + 0
					end
				end

				arg_427_1.text_.text = var_430_2
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201106", "story_v_side_new_1102201.awb") ~= 0 then
					local var_430_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201106", "story_v_side_new_1102201.awb") / 1000

					if var_430_5 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_5 + 0
					end

					if var_430_1.prefab_name ~= "" and arg_427_1.actors_[var_430_1.prefab_name] ~= nil then
						local var_430_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_1.prefab_name].transform, "story_v_side_new_1102201", "1102201106", "story_v_side_new_1102201.awb")

						arg_427_1:RecordAudio("1102201106", var_430_6)
						arg_427_1:RecordAudio("1102201106", var_430_6)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201106", "story_v_side_new_1102201.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201106", "story_v_side_new_1102201.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_7 and arg_427_1.time_ < 0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1102201109 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1102201109
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1102201110(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["102201ui_story"]) and arg_431_1.var_.characterEffect102201ui_story == nil then
				arg_431_1.var_.characterEffect102201ui_story = arg_431_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["102201ui_story"]) then
				if arg_431_1.var_.characterEffect102201ui_story and not isNil(arg_431_1.actors_["102201ui_story"]) then
					arg_431_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_431_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["102201ui_story"]) and arg_431_1.var_.characterEffect102201ui_story then
				arg_431_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_431_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_431_1.time_ and arg_431_1.time_ <= 0.1 + arg_434_0 then
				arg_431_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_footstep", "")
			end

			local var_434_2 = 0
			local var_434_3 = 0.375

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_4 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1102201109).content)

				arg_431_1.text_.text = var_434_4

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_6 = 15 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_4) / 15)

				if (15 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_4) / 15)) > 0 and var_434_3 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_4
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_7 and arg_431_1.time_ < var_434_2 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1102201110 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1102201110
		arg_435_1.duration_ = 2.23

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1102201111(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["102201ui_story"]) and arg_435_1.var_.characterEffect102201ui_story == nil then
				arg_435_1.var_.characterEffect102201ui_story = arg_435_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["102201ui_story"]) then
				if arg_435_1.var_.characterEffect102201ui_story and not isNil(arg_435_1.actors_["102201ui_story"]) then
					arg_435_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["102201ui_story"]) and arg_435_1.var_.characterEffect102201ui_story then
				arg_435_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action6_1")
			end

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_438_2 = 0
			local var_438_3 = 0.2

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(1102201110)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 8 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 8)

				if (8 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 8)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201110", "story_v_side_new_1102201.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201110", "story_v_side_new_1102201.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_side_new_1102201", "1102201110", "story_v_side_new_1102201.awb")

						arg_435_1:RecordAudio("1102201110", var_438_9)
						arg_435_1:RecordAudio("1102201110", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201110", "story_v_side_new_1102201.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201110", "story_v_side_new_1102201.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1102201111 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1102201111
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1102201112(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos102201ui_story = arg_439_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).z)
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles = arg_439_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["102201ui_story"].transform.position).z)
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["102201ui_story"].transform.localEulerAngles = arg_439_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["102201ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect102201ui_story == nil then
				arg_439_1.var_.characterEffect102201ui_story = var_442_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 and not isNil(var_442_1) then
				if arg_439_1.var_.characterEffect102201ui_story and not isNil(var_442_1) then
					arg_439_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_439_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_2)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 and not isNil(var_442_1) and arg_439_1.var_.characterEffect102201ui_story then
				arg_439_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_439_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_442_3 = 0
			local var_442_4 = 1.225

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_5 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(1102201111).content)

				arg_439_1.text_.text = var_442_5

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_7 = 49 <= 0 and var_442_4 or var_442_4 * (utf8.len(var_442_5) / 49)

				if (49 <= 0 and var_442_4 or var_442_4 * (utf8.len(var_442_5) / 49)) > 0 and var_442_4 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_3 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_3
					end
				end

				arg_439_1.text_.text = var_442_5
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_8 = math.max(var_442_4, arg_439_1.talkMaxDuration)

			if var_442_3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_3 + var_442_8 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_3) / var_442_8

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_3 + var_442_8 and arg_439_1.time_ < var_442_3 + var_442_8 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play1102201112 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1102201112
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1102201113(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 1.65

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(1102201112).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 66 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 66)

				if (66 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 66)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1102201113 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1102201113
		arg_447_1.duration_ = 3.47

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1102201114(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.275

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_1 = arg_447_1:GetWordFromCfg(1102201113)
				local var_450_2 = arg_447_1:FormatText(var_450_1.content)

				arg_447_1.text_.text = var_450_2

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_4 = 11 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 11)

				if (11 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_2) / 11)) > 0 and var_450_0 < var_450_4 then
					arg_447_1.talkMaxDuration = var_450_4

					if var_450_4 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_4 + 0
					end
				end

				arg_447_1.text_.text = var_450_2
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201113", "story_v_side_new_1102201.awb") ~= 0 then
					local var_450_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201113", "story_v_side_new_1102201.awb") / 1000

					if var_450_5 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + 0
					end

					if var_450_1.prefab_name ~= "" and arg_447_1.actors_[var_450_1.prefab_name] ~= nil then
						local var_450_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_1.prefab_name].transform, "story_v_side_new_1102201", "1102201113", "story_v_side_new_1102201.awb")

						arg_447_1:RecordAudio("1102201113", var_450_6)
						arg_447_1:RecordAudio("1102201113", var_450_6)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201113", "story_v_side_new_1102201.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201113", "story_v_side_new_1102201.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_7 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_7 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_7

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_7 and arg_447_1.time_ < 0 + var_450_7 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1102201114 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 1102201114
		arg_451_1.duration_ = 6.97

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play1102201115(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0.3 < arg_451_1.time_ and arg_451_1.time_ <= 0.3 + arg_454_0 then
				arg_451_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_footstep", "")
			end

			local var_454_1 = 0
			local var_454_2 = 0.725

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[1139].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_3 = arg_451_1:GetWordFromCfg(1102201114)
				local var_454_4 = arg_451_1:FormatText(var_454_3.content)

				arg_451_1.text_.text = var_454_4

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_6 = 29 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_4) / 29)

				if (29 <= 0 and var_454_2 or var_454_2 * (utf8.len(var_454_4) / 29)) > 0 and var_454_2 < var_454_6 then
					arg_451_1.talkMaxDuration = var_454_6

					if var_454_6 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_6 + var_454_1
					end
				end

				arg_451_1.text_.text = var_454_4
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201114", "story_v_side_new_1102201.awb") ~= 0 then
					local var_454_7 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201114", "story_v_side_new_1102201.awb") / 1000

					if var_454_7 + var_454_1 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_1
					end

					if var_454_3.prefab_name ~= "" and arg_451_1.actors_[var_454_3.prefab_name] ~= nil then
						local var_454_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_3.prefab_name].transform, "story_v_side_new_1102201", "1102201114", "story_v_side_new_1102201.awb")

						arg_451_1:RecordAudio("1102201114", var_454_8)
						arg_451_1:RecordAudio("1102201114", var_454_8)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201114", "story_v_side_new_1102201.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201114", "story_v_side_new_1102201.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_9 = math.max(var_454_2, arg_451_1.talkMaxDuration)

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_9 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_1) / var_454_9

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_1 + var_454_9 and arg_451_1.time_ < var_454_1 + var_454_9 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play1102201115 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 1102201115
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play1102201116(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 2.05

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(1102201115).content)

				arg_455_1.text_.text = var_458_1

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_3 = 82 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 82)

				if (82 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 82)) > 0 and var_458_0 < var_458_3 then
					arg_455_1.talkMaxDuration = var_458_3

					if var_458_3 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_3 + 0
					end
				end

				arg_455_1.text_.text = var_458_1
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_4 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_4

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play1102201116 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 1102201116
		arg_459_1.duration_ = 3.9

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play1102201117(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos102201ui_story = arg_459_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).z)
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles = arg_459_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_459_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["102201ui_story"].transform.position).z)
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["102201ui_story"].transform.localEulerAngles = arg_459_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_462_1 = arg_459_1.actors_["102201ui_story"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect102201ui_story == nil then
				arg_459_1.var_.characterEffect102201ui_story = var_462_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_2 and not isNil(var_462_1) then
				if arg_459_1.var_.characterEffect102201ui_story and not isNil(var_462_1) then
					arg_459_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_2 and arg_459_1.time_ < 0 + var_462_2 + arg_462_0 and not isNil(var_462_1) and arg_459_1.var_.characterEffect102201ui_story then
				arg_459_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_462_4 = 0
			local var_462_5 = 0.375

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_6 = arg_459_1:GetWordFromCfg(1102201116)
				local var_462_7 = arg_459_1:FormatText(var_462_6.content)

				arg_459_1.text_.text = var_462_7

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_9 = 15 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 15)

				if (15 <= 0 and var_462_5 or var_462_5 * (utf8.len(var_462_7) / 15)) > 0 and var_462_5 < var_462_9 then
					arg_459_1.talkMaxDuration = var_462_9

					if var_462_9 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_9 + var_462_4
					end
				end

				arg_459_1.text_.text = var_462_7
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201116", "story_v_side_new_1102201.awb") ~= 0 then
					local var_462_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201116", "story_v_side_new_1102201.awb") / 1000

					if var_462_10 + var_462_4 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_4
					end

					if var_462_6.prefab_name ~= "" and arg_459_1.actors_[var_462_6.prefab_name] ~= nil then
						local var_462_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_6.prefab_name].transform, "story_v_side_new_1102201", "1102201116", "story_v_side_new_1102201.awb")

						arg_459_1:RecordAudio("1102201116", var_462_11)
						arg_459_1:RecordAudio("1102201116", var_462_11)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201116", "story_v_side_new_1102201.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201116", "story_v_side_new_1102201.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_12 = math.max(var_462_5, arg_459_1.talkMaxDuration)

			if var_462_4 <= arg_459_1.time_ and arg_459_1.time_ < var_462_4 + var_462_12 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_4) / var_462_12

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_4 + var_462_12 and arg_459_1.time_ < var_462_4 + var_462_12 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play1102201117 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1102201117
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1102201118(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["102201ui_story"]) and arg_463_1.var_.characterEffect102201ui_story == nil then
				arg_463_1.var_.characterEffect102201ui_story = arg_463_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["102201ui_story"]) then
				if arg_463_1.var_.characterEffect102201ui_story and not isNil(arg_463_1.actors_["102201ui_story"]) then
					arg_463_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_463_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_463_1.time_ - 0) / var_466_0)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["102201ui_story"]) and arg_463_1.var_.characterEffect102201ui_story then
				arg_463_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_463_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_466_1 = 0
			local var_466_2 = 0.575

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(1102201117).content)

				arg_463_1.text_.text = var_466_3

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 23 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_3) / 23)

				if (23 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_3) / 23)) > 0 and var_466_2 < var_466_5 then
					arg_463_1.talkMaxDuration = var_466_5

					if var_466_5 + var_466_1 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_5 + var_466_1
					end
				end

				arg_463_1.text_.text = var_466_3
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_6 = math.max(var_466_2, arg_463_1.talkMaxDuration)

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_6 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_1) / var_466_6

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_1 + var_466_6 and arg_463_1.time_ < var_466_1 + var_466_6 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1102201118 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1102201118
		arg_467_1.duration_ = 3.53

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1102201119(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["102201ui_story"]) and arg_467_1.var_.characterEffect102201ui_story == nil then
				arg_467_1.var_.characterEffect102201ui_story = arg_467_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["102201ui_story"]) then
				if arg_467_1.var_.characterEffect102201ui_story and not isNil(arg_467_1.actors_["102201ui_story"]) then
					arg_467_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["102201ui_story"]) and arg_467_1.var_.characterEffect102201ui_story then
				arg_467_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_470_2 = 0
			local var_470_3 = 0.3

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_4 = arg_467_1:GetWordFromCfg(1102201118)
				local var_470_5 = arg_467_1:FormatText(var_470_4.content)

				arg_467_1.text_.text = var_470_5

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_7 = 12 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 12)

				if (12 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 12)) > 0 and var_470_3 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_2
					end
				end

				arg_467_1.text_.text = var_470_5
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201118", "story_v_side_new_1102201.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201118", "story_v_side_new_1102201.awb") / 1000

					if var_470_8 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_2
					end

					if var_470_4.prefab_name ~= "" and arg_467_1.actors_[var_470_4.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_4.prefab_name].transform, "story_v_side_new_1102201", "1102201118", "story_v_side_new_1102201.awb")

						arg_467_1:RecordAudio("1102201118", var_470_9)
						arg_467_1:RecordAudio("1102201118", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201118", "story_v_side_new_1102201.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201118", "story_v_side_new_1102201.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_3, arg_467_1.talkMaxDuration)

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_2) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_2 + var_470_10 and arg_467_1.time_ < var_470_2 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1102201119 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1102201119
		arg_471_1.duration_ = 9

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1102201120(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if arg_471_1.bgs_.ST22a == nil then
				local var_474_0 = Object.Instantiate(arg_471_1.paintGo_)

				var_474_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_474_0.name = "ST22a"
				var_474_0.transform.parent = arg_471_1.stage_.transform
				var_474_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_471_1.bgs_.ST22a = var_474_0
			end

			if 2 < arg_471_1.time_ and arg_471_1.time_ <= 2 + arg_474_0 then
				local var_474_1 = arg_471_1.bgs_.ST22a

				arg_471_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_474_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_474_2 = var_474_1:GetComponent("SpriteRenderer")

				if var_474_2 and var_474_2.sprite then
					local var_474_3 = 2 * (var_474_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_474_1.transform.localScale = Vector3.New(var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, var_474_3 / var_474_2.sprite.bounds.size.y < var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x and var_474_3 * manager.ui.mainCameraCom_.aspect / var_474_2.sprite.bounds.size.x or var_474_3 / var_474_2.sprite.bounds.size.y, 0)
				end

				for iter_474_0, iter_474_1 in pairs(arg_471_1.bgs_) do
					if iter_474_0 ~= "ST22a" then
						iter_474_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_474_4 = 4

			if 4 < arg_471_1.time_ and arg_471_1.time_ <= var_474_4 + arg_474_0 then
				arg_471_1.allBtn_.enabled = false
			end

			if arg_471_1.time_ >= var_474_4 + 0.3 and arg_471_1.time_ < var_474_4 + 0.3 + arg_474_0 then
				arg_471_1.allBtn_.enabled = true
			end

			local var_474_5 = 0

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_6 = 2

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_6 then
				local var_474_7 = Color.New(0, 0, 0)

				var_474_7.a = Mathf.Lerp(0, 1, (arg_471_1.time_ - var_474_5) / var_474_6)
				arg_471_1.mask_.color = var_474_7
			end

			if arg_471_1.time_ >= var_474_5 + var_474_6 and arg_471_1.time_ < var_474_5 + var_474_6 + arg_474_0 then
				local var_474_8 = Color.New(0, 0, 0)

				var_474_8.a = 1
				arg_471_1.mask_.color = var_474_8
			end

			local var_474_9 = 2

			if 2 < arg_471_1.time_ and arg_471_1.time_ <= var_474_9 + arg_474_0 then
				arg_471_1.mask_.enabled = true
				arg_471_1.mask_.raycastTarget = true

				arg_471_1:SetGaussion(false)
			end

			local var_474_10 = 2

			if var_474_9 <= arg_471_1.time_ and arg_471_1.time_ < var_474_9 + var_474_10 then
				local var_474_11 = Color.New(0, 0, 0)

				var_474_11.a = Mathf.Lerp(1, 0, (arg_471_1.time_ - var_474_9) / var_474_10)
				arg_471_1.mask_.color = var_474_11
			end

			if arg_471_1.time_ >= var_474_9 + var_474_10 and arg_471_1.time_ < var_474_9 + var_474_10 + arg_474_0 then
				local var_474_12 = Color.New(0, 0, 0)

				arg_471_1.mask_.enabled = false
				var_474_12.a = 0
				arg_471_1.mask_.color = var_474_12
			end

			local var_474_13 = arg_471_1.actors_["102201ui_story"].transform

			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 then
				arg_471_1.var_.moveOldPos102201ui_story = var_474_13.localPosition
			end

			local var_474_14 = 0.001

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_14 then
				var_474_13.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_471_1.time_ - 1.96599999815226) / var_474_14)
				var_474_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_13.position).x, (manager.ui.mainCamera.transform.position - var_474_13.position).y, (manager.ui.mainCamera.transform.position - var_474_13.position).z)
				var_474_13.localEulerAngles.z = 0
				var_474_13.localEulerAngles.x = 0
				var_474_13.localEulerAngles = var_474_13.localEulerAngles
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_14 and arg_471_1.time_ < 1.96599999815226 + var_474_14 + arg_474_0 then
				var_474_13.localPosition = Vector3.New(0, 100, 0)
				var_474_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_474_13.position).x, (manager.ui.mainCamera.transform.position - var_474_13.position).y, (manager.ui.mainCamera.transform.position - var_474_13.position).z)
				var_474_13.localEulerAngles.z = 0
				var_474_13.localEulerAngles.x = 0
				var_474_13.localEulerAngles = var_474_13.localEulerAngles
			end

			local var_474_15 = arg_471_1.actors_["102201ui_story"]

			if 1.96599999815226 < arg_471_1.time_ and arg_471_1.time_ <= 1.96599999815226 + arg_474_0 and not isNil(var_474_15) and arg_471_1.var_.characterEffect102201ui_story == nil then
				arg_471_1.var_.characterEffect102201ui_story = var_474_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_16 = 0.034000001847744

			if 1.96599999815226 <= arg_471_1.time_ and arg_471_1.time_ < 1.96599999815226 + var_474_16 and not isNil(var_474_15) then
				if arg_471_1.var_.characterEffect102201ui_story and not isNil(var_474_15) then
					arg_471_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_471_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 1.96599999815226) / var_474_16)
				end
			end

			if arg_471_1.time_ >= 1.96599999815226 + var_474_16 and arg_471_1.time_ < 1.96599999815226 + var_474_16 + arg_474_0 and not isNil(var_474_15) and arg_471_1.var_.characterEffect102201ui_story then
				arg_471_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_471_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_474_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_19 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_19

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_19
						arg_471_1.bgmTxt2_.text = var_474_19
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_471_1.time_ and arg_471_1.time_ <= 1 + arg_474_0 then
				arg_471_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_474_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_22 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_22

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_22
						arg_471_1.bgmTxt2_.text = var_474_22
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_471_1.frameCnt_ <= 1 then
				arg_471_1.dialog_:SetActive(false)
			end

			local var_474_23 = 4
			local var_474_24 = 1.625

			if 4 < arg_471_1.time_ and arg_471_1.time_ <= var_474_23 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0

				arg_471_1.dialog_:SetActive(true)

				arg_471_1.dialogCg_.alpha = 0

				local var_474_25 = LeanTween.value(arg_471_1.dialog_, 0, 1, 0.3)

				var_474_25:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_471_1.dialogCg_.alpha = arg_477_0
				end))
				var_474_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_471_1.dialog_)
					var_474_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_471_1.duration_ = arg_471_1.duration_ + 0.3

				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_26 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(1102201119).content)

				arg_471_1.text_.text = var_474_26

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_28 = 65 <= 0 and var_474_24 or var_474_24 * (utf8.len(var_474_26) / 65)

				if (65 <= 0 and var_474_24 or var_474_24 * (utf8.len(var_474_26) / 65)) > 0 and var_474_24 < var_474_28 then
					arg_471_1.talkMaxDuration = var_474_28
					var_474_23 = var_474_23 + 0.3

					if var_474_28 + var_474_23 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_28 + var_474_23
					end
				end

				arg_471_1.text_.text = var_474_26
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_29 = var_474_23 + 0.3
			local var_474_30 = math.max(var_474_24, arg_471_1.talkMaxDuration)

			if var_474_23 + 0.3 <= arg_471_1.time_ and arg_471_1.time_ < var_474_29 + var_474_30 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_29) / var_474_30

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_29 + var_474_30 and arg_471_1.time_ < var_474_29 + var_474_30 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
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
	Play1102201120 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 1102201120
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play1102201121(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0.525

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_479_1.callingController_:SetSelectedState("normal")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_1 = arg_479_1:FormatText(arg_479_1:GetWordFromCfg(1102201120).content)

				arg_479_1.text_.text = var_482_1

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_3 = 21 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 21)

				if (21 <= 0 and var_482_0 or var_482_0 * (utf8.len(var_482_1) / 21)) > 0 and var_482_0 < var_482_3 then
					arg_479_1.talkMaxDuration = var_482_3

					if var_482_3 + 0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_3 + 0
					end
				end

				arg_479_1.text_.text = var_482_1
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_4 = math.max(var_482_0, arg_479_1.talkMaxDuration)

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_4 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - 0) / var_482_4

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= 0 + var_482_4 and arg_479_1.time_ < 0 + var_482_4 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play1102201121 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1102201121
		arg_483_1.duration_ = 6.23

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1102201122(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos102201ui_story = arg_483_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).z)
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles = arg_483_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_483_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["102201ui_story"].transform.position).z)
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["102201ui_story"].transform.localEulerAngles = arg_483_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_486_1 = arg_483_1.actors_["102201ui_story"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect102201ui_story == nil then
				arg_483_1.var_.characterEffect102201ui_story = var_486_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_2 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_2 and not isNil(var_486_1) then
				if arg_483_1.var_.characterEffect102201ui_story and not isNil(var_486_1) then
					arg_483_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_483_1.time_ >= 0 + var_486_2 and arg_483_1.time_ < 0 + var_486_2 + arg_486_0 and not isNil(var_486_1) and arg_483_1.var_.characterEffect102201ui_story then
				arg_483_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_486_4 = 0
			local var_486_5 = 0.5

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_4 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_6 = arg_483_1:GetWordFromCfg(1102201121)
				local var_486_7 = arg_483_1:FormatText(var_486_6.content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 20 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 20)

				if (20 <= 0 and var_486_5 or var_486_5 * (utf8.len(var_486_7) / 20)) > 0 and var_486_5 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_4
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201121", "story_v_side_new_1102201.awb") ~= 0 then
					local var_486_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201121", "story_v_side_new_1102201.awb") / 1000

					if var_486_10 + var_486_4 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_4
					end

					if var_486_6.prefab_name ~= "" and arg_483_1.actors_[var_486_6.prefab_name] ~= nil then
						local var_486_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_6.prefab_name].transform, "story_v_side_new_1102201", "1102201121", "story_v_side_new_1102201.awb")

						arg_483_1:RecordAudio("1102201121", var_486_11)
						arg_483_1:RecordAudio("1102201121", var_486_11)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201121", "story_v_side_new_1102201.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201121", "story_v_side_new_1102201.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_12 = math.max(var_486_5, arg_483_1.talkMaxDuration)

			if var_486_4 <= arg_483_1.time_ and arg_483_1.time_ < var_486_4 + var_486_12 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_4) / var_486_12

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_4 + var_486_12 and arg_483_1.time_ < var_486_4 + var_486_12 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play1102201122 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1102201122
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1102201123(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["102201ui_story"]) and arg_487_1.var_.characterEffect102201ui_story == nil then
				arg_487_1.var_.characterEffect102201ui_story = arg_487_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["102201ui_story"]) then
				if arg_487_1.var_.characterEffect102201ui_story and not isNil(arg_487_1.actors_["102201ui_story"]) then
					arg_487_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_487_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_0)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["102201ui_story"]) and arg_487_1.var_.characterEffect102201ui_story then
				arg_487_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_487_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_490_1 = 0
			local var_490_2 = 0.275

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(1102201122).content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 11 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 11)

				if (11 <= 0 and var_490_2 or var_490_2 * (utf8.len(var_490_3) / 11)) > 0 and var_490_2 < var_490_5 then
					arg_487_1.talkMaxDuration = var_490_5

					if var_490_5 + var_490_1 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + var_490_1
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_6 = math.max(var_490_2, arg_487_1.talkMaxDuration)

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_6 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_1) / var_490_6

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_1 + var_490_6 and arg_487_1.time_ < var_490_1 + var_490_6 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1102201123 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1102201123
		arg_491_1.duration_ = 4.7

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1102201124(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["102201ui_story"]) and arg_491_1.var_.characterEffect102201ui_story == nil then
				arg_491_1.var_.characterEffect102201ui_story = arg_491_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["102201ui_story"]) then
				if arg_491_1.var_.characterEffect102201ui_story and not isNil(arg_491_1.actors_["102201ui_story"]) then
					arg_491_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["102201ui_story"]) and arg_491_1.var_.characterEffect102201ui_story then
				arg_491_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_494_2 = 0
			local var_494_3 = 0.4

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_2 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_4 = arg_491_1:GetWordFromCfg(1102201123)
				local var_494_5 = arg_491_1:FormatText(var_494_4.content)

				arg_491_1.text_.text = var_494_5

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_7 = 16 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 16)

				if (16 <= 0 and var_494_3 or var_494_3 * (utf8.len(var_494_5) / 16)) > 0 and var_494_3 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_2
					end
				end

				arg_491_1.text_.text = var_494_5
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201123", "story_v_side_new_1102201.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201123", "story_v_side_new_1102201.awb") / 1000

					if var_494_8 + var_494_2 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_2
					end

					if var_494_4.prefab_name ~= "" and arg_491_1.actors_[var_494_4.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_4.prefab_name].transform, "story_v_side_new_1102201", "1102201123", "story_v_side_new_1102201.awb")

						arg_491_1:RecordAudio("1102201123", var_494_9)
						arg_491_1:RecordAudio("1102201123", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201123", "story_v_side_new_1102201.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201123", "story_v_side_new_1102201.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_3, arg_491_1.talkMaxDuration)

			if var_494_2 <= arg_491_1.time_ and arg_491_1.time_ < var_494_2 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_2) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_2 + var_494_10 and arg_491_1.time_ < var_494_2 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1102201124 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1102201124
		arg_495_1.duration_ = 1

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"

			SetActive(arg_495_1.choicesGo_, true)

			for iter_496_0, iter_496_1 in ipairs(arg_495_1.choices_) do
				SetActive(iter_496_1.go, iter_496_0 <= 2)
			end

			arg_495_1.choices_[1].txt.text = arg_495_1:FormatText(StoryChoiceCfg[1125].name)
			arg_495_1.choices_[2].txt.text = arg_495_1:FormatText(StoryChoiceCfg[1126].name)
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1102201125(arg_495_1)
			end

			if arg_497_0 == 2 then
				arg_495_0:Play1102201126(arg_495_1)
			end

			arg_495_1:RecordChoiceLog(1102201124, 1125, 1126)
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["102201ui_story"]) and arg_495_1.var_.characterEffect102201ui_story == nil then
				arg_495_1.var_.characterEffect102201ui_story = arg_495_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["102201ui_story"]) then
				if arg_495_1.var_.characterEffect102201ui_story and not isNil(arg_495_1.actors_["102201ui_story"]) then
					arg_495_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_495_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_0)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["102201ui_story"]) and arg_495_1.var_.characterEffect102201ui_story then
				arg_495_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_495_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_498_1 = 0

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			if arg_495_1.time_ >= var_498_1 + 0.5 and arg_495_1.time_ < var_498_1 + 0.5 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1102201125 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1102201125
		arg_499_1.duration_ = 4.17

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1102201127(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["102201ui_story"]) and arg_499_1.var_.characterEffect102201ui_story == nil then
				arg_499_1.var_.characterEffect102201ui_story = arg_499_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["102201ui_story"]) then
				if arg_499_1.var_.characterEffect102201ui_story and not isNil(arg_499_1.actors_["102201ui_story"]) then
					arg_499_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["102201ui_story"]) and arg_499_1.var_.characterEffect102201ui_story then
				arg_499_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_502_2 = 0
			local var_502_3 = 0.425

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_2 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_4 = arg_499_1:GetWordFromCfg(1102201125)
				local var_502_5 = arg_499_1:FormatText(var_502_4.content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 17 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 17)

				if (17 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 17)) > 0 and var_502_3 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_2
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201125", "story_v_side_new_1102201.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201125", "story_v_side_new_1102201.awb") / 1000

					if var_502_8 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_2
					end

					if var_502_4.prefab_name ~= "" and arg_499_1.actors_[var_502_4.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_4.prefab_name].transform, "story_v_side_new_1102201", "1102201125", "story_v_side_new_1102201.awb")

						arg_499_1:RecordAudio("1102201125", var_502_9)
						arg_499_1:RecordAudio("1102201125", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201125", "story_v_side_new_1102201.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201125", "story_v_side_new_1102201.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_3, arg_499_1.talkMaxDuration)

			if var_502_2 <= arg_499_1.time_ and arg_499_1.time_ < var_502_2 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_2) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_2 + var_502_10 and arg_499_1.time_ < var_502_2 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1102201127 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1102201127
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1102201128(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos102201ui_story = arg_503_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_506_0 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 then
				arg_503_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_503_1.time_ - 0) / var_506_0)
				arg_503_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).z)
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles = arg_503_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 then
				arg_503_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_503_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_503_1.actors_["102201ui_story"].transform.position).z)
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_503_1.actors_["102201ui_story"].transform.localEulerAngles = arg_503_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_506_1 = arg_503_1.actors_["102201ui_story"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect102201ui_story == nil then
				arg_503_1.var_.characterEffect102201ui_story = var_506_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_2 and not isNil(var_506_1) then
				if arg_503_1.var_.characterEffect102201ui_story and not isNil(var_506_1) then
					arg_503_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_503_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_2)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_2 and arg_503_1.time_ < 0 + var_506_2 + arg_506_0 and not isNil(var_506_1) and arg_503_1.var_.characterEffect102201ui_story then
				arg_503_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_503_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_506_3 = 0
			local var_506_4 = 1.275

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_3 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_5 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(1102201127).content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 51 <= 0 and var_506_4 or var_506_4 * (utf8.len(var_506_5) / 51)

				if (51 <= 0 and var_506_4 or var_506_4 * (utf8.len(var_506_5) / 51)) > 0 and var_506_4 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_3 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_3
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_4, arg_503_1.talkMaxDuration)

			if var_506_3 <= arg_503_1.time_ and arg_503_1.time_ < var_506_3 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_3) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_3 + var_506_8 and arg_503_1.time_ < var_506_3 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play1102201128 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1102201128
		arg_507_1.duration_ = 2.9

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1102201129(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos102201ui_story = arg_507_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).z)
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles = arg_507_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_507_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["102201ui_story"].transform.position).z)
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["102201ui_story"].transform.localEulerAngles = arg_507_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_510_1 = arg_507_1.actors_["102201ui_story"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect102201ui_story == nil then
				arg_507_1.var_.characterEffect102201ui_story = var_510_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_2 and not isNil(var_510_1) then
				if arg_507_1.var_.characterEffect102201ui_story and not isNil(var_510_1) then
					arg_507_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= 0 + var_510_2 and arg_507_1.time_ < 0 + var_510_2 + arg_510_0 and not isNil(var_510_1) and arg_507_1.var_.characterEffect102201ui_story then
				arg_507_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_510_4 = 0
			local var_510_5 = 0.375

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_4 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_6 = arg_507_1:GetWordFromCfg(1102201128)
				local var_510_7 = arg_507_1:FormatText(var_510_6.content)

				arg_507_1.text_.text = var_510_7

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_9 = 15 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 15)

				if (15 <= 0 and var_510_5 or var_510_5 * (utf8.len(var_510_7) / 15)) > 0 and var_510_5 < var_510_9 then
					arg_507_1.talkMaxDuration = var_510_9

					if var_510_9 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_9 + var_510_4
					end
				end

				arg_507_1.text_.text = var_510_7
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201128", "story_v_side_new_1102201.awb") ~= 0 then
					local var_510_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201128", "story_v_side_new_1102201.awb") / 1000

					if var_510_10 + var_510_4 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_4
					end

					if var_510_6.prefab_name ~= "" and arg_507_1.actors_[var_510_6.prefab_name] ~= nil then
						local var_510_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_6.prefab_name].transform, "story_v_side_new_1102201", "1102201128", "story_v_side_new_1102201.awb")

						arg_507_1:RecordAudio("1102201128", var_510_11)
						arg_507_1:RecordAudio("1102201128", var_510_11)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201128", "story_v_side_new_1102201.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201128", "story_v_side_new_1102201.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_12 = math.max(var_510_5, arg_507_1.talkMaxDuration)

			if var_510_4 <= arg_507_1.time_ and arg_507_1.time_ < var_510_4 + var_510_12 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_4) / var_510_12

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_4 + var_510_12 and arg_507_1.time_ < var_510_4 + var_510_12 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play1102201129 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1102201129
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1102201130(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["102201ui_story"]) and arg_511_1.var_.characterEffect102201ui_story == nil then
				arg_511_1.var_.characterEffect102201ui_story = arg_511_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["102201ui_story"]) then
				if arg_511_1.var_.characterEffect102201ui_story and not isNil(arg_511_1.actors_["102201ui_story"]) then
					arg_511_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_511_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_511_1.time_ - 0) / var_514_0)
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["102201ui_story"]) and arg_511_1.var_.characterEffect102201ui_story then
				arg_511_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_511_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_514_1 = 0
			local var_514_2 = 0.375

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_3 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1102201129).content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)

				if (15 <= 0 and var_514_2 or var_514_2 * (utf8.len(var_514_3) / 15)) > 0 and var_514_2 < var_514_5 then
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

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1102201130 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1102201130
		arg_515_1.duration_ = 6.23

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1102201131(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["102201ui_story"]) and arg_515_1.var_.characterEffect102201ui_story == nil then
				arg_515_1.var_.characterEffect102201ui_story = arg_515_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["102201ui_story"]) then
				if arg_515_1.var_.characterEffect102201ui_story and not isNil(arg_515_1.actors_["102201ui_story"]) then
					arg_515_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["102201ui_story"]) and arg_515_1.var_.characterEffect102201ui_story then
				arg_515_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action5_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_518_2 = 0
			local var_518_3 = 0.675

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_2 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_4 = arg_515_1:GetWordFromCfg(1102201130)
				local var_518_5 = arg_515_1:FormatText(var_518_4.content)

				arg_515_1.text_.text = var_518_5

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_7 = 27 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 27)

				if (27 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 27)) > 0 and var_518_3 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_2
					end
				end

				arg_515_1.text_.text = var_518_5
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201130", "story_v_side_new_1102201.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201130", "story_v_side_new_1102201.awb") / 1000

					if var_518_8 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_2
					end

					if var_518_4.prefab_name ~= "" and arg_515_1.actors_[var_518_4.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_4.prefab_name].transform, "story_v_side_new_1102201", "1102201130", "story_v_side_new_1102201.awb")

						arg_515_1:RecordAudio("1102201130", var_518_9)
						arg_515_1:RecordAudio("1102201130", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201130", "story_v_side_new_1102201.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201130", "story_v_side_new_1102201.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_3, arg_515_1.talkMaxDuration)

			if var_518_2 <= arg_515_1.time_ and arg_515_1.time_ < var_518_2 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_2) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_2 + var_518_10 and arg_515_1.time_ < var_518_2 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1102201131 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1102201131
		arg_519_1.duration_ = 9.5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1102201132(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_522_0 = 0
			local var_522_1 = 0.975

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_2 = arg_519_1:GetWordFromCfg(1102201131)
				local var_522_3 = arg_519_1:FormatText(var_522_2.content)

				arg_519_1.text_.text = var_522_3

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 39 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 39)

				if (39 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 39)) > 0 and var_522_1 < var_522_5 then
					arg_519_1.talkMaxDuration = var_522_5

					if var_522_5 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_3
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201131", "story_v_side_new_1102201.awb") ~= 0 then
					local var_522_6 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201131", "story_v_side_new_1102201.awb") / 1000

					if var_522_6 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_0
					end

					if var_522_2.prefab_name ~= "" and arg_519_1.actors_[var_522_2.prefab_name] ~= nil then
						local var_522_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_2.prefab_name].transform, "story_v_side_new_1102201", "1102201131", "story_v_side_new_1102201.awb")

						arg_519_1:RecordAudio("1102201131", var_522_7)
						arg_519_1:RecordAudio("1102201131", var_522_7)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201131", "story_v_side_new_1102201.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201131", "story_v_side_new_1102201.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1102201132 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1102201132
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1102201133(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["102201ui_story"]) and arg_523_1.var_.characterEffect102201ui_story == nil then
				arg_523_1.var_.characterEffect102201ui_story = arg_523_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["102201ui_story"]) then
				if arg_523_1.var_.characterEffect102201ui_story and not isNil(arg_523_1.actors_["102201ui_story"]) then
					arg_523_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_523_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["102201ui_story"]) and arg_523_1.var_.characterEffect102201ui_story then
				arg_523_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_523_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.3

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

				local var_526_3 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1102201132).content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 12 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 12)

				if (12 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_3) / 12)) > 0 and var_526_2 < var_526_5 then
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
	Play1102201133 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1102201133
		arg_527_1.duration_ = 5.57

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1102201134(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["102201ui_story"]) and arg_527_1.var_.characterEffect102201ui_story == nil then
				arg_527_1.var_.characterEffect102201ui_story = arg_527_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_0 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["102201ui_story"]) then
				if arg_527_1.var_.characterEffect102201ui_story and not isNil(arg_527_1.actors_["102201ui_story"]) then
					arg_527_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["102201ui_story"]) and arg_527_1.var_.characterEffect102201ui_story then
				arg_527_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action453")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_530_2 = 0
			local var_530_3 = 0.5

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_2 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_4 = arg_527_1:GetWordFromCfg(1102201133)
				local var_530_5 = arg_527_1:FormatText(var_530_4.content)

				arg_527_1.text_.text = var_530_5

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_7 = 20 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 20)

				if (20 <= 0 and var_530_3 or var_530_3 * (utf8.len(var_530_5) / 20)) > 0 and var_530_3 < var_530_7 then
					arg_527_1.talkMaxDuration = var_530_7

					if var_530_7 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_7 + var_530_2
					end
				end

				arg_527_1.text_.text = var_530_5
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201133", "story_v_side_new_1102201.awb") ~= 0 then
					local var_530_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201133", "story_v_side_new_1102201.awb") / 1000

					if var_530_8 + var_530_2 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_8 + var_530_2
					end

					if var_530_4.prefab_name ~= "" and arg_527_1.actors_[var_530_4.prefab_name] ~= nil then
						local var_530_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_4.prefab_name].transform, "story_v_side_new_1102201", "1102201133", "story_v_side_new_1102201.awb")

						arg_527_1:RecordAudio("1102201133", var_530_9)
						arg_527_1:RecordAudio("1102201133", var_530_9)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201133", "story_v_side_new_1102201.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201133", "story_v_side_new_1102201.awb")
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
	Play1102201134 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1102201134
		arg_531_1.duration_ = 7.67

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1102201135(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.725

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:GetWordFromCfg(1102201134)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 29 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 29)

				if (29 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 29)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201134", "story_v_side_new_1102201.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201134", "story_v_side_new_1102201.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_side_new_1102201", "1102201134", "story_v_side_new_1102201.awb")

						arg_531_1:RecordAudio("1102201134", var_534_6)
						arg_531_1:RecordAudio("1102201134", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201134", "story_v_side_new_1102201.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201134", "story_v_side_new_1102201.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1102201135 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1102201135
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1102201136(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["102201ui_story"]) and arg_535_1.var_.characterEffect102201ui_story == nil then
				arg_535_1.var_.characterEffect102201ui_story = arg_535_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["102201ui_story"]) then
				if arg_535_1.var_.characterEffect102201ui_story and not isNil(arg_535_1.actors_["102201ui_story"]) then
					arg_535_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_535_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["102201ui_story"]) and arg_535_1.var_.characterEffect102201ui_story then
				arg_535_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_535_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 0.575

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1102201135).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 23 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 23)

				if (23 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 23)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1102201136 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1102201136
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1102201137(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos102201ui_story = arg_539_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_542_0 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 then
				arg_539_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0) / var_542_0)
				arg_539_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).z)
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles = arg_539_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 then
				arg_539_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_539_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["102201ui_story"].transform.position).z)
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["102201ui_story"].transform.localEulerAngles = arg_539_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if 0.5 < arg_539_1.time_ and arg_539_1.time_ <= 0.5 + arg_542_0 then
				arg_539_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_picture", "")
			end

			local var_542_2 = 0
			local var_542_3 = 1.075

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_2 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_4 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(1102201136).content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_6 = 43 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_4) / 43)

				if (43 <= 0 and var_542_3 or var_542_3 * (utf8.len(var_542_4) / 43)) > 0 and var_542_3 < var_542_6 then
					arg_539_1.talkMaxDuration = var_542_6

					if var_542_6 + var_542_2 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_6 + var_542_2
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_3, arg_539_1.talkMaxDuration)

			if var_542_2 <= arg_539_1.time_ and arg_539_1.time_ < var_542_2 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_2) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_2 + var_542_7 and arg_539_1.time_ < var_542_2 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play1102201137 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1102201137
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1102201138(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_546_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_543_1.bgmTxt_.text ~= var_546_2 and arg_543_1.bgmTxt_.text ~= "" then
						if arg_543_1.bgmTxt2_.text ~= "" then
							arg_543_1.bgmTxt_.text = arg_543_1.bgmTxt2_.text
						end

						arg_543_1.bgmTxt2_.text = var_546_2

						arg_543_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_543_1.bgmTxt_.text = var_546_2
						arg_543_1.bgmTxt2_.text = var_546_2
					end

					if arg_543_1.bgmTimer then
						arg_543_1.bgmTimer:Stop()

						arg_543_1.bgmTimer = nil
					end

					if arg_543_1.settingData.show_music_name == 1 then
						arg_543_1.musicController:SetSelectedState("show")
						arg_543_1.musicAnimator_:Play("open", 0, 0)

						if arg_543_1.settingData.music_time ~= 0 then
							arg_543_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_543_1.settingData.music_time), function()
								if arg_543_1 == nil or isNil(arg_543_1.bgmTxt_) then
									return
								end

								arg_543_1.musicController:SetSelectedState("hide")
								arg_543_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.9 < arg_543_1.time_ and arg_543_1.time_ <= 0.9 + arg_546_0 then
				arg_543_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_546_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_543_1.bgmTxt_.text ~= var_546_5 and arg_543_1.bgmTxt_.text ~= "" then
						if arg_543_1.bgmTxt2_.text ~= "" then
							arg_543_1.bgmTxt_.text = arg_543_1.bgmTxt2_.text
						end

						arg_543_1.bgmTxt2_.text = var_546_5

						arg_543_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_543_1.bgmTxt_.text = var_546_5
						arg_543_1.bgmTxt2_.text = var_546_5
					end

					if arg_543_1.bgmTimer then
						arg_543_1.bgmTimer:Stop()

						arg_543_1.bgmTimer = nil
					end

					if arg_543_1.settingData.show_music_name == 1 then
						arg_543_1.musicController:SetSelectedState("show")
						arg_543_1.musicAnimator_:Play("open", 0, 0)

						if arg_543_1.settingData.music_time ~= 0 then
							arg_543_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_543_1.settingData.music_time), function()
								if arg_543_1 == nil or isNil(arg_543_1.bgmTxt_) then
									return
								end

								arg_543_1.musicController:SetSelectedState("hide")
								arg_543_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.275 < arg_543_1.time_ and arg_543_1.time_ <= 0.275 + arg_546_0 then
				arg_543_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_leaves", "")
			end

			local var_546_7 = 0
			local var_546_8 = 1.275

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_7 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, false)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_9 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1102201137).content)

				arg_543_1.text_.text = var_546_9

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_11 = 51 <= 0 and var_546_8 or var_546_8 * (utf8.len(var_546_9) / 51)

				if (51 <= 0 and var_546_8 or var_546_8 * (utf8.len(var_546_9) / 51)) > 0 and var_546_8 < var_546_11 then
					arg_543_1.talkMaxDuration = var_546_11

					if var_546_11 + var_546_7 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_11 + var_546_7
					end
				end

				arg_543_1.text_.text = var_546_9
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_12 = math.max(var_546_8, arg_543_1.talkMaxDuration)

			if var_546_7 <= arg_543_1.time_ and arg_543_1.time_ < var_546_7 + var_546_12 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_7) / var_546_12

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_7 + var_546_12 and arg_543_1.time_ < var_546_7 + var_546_12 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play1102201138 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1102201138
		arg_549_1.duration_ = 6.6

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1102201139(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_552_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_549_1.bgmTxt_.text ~= var_552_2 and arg_549_1.bgmTxt_.text ~= "" then
						if arg_549_1.bgmTxt2_.text ~= "" then
							arg_549_1.bgmTxt_.text = arg_549_1.bgmTxt2_.text
						end

						arg_549_1.bgmTxt2_.text = var_552_2

						arg_549_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_549_1.bgmTxt_.text = var_552_2
						arg_549_1.bgmTxt2_.text = var_552_2
					end

					if arg_549_1.bgmTimer then
						arg_549_1.bgmTimer:Stop()

						arg_549_1.bgmTimer = nil
					end

					if arg_549_1.settingData.show_music_name == 1 then
						arg_549_1.musicController:SetSelectedState("show")
						arg_549_1.musicAnimator_:Play("open", 0, 0)

						if arg_549_1.settingData.music_time ~= 0 then
							arg_549_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_549_1.settingData.music_time), function()
								if arg_549_1 == nil or isNil(arg_549_1.bgmTxt_) then
									return
								end

								arg_549_1.musicController:SetSelectedState("hide")
								arg_549_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_549_1.time_ and arg_549_1.time_ <= 1 + arg_552_0 then
				arg_549_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_552_5 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if "" ~= "" then
					if arg_549_1.bgmTxt_.text ~= var_552_5 and arg_549_1.bgmTxt_.text ~= "" then
						if arg_549_1.bgmTxt2_.text ~= "" then
							arg_549_1.bgmTxt_.text = arg_549_1.bgmTxt2_.text
						end

						arg_549_1.bgmTxt2_.text = var_552_5

						arg_549_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_549_1.bgmTxt_.text = var_552_5
						arg_549_1.bgmTxt2_.text = var_552_5
					end

					if arg_549_1.bgmTimer then
						arg_549_1.bgmTimer:Stop()

						arg_549_1.bgmTimer = nil
					end

					if arg_549_1.settingData.show_music_name == 1 then
						arg_549_1.musicController:SetSelectedState("show")
						arg_549_1.musicAnimator_:Play("open", 0, 0)

						if arg_549_1.settingData.music_time ~= 0 then
							arg_549_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_549_1.settingData.music_time), function()
								if arg_549_1 == nil or isNil(arg_549_1.bgmTxt_) then
									return
								end

								arg_549_1.musicController:SetSelectedState("hide")
								arg_549_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_552_6 = 0
			local var_552_7 = 0.825

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_6 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_8 = arg_549_1:GetWordFromCfg(1102201138)
				local var_552_9 = arg_549_1:FormatText(var_552_8.content)

				arg_549_1.text_.text = var_552_9

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_11 = 33 <= 0 and var_552_7 or var_552_7 * (utf8.len(var_552_9) / 33)

				if (33 <= 0 and var_552_7 or var_552_7 * (utf8.len(var_552_9) / 33)) > 0 and var_552_7 < var_552_11 then
					arg_549_1.talkMaxDuration = var_552_11

					if var_552_11 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_11 + var_552_6
					end
				end

				arg_549_1.text_.text = var_552_9
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201138", "story_v_side_new_1102201.awb") ~= 0 then
					local var_552_12 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201138", "story_v_side_new_1102201.awb") / 1000

					if var_552_12 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_12 + var_552_6
					end

					if var_552_8.prefab_name ~= "" and arg_549_1.actors_[var_552_8.prefab_name] ~= nil then
						local var_552_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_8.prefab_name].transform, "story_v_side_new_1102201", "1102201138", "story_v_side_new_1102201.awb")

						arg_549_1:RecordAudio("1102201138", var_552_13)
						arg_549_1:RecordAudio("1102201138", var_552_13)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201138", "story_v_side_new_1102201.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201138", "story_v_side_new_1102201.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_14 = math.max(var_552_7, arg_549_1.talkMaxDuration)

			if var_552_6 <= arg_549_1.time_ and arg_549_1.time_ < var_552_6 + var_552_14 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_6) / var_552_14

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_6 + var_552_14 and arg_549_1.time_ < var_552_6 + var_552_14 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1102201139 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1102201139
		arg_555_1.duration_ = 2.87

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1102201140(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos102201ui_story = arg_555_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).z)
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles = arg_555_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_555_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["102201ui_story"].transform.position).z)
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["102201ui_story"].transform.localEulerAngles = arg_555_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["102201ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect102201ui_story == nil then
				arg_555_1.var_.characterEffect102201ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect102201ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect102201ui_story then
				arg_555_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_558_4 = 0
			local var_558_5 = 0.25

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_4 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_6 = arg_555_1:GetWordFromCfg(1102201139)
				local var_558_7 = arg_555_1:FormatText(var_558_6.content)

				arg_555_1.text_.text = var_558_7

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_9 = 10 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 10)

				if (10 <= 0 and var_558_5 or var_558_5 * (utf8.len(var_558_7) / 10)) > 0 and var_558_5 < var_558_9 then
					arg_555_1.talkMaxDuration = var_558_9

					if var_558_9 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_9 + var_558_4
					end
				end

				arg_555_1.text_.text = var_558_7
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201139", "story_v_side_new_1102201.awb") ~= 0 then
					local var_558_10 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201139", "story_v_side_new_1102201.awb") / 1000

					if var_558_10 + var_558_4 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_4
					end

					if var_558_6.prefab_name ~= "" and arg_555_1.actors_[var_558_6.prefab_name] ~= nil then
						local var_558_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_6.prefab_name].transform, "story_v_side_new_1102201", "1102201139", "story_v_side_new_1102201.awb")

						arg_555_1:RecordAudio("1102201139", var_558_11)
						arg_555_1:RecordAudio("1102201139", var_558_11)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201139", "story_v_side_new_1102201.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201139", "story_v_side_new_1102201.awb")
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
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play1102201140 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1102201140
		arg_559_1.duration_ = 6.77

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1102201141(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["102201ui_story"]) and arg_559_1.var_.characterEffect102201ui_story == nil then
				arg_559_1.var_.characterEffect102201ui_story = arg_559_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["102201ui_story"]) then
				if arg_559_1.var_.characterEffect102201ui_story and not isNil(arg_559_1.actors_["102201ui_story"]) then
					arg_559_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_559_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_559_1.time_ - 0) / var_562_0)
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["102201ui_story"]) and arg_559_1.var_.characterEffect102201ui_story then
				arg_559_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_559_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_562_1 = 0
			local var_562_2 = 0.875

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:GetWordFromCfg(1102201140)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_6 = 35 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_4) / 35)

				if (35 <= 0 and var_562_2 or var_562_2 * (utf8.len(var_562_4) / 35)) > 0 and var_562_2 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_1
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201140", "story_v_side_new_1102201.awb") ~= 0 then
					local var_562_7 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201140", "story_v_side_new_1102201.awb") / 1000

					if var_562_7 + var_562_1 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_1
					end

					if var_562_3.prefab_name ~= "" and arg_559_1.actors_[var_562_3.prefab_name] ~= nil then
						local var_562_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_3.prefab_name].transform, "story_v_side_new_1102201", "1102201140", "story_v_side_new_1102201.awb")

						arg_559_1:RecordAudio("1102201140", var_562_8)
						arg_559_1:RecordAudio("1102201140", var_562_8)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201140", "story_v_side_new_1102201.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201140", "story_v_side_new_1102201.awb")
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
	Play1102201141 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1102201141
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play1102201142(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.65

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

				local var_566_1 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(1102201141).content)

				arg_563_1.text_.text = var_566_1

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_3 = 26 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 26)

				if (26 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_1) / 26)) > 0 and var_566_0 < var_566_3 then
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
	Play1102201142 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1102201142
		arg_567_1.duration_ = 5.2

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1102201143(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.65

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_1 = arg_567_1:GetWordFromCfg(1102201142)
				local var_570_2 = arg_567_1:FormatText(var_570_1.content)

				arg_567_1.text_.text = var_570_2

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_4 = 26 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 26)

				if (26 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 26)) > 0 and var_570_0 < var_570_4 then
					arg_567_1.talkMaxDuration = var_570_4

					if var_570_4 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_4 + 0
					end
				end

				arg_567_1.text_.text = var_570_2
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201142", "story_v_side_new_1102201.awb") ~= 0 then
					local var_570_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201142", "story_v_side_new_1102201.awb") / 1000

					if var_570_5 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + 0
					end

					if var_570_1.prefab_name ~= "" and arg_567_1.actors_[var_570_1.prefab_name] ~= nil then
						local var_570_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_1.prefab_name].transform, "story_v_side_new_1102201", "1102201142", "story_v_side_new_1102201.awb")

						arg_567_1:RecordAudio("1102201142", var_570_6)
						arg_567_1:RecordAudio("1102201142", var_570_6)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201142", "story_v_side_new_1102201.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201142", "story_v_side_new_1102201.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_7 and arg_567_1.time_ < 0 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play1102201143 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1102201143
		arg_571_1.duration_ = 8.13

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1102201144(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["102201ui_story"]) and arg_571_1.var_.characterEffect102201ui_story == nil then
				arg_571_1.var_.characterEffect102201ui_story = arg_571_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["102201ui_story"]) then
				if arg_571_1.var_.characterEffect102201ui_story and not isNil(arg_571_1.actors_["102201ui_story"]) then
					arg_571_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["102201ui_story"]) and arg_571_1.var_.characterEffect102201ui_story then
				arg_571_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_574_2 = 0
			local var_574_3 = 1.05

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:GetWordFromCfg(1102201143)
				local var_574_5 = arg_571_1:FormatText(var_574_4.content)

				arg_571_1.text_.text = var_574_5

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_7 = 42 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 42)

				if (42 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 42)) > 0 and var_574_3 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_5
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201143", "story_v_side_new_1102201.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201143", "story_v_side_new_1102201.awb") / 1000

					if var_574_8 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_2
					end

					if var_574_4.prefab_name ~= "" and arg_571_1.actors_[var_574_4.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_4.prefab_name].transform, "story_v_side_new_1102201", "1102201143", "story_v_side_new_1102201.awb")

						arg_571_1:RecordAudio("1102201143", var_574_9)
						arg_571_1:RecordAudio("1102201143", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201143", "story_v_side_new_1102201.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201143", "story_v_side_new_1102201.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_10 and arg_571_1.time_ < var_574_2 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1102201144 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1102201144
		arg_575_1.duration_ = 4.7

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1102201145(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(arg_575_1.actors_["102201ui_story"]) and arg_575_1.var_.characterEffect102201ui_story == nil then
				arg_575_1.var_.characterEffect102201ui_story = arg_575_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_0 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 and not isNil(arg_575_1.actors_["102201ui_story"]) then
				if arg_575_1.var_.characterEffect102201ui_story and not isNil(arg_575_1.actors_["102201ui_story"]) then
					arg_575_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_575_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_575_1.time_ - 0) / var_578_0)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 and not isNil(arg_575_1.actors_["102201ui_story"]) and arg_575_1.var_.characterEffect102201ui_story then
				arg_575_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_575_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_578_1 = 0
			local var_578_2 = 0.7

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_3 = arg_575_1:GetWordFromCfg(1102201144)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_6 = 28 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_4) / 28)

				if (28 <= 0 and var_578_2 or var_578_2 * (utf8.len(var_578_4) / 28)) > 0 and var_578_2 < var_578_6 then
					arg_575_1.talkMaxDuration = var_578_6

					if var_578_6 + var_578_1 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_6 + var_578_1
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201144", "story_v_side_new_1102201.awb") ~= 0 then
					local var_578_7 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201144", "story_v_side_new_1102201.awb") / 1000

					if var_578_7 + var_578_1 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_1
					end

					if var_578_3.prefab_name ~= "" and arg_575_1.actors_[var_578_3.prefab_name] ~= nil then
						local var_578_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_3.prefab_name].transform, "story_v_side_new_1102201", "1102201144", "story_v_side_new_1102201.awb")

						arg_575_1:RecordAudio("1102201144", var_578_8)
						arg_575_1:RecordAudio("1102201144", var_578_8)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201144", "story_v_side_new_1102201.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201144", "story_v_side_new_1102201.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_9 = math.max(var_578_2, arg_575_1.talkMaxDuration)

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_9 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_1) / var_578_9

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_1 + var_578_9 and arg_575_1.time_ < var_578_1 + var_578_9 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play1102201145 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1102201145
		arg_579_1.duration_ = 7.47

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1102201146(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.775

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_1 = arg_579_1:GetWordFromCfg(1102201145)
				local var_582_2 = arg_579_1:FormatText(var_582_1.content)

				arg_579_1.text_.text = var_582_2

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 32 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 32)

				if (32 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 32)) > 0 and var_582_0 < var_582_4 then
					arg_579_1.talkMaxDuration = var_582_4

					if var_582_4 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_4 + 0
					end
				end

				arg_579_1.text_.text = var_582_2
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201145", "story_v_side_new_1102201.awb") ~= 0 then
					local var_582_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201145", "story_v_side_new_1102201.awb") / 1000

					if var_582_5 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + 0
					end

					if var_582_1.prefab_name ~= "" and arg_579_1.actors_[var_582_1.prefab_name] ~= nil then
						local var_582_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_1.prefab_name].transform, "story_v_side_new_1102201", "1102201145", "story_v_side_new_1102201.awb")

						arg_579_1:RecordAudio("1102201145", var_582_6)
						arg_579_1:RecordAudio("1102201145", var_582_6)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201145", "story_v_side_new_1102201.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201145", "story_v_side_new_1102201.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_7 and arg_579_1.time_ < 0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1102201146 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1102201146
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1102201147(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos102201ui_story = arg_583_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_586_0 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 then
				arg_583_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_583_1.time_ - 0) / var_586_0)
				arg_583_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).z)
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles = arg_583_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 then
				arg_583_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_583_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_583_1.actors_["102201ui_story"].transform.position).z)
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_583_1.actors_["102201ui_story"].transform.localEulerAngles = arg_583_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_586_1 = 0
			local var_586_2 = 1.25

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, false)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_3 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(1102201146).content)

				arg_583_1.text_.text = var_586_3

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 50 <= 0 and var_586_2 or var_586_2 * (utf8.len(var_586_3) / 50)

				if (50 <= 0 and var_586_2 or var_586_2 * (utf8.len(var_586_3) / 50)) > 0 and var_586_2 < var_586_5 then
					arg_583_1.talkMaxDuration = var_586_5

					if var_586_5 + var_586_1 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + var_586_1
					end
				end

				arg_583_1.text_.text = var_586_3
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_6 = math.max(var_586_2, arg_583_1.talkMaxDuration)

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_6 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_1) / var_586_6

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_1 + var_586_6 and arg_583_1.time_ < var_586_1 + var_586_6 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play1102201147 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1102201147
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1102201148(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.525

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1102201147).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 21 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 21)

				if (21 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 21)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1102201148 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1102201148
		arg_591_1.duration_ = 7.4

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1102201149(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.725

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:GetWordFromCfg(1102201148)
				local var_594_2 = arg_591_1:FormatText(var_594_1.content)

				arg_591_1.text_.text = var_594_2

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_4 = 29 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 29)

				if (29 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_2) / 29)) > 0 and var_594_0 < var_594_4 then
					arg_591_1.talkMaxDuration = var_594_4

					if var_594_4 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_4 + 0
					end
				end

				arg_591_1.text_.text = var_594_2
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201148", "story_v_side_new_1102201.awb") ~= 0 then
					local var_594_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201148", "story_v_side_new_1102201.awb") / 1000

					if var_594_5 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_5 + 0
					end

					if var_594_1.prefab_name ~= "" and arg_591_1.actors_[var_594_1.prefab_name] ~= nil then
						local var_594_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_1.prefab_name].transform, "story_v_side_new_1102201", "1102201148", "story_v_side_new_1102201.awb")

						arg_591_1:RecordAudio("1102201148", var_594_6)
						arg_591_1:RecordAudio("1102201148", var_594_6)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201148", "story_v_side_new_1102201.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201148", "story_v_side_new_1102201.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_7 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_7 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_7

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_7 and arg_591_1.time_ < 0 + var_594_7 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1102201149 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1102201149
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1102201150(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 1.425

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, false)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_1 = arg_595_1:FormatText(arg_595_1:GetWordFromCfg(1102201149).content)

				arg_595_1.text_.text = var_598_1

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_3 = 57 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 57)

				if (57 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_1) / 57)) > 0 and var_598_0 < var_598_3 then
					arg_595_1.talkMaxDuration = var_598_3

					if var_598_3 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_3 + 0
					end
				end

				arg_595_1.text_.text = var_598_1
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_4 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_4 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_4

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_4 and arg_595_1.time_ < 0 + var_598_4 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play1102201150 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1102201150
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1102201151(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_602_0 = 1

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 then
				local var_602_1, var_602_2 = math.modf((arg_599_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_602_2 * 0.13, var_602_2 * 0.13, var_602_2 * 0.13) + arg_599_1.var_.shakeOldPos
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 then
				manager.ui.mainCamera.transform.localPosition = arg_599_1.var_.shakeOldPos
			end

			local var_602_3 = 0

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_3 + arg_602_0 then
				arg_599_1.allBtn_.enabled = false
			end

			if arg_599_1.time_ >= var_602_3 + 1 and arg_599_1.time_ < var_602_3 + 1 + arg_602_0 then
				arg_599_1.allBtn_.enabled = true
			end

			local var_602_4 = 0
			local var_602_5 = 0.325

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
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

				local var_602_6 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(1102201150).content)

				arg_599_1.text_.text = var_602_6

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_8 = 13 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_6) / 13)

				if (13 <= 0 and var_602_5 or var_602_5 * (utf8.len(var_602_6) / 13)) > 0 and var_602_5 < var_602_8 then
					arg_599_1.talkMaxDuration = var_602_8

					if var_602_8 + var_602_4 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_8 + var_602_4
					end
				end

				arg_599_1.text_.text = var_602_6
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_9 = math.max(var_602_5, arg_599_1.talkMaxDuration)

			if var_602_4 <= arg_599_1.time_ and arg_599_1.time_ < var_602_4 + var_602_9 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_4) / var_602_9

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_4 + var_602_9 and arg_599_1.time_ < var_602_4 + var_602_9 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1102201151 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1102201151
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
			arg_603_1.auto_ = false
		end

		function arg_603_1.playNext_(arg_605_0)
			arg_603_1.onStoryFinished_()
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0.2 < arg_603_1.time_ and arg_603_1.time_ <= 0.2 + arg_606_0 then
				arg_603_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officefootstep", "")
			end

			local var_606_1 = 0
			local var_606_2 = 2.05

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_3 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(1102201151).content)

				arg_603_1.text_.text = var_606_3

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 82 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_3) / 82)

				if (82 <= 0 and var_606_2 or var_606_2 * (utf8.len(var_606_3) / 82)) > 0 and var_606_2 < var_606_5 then
					arg_603_1.talkMaxDuration = var_606_5

					if var_606_5 + var_606_1 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_5 + var_606_1
					end
				end

				arg_603_1.text_.text = var_606_3
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_6 = math.max(var_606_2, arg_603_1.talkMaxDuration)

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_6 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_1) / var_606_6

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_1 + var_606_6 and arg_603_1.time_ < var_606_1 + var_606_6 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1102201126 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1102201126
		arg_607_1.duration_ = 3.23

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1102201127(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if arg_607_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_610_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_607_1.stage_.transform)

				var_610_0.name = "102201ui_story"
				var_610_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_607_1.actors_["102201ui_story"] = var_610_0

				local var_610_1 = var_610_0:GetComponentInChildren(typeof(CharacterEffect))

				var_610_1.enabled = true

				local var_610_2 = GameObjectTools.GetOrAddComponent(var_610_0, typeof(DynamicBoneHelper))

				if var_610_2 then
					var_610_2:EnableDynamicBone(false)
				end

				arg_607_1:ShowWeapon(var_610_1.transform, false)

				arg_607_1.var_["102201ui_story" .. "Animator"] = var_610_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_607_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_607_1.var_["102201ui_story" .. "LipSync"] = var_610_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action3_2")
			end

			local var_610_3 = arg_607_1.actors_["102201ui_story"]

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(var_610_3) and arg_607_1.var_.characterEffect102201ui_story == nil then
				arg_607_1.var_.characterEffect102201ui_story = var_610_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_4 = 0.2

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_4 and not isNil(var_610_3) then
				if arg_607_1.var_.characterEffect102201ui_story and not isNil(var_610_3) then
					arg_607_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_4 and arg_607_1.time_ < 0 + var_610_4 + arg_610_0 and not isNil(var_610_3) and arg_607_1.var_.characterEffect102201ui_story then
				arg_607_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_610_6 = 0
			local var_610_7 = 0.325

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_6 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_8 = arg_607_1:GetWordFromCfg(1102201126)
				local var_610_9 = arg_607_1:FormatText(var_610_8.content)

				arg_607_1.text_.text = var_610_9

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_11 = 13 <= 0 and var_610_7 or var_610_7 * (utf8.len(var_610_9) / 13)

				if (13 <= 0 and var_610_7 or var_610_7 * (utf8.len(var_610_9) / 13)) > 0 and var_610_7 < var_610_11 then
					arg_607_1.talkMaxDuration = var_610_11

					if var_610_11 + var_610_6 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_11 + var_610_6
					end
				end

				arg_607_1.text_.text = var_610_9
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201126", "story_v_side_new_1102201.awb") ~= 0 then
					local var_610_12 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201126", "story_v_side_new_1102201.awb") / 1000

					if var_610_12 + var_610_6 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_12 + var_610_6
					end

					if var_610_8.prefab_name ~= "" and arg_607_1.actors_[var_610_8.prefab_name] ~= nil then
						local var_610_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_8.prefab_name].transform, "story_v_side_new_1102201", "1102201126", "story_v_side_new_1102201.awb")

						arg_607_1:RecordAudio("1102201126", var_610_13)
						arg_607_1:RecordAudio("1102201126", var_610_13)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201126", "story_v_side_new_1102201.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201126", "story_v_side_new_1102201.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_14 = math.max(var_610_7, arg_607_1.talkMaxDuration)

			if var_610_6 <= arg_607_1.time_ and arg_607_1.time_ < var_610_6 + var_610_14 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_6) / var_610_14

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_6 + var_610_14 and arg_607_1.time_ < var_610_6 + var_610_14 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1102201107 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1102201107
		arg_611_1.duration_ = 9.17

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1102201108(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if arg_611_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_614_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_611_1.stage_.transform)

				var_614_0.name = "102201ui_story"
				var_614_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_611_1.actors_["102201ui_story"] = var_614_0

				local var_614_1 = var_614_0:GetComponentInChildren(typeof(CharacterEffect))

				var_614_1.enabled = true

				local var_614_2 = GameObjectTools.GetOrAddComponent(var_614_0, typeof(DynamicBoneHelper))

				if var_614_2 then
					var_614_2:EnableDynamicBone(false)
				end

				arg_611_1:ShowWeapon(var_614_1.transform, false)

				arg_611_1.var_["102201ui_story" .. "Animator"] = var_614_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_611_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_611_1.var_["102201ui_story" .. "LipSync"] = var_614_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022actionlink/1022action452")
			end

			local var_614_3 = "102201ui_story"

			if arg_611_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_614_4 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_611_1.stage_.transform)

				var_614_4.name = var_614_3
				var_614_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_611_1.actors_[var_614_3] = var_614_4

				local var_614_5 = var_614_4:GetComponentInChildren(typeof(CharacterEffect))

				var_614_5.enabled = true

				local var_614_6 = GameObjectTools.GetOrAddComponent(var_614_4, typeof(DynamicBoneHelper))

				if var_614_6 then
					var_614_6:EnableDynamicBone(false)
				end

				arg_611_1:ShowWeapon(var_614_5.transform, false)

				arg_611_1.var_[var_614_3 .. "Animator"] = var_614_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_611_1.var_[var_614_3 .. "Animator"].applyRootMotion = true
				arg_611_1.var_[var_614_3 .. "LipSync"] = var_614_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_614_7 = arg_611_1.actors_["102201ui_story"]

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(var_614_7) and arg_611_1.var_.characterEffect102201ui_story == nil then
				arg_611_1.var_.characterEffect102201ui_story = var_614_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_8 = 0.2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_8 and not isNil(var_614_7) then
				if arg_611_1.var_.characterEffect102201ui_story and not isNil(var_614_7) then
					arg_611_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_8 and arg_611_1.time_ < 0 + var_614_8 + arg_614_0 and not isNil(var_614_7) and arg_611_1.var_.characterEffect102201ui_story then
				arg_611_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_614_10 = 0
			local var_614_11 = 0.775

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_10 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_12 = arg_611_1:GetWordFromCfg(1102201107)
				local var_614_13 = arg_611_1:FormatText(var_614_12.content)

				arg_611_1.text_.text = var_614_13

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_15 = 31 <= 0 and var_614_11 or var_614_11 * (utf8.len(var_614_13) / 31)

				if (31 <= 0 and var_614_11 or var_614_11 * (utf8.len(var_614_13) / 31)) > 0 and var_614_11 < var_614_15 then
					arg_611_1.talkMaxDuration = var_614_15

					if var_614_15 + var_614_10 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_15 + var_614_10
					end
				end

				arg_611_1.text_.text = var_614_13
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201107", "story_v_side_new_1102201.awb") ~= 0 then
					local var_614_16 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201107", "story_v_side_new_1102201.awb") / 1000

					if var_614_16 + var_614_10 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_16 + var_614_10
					end

					if var_614_12.prefab_name ~= "" and arg_611_1.actors_[var_614_12.prefab_name] ~= nil then
						local var_614_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_12.prefab_name].transform, "story_v_side_new_1102201", "1102201107", "story_v_side_new_1102201.awb")

						arg_611_1:RecordAudio("1102201107", var_614_17)
						arg_611_1:RecordAudio("1102201107", var_614_17)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201107", "story_v_side_new_1102201.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201107", "story_v_side_new_1102201.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_18 = math.max(var_614_11, arg_611_1.talkMaxDuration)

			if var_614_10 <= arg_611_1.time_ and arg_611_1.time_ < var_614_10 + var_614_18 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_10) / var_614_18

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_10 + var_614_18 and arg_611_1.time_ < var_614_10 + var_614_18 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1102201108 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1102201108
		arg_615_1.duration_ = 3.1

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1102201109(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action2_2")
			end

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_618_0 = 0
			local var_618_1 = 0.325

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_2 = arg_615_1:GetWordFromCfg(1102201108)
				local var_618_3 = arg_615_1:FormatText(var_618_2.content)

				arg_615_1.text_.text = var_618_3

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 13 <= 0 and var_618_1 or var_618_1 * (utf8.len(var_618_3) / 13)

				if (13 <= 0 and var_618_1 or var_618_1 * (utf8.len(var_618_3) / 13)) > 0 and var_618_1 < var_618_5 then
					arg_615_1.talkMaxDuration = var_618_5

					if var_618_5 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_3
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201108", "story_v_side_new_1102201.awb") ~= 0 then
					local var_618_6 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201108", "story_v_side_new_1102201.awb") / 1000

					if var_618_6 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_6 + var_618_0
					end

					if var_618_2.prefab_name ~= "" and arg_615_1.actors_[var_618_2.prefab_name] ~= nil then
						local var_618_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_2.prefab_name].transform, "story_v_side_new_1102201", "1102201108", "story_v_side_new_1102201.awb")

						arg_615_1:RecordAudio("1102201108", var_618_7)
						arg_615_1:RecordAudio("1102201108", var_618_7)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201108", "story_v_side_new_1102201.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201108", "story_v_side_new_1102201.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_8 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_8 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_8

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_8 and arg_615_1.time_ < var_618_0 + var_618_8 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1102201088 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1102201088
		arg_619_1.duration_ = 2.83

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1102201089(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if arg_619_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_622_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_619_1.stage_.transform)

				var_622_0.name = "102201ui_story"
				var_622_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_619_1.actors_["102201ui_story"] = var_622_0

				local var_622_1 = var_622_0:GetComponentInChildren(typeof(CharacterEffect))

				var_622_1.enabled = true

				local var_622_2 = GameObjectTools.GetOrAddComponent(var_622_0, typeof(DynamicBoneHelper))

				if var_622_2 then
					var_622_2:EnableDynamicBone(false)
				end

				arg_619_1:ShowWeapon(var_622_1.transform, false)

				arg_619_1.var_["102201ui_story" .. "Animator"] = var_622_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_619_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_619_1.var_["102201ui_story" .. "LipSync"] = var_622_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_622_3 = arg_619_1.actors_["102201ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_3) and arg_619_1.var_.characterEffect102201ui_story == nil then
				arg_619_1.var_.characterEffect102201ui_story = var_622_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_4 = 0.2

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 and not isNil(var_622_3) then
				if arg_619_1.var_.characterEffect102201ui_story and not isNil(var_622_3) then
					arg_619_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 and not isNil(var_622_3) and arg_619_1.var_.characterEffect102201ui_story then
				arg_619_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_622_6 = 0
			local var_622_7 = 0.375

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_6 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_8 = arg_619_1:GetWordFromCfg(1102201088)
				local var_622_9 = arg_619_1:FormatText(var_622_8.content)

				arg_619_1.text_.text = var_622_9

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_11 = 15 <= 0 and var_622_7 or var_622_7 * (utf8.len(var_622_9) / 15)

				if (15 <= 0 and var_622_7 or var_622_7 * (utf8.len(var_622_9) / 15)) > 0 and var_622_7 < var_622_11 then
					arg_619_1.talkMaxDuration = var_622_11

					if var_622_11 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_11 + var_622_6
					end
				end

				arg_619_1.text_.text = var_622_9
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201088", "story_v_side_new_1102201.awb") ~= 0 then
					local var_622_12 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201088", "story_v_side_new_1102201.awb") / 1000

					if var_622_12 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_12 + var_622_6
					end

					if var_622_8.prefab_name ~= "" and arg_619_1.actors_[var_622_8.prefab_name] ~= nil then
						local var_622_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_8.prefab_name].transform, "story_v_side_new_1102201", "1102201088", "story_v_side_new_1102201.awb")

						arg_619_1:RecordAudio("1102201088", var_622_13)
						arg_619_1:RecordAudio("1102201088", var_622_13)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201088", "story_v_side_new_1102201.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201088", "story_v_side_new_1102201.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_7, arg_619_1.talkMaxDuration)

			if var_622_6 <= arg_619_1.time_ and arg_619_1.time_ < var_622_6 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_6) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_6 + var_622_14 and arg_619_1.time_ < var_622_6 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play1102201062 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1102201062
		arg_623_1.duration_ = 7.2

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1102201063(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["1022ui_story"]) and arg_623_1.var_.characterEffect1022ui_story == nil then
				arg_623_1.var_.characterEffect1022ui_story = arg_623_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["1022ui_story"]) then
				if arg_623_1.var_.characterEffect1022ui_story and not isNil(arg_623_1.actors_["1022ui_story"]) then
					arg_623_1.var_.characterEffect1022ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["1022ui_story"]) and arg_623_1.var_.characterEffect1022ui_story then
				arg_623_1.var_.characterEffect1022ui_story.fillFlat = false
			end

			local var_626_2 = 0
			local var_626_3 = 0.8

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_2 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_4 = arg_623_1:GetWordFromCfg(1102201062)
				local var_626_5 = arg_623_1:FormatText(var_626_4.content)

				arg_623_1.text_.text = var_626_5

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_7 = 32 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_5) / 32)

				if (32 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_5) / 32)) > 0 and var_626_3 < var_626_7 then
					arg_623_1.talkMaxDuration = var_626_7

					if var_626_7 + var_626_2 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_7 + var_626_2
					end
				end

				arg_623_1.text_.text = var_626_5
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201062", "story_v_side_new_1102201.awb") ~= 0 then
					local var_626_8 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201062", "story_v_side_new_1102201.awb") / 1000

					if var_626_8 + var_626_2 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_2
					end

					if var_626_4.prefab_name ~= "" and arg_623_1.actors_[var_626_4.prefab_name] ~= nil then
						local var_626_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_4.prefab_name].transform, "story_v_side_new_1102201", "1102201062", "story_v_side_new_1102201.awb")

						arg_623_1:RecordAudio("1102201062", var_626_9)
						arg_623_1:RecordAudio("1102201062", var_626_9)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201062", "story_v_side_new_1102201.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201062", "story_v_side_new_1102201.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_10 = math.max(var_626_3, arg_623_1.talkMaxDuration)

			if var_626_2 <= arg_623_1.time_ and arg_623_1.time_ < var_626_2 + var_626_10 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_2) / var_626_10

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_2 + var_626_10 and arg_623_1.time_ < var_626_2 + var_626_10 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1102201063 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1102201063
		arg_627_1.duration_ = 6.97

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1102201064(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.8

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_1 = arg_627_1:GetWordFromCfg(1102201063)
				local var_630_2 = arg_627_1:FormatText(var_630_1.content)

				arg_627_1.text_.text = var_630_2

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_4 = 32 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 32)

				if (32 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_2) / 32)) > 0 and var_630_0 < var_630_4 then
					arg_627_1.talkMaxDuration = var_630_4

					if var_630_4 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_4 + 0
					end
				end

				arg_627_1.text_.text = var_630_2
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201063", "story_v_side_new_1102201.awb") ~= 0 then
					local var_630_5 = manager.audio:GetVoiceLength("story_v_side_new_1102201", "1102201063", "story_v_side_new_1102201.awb") / 1000

					if var_630_5 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_5 + 0
					end

					if var_630_1.prefab_name ~= "" and arg_627_1.actors_[var_630_1.prefab_name] ~= nil then
						local var_630_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_1.prefab_name].transform, "story_v_side_new_1102201", "1102201063", "story_v_side_new_1102201.awb")

						arg_627_1:RecordAudio("1102201063", var_630_6)
						arg_627_1:RecordAudio("1102201063", var_630_6)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_side_new_1102201", "1102201063", "story_v_side_new_1102201.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_side_new_1102201", "1102201063", "story_v_side_new_1102201.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_7 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_7 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_7

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_7 and arg_627_1.time_ < 0 + var_630_7 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1102201064 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1102201064
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1102201065(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1022ui_story"]) and arg_631_1.var_.characterEffect1022ui_story == nil then
				arg_631_1.var_.characterEffect1022ui_story = arg_631_1.actors_["1022ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.200000002980232

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1022ui_story"]) then
				if arg_631_1.var_.characterEffect1022ui_story and not isNil(arg_631_1.actors_["1022ui_story"]) then
					arg_631_1.var_.characterEffect1022ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1022ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_631_1.time_ - 0) / var_634_0)
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1022ui_story"]) and arg_631_1.var_.characterEffect1022ui_story then
				arg_631_1.var_.characterEffect1022ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1022ui_story.fillRatio = 0.5
			end

			local var_634_1 = 0
			local var_634_2 = 0.5

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_3 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(1102201064).content)

				arg_631_1.text_.text = var_634_3

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_5 = 20 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 20)

				if (20 <= 0 and var_634_2 or var_634_2 * (utf8.len(var_634_3) / 20)) > 0 and var_634_2 < var_634_5 then
					arg_631_1.talkMaxDuration = var_634_5

					if var_634_5 + var_634_1 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + var_634_1
					end
				end

				arg_631_1.text_.text = var_634_3
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_6 = math.max(var_634_2, arg_631_1.talkMaxDuration)

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_6 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_1) / var_634_6

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_1 + var_634_6 and arg_631_1.time_ < var_634_1 + var_634_6 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/ST21",
		"TextureConfig/Background/ST21a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST22a"
	},
	voices = {
		"story_v_side_new_1102201.awb"
	}
}
