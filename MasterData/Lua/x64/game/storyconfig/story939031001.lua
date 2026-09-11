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
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.marker = "luntantiezi9998"
				arg_1_1.actionList["1"] = arg_1_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

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
			if arg_6_1.bgs_.ST04c == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST04c")
				var_9_0.name = "ST04c"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.ST04c = var_9_0
			end

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= 2 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.ST04c

				arg_6_1.bgs_.ST04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST04c" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 4

			if 4 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_4 + 0.3 and arg_6_1.time_ < var_9_4 + 0.3 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_5 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_6 = 2

			if var_9_5 <= arg_6_1.time_ and arg_6_1.time_ < var_9_5 + var_9_6 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = Mathf.Lerp(0, 1, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				var_9_8.a = 1
				arg_6_1.mask_.color = var_9_8
			end

			local var_9_9 = 2

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_9 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_10 = 2

			if var_9_9 <= arg_6_1.time_ and arg_6_1.time_ < var_9_9 + var_9_10 then
				local var_9_11 = Color.New(0, 0, 0)

				var_9_11.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_9) / var_9_10)
				arg_6_1.mask_.color = var_9_11
			end

			if arg_6_1.time_ >= var_9_9 + var_9_10 and arg_6_1.time_ < var_9_9 + var_9_10 + arg_9_0 then
				local var_9_12 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_12.a = 0
				arg_6_1.mask_.color = var_9_12
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_13 = 4
			local var_9_14 = 1

			if 4 < arg_6_1.time_ and arg_6_1.time_ <= var_9_13 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_15 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_15:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_16 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(939031002).content)

				arg_6_1.text_.text = var_9_16

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_18 = 40 <= 0 and var_9_14 or var_9_14 * (utf8.len(var_9_16) / 40)

				if (40 <= 0 and var_9_14 or var_9_14 * (utf8.len(var_9_16) / 40)) > 0 and var_9_14 < var_9_18 then
					arg_6_1.talkMaxDuration = var_9_18
					var_9_13 = var_9_13 + 0.3

					if var_9_18 + var_9_13 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_18 + var_9_13
					end
				end

				arg_6_1.text_.text = var_9_16
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_19 = var_9_13 + 0.3
			local var_9_20 = math.max(var_9_14, arg_6_1.talkMaxDuration)

			if var_9_13 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_19 + var_9_20 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_19) / var_9_20

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_19 + var_9_20 and arg_6_1.time_ < var_9_19 + var_9_20 + arg_9_0 then
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
			local var_15_0 = 0.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[36].name)

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(939031003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 10 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 10)

				if (10 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 10)) > 0 and var_15_0 < var_15_3 then
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
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_.story_grandmaaui_story) and arg_16_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_16_1.var_.characterEffectstory_grandmaaui_story = arg_16_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_.story_grandmaaui_story) then
				if arg_16_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_16_1.actors_.story_grandmaaui_story) then
					arg_16_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_.story_grandmaaui_story) and arg_16_1.var_.characterEffectstory_grandmaaui_story then
				arg_16_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_19_2 = 0
			local var_19_3 = 0.525

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1540].name)

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

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(939031004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 21 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 21)

				if (21 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 21)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
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
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_.story_grandmaaui_story) and arg_20_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_20_1.var_.characterEffectstory_grandmaaui_story = arg_20_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_.story_grandmaaui_story) then
				if arg_20_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_20_1.actors_.story_grandmaaui_story) then
					arg_20_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_20_1.var_.characterEffectstory_grandmaaui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_.story_grandmaaui_story) and arg_20_1.var_.characterEffectstory_grandmaaui_story then
				arg_20_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_20_1.var_.characterEffectstory_grandmaaui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[36].name)

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

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(939031005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 13 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 13)

				if (13 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 13)) > 0 and var_23_2 < var_23_5 then
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
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_.story_grandmaaui_story) and arg_24_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_24_1.var_.characterEffectstory_grandmaaui_story = arg_24_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_.story_grandmaaui_story) then
				if arg_24_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_24_1.actors_.story_grandmaaui_story) then
					arg_24_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_.story_grandmaaui_story) and arg_24_1.var_.characterEffectstory_grandmaaui_story then
				arg_24_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_27_2 = 0
			local var_27_3 = 0.7

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1540].name)

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

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(939031006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 28 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 28)

				if (28 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 28)) > 0 and var_27_3 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_7 and arg_24_1.time_ < var_27_2 + var_27_7 + arg_27_0 then
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
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_.story_grandmaaui_story) and arg_28_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_28_1.var_.characterEffectstory_grandmaaui_story = arg_28_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_.story_grandmaaui_story) then
				if arg_28_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_28_1.actors_.story_grandmaaui_story) then
					arg_28_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_28_1.var_.characterEffectstory_grandmaaui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_.story_grandmaaui_story) and arg_28_1.var_.characterEffectstory_grandmaaui_story then
				arg_28_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_28_1.var_.characterEffectstory_grandmaaui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.7

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(939031007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 28 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 28)

				if (28 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 28)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
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
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_.story_grandmaaui_story) and arg_32_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_32_1.var_.characterEffectstory_grandmaaui_story = arg_32_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_.story_grandmaaui_story) then
				if arg_32_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_32_1.actors_.story_grandmaaui_story) then
					arg_32_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_.story_grandmaaui_story) and arg_32_1.var_.characterEffectstory_grandmaaui_story then
				arg_32_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_35_2 = manager.ui.mainCamera.transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.shakeOldPos = var_35_2.localPosition
			end

			local var_35_3 = 0.6

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				local var_35_4, var_35_5 = math.modf((arg_32_1.time_ - 0) / 0.066)

				var_35_2.localPosition = Vector3.New(var_35_5 * 0.13, var_35_5 * 0.13, var_35_5 * 0.13) + arg_32_1.var_.shakeOldPos
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_2.localPosition = arg_32_1.var_.shakeOldPos
			end

			local var_35_6 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_6 + 0.6 and arg_32_1.time_ < var_35_6 + 0.6 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_7 = 0
			local var_35_8 = 0.075

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_9 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_9:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1540].name)

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

				local var_35_10 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(939031008).content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 3 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 3)

				if (3 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 3)) > 0 and var_35_8 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12
					var_35_7 = var_35_7 + 0.3

					if var_35_12 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_13 = var_35_7 + 0.3
			local var_35_14 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_7 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_13 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_13) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_13 + var_35_14 and arg_32_1.time_ < var_35_13 + var_35_14 + arg_35_0 then
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
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_.story_grandmaaui_story) and arg_38_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_38_1.var_.characterEffectstory_grandmaaui_story = arg_38_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_.story_grandmaaui_story) then
				if arg_38_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_38_1.actors_.story_grandmaaui_story) then
					arg_38_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_38_1.var_.characterEffectstory_grandmaaui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_.story_grandmaaui_story) and arg_38_1.var_.characterEffectstory_grandmaaui_story then
				arg_38_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_38_1.var_.characterEffectstory_grandmaaui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 1.325

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(939031009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 53 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 53)

				if (53 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 53)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
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
			local var_45_0 = 0.4

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[36].name)

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

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(939031010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 16 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 16)

				if (16 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 16)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
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
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_.story_grandmaaui_story) and arg_46_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_46_1.var_.characterEffectstory_grandmaaui_story = arg_46_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_.story_grandmaaui_story) then
				if arg_46_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_46_1.actors_.story_grandmaaui_story) then
					arg_46_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_.story_grandmaaui_story) and arg_46_1.var_.characterEffectstory_grandmaaui_story then
				arg_46_1.var_.characterEffectstory_grandmaaui_story.fillFlat = false
			end

			local var_49_2 = manager.ui.mainCamera.transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.shakeOldPos = var_49_2.localPosition
			end

			local var_49_3 = 1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 then
				local var_49_4, var_49_5 = math.modf((arg_46_1.time_ - 0) / 0.066)

				var_49_2.localPosition = Vector3.New(var_49_5 * 0.13, var_49_5 * 0.13, var_49_5 * 0.13) + arg_46_1.var_.shakeOldPos
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 then
				var_49_2.localPosition = arg_46_1.var_.shakeOldPos
			end

			local var_49_6 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			if arg_46_1.time_ >= var_49_6 + 1 and arg_46_1.time_ < var_49_6 + 1 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_7 = 0.4
			local var_49_8 = 0.325

			if 0.4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_7 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_9 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_9:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1540].name)

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

				local var_49_10 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(939031011).content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_12 = 13 <= 0 and var_49_8 or var_49_8 * (utf8.len(var_49_10) / 13)

				if (13 <= 0 and var_49_8 or var_49_8 * (utf8.len(var_49_10) / 13)) > 0 and var_49_8 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12
					var_49_7 = var_49_7 + 0.3

					if var_49_12 + var_49_7 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_7
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = var_49_7 + 0.3
			local var_49_14 = math.max(var_49_8, arg_46_1.talkMaxDuration)

			if var_49_7 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_13 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_13) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_13 + var_49_14 and arg_46_1.time_ < var_49_13 + var_49_14 + arg_49_0 then
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
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_.story_grandmaaui_story) and arg_52_1.var_.characterEffectstory_grandmaaui_story == nil then
				arg_52_1.var_.characterEffectstory_grandmaaui_story = arg_52_1.actors_.story_grandmaaui_story:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_.story_grandmaaui_story) then
				if arg_52_1.var_.characterEffectstory_grandmaaui_story and not isNil(arg_52_1.actors_.story_grandmaaui_story) then
					arg_52_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
					arg_52_1.var_.characterEffectstory_grandmaaui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_.story_grandmaaui_story) and arg_52_1.var_.characterEffectstory_grandmaaui_story then
				arg_52_1.var_.characterEffectstory_grandmaaui_story.fillFlat = true
				arg_52_1.var_.characterEffectstory_grandmaaui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.35

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[36].name)

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

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(939031012).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 14 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 14)

				if (14 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 14)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
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
			local var_59_9000

			if arg_56_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_59_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_56_1.stage_.transform)

				var_59_0.name = "1211ui_story"
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1211ui_story"] = var_59_0

				local var_59_1 = var_59_0:GetComponentInChildren(typeof(CharacterEffect))

				var_59_1.enabled = true

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_0, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_1.transform, false)

				arg_56_1.var_["1211ui_story" .. "Animator"] = var_59_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_56_1.var_["1211ui_story" .. "LipSync"] = var_59_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_3 = arg_56_1.actors_["1211ui_story"].transform

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1.var_.moveOldPos1211ui_story = var_59_3.localPosition
			end

			local var_59_4 = 0.001

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_4 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_56_1.time_ - 1.5) / var_59_4)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 1.5 + var_59_4 and arg_56_1.time_ < 1.5 + var_59_4 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, -0.67, -6.07)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			local var_59_5 = arg_56_1.actors_["1211ui_story"]

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1211ui_story == nil then
				arg_56_1.var_.characterEffect1211ui_story = var_59_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.200000002980232

			if 1.5 <= arg_56_1.time_ and arg_56_1.time_ < 1.5 + var_59_6 and not isNil(var_59_5) then
				if arg_56_1.var_.characterEffect1211ui_story and not isNil(var_59_5) then
					arg_56_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 1.5 + var_59_6 and arg_56_1.time_ < 1.5 + var_59_6 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1211ui_story then
				arg_56_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 1.5 < arg_56_1.time_ and arg_56_1.time_ <= 1.5 + arg_59_0 then
				arg_56_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_8 = arg_56_1.var_.effectzhuanchang21314

				if not arg_56_1.var_.effectzhuanchang21314 then
					var_59_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_59_8.name = "zhuanchang21314"
					arg_56_1.var_.effectzhuanchang21314 = var_59_8
				else
					var_59_8.transform:SetParent(var_59_9000)
				end

				var_59_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_10 = 1.4
			local var_59_11 = 0.65

			if 1.4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_12 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_12:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_13 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(939031013).content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 26 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 26)

				if (26 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 26)) > 0 and var_59_11 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15
					var_59_10 = var_59_10 + 0.3

					if var_59_15 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = var_59_10 + 0.3
			local var_59_17 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_17 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_17

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_17 and arg_56_1.time_ < var_59_16 + var_59_17 + arg_59_0 then
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
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1211ui_story"]) and arg_62_1.var_.characterEffect1211ui_story == nil then
				arg_62_1.var_.characterEffect1211ui_story = arg_62_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1211ui_story"]) then
				if arg_62_1.var_.characterEffect1211ui_story and not isNil(arg_62_1.actors_["1211ui_story"]) then
					arg_62_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1211ui_story"]) and arg_62_1.var_.characterEffect1211ui_story then
				arg_62_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.625

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

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

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(939031014).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 25 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 25)

				if (25 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 25)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
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
			local var_69_9000

			if 0.9 < arg_66_1.time_ and arg_66_1.time_ <= 0.9 + arg_69_0 then
				local var_69_0 = arg_66_1.bgs_.ST04c

				arg_66_1.bgs_.ST04c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_1 = var_69_0:GetComponent("SpriteRenderer")

				if var_69_1 and var_69_1.sprite then
					local var_69_2 = 2 * (var_69_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_0.transform.localScale = Vector3.New(var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, var_69_2 / var_69_1.sprite.bounds.size.y < var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x and var_69_2 * manager.ui.mainCameraCom_.aspect / var_69_1.sprite.bounds.size.x or var_69_2 / var_69_1.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST04c" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_3 = 1.5

			if 1.5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_3 + 0.3 and arg_66_1.time_ < var_69_3 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_4 = arg_66_1.actors_["1211ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1211ui_story = var_69_4.localPosition
			end

			local var_69_5 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_5 then
				var_69_4.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_5)
				var_69_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_4.position).x, (manager.ui.mainCamera.transform.position - var_69_4.position).y, (manager.ui.mainCamera.transform.position - var_69_4.position).z)
				var_69_4.localEulerAngles.z = 0
				var_69_4.localEulerAngles.x = 0
				var_69_4.localEulerAngles = var_69_4.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_5 and arg_66_1.time_ < 0 + var_69_5 + arg_69_0 then
				var_69_4.localPosition = Vector3.New(0, 100, 0)
				var_69_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_4.position).x, (manager.ui.mainCamera.transform.position - var_69_4.position).y, (manager.ui.mainCamera.transform.position - var_69_4.position).z)
				var_69_4.localEulerAngles.z = 0
				var_69_4.localEulerAngles.x = 0
				var_69_4.localEulerAngles = var_69_4.localEulerAngles
			end

			local var_69_6 = "1054ui_story"

			if arg_66_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_69_7 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_66_1.stage_.transform)

				var_69_7.name = var_69_6
				var_69_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_[var_69_6] = var_69_7

				local var_69_8 = var_69_7:GetComponentInChildren(typeof(CharacterEffect))

				var_69_8.enabled = true

				local var_69_9 = GameObjectTools.GetOrAddComponent(var_69_7, typeof(DynamicBoneHelper))

				if var_69_9 then
					var_69_9:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_8.transform, false)

				arg_66_1.var_[var_69_6 .. "Animator"] = var_69_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_[var_69_6 .. "Animator"].applyRootMotion = true
				arg_66_1.var_[var_69_6 .. "LipSync"] = var_69_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_10 = arg_66_1.actors_["1054ui_story"].transform

			if 1.5 < arg_66_1.time_ and arg_66_1.time_ <= 1.5 + arg_69_0 then
				arg_66_1.var_.moveOldPos1054ui_story = var_69_10.localPosition

				local var_69_11 = GameObjectTools.GetOrAddComponent(var_69_10.gameObject, typeof(DynamicBoneHelper))

				if var_69_11 then
					var_69_11:EnableDynamicBone(false)
				end
			end

			local var_69_12 = 0.001

			if 1.5 <= arg_66_1.time_ and arg_66_1.time_ < 1.5 + var_69_12 then
				var_69_10.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_66_1.time_ - 1.5) / var_69_12)
				var_69_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_10.position).x, (manager.ui.mainCamera.transform.position - var_69_10.position).y, (manager.ui.mainCamera.transform.position - var_69_10.position).z)
				var_69_10.localEulerAngles.z = 0
				var_69_10.localEulerAngles.x = 0
				var_69_10.localEulerAngles = var_69_10.localEulerAngles
			end

			if arg_66_1.time_ >= 1.5 + var_69_12 and arg_66_1.time_ < 1.5 + var_69_12 + arg_69_0 then
				var_69_10.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_69_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_10.position).x, (manager.ui.mainCamera.transform.position - var_69_10.position).y, (manager.ui.mainCamera.transform.position - var_69_10.position).z)
				var_69_10.localEulerAngles.z = 0
				var_69_10.localEulerAngles.x = 0
				var_69_10.localEulerAngles = var_69_10.localEulerAngles

				local var_69_13 = GameObjectTools.GetOrAddComponent(var_69_10.gameObject, typeof(DynamicBoneHelper))

				if var_69_13 then
					var_69_13:EnableDynamicBone(true)
				end
			end

			local var_69_14 = arg_66_1.actors_["1054ui_story"]

			if 1.5 < arg_66_1.time_ and arg_66_1.time_ <= 1.5 + arg_69_0 and not isNil(var_69_14) and arg_66_1.var_.characterEffect1054ui_story == nil then
				arg_66_1.var_.characterEffect1054ui_story = var_69_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_15 = 0.200000002980232

			if 1.5 <= arg_66_1.time_ and arg_66_1.time_ < 1.5 + var_69_15 and not isNil(var_69_14) then
				if arg_66_1.var_.characterEffect1054ui_story and not isNil(var_69_14) then
					arg_66_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 1.5 + var_69_15 and arg_66_1.time_ < 1.5 + var_69_15 + arg_69_0 and not isNil(var_69_14) and arg_66_1.var_.characterEffect1054ui_story then
				arg_66_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 1.5 < arg_66_1.time_ and arg_66_1.time_ <= 1.5 + arg_69_0 then
				arg_66_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 1.5 < arg_66_1.time_ and arg_66_1.time_ <= 1.5 + arg_69_0 then
				arg_66_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				local var_69_17 = arg_66_1.var_.effectzhuanchang21314

				if not arg_66_1.var_.effectzhuanchang21314 then
					var_69_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_69_17.name = "zhuanchang21314"
					arg_66_1.var_.effectzhuanchang21314 = var_69_17
				else
					var_69_17.transform:SetParent(var_69_9000)
				end

				var_69_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_69_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_19 = 1.8
			local var_69_20 = 0.2

			if 1.8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_19 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_21 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_21:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_22 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(939031015).content)

				arg_66_1.text_.text = var_69_22

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_24 = 8 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_22) / 8)

				if (8 <= 0 and var_69_20 or var_69_20 * (utf8.len(var_69_22) / 8)) > 0 and var_69_20 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24
					var_69_19 = var_69_19 + 0.3

					if var_69_24 + var_69_19 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_19
					end
				end

				arg_66_1.text_.text = var_69_22
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = var_69_19 + 0.3
			local var_69_26 = math.max(var_69_20, arg_66_1.talkMaxDuration)

			if var_69_19 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_25 + var_69_26 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_25) / var_69_26

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_25 + var_69_26 and arg_66_1.time_ < var_69_25 + var_69_26 + arg_69_0 then
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
			if arg_72_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "6148ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["6148ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["6148ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["6148ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["6148ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = var_75_3.localPosition

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(false)
				end
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_72_1.time_ - 0) / var_75_5)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles

				local var_75_6 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_6 then
					var_75_6:EnableDynamicBone(true)
				end
			end

			local var_75_7 = arg_72_1.actors_["6148ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect6148ui_story == nil then
				arg_72_1.var_.characterEffect6148ui_story = var_75_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_8 and not isNil(var_75_7) then
				if arg_72_1.var_.characterEffect6148ui_story and not isNil(var_75_7) then
					arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_8 and arg_72_1.time_ < 0 + var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect6148ui_story then
				arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_75_10 = arg_72_1.actors_["1054ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_11 and not isNil(var_75_10) then
				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_10) then
					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_11)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_11 and arg_72_1.time_ < 0 + var_75_11 + arg_75_0 and not isNil(var_75_10) and arg_72_1.var_.characterEffect1054ui_story then
				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_75_12 = 0
			local var_75_13 = 0.2

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_14 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(939031016).content)

				arg_72_1.text_.text = var_75_14

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_16 = 8 <= 0 and var_75_13 or var_75_13 * (utf8.len(var_75_14) / 8)

				if (8 <= 0 and var_75_13 or var_75_13 * (utf8.len(var_75_14) / 8)) > 0 and var_75_13 < var_75_16 then
					arg_72_1.talkMaxDuration = var_75_16

					if var_75_16 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_14
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_17 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_17 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_17

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_17 and arg_72_1.time_ < var_75_12 + var_75_17 + arg_75_0 then
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
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1054ui_story = arg_76_1.actors_["1054ui_story"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).z)
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles = arg_76_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_76_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1054ui_story"].transform.position).z)
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1054ui_story"].transform.localEulerAngles = arg_76_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = arg_76_1.actors_["1054ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1054ui_story == nil then
				arg_76_1.var_.characterEffect1054ui_story = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect1054ui_story and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1054ui_story then
				arg_76_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_79_6 = arg_76_1.actors_["6148ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_7 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 and not isNil(var_79_6) then
				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_6) then
					arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_7)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect6148ui_story then
				arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_79_8 = 0
			local var_79_9 = 0.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(939031017).content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 16 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 16)

				if (16 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_10) / 16)) > 0 and var_79_9 < var_79_12 then
					arg_76_1.talkMaxDuration = var_79_12

					if var_79_12 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_13 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_13 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_13

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_13 and arg_76_1.time_ < var_79_8 + var_79_13 + arg_79_0 then
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
			if arg_80_1.actors_["1137ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1137ui_story"))) then
				local var_83_0 = Object.Instantiate(Asset.Load("Char/" .. "1137ui_story"), arg_80_1.stage_.transform)

				var_83_0.name = "1137ui_story"
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1137ui_story"] = var_83_0

				local var_83_1 = var_83_0:GetComponentInChildren(typeof(CharacterEffect))

				var_83_1.enabled = true

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_1.transform, false)

				arg_80_1.var_["1137ui_story" .. "Animator"] = var_83_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_["1137ui_story" .. "Animator"].applyRootMotion = true
				arg_80_1.var_["1137ui_story" .. "LipSync"] = var_83_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_3 = arg_80_1.actors_["1137ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1137ui_story = var_83_3.localPosition

				local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_3.gameObject, typeof(DynamicBoneHelper))

				if var_83_4 then
					var_83_4:EnableDynamicBone(false)
				end
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1137ui_story, Vector3.New(0, -1.15, -5.7), (arg_80_1.time_ - 0) / var_83_5)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, -1.15, -5.7)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles

				local var_83_6 = GameObjectTools.GetOrAddComponent(var_83_3.gameObject, typeof(DynamicBoneHelper))

				if var_83_6 then
					var_83_6:EnableDynamicBone(true)
				end
			end

			local var_83_7 = arg_80_1.actors_["1054ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1054ui_story = var_83_7.localPosition

				local var_83_8 = GameObjectTools.GetOrAddComponent(var_83_7.gameObject, typeof(DynamicBoneHelper))

				if var_83_8 then
					var_83_8:EnableDynamicBone(false)
				end
			end

			local var_83_9 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_9 then
				var_83_7.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_9)
				var_83_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_7.position).x, (manager.ui.mainCamera.transform.position - var_83_7.position).y, (manager.ui.mainCamera.transform.position - var_83_7.position).z)
				var_83_7.localEulerAngles.z = 0
				var_83_7.localEulerAngles.x = 0
				var_83_7.localEulerAngles = var_83_7.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_9 and arg_80_1.time_ < 0 + var_83_9 + arg_83_0 then
				var_83_7.localPosition = Vector3.New(0, 100, 0)
				var_83_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_7.position).x, (manager.ui.mainCamera.transform.position - var_83_7.position).y, (manager.ui.mainCamera.transform.position - var_83_7.position).z)
				var_83_7.localEulerAngles.z = 0
				var_83_7.localEulerAngles.x = 0
				var_83_7.localEulerAngles = var_83_7.localEulerAngles

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_7.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = arg_80_1.actors_["6148ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos6148ui_story = var_83_11.localPosition

				local var_83_12 = GameObjectTools.GetOrAddComponent(var_83_11.gameObject, typeof(DynamicBoneHelper))

				if var_83_12 then
					var_83_12:EnableDynamicBone(false)
				end
			end

			local var_83_13 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_13 then
				var_83_11.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_13)
				var_83_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_11.position).x, (manager.ui.mainCamera.transform.position - var_83_11.position).y, (manager.ui.mainCamera.transform.position - var_83_11.position).z)
				var_83_11.localEulerAngles.z = 0
				var_83_11.localEulerAngles.x = 0
				var_83_11.localEulerAngles = var_83_11.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_13 and arg_80_1.time_ < 0 + var_83_13 + arg_83_0 then
				var_83_11.localPosition = Vector3.New(0, 100, 0)
				var_83_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_11.position).x, (manager.ui.mainCamera.transform.position - var_83_11.position).y, (manager.ui.mainCamera.transform.position - var_83_11.position).z)
				var_83_11.localEulerAngles.z = 0
				var_83_11.localEulerAngles.x = 0
				var_83_11.localEulerAngles = var_83_11.localEulerAngles

				local var_83_14 = GameObjectTools.GetOrAddComponent(var_83_11.gameObject, typeof(DynamicBoneHelper))

				if var_83_14 then
					var_83_14:EnableDynamicBone(true)
				end
			end

			local var_83_15 = arg_80_1.actors_["1137ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_15) and arg_80_1.var_.characterEffect1137ui_story == nil then
				arg_80_1.var_.characterEffect1137ui_story = var_83_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_16 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_16 and not isNil(var_83_15) then
				if arg_80_1.var_.characterEffect1137ui_story and not isNil(var_83_15) then
					arg_80_1.var_.characterEffect1137ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_16 and arg_80_1.time_ < 0 + var_83_16 + arg_83_0 and not isNil(var_83_15) and arg_80_1.var_.characterEffect1137ui_story then
				arg_80_1.var_.characterEffect1137ui_story.fillFlat = false
			end

			local var_83_18 = arg_80_1.actors_["1054ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_18) and arg_80_1.var_.characterEffect1054ui_story == nil then
				arg_80_1.var_.characterEffect1054ui_story = var_83_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_19 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_19 and not isNil(var_83_18) then
				if arg_80_1.var_.characterEffect1054ui_story and not isNil(var_83_18) then
					arg_80_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_19)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_19 and arg_80_1.time_ < 0 + var_83_19 + arg_83_0 and not isNil(var_83_18) and arg_80_1.var_.characterEffect1054ui_story then
				arg_80_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1137ui_story", "StoryTimeline/CharAction/story1137/story1137action/1137action3_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1137ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_83_20 = 0
			local var_83_21 = 0.225

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_22 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(939031018).content)

				arg_80_1.text_.text = var_83_22

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_24 = 9 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_22) / 9)

				if (9 <= 0 and var_83_21 or var_83_21 * (utf8.len(var_83_22) / 9)) > 0 and var_83_21 < var_83_24 then
					arg_80_1.talkMaxDuration = var_83_24

					if var_83_24 + var_83_20 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_24 + var_83_20
					end
				end

				arg_80_1.text_.text = var_83_22
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_21, arg_80_1.talkMaxDuration)

			if var_83_20 <= arg_80_1.time_ and arg_80_1.time_ < var_83_20 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_20) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_20 + var_83_25 and arg_80_1.time_ < var_83_20 + var_83_25 + arg_83_0 then
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
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1137ui_story = arg_84_1.actors_["1137ui_story"].transform.localPosition

				local var_87_0 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1137ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_0 then
					var_87_0:EnableDynamicBone(false)
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1137ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1137ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_1)
				arg_84_1.actors_["1137ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).z)
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles = arg_84_1.actors_["1137ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1137ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1137ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1137ui_story"].transform.position).z)
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1137ui_story"].transform.localEulerAngles = arg_84_1.actors_["1137ui_story"].transform.localEulerAngles

				local var_87_2 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["1137ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(true)
				end
			end

			local var_87_3 = arg_84_1.actors_["1137ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1137ui_story == nil then
				arg_84_1.var_.characterEffect1137ui_story = var_87_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_4 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 and not isNil(var_87_3) then
				if arg_84_1.var_.characterEffect1137ui_story and not isNil(var_87_3) then
					arg_84_1.var_.characterEffect1137ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1137ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_4)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 and not isNil(var_87_3) and arg_84_1.var_.characterEffect1137ui_story then
				arg_84_1.var_.characterEffect1137ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1137ui_story.fillRatio = 0.5
			end

			local var_87_5 = 0
			local var_87_6 = 0.925

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(939031019).content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 37 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 37)

				if (37 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_7) / 37)) > 0 and var_87_6 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_10 and arg_84_1.time_ < var_87_5 + var_87_10 + arg_87_0 then
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
			local var_91_0 = 0.35

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1541].name)

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

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(939031020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 14 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 14)

				if (14 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 14)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
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
			local var_95_0 = 1.05

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[8].name)

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

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(939031021).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 42 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 42)

				if (42 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 42)) > 0 and var_95_0 < var_95_3 then
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
			if arg_96_1.actors_["1248ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1248ui_story"))) then
				local var_99_0 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_96_1.stage_.transform)

				var_99_0.name = "1248ui_story"
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1248ui_story"] = var_99_0

				local var_99_1 = var_99_0:GetComponentInChildren(typeof(CharacterEffect))

				var_99_1.enabled = true

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end

				arg_96_1:ShowWeapon(var_99_1.transform, false)

				arg_96_1.var_["1248ui_story" .. "Animator"] = var_99_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_96_1.var_["1248ui_story" .. "Animator"].applyRootMotion = true
				arg_96_1.var_["1248ui_story" .. "LipSync"] = var_99_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_99_3 = arg_96_1.actors_["1248ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect1248ui_story == nil then
				arg_96_1.var_.characterEffect1248ui_story = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect1248ui_story and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_4)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect1248ui_story then
				arg_96_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_99_5 = 0
			local var_99_6 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

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

				local var_99_7 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(939031022).content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 19 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 19)

				if (19 <= 0 and var_99_6 or var_99_6 * (utf8.len(var_99_7) / 19)) > 0 and var_99_6 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_5 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_5
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_6, arg_96_1.talkMaxDuration)

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_5) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_5 + var_99_10 and arg_96_1.time_ < var_99_5 + var_99_10 + arg_99_0 then
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
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1248ui_story = arg_100_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).z)
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles = arg_100_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1248ui_story"].transform.position).z)
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1248ui_story"].transform.localEulerAngles = arg_100_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1054ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1054ui_story = var_103_1.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_1.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_100_1.time_ - 0) / var_103_3)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles

				local var_103_4 = GameObjectTools.GetOrAddComponent(var_103_1.gameObject, typeof(DynamicBoneHelper))

				if var_103_4 then
					var_103_4:EnableDynamicBone(true)
				end
			end

			local var_103_5 = arg_100_1.actors_["1054ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect1054ui_story == nil then
				arg_100_1.var_.characterEffect1054ui_story = var_103_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_6 and not isNil(var_103_5) then
				if arg_100_1.var_.characterEffect1054ui_story and not isNil(var_103_5) then
					arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_6 and arg_100_1.time_ < 0 + var_103_6 + arg_103_0 and not isNil(var_103_5) and arg_100_1.var_.characterEffect1054ui_story then
				arg_100_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_103_8 = 0
			local var_103_9 = 0.2

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(939031023).content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_12 = 8 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_10) / 8)

				if (8 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_10) / 8)) > 0 and var_103_9 < var_103_12 then
					arg_100_1.talkMaxDuration = var_103_12

					if var_103_12 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_13 and arg_100_1.time_ < var_103_8 + var_103_13 + arg_103_0 then
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
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos6148ui_story = arg_104_1.actors_["6148ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).z)
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles = arg_104_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_104_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).z)
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles = arg_104_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["6148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect6148ui_story == nil then
				arg_104_1.var_.characterEffect6148ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect6148ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect6148ui_story then
				arg_104_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_107_6 = arg_104_1.actors_["1054ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1054ui_story == nil then
				arg_104_1.var_.characterEffect1054ui_story = var_107_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 and not isNil(var_107_6) then
				if arg_104_1.var_.characterEffect1054ui_story and not isNil(var_107_6) then
					arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_7)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1054ui_story then
				arg_104_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_107_8 = 0
			local var_107_9 = 0.25

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(939031024).content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_12 = 10 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_10) / 10)

				if (10 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_10) / 10)) > 0 and var_107_9 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_13 and arg_104_1.time_ < var_107_8 + var_107_13 + arg_107_0 then
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
