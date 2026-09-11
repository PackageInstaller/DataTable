return {
	Play939071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939071002(arg_1_1)
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.marker = "213213231231"
				arg_1_1.actionList["1"] = arg_1_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 107,
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
	Play939071002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939071002
		arg_6_1.duration_ = 7

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939071003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.ST12a == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12a")
				var_9_0.name = "ST12a"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.ST12a = var_9_0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.ST12a

				arg_6_1.bgs_.ST12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST12a" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 2

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
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

				var_9_7.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_8.a = 0
				arg_6_1.mask_.color = var_9_8
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_9 = 2
			local var_9_10 = 1.05

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_9 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_11 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_11:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_12 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(939071002).content)

				arg_6_1.text_.text = var_9_12

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_14 = 42 <= 0 and var_9_10 or var_9_10 * (utf8.len(var_9_12) / 42)

				if (42 <= 0 and var_9_10 or var_9_10 * (utf8.len(var_9_12) / 42)) > 0 and var_9_10 < var_9_14 then
					arg_6_1.talkMaxDuration = var_9_14
					var_9_9 = var_9_9 + 0.3

					if var_9_14 + var_9_9 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_14 + var_9_9
					end
				end

				arg_6_1.text_.text = var_9_12
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_15 = var_9_9 + 0.3
			local var_9_16 = math.max(var_9_10, arg_6_1.talkMaxDuration)

			if var_9_9 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_15 + var_9_16 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_15) / var_9_16

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_15 + var_9_16 and arg_6_1.time_ < var_9_15 + var_9_16 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play939071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939071003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(939071003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 44 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 44)

				if (44 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 44)) > 0 and var_15_0 < var_15_3 then
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
	Play939071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939071004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.675

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(939071004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 27 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 27)

				if (27 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 27)) > 0 and var_19_0 < var_19_3 then
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
	Play939071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939071005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.125

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(939071005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 5 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 5)

				if (5 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 5)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play939071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939071006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.1

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

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(939071006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 4 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 4)

				if (4 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 4)) > 0 and var_27_0 < var_27_3 then
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
	Play939071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939071007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.575

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(939071007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 23 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 23)

				if (23 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 23)) > 0 and var_31_0 < var_31_3 then
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
	Play939071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939071008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.25

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

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(939071008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 10 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 10)

				if (10 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 10)) > 0 and var_35_0 < var_35_3 then
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
	Play939071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 939071009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play939071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(939071009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 55 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 55)

				if (55 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 55)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play939071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 939071010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play939071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1054ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1054ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1054ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1054ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1054ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_3.localPosition

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_40_1.time_ - 0) / var_43_5)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, -0.985, -6)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(true)
				end
			end

			local var_43_7 = arg_40_1.actors_["1054ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_43_12 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if "" ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_12 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_12

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_12
						arg_40_1.bgmTxt2_.text = var_43_12
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_13 = 0
			local var_43_14 = 1.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_13 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(939071010).content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 47 <= 0 and var_43_14 or var_43_14 * (utf8.len(var_43_15) / 47)

				if (47 <= 0 and var_43_14 or var_43_14 * (utf8.len(var_43_15) / 47)) > 0 and var_43_14 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_13 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_13
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_14, arg_40_1.talkMaxDuration)

			if var_43_13 <= arg_40_1.time_ and arg_40_1.time_ < var_43_13 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_13) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_13 + var_43_18 and arg_40_1.time_ < var_43_13 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play939071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 939071011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play939071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) and arg_45_1.var_.characterEffect1054ui_story == nil then
				arg_45_1.var_.characterEffect1054ui_story = arg_45_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) then
				if arg_45_1.var_.characterEffect1054ui_story and not isNil(arg_45_1.actors_["1054ui_story"]) then
					arg_45_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) and arg_45_1.var_.characterEffect1054ui_story then
				arg_45_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.5

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

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(939071011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 20 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 20)

				if (20 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 20)) > 0 and var_48_2 < var_48_5 then
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
	Play939071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 939071012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play939071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1054ui_story = arg_49_1.actors_["1054ui_story"].transform.localPosition

				local var_52_0 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_0 then
					var_52_0:EnableDynamicBone(false)
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_49_1.time_ - 0) / var_52_1)
				arg_49_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).z)
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles = arg_49_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_49_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1054ui_story"].transform.position).z)
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1054ui_story"].transform.localEulerAngles = arg_49_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_52_2 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(true)
				end
			end

			local var_52_3 = arg_49_1.actors_["1054ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1054ui_story == nil then
				arg_49_1.var_.characterEffect1054ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect1054ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect1054ui_story then
				arg_49_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(939071012).content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 20 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_8) / 20)

				if (20 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_8) / 20)) > 0 and var_52_7 < var_52_10 then
					arg_49_1.talkMaxDuration = var_52_10

					if var_52_10 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_11 and arg_49_1.time_ < var_52_6 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play939071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 939071013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play939071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1054ui_story"]) and arg_53_1.var_.characterEffect1054ui_story == nil then
				arg_53_1.var_.characterEffect1054ui_story = arg_53_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1054ui_story"]) then
				if arg_53_1.var_.characterEffect1054ui_story and not isNil(arg_53_1.actors_["1054ui_story"]) then
					arg_53_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1054ui_story"]) and arg_53_1.var_.characterEffect1054ui_story then
				arg_53_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.125

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

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(939071013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 5 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 5)

				if (5 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 5)) > 0 and var_56_2 < var_56_5 then
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
	Play939071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 939071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play939071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1054ui_story = arg_57_1.actors_["1054ui_story"].transform.localPosition

				local var_60_0 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_0 then
					var_60_0:EnableDynamicBone(false)
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_57_1.time_ - 0) / var_60_1)
				arg_57_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).z)
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles = arg_57_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_57_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1054ui_story"].transform.position).z)
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1054ui_story"].transform.localEulerAngles = arg_57_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_60_2 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(true)
				end
			end

			local var_60_3 = arg_57_1.actors_["1054ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1054ui_story == nil then
				arg_57_1.var_.characterEffect1054ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1054ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1054ui_story then
				arg_57_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(939071014).content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 20 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_8) / 20)

				if (20 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_8) / 20)) > 0 and var_60_7 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_11 and arg_57_1.time_ < var_60_6 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play939071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 939071015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play939071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1054ui_story = arg_61_1.actors_["1054ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).z)
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles = arg_61_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_61_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).z)
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles = arg_61_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action435")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_64_3 = 0
			local var_64_4 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(939071015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 17 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 17)

				if (17 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 17)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play939071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 939071016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play939071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1054ui_story"]) and arg_65_1.var_.characterEffect1054ui_story == nil then
				arg_65_1.var_.characterEffect1054ui_story = arg_65_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1054ui_story"]) then
				if arg_65_1.var_.characterEffect1054ui_story and not isNil(arg_65_1.actors_["1054ui_story"]) then
					arg_65_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1054ui_story"]) and arg_65_1.var_.characterEffect1054ui_story then
				arg_65_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
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

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(939071016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 6 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 6)

				if (6 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 6)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play939071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 939071017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play939071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1054ui_story = arg_69_1.actors_["1054ui_story"].transform.localPosition

				local var_72_0 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_0 then
					var_72_0:EnableDynamicBone(false)
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_1)
				arg_69_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).z)
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles = arg_69_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).z)
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles = arg_69_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_72_2 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(true)
				end
			end

			local var_72_3 = 0
			local var_72_4 = 0.525

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(939071017).content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 21 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 21)

				if (21 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_5) / 21)) > 0 and var_72_4 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_3) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_8 and arg_69_1.time_ < var_72_3 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play939071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 939071018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play939071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "1284ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1284ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["1284ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["1284ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["1284ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1284ui_story == nil then
				arg_73_1.var_.characterEffect1284ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect1284ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1284ui_story then
				arg_73_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_76_6 = 0
			local var_76_7 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_8 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(939071018).content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 20 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 20)

				if (20 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 20)) > 0 and var_76_7 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_11 and arg_73_1.time_ < var_76_6 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play939071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 939071019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play939071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1284ui_story"]) and arg_77_1.var_.characterEffect1284ui_story == nil then
				arg_77_1.var_.characterEffect1284ui_story = arg_77_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1284ui_story"]) then
				if arg_77_1.var_.characterEffect1284ui_story and not isNil(arg_77_1.actors_["1284ui_story"]) then
					arg_77_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1284ui_story"]) and arg_77_1.var_.characterEffect1284ui_story then
				arg_77_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.7

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

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(939071019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 28 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 28)

				if (28 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 28)) > 0 and var_80_2 < var_80_5 then
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
	Play939071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 939071020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play939071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1054ui_story = arg_81_1.actors_["1054ui_story"].transform.localPosition

				local var_84_0 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_0 then
					var_84_0:EnableDynamicBone(false)
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_81_1.time_ - 0) / var_84_1)
				arg_81_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).z)
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles = arg_81_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_81_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1054ui_story"].transform.position).z)
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1054ui_story"].transform.localEulerAngles = arg_81_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_84_2 = GameObjectTools.GetOrAddComponent(arg_81_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(true)
				end
			end

			local var_84_3 = arg_81_1.actors_["1054ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1054ui_story == nil then
				arg_81_1.var_.characterEffect1054ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect1054ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1054ui_story then
				arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_84_6 = 0
			local var_84_7 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(939071020).content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 15 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 15)

				if (15 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 15)) > 0 and var_84_7 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_11 and arg_81_1.time_ < var_84_6 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play939071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 939071021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play939071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1054ui_story = arg_85_1.actors_["1054ui_story"].transform.localPosition

				local var_88_0 = GameObjectTools.GetOrAddComponent(arg_85_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_88_0 then
					var_88_0:EnableDynamicBone(false)
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_1)
				arg_85_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).z)
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles = arg_85_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1054ui_story"].transform.position).z)
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1054ui_story"].transform.localEulerAngles = arg_85_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_88_2 = GameObjectTools.GetOrAddComponent(arg_85_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(true)
				end
			end

			local var_88_3 = arg_85_1.actors_["1054ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1054ui_story == nil then
				arg_85_1.var_.characterEffect1054ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect1054ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_4)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1054ui_story then
				arg_85_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_88_5 = 0
			local var_88_6 = 1.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(939071021).content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 54 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 54)

				if (54 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_7) / 54)) > 0 and var_88_6 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_10 and arg_85_1.time_ < var_88_5 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play939071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 939071022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play939071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_92_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_89_1.stage_.transform)

				var_92_0.name = "6148ui_story"
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["6148ui_story"] = var_92_0

				local var_92_1 = var_92_0:GetComponentInChildren(typeof(CharacterEffect))

				var_92_1.enabled = true

				local var_92_2 = GameObjectTools.GetOrAddComponent(var_92_0, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(false)
				end

				arg_89_1:ShowWeapon(var_92_1.transform, false)

				arg_89_1.var_["6148ui_story" .. "Animator"] = var_92_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_89_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_89_1.var_["6148ui_story" .. "LipSync"] = var_92_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_92_3 = arg_89_1.actors_["6148ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos6148ui_story = var_92_3.localPosition

				local var_92_4 = GameObjectTools.GetOrAddComponent(var_92_3.gameObject, typeof(DynamicBoneHelper))

				if var_92_4 then
					var_92_4:EnableDynamicBone(false)
				end
			end

			local var_92_5 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_89_1.time_ - 0) / var_92_5)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles

				local var_92_6 = GameObjectTools.GetOrAddComponent(var_92_3.gameObject, typeof(DynamicBoneHelper))

				if var_92_6 then
					var_92_6:EnableDynamicBone(true)
				end
			end

			local var_92_7 = arg_89_1.actors_["6148ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.characterEffect6148ui_story == nil then
				arg_89_1.var_.characterEffect6148ui_story = var_92_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_8 and not isNil(var_92_7) then
				if arg_89_1.var_.characterEffect6148ui_story and not isNil(var_92_7) then
					arg_89_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_8 and arg_89_1.time_ < 0 + var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.characterEffect6148ui_story then
				arg_89_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_92_10 = 0
			local var_92_11 = 1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_12 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(939071022).content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_14 = 40 <= 0 and var_92_11 or var_92_11 * (utf8.len(var_92_12) / 40)

				if (40 <= 0 and var_92_11 or var_92_11 * (utf8.len(var_92_12) / 40)) > 0 and var_92_11 < var_92_14 then
					arg_89_1.talkMaxDuration = var_92_14

					if var_92_14 + var_92_10 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_10
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_15 = math.max(var_92_11, arg_89_1.talkMaxDuration)

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_15 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_10) / var_92_15

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_10 + var_92_15 and arg_89_1.time_ < var_92_10 + var_92_15 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play939071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 939071023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play939071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1054ui_story = arg_93_1.actors_["1054ui_story"].transform.localPosition

				local var_96_0 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_0 then
					var_96_0:EnableDynamicBone(false)
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_93_1.time_ - 0) / var_96_1)
				arg_93_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).z)
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles = arg_93_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_93_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1054ui_story"].transform.position).z)
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1054ui_story"].transform.localEulerAngles = arg_93_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_96_2 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(true)
				end
			end

			local var_96_3 = arg_93_1.actors_["1054ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1054ui_story == nil then
				arg_93_1.var_.characterEffect1054ui_story = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect1054ui_story and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1054ui_story then
				arg_93_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_96_6 = arg_93_1.actors_["6148ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect6148ui_story == nil then
				arg_93_1.var_.characterEffect6148ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect6148ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_93_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect6148ui_story then
				arg_93_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_93_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_96_8 = 0
			local var_96_9 = 0.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(939071023).content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 29 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_10) / 29)

				if (29 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_10) / 29)) > 0 and var_96_9 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_13 and arg_93_1.time_ < var_96_8 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play939071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 939071024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play939071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos6148ui_story = arg_97_1.actors_["6148ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).z)
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles = arg_97_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_97_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6148ui_story"].transform.position).z)
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["6148ui_story"].transform.localEulerAngles = arg_97_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["6148ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect6148ui_story == nil then
				arg_97_1.var_.characterEffect6148ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect6148ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect6148ui_story then
				arg_97_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_100_6 = arg_97_1.actors_["1054ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1054ui_story == nil then
				arg_97_1.var_.characterEffect1054ui_story = var_100_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_7 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 and not isNil(var_100_6) then
				if arg_97_1.var_.characterEffect1054ui_story and not isNil(var_100_6) then
					arg_97_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_7)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 and not isNil(var_100_6) and arg_97_1.var_.characterEffect1054ui_story then
				arg_97_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_100_8 = 0
			local var_100_9 = 1.05

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(939071024).content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_12 = 42 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 42)

				if (42 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_10) / 42)) > 0 and var_100_9 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_13 and arg_97_1.time_ < var_100_8 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play939071025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 939071025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play939071026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["6148ui_story"]) and arg_101_1.var_.characterEffect6148ui_story == nil then
				arg_101_1.var_.characterEffect6148ui_story = arg_101_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["6148ui_story"]) then
				if arg_101_1.var_.characterEffect6148ui_story and not isNil(arg_101_1.actors_["6148ui_story"]) then
					arg_101_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_101_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["6148ui_story"]) and arg_101_1.var_.characterEffect6148ui_story then
				arg_101_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_101_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.375

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

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(939071025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 15 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 15)

				if (15 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 15)) > 0 and var_104_2 < var_104_5 then
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
	Play939071026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 939071026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play939071027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos6148ui_story = arg_105_1.actors_["6148ui_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).z)
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles = arg_105_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_105_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["6148ui_story"].transform.position).z)
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["6148ui_story"].transform.localEulerAngles = arg_105_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			local var_108_3 = arg_105_1.actors_["6148ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect6148ui_story == nil then
				arg_105_1.var_.characterEffect6148ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect6148ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect6148ui_story then
				arg_105_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action443")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_108_6 = 0
			local var_108_7 = 1.025

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(939071026).content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 41 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_8) / 41)

				if (41 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_8) / 41)) > 0 and var_108_7 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_11 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_11 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_11

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_11 and arg_105_1.time_ < var_108_6 + var_108_11 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play939071027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 939071027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play939071028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1054ui_story = arg_109_1.actors_["1054ui_story"].transform.localPosition

				local var_112_0 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_0 then
					var_112_0:EnableDynamicBone(false)
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_109_1.time_ - 0) / var_112_1)
				arg_109_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).z)
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles = arg_109_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_109_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1054ui_story"].transform.position).z)
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1054ui_story"].transform.localEulerAngles = arg_109_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_112_2 = GameObjectTools.GetOrAddComponent(arg_109_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(true)
				end
			end

			local var_112_3 = arg_109_1.actors_["1054ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1054ui_story == nil then
				arg_109_1.var_.characterEffect1054ui_story = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect1054ui_story and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1054ui_story then
				arg_109_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_112_6 = arg_109_1.actors_["6148ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect6148ui_story == nil then
				arg_109_1.var_.characterEffect6148ui_story = var_112_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_7 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 and not isNil(var_112_6) then
				if arg_109_1.var_.characterEffect6148ui_story and not isNil(var_112_6) then
					arg_109_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_109_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_7)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 and not isNil(var_112_6) and arg_109_1.var_.characterEffect6148ui_story then
				arg_109_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_109_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_112_8 = 0
			local var_112_9 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(939071027).content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 12 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_10) / 12)

				if (12 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_10) / 12)) > 0 and var_112_9 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_13 and arg_109_1.time_ < var_112_8 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play939071028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 939071028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play939071029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1054ui_story = arg_113_1.actors_["1054ui_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).z)
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles = arg_113_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1054ui_story"].transform.position).z)
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1054ui_story"].transform.localEulerAngles = arg_113_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["6148ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos6148ui_story = var_116_3.localPosition

				local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_4 then
					var_116_4:EnableDynamicBone(false)
				end
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_5)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles

				local var_116_6 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_6 then
					var_116_6:EnableDynamicBone(true)
				end
			end

			local var_116_7 = arg_113_1.actors_["1054ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1054ui_story == nil then
				arg_113_1.var_.characterEffect1054ui_story = var_116_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 and not isNil(var_116_7) then
				if arg_113_1.var_.characterEffect1054ui_story and not isNil(var_116_7) then
					arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_8)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1054ui_story then
				arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_116_9 = 0
			local var_116_10 = 1.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_11 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(939071028).content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 64 <= 0 and var_116_10 or var_116_10 * (utf8.len(var_116_11) / 64)

				if (64 <= 0 and var_116_10 or var_116_10 * (utf8.len(var_116_11) / 64)) > 0 and var_116_10 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_9 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_9
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_10, arg_113_1.talkMaxDuration)

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_9) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_9 + var_116_14 and arg_113_1.time_ < var_116_9 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play939071029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 939071029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play939071030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.95

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
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

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(939071029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 38 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 38)

				if (38 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 38)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play939071030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 939071030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play939071031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.075

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

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(939071030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 43 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 43)

				if (43 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 43)) > 0 and var_124_0 < var_124_3 then
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
	Play939071031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 939071031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
			arg_125_1.auto_ = false
		end

		function arg_125_1.playNext_(arg_127_0)
			arg_125_1.onStoryFinished_()
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.marker = "luntantiezi9999"
				arg_125_1.actionList["213211321"] = arg_125_1.actionList["213211321"] or StoryInteractionRogueCardForumGame.New(arg_125_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_125_1.actionList["213211321"]:SetData({
					hideOnEndGame = true,
					type = 2,
					postId = 207,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "postBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12a"
	},
	voices = {},
	skipMarkers = {
		939071001,
		939071031
	}
}
