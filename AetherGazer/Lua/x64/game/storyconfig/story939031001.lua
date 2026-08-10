return {
	Play939031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 2
			local var_4_31 = 5

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "1"

				arg_1_1.marker = "luntantiezi9998"

				if not arg_1_1.actionList["1"] then
					arg_1_1.actionList["1"] = StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")
				end

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 103,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "bgBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939031002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939031002
		arg_6_1.duration_ = 9

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939031003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "ST04c"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 2

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.ST04c

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST04c" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 4

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_17 = 0.3

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_19 = 2

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				local var_9_20 = (arg_6_1.time_ - var_9_18) / var_9_19
				local var_9_21 = Color.New(0, 0, 0)

				var_9_21.a = Mathf.Lerp(0, 1, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)

				var_9_22.a = 1
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_23 = 2

			if var_9_23 < arg_6_1.time_ and arg_6_1.time_ <= var_9_23 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_24 = 2

			if var_9_23 <= arg_6_1.time_ and arg_6_1.time_ < var_9_23 + var_9_24 then
				local var_9_25 = (arg_6_1.time_ - var_9_23) / var_9_24
				local var_9_26 = Color.New(0, 0, 0)

				var_9_26.a = Mathf.Lerp(1, 0, var_9_25)
				arg_6_1.mask_.color = var_9_26
			end

			if arg_6_1.time_ >= var_9_23 + var_9_24 and arg_6_1.time_ < var_9_23 + var_9_24 + arg_9_0 then
				local var_9_27 = Color.New(0, 0, 0)
				local var_9_28 = 0

				arg_6_1.mask_.enabled = false
				var_9_27.a = var_9_28
				arg_6_1.mask_.color = var_9_27
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_29 = 4
			local var_9_30 = 1

			if var_9_29 < arg_6_1.time_ and arg_6_1.time_ <= var_9_29 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_31 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_31:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_32 = arg_6_1:GetWordFromCfg(939031002)
				local var_9_33 = arg_6_1:FormatText(var_9_32.content)

				arg_6_1.text_.text = var_9_33

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_34 = 40
				local var_9_35 = utf8.len(var_9_33)
				local var_9_36 = var_9_34 <= 0 and var_9_30 or var_9_30 * (var_9_35 / var_9_34)

				if var_9_36 > 0 and var_9_30 < var_9_36 then
					arg_6_1.talkMaxDuration = var_9_36
					var_9_29 = var_9_29 + 0.3

					if var_9_36 + var_9_29 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_36 + var_9_29
					end
				end

				arg_6_1.text_.text = var_9_33
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_37 = var_9_29 + 0.3
			local var_9_38 = math.max(var_9_30, arg_6_1.talkMaxDuration)

			if var_9_37 <= arg_6_1.time_ and arg_6_1.time_ < var_9_37 + var_9_38 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_37) / var_9_38

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_37 + var_9_38 and arg_6_1.time_ < var_9_37 + var_9_38 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play939031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939031003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.25

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[36].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(939031003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 10
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play939031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_.story_grandmaaui_story
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_16_1.var_.characterEffectstory_grandmaaui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffectstory_grandmaaui_story then
				arg_16_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_19_4 = 0
			local var_19_5 = 0.525

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_6 = arg_16_1:FormatText(StoryNameCfg[1540].name)

				arg_16_1.leftNameTxt_.text = var_19_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_7 = arg_16_1:GetWordFromCfg(939031004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 21
				local var_19_10 = utf8.len(var_19_8)
				local var_19_11 = var_19_9 <= 0 and var_19_5 or var_19_5 * (var_19_10 / var_19_9)

				if var_19_11 > 0 and var_19_5 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_12 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_12 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_12

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_12 and arg_16_1.time_ < var_19_4 + var_19_12 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play939031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939031005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_.story_grandmaaui_story
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_20_1.var_.characterEffectstory_grandmaaui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_20_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffectstory_grandmaaui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_20_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.325

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[36].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_9 = arg_20_1:GetWordFromCfg(939031005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 13
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play939031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939031006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_.story_grandmaaui_story
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_24_1.var_.characterEffectstory_grandmaaui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffectstory_grandmaaui_story then
				arg_24_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.7

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[1540].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_7 = arg_24_1:GetWordFromCfg(939031006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 28
				local var_27_10 = utf8.len(var_27_8)
				local var_27_11 = var_27_9 <= 0 and var_27_5 or var_27_5 * (var_27_10 / var_27_9)

				if var_27_11 > 0 and var_27_5 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play939031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939031007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_.story_grandmaaui_story
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_28_1.var_.characterEffectstory_grandmaaui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_28_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffectstory_grandmaaui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_28_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.7

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(939031007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 28
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_7 or var_31_7 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_7 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_13 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_13 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_13

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_13 and arg_28_1.time_ < var_31_6 + var_31_13 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play939031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939031008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_.story_grandmaaui_story
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_32_1.var_.characterEffectstory_grandmaaui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffectstory_grandmaaui_story then
				arg_32_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_35_4 = manager.ui.mainCamera.transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.shakeOldPos = var_35_4.localPosition
			end

			local var_35_6 = 0.6

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / 0.066
				local var_35_8, var_35_9 = math.modf(var_35_7)

				var_35_4.localPosition = Vector3.New(var_35_9 * 0.13, var_35_9 * 0.13, var_35_9 * 0.13) + arg_32_1.var_.shakeOldPos
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = arg_32_1.var_.shakeOldPos
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_11 = 0.6

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_12 = 0
			local var_35_13 = 0.075

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_14 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_14:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_15 = arg_32_1:FormatText(StoryNameCfg[1540].name)

				arg_32_1.leftNameTxt_.text = var_35_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_16 = arg_32_1:GetWordFromCfg(939031008)
				local var_35_17 = arg_32_1:FormatText(var_35_16.content)

				arg_32_1.text_.text = var_35_17

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_18 = 3
				local var_35_19 = utf8.len(var_35_17)
				local var_35_20 = var_35_18 <= 0 and var_35_13 or var_35_13 * (var_35_19 / var_35_18)

				if var_35_20 > 0 and var_35_13 < var_35_20 then
					arg_32_1.talkMaxDuration = var_35_20
					var_35_12 = var_35_12 + 0.3

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_17
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_21 = var_35_12 + 0.3
			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_21) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play939031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 939031009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play939031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_.story_grandmaaui_story
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_38_1.var_.characterEffectstory_grandmaaui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_38_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffectstory_grandmaaui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_38_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 1.325

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(939031009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 53
				local var_41_11 = utf8.len(var_41_9)
				local var_41_12 = var_41_10 <= 0 and var_41_7 or var_41_7 * (var_41_11 / var_41_10)

				if var_41_12 > 0 and var_41_7 < var_41_12 then
					arg_38_1.talkMaxDuration = var_41_12

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_13 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_13 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_13

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_13 and arg_38_1.time_ < var_41_6 + var_41_13 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play939031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 939031010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play939031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 0.4

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[36].name)

				arg_42_1.leftNameTxt_.text = var_45_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:GetWordFromCfg(939031010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 16
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play939031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 939031011
		arg_46_1.duration_ = 5.4

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play939031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_.story_grandmaaui_story
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_46_1.var_.characterEffectstory_grandmaaui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffectstory_grandmaaui_story then
				arg_46_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_49_4 = manager.ui.mainCamera.transform
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.var_.shakeOldPos = var_49_4.localPosition
			end

			local var_49_6 = 1

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / 0.066
				local var_49_8, var_49_9 = math.modf(var_49_7)

				var_49_4.localPosition = Vector3.New(var_49_9 * 0.13, var_49_9 * 0.13, var_49_9 * 0.13) + arg_46_1.var_.shakeOldPos
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				var_49_4.localPosition = arg_46_1.var_.shakeOldPos
			end

			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			local var_49_11 = 1

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_12 = 0.4
			local var_49_13 = 0.325

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_14 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_14:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_15 = arg_46_1:FormatText(StoryNameCfg[1540].name)

				arg_46_1.leftNameTxt_.text = var_49_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_16 = arg_46_1:GetWordFromCfg(939031011)
				local var_49_17 = arg_46_1:FormatText(var_49_16.content)

				arg_46_1.text_.text = var_49_17

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_18 = 13
				local var_49_19 = utf8.len(var_49_17)
				local var_49_20 = var_49_18 <= 0 and var_49_13 or var_49_13 * (var_49_19 / var_49_18)

				if var_49_20 > 0 and var_49_13 < var_49_20 then
					arg_46_1.talkMaxDuration = var_49_20
					var_49_12 = var_49_12 + 0.3

					if var_49_20 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_12
					end
				end

				arg_46_1.text_.text = var_49_17
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_21 = var_49_12 + 0.3
			local var_49_22 = math.max(var_49_13, arg_46_1.talkMaxDuration)

			if var_49_21 <= arg_46_1.time_ and arg_46_1.time_ < var_49_21 + var_49_22 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_21) / var_49_22

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_21 + var_49_22 and arg_46_1.time_ < var_49_21 + var_49_22 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play939031012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 939031012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play939031013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_.story_grandmaaui_story
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_52_1.var_.characterEffectstory_grandmaaui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffectstory_grandmaaui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_52_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffectstory_grandmaaui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_52_1.var_.characterEffectstory_grandmaaui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.35

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[36].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(939031012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 14
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play939031013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 939031013
		arg_56_1.duration_ = 6.4

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play939031014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "1211ui_story"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_56_1.stage_.transform)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

					var_59_3.enabled = true

					local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

					if var_59_4 then
						var_59_4:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_3.transform, false)

					arg_56_1.var_[var_59_0 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_0 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_0 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_5 = arg_56_1.actors_["1211ui_story"].transform
			local var_59_6 = 1.5

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.var_.moveOldPos1211ui_story = var_59_5.localPosition
			end

			local var_59_7 = 0.001

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_7 then
				local var_59_8 = (arg_56_1.time_ - var_59_6) / var_59_7
				local var_59_9 = Vector3.New(0, -0.67, -6.07)

				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1211ui_story, var_59_9, var_59_8)

				local var_59_10 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_10.x, var_59_10.y, var_59_10.z)

				local var_59_11 = var_59_5.localEulerAngles

				var_59_11.z = 0
				var_59_11.x = 0
				var_59_5.localEulerAngles = var_59_11
			end

			if arg_56_1.time_ >= var_59_6 + var_59_7 and arg_56_1.time_ < var_59_6 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, -0.67, -6.07)

				local var_59_12 = manager.ui.mainCamera.transform.position - var_59_5.position

				var_59_5.forward = Vector3.New(var_59_12.x, var_59_12.y, var_59_12.z)

				local var_59_13 = var_59_5.localEulerAngles

				var_59_13.z = 0
				var_59_13.x = 0
				var_59_5.localEulerAngles = var_59_13
			end

			local var_59_14 = arg_56_1.actors_["1211ui_story"]
			local var_59_15 = 1.5

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 and not isNil(var_59_14) and arg_56_1.var_.characterEffect1211ui_story == nil then
				arg_56_1.var_.characterEffect1211ui_story = var_59_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_16 = 0.200000002980232

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_16 and not isNil(var_59_14) then
				local var_59_17 = (arg_56_1.time_ - var_59_15) / var_59_16

				if arg_56_1.var_.characterEffect1211ui_story and not isNil(var_59_14) then
					arg_56_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_15 + var_59_16 and arg_56_1.time_ < var_59_15 + var_59_16 + arg_59_0 and not isNil(var_59_14) and arg_56_1.var_.characterEffect1211ui_story then
				arg_56_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_59_18 = 1.5

			if var_59_18 < arg_56_1.time_ and arg_56_1.time_ <= var_59_18 + arg_59_0 then
				arg_56_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_59_19 = 1.5

			if var_59_19 < arg_56_1.time_ and arg_56_1.time_ <= var_59_19 + arg_59_0 then
				arg_56_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_59_20 = manager.ui.mainCamera.transform
			local var_59_21 = 0

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				local var_59_22 = arg_56_1.var_.effectzhuanchang21314
				local var_59_23
				local var_59_24 = var_59_20

				if not var_59_22 then
					var_59_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_59_24)
					var_59_22.name = "zhuanchang21314"
					arg_56_1.var_.effectzhuanchang21314 = var_59_22
				else
					var_59_22.transform:SetParent(var_59_24)
				end

				var_59_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_25 = 1.4
			local var_59_26 = 0.65

			if var_59_25 < arg_56_1.time_ and arg_56_1.time_ <= var_59_25 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_27 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_27:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_28 = arg_56_1:FormatText(StoryNameCfg[37].name)

				arg_56_1.leftNameTxt_.text = var_59_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_29 = arg_56_1:GetWordFromCfg(939031013)
				local var_59_30 = arg_56_1:FormatText(var_59_29.content)

				arg_56_1.text_.text = var_59_30

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_31 = 26
				local var_59_32 = utf8.len(var_59_30)
				local var_59_33 = var_59_31 <= 0 and var_59_26 or var_59_26 * (var_59_32 / var_59_31)

				if var_59_33 > 0 and var_59_26 < var_59_33 then
					arg_56_1.talkMaxDuration = var_59_33
					var_59_25 = var_59_25 + 0.3

					if var_59_33 + var_59_25 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_33 + var_59_25
					end
				end

				arg_56_1.text_.text = var_59_30
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_34 = var_59_25 + 0.3
			local var_59_35 = math.max(var_59_26, arg_56_1.talkMaxDuration)

			if var_59_34 <= arg_56_1.time_ and arg_56_1.time_ < var_59_34 + var_59_35 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_34) / var_59_35

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_34 + var_59_35 and arg_56_1.time_ < var_59_34 + var_59_35 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play939031014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 939031014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play939031015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1211ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1211ui_story == nil then
				arg_62_1.var_.characterEffect1211ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1211ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1211ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1211ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1211ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.625

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[7].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(939031014)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 25
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_14 and arg_62_1.time_ < var_65_6 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play939031015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 939031015
		arg_66_1.duration_ = 6.8

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play939031016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.9

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				local var_69_1 = manager.ui.mainCamera.transform.localPosition
				local var_69_2 = Vector3.New(0, 0, 10) + Vector3.New(var_69_1.x, var_69_1.y, 0)
				local var_69_3 = arg_66_1.bgs_.ST04c

				var_69_3.transform.localPosition = var_69_2
				var_69_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_4 = var_69_3:GetComponent("SpriteRenderer")

				if var_69_4 and var_69_4.sprite then
					local var_69_5 = (var_69_3.transform.localPosition - var_69_1).z
					local var_69_6 = manager.ui.mainCameraCom_
					local var_69_7 = 2 * var_69_5 * Mathf.Tan(var_69_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_69_8 = var_69_7 * var_69_6.aspect
					local var_69_9 = var_69_4.sprite.bounds.size.x
					local var_69_10 = var_69_4.sprite.bounds.size.y
					local var_69_11 = var_69_8 / var_69_9
					local var_69_12 = var_69_7 / var_69_10
					local var_69_13 = var_69_12 < var_69_11 and var_69_11 or var_69_12

					var_69_3.transform.localScale = Vector3.New(var_69_13, var_69_13, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST04c" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_14 = 1.5

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_15 = 0.3

			if arg_66_1.time_ >= var_69_14 + var_69_15 and arg_66_1.time_ < var_69_14 + var_69_15 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_16 = arg_66_1.actors_["1211ui_story"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos1211ui_story = var_69_16.localPosition
			end

			local var_69_18 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_18 then
				local var_69_19 = (arg_66_1.time_ - var_69_17) / var_69_18
				local var_69_20 = Vector3.New(0, 100, 0)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1211ui_story, var_69_20, var_69_19)

				local var_69_21 = manager.ui.mainCamera.transform.position - var_69_16.position

				var_69_16.forward = Vector3.New(var_69_21.x, var_69_21.y, var_69_21.z)

				local var_69_22 = var_69_16.localEulerAngles

				var_69_22.z = 0
				var_69_22.x = 0
				var_69_16.localEulerAngles = var_69_22
			end

			if arg_66_1.time_ >= var_69_17 + var_69_18 and arg_66_1.time_ < var_69_17 + var_69_18 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(0, 100, 0)

				local var_69_23 = manager.ui.mainCamera.transform.position - var_69_16.position

				var_69_16.forward = Vector3.New(var_69_23.x, var_69_23.y, var_69_23.z)

				local var_69_24 = var_69_16.localEulerAngles

				var_69_24.z = 0
				var_69_24.x = 0
				var_69_16.localEulerAngles = var_69_24
			end

			local var_69_25 = "1054ui_story"

			if arg_66_1.actors_[var_69_25] == nil then
				local var_69_26 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_69_26) then
					local var_69_27 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_66_1.stage_.transform)

					var_69_27.name = var_69_25
					var_69_27.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_25] = var_69_27

					local var_69_28 = var_69_27:GetComponentInChildren(typeof(CharacterEffect))

					var_69_28.enabled = true

					local var_69_29 = GameObjectTools.GetOrAddComponent(var_69_27, typeof(DynamicBoneHelper))

					if var_69_29 then
						var_69_29:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_28.transform, false)

					arg_66_1.var_[var_69_25 .. "Animator"] = var_69_28.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_25 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_25 .. "LipSync"] = var_69_28.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_30 = arg_66_1.actors_["1054ui_story"].transform
			local var_69_31 = 1.5

			if var_69_31 < arg_66_1.time_ and arg_66_1.time_ <= var_69_31 + arg_69_0 then
				arg_66_1.var_.moveOldPos1054ui_story = var_69_30.localPosition

				local var_69_32 = GameObjectTools.GetOrAddComponent(var_69_30.gameObject, typeof(DynamicBoneHelper))

				if var_69_32 then
					var_69_32:EnableDynamicBone(false)
				end
			end

			local var_69_33 = 0.001

			if var_69_31 <= arg_66_1.time_ and arg_66_1.time_ < var_69_31 + var_69_33 then
				local var_69_34 = (arg_66_1.time_ - var_69_31) / var_69_33
				local var_69_35 = Vector3.New(-0.7, -0.985, -6)

				var_69_30.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1054ui_story, var_69_35, var_69_34)

				local var_69_36 = manager.ui.mainCamera.transform.position - var_69_30.position

				var_69_30.forward = Vector3.New(var_69_36.x, var_69_36.y, var_69_36.z)

				local var_69_37 = var_69_30.localEulerAngles

				var_69_37.z = 0
				var_69_37.x = 0
				var_69_30.localEulerAngles = var_69_37
			end

			if arg_66_1.time_ >= var_69_31 + var_69_33 and arg_66_1.time_ < var_69_31 + var_69_33 + arg_69_0 then
				var_69_30.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_69_38 = manager.ui.mainCamera.transform.position - var_69_30.position

				var_69_30.forward = Vector3.New(var_69_38.x, var_69_38.y, var_69_38.z)

				local var_69_39 = var_69_30.localEulerAngles

				var_69_39.z = 0
				var_69_39.x = 0
				var_69_30.localEulerAngles = var_69_39

				local var_69_40 = GameObjectTools.GetOrAddComponent(var_69_30.gameObject, typeof(DynamicBoneHelper))

				if var_69_40 then
					var_69_40:EnableDynamicBone(true)
				end
			end

			local var_69_41 = arg_66_1.actors_["1054ui_story"]
			local var_69_42 = 1.5

			if var_69_42 < arg_66_1.time_ and arg_66_1.time_ <= var_69_42 + arg_69_0 and not isNil(var_69_41) and arg_66_1.var_.characterEffect1054ui_story == nil then
				arg_66_1.var_.characterEffect1054ui_story = var_69_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_43 = 0.200000002980232

			if var_69_42 <= arg_66_1.time_ and arg_66_1.time_ < var_69_42 + var_69_43 and not isNil(var_69_41) then
				local var_69_44 = (arg_66_1.time_ - var_69_42) / var_69_43

				if arg_66_1.var_.characterEffect1054ui_story and not isNil(var_69_41) then
					arg_66_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_42 + var_69_43 and arg_66_1.time_ < var_69_42 + var_69_43 + arg_69_0 and not isNil(var_69_41) and arg_66_1.var_.characterEffect1054ui_story then
				arg_66_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_69_45 = 1.5

			if var_69_45 < arg_66_1.time_ and arg_66_1.time_ <= var_69_45 + arg_69_0 then
				arg_66_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_69_46 = 1.5

			if var_69_46 < arg_66_1.time_ and arg_66_1.time_ <= var_69_46 + arg_69_0 then
				arg_66_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_69_47 = manager.ui.mainCamera.transform
			local var_69_48 = 0

			if var_69_48 < arg_66_1.time_ and arg_66_1.time_ <= var_69_48 + arg_69_0 then
				local var_69_49 = arg_66_1.var_.effectzhuanchang21314
				local var_69_50
				local var_69_51 = var_69_47

				if not var_69_49 then
					var_69_49 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_69_51)
					var_69_49.name = "zhuanchang21314"
					arg_66_1.var_.effectzhuanchang21314 = var_69_49
				else
					var_69_49.transform:SetParent(var_69_51)
				end

				var_69_49.transform.localPosition = Vector3.New(0, 0, 0)
				var_69_49.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_52 = 1.8
			local var_69_53 = 0.2

			if var_69_52 < arg_66_1.time_ and arg_66_1.time_ <= var_69_52 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_54 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_54:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_55 = arg_66_1:FormatText(StoryNameCfg[1487].name)

				arg_66_1.leftNameTxt_.text = var_69_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_56 = arg_66_1:GetWordFromCfg(939031015)
				local var_69_57 = arg_66_1:FormatText(var_69_56.content)

				arg_66_1.text_.text = var_69_57

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_58 = 8
				local var_69_59 = utf8.len(var_69_57)
				local var_69_60 = var_69_58 <= 0 and var_69_53 or var_69_53 * (var_69_59 / var_69_58)

				if var_69_60 > 0 and var_69_53 < var_69_60 then
					arg_66_1.talkMaxDuration = var_69_60
					var_69_52 = var_69_52 + 0.3

					if var_69_60 + var_69_52 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_60 + var_69_52
					end
				end

				arg_66_1.text_.text = var_69_57
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_61 = var_69_52 + 0.3
			local var_69_62 = math.max(var_69_53, arg_66_1.talkMaxDuration)

			if var_69_61 <= arg_66_1.time_ and arg_66_1.time_ < var_69_61 + var_69_62 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_61) / var_69_62

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_61 + var_69_62 and arg_66_1.time_ < var_69_61 + var_69_62 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play939031016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 939031016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play939031017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = "6148ui_story"

			if arg_72_1.actors_[var_75_0] == nil then
				local var_75_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_75_1) then
					local var_75_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_72_1.stage_.transform)

					var_75_2.name = var_75_0
					var_75_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_0] = var_75_2

					local var_75_3 = var_75_2:GetComponentInChildren(typeof(CharacterEffect))

					var_75_3.enabled = true

					local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_2, typeof(DynamicBoneHelper))

					if var_75_4 then
						var_75_4:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_3.transform, false)

					arg_72_1.var_[var_75_0 .. "Animator"] = var_75_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_0 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_0 .. "LipSync"] = var_75_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_5 = arg_72_1.actors_["6148ui_story"].transform
			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = var_75_5.localPosition

				local var_75_7 = GameObjectTools.GetOrAddComponent(var_75_5.gameObject, typeof(DynamicBoneHelper))

				if var_75_7 then
					var_75_7:EnableDynamicBone(false)
				end
			end

			local var_75_8 = 0.001

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_8 then
				local var_75_9 = (arg_72_1.time_ - var_75_6) / var_75_8
				local var_75_10 = Vector3.New(0.7, -0.985, -6)

				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, var_75_10, var_75_9)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_5.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_5.localEulerAngles = var_75_12
			end

			if arg_72_1.time_ >= var_75_6 + var_75_8 and arg_72_1.time_ < var_75_6 + var_75_8 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_75_13 = manager.ui.mainCamera.transform.position - var_75_5.position

				var_75_5.forward = Vector3.New(var_75_13.x, var_75_13.y, var_75_13.z)

				local var_75_14 = var_75_5.localEulerAngles

				var_75_14.z = 0
				var_75_14.x = 0
				var_75_5.localEulerAngles = var_75_14

				local var_75_15 = GameObjectTools.GetOrAddComponent(var_75_5.gameObject, typeof(DynamicBoneHelper))

				if var_75_15 then
					var_75_15:EnableDynamicBone(true)
				end
			end

			local var_75_16 = arg_72_1.actors_["6148ui_story"]
			local var_75_17 = 0

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 and not isNil(var_75_16) and arg_72_1.var_.characterEffect6148ui_story == nil then
				arg_72_1.var_.characterEffect6148ui_story = var_75_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_18 = 0.200000002980232

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_18 and not isNil(var_75_16) then
				local var_75_19 = (arg_72_1.time_ - var_75_17) / var_75_18

				if arg_72_1.var_.characterEffect6148ui_story and not isNil(var_75_16) then
					arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_17 + var_75_18 and arg_72_1.time_ < var_75_17 + var_75_18 + arg_75_0 and not isNil(var_75_16) and arg_72_1.var_.characterEffect6148ui_story then
				arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_75_20 = arg_72_1.actors_["1054ui_story"]
			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_22 = 0.200000002980232

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 and not isNil(var_75_20) then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22

				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_20) then
					local var_75_24 = Mathf.Lerp(0, 0.5, var_75_23)

					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_24
				end
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1054ui_story then
				local var_75_25 = 0.5

				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_25
			end

			local var_75_26 = 0

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_75_27 = 0

			if var_75_27 < arg_72_1.time_ and arg_72_1.time_ <= var_75_27 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_75_28 = 0
			local var_75_29 = 0.2

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_30 = arg_72_1:FormatText(StoryNameCfg[1488].name)

				arg_72_1.leftNameTxt_.text = var_75_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_31 = arg_72_1:GetWordFromCfg(939031016)
				local var_75_32 = arg_72_1:FormatText(var_75_31.content)

				arg_72_1.text_.text = var_75_32

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_33 = 8
				local var_75_34 = utf8.len(var_75_32)
				local var_75_35 = var_75_33 <= 0 and var_75_29 or var_75_29 * (var_75_34 / var_75_33)

				if var_75_35 > 0 and var_75_29 < var_75_35 then
					arg_72_1.talkMaxDuration = var_75_35

					if var_75_35 + var_75_28 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_35 + var_75_28
					end
				end

				arg_72_1.text_.text = var_75_32
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_36 = math.max(var_75_29, arg_72_1.talkMaxDuration)

			if var_75_28 <= arg_72_1.time_ and arg_72_1.time_ < var_75_28 + var_75_36 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_28) / var_75_36

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_28 + var_75_36 and arg_72_1.time_ < var_75_28 + var_75_36 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play939031017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939031017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939031018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1054ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1054ui_story = var_79_0.localPosition

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(-0.7, -0.985, -6)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1054ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_79_8 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_8.x, var_79_8.y, var_79_8.z)

				local var_79_9 = var_79_0.localEulerAngles

				var_79_9.z = 0
				var_79_9.x = 0
				var_79_0.localEulerAngles = var_79_9

				local var_79_10 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_10 then
					var_79_10:EnableDynamicBone(true)
				end
			end

			local var_79_11 = arg_76_1.actors_["1054ui_story"]
			local var_79_12 = 0

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect1054ui_story == nil then
				arg_76_1.var_.characterEffect1054ui_story = var_79_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_13 = 0.200000002980232

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_13 and not isNil(var_79_11) then
				local var_79_14 = (arg_76_1.time_ - var_79_12) / var_79_13

				if arg_76_1.var_.characterEffect1054ui_story and not isNil(var_79_11) then
					arg_76_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_12 + var_79_13 and arg_76_1.time_ < var_79_12 + var_79_13 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect1054ui_story then
				arg_76_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_79_15 = arg_76_1.actors_["6148ui_story"]
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_17 = 0.200000002980232

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 and not isNil(var_79_15) then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17

				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_15) then
					local var_79_19 = Mathf.Lerp(0, 0.5, var_79_18)

					arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_19
				end
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 and not isNil(var_79_15) and arg_76_1.var_.characterEffect6148ui_story then
				local var_79_20 = 0.5

				arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_20
			end

			local var_79_21 = 0

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_79_22 = 0

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_79_23 = 0
			local var_79_24 = 0.4

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[1487].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(939031017)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 16
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_31 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_31 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_31

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_31 and arg_76_1.time_ < var_79_23 + var_79_31 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play939031018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939031018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939031019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = "1137ui_story"

			if arg_80_1.actors_[var_83_0] == nil then
				local var_83_1 = Asset.Load("Char/" .. "1137ui_story")

				if not isNil(var_83_1) then
					local var_83_2 = Object.Instantiate(Asset.Load("Char/" .. "1137ui_story"), arg_80_1.stage_.transform)

					var_83_2.name = var_83_0
					var_83_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_80_1.actors_[var_83_0] = var_83_2

					local var_83_3 = var_83_2:GetComponentInChildren(typeof(CharacterEffect))

					var_83_3.enabled = true

					local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_2, typeof(DynamicBoneHelper))

					if var_83_4 then
						var_83_4:EnableDynamicBone(false)
					end

					arg_80_1:ShowWeapon(var_83_3.transform, false)

					arg_80_1.var_[var_83_0 .. "Animator"] = var_83_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_80_1.var_[var_83_0 .. "Animator"].applyRootMotion = true
					arg_80_1.var_[var_83_0 .. "LipSync"] = var_83_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_83_5 = arg_80_1.actors_["1137ui_story"].transform
			local var_83_6 = 0

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.var_.moveOldPos1137ui_story = var_83_5.localPosition

				local var_83_7 = GameObjectTools.GetOrAddComponent(var_83_5.gameObject, typeof(DynamicBoneHelper))

				if var_83_7 then
					var_83_7:EnableDynamicBone(false)
				end
			end

			local var_83_8 = 0.001

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_8 then
				local var_83_9 = (arg_80_1.time_ - var_83_6) / var_83_8
				local var_83_10 = Vector3.New(0, -1.15, -5.7)

				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1137ui_story, var_83_10, var_83_9)

				local var_83_11 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_11.x, var_83_11.y, var_83_11.z)

				local var_83_12 = var_83_5.localEulerAngles

				var_83_12.z = 0
				var_83_12.x = 0
				var_83_5.localEulerAngles = var_83_12
			end

			if arg_80_1.time_ >= var_83_6 + var_83_8 and arg_80_1.time_ < var_83_6 + var_83_8 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(0, -1.15, -5.7)

				local var_83_13 = manager.ui.mainCamera.transform.position - var_83_5.position

				var_83_5.forward = Vector3.New(var_83_13.x, var_83_13.y, var_83_13.z)

				local var_83_14 = var_83_5.localEulerAngles

				var_83_14.z = 0
				var_83_14.x = 0
				var_83_5.localEulerAngles = var_83_14

				local var_83_15 = GameObjectTools.GetOrAddComponent(var_83_5.gameObject, typeof(DynamicBoneHelper))

				if var_83_15 then
					var_83_15:EnableDynamicBone(true)
				end
			end

			local var_83_16 = arg_80_1.actors_["1054ui_story"].transform
			local var_83_17 = 0

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.var_.moveOldPos1054ui_story = var_83_16.localPosition

				local var_83_18 = GameObjectTools.GetOrAddComponent(var_83_16.gameObject, typeof(DynamicBoneHelper))

				if var_83_18 then
					var_83_18:EnableDynamicBone(false)
				end
			end

			local var_83_19 = 0.001

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_19 then
				local var_83_20 = (arg_80_1.time_ - var_83_17) / var_83_19
				local var_83_21 = Vector3.New(0, 100, 0)

				var_83_16.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1054ui_story, var_83_21, var_83_20)

				local var_83_22 = manager.ui.mainCamera.transform.position - var_83_16.position

				var_83_16.forward = Vector3.New(var_83_22.x, var_83_22.y, var_83_22.z)

				local var_83_23 = var_83_16.localEulerAngles

				var_83_23.z = 0
				var_83_23.x = 0
				var_83_16.localEulerAngles = var_83_23
			end

			if arg_80_1.time_ >= var_83_17 + var_83_19 and arg_80_1.time_ < var_83_17 + var_83_19 + arg_83_0 then
				var_83_16.localPosition = Vector3.New(0, 100, 0)

				local var_83_24 = manager.ui.mainCamera.transform.position - var_83_16.position

				var_83_16.forward = Vector3.New(var_83_24.x, var_83_24.y, var_83_24.z)

				local var_83_25 = var_83_16.localEulerAngles

				var_83_25.z = 0
				var_83_25.x = 0
				var_83_16.localEulerAngles = var_83_25

				local var_83_26 = GameObjectTools.GetOrAddComponent(var_83_16.gameObject, typeof(DynamicBoneHelper))

				if var_83_26 then
					var_83_26:EnableDynamicBone(true)
				end
			end

			local var_83_27 = arg_80_1.actors_["6148ui_story"].transform
			local var_83_28 = 0

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1.var_.moveOldPos6148ui_story = var_83_27.localPosition

				local var_83_29 = GameObjectTools.GetOrAddComponent(var_83_27.gameObject, typeof(DynamicBoneHelper))

				if var_83_29 then
					var_83_29:EnableDynamicBone(false)
				end
			end

			local var_83_30 = 0.001

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_30 then
				local var_83_31 = (arg_80_1.time_ - var_83_28) / var_83_30
				local var_83_32 = Vector3.New(0, 100, 0)

				var_83_27.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos6148ui_story, var_83_32, var_83_31)

				local var_83_33 = manager.ui.mainCamera.transform.position - var_83_27.position

				var_83_27.forward = Vector3.New(var_83_33.x, var_83_33.y, var_83_33.z)

				local var_83_34 = var_83_27.localEulerAngles

				var_83_34.z = 0
				var_83_34.x = 0
				var_83_27.localEulerAngles = var_83_34
			end

			if arg_80_1.time_ >= var_83_28 + var_83_30 and arg_80_1.time_ < var_83_28 + var_83_30 + arg_83_0 then
				var_83_27.localPosition = Vector3.New(0, 100, 0)

				local var_83_35 = manager.ui.mainCamera.transform.position - var_83_27.position

				var_83_27.forward = Vector3.New(var_83_35.x, var_83_35.y, var_83_35.z)

				local var_83_36 = var_83_27.localEulerAngles

				var_83_36.z = 0
				var_83_36.x = 0
				var_83_27.localEulerAngles = var_83_36

				local var_83_37 = GameObjectTools.GetOrAddComponent(var_83_27.gameObject, typeof(DynamicBoneHelper))

				if var_83_37 then
					var_83_37:EnableDynamicBone(true)
				end
			end

			local var_83_38 = arg_80_1.actors_["1137ui_story"]
			local var_83_39 = 0

			if var_83_39 < arg_80_1.time_ and arg_80_1.time_ <= var_83_39 + arg_83_0 and not isNil(var_83_38) and arg_80_1.var_.characterEffect1137ui_story == nil then
				arg_80_1.var_.characterEffect1137ui_story = var_83_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_40 = 0.200000002980232

			if var_83_39 <= arg_80_1.time_ and arg_80_1.time_ < var_83_39 + var_83_40 and not isNil(var_83_38) then
				local var_83_41 = (arg_80_1.time_ - var_83_39) / var_83_40

				if arg_80_1.var_.characterEffect1137ui_story and not isNil(var_83_38) then
					arg_80_1.var_.characterEffect1137ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_39 + var_83_40 and arg_80_1.time_ < var_83_39 + var_83_40 + arg_83_0 and not isNil(var_83_38) and arg_80_1.var_.characterEffect1137ui_story then
				arg_80_1.var_.characterEffect1137ui_story.fillFlat = false
			end

			local var_83_42 = arg_80_1.actors_["1054ui_story"]
			local var_83_43 = 0

			if var_83_43 < arg_80_1.time_ and arg_80_1.time_ <= var_83_43 + arg_83_0 and not isNil(var_83_42) and arg_80_1.var_.characterEffect1054ui_story == nil then
				arg_80_1.var_.characterEffect1054ui_story = var_83_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_44 = 0.200000002980232

			if var_83_43 <= arg_80_1.time_ and arg_80_1.time_ < var_83_43 + var_83_44 and not isNil(var_83_42) then
				local var_83_45 = (arg_80_1.time_ - var_83_43) / var_83_44

				if arg_80_1.var_.characterEffect1054ui_story and not isNil(var_83_42) then
					local var_83_46 = Mathf.Lerp(0, 0.5, var_83_45)

					arg_80_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1054ui_story.fillRatio = var_83_46
				end
			end

			if arg_80_1.time_ >= var_83_43 + var_83_44 and arg_80_1.time_ < var_83_43 + var_83_44 + arg_83_0 and not isNil(var_83_42) and arg_80_1.var_.characterEffect1054ui_story then
				local var_83_47 = 0.5

				arg_80_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1054ui_story.fillRatio = var_83_47
			end

			local var_83_48 = 0

			if var_83_48 < arg_80_1.time_ and arg_80_1.time_ <= var_83_48 + arg_83_0 then
				arg_80_1:PlayTimeline("1137ui_story", "StoryTimeline/CharAction/story1137/story1137action/1137action3_1")
			end

			local var_83_49 = 0

			if var_83_49 < arg_80_1.time_ and arg_80_1.time_ <= var_83_49 + arg_83_0 then
				arg_80_1:PlayTimeline("1137ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_83_50 = 0
			local var_83_51 = 0.225

			if var_83_50 < arg_80_1.time_ and arg_80_1.time_ <= var_83_50 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_52 = arg_80_1:FormatText(StoryNameCfg[15].name)

				arg_80_1.leftNameTxt_.text = var_83_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_53 = arg_80_1:GetWordFromCfg(939031018)
				local var_83_54 = arg_80_1:FormatText(var_83_53.content)

				arg_80_1.text_.text = var_83_54

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_55 = 9
				local var_83_56 = utf8.len(var_83_54)
				local var_83_57 = var_83_55 <= 0 and var_83_51 or var_83_51 * (var_83_56 / var_83_55)

				if var_83_57 > 0 and var_83_51 < var_83_57 then
					arg_80_1.talkMaxDuration = var_83_57

					if var_83_57 + var_83_50 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_57 + var_83_50
					end
				end

				arg_80_1.text_.text = var_83_54
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_58 = math.max(var_83_51, arg_80_1.talkMaxDuration)

			if var_83_50 <= arg_80_1.time_ and arg_80_1.time_ < var_83_50 + var_83_58 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_50) / var_83_58

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_50 + var_83_58 and arg_80_1.time_ < var_83_50 + var_83_58 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play939031019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939031019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939031020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1137ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1137ui_story = var_87_0.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_3 then
				local var_87_4 = (arg_84_1.time_ - var_87_1) / var_87_3
				local var_87_5 = Vector3.New(0, 100, 0)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1137ui_story, var_87_5, var_87_4)

				local var_87_6 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_6.x, var_87_6.y, var_87_6.z)

				local var_87_7 = var_87_0.localEulerAngles

				var_87_7.z = 0
				var_87_7.x = 0
				var_87_0.localEulerAngles = var_87_7
			end

			if arg_84_1.time_ >= var_87_1 + var_87_3 and arg_84_1.time_ < var_87_1 + var_87_3 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, 100, 0)

				local var_87_8 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_8.x, var_87_8.y, var_87_8.z)

				local var_87_9 = var_87_0.localEulerAngles

				var_87_9.z = 0
				var_87_9.x = 0
				var_87_0.localEulerAngles = var_87_9

				local var_87_10 = GameObjectTools.GetOrAddComponent(var_87_0.gameObject, typeof(DynamicBoneHelper))

				if var_87_10 then
					var_87_10:EnableDynamicBone(true)
				end
			end

			local var_87_11 = arg_84_1.actors_["1137ui_story"]
			local var_87_12 = 0

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1137ui_story == nil then
				arg_84_1.var_.characterEffect1137ui_story = var_87_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_13 = 0.200000002980232

			if var_87_12 <= arg_84_1.time_ and arg_84_1.time_ < var_87_12 + var_87_13 and not isNil(var_87_11) then
				local var_87_14 = (arg_84_1.time_ - var_87_12) / var_87_13

				if arg_84_1.var_.characterEffect1137ui_story and not isNil(var_87_11) then
					local var_87_15 = Mathf.Lerp(0, 0.5, var_87_14)

					arg_84_1.var_.characterEffect1137ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1137ui_story.fillRatio = var_87_15
				end
			end

			if arg_84_1.time_ >= var_87_12 + var_87_13 and arg_84_1.time_ < var_87_12 + var_87_13 + arg_87_0 and not isNil(var_87_11) and arg_84_1.var_.characterEffect1137ui_story then
				local var_87_16 = 0.5

				arg_84_1.var_.characterEffect1137ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1137ui_story.fillRatio = var_87_16
			end

			local var_87_17 = 0
			local var_87_18 = 0.925

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_19 = arg_84_1:GetWordFromCfg(939031019)
				local var_87_20 = arg_84_1:FormatText(var_87_19.content)

				arg_84_1.text_.text = var_87_20

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_21 = 37
				local var_87_22 = utf8.len(var_87_20)
				local var_87_23 = var_87_21 <= 0 and var_87_18 or var_87_18 * (var_87_22 / var_87_21)

				if var_87_23 > 0 and var_87_18 < var_87_23 then
					arg_84_1.talkMaxDuration = var_87_23

					if var_87_23 + var_87_17 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_17
					end
				end

				arg_84_1.text_.text = var_87_20
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_24 = math.max(var_87_18, arg_84_1.talkMaxDuration)

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_24 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_17) / var_87_24

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_17 + var_87_24 and arg_84_1.time_ < var_87_17 + var_87_24 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play939031020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939031020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939031021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.35

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[1541].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(939031020)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 14
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play939031021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939031021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play939031022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1.05

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[8].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_92_1.callingController_:SetSelectedState("calling")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(939031021)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 42
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play939031022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 939031022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play939031023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = "1248ui_story"

			if arg_96_1.actors_[var_99_0] == nil then
				local var_99_1 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_99_1) then
					local var_99_2 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_96_1.stage_.transform)

					var_99_2.name = var_99_0
					var_99_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_96_1.actors_[var_99_0] = var_99_2

					local var_99_3 = var_99_2:GetComponentInChildren(typeof(CharacterEffect))

					var_99_3.enabled = true

					local var_99_4 = GameObjectTools.GetOrAddComponent(var_99_2, typeof(DynamicBoneHelper))

					if var_99_4 then
						var_99_4:EnableDynamicBone(false)
					end

					arg_96_1:ShowWeapon(var_99_3.transform, false)

					arg_96_1.var_[var_99_0 .. "Animator"] = var_99_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_96_1.var_[var_99_0 .. "Animator"].applyRootMotion = true
					arg_96_1.var_[var_99_0 .. "LipSync"] = var_99_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_99_5 = arg_96_1.actors_["1248ui_story"]
			local var_99_6 = 0

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1248ui_story == nil then
				arg_96_1.var_.characterEffect1248ui_story = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.200000002980232

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_7 and not isNil(var_99_5) then
				local var_99_8 = (arg_96_1.time_ - var_99_6) / var_99_7

				if arg_96_1.var_.characterEffect1248ui_story and not isNil(var_99_5) then
					local var_99_9 = Mathf.Lerp(0, 0.5, var_99_8)

					arg_96_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1248ui_story.fillRatio = var_99_9
				end
			end

			if arg_96_1.time_ >= var_99_6 + var_99_7 and arg_96_1.time_ < var_99_6 + var_99_7 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1248ui_story then
				local var_99_10 = 0.5

				arg_96_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1248ui_story.fillRatio = var_99_10
			end

			local var_99_11 = 0
			local var_99_12 = 0.475

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_13 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_14 = arg_96_1:GetWordFromCfg(939031022)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 19
				local var_99_17 = utf8.len(var_99_15)
				local var_99_18 = var_99_16 <= 0 and var_99_12 or var_99_12 * (var_99_17 / var_99_16)

				if var_99_18 > 0 and var_99_12 < var_99_18 then
					arg_96_1.talkMaxDuration = var_99_18

					if var_99_18 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_11
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_19 = math.max(var_99_12, arg_96_1.talkMaxDuration)

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_19 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_11) / var_99_19

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_11 + var_99_19 and arg_96_1.time_ < var_99_11 + var_99_19 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play939031023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939031023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939031024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1248ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1248ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, 100, 0)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1248ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, 100, 0)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1054ui_story"].transform
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.var_.moveOldPos1054ui_story = var_103_9.localPosition

				local var_103_11 = GameObjectTools.GetOrAddComponent(var_103_9.gameObject, typeof(DynamicBoneHelper))

				if var_103_11 then
					var_103_11:EnableDynamicBone(false)
				end
			end

			local var_103_12 = 0.001

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_10) / var_103_12
				local var_103_14 = Vector3.New(-0.7, -0.985, -6)

				var_103_9.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1054ui_story, var_103_14, var_103_13)

				local var_103_15 = manager.ui.mainCamera.transform.position - var_103_9.position

				var_103_9.forward = Vector3.New(var_103_15.x, var_103_15.y, var_103_15.z)

				local var_103_16 = var_103_9.localEulerAngles

				var_103_16.z = 0
				var_103_16.x = 0
				var_103_9.localEulerAngles = var_103_16
			end

			if arg_100_1.time_ >= var_103_10 + var_103_12 and arg_100_1.time_ < var_103_10 + var_103_12 + arg_103_0 then
				var_103_9.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_103_17 = manager.ui.mainCamera.transform.position - var_103_9.position

				var_103_9.forward = Vector3.New(var_103_17.x, var_103_17.y, var_103_17.z)

				local var_103_18 = var_103_9.localEulerAngles

				var_103_18.z = 0
				var_103_18.x = 0
				var_103_9.localEulerAngles = var_103_18

				local var_103_19 = GameObjectTools.GetOrAddComponent(var_103_9.gameObject, typeof(DynamicBoneHelper))

				if var_103_19 then
					var_103_19:EnableDynamicBone(true)
				end
			end

			local var_103_20 = arg_100_1.actors_["1054ui_story"]
			local var_103_21 = 0

			if var_103_21 < arg_100_1.time_ and arg_100_1.time_ <= var_103_21 + arg_103_0 and not isNil(var_103_20) and arg_100_1.var_.characterEffect1054ui_story == nil then
				arg_100_1.var_.characterEffect1054ui_story = var_103_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_22 = 0.200000002980232

			if var_103_21 <= arg_100_1.time_ and arg_100_1.time_ < var_103_21 + var_103_22 and not isNil(var_103_20) then
				local var_103_23 = (arg_100_1.time_ - var_103_21) / var_103_22

				if arg_100_1.var_.characterEffect1054ui_story and not isNil(var_103_20) then
					arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_21 + var_103_22 and arg_100_1.time_ < var_103_21 + var_103_22 + arg_103_0 and not isNil(var_103_20) and arg_100_1.var_.characterEffect1054ui_story then
				arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_103_24 = 0

			if var_103_24 < arg_100_1.time_ and arg_100_1.time_ <= var_103_24 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_103_25 = 0

			if var_103_25 < arg_100_1.time_ and arg_100_1.time_ <= var_103_25 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_103_26 = 0
			local var_103_27 = 0.2

			if var_103_26 < arg_100_1.time_ and arg_100_1.time_ <= var_103_26 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_28 = arg_100_1:FormatText(StoryNameCfg[1487].name)

				arg_100_1.leftNameTxt_.text = var_103_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_29 = arg_100_1:GetWordFromCfg(939031023)
				local var_103_30 = arg_100_1:FormatText(var_103_29.content)

				arg_100_1.text_.text = var_103_30

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_31 = 8
				local var_103_32 = utf8.len(var_103_30)
				local var_103_33 = var_103_31 <= 0 and var_103_27 or var_103_27 * (var_103_32 / var_103_31)

				if var_103_33 > 0 and var_103_27 < var_103_33 then
					arg_100_1.talkMaxDuration = var_103_33

					if var_103_33 + var_103_26 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_33 + var_103_26
					end
				end

				arg_100_1.text_.text = var_103_30
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_34 = math.max(var_103_27, arg_100_1.talkMaxDuration)

			if var_103_26 <= arg_100_1.time_ and arg_100_1.time_ < var_103_26 + var_103_34 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_26) / var_103_34

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_26 + var_103_34 and arg_100_1.time_ < var_103_26 + var_103_34 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play939031024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939031024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
			arg_104_1.auto_ = false
		end

		function arg_104_1.playNext_(arg_106_0)
			arg_104_1.onStoryFinished_()
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["6148ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos6148ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0.7, -0.985, -6)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos6148ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["6148ui_story"]
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect6148ui_story == nil then
				arg_104_1.var_.characterEffect6148ui_story = var_107_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_13 = 0.200000002980232

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 and not isNil(var_107_11) then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13

				if arg_104_1.var_.characterEffect6148ui_story and not isNil(var_107_11) then
					arg_104_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect6148ui_story then
				arg_104_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_107_15 = arg_104_1.actors_["1054ui_story"]
			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 and not isNil(var_107_15) and arg_104_1.var_.characterEffect1054ui_story == nil then
				arg_104_1.var_.characterEffect1054ui_story = var_107_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_17 = 0.200000002980232

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 and not isNil(var_107_15) then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17

				if arg_104_1.var_.characterEffect1054ui_story and not isNil(var_107_15) then
					local var_107_19 = Mathf.Lerp(0, 0.5, var_107_18)

					arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1054ui_story.fillRatio = var_107_19
				end
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 and not isNil(var_107_15) and arg_104_1.var_.characterEffect1054ui_story then
				local var_107_20 = 0.5

				arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1054ui_story.fillRatio = var_107_20
			end

			local var_107_21 = 0

			if var_107_21 < arg_104_1.time_ and arg_104_1.time_ <= var_107_21 + arg_107_0 then
				arg_104_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_107_22 = 0

			if var_107_22 < arg_104_1.time_ and arg_104_1.time_ <= var_107_22 + arg_107_0 then
				arg_104_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_107_23 = 0
			local var_107_24 = 0.25

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_25 = arg_104_1:FormatText(StoryNameCfg[1488].name)

				arg_104_1.leftNameTxt_.text = var_107_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_26 = arg_104_1:GetWordFromCfg(939031024)
				local var_107_27 = arg_104_1:FormatText(var_107_26.content)

				arg_104_1.text_.text = var_107_27

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_28 = 10
				local var_107_29 = utf8.len(var_107_27)
				local var_107_30 = var_107_28 <= 0 and var_107_24 or var_107_24 * (var_107_29 / var_107_28)

				if var_107_30 > 0 and var_107_24 < var_107_30 then
					arg_104_1.talkMaxDuration = var_107_30

					if var_107_30 + var_107_23 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_30 + var_107_23
					end
				end

				arg_104_1.text_.text = var_107_27
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_31 = math.max(var_107_24, arg_104_1.talkMaxDuration)

			if var_107_23 <= arg_104_1.time_ and arg_104_1.time_ < var_107_23 + var_107_31 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_23) / var_107_31

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_23 + var_107_31 and arg_104_1.time_ < var_107_23 + var_107_31 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST04c"
	},
	voices = {},
	skipMarkers = {
		939031001
	}
}
