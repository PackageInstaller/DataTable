return {
	Play117101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 117101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play117101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST24a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST24a")
				var_4_0.name = "ST24a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST24a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST24a

				arg_1_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST24a" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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
			local var_4_15 = 0.725

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(117101001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 29 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 29)

				if (29 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 29)) > 0 and var_4_15 < var_4_19 then
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
	Play117101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 117101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play117101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.425

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(117101002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 17)

				if (17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 17)) > 0 and var_12_0 < var_12_3 then
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
	Play117101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 117101003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play117101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_16_1 = 0
			local var_16_2 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(117101003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 10 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 10)

				if (10 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 10)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play117101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 117101004
		arg_17_1.duration_ = 2.47

		local var_17_0 = {
			zh = 2.166,
			ja = 2.466
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play117101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10035"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10035")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "10035"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["10035"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["10035"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10035 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10035", 3)

				for iter_20_2 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_2)

					if var_20_3.name == "split_1" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10035, Vector3.New(0, -410, -235), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -410, -235)
			end

			local var_20_5 = arg_17_1.actors_["10035"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10035 == nil then
				arg_17_1.var_.actorSpriteComps10035 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10035 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								iter_20_4.color = Color.New(Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_4.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_4.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10035 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_20_6 then
						iter_20_6.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_8 then
					arg_17_1.var_.alphaOldValue10035 = var_20_8.alpha
					arg_17_1.var_.characterEffect10035 = var_20_8
				end

				arg_17_1.var_.alphaOldValue10035 = 0
			end

			local var_20_9 = 0.5

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.characterEffect10035 then
					arg_17_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_17_1.var_.alphaOldValue10035, 1, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.characterEffect10035 then
				arg_17_1.var_.characterEffect10035.alpha = 1
			end

			local var_20_10 = 0
			local var_20_11 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(117101004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 5 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 5)

				if (5 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 5)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101004", "story_v_out_117101.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_117101", "117101004", "story_v_out_117101.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_117101", "117101004", "story_v_out_117101.awb")

						arg_17_1:RecordAudio("117101004", var_20_17)
						arg_17_1:RecordAudio("117101004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_117101", "117101004", "story_v_out_117101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_117101", "117101004", "story_v_out_117101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play117101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 117101005
		arg_21_1.duration_ = 3.17

		local var_21_0 = {
			zh = 3.166,
			ja = 1.566
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
				arg_21_0:Play117101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10035 = arg_21_1.actors_["10035"].transform.localPosition
				arg_21_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10035", 3)

				for iter_24_0 = 0, arg_21_1.actors_["10035"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10035"].transform:GetChild(iter_24_0)

					if var_24_0.name == "split_4" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10035, Vector3.New(0, -410, -235), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10035"].transform.localPosition = Vector3.New(0, -410, -235)
			end

			local var_24_2 = 0
			local var_24_3 = 0.1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(117101005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 4 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 4)

				if (4 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 4)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101005", "story_v_out_117101.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101005", "story_v_out_117101.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_117101", "117101005", "story_v_out_117101.awb")

						arg_21_1:RecordAudio("117101005", var_24_9)
						arg_21_1:RecordAudio("117101005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_117101", "117101005", "story_v_out_117101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_117101", "117101005", "story_v_out_117101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play117101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 117101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play117101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = arg_25_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_28_0 then
					arg_25_1.var_.alphaOldValue10035 = var_28_0.alpha
					arg_25_1.var_.characterEffect10035 = var_28_0
				end

				arg_25_1.var_.alphaOldValue10035 = 1
			end

			local var_28_1 = 0.5

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				if arg_25_1.var_.characterEffect10035 then
					arg_25_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_25_1.var_.alphaOldValue10035, 0, (arg_25_1.time_ - 0) / var_28_1)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and arg_25_1.var_.characterEffect10035 then
				arg_25_1.var_.characterEffect10035.alpha = 0
			end

			local var_28_2 = 0
			local var_28_3 = 0.925

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(117101006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 37 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 37)

				if (37 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 37)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play117101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 117101007
		arg_29_1.duration_ = 2

		local var_29_0 = {
			zh = 1.833,
			ja = 2
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
				arg_29_0:Play117101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10035 = arg_29_1.actors_["10035"].transform.localPosition
				arg_29_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10035", 2)

				for iter_32_0 = 0, arg_29_1.actors_["10035"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["10035"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_4" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10035, Vector3.New(-390, -410, -235), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["10035"].transform.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_32_2 = arg_29_1.actors_["10035"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10035 == nil then
				arg_29_1.var_.actorSpriteComps10035 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10035 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								iter_32_2.color = Color.New(Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_2.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_2.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10035 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_32_4 then
						iter_32_4.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10035 = nil
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_5 = arg_29_1.actors_["10035"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_32_5 then
					arg_29_1.var_.alphaOldValue10035 = var_32_5.alpha
					arg_29_1.var_.characterEffect10035 = var_32_5
				end

				arg_29_1.var_.alphaOldValue10035 = 0
			end

			local var_32_6 = 0.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				if arg_29_1.var_.characterEffect10035 then
					arg_29_1.var_.characterEffect10035.alpha = Mathf.Lerp(arg_29_1.var_.alphaOldValue10035, 1, (arg_29_1.time_ - 0) / var_32_6)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and arg_29_1.var_.characterEffect10035 then
				arg_29_1.var_.characterEffect10035.alpha = 1
			end

			local var_32_7 = 0
			local var_32_8 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(117101007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 3 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 3)

				if (3 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 3)) > 0 and var_32_8 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101007", "story_v_out_117101.awb") ~= 0 then
					local var_32_13 = manager.audio:GetVoiceLength("story_v_out_117101", "117101007", "story_v_out_117101.awb") / 1000

					if var_32_13 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_7
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_117101", "117101007", "story_v_out_117101.awb")

						arg_29_1:RecordAudio("117101007", var_32_14)
						arg_29_1:RecordAudio("117101007", var_32_14)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_117101", "117101007", "story_v_out_117101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_117101", "117101007", "story_v_out_117101.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_15 and arg_29_1.time_ < var_32_7 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play117101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 117101008
		arg_33_1.duration_ = 8.1

		local var_33_0 = {
			zh = 6.266,
			ja = 8.1
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
				arg_33_0:Play117101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1033"] == nil then
				local var_36_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_36_0) then
					local var_36_1 = Object.Instantiate(var_36_0, arg_33_1.canvasGo_.transform)

					var_36_1.transform:SetSiblingIndex(1)

					var_36_1.name = "1033"
					var_36_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_33_1.actors_["1033"] = var_36_1

					if arg_33_1.isInRecall_ then
						for iter_36_0, iter_36_1 in ipairs((var_36_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_36_1.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_36_2 = arg_33_1.actors_["1033"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1033 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1033", 4)

				for iter_36_2 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_2)

					if var_36_3.name == "split_6" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(390, -420, 0)
			end

			local var_36_5 = arg_33_1.actors_["10035"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10035 = var_36_5.localPosition
				var_36_5.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10035", 2)

				for iter_36_3 = 0, var_36_5.childCount - 1 do
					local var_36_6 = var_36_5:GetChild(iter_36_3)

					if var_36_6.name == "split_4" or not string.find(var_36_6.name, "split") then
						var_36_6.gameObject:SetActive(true)
					else
						var_36_6.gameObject:SetActive(false)
					end
				end
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10035, Vector3.New(-390, -410, -235), (arg_33_1.time_ - 0) / var_36_7)
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-390, -410, -235)
			end

			local var_36_8 = arg_33_1.actors_["10035"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10035 == nil then
				arg_33_1.var_.actorSpriteComps10035 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 and not isNil(var_36_8) then
				if arg_33_1.var_.actorSpriteComps10035 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10035:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_9), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_9), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_9)))
							else
								local var_36_10 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_9)

								iter_36_5.color = Color.New(var_36_10, var_36_10, var_36_10)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10035 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10035:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10035 = nil
			end

			local var_36_11 = arg_33_1.actors_["1033"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1033 == nil then
				arg_33_1.var_.actorSpriteComps1033 = var_36_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_12 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_12 and not isNil(var_36_11) then
				if arg_33_1.var_.actorSpriteComps1033 then
					for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_36_9 then
							if arg_33_1.isInRecall_ then
								iter_36_9.color = Color.New(Mathf.Lerp(iter_36_9.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_12), Mathf.Lerp(iter_36_9.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_12), (Mathf.Lerp(iter_36_9.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_12)))
							else
								local var_36_13 = Mathf.Lerp(iter_36_9.color.r, 1, (arg_33_1.time_ - 0) / var_36_12)

								iter_36_9.color = Color.New(var_36_13, var_36_13, var_36_13)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_12 and arg_33_1.time_ < 0 + var_36_12 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.actorSpriteComps1033 then
				for iter_36_10, iter_36_11 in pairs(arg_33_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_36_11 then
						iter_36_11.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_14 = arg_33_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_14 then
					arg_33_1.var_.alphaOldValue1033 = var_36_14.alpha
					arg_33_1.var_.characterEffect1033 = var_36_14
				end

				arg_33_1.var_.alphaOldValue1033 = 0
			end

			local var_36_15 = 0.5

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_15 then
				if arg_33_1.var_.characterEffect1033 then
					arg_33_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_33_1.var_.alphaOldValue1033, 1, (arg_33_1.time_ - 0) / var_36_15)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_15 and arg_33_1.time_ < 0 + var_36_15 + arg_36_0 and arg_33_1.var_.characterEffect1033 then
				arg_33_1.var_.characterEffect1033.alpha = 1
			end

			local var_36_16 = 0
			local var_36_17 = 0.725

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(117101008)
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

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101008", "story_v_out_117101.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_out_117101", "117101008", "story_v_out_117101.awb") / 1000

					if var_36_22 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_16
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_117101", "117101008", "story_v_out_117101.awb")

						arg_33_1:RecordAudio("117101008", var_36_23)
						arg_33_1:RecordAudio("117101008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_117101", "117101008", "story_v_out_117101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_117101", "117101008", "story_v_out_117101.awb")
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
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play117101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 117101009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play117101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1033"]) and arg_37_1.var_.actorSpriteComps1033 == nil then
				arg_37_1.var_.actorSpriteComps1033 = arg_37_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1033"]) then
				if arg_37_1.var_.actorSpriteComps1033 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1033"]) and arg_37_1.var_.actorSpriteComps1033 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1033 = nil
			end

			local var_40_2 = 0
			local var_40_3 = 0.625

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(117101009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 25 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 25)

				if (25 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 25)) > 0 and var_40_3 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_7 and arg_37_1.time_ < var_40_2 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play117101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 117101010
		arg_41_1.duration_ = 4.6

		local var_41_0 = {
			zh = 4.2,
			ja = 4.6
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
				arg_41_0:Play117101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10035 = arg_41_1.actors_["10035"].transform.localPosition
				arg_41_1.actors_["10035"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10035", 7)

				for iter_44_0 = 0, arg_41_1.actors_["10035"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10035"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_4" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10035"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10035, Vector3.New(0, -2000, -235), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10035"].transform.localPosition = Vector3.New(0, -2000, -235)
			end

			local var_44_2 = "10034"

			if arg_41_1.actors_["10034"] == nil then
				local var_44_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10034")

				if not isNil(var_44_3) then
					local var_44_4 = Object.Instantiate(var_44_3, arg_41_1.canvasGo_.transform)

					var_44_4.transform:SetSiblingIndex(1)

					var_44_4.name = var_44_2
					var_44_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_[var_44_2] = var_44_4

					if arg_41_1.isInRecall_ then
						for iter_44_1, iter_44_2 in ipairs((var_44_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_2.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_5 = arg_41_1.actors_["10034"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10034 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10034", 2)

				for iter_44_3 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_3)

					if var_44_6.name == "split_2" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_44_8 = arg_41_1.actors_["10034"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10034 == nil then
				arg_41_1.var_.actorSpriteComps10034 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 and not isNil(var_44_8) then
				if arg_41_1.var_.actorSpriteComps10034 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_9), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_9), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_9)))
							else
								local var_44_10 = Mathf.Lerp(iter_44_5.color.r, 1, (arg_41_1.time_ - 0) / var_44_9)

								iter_44_5.color = Color.New(var_44_10, var_44_10, var_44_10)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10034 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10034 = nil
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_11 = arg_41_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_11 then
					arg_41_1.var_.alphaOldValue10034 = var_44_11.alpha
					arg_41_1.var_.characterEffect10034 = var_44_11
				end

				arg_41_1.var_.alphaOldValue10034 = 0
			end

			local var_44_12 = 0.5

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_12 then
				if arg_41_1.var_.characterEffect10034 then
					arg_41_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_41_1.var_.alphaOldValue10034, 1, (arg_41_1.time_ - 0) / var_44_12)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_12 and arg_41_1.time_ < 0 + var_44_12 + arg_44_0 and arg_41_1.var_.characterEffect10034 then
				arg_41_1.var_.characterEffect10034.alpha = 1
			end

			local var_44_13 = 0
			local var_44_14 = 0.5

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(117101010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_18 = 20 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 20)

				if (20 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 20)) > 0 and var_44_14 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101010", "story_v_out_117101.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_117101", "117101010", "story_v_out_117101.awb") / 1000

					if var_44_19 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_13
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_117101", "117101010", "story_v_out_117101.awb")

						arg_41_1:RecordAudio("117101010", var_44_20)
						arg_41_1:RecordAudio("117101010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_117101", "117101010", "story_v_out_117101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_117101", "117101010", "story_v_out_117101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 <= arg_41_1.time_ and arg_41_1.time_ < var_44_13 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_13) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_13 + var_44_21 and arg_41_1.time_ < var_44_13 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10035",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play117101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 117101011
		arg_45_1.duration_ = 1.9

		local var_45_0 = {
			zh = 1.4,
			ja = 1.9
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
				arg_45_0:Play117101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10034"]) and arg_45_1.var_.actorSpriteComps10034 == nil then
				arg_45_1.var_.actorSpriteComps10034 = arg_45_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10034"]) then
				if arg_45_1.var_.actorSpriteComps10034 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10034"]) and arg_45_1.var_.actorSpriteComps10034 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps10034 = nil
			end

			local var_48_2 = 0
			local var_48_3 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_4 = arg_45_1:GetWordFromCfg(117101011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 4 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 4)

				if (4 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 4)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101011", "story_v_out_117101.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101011", "story_v_out_117101.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_117101", "117101011", "story_v_out_117101.awb")

						arg_45_1:RecordAudio("117101011", var_48_9)
						arg_45_1:RecordAudio("117101011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_117101", "117101011", "story_v_out_117101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_117101", "117101011", "story_v_out_117101.awb")
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
	Play117101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 117101012
		arg_49_1.duration_ = 3.83

		local var_49_0 = {
			zh = 2.6,
			ja = 3.833
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
				arg_49_0:Play117101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10034"]) and arg_49_1.var_.actorSpriteComps10034 == nil then
				arg_49_1.var_.actorSpriteComps10034 = arg_49_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10034"]) then
				if arg_49_1.var_.actorSpriteComps10034 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10034"]) and arg_49_1.var_.actorSpriteComps10034 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10034 = nil
			end

			local var_52_2 = 0
			local var_52_3 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(117101012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 12 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 12)

				if (12 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 12)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101012", "story_v_out_117101.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101012", "story_v_out_117101.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_117101", "117101012", "story_v_out_117101.awb")

						arg_49_1:RecordAudio("117101012", var_52_9)
						arg_49_1:RecordAudio("117101012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_117101", "117101012", "story_v_out_117101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_117101", "117101012", "story_v_out_117101.awb")
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
	Play117101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 117101013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play117101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10034"]) and arg_53_1.var_.actorSpriteComps10034 == nil then
				arg_53_1.var_.actorSpriteComps10034 = arg_53_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10034"]) then
				if arg_53_1.var_.actorSpriteComps10034 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10034"]) and arg_53_1.var_.actorSpriteComps10034 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps10034 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.925

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(117101013).content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 37 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 37)

				if (37 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_4) / 37)) > 0 and var_56_3 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_7 and arg_53_1.time_ < var_56_2 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play117101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 117101014
		arg_57_1.duration_ = 2.03

		local var_57_0 = {
			zh = 1.766,
			ja = 2.033
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
				arg_57_0:Play117101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1033 = arg_57_1.actors_["1033"].transform.localPosition
				arg_57_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1033", 4)

				for iter_60_0 = 0, arg_57_1.actors_["1033"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1033"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_6" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_60_2 = arg_57_1.actors_["1033"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1033 == nil then
				arg_57_1.var_.actorSpriteComps1033 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps1033 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								iter_60_2.color = Color.New(Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_2.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_2.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps1033 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_60_4 then
						iter_60_4.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1033 = nil
			end

			local var_60_5 = 0
			local var_60_6 = 0.075

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(117101014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 3 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 3)

				if (3 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 3)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101014", "story_v_out_117101.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101014", "story_v_out_117101.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_117101", "117101014", "story_v_out_117101.awb")

						arg_57_1:RecordAudio("117101014", var_60_12)
						arg_57_1:RecordAudio("117101014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_117101", "117101014", "story_v_out_117101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_117101", "117101014", "story_v_out_117101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play117101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 117101015
		arg_61_1.duration_ = 7.57

		local var_61_0 = {
			zh = 7.566,
			ja = 4.466
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
				arg_61_0:Play117101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10034"]) and arg_61_1.var_.actorSpriteComps10034 == nil then
				arg_61_1.var_.actorSpriteComps10034 = arg_61_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10034"]) then
				if arg_61_1.var_.actorSpriteComps10034 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10034"]) and arg_61_1.var_.actorSpriteComps10034 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10034 = nil
			end

			local var_64_2 = arg_61_1.actors_["1033"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								iter_64_5.color = Color.New(Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_5.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_5.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_7 then
						iter_64_7.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_5 = 0
			local var_64_6 = 0.7

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(117101015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 28 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 28)

				if (28 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 28)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101015", "story_v_out_117101.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101015", "story_v_out_117101.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_117101", "117101015", "story_v_out_117101.awb")

						arg_61_1:RecordAudio("117101015", var_64_12)
						arg_61_1:RecordAudio("117101015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_117101", "117101015", "story_v_out_117101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_117101", "117101015", "story_v_out_117101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play117101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 117101016
		arg_65_1.duration_ = 6.9

		local var_65_0 = {
			zh = 6.9,
			ja = 4.733
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
				arg_65_0:Play117101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10034"]) and arg_65_1.var_.actorSpriteComps10034 == nil then
				arg_65_1.var_.actorSpriteComps10034 = arg_65_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10034"]) then
				if arg_65_1.var_.actorSpriteComps10034 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10034"]) and arg_65_1.var_.actorSpriteComps10034 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10034 = nil
			end

			local var_68_2 = arg_65_1.actors_["1033"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 == nil then
				arg_65_1.var_.actorSpriteComps1033 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps1033 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 1, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps1033 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1033 = nil
			end

			local var_68_5 = 0
			local var_68_6 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(117101016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 24 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 24)

				if (24 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 24)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101016", "story_v_out_117101.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101016", "story_v_out_117101.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_117101", "117101016", "story_v_out_117101.awb")

						arg_65_1:RecordAudio("117101016", var_68_12)
						arg_65_1:RecordAudio("117101016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_117101", "117101016", "story_v_out_117101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_117101", "117101016", "story_v_out_117101.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play117101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 117101017
		arg_69_1.duration_ = 8.33

		local var_69_0 = {
			zh = 8.333,
			ja = 4.533
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
				arg_69_0:Play117101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10034"]) and arg_69_1.var_.actorSpriteComps10034 == nil then
				arg_69_1.var_.actorSpriteComps10034 = arg_69_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10034"]) then
				if arg_69_1.var_.actorSpriteComps10034 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								iter_72_1.color = Color.New(Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_0), Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_0), (Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_0)))
							else
								local var_72_1 = Mathf.Lerp(iter_72_1.color.r, 1, (arg_69_1.time_ - 0) / var_72_0)

								iter_72_1.color = Color.New(var_72_1, var_72_1, var_72_1)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10034"]) and arg_69_1.var_.actorSpriteComps10034 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10034 = nil
			end

			local var_72_2 = arg_69_1.actors_["1033"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1033 == nil then
				arg_69_1.var_.actorSpriteComps1033 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1033 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_5.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1033 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1033 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 0.85

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(117101017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 34 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 34)

				if (34 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 34)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101017", "story_v_out_117101.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101017", "story_v_out_117101.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_117101", "117101017", "story_v_out_117101.awb")

						arg_69_1:RecordAudio("117101017", var_72_12)
						arg_69_1:RecordAudio("117101017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_117101", "117101017", "story_v_out_117101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_117101", "117101017", "story_v_out_117101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play117101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 117101018
		arg_73_1.duration_ = 6.67

		local var_73_0 = {
			zh = 4.533,
			ja = 6.666
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
				arg_73_0:Play117101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1033 = arg_73_1.actors_["1033"].transform.localPosition
				arg_73_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1033", 4)

				for iter_76_0 = 0, arg_73_1.actors_["1033"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["1033"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_6" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_76_2 = arg_73_1.actors_["10034"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10034 == nil then
				arg_73_1.var_.actorSpriteComps10034 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10034 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								iter_76_2.color = Color.New(Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_2.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_2.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10034 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10034 = nil
			end

			local var_76_5 = arg_73_1.actors_["1033"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps1033 == nil then
				arg_73_1.var_.actorSpriteComps1033 = var_76_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.actorSpriteComps1033 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								iter_76_6.color = Color.New(Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_6), Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_6), (Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_6)))
							else
								local var_76_7 = Mathf.Lerp(iter_76_6.color.r, 1, (arg_73_1.time_ - 0) / var_76_6)

								iter_76_6.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.actorSpriteComps1033 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_76_8 then
						iter_76_8.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1033 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.45

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(117101018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 18 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 18)

				if (18 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 18)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101018", "story_v_out_117101.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101018", "story_v_out_117101.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_117101", "117101018", "story_v_out_117101.awb")

						arg_73_1:RecordAudio("117101018", var_76_15)
						arg_73_1:RecordAudio("117101018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_117101", "117101018", "story_v_out_117101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_117101", "117101018", "story_v_out_117101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play117101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 117101019
		arg_77_1.duration_ = 12

		local var_77_0 = {
			zh = 6.5,
			ja = 12
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
				arg_77_0:Play117101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10034"]) and arg_77_1.var_.actorSpriteComps10034 == nil then
				arg_77_1.var_.actorSpriteComps10034 = arg_77_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10034"]) then
				if arg_77_1.var_.actorSpriteComps10034 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10034"]) and arg_77_1.var_.actorSpriteComps10034 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10034 = nil
			end

			local var_80_2 = arg_77_1.actors_["1033"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1033 == nil then
				arg_77_1.var_.actorSpriteComps1033 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1033 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1033 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1033 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.675

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(117101019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 27 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 27)

				if (27 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 27)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101019", "story_v_out_117101.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101019", "story_v_out_117101.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_117101", "117101019", "story_v_out_117101.awb")

						arg_77_1:RecordAudio("117101019", var_80_12)
						arg_77_1:RecordAudio("117101019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_117101", "117101019", "story_v_out_117101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_117101", "117101019", "story_v_out_117101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play117101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 117101020
		arg_81_1.duration_ = 7.4

		local var_81_0 = {
			zh = 6.5,
			ja = 7.4
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
				arg_81_0:Play117101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1033 = arg_81_1.actors_["1033"].transform.localPosition
				arg_81_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1033", 4)

				for iter_84_0 = 0, arg_81_1.actors_["1033"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["1033"].transform:GetChild(iter_84_0)

					if var_84_0.name == "split_4" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_84_2 = arg_81_1.actors_["10034"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10034 == nil then
				arg_81_1.var_.actorSpriteComps10034 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10034 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10034 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10034 = nil
			end

			local var_84_5 = arg_81_1.actors_["1033"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1033 == nil then
				arg_81_1.var_.actorSpriteComps1033 = var_84_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_6 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.actorSpriteComps1033 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								iter_84_6.color = Color.New(Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_6), Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_6), (Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_6)))
							else
								local var_84_7 = Mathf.Lerp(iter_84_6.color.r, 1, (arg_81_1.time_ - 0) / var_84_6)

								iter_84_6.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.actorSpriteComps1033 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_84_8 then
						iter_84_8.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1033 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.75

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(117101020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 30 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 30)

				if (30 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 30)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101020", "story_v_out_117101.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101020", "story_v_out_117101.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_117101", "117101020", "story_v_out_117101.awb")

						arg_81_1:RecordAudio("117101020", var_84_15)
						arg_81_1:RecordAudio("117101020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_117101", "117101020", "story_v_out_117101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_117101", "117101020", "story_v_out_117101.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play117101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 117101021
		arg_85_1.duration_ = 6.47

		local var_85_0 = {
			zh = 6.466,
			ja = 5.3
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
				arg_85_0:Play117101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10034 = arg_85_1.actors_["10034"].transform.localPosition
				arg_85_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10034", 2)

				for iter_88_0 = 0, arg_85_1.actors_["10034"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10034"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_5" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_85_1.time_ - 0) / var_88_1)
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_88_2 = arg_85_1.actors_["10034"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10034 == nil then
				arg_85_1.var_.actorSpriteComps10034 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10034 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								iter_88_2.color = Color.New(Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_2.color.r, 1, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_2.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10034 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_88_4 then
						iter_88_4.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10034 = nil
			end

			local var_88_5 = arg_85_1.actors_["1033"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps1033 == nil then
				arg_85_1.var_.actorSpriteComps1033 = var_88_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.actorSpriteComps1033 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								iter_88_6.color = Color.New(Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_6), Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_6), (Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_6)))
							else
								local var_88_7 = Mathf.Lerp(iter_88_6.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_6)

								iter_88_6.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.actorSpriteComps1033 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_88_8 then
						iter_88_8.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1033 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.7

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(117101021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 28 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 28)

				if (28 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 28)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101021", "story_v_out_117101.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101021", "story_v_out_117101.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_117101", "117101021", "story_v_out_117101.awb")

						arg_85_1:RecordAudio("117101021", var_88_15)
						arg_85_1:RecordAudio("117101021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_117101", "117101021", "story_v_out_117101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_117101", "117101021", "story_v_out_117101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play117101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 117101022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play117101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1033 = arg_89_1.actors_["1033"].transform.localPosition
				arg_89_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1033", 4)

				for iter_92_0 = 0, arg_89_1.actors_["1033"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["1033"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_6" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_92_2 = arg_89_1.actors_["10034"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10034 == nil then
				arg_89_1.var_.actorSpriteComps10034 = var_92_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_3 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.actorSpriteComps10034 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								iter_92_2.color = Color.New(Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, (arg_89_1.time_ - 0) / var_92_3), Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, (arg_89_1.time_ - 0) / var_92_3), (Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, (arg_89_1.time_ - 0) / var_92_3)))
							else
								local var_92_4 = Mathf.Lerp(iter_92_2.color.r, 0.5, (arg_89_1.time_ - 0) / var_92_3)

								iter_92_2.color = Color.New(var_92_4, var_92_4, var_92_4)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.actorSpriteComps10034 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_92_4 then
						iter_92_4.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_89_1.var_.actorSpriteComps10034 = nil
			end

			local var_92_5 = 0
			local var_92_6 = 0.7

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(117101022).content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 28 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 28)

				if (28 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 28)) > 0 and var_92_6 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_10 and arg_89_1.time_ < var_92_5 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play117101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 117101023
		arg_93_1.duration_ = 5.4

		local var_93_0 = {
			zh = 5.4,
			ja = 3.133
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
				arg_93_0:Play117101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1033 = arg_93_1.actors_["1033"].transform.localPosition
				arg_93_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1033", 4)

				for iter_96_0 = 0, arg_93_1.actors_["1033"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["1033"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_4" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_96_2 = arg_93_1.actors_["1033"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1033 == nil then
				arg_93_1.var_.actorSpriteComps1033 = var_96_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_3 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.actorSpriteComps1033 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								iter_96_2.color = Color.New(Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_3), Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_3), (Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_3)))
							else
								local var_96_4 = Mathf.Lerp(iter_96_2.color.r, 1, (arg_93_1.time_ - 0) / var_96_3)

								iter_96_2.color = Color.New(var_96_4, var_96_4, var_96_4)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.actorSpriteComps1033 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_96_4 then
						iter_96_4.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1033 = nil
			end

			local var_96_5 = 0
			local var_96_6 = 0.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(117101023)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 29 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 29)

				if (29 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 29)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101023", "story_v_out_117101.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101023", "story_v_out_117101.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_117101", "117101023", "story_v_out_117101.awb")

						arg_93_1:RecordAudio("117101023", var_96_12)
						arg_93_1:RecordAudio("117101023", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_117101", "117101023", "story_v_out_117101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_117101", "117101023", "story_v_out_117101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_13 and arg_93_1.time_ < var_96_5 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play117101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 117101024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play117101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1033"]) and arg_97_1.var_.actorSpriteComps1033 == nil then
				arg_97_1.var_.actorSpriteComps1033 = arg_97_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1033"]) then
				if arg_97_1.var_.actorSpriteComps1033 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1033"]) and arg_97_1.var_.actorSpriteComps1033 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1033 = nil
			end

			local var_100_2 = 0
			local var_100_3 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(117101024).content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 30 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 30)

				if (30 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 30)) > 0 and var_100_3 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_7 and arg_97_1.time_ < var_100_2 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play117101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 117101025
		arg_101_1.duration_ = 5.57

		local var_101_0 = {
			zh = 3.033,
			ja = 5.566
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
				arg_101_0:Play117101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1033 = arg_101_1.actors_["1033"].transform.localPosition
				arg_101_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1033", 4)

				for iter_104_0 = 0, arg_101_1.actors_["1033"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["1033"].transform:GetChild(iter_104_0)

					if var_104_0.name == "split_6" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_104_2 = arg_101_1.actors_["1033"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1033 == nil then
				arg_101_1.var_.actorSpriteComps1033 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps1033 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								iter_104_2.color = Color.New(Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_2.color.r, 1, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_2.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps1033 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps1033 = nil
			end

			local var_104_5 = 0
			local var_104_6 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(117101025)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 15 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 15)

				if (15 <= 0 and var_104_6 or var_104_6 * (utf8.len(var_104_8) / 15)) > 0 and var_104_6 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101025", "story_v_out_117101.awb") ~= 0 then
					local var_104_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101025", "story_v_out_117101.awb") / 1000

					if var_104_11 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_5
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_117101", "117101025", "story_v_out_117101.awb")

						arg_101_1:RecordAudio("117101025", var_104_12)
						arg_101_1:RecordAudio("117101025", var_104_12)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_117101", "117101025", "story_v_out_117101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_117101", "117101025", "story_v_out_117101.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_5) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_5 + var_104_13 and arg_101_1.time_ < var_104_5 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play117101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 117101026
		arg_105_1.duration_ = 4.83

		local var_105_0 = {
			zh = 2,
			ja = 4.833
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
				arg_105_0:Play117101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10034 = arg_105_1.actors_["10034"].transform.localPosition
				arg_105_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10034", 2)

				for iter_108_0 = 0, arg_105_1.actors_["10034"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10034"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_2" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_108_2 = arg_105_1.actors_["10034"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10034 == nil then
				arg_105_1.var_.actorSpriteComps10034 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10034 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								iter_108_2.color = Color.New(Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_3), Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_3), (Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_3)))
							else
								local var_108_4 = Mathf.Lerp(iter_108_2.color.r, 1, (arg_105_1.time_ - 0) / var_108_3)

								iter_108_2.color = Color.New(var_108_4, var_108_4, var_108_4)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10034 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10034 = nil
			end

			local var_108_5 = arg_105_1.actors_["1033"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1033 == nil then
				arg_105_1.var_.actorSpriteComps1033 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps1033 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								iter_108_6.color = Color.New(Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_6.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_6.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps1033 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_108_8 then
						iter_108_8.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps1033 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.225

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(117101026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 9 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 9)

				if (9 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 9)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101026", "story_v_out_117101.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101026", "story_v_out_117101.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_117101", "117101026", "story_v_out_117101.awb")

						arg_105_1:RecordAudio("117101026", var_108_15)
						arg_105_1:RecordAudio("117101026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_117101", "117101026", "story_v_out_117101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_117101", "117101026", "story_v_out_117101.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play117101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 117101027
		arg_109_1.duration_ = 6.03

		local var_109_0 = {
			zh = 5.366,
			ja = 6.033
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
				arg_109_0:Play117101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10034"]) and arg_109_1.var_.actorSpriteComps10034 == nil then
				arg_109_1.var_.actorSpriteComps10034 = arg_109_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10034"]) then
				if arg_109_1.var_.actorSpriteComps10034 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10034"]) and arg_109_1.var_.actorSpriteComps10034 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps10034 = nil
			end

			local var_112_2 = arg_109_1.actors_["1033"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1033 == nil then
				arg_109_1.var_.actorSpriteComps1033 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps1033 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								iter_112_5.color = Color.New(Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_5.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_5.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1033 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_112_7 then
						iter_112_7.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1033 = nil
			end

			local var_112_5 = 0
			local var_112_6 = 0.8

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(117101027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 32 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 32)

				if (32 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 32)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101027", "story_v_out_117101.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101027", "story_v_out_117101.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_117101", "117101027", "story_v_out_117101.awb")

						arg_109_1:RecordAudio("117101027", var_112_12)
						arg_109_1:RecordAudio("117101027", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_117101", "117101027", "story_v_out_117101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_117101", "117101027", "story_v_out_117101.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play117101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 117101028
		arg_113_1.duration_ = 1.5

		local var_113_0 = {
			zh = 1.5,
			ja = 1.2
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
				arg_113_0:Play117101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10034"]) and arg_113_1.var_.actorSpriteComps10034 == nil then
				arg_113_1.var_.actorSpriteComps10034 = arg_113_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10034"]) then
				if arg_113_1.var_.actorSpriteComps10034 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 1, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10034"]) and arg_113_1.var_.actorSpriteComps10034 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10034 = nil
			end

			local var_116_2 = arg_113_1.actors_["1033"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1033 == nil then
				arg_113_1.var_.actorSpriteComps1033 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps1033 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								iter_116_5.color = Color.New(Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_5.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_5.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps1033 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_116_7 then
						iter_116_7.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1033 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.075

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(117101028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 3 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 3)

				if (3 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 3)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101028", "story_v_out_117101.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101028", "story_v_out_117101.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_117101", "117101028", "story_v_out_117101.awb")

						arg_113_1:RecordAudio("117101028", var_116_12)
						arg_113_1:RecordAudio("117101028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_117101", "117101028", "story_v_out_117101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_117101", "117101028", "story_v_out_117101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play117101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 117101029
		arg_117_1.duration_ = 9.6

		local var_117_0 = {
			zh = 9.033,
			ja = 9.6
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
				arg_117_0:Play117101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1033"]) and arg_117_1.var_.actorSpriteComps1033 == nil then
				arg_117_1.var_.actorSpriteComps1033 = arg_117_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1033"]) then
				if arg_117_1.var_.actorSpriteComps1033 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1033"]) and arg_117_1.var_.actorSpriteComps1033 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1033 = nil
			end

			local var_120_2 = arg_117_1.actors_["10034"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10034 == nil then
				arg_117_1.var_.actorSpriteComps10034 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10034 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								iter_120_5.color = Color.New(Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_5.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_5.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10034 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_120_7 then
						iter_120_7.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10034 = nil
			end

			local var_120_5 = 0
			local var_120_6 = 1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(117101029)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 40 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 40)

				if (40 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 40)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101029", "story_v_out_117101.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101029", "story_v_out_117101.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_117101", "117101029", "story_v_out_117101.awb")

						arg_117_1:RecordAudio("117101029", var_120_12)
						arg_117_1:RecordAudio("117101029", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_117101", "117101029", "story_v_out_117101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_117101", "117101029", "story_v_out_117101.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play117101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 117101030
		arg_121_1.duration_ = 7.73

		local var_121_0 = {
			zh = 7.733,
			ja = 5.866
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
				arg_121_0:Play117101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1033"]) and arg_121_1.var_.actorSpriteComps1033 == nil then
				arg_121_1.var_.actorSpriteComps1033 = arg_121_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1033"]) then
				if arg_121_1.var_.actorSpriteComps1033 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								iter_124_1.color = Color.New(Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_0), Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_0), (Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_0)))
							else
								local var_124_1 = Mathf.Lerp(iter_124_1.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_0)

								iter_124_1.color = Color.New(var_124_1, var_124_1, var_124_1)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1033"]) and arg_121_1.var_.actorSpriteComps1033 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_124_3 then
						iter_124_3.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps1033 = nil
			end

			local var_124_2 = arg_121_1.actors_["10034"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10034 == nil then
				arg_121_1.var_.actorSpriteComps10034 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10034 then
					for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_124_5 then
							if arg_121_1.isInRecall_ then
								iter_124_5.color = Color.New(Mathf.Lerp(iter_124_5.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_5.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_5.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_5.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_5.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10034 then
				for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_124_7 then
						iter_124_7.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10034 = nil
			end

			local var_124_5 = 0
			local var_124_6 = 0.575

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(117101030)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 23 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 23)

				if (23 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 23)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101030", "story_v_out_117101.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101030", "story_v_out_117101.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_117101", "117101030", "story_v_out_117101.awb")

						arg_121_1:RecordAudio("117101030", var_124_12)
						arg_121_1:RecordAudio("117101030", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_117101", "117101030", "story_v_out_117101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_117101", "117101030", "story_v_out_117101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play117101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 117101031
		arg_125_1.duration_ = 2.07

		local var_125_0 = {
			zh = 1.233,
			ja = 2.066
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
				arg_125_0:Play117101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10034"]) and arg_125_1.var_.actorSpriteComps10034 == nil then
				arg_125_1.var_.actorSpriteComps10034 = arg_125_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10034"]) then
				if arg_125_1.var_.actorSpriteComps10034 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10034"]) and arg_125_1.var_.actorSpriteComps10034 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10034 = nil
			end

			local var_128_2 = 0
			local var_128_3 = 0.1

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_1")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_4 = arg_125_1:GetWordFromCfg(117101031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 4 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 4)

				if (4 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 4)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101031", "story_v_out_117101.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101031", "story_v_out_117101.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_117101", "117101031", "story_v_out_117101.awb")

						arg_125_1:RecordAudio("117101031", var_128_9)
						arg_125_1:RecordAudio("117101031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_117101", "117101031", "story_v_out_117101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_117101", "117101031", "story_v_out_117101.awb")
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
	Play117101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 117101032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play117101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(117101032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 14)

				if (14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 14)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play117101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 117101033
		arg_133_1.duration_ = 5.83

		local var_133_0 = {
			zh = 5.833,
			ja = 5.6
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play117101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10034 = arg_133_1.actors_["10034"].transform.localPosition
				arg_133_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10034", 2)

				for iter_136_0 = 0, arg_133_1.actors_["10034"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10034"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_2" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10034"].transform.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_136_2 = arg_133_1.actors_["10034"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10034 == nil then
				arg_133_1.var_.actorSpriteComps10034 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10034 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10034 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10034 = nil
			end

			local var_136_5 = 0
			local var_136_6 = 0.45

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(117101033)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 18 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 18)

				if (18 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 18)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101033", "story_v_out_117101.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101033", "story_v_out_117101.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_117101", "117101033", "story_v_out_117101.awb")

						arg_133_1:RecordAudio("117101033", var_136_12)
						arg_133_1:RecordAudio("117101033", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_117101", "117101033", "story_v_out_117101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_117101", "117101033", "story_v_out_117101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_13 and arg_133_1.time_ < var_136_5 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play117101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 117101034
		arg_137_1.duration_ = 7.03

		local var_137_0 = {
			zh = 7.033,
			ja = 6.533
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
				arg_137_0:Play117101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1033 = arg_137_1.actors_["1033"].transform.localPosition
				arg_137_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1033", 4)

				for iter_140_0 = 0, arg_137_1.actors_["1033"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["1033"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_6" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_140_2 = arg_137_1.actors_["10034"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10034 == nil then
				arg_137_1.var_.actorSpriteComps10034 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10034 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10034 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10034 = nil
			end

			local var_140_5 = arg_137_1.actors_["1033"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps1033 == nil then
				arg_137_1.var_.actorSpriteComps1033 = var_140_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_6 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.actorSpriteComps1033 then
					for iter_140_5, iter_140_6 in pairs(arg_137_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_140_6 then
							if arg_137_1.isInRecall_ then
								iter_140_6.color = Color.New(Mathf.Lerp(iter_140_6.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_6), Mathf.Lerp(iter_140_6.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_6), (Mathf.Lerp(iter_140_6.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_6)))
							else
								local var_140_7 = Mathf.Lerp(iter_140_6.color.r, 1, (arg_137_1.time_ - 0) / var_140_6)

								iter_140_6.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps1033 then
				for iter_140_7, iter_140_8 in pairs(arg_137_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_140_8 then
						iter_140_8.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps1033 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.875

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(117101034)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 35 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 35)

				if (35 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 35)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101034", "story_v_out_117101.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101034", "story_v_out_117101.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_117101", "117101034", "story_v_out_117101.awb")

						arg_137_1:RecordAudio("117101034", var_140_15)
						arg_137_1:RecordAudio("117101034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_117101", "117101034", "story_v_out_117101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_117101", "117101034", "story_v_out_117101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play117101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 117101035
		arg_141_1.duration_ = 12.2

		local var_141_0 = {
			zh = 8.166,
			ja = 12.2
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
				arg_141_0:Play117101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1033"]) and arg_141_1.var_.actorSpriteComps1033 == nil then
				arg_141_1.var_.actorSpriteComps1033 = arg_141_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1033"]) then
				if arg_141_1.var_.actorSpriteComps1033 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1033"]) and arg_141_1.var_.actorSpriteComps1033 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps1033 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 1.025

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_1")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_4 = arg_141_1:GetWordFromCfg(117101035)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 41 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 41)

				if (41 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 41)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101035", "story_v_out_117101.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101035", "story_v_out_117101.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_117101", "117101035", "story_v_out_117101.awb")

						arg_141_1:RecordAudio("117101035", var_144_9)
						arg_141_1:RecordAudio("117101035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_117101", "117101035", "story_v_out_117101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_117101", "117101035", "story_v_out_117101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play117101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 117101036
		arg_145_1.duration_ = 1.7

		local var_145_0 = {
			zh = 1.333,
			ja = 1.7
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
				arg_145_0:Play117101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1033 = arg_145_1.actors_["1033"].transform.localPosition
				arg_145_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1033", 4)

				for iter_148_0 = 0, arg_145_1.actors_["1033"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["1033"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_4" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["1033"].transform.localPosition = Vector3.New(390, -420, 0)
			end

			local var_148_2 = arg_145_1.actors_["10034"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10034 = var_148_2.localPosition
				var_148_2.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10034", 2)

				for iter_148_1 = 0, var_148_2.childCount - 1 do
					local var_148_3 = var_148_2:GetChild(iter_148_1)

					if var_148_3.name == "split_2" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_2.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10034, Vector3.New(-390, -415, -290), (arg_145_1.time_ - 0) / var_148_4)
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_2.localPosition = Vector3.New(-390, -415, -290)
			end

			local var_148_5 = arg_145_1.actors_["1033"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps1033 == nil then
				arg_145_1.var_.actorSpriteComps1033 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps1033 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								iter_148_3.color = Color.New(Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_3.color.r, 1, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_3.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps1033 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_148_5 then
						iter_148_5.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps1033 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(117101036)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 4 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 4)

				if (4 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 4)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101036", "story_v_out_117101.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101036", "story_v_out_117101.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_117101", "117101036", "story_v_out_117101.awb")

						arg_145_1:RecordAudio("117101036", var_148_15)
						arg_145_1:RecordAudio("117101036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_117101", "117101036", "story_v_out_117101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_117101", "117101036", "story_v_out_117101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play117101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 117101037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play117101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				local var_152_0 = arg_149_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_152_0 then
					arg_149_1.var_.alphaOldValue1033 = var_152_0.alpha
					arg_149_1.var_.characterEffect1033 = var_152_0
				end

				arg_149_1.var_.alphaOldValue1033 = 1
			end

			local var_152_1 = 0.333333333333333

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				if arg_149_1.var_.characterEffect1033 then
					arg_149_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_149_1.var_.alphaOldValue1033, 0, (arg_149_1.time_ - 0) / var_152_1)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 and arg_149_1.var_.characterEffect1033 then
				arg_149_1.var_.characterEffect1033.alpha = 0
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				local var_152_2 = arg_149_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_152_2 then
					arg_149_1.var_.alphaOldValue10034 = var_152_2.alpha
					arg_149_1.var_.characterEffect10034 = var_152_2
				end

				arg_149_1.var_.alphaOldValue10034 = 1
			end

			local var_152_3 = 0.333333333333333

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 then
				if arg_149_1.var_.characterEffect10034 then
					arg_149_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_149_1.var_.alphaOldValue10034, 0, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and arg_149_1.var_.characterEffect10034 then
				arg_149_1.var_.characterEffect10034.alpha = 0
			end

			local var_152_4 = 0
			local var_152_5 = 1.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(117101037).content)

				arg_149_1.text_.text = var_152_6

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_8 = 51 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_6) / 51)

				if (51 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_6) / 51)) > 0 and var_152_5 < var_152_8 then
					arg_149_1.talkMaxDuration = var_152_8

					if var_152_8 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_6
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_9 and arg_149_1.time_ < var_152_4 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play117101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 117101038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play117101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.825

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(117101038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 33 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 33)

				if (33 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 33)) > 0 and var_156_0 < var_156_3 then
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
	Play117101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 117101039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play117101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.725

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(117101039).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 69 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 69)

				if (69 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 69)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play117101040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 117101040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play117101041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(117101040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 36)

				if (36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 36)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play117101041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 117101041
		arg_165_1.duration_ = 7.6

		local var_165_0 = {
			zh = 5.8,
			ja = 7.6
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
				arg_165_0:Play117101042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1033 = arg_165_1.actors_["1033"].transform.localPosition
				arg_165_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1033", 2)

				for iter_168_0 = 0, arg_165_1.actors_["1033"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1033"].transform:GetChild(iter_168_0)

					if var_168_0.name == "split_6" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_168_2 = arg_165_1.actors_["1033"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1033 == nil then
				arg_165_1.var_.actorSpriteComps1033 = var_168_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_3 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.actorSpriteComps1033 then
					for iter_168_1, iter_168_2 in pairs(arg_165_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_168_2 then
							if arg_165_1.isInRecall_ then
								iter_168_2.color = Color.New(Mathf.Lerp(iter_168_2.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_3), Mathf.Lerp(iter_168_2.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_3), (Mathf.Lerp(iter_168_2.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_3)))
							else
								local var_168_4 = Mathf.Lerp(iter_168_2.color.r, 1, (arg_165_1.time_ - 0) / var_168_3)

								iter_168_2.color = Color.New(var_168_4, var_168_4, var_168_4)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.actorSpriteComps1033 then
				for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_168_4 then
						iter_168_4.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_5 = arg_165_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_5 then
					arg_165_1.var_.alphaOldValue1033 = var_168_5.alpha
					arg_165_1.var_.characterEffect1033 = var_168_5
				end

				arg_165_1.var_.alphaOldValue1033 = 0
			end

			local var_168_6 = 0.333333333333333

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 then
				if arg_165_1.var_.characterEffect1033 then
					arg_165_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_165_1.var_.alphaOldValue1033, 1, (arg_165_1.time_ - 0) / var_168_6)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and arg_165_1.var_.characterEffect1033 then
				arg_165_1.var_.characterEffect1033.alpha = 1
			end

			local var_168_7 = arg_165_1.actors_["10034"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10034 = var_168_7.localPosition
				var_168_7.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10034", 4)

				for iter_168_5 = 0, var_168_7.childCount - 1 do
					local var_168_8 = var_168_7:GetChild(iter_168_5)

					if var_168_8.name == "split_2" or not string.find(var_168_8.name, "split") then
						var_168_8.gameObject:SetActive(true)
					else
						var_168_8.gameObject:SetActive(false)
					end
				end
			end

			local var_168_9 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 then
				var_168_7.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_165_1.time_ - 0) / var_168_9)
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 then
				var_168_7.localPosition = Vector3.New(390, -415, -290)
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_10 = arg_165_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_10 then
					arg_165_1.var_.alphaOldValue10034 = var_168_10.alpha
					arg_165_1.var_.characterEffect10034 = var_168_10
				end

				arg_165_1.var_.alphaOldValue10034 = 0
			end

			local var_168_11 = 0.333333333333333

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_11 then
				if arg_165_1.var_.characterEffect10034 then
					arg_165_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_165_1.var_.alphaOldValue10034, 1, (arg_165_1.time_ - 0) / var_168_11)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_11 and arg_165_1.time_ < 0 + var_168_11 + arg_168_0 and arg_165_1.var_.characterEffect10034 then
				arg_165_1.var_.characterEffect10034.alpha = 1
			end

			local var_168_12 = arg_165_1.actors_["10034"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_12) and arg_165_1.var_.actorSpriteComps10034 == nil then
				arg_165_1.var_.actorSpriteComps10034 = var_168_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_13 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_13 and not isNil(var_168_12) then
				if arg_165_1.var_.actorSpriteComps10034 then
					for iter_168_6, iter_168_7 in pairs(arg_165_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_168_7 then
							if arg_165_1.isInRecall_ then
								iter_168_7.color = Color.New(Mathf.Lerp(iter_168_7.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_13), Mathf.Lerp(iter_168_7.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_13), (Mathf.Lerp(iter_168_7.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_13)))
							else
								local var_168_14 = Mathf.Lerp(iter_168_7.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_13)

								iter_168_7.color = Color.New(var_168_14, var_168_14, var_168_14)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_13 and arg_165_1.time_ < 0 + var_168_13 + arg_168_0 and not isNil(var_168_12) and arg_165_1.var_.actorSpriteComps10034 then
				for iter_168_8, iter_168_9 in pairs(arg_165_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_168_9 then
						iter_168_9.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10034 = nil
			end

			local var_168_15 = 0
			local var_168_16 = 0.8

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_17 = arg_165_1:GetWordFromCfg(117101041)
				local var_168_18 = arg_165_1:FormatText(var_168_17.content)

				arg_165_1.text_.text = var_168_18

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 32 <= 0 and var_168_16 or var_168_16 * (utf8.len(var_168_18) / 32)

				if (32 <= 0 and var_168_16 or var_168_16 * (utf8.len(var_168_18) / 32)) > 0 and var_168_16 < var_168_20 then
					arg_165_1.talkMaxDuration = var_168_20

					if var_168_20 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_20 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_18
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101041", "story_v_out_117101.awb") ~= 0 then
					local var_168_21 = manager.audio:GetVoiceLength("story_v_out_117101", "117101041", "story_v_out_117101.awb") / 1000

					if var_168_21 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_21 + var_168_15
					end

					if var_168_17.prefab_name ~= "" and arg_165_1.actors_[var_168_17.prefab_name] ~= nil then
						local var_168_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_17.prefab_name].transform, "story_v_out_117101", "117101041", "story_v_out_117101.awb")

						arg_165_1:RecordAudio("117101041", var_168_22)
						arg_165_1:RecordAudio("117101041", var_168_22)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_117101", "117101041", "story_v_out_117101.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_117101", "117101041", "story_v_out_117101.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_23 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_23 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_23

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_23 and arg_165_1.time_ < var_168_15 + var_168_23 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play117101042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 117101042
		arg_169_1.duration_ = 11.83

		local var_169_0 = {
			zh = 11.833,
			ja = 11.133
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
				arg_169_0:Play117101043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.4

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(117101042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 56 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 56)

				if (56 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 56)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101042", "story_v_out_117101.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101042", "story_v_out_117101.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_117101", "117101042", "story_v_out_117101.awb")

						arg_169_1:RecordAudio("117101042", var_172_6)
						arg_169_1:RecordAudio("117101042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_117101", "117101042", "story_v_out_117101.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_117101", "117101042", "story_v_out_117101.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play117101043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 117101043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play117101044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1033"]) and arg_173_1.var_.actorSpriteComps1033 == nil then
				arg_173_1.var_.actorSpriteComps1033 = arg_173_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1033"]) then
				if arg_173_1.var_.actorSpriteComps1033 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1033"]) and arg_173_1.var_.actorSpriteComps1033 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps1033 = nil
			end

			local var_176_2 = 0
			local var_176_3 = 0.85

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(117101043).content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_6 = 34 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 34)

				if (34 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_4) / 34)) > 0 and var_176_3 < var_176_6 then
					arg_173_1.talkMaxDuration = var_176_6

					if var_176_6 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_7 and arg_173_1.time_ < var_176_2 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play117101044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 117101044
		arg_177_1.duration_ = 6.7

		local var_177_0 = {
			zh = 4.933,
			ja = 6.7
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
				arg_177_0:Play117101045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10034"]) and arg_177_1.var_.actorSpriteComps10034 == nil then
				arg_177_1.var_.actorSpriteComps10034 = arg_177_1.actors_["10034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10034"]) then
				if arg_177_1.var_.actorSpriteComps10034 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10034"]) and arg_177_1.var_.actorSpriteComps10034 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10034 = nil
			end

			local var_180_2 = 0
			local var_180_3 = 0.475

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(117101044)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 19 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 19)

				if (19 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 19)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101044", "story_v_out_117101.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_117101", "117101044", "story_v_out_117101.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_out_117101", "117101044", "story_v_out_117101.awb")

						arg_177_1:RecordAudio("117101044", var_180_9)
						arg_177_1:RecordAudio("117101044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_117101", "117101044", "story_v_out_117101.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_117101", "117101044", "story_v_out_117101.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play117101045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 117101045
		arg_181_1.duration_ = 3.53

		local var_181_0 = {
			zh = 1.966,
			ja = 3.533
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play117101046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1033"]) and arg_181_1.var_.actorSpriteComps1033 == nil then
				arg_181_1.var_.actorSpriteComps1033 = arg_181_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1033"]) then
				if arg_181_1.var_.actorSpriteComps1033 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1033"]) and arg_181_1.var_.actorSpriteComps1033 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps1033 = nil
			end

			local var_184_2 = arg_181_1.actors_["10034"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10034 == nil then
				arg_181_1.var_.actorSpriteComps10034 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps10034 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps10034 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10034 = nil
			end

			local var_184_5 = 0
			local var_184_6 = 0.225

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:GetWordFromCfg(117101045)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 9 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 9)

				if (9 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 9)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101045", "story_v_out_117101.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101045", "story_v_out_117101.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_117101", "117101045", "story_v_out_117101.awb")

						arg_181_1:RecordAudio("117101045", var_184_12)
						arg_181_1:RecordAudio("117101045", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_117101", "117101045", "story_v_out_117101.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_117101", "117101045", "story_v_out_117101.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play117101046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 117101046
		arg_185_1.duration_ = 11.37

		local var_185_0 = {
			zh = 5.033,
			ja = 11.366
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
				arg_185_0:Play117101047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1033"]) and arg_185_1.var_.actorSpriteComps1033 == nil then
				arg_185_1.var_.actorSpriteComps1033 = arg_185_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1033"]) then
				if arg_185_1.var_.actorSpriteComps1033 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1033"]) and arg_185_1.var_.actorSpriteComps1033 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps1033 = nil
			end

			local var_188_2 = arg_185_1.actors_["10034"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10034 == nil then
				arg_185_1.var_.actorSpriteComps10034 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10034 then
					for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_188_5 then
							if arg_185_1.isInRecall_ then
								iter_188_5.color = Color.New(Mathf.Lerp(iter_188_5.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_5.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_5.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_5.color.r, 1, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_5.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10034 then
				for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_188_7 then
						iter_188_7.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10034 = nil
			end

			local var_188_5 = arg_185_1.actors_["10034"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10034 = var_188_5.localPosition
				var_188_5.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10034", 4)

				for iter_188_8 = 0, var_188_5.childCount - 1 do
					local var_188_6 = var_188_5:GetChild(iter_188_8)

					if var_188_6.name == "split_5" or not string.find(var_188_6.name, "split") then
						var_188_6.gameObject:SetActive(true)
					else
						var_188_6.gameObject:SetActive(false)
					end
				end
			end

			local var_188_7 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				var_188_5.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_185_1.time_ - 0) / var_188_7)
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				var_188_5.localPosition = Vector3.New(390, -415, -290)
			end

			local var_188_8 = 0
			local var_188_9 = 0.55

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(117101046)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 22 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 22)

				if (22 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 22)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101046", "story_v_out_117101.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101046", "story_v_out_117101.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_117101", "117101046", "story_v_out_117101.awb")

						arg_185_1:RecordAudio("117101046", var_188_15)
						arg_185_1:RecordAudio("117101046", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_117101", "117101046", "story_v_out_117101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_117101", "117101046", "story_v_out_117101.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play117101047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 117101047
		arg_189_1.duration_ = 9.37

		local var_189_0 = {
			zh = 5.966,
			ja = 9.366
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
				arg_189_0:Play117101048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1033"]) and arg_189_1.var_.actorSpriteComps1033 == nil then
				arg_189_1.var_.actorSpriteComps1033 = arg_189_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1033"]) then
				if arg_189_1.var_.actorSpriteComps1033 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1033"]) and arg_189_1.var_.actorSpriteComps1033 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps1033 = nil
			end

			local var_192_2 = arg_189_1.actors_["10034"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10034 == nil then
				arg_189_1.var_.actorSpriteComps10034 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10034 then
					for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_192_5 then
							if arg_189_1.isInRecall_ then
								iter_192_5.color = Color.New(Mathf.Lerp(iter_192_5.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_5.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_5.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_5.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_5.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10034 then
				for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_192_7 then
						iter_192_7.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10034 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.725

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(117101047)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 29 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 29)

				if (29 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 29)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101047", "story_v_out_117101.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101047", "story_v_out_117101.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_117101", "117101047", "story_v_out_117101.awb")

						arg_189_1:RecordAudio("117101047", var_192_12)
						arg_189_1:RecordAudio("117101047", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_117101", "117101047", "story_v_out_117101.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_117101", "117101047", "story_v_out_117101.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play117101048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 117101048
		arg_193_1.duration_ = 14.5

		local var_193_0 = {
			zh = 11,
			ja = 14.5
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
				arg_193_0:Play117101049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10034 = arg_193_1.actors_["10034"].transform.localPosition
				arg_193_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10034", 4)

				for iter_196_0 = 0, arg_193_1.actors_["10034"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10034"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_5" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_196_2 = arg_193_1.actors_["1033"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1033 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1033", 2)

				for iter_196_1 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_1)

					if var_196_3.name == "split_6" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_196_5 = arg_193_1.actors_["1033"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1033 == nil then
				arg_193_1.var_.actorSpriteComps1033 = var_196_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_6 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.actorSpriteComps1033 then
					for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_196_3 then
							if arg_193_1.isInRecall_ then
								iter_196_3.color = Color.New(Mathf.Lerp(iter_196_3.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_6), Mathf.Lerp(iter_196_3.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_6), (Mathf.Lerp(iter_196_3.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_6)))
							else
								local var_196_7 = Mathf.Lerp(iter_196_3.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_6)

								iter_196_3.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.actorSpriteComps1033 then
				for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_196_5 then
						iter_196_5.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps1033 = nil
			end

			local var_196_8 = arg_193_1.actors_["10034"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10034 == nil then
				arg_193_1.var_.actorSpriteComps10034 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_9 and not isNil(var_196_8) then
				if arg_193_1.var_.actorSpriteComps10034 then
					for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_196_7 then
							if arg_193_1.isInRecall_ then
								iter_196_7.color = Color.New(Mathf.Lerp(iter_196_7.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_9), Mathf.Lerp(iter_196_7.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_9), (Mathf.Lerp(iter_196_7.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_9)))
							else
								local var_196_10 = Mathf.Lerp(iter_196_7.color.r, 1, (arg_193_1.time_ - 0) / var_196_9)

								iter_196_7.color = Color.New(var_196_10, var_196_10, var_196_10)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_9 and arg_193_1.time_ < 0 + var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10034 then
				for iter_196_8, iter_196_9 in pairs(arg_193_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_196_9 then
						iter_196_9.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10034 = nil
			end

			local var_196_11 = 0
			local var_196_12 = 1.2

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(117101048)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 48 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 48)

				if (48 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 48)) > 0 and var_196_12 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16

					if var_196_16 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101048", "story_v_out_117101.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_117101", "117101048", "story_v_out_117101.awb") / 1000

					if var_196_17 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_11
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_117101", "117101048", "story_v_out_117101.awb")

						arg_193_1:RecordAudio("117101048", var_196_18)
						arg_193_1:RecordAudio("117101048", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_117101", "117101048", "story_v_out_117101.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_117101", "117101048", "story_v_out_117101.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_19 and arg_193_1.time_ < var_196_11 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play117101049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 117101049
		arg_197_1.duration_ = 9.33

		local var_197_0 = {
			zh = 4.966,
			ja = 9.333
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
				arg_197_0:Play117101050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1033 = arg_197_1.actors_["1033"].transform.localPosition
				arg_197_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1033", 2)

				for iter_200_0 = 0, arg_197_1.actors_["1033"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1033"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_4" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_200_2 = arg_197_1.actors_["1033"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1033 == nil then
				arg_197_1.var_.actorSpriteComps1033 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps1033 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps1033 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps1033 = nil
			end

			local var_200_5 = arg_197_1.actors_["10034"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10034 == nil then
				arg_197_1.var_.actorSpriteComps10034 = var_200_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_6 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.actorSpriteComps10034 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								iter_200_6.color = Color.New(Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_6), Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_6), (Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_6)))
							else
								local var_200_7 = Mathf.Lerp(iter_200_6.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_6)

								iter_200_6.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.actorSpriteComps10034 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_200_8 then
						iter_200_8.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps10034 = nil
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_8 = arg_197_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_200_8 then
					arg_197_1.var_.alphaOldValue1033 = var_200_8.alpha
					arg_197_1.var_.characterEffect1033 = var_200_8
				end

				arg_197_1.var_.alphaOldValue1033 = 0
			end

			local var_200_9 = 0.0166666666666667

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_9 then
				if arg_197_1.var_.characterEffect1033 then
					arg_197_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_197_1.var_.alphaOldValue1033, 1, (arg_197_1.time_ - 0) / var_200_9)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_9 and arg_197_1.time_ < 0 + var_200_9 + arg_200_0 and arg_197_1.var_.characterEffect1033 then
				arg_197_1.var_.characterEffect1033.alpha = 1
			end

			local var_200_10 = 0
			local var_200_11 = 0.55

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_12 = arg_197_1:GetWordFromCfg(117101049)
				local var_200_13 = arg_197_1:FormatText(var_200_12.content)

				arg_197_1.text_.text = var_200_13

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_15 = 22 <= 0 and var_200_11 or var_200_11 * (utf8.len(var_200_13) / 22)

				if (22 <= 0 and var_200_11 or var_200_11 * (utf8.len(var_200_13) / 22)) > 0 and var_200_11 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_10
					end
				end

				arg_197_1.text_.text = var_200_13
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101049", "story_v_out_117101.awb") ~= 0 then
					local var_200_16 = manager.audio:GetVoiceLength("story_v_out_117101", "117101049", "story_v_out_117101.awb") / 1000

					if var_200_16 + var_200_10 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_10
					end

					if var_200_12.prefab_name ~= "" and arg_197_1.actors_[var_200_12.prefab_name] ~= nil then
						local var_200_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_12.prefab_name].transform, "story_v_out_117101", "117101049", "story_v_out_117101.awb")

						arg_197_1:RecordAudio("117101049", var_200_17)
						arg_197_1:RecordAudio("117101049", var_200_17)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_117101", "117101049", "story_v_out_117101.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_117101", "117101049", "story_v_out_117101.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_18 = math.max(var_200_11, arg_197_1.talkMaxDuration)

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_18 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_10) / var_200_18

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_10 + var_200_18 and arg_197_1.time_ < var_200_10 + var_200_18 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play117101050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 117101050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play117101051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1033"]) and arg_201_1.var_.actorSpriteComps1033 == nil then
				arg_201_1.var_.actorSpriteComps1033 = arg_201_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1033"]) then
				if arg_201_1.var_.actorSpriteComps1033 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1033"]) and arg_201_1.var_.actorSpriteComps1033 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps1033 = nil
			end

			local var_204_2 = 0
			local var_204_3 = 1.675

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(117101050).content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_6 = 67 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 67)

				if (67 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_4) / 67)) > 0 and var_204_3 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_7 and arg_201_1.time_ < var_204_2 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play117101051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 117101051
		arg_205_1.duration_ = 2.4

		local var_205_0 = {
			zh = 2.4,
			ja = 1.966
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
				arg_205_0:Play117101052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10034 = arg_205_1.actors_["10034"].transform.localPosition
				arg_205_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10034", 4)

				for iter_208_0 = 0, arg_205_1.actors_["10034"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10034"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_5" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_208_2 = arg_205_1.actors_["10034"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10034 == nil then
				arg_205_1.var_.actorSpriteComps10034 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10034 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10034 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10034 = nil
			end

			local var_208_5 = 0
			local var_208_6 = 0.275

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:GetWordFromCfg(117101051)
				local var_208_8 = arg_205_1:FormatText(var_208_7.content)

				arg_205_1.text_.text = var_208_8

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 11 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 11)

				if (11 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_8) / 11)) > 0 and var_208_6 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_8
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101051", "story_v_out_117101.awb") ~= 0 then
					local var_208_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101051", "story_v_out_117101.awb") / 1000

					if var_208_11 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_5
					end

					if var_208_7.prefab_name ~= "" and arg_205_1.actors_[var_208_7.prefab_name] ~= nil then
						local var_208_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_7.prefab_name].transform, "story_v_out_117101", "117101051", "story_v_out_117101.awb")

						arg_205_1:RecordAudio("117101051", var_208_12)
						arg_205_1:RecordAudio("117101051", var_208_12)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_117101", "117101051", "story_v_out_117101.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_117101", "117101051", "story_v_out_117101.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_13 and arg_205_1.time_ < var_208_5 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play117101052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 117101052
		arg_209_1.duration_ = 9.2

		local var_209_0 = {
			zh = 9.2,
			ja = 8.933
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play117101053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1033 = arg_209_1.actors_["1033"].transform.localPosition
				arg_209_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1033", 2)

				for iter_212_0 = 0, arg_209_1.actors_["1033"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["1033"].transform:GetChild(iter_212_0)

					if var_212_0.name == "split_6" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_212_2 = arg_209_1.actors_["1033"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1033 == nil then
				arg_209_1.var_.actorSpriteComps1033 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps1033 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								iter_212_2.color = Color.New(Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_2.color.r, 1, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_2.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps1033 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_212_4 then
						iter_212_4.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps1033 = nil
			end

			local var_212_5 = arg_209_1.actors_["10034"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10034 == nil then
				arg_209_1.var_.actorSpriteComps10034 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10034 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								iter_212_6.color = Color.New(Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_6.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_6.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10034 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_212_8 then
						iter_212_8.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10034 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 1.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(117101052)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 46 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 46)

				if (46 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 46)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101052", "story_v_out_117101.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101052", "story_v_out_117101.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_117101", "117101052", "story_v_out_117101.awb")

						arg_209_1:RecordAudio("117101052", var_212_15)
						arg_209_1:RecordAudio("117101052", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_117101", "117101052", "story_v_out_117101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_117101", "117101052", "story_v_out_117101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play117101053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 117101053
		arg_213_1.duration_ = 11.7

		local var_213_0 = {
			zh = 7.966,
			ja = 11.7
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
				arg_213_0:Play117101054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(117101053)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 42 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 42)

				if (42 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 42)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101053", "story_v_out_117101.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101053", "story_v_out_117101.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_117101", "117101053", "story_v_out_117101.awb")

						arg_213_1:RecordAudio("117101053", var_216_6)
						arg_213_1:RecordAudio("117101053", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_117101", "117101053", "story_v_out_117101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_117101", "117101053", "story_v_out_117101.awb")
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
	Play117101054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 117101054
		arg_217_1.duration_ = 3.07

		local var_217_0 = {
			zh = 2.4,
			ja = 3.066
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
				arg_217_0:Play117101055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10034 = arg_217_1.actors_["10034"].transform.localPosition
				arg_217_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10034", 4)

				for iter_220_0 = 0, arg_217_1.actors_["10034"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10034"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_3" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_220_2 = arg_217_1.actors_["1033"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1033 == nil then
				arg_217_1.var_.actorSpriteComps1033 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps1033 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								iter_220_2.color = Color.New(Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_2.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_2.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps1033 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps1033 = nil
			end

			local var_220_5 = arg_217_1.actors_["10034"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.actorSpriteComps10034 == nil then
				arg_217_1.var_.actorSpriteComps10034 = var_220_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_6 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_6 and not isNil(var_220_5) then
				if arg_217_1.var_.actorSpriteComps10034 then
					for iter_220_5, iter_220_6 in pairs(arg_217_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_220_6 then
							if arg_217_1.isInRecall_ then
								iter_220_6.color = Color.New(Mathf.Lerp(iter_220_6.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_6), Mathf.Lerp(iter_220_6.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_6), (Mathf.Lerp(iter_220_6.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_6)))
							else
								local var_220_7 = Mathf.Lerp(iter_220_6.color.r, 1, (arg_217_1.time_ - 0) / var_220_6)

								iter_220_6.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_6 and arg_217_1.time_ < 0 + var_220_6 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.actorSpriteComps10034 then
				for iter_220_7, iter_220_8 in pairs(arg_217_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_220_8 then
						iter_220_8.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10034 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.275

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(117101054)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 11 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 11)

				if (11 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 11)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101054", "story_v_out_117101.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101054", "story_v_out_117101.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_117101", "117101054", "story_v_out_117101.awb")

						arg_217_1:RecordAudio("117101054", var_220_15)
						arg_217_1:RecordAudio("117101054", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_117101", "117101054", "story_v_out_117101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_117101", "117101054", "story_v_out_117101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play117101055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 117101055
		arg_221_1.duration_ = 4.5

		local var_221_0 = {
			zh = 3.633,
			ja = 4.5
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play117101056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1033"]) and arg_221_1.var_.actorSpriteComps1033 == nil then
				arg_221_1.var_.actorSpriteComps1033 = arg_221_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1033"]) then
				if arg_221_1.var_.actorSpriteComps1033 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 1, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1033"]) and arg_221_1.var_.actorSpriteComps1033 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps1033 = nil
			end

			local var_224_2 = arg_221_1.actors_["10034"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10034 == nil then
				arg_221_1.var_.actorSpriteComps10034 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10034 then
					for iter_224_4, iter_224_5 in pairs(arg_221_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_224_5 then
							if arg_221_1.isInRecall_ then
								iter_224_5.color = Color.New(Mathf.Lerp(iter_224_5.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_5.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_5.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_5.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_5.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10034 then
				for iter_224_6, iter_224_7 in pairs(arg_221_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_224_7 then
						iter_224_7.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10034 = nil
			end

			local var_224_5 = 0
			local var_224_6 = 0.375

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_7 = arg_221_1:GetWordFromCfg(117101055)
				local var_224_8 = arg_221_1:FormatText(var_224_7.content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 15 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 15)

				if (15 <= 0 and var_224_6 or var_224_6 * (utf8.len(var_224_8) / 15)) > 0 and var_224_6 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_5
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101055", "story_v_out_117101.awb") ~= 0 then
					local var_224_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101055", "story_v_out_117101.awb") / 1000

					if var_224_11 + var_224_5 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_5
					end

					if var_224_7.prefab_name ~= "" and arg_221_1.actors_[var_224_7.prefab_name] ~= nil then
						local var_224_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_7.prefab_name].transform, "story_v_out_117101", "117101055", "story_v_out_117101.awb")

						arg_221_1:RecordAudio("117101055", var_224_12)
						arg_221_1:RecordAudio("117101055", var_224_12)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_117101", "117101055", "story_v_out_117101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_117101", "117101055", "story_v_out_117101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_13 = math.max(var_224_6, arg_221_1.talkMaxDuration)

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_13 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_5) / var_224_13

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_5 + var_224_13 and arg_221_1.time_ < var_224_5 + var_224_13 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play117101056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 117101056
		arg_225_1.duration_ = 1.6

		local var_225_0 = {
			zh = 1.133,
			ja = 1.6
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play117101057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10034 = arg_225_1.actors_["10034"].transform.localPosition
				arg_225_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10034", 4)

				for iter_228_0 = 0, arg_225_1.actors_["10034"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["10034"].transform:GetChild(iter_228_0)

					if var_228_0.name == "split_2" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_228_2 = arg_225_1.actors_["1033"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1033 == nil then
				arg_225_1.var_.actorSpriteComps1033 = var_228_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_3 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.actorSpriteComps1033 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								iter_228_2.color = Color.New(Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_3), Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_3), (Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_3)))
							else
								local var_228_4 = Mathf.Lerp(iter_228_2.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_3)

								iter_228_2.color = Color.New(var_228_4, var_228_4, var_228_4)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps1033 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_228_4 then
						iter_228_4.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps1033 = nil
			end

			local var_228_5 = arg_225_1.actors_["10034"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps10034 == nil then
				arg_225_1.var_.actorSpriteComps10034 = var_228_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_6 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.actorSpriteComps10034 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								iter_228_6.color = Color.New(Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_6), Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_6), (Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_6)))
							else
								local var_228_7 = Mathf.Lerp(iter_228_6.color.r, 1, (arg_225_1.time_ - 0) / var_228_6)

								iter_228_6.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.actorSpriteComps10034 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_228_8 then
						iter_228_8.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10034 = nil
			end

			local var_228_8 = 0
			local var_228_9 = 0.1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_10 = arg_225_1:GetWordFromCfg(117101056)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 4 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 4)

				if (4 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 4)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101056", "story_v_out_117101.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101056", "story_v_out_117101.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_out_117101", "117101056", "story_v_out_117101.awb")

						arg_225_1:RecordAudio("117101056", var_228_15)
						arg_225_1:RecordAudio("117101056", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_117101", "117101056", "story_v_out_117101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_117101", "117101056", "story_v_out_117101.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play117101057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 117101057
		arg_229_1.duration_ = 12.2

		local var_229_0 = {
			zh = 11,
			ja = 12.2
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
				arg_229_0:Play117101058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1033 = arg_229_1.actors_["1033"].transform.localPosition
				arg_229_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1033", 2)

				for iter_232_0 = 0, arg_229_1.actors_["1033"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["1033"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_6" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_232_2 = arg_229_1.actors_["1033"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1033 == nil then
				arg_229_1.var_.actorSpriteComps1033 = var_232_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_3 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.actorSpriteComps1033 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								iter_232_2.color = Color.New(Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_3), Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_3), (Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_3)))
							else
								local var_232_4 = Mathf.Lerp(iter_232_2.color.r, 1, (arg_229_1.time_ - 0) / var_232_3)

								iter_232_2.color = Color.New(var_232_4, var_232_4, var_232_4)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.actorSpriteComps1033 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_232_4 then
						iter_232_4.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps1033 = nil
			end

			local var_232_5 = arg_229_1.actors_["10034"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.actorSpriteComps10034 == nil then
				arg_229_1.var_.actorSpriteComps10034 = var_232_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_6 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.actorSpriteComps10034 then
					for iter_232_5, iter_232_6 in pairs(arg_229_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_232_6 then
							if arg_229_1.isInRecall_ then
								iter_232_6.color = Color.New(Mathf.Lerp(iter_232_6.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_6), Mathf.Lerp(iter_232_6.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_6), (Mathf.Lerp(iter_232_6.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_6)))
							else
								local var_232_7 = Mathf.Lerp(iter_232_6.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_6)

								iter_232_6.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.actorSpriteComps10034 then
				for iter_232_7, iter_232_8 in pairs(arg_229_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_232_8 then
						iter_232_8.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10034 = nil
			end

			local var_232_8 = 0
			local var_232_9 = 1.5

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:GetWordFromCfg(117101057)
				local var_232_11 = arg_229_1:FormatText(var_232_10.content)

				arg_229_1.text_.text = var_232_11

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_13 = 60 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 60)

				if (60 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_11) / 60)) > 0 and var_232_9 < var_232_13 then
					arg_229_1.talkMaxDuration = var_232_13

					if var_232_13 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_11
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101057", "story_v_out_117101.awb") ~= 0 then
					local var_232_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101057", "story_v_out_117101.awb") / 1000

					if var_232_14 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_14 + var_232_8
					end

					if var_232_10.prefab_name ~= "" and arg_229_1.actors_[var_232_10.prefab_name] ~= nil then
						local var_232_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_10.prefab_name].transform, "story_v_out_117101", "117101057", "story_v_out_117101.awb")

						arg_229_1:RecordAudio("117101057", var_232_15)
						arg_229_1:RecordAudio("117101057", var_232_15)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_117101", "117101057", "story_v_out_117101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_117101", "117101057", "story_v_out_117101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_16 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_16 and arg_229_1.time_ < var_232_8 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play117101058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 117101058
		arg_233_1.duration_ = 7.33

		local var_233_0 = {
			zh = 5.333,
			ja = 7.333
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play117101059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.75

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(117101058)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 30 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 30)

				if (30 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 30)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101058", "story_v_out_117101.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101058", "story_v_out_117101.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_117101", "117101058", "story_v_out_117101.awb")

						arg_233_1:RecordAudio("117101058", var_236_6)
						arg_233_1:RecordAudio("117101058", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_117101", "117101058", "story_v_out_117101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_117101", "117101058", "story_v_out_117101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play117101059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 117101059
		arg_237_1.duration_ = 1.47

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play117101060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10034 = arg_237_1.actors_["10034"].transform.localPosition
				arg_237_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10034", 4)

				for iter_240_0 = 0, arg_237_1.actors_["10034"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10034"].transform:GetChild(iter_240_0)

					if var_240_0.name == "split_2" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_240_2 = arg_237_1.actors_["1033"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1033 == nil then
				arg_237_1.var_.actorSpriteComps1033 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps1033 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps1033 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps1033 = nil
			end

			local var_240_5 = arg_237_1.actors_["10034"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10034 == nil then
				arg_237_1.var_.actorSpriteComps10034 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps10034 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								iter_240_6.color = Color.New(Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_6), Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_6), (Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_6)))
							else
								local var_240_7 = Mathf.Lerp(iter_240_6.color.r, 1, (arg_237_1.time_ - 0) / var_240_6)

								iter_240_6.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10034 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_240_8 then
						iter_240_8.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10034 = nil
			end

			local var_240_8 = 0
			local var_240_9 = 0.175

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(117101059)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 7 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 7)

				if (7 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 7)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101059", "story_v_out_117101.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101059", "story_v_out_117101.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_117101", "117101059", "story_v_out_117101.awb")

						arg_237_1:RecordAudio("117101059", var_240_15)
						arg_237_1:RecordAudio("117101059", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_117101", "117101059", "story_v_out_117101.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_117101", "117101059", "story_v_out_117101.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play117101060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 117101060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play117101061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				local var_244_0 = arg_241_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_244_0 then
					arg_241_1.var_.alphaOldValue10034 = var_244_0.alpha
					arg_241_1.var_.characterEffect10034 = var_244_0
				end

				arg_241_1.var_.alphaOldValue10034 = 1
			end

			local var_244_1 = 0.333333333333333

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 then
				if arg_241_1.var_.characterEffect10034 then
					arg_241_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_241_1.var_.alphaOldValue10034, 0, (arg_241_1.time_ - 0) / var_244_1)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 and arg_241_1.var_.characterEffect10034 then
				arg_241_1.var_.characterEffect10034.alpha = 0
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				local var_244_2 = arg_241_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_244_2 then
					arg_241_1.var_.alphaOldValue1033 = var_244_2.alpha
					arg_241_1.var_.characterEffect1033 = var_244_2
				end

				arg_241_1.var_.alphaOldValue1033 = 1
			end

			local var_244_3 = 0.333333333333333

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 then
				if arg_241_1.var_.characterEffect1033 then
					arg_241_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_241_1.var_.alphaOldValue1033, 0, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and arg_241_1.var_.characterEffect1033 then
				arg_241_1.var_.characterEffect1033.alpha = 0
			end

			local var_244_4 = 0
			local var_244_5 = 0.475

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(117101060).content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_8 = 19 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 19)

				if (19 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 19)) > 0 and var_244_5 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_9 and arg_241_1.time_ < var_244_4 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play117101061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 117101061
		arg_245_1.duration_ = 6.17

		local var_245_0 = {
			zh = 2.9,
			ja = 6.166
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
				arg_245_0:Play117101062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10034 = arg_245_1.actors_["10034"].transform.localPosition
				arg_245_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10034", 4)

				for iter_248_0 = 0, arg_245_1.actors_["10034"].transform.childCount - 1 do
					local var_248_0 = arg_245_1.actors_["10034"].transform:GetChild(iter_248_0)

					if var_248_0.name == "split_2" or not string.find(var_248_0.name, "split") then
						var_248_0.gameObject:SetActive(true)
					else
						var_248_0.gameObject:SetActive(false)
					end
				end
			end

			local var_248_1 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_1 then
				arg_245_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_245_1.time_ - 0) / var_248_1)
			end

			if arg_245_1.time_ >= 0 + var_248_1 and arg_245_1.time_ < 0 + var_248_1 + arg_248_0 then
				arg_245_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_248_2 = arg_245_1.actors_["1033"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1033 = var_248_2.localPosition
				var_248_2.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1033", 2)

				for iter_248_1 = 0, var_248_2.childCount - 1 do
					local var_248_3 = var_248_2:GetChild(iter_248_1)

					if var_248_3.name == "split_4" or not string.find(var_248_3.name, "split") then
						var_248_3.gameObject:SetActive(true)
					else
						var_248_3.gameObject:SetActive(false)
					end
				end
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_2.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_245_1.time_ - 0) / var_248_4)
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_248_5 = arg_245_1.actors_["1033"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.actorSpriteComps1033 == nil then
				arg_245_1.var_.actorSpriteComps1033 = var_248_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_6 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.actorSpriteComps1033 then
					for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_248_3 then
							if arg_245_1.isInRecall_ then
								iter_248_3.color = Color.New(Mathf.Lerp(iter_248_3.color.r, arg_245_1.hightColor1.r, (arg_245_1.time_ - 0) / var_248_6), Mathf.Lerp(iter_248_3.color.g, arg_245_1.hightColor1.g, (arg_245_1.time_ - 0) / var_248_6), (Mathf.Lerp(iter_248_3.color.b, arg_245_1.hightColor1.b, (arg_245_1.time_ - 0) / var_248_6)))
							else
								local var_248_7 = Mathf.Lerp(iter_248_3.color.r, 1, (arg_245_1.time_ - 0) / var_248_6)

								iter_248_3.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.actorSpriteComps1033 then
				for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_248_5 then
						iter_248_5.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_245_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_8 = arg_245_1.actors_["10034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_248_8 then
					arg_245_1.var_.alphaOldValue10034 = var_248_8.alpha
					arg_245_1.var_.characterEffect10034 = var_248_8
				end

				arg_245_1.var_.alphaOldValue10034 = 0
			end

			local var_248_9 = 0.333333333333333

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_9 then
				if arg_245_1.var_.characterEffect10034 then
					arg_245_1.var_.characterEffect10034.alpha = Mathf.Lerp(arg_245_1.var_.alphaOldValue10034, 1, (arg_245_1.time_ - 0) / var_248_9)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_9 and arg_245_1.time_ < 0 + var_248_9 + arg_248_0 and arg_245_1.var_.characterEffect10034 then
				arg_245_1.var_.characterEffect10034.alpha = 1
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_10 = arg_245_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_248_10 then
					arg_245_1.var_.alphaOldValue1033 = var_248_10.alpha
					arg_245_1.var_.characterEffect1033 = var_248_10
				end

				arg_245_1.var_.alphaOldValue1033 = 0
			end

			local var_248_11 = 0.333333333333333

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_11 then
				if arg_245_1.var_.characterEffect1033 then
					arg_245_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_245_1.var_.alphaOldValue1033, 1, (arg_245_1.time_ - 0) / var_248_11)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_11 and arg_245_1.time_ < 0 + var_248_11 + arg_248_0 and arg_245_1.var_.characterEffect1033 then
				arg_245_1.var_.characterEffect1033.alpha = 1
			end

			local var_248_12 = arg_245_1.actors_["10034"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_12) and arg_245_1.var_.actorSpriteComps10034 == nil then
				arg_245_1.var_.actorSpriteComps10034 = var_248_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_13 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_13 and not isNil(var_248_12) then
				if arg_245_1.var_.actorSpriteComps10034 then
					for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_248_7 then
							if arg_245_1.isInRecall_ then
								iter_248_7.color = Color.New(Mathf.Lerp(iter_248_7.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_13), Mathf.Lerp(iter_248_7.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_13), (Mathf.Lerp(iter_248_7.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_13)))
							else
								local var_248_14 = Mathf.Lerp(iter_248_7.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_13)

								iter_248_7.color = Color.New(var_248_14, var_248_14, var_248_14)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_13 and arg_245_1.time_ < 0 + var_248_13 + arg_248_0 and not isNil(var_248_12) and arg_245_1.var_.actorSpriteComps10034 then
				for iter_248_8, iter_248_9 in pairs(arg_245_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_248_9 then
						iter_248_9.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps10034 = nil
			end

			local var_248_15 = 0
			local var_248_16 = 0.425

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_17 = arg_245_1:GetWordFromCfg(117101061)
				local var_248_18 = arg_245_1:FormatText(var_248_17.content)

				arg_245_1.text_.text = var_248_18

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_20 = 17 <= 0 and var_248_16 or var_248_16 * (utf8.len(var_248_18) / 17)

				if (17 <= 0 and var_248_16 or var_248_16 * (utf8.len(var_248_18) / 17)) > 0 and var_248_16 < var_248_20 then
					arg_245_1.talkMaxDuration = var_248_20

					if var_248_20 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_20 + var_248_15
					end
				end

				arg_245_1.text_.text = var_248_18
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101061", "story_v_out_117101.awb") ~= 0 then
					local var_248_21 = manager.audio:GetVoiceLength("story_v_out_117101", "117101061", "story_v_out_117101.awb") / 1000

					if var_248_21 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_21 + var_248_15
					end

					if var_248_17.prefab_name ~= "" and arg_245_1.actors_[var_248_17.prefab_name] ~= nil then
						local var_248_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_17.prefab_name].transform, "story_v_out_117101", "117101061", "story_v_out_117101.awb")

						arg_245_1:RecordAudio("117101061", var_248_22)
						arg_245_1:RecordAudio("117101061", var_248_22)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_117101", "117101061", "story_v_out_117101.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_117101", "117101061", "story_v_out_117101.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_23 = math.max(var_248_16, arg_245_1.talkMaxDuration)

			if var_248_15 <= arg_245_1.time_ and arg_245_1.time_ < var_248_15 + var_248_23 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_15) / var_248_23

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_15 + var_248_23 and arg_245_1.time_ < var_248_15 + var_248_23 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play117101062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 117101062
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play117101063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10034 = arg_249_1.actors_["10034"].transform.localPosition
				arg_249_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10034", 4)

				for iter_252_0 = 0, arg_249_1.actors_["10034"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["10034"].transform:GetChild(iter_252_0)

					if var_252_0.name == "split_2" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_252_2 = arg_249_1.actors_["1033"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1033 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1033", 2)

				for iter_252_1 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_1)

					if var_252_3.name == "split_4" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_252_5 = arg_249_1.actors_["1033"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1033 == nil then
				arg_249_1.var_.actorSpriteComps1033 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps1033 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								iter_252_3.color = Color.New(Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_3.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_3.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps1033 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps1033 = nil
			end

			local var_252_8 = 0
			local var_252_9 = 0.75

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_10 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(117101062).content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_12 = 30 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_10) / 30)

				if (30 <= 0 and var_252_9 or var_252_9 * (utf8.len(var_252_10) / 30)) > 0 and var_252_9 < var_252_12 then
					arg_249_1.talkMaxDuration = var_252_12

					if var_252_12 + var_252_8 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_8
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_9, arg_249_1.talkMaxDuration)

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_8) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_8 + var_252_13 and arg_249_1.time_ < var_252_8 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play117101063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 117101063
		arg_253_1.duration_ = 4.07

		local var_253_0 = {
			zh = 4.066,
			ja = 4
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play117101064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.425

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_4")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(117101063)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 17 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 17)

				if (17 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 17)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101063", "story_v_out_117101.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101063", "story_v_out_117101.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_117101", "117101063", "story_v_out_117101.awb")

						arg_253_1:RecordAudio("117101063", var_256_6)
						arg_253_1:RecordAudio("117101063", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_117101", "117101063", "story_v_out_117101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_117101", "117101063", "story_v_out_117101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play117101064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 117101064
		arg_257_1.duration_ = 3.67

		local var_257_0 = {
			zh = 3.666,
			ja = 2.4
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
				arg_257_0:Play117101065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10034 = arg_257_1.actors_["10034"].transform.localPosition
				arg_257_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10034", 4)

				for iter_260_0 = 0, arg_257_1.actors_["10034"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["10034"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_5" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_260_2 = arg_257_1.actors_["10034"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10034 == nil then
				arg_257_1.var_.actorSpriteComps10034 = var_260_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_3 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.actorSpriteComps10034 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								iter_260_2.color = Color.New(Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, (arg_257_1.time_ - 0) / var_260_3), Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, (arg_257_1.time_ - 0) / var_260_3), (Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, (arg_257_1.time_ - 0) / var_260_3)))
							else
								local var_260_4 = Mathf.Lerp(iter_260_2.color.r, 1, (arg_257_1.time_ - 0) / var_260_3)

								iter_260_2.color = Color.New(var_260_4, var_260_4, var_260_4)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.actorSpriteComps10034 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_260_4 then
						iter_260_4.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_257_1.var_.actorSpriteComps10034 = nil
			end

			local var_260_5 = 0
			local var_260_6 = 0.4

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:GetWordFromCfg(117101064)
				local var_260_8 = arg_257_1:FormatText(var_260_7.content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 16 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 16)

				if (16 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_8) / 16)) > 0 and var_260_6 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101064", "story_v_out_117101.awb") ~= 0 then
					local var_260_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101064", "story_v_out_117101.awb") / 1000

					if var_260_11 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_5
					end

					if var_260_7.prefab_name ~= "" and arg_257_1.actors_[var_260_7.prefab_name] ~= nil then
						local var_260_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_7.prefab_name].transform, "story_v_out_117101", "117101064", "story_v_out_117101.awb")

						arg_257_1:RecordAudio("117101064", var_260_12)
						arg_257_1:RecordAudio("117101064", var_260_12)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_117101", "117101064", "story_v_out_117101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_117101", "117101064", "story_v_out_117101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_13 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_13 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_13

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_13 and arg_257_1.time_ < var_260_5 + var_260_13 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play117101065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 117101065
		arg_261_1.duration_ = 10.23

		local var_261_0 = {
			zh = 9.1,
			ja = 10.233
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
				arg_261_0:Play117101066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1033 = arg_261_1.actors_["1033"].transform.localPosition
				arg_261_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1033", 2)

				for iter_264_0 = 0, arg_261_1.actors_["1033"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["1033"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_6" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_264_2 = arg_261_1.actors_["1033"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1033 == nil then
				arg_261_1.var_.actorSpriteComps1033 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.0166666666666667

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps1033 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps1033 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps1033 = nil
			end

			local var_264_5 = arg_261_1.actors_["10034"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps10034 == nil then
				arg_261_1.var_.actorSpriteComps10034 = var_264_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_6 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_6 and not isNil(var_264_5) then
				if arg_261_1.var_.actorSpriteComps10034 then
					for iter_264_5, iter_264_6 in pairs(arg_261_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_264_6 then
							if arg_261_1.isInRecall_ then
								iter_264_6.color = Color.New(Mathf.Lerp(iter_264_6.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_6), Mathf.Lerp(iter_264_6.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_6), (Mathf.Lerp(iter_264_6.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_6)))
							else
								local var_264_7 = Mathf.Lerp(iter_264_6.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_6)

								iter_264_6.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_6 and arg_261_1.time_ < 0 + var_264_6 + arg_264_0 and not isNil(var_264_5) and arg_261_1.var_.actorSpriteComps10034 then
				for iter_264_7, iter_264_8 in pairs(arg_261_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_264_8 then
						iter_264_8.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10034 = nil
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				local var_264_8 = arg_261_1.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_264_8 then
					arg_261_1.var_.alphaOldValue1033 = var_264_8.alpha
					arg_261_1.var_.characterEffect1033 = var_264_8
				end

				arg_261_1.var_.alphaOldValue1033 = 0
			end

			local var_264_9 = 0.333333333333333

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_9 then
				if arg_261_1.var_.characterEffect1033 then
					arg_261_1.var_.characterEffect1033.alpha = Mathf.Lerp(arg_261_1.var_.alphaOldValue1033, 1, (arg_261_1.time_ - 0) / var_264_9)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_9 and arg_261_1.time_ < 0 + var_264_9 + arg_264_0 and arg_261_1.var_.characterEffect1033 then
				arg_261_1.var_.characterEffect1033.alpha = 1
			end

			local var_264_10 = 0
			local var_264_11 = 1.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_12 = arg_261_1:GetWordFromCfg(117101065)
				local var_264_13 = arg_261_1:FormatText(var_264_12.content)

				arg_261_1.text_.text = var_264_13

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 52 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 52)

				if (52 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 52)) > 0 and var_264_11 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_13
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101065", "story_v_out_117101.awb") ~= 0 then
					local var_264_16 = manager.audio:GetVoiceLength("story_v_out_117101", "117101065", "story_v_out_117101.awb") / 1000

					if var_264_16 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_10
					end

					if var_264_12.prefab_name ~= "" and arg_261_1.actors_[var_264_12.prefab_name] ~= nil then
						local var_264_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_12.prefab_name].transform, "story_v_out_117101", "117101065", "story_v_out_117101.awb")

						arg_261_1:RecordAudio("117101065", var_264_17)
						arg_261_1:RecordAudio("117101065", var_264_17)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_117101", "117101065", "story_v_out_117101.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_117101", "117101065", "story_v_out_117101.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_18 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_18

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_18 and arg_261_1.time_ < var_264_10 + var_264_18 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play117101066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 117101066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play117101067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033 = arg_265_1.actors_["1033"].transform.localPosition
				arg_265_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1033", 7)

				for iter_268_0 = 0, arg_265_1.actors_["1033"].transform.childCount - 1 do
					local var_268_0 = arg_265_1.actors_["1033"].transform:GetChild(iter_268_0)

					if var_268_0.name == "split_6" or not string.find(var_268_0.name, "split") then
						var_268_0.gameObject:SetActive(true)
					else
						var_268_0.gameObject:SetActive(false)
					end
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_265_1.time_ - 0) / var_268_1)
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_2 = arg_265_1.actors_["10034"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10034 = var_268_2.localPosition
				var_268_2.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10034", 7)

				for iter_268_1 = 0, var_268_2.childCount - 1 do
					local var_268_3 = var_268_2:GetChild(iter_268_1)

					if var_268_3.name == "split_5" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				var_268_2.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10034, Vector3.New(0, -2000, -290), (arg_265_1.time_ - 0) / var_268_4)
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				var_268_2.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_268_5 = 0
			local var_268_6 = 1.375

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(117101066).content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 55 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 55)

				if (55 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_7) / 55)) > 0 and var_268_6 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_10 and arg_265_1.time_ < var_268_5 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play117101067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 117101067
		arg_269_1.duration_ = 7.97

		local var_269_0 = {
			zh = 7.966,
			ja = 7.133
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play117101068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.95

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_1 = arg_269_1:GetWordFromCfg(117101067)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 38)

				if (38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 38)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101067", "story_v_out_117101.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101067", "story_v_out_117101.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_117101", "117101067", "story_v_out_117101.awb")

						arg_269_1:RecordAudio("117101067", var_272_6)
						arg_269_1:RecordAudio("117101067", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_117101", "117101067", "story_v_out_117101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_117101", "117101067", "story_v_out_117101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play117101068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 117101068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play117101069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.475

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(117101068).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 59 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 59)

				if (59 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 59)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play117101069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 117101069
		arg_277_1.duration_ = 7.13

		local var_277_0 = {
			zh = 5.4,
			ja = 7.133
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play117101070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1033 = arg_277_1.actors_["1033"].transform.localPosition
				arg_277_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1033", 3)

				for iter_280_0 = 0, arg_277_1.actors_["1033"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["1033"].transform:GetChild(iter_280_0)

					if var_280_0.name == "split_4" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["1033"].transform.localPosition = Vector3.New(0, -420, 0)
			end

			local var_280_2 = arg_277_1.actors_["1033"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1033 == nil then
				arg_277_1.var_.actorSpriteComps1033 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps1033 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps1033 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps1033 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 0.5

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(117101069)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 20 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 20)

				if (20 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 20)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101069", "story_v_out_117101.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101069", "story_v_out_117101.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_117101", "117101069", "story_v_out_117101.awb")

						arg_277_1:RecordAudio("117101069", var_280_12)
						arg_277_1:RecordAudio("117101069", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_117101", "117101069", "story_v_out_117101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_117101", "117101069", "story_v_out_117101.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play117101070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 117101070
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play117101071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1033"]) and arg_281_1.var_.actorSpriteComps1033 == nil then
				arg_281_1.var_.actorSpriteComps1033 = arg_281_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1033"]) then
				if arg_281_1.var_.actorSpriteComps1033 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1033"]) and arg_281_1.var_.actorSpriteComps1033 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps1033 = nil
			end

			local var_284_2 = 0
			local var_284_3 = 0.475

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(117101070).content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_6 = 19 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 19)

				if (19 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_4) / 19)) > 0 and var_284_3 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_7 and arg_281_1.time_ < var_284_2 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play117101071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 117101071
		arg_285_1.duration_ = 6.3

		local var_285_0 = {
			zh = 6.3,
			ja = 5.733
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play117101072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1033"]) and arg_285_1.var_.actorSpriteComps1033 == nil then
				arg_285_1.var_.actorSpriteComps1033 = arg_285_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1033"]) then
				if arg_285_1.var_.actorSpriteComps1033 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 1, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1033"]) and arg_285_1.var_.actorSpriteComps1033 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps1033 = nil
			end

			local var_288_2 = arg_285_1.actors_["1033"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1033 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1033", 3)

				for iter_288_4 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_4)

					if var_288_3.name == "split_6" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_288_5 = 0
			local var_288_6 = 0.725

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(117101071)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 29 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 29)

				if (29 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 29)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101071", "story_v_out_117101.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101071", "story_v_out_117101.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_117101", "117101071", "story_v_out_117101.awb")

						arg_285_1:RecordAudio("117101071", var_288_12)
						arg_285_1:RecordAudio("117101071", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_117101", "117101071", "story_v_out_117101.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_117101", "117101071", "story_v_out_117101.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play117101072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 117101072
		arg_289_1.duration_ = 7.37

		local var_289_0 = {
			zh = 5.8,
			ja = 7.366
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
				arg_289_0:Play117101073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10034 = arg_289_1.actors_["10034"].transform.localPosition
				arg_289_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10034", 4)

				for iter_292_0 = 0, arg_289_1.actors_["10034"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["10034"].transform:GetChild(iter_292_0)

					if var_292_0.name == "split_3" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_292_2 = arg_289_1.actors_["1033"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1033 == nil then
				arg_289_1.var_.actorSpriteComps1033 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps1033 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps1033 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps1033 = nil
			end

			local var_292_5 = arg_289_1.actors_["10034"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10034 == nil then
				arg_289_1.var_.actorSpriteComps10034 = var_292_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_6 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.actorSpriteComps10034 then
					for iter_292_5, iter_292_6 in pairs(arg_289_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_292_6 then
							if arg_289_1.isInRecall_ then
								iter_292_6.color = Color.New(Mathf.Lerp(iter_292_6.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_6), Mathf.Lerp(iter_292_6.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_6), (Mathf.Lerp(iter_292_6.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_6)))
							else
								local var_292_7 = Mathf.Lerp(iter_292_6.color.r, 1, (arg_289_1.time_ - 0) / var_292_6)

								iter_292_6.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.actorSpriteComps10034 then
				for iter_292_7, iter_292_8 in pairs(arg_289_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_292_8 then
						iter_292_8.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10034 = nil
			end

			local var_292_8 = arg_289_1.actors_["1033"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1033 = var_292_8.localPosition
				var_292_8.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1033", 2)

				for iter_292_9 = 0, var_292_8.childCount - 1 do
					local var_292_9 = var_292_8:GetChild(iter_292_9)

					if var_292_9.name == "split_6" or not string.find(var_292_9.name, "split") then
						var_292_9.gameObject:SetActive(true)
					else
						var_292_9.gameObject:SetActive(false)
					end
				end
			end

			local var_292_10 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_10 then
				var_292_8.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_289_1.time_ - 0) / var_292_10)
			end

			if arg_289_1.time_ >= 0 + var_292_10 and arg_289_1.time_ < 0 + var_292_10 + arg_292_0 then
				var_292_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_292_11 = 0
			local var_292_12 = 0.65

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_11 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_13 = arg_289_1:GetWordFromCfg(117101072)
				local var_292_14 = arg_289_1:FormatText(var_292_13.content)

				arg_289_1.text_.text = var_292_14

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_16 = 26 <= 0 and var_292_12 or var_292_12 * (utf8.len(var_292_14) / 26)

				if (26 <= 0 and var_292_12 or var_292_12 * (utf8.len(var_292_14) / 26)) > 0 and var_292_12 < var_292_16 then
					arg_289_1.talkMaxDuration = var_292_16

					if var_292_16 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_16 + var_292_11
					end
				end

				arg_289_1.text_.text = var_292_14
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101072", "story_v_out_117101.awb") ~= 0 then
					local var_292_17 = manager.audio:GetVoiceLength("story_v_out_117101", "117101072", "story_v_out_117101.awb") / 1000

					if var_292_17 + var_292_11 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_17 + var_292_11
					end

					if var_292_13.prefab_name ~= "" and arg_289_1.actors_[var_292_13.prefab_name] ~= nil then
						local var_292_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_13.prefab_name].transform, "story_v_out_117101", "117101072", "story_v_out_117101.awb")

						arg_289_1:RecordAudio("117101072", var_292_18)
						arg_289_1:RecordAudio("117101072", var_292_18)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_117101", "117101072", "story_v_out_117101.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_117101", "117101072", "story_v_out_117101.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_19 = math.max(var_292_12, arg_289_1.talkMaxDuration)

			if var_292_11 <= arg_289_1.time_ and arg_289_1.time_ < var_292_11 + var_292_19 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_11) / var_292_19

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_11 + var_292_19 and arg_289_1.time_ < var_292_11 + var_292_19 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play117101073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 117101073
		arg_293_1.duration_ = 8.03

		local var_293_0 = {
			zh = 8.033,
			ja = 5.666
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play117101074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1033 = arg_293_1.actors_["1033"].transform.localPosition
				arg_293_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1033", 2)

				for iter_296_0 = 0, arg_293_1.actors_["1033"].transform.childCount - 1 do
					local var_296_0 = arg_293_1.actors_["1033"].transform:GetChild(iter_296_0)

					if var_296_0.name == "split_6" or not string.find(var_296_0.name, "split") then
						var_296_0.gameObject:SetActive(true)
					else
						var_296_0.gameObject:SetActive(false)
					end
				end
			end

			local var_296_1 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 then
				arg_293_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_293_1.time_ - 0) / var_296_1)
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 then
				arg_293_1.actors_["1033"].transform.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_296_2 = arg_293_1.actors_["10034"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10034 == nil then
				arg_293_1.var_.actorSpriteComps10034 = var_296_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_3 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.actorSpriteComps10034 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								iter_296_2.color = Color.New(Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_3), Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_3), (Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_3)))
							else
								local var_296_4 = Mathf.Lerp(iter_296_2.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_3)

								iter_296_2.color = Color.New(var_296_4, var_296_4, var_296_4)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.actorSpriteComps10034 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_296_4 then
						iter_296_4.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps10034 = nil
			end

			local var_296_5 = 0
			local var_296_6 = 0.8

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_7 = arg_293_1:GetWordFromCfg(117101073)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 32 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 32)

				if (32 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 32)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101073", "story_v_out_117101.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101073", "story_v_out_117101.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_117101", "117101073", "story_v_out_117101.awb")

						arg_293_1:RecordAudio("117101073", var_296_12)
						arg_293_1:RecordAudio("117101073", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_117101", "117101073", "story_v_out_117101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_117101", "117101073", "story_v_out_117101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play117101074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 117101074
		arg_297_1.duration_ = 2.4

		local var_297_0 = {
			zh = 1.333,
			ja = 2.4
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play117101075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10034 = arg_297_1.actors_["10034"].transform.localPosition
				arg_297_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10034", 4)

				for iter_300_0 = 0, arg_297_1.actors_["10034"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["10034"].transform:GetChild(iter_300_0)

					if var_300_0.name == "split_2" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_300_2 = arg_297_1.actors_["10034"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps10034 == nil then
				arg_297_1.var_.actorSpriteComps10034 = var_300_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_3 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.actorSpriteComps10034 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								iter_300_2.color = Color.New(Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_3), Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_3), (Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_3)))
							else
								local var_300_4 = Mathf.Lerp(iter_300_2.color.r, 1, (arg_297_1.time_ - 0) / var_300_3)

								iter_300_2.color = Color.New(var_300_4, var_300_4, var_300_4)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.actorSpriteComps10034 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_300_4 then
						iter_300_4.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10034 = nil
			end

			local var_300_5 = arg_297_1.actors_["1033"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1033 = var_300_5.localPosition
				var_300_5.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1033", 2)

				for iter_300_5 = 0, var_300_5.childCount - 1 do
					local var_300_6 = var_300_5:GetChild(iter_300_5)

					if var_300_6.name == "split_6" or not string.find(var_300_6.name, "split") then
						var_300_6.gameObject:SetActive(true)
					else
						var_300_6.gameObject:SetActive(false)
					end
				end
			end

			local var_300_7 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				var_300_5.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_297_1.time_ - 0) / var_300_7)
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				var_300_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_300_8 = 0
			local var_300_9 = 0.125

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_10 = arg_297_1:GetWordFromCfg(117101074)
				local var_300_11 = arg_297_1:FormatText(var_300_10.content)

				arg_297_1.text_.text = var_300_11

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 5 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 5)

				if (5 <= 0 and var_300_9 or var_300_9 * (utf8.len(var_300_11) / 5)) > 0 and var_300_9 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_11
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101074", "story_v_out_117101.awb") ~= 0 then
					local var_300_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101074", "story_v_out_117101.awb") / 1000

					if var_300_14 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_14 + var_300_8
					end

					if var_300_10.prefab_name ~= "" and arg_297_1.actors_[var_300_10.prefab_name] ~= nil then
						local var_300_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_10.prefab_name].transform, "story_v_out_117101", "117101074", "story_v_out_117101.awb")

						arg_297_1:RecordAudio("117101074", var_300_15)
						arg_297_1:RecordAudio("117101074", var_300_15)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_117101", "117101074", "story_v_out_117101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_117101", "117101074", "story_v_out_117101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play117101075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 117101075
		arg_301_1.duration_ = 14.03

		local var_301_0 = {
			zh = 14.033,
			ja = 11.366
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play117101076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10034 = arg_301_1.actors_["10034"].transform.localPosition
				arg_301_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10034", 4)

				for iter_304_0 = 0, arg_301_1.actors_["10034"].transform.childCount - 1 do
					local var_304_0 = arg_301_1.actors_["10034"].transform:GetChild(iter_304_0)

					if var_304_0.name == "split_2" or not string.find(var_304_0.name, "split") then
						var_304_0.gameObject:SetActive(true)
					else
						var_304_0.gameObject:SetActive(false)
					end
				end
			end

			local var_304_1 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 then
				arg_301_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_301_1.time_ - 0) / var_304_1)
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 then
				arg_301_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_304_2 = arg_301_1.actors_["10034"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10034 == nil then
				arg_301_1.var_.actorSpriteComps10034 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps10034 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								iter_304_2.color = Color.New(Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_2.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_2.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10034 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_304_4 then
						iter_304_4.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10034 = nil
			end

			local var_304_5 = arg_301_1.actors_["1033"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1033 = var_304_5.localPosition
				var_304_5.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1033", 2)

				for iter_304_5 = 0, var_304_5.childCount - 1 do
					local var_304_6 = var_304_5:GetChild(iter_304_5)

					if var_304_6.name == "split_6" or not string.find(var_304_6.name, "split") then
						var_304_6.gameObject:SetActive(true)
					else
						var_304_6.gameObject:SetActive(false)
					end
				end
			end

			local var_304_7 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				var_304_5.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_301_1.time_ - 0) / var_304_7)
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				var_304_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_304_8 = 0
			local var_304_9 = 1.9

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_10 = arg_301_1:GetWordFromCfg(117101075)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_13 = 76 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 76)

				if (76 <= 0 and var_304_9 or var_304_9 * (utf8.len(var_304_11) / 76)) > 0 and var_304_9 < var_304_13 then
					arg_301_1.talkMaxDuration = var_304_13

					if var_304_13 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_13 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101075", "story_v_out_117101.awb") ~= 0 then
					local var_304_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101075", "story_v_out_117101.awb") / 1000

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_117101", "117101075", "story_v_out_117101.awb")

						arg_301_1:RecordAudio("117101075", var_304_15)
						arg_301_1:RecordAudio("117101075", var_304_15)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_117101", "117101075", "story_v_out_117101.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_117101", "117101075", "story_v_out_117101.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_16 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_16 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_16

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_16 and arg_301_1.time_ < var_304_8 + var_304_16 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play117101076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 117101076
		arg_305_1.duration_ = 5.9

		local var_305_0 = {
			zh = 3.633,
			ja = 5.9
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play117101077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.375

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[369].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10035_split_5")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(117101076)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 15 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 15)

				if (15 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 15)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101076", "story_v_out_117101.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101076", "story_v_out_117101.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_117101", "117101076", "story_v_out_117101.awb")

						arg_305_1:RecordAudio("117101076", var_308_6)
						arg_305_1:RecordAudio("117101076", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_117101", "117101076", "story_v_out_117101.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_117101", "117101076", "story_v_out_117101.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play117101077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 117101077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play117101078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.1

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(117101077).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 44 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 44)

				if (44 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 44)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play117101078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 117101078
		arg_313_1.duration_ = 5.47

		local var_313_0 = {
			zh = 4.833,
			ja = 5.466
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play117101079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10034 = arg_313_1.actors_["10034"].transform.localPosition
				arg_313_1.actors_["10034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10034", 4)

				for iter_316_0 = 0, arg_313_1.actors_["10034"].transform.childCount - 1 do
					local var_316_0 = arg_313_1.actors_["10034"].transform:GetChild(iter_316_0)

					if var_316_0.name == "split_2" or not string.find(var_316_0.name, "split") then
						var_316_0.gameObject:SetActive(true)
					else
						var_316_0.gameObject:SetActive(false)
					end
				end
			end

			local var_316_1 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 then
				arg_313_1.actors_["10034"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10034, Vector3.New(390, -415, -290), (arg_313_1.time_ - 0) / var_316_1)
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 then
				arg_313_1.actors_["10034"].transform.localPosition = Vector3.New(390, -415, -290)
			end

			local var_316_2 = arg_313_1.actors_["10034"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10034 == nil then
				arg_313_1.var_.actorSpriteComps10034 = var_316_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_3 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 and not isNil(var_316_2) then
				if arg_313_1.var_.actorSpriteComps10034 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps10034:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								iter_316_2.color = Color.New(Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_3), Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_3), (Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_3)))
							else
								local var_316_4 = Mathf.Lerp(iter_316_2.color.r, 1, (arg_313_1.time_ - 0) / var_316_3)

								iter_316_2.color = Color.New(var_316_4, var_316_4, var_316_4)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 and not isNil(var_316_2) and arg_313_1.var_.actorSpriteComps10034 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps10034:ToTable()) do
					if iter_316_4 then
						iter_316_4.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10034 = nil
			end

			local var_316_5 = arg_313_1.actors_["1033"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1033 = var_316_5.localPosition
				var_316_5.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1033", 2)

				for iter_316_5 = 0, var_316_5.childCount - 1 do
					local var_316_6 = var_316_5:GetChild(iter_316_5)

					if var_316_6.name == "split_6" or not string.find(var_316_6.name, "split") then
						var_316_6.gameObject:SetActive(true)
					else
						var_316_6.gameObject:SetActive(false)
					end
				end
			end

			local var_316_7 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				var_316_5.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1033, Vector3.New(-390, -420, 0), (arg_313_1.time_ - 0) / var_316_7)
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				var_316_5.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_316_8 = 0
			local var_316_9 = 0.55

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_10 = arg_313_1:GetWordFromCfg(117101078)
				local var_316_11 = arg_313_1:FormatText(var_316_10.content)

				arg_313_1.text_.text = var_316_11

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 22 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 22)

				if (22 <= 0 and var_316_9 or var_316_9 * (utf8.len(var_316_11) / 22)) > 0 and var_316_9 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_11
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101078", "story_v_out_117101.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_117101", "117101078", "story_v_out_117101.awb") / 1000

					if var_316_14 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_8
					end

					if var_316_10.prefab_name ~= "" and arg_313_1.actors_[var_316_10.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_10.prefab_name].transform, "story_v_out_117101", "117101078", "story_v_out_117101.awb")

						arg_313_1:RecordAudio("117101078", var_316_15)
						arg_313_1:RecordAudio("117101078", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_117101", "117101078", "story_v_out_117101.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_117101", "117101078", "story_v_out_117101.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play117101079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 117101079
		arg_317_1.duration_ = 9

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play117101080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if arg_317_1.bgs_.B01c == nil then
				local var_320_0 = Object.Instantiate(arg_317_1.paintGo_)

				var_320_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01c")
				var_320_0.name = "B01c"
				var_320_0.transform.parent = arg_317_1.stage_.transform
				var_320_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.bgs_.B01c = var_320_0
			end

			if 2 < arg_317_1.time_ and arg_317_1.time_ <= 2 + arg_320_0 then
				local var_320_1 = arg_317_1.bgs_.B01c

				arg_317_1.bgs_.B01c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_320_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_2 = var_320_1:GetComponent("SpriteRenderer")

				if var_320_2 and var_320_2.sprite then
					local var_320_3 = 2 * (var_320_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_320_1.transform.localScale = Vector3.New(var_320_3 / var_320_2.sprite.bounds.size.y < var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x and var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x or var_320_3 / var_320_2.sprite.bounds.size.y, var_320_3 / var_320_2.sprite.bounds.size.y < var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x and var_320_3 * manager.ui.mainCameraCom_.aspect / var_320_2.sprite.bounds.size.x or var_320_3 / var_320_2.sprite.bounds.size.y, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "B01c" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_4 = 0

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_5 = 2

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_5 then
				local var_320_6 = Color.New(0, 0, 0)

				var_320_6.a = Mathf.Lerp(0, 1, (arg_317_1.time_ - var_320_4) / var_320_5)
				arg_317_1.mask_.color = var_320_6
			end

			if arg_317_1.time_ >= var_320_4 + var_320_5 and arg_317_1.time_ < var_320_4 + var_320_5 + arg_320_0 then
				local var_320_7 = Color.New(0, 0, 0)

				var_320_7.a = 1
				arg_317_1.mask_.color = var_320_7
			end

			local var_320_8 = 2

			if 2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_9 = 2

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 then
				local var_320_10 = Color.New(0, 0, 0)

				var_320_10.a = Mathf.Lerp(1, 0, (arg_317_1.time_ - var_320_8) / var_320_9)
				arg_317_1.mask_.color = var_320_10
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 then
				local var_320_11 = Color.New(0, 0, 0)

				arg_317_1.mask_.enabled = false
				var_320_11.a = 0
				arg_317_1.mask_.color = var_320_11
			end

			local var_320_12 = arg_317_1.actors_["10034"].transform

			if 1.966 < arg_317_1.time_ and arg_317_1.time_ <= 1.966 + arg_320_0 then
				arg_317_1.var_.moveOldPos10034 = var_320_12.localPosition
				var_320_12.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10034", 7)

				for iter_320_2 = 0, var_320_12.childCount - 1 do
					local var_320_13 = var_320_12:GetChild(iter_320_2)

					if var_320_13.name == "split_2" or not string.find(var_320_13.name, "split") then
						var_320_13.gameObject:SetActive(true)
					else
						var_320_13.gameObject:SetActive(false)
					end
				end
			end

			local var_320_14 = 0.001

			if 1.966 <= arg_317_1.time_ and arg_317_1.time_ < 1.966 + var_320_14 then
				var_320_12.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10034, Vector3.New(0, -2000, -290), (arg_317_1.time_ - 1.966) / var_320_14)
			end

			if arg_317_1.time_ >= 1.966 + var_320_14 and arg_317_1.time_ < 1.966 + var_320_14 + arg_320_0 then
				var_320_12.localPosition = Vector3.New(0, -2000, -290)
			end

			local var_320_15 = arg_317_1.actors_["1033"].transform

			if 1.966 < arg_317_1.time_ and arg_317_1.time_ <= 1.966 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033 = var_320_15.localPosition
				var_320_15.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1033", 7)

				for iter_320_3 = 0, var_320_15.childCount - 1 do
					local var_320_16 = var_320_15:GetChild(iter_320_3)

					if var_320_16.name == "split_6" or not string.find(var_320_16.name, "split") then
						var_320_16.gameObject:SetActive(true)
					else
						var_320_16.gameObject:SetActive(false)
					end
				end
			end

			local var_320_17 = 0.001

			if 1.966 <= arg_317_1.time_ and arg_317_1.time_ < 1.966 + var_320_17 then
				var_320_15.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_317_1.time_ - 1.966) / var_320_17)
			end

			if arg_317_1.time_ >= 1.966 + var_320_17 and arg_317_1.time_ < 1.966 + var_320_17 + arg_320_0 then
				var_320_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_18 = 4
			local var_320_19 = 0.65

			if 4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_18 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_20 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_20:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_21 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(117101079).content)

				arg_317_1.text_.text = var_320_21

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_23 = 26 <= 0 and var_320_19 or var_320_19 * (utf8.len(var_320_21) / 26)

				if (26 <= 0 and var_320_19 or var_320_19 * (utf8.len(var_320_21) / 26)) > 0 and var_320_19 < var_320_23 then
					arg_317_1.talkMaxDuration = var_320_23
					var_320_18 = var_320_18 + 0.3

					if var_320_23 + var_320_18 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_18
					end
				end

				arg_317_1.text_.text = var_320_21
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_24 = var_320_18 + 0.3
			local var_320_25 = math.max(var_320_19, arg_317_1.talkMaxDuration)

			if var_320_18 + 0.3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_24 + var_320_25 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_24) / var_320_25

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_24 + var_320_25 and arg_317_1.time_ < var_320_24 + var_320_25 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play117101080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 117101080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play117101081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.95

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(117101080).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 38 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 38)

				if (38 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 38)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play117101081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 117101081
		arg_327_1.duration_ = 7

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play117101082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if arg_327_1.bgs_.B01b == nil then
				local var_330_0 = Object.Instantiate(arg_327_1.paintGo_)

				var_330_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01b")
				var_330_0.name = "B01b"
				var_330_0.transform.parent = arg_327_1.stage_.transform
				var_330_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.bgs_.B01b = var_330_0
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				local var_330_1 = arg_327_1.bgs_.B01b

				arg_327_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_330_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_2 = var_330_1:GetComponent("SpriteRenderer")

				if var_330_2 and var_330_2.sprite then
					local var_330_3 = 2 * (var_330_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_330_1.transform.localScale = Vector3.New(var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, 0)
				end

				for iter_330_0, iter_330_1 in pairs(arg_327_1.bgs_) do
					if iter_330_0 ~= "B01b" then
						iter_330_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_330_4 = 0

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_5 = 2

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_5 then
				local var_330_6 = Color.New(1, 1, 1)

				var_330_6.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_4) / var_330_5)
				arg_327_1.mask_.color = var_330_6
			end

			if arg_327_1.time_ >= var_330_4 + var_330_5 and arg_327_1.time_ < var_330_4 + var_330_5 + arg_330_0 then
				local var_330_7 = Color.New(1, 1, 1)

				arg_327_1.mask_.enabled = false
				var_330_7.a = 0
				arg_327_1.mask_.color = var_330_7
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_17", "se_story_17_headlamps", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_9 = 2
			local var_330_10 = 1.175

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_11 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_11:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_12 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(117101081).content)

				arg_327_1.text_.text = var_330_12

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_14 = 47 <= 0 and var_330_10 or var_330_10 * (utf8.len(var_330_12) / 47)

				if (47 <= 0 and var_330_10 or var_330_10 * (utf8.len(var_330_12) / 47)) > 0 and var_330_10 < var_330_14 then
					arg_327_1.talkMaxDuration = var_330_14
					var_330_9 = var_330_9 + 0.3

					if var_330_14 + var_330_9 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_9
					end
				end

				arg_327_1.text_.text = var_330_12
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_15 = var_330_9 + 0.3
			local var_330_16 = math.max(var_330_10, arg_327_1.talkMaxDuration)

			if var_330_9 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_16 and arg_327_1.time_ < var_330_15 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play117101082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 117101082
		arg_333_1.duration_ = 7.93

		local var_333_0 = {
			zh = 7.933,
			ja = 7.666
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
				arg_333_0:Play117101083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if arg_333_1.actors_["10036"] == nil then
				local var_336_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10036")

				if not isNil(var_336_0) then
					local var_336_1 = Object.Instantiate(var_336_0, arg_333_1.canvasGo_.transform)

					var_336_1.transform:SetSiblingIndex(1)

					var_336_1.name = "10036"
					var_336_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_333_1.actors_["10036"] = var_336_1

					if arg_333_1.isInRecall_ then
						for iter_336_0, iter_336_1 in ipairs((var_336_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_336_1.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_336_2 = arg_333_1.actors_["10036"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10036 = var_336_2.localPosition
				var_336_2.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10036", 2)

				for iter_336_2 = 0, var_336_2.childCount - 1 do
					local var_336_3 = var_336_2:GetChild(iter_336_2)

					if var_336_3.name == "split_1" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_2.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10036, Vector3.New(-390, -445, -290), (arg_333_1.time_ - 0) / var_336_4)
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_2.localPosition = Vector3.New(-390, -445, -290)
			end

			local var_336_5 = arg_333_1.actors_["10036"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.actorSpriteComps10036 == nil then
				arg_333_1.var_.actorSpriteComps10036 = var_336_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_6 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_6 and not isNil(var_336_5) then
				if arg_333_1.var_.actorSpriteComps10036 then
					for iter_336_3, iter_336_4 in pairs(arg_333_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_336_4 then
							if arg_333_1.isInRecall_ then
								iter_336_4.color = Color.New(Mathf.Lerp(iter_336_4.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_6), Mathf.Lerp(iter_336_4.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_6), (Mathf.Lerp(iter_336_4.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_6)))
							else
								local var_336_7 = Mathf.Lerp(iter_336_4.color.r, 1, (arg_333_1.time_ - 0) / var_336_6)

								iter_336_4.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_6 and arg_333_1.time_ < 0 + var_336_6 + arg_336_0 and not isNil(var_336_5) and arg_333_1.var_.actorSpriteComps10036 then
				for iter_336_5, iter_336_6 in pairs(arg_333_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_336_6 then
						iter_336_6.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps10036 = nil
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				local var_336_8 = arg_333_1.actors_["10036"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_336_8 then
					arg_333_1.var_.alphaOldValue10036 = var_336_8.alpha
					arg_333_1.var_.characterEffect10036 = var_336_8
				end

				arg_333_1.var_.alphaOldValue10036 = 0
			end

			local var_336_9 = 0.5

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_9 then
				if arg_333_1.var_.characterEffect10036 then
					arg_333_1.var_.characterEffect10036.alpha = Mathf.Lerp(arg_333_1.var_.alphaOldValue10036, 1, (arg_333_1.time_ - 0) / var_336_9)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_9 and arg_333_1.time_ < 0 + var_336_9 + arg_336_0 and arg_333_1.var_.characterEffect10036 then
				arg_333_1.var_.characterEffect10036.alpha = 1
			end

			local var_336_10 = 0
			local var_336_11 = 0.8

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_12 = arg_333_1:GetWordFromCfg(117101082)
				local var_336_13 = arg_333_1:FormatText(var_336_12.content)

				arg_333_1.text_.text = var_336_13

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_15 = 32 <= 0 and var_336_11 or var_336_11 * (utf8.len(var_336_13) / 32)

				if (32 <= 0 and var_336_11 or var_336_11 * (utf8.len(var_336_13) / 32)) > 0 and var_336_11 < var_336_15 then
					arg_333_1.talkMaxDuration = var_336_15

					if var_336_15 + var_336_10 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_15 + var_336_10
					end
				end

				arg_333_1.text_.text = var_336_13
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101082", "story_v_out_117101.awb") ~= 0 then
					local var_336_16 = manager.audio:GetVoiceLength("story_v_out_117101", "117101082", "story_v_out_117101.awb") / 1000

					if var_336_16 + var_336_10 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_10
					end

					if var_336_12.prefab_name ~= "" and arg_333_1.actors_[var_336_12.prefab_name] ~= nil then
						local var_336_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_12.prefab_name].transform, "story_v_out_117101", "117101082", "story_v_out_117101.awb")

						arg_333_1:RecordAudio("117101082", var_336_17)
						arg_333_1:RecordAudio("117101082", var_336_17)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_117101", "117101082", "story_v_out_117101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_117101", "117101082", "story_v_out_117101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_18 = math.max(var_336_11, arg_333_1.talkMaxDuration)

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_18 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_10) / var_336_18

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_10 + var_336_18 and arg_333_1.time_ < var_336_10 + var_336_18 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play117101083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 117101083
		arg_337_1.duration_ = 11.87

		local var_337_0 = {
			zh = 8.2,
			ja = 11.866
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play117101084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.95

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:GetWordFromCfg(117101083)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 38 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 38)

				if (38 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 38)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101083", "story_v_out_117101.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101083", "story_v_out_117101.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_117101", "117101083", "story_v_out_117101.awb")

						arg_337_1:RecordAudio("117101083", var_340_6)
						arg_337_1:RecordAudio("117101083", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_117101", "117101083", "story_v_out_117101.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_117101", "117101083", "story_v_out_117101.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play117101084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 117101084
		arg_341_1.duration_ = 7.2

		local var_341_0 = {
			zh = 6.6,
			ja = 7.2
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play117101085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if arg_341_1.actors_["1132"] == nil then
				local var_344_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1132")

				if not isNil(var_344_0) then
					local var_344_1 = Object.Instantiate(var_344_0, arg_341_1.canvasGo_.transform)

					var_344_1.transform:SetSiblingIndex(1)

					var_344_1.name = "1132"
					var_344_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_341_1.actors_["1132"] = var_344_1

					if arg_341_1.isInRecall_ then
						for iter_344_0, iter_344_1 in ipairs((var_344_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_344_1.color = arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_344_2 = arg_341_1.actors_["1132"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1132 = var_344_2.localPosition
				var_344_2.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1132", 4)

				for iter_344_2 = 0, var_344_2.childCount - 1 do
					local var_344_3 = var_344_2:GetChild(iter_344_2)

					if var_344_3.name == "split_6" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				var_344_2.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1132, Vector3.New(390, -413, -185), (arg_341_1.time_ - 0) / var_344_4)
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				var_344_2.localPosition = Vector3.New(390, -413, -185)
			end

			local var_344_5 = arg_341_1.actors_["10036"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10036 == nil then
				arg_341_1.var_.actorSpriteComps10036 = var_344_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_6 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_6 and not isNil(var_344_5) then
				if arg_341_1.var_.actorSpriteComps10036 then
					for iter_344_3, iter_344_4 in pairs(arg_341_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_344_4 then
							if arg_341_1.isInRecall_ then
								iter_344_4.color = Color.New(Mathf.Lerp(iter_344_4.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_6), Mathf.Lerp(iter_344_4.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_6), (Mathf.Lerp(iter_344_4.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_6)))
							else
								local var_344_7 = Mathf.Lerp(iter_344_4.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_6)

								iter_344_4.color = Color.New(var_344_7, var_344_7, var_344_7)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_6 and arg_341_1.time_ < 0 + var_344_6 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.actorSpriteComps10036 then
				for iter_344_5, iter_344_6 in pairs(arg_341_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_344_6 then
						iter_344_6.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps10036 = nil
			end

			local var_344_8 = arg_341_1.actors_["1132"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps1132 == nil then
				arg_341_1.var_.actorSpriteComps1132 = var_344_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_9 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_9 and not isNil(var_344_8) then
				if arg_341_1.var_.actorSpriteComps1132 then
					for iter_344_7, iter_344_8 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_344_8 then
							if arg_341_1.isInRecall_ then
								iter_344_8.color = Color.New(Mathf.Lerp(iter_344_8.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_9), Mathf.Lerp(iter_344_8.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_9), (Mathf.Lerp(iter_344_8.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_9)))
							else
								local var_344_10 = Mathf.Lerp(iter_344_8.color.r, 1, (arg_341_1.time_ - 0) / var_344_9)

								iter_344_8.color = Color.New(var_344_10, var_344_10, var_344_10)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_9 and arg_341_1.time_ < 0 + var_344_9 + arg_344_0 and not isNil(var_344_8) and arg_341_1.var_.actorSpriteComps1132 then
				for iter_344_9, iter_344_10 in pairs(arg_341_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_344_10 then
						iter_344_10.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps1132 = nil
			end

			local var_344_11 = 0
			local var_344_12 = 0.875

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_11 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:GetWordFromCfg(117101084)
				local var_344_14 = arg_341_1:FormatText(var_344_13.content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_16 = 35 <= 0 and var_344_12 or var_344_12 * (utf8.len(var_344_14) / 35)

				if (35 <= 0 and var_344_12 or var_344_12 * (utf8.len(var_344_14) / 35)) > 0 and var_344_12 < var_344_16 then
					arg_341_1.talkMaxDuration = var_344_16

					if var_344_16 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_16 + var_344_11
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101084", "story_v_out_117101.awb") ~= 0 then
					local var_344_17 = manager.audio:GetVoiceLength("story_v_out_117101", "117101084", "story_v_out_117101.awb") / 1000

					if var_344_17 + var_344_11 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_11
					end

					if var_344_13.prefab_name ~= "" and arg_341_1.actors_[var_344_13.prefab_name] ~= nil then
						local var_344_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_13.prefab_name].transform, "story_v_out_117101", "117101084", "story_v_out_117101.awb")

						arg_341_1:RecordAudio("117101084", var_344_18)
						arg_341_1:RecordAudio("117101084", var_344_18)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_117101", "117101084", "story_v_out_117101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_117101", "117101084", "story_v_out_117101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_19 = math.max(var_344_12, arg_341_1.talkMaxDuration)

			if var_344_11 <= arg_341_1.time_ and arg_341_1.time_ < var_344_11 + var_344_19 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_11) / var_344_19

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_11 + var_344_19 and arg_341_1.time_ < var_344_11 + var_344_19 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play117101085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 117101085
		arg_345_1.duration_ = 17.63

		local var_345_0 = {
			zh = 17.633,
			ja = 12.8
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
				arg_345_0:Play117101086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10036"]) and arg_345_1.var_.actorSpriteComps10036 == nil then
				arg_345_1.var_.actorSpriteComps10036 = arg_345_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10036"]) then
				if arg_345_1.var_.actorSpriteComps10036 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								iter_348_1.color = Color.New(Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_0), Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_0), (Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_0)))
							else
								local var_348_1 = Mathf.Lerp(iter_348_1.color.r, 1, (arg_345_1.time_ - 0) / var_348_0)

								iter_348_1.color = Color.New(var_348_1, var_348_1, var_348_1)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10036"]) and arg_345_1.var_.actorSpriteComps10036 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_348_3 then
						iter_348_3.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10036 = nil
			end

			local var_348_2 = arg_345_1.actors_["1132"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1132 == nil then
				arg_345_1.var_.actorSpriteComps1132 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps1132 then
					for iter_348_4, iter_348_5 in pairs(arg_345_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_348_5 then
							if arg_345_1.isInRecall_ then
								iter_348_5.color = Color.New(Mathf.Lerp(iter_348_5.color.r, arg_345_1.hightColor2.r, (arg_345_1.time_ - 0) / var_348_3), Mathf.Lerp(iter_348_5.color.g, arg_345_1.hightColor2.g, (arg_345_1.time_ - 0) / var_348_3), (Mathf.Lerp(iter_348_5.color.b, arg_345_1.hightColor2.b, (arg_345_1.time_ - 0) / var_348_3)))
							else
								local var_348_4 = Mathf.Lerp(iter_348_5.color.r, 0.5, (arg_345_1.time_ - 0) / var_348_3)

								iter_348_5.color = Color.New(var_348_4, var_348_4, var_348_4)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1132 then
				for iter_348_6, iter_348_7 in pairs(arg_345_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_348_7 then
						iter_348_7.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_345_1.var_.actorSpriteComps1132 = nil
			end

			local var_348_5 = 0
			local var_348_6 = 1.5

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_7 = arg_345_1:GetWordFromCfg(117101085)
				local var_348_8 = arg_345_1:FormatText(var_348_7.content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 60 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 60)

				if (60 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 60)) > 0 and var_348_6 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101085", "story_v_out_117101.awb") ~= 0 then
					local var_348_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101085", "story_v_out_117101.awb") / 1000

					if var_348_11 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_5
					end

					if var_348_7.prefab_name ~= "" and arg_345_1.actors_[var_348_7.prefab_name] ~= nil then
						local var_348_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_7.prefab_name].transform, "story_v_out_117101", "117101085", "story_v_out_117101.awb")

						arg_345_1:RecordAudio("117101085", var_348_12)
						arg_345_1:RecordAudio("117101085", var_348_12)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_117101", "117101085", "story_v_out_117101.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_117101", "117101085", "story_v_out_117101.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_13 and arg_345_1.time_ < var_348_5 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play117101086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 117101086
		arg_349_1.duration_ = 6.73

		local var_349_0 = {
			zh = 4.233,
			ja = 6.733
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play117101087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["10036"]) and arg_349_1.var_.actorSpriteComps10036 == nil then
				arg_349_1.var_.actorSpriteComps10036 = arg_349_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_0 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["10036"]) then
				if arg_349_1.var_.actorSpriteComps10036 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								iter_352_1.color = Color.New(Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_0), Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_0), (Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_0)))
							else
								local var_352_1 = Mathf.Lerp(iter_352_1.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_0)

								iter_352_1.color = Color.New(var_352_1, var_352_1, var_352_1)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["10036"]) and arg_349_1.var_.actorSpriteComps10036 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_352_3 then
						iter_352_3.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10036 = nil
			end

			local var_352_2 = arg_349_1.actors_["1132"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1132 == nil then
				arg_349_1.var_.actorSpriteComps1132 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps1132 then
					for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_352_5 then
							if arg_349_1.isInRecall_ then
								iter_352_5.color = Color.New(Mathf.Lerp(iter_352_5.color.r, arg_349_1.hightColor1.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_5.color.g, arg_349_1.hightColor1.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_5.color.b, arg_349_1.hightColor1.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_5.color.r, 1, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_5.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps1132 then
				for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_352_7 then
						iter_352_7.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_349_1.var_.actorSpriteComps1132 = nil
			end

			local var_352_5 = 0
			local var_352_6 = 0.45

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_7 = arg_349_1:GetWordFromCfg(117101086)
				local var_352_8 = arg_349_1:FormatText(var_352_7.content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 18 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_8) / 18)

				if (18 <= 0 and var_352_6 or var_352_6 * (utf8.len(var_352_8) / 18)) > 0 and var_352_6 < var_352_10 then
					arg_349_1.talkMaxDuration = var_352_10

					if var_352_10 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_5
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101086", "story_v_out_117101.awb") ~= 0 then
					local var_352_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101086", "story_v_out_117101.awb") / 1000

					if var_352_11 + var_352_5 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_5
					end

					if var_352_7.prefab_name ~= "" and arg_349_1.actors_[var_352_7.prefab_name] ~= nil then
						local var_352_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_7.prefab_name].transform, "story_v_out_117101", "117101086", "story_v_out_117101.awb")

						arg_349_1:RecordAudio("117101086", var_352_12)
						arg_349_1:RecordAudio("117101086", var_352_12)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_117101", "117101086", "story_v_out_117101.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_117101", "117101086", "story_v_out_117101.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_13 = math.max(var_352_6, arg_349_1.talkMaxDuration)

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_13 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_5) / var_352_13

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_5 + var_352_13 and arg_349_1.time_ < var_352_5 + var_352_13 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play117101087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 117101087
		arg_353_1.duration_ = 12

		local var_353_0 = {
			zh = 10.1,
			ja = 12
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
				arg_353_0:Play117101088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10036"]) and arg_353_1.var_.actorSpriteComps10036 == nil then
				arg_353_1.var_.actorSpriteComps10036 = arg_353_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10036"]) then
				if arg_353_1.var_.actorSpriteComps10036 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 1, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10036"]) and arg_353_1.var_.actorSpriteComps10036 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10036 = nil
			end

			local var_356_2 = arg_353_1.actors_["1132"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1132 == nil then
				arg_353_1.var_.actorSpriteComps1132 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps1132 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								iter_356_5.color = Color.New(Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_5.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_5.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1132 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_356_7 then
						iter_356_7.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1132 = nil
			end

			local var_356_5 = 0
			local var_356_6 = 1.075

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_7 = arg_353_1:GetWordFromCfg(117101087)
				local var_356_8 = arg_353_1:FormatText(var_356_7.content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 43 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 43)

				if (43 <= 0 and var_356_6 or var_356_6 * (utf8.len(var_356_8) / 43)) > 0 and var_356_6 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_5
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101087", "story_v_out_117101.awb") ~= 0 then
					local var_356_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101087", "story_v_out_117101.awb") / 1000

					if var_356_11 + var_356_5 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_5
					end

					if var_356_7.prefab_name ~= "" and arg_353_1.actors_[var_356_7.prefab_name] ~= nil then
						local var_356_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_7.prefab_name].transform, "story_v_out_117101", "117101087", "story_v_out_117101.awb")

						arg_353_1:RecordAudio("117101087", var_356_12)
						arg_353_1:RecordAudio("117101087", var_356_12)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_117101", "117101087", "story_v_out_117101.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_117101", "117101087", "story_v_out_117101.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_13 = math.max(var_356_6, arg_353_1.talkMaxDuration)

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_13 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_5) / var_356_13

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_5 + var_356_13 and arg_353_1.time_ < var_356_5 + var_356_13 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play117101088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 117101088
		arg_357_1.duration_ = 9.9

		local var_357_0 = {
			zh = 7.8,
			ja = 9.9
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
				arg_357_0:Play117101089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10036"]) and arg_357_1.var_.actorSpriteComps10036 == nil then
				arg_357_1.var_.actorSpriteComps10036 = arg_357_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10036"]) then
				if arg_357_1.var_.actorSpriteComps10036 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10036"]) and arg_357_1.var_.actorSpriteComps10036 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10036 = nil
			end

			local var_360_2 = arg_357_1.actors_["1132"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1132 == nil then
				arg_357_1.var_.actorSpriteComps1132 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps1132 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								iter_360_5.color = Color.New(Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_5.color.r, 1, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_5.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps1132 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_360_7 then
						iter_360_7.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1132 = nil
			end

			local var_360_5 = 0
			local var_360_6 = 0.875

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:GetWordFromCfg(117101088)
				local var_360_8 = arg_357_1:FormatText(var_360_7.content)

				arg_357_1.text_.text = var_360_8

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_10 = 35 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 35)

				if (35 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_8) / 35)) > 0 and var_360_6 < var_360_10 then
					arg_357_1.talkMaxDuration = var_360_10

					if var_360_10 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_8
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101088", "story_v_out_117101.awb") ~= 0 then
					local var_360_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101088", "story_v_out_117101.awb") / 1000

					if var_360_11 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_5
					end

					if var_360_7.prefab_name ~= "" and arg_357_1.actors_[var_360_7.prefab_name] ~= nil then
						local var_360_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_7.prefab_name].transform, "story_v_out_117101", "117101088", "story_v_out_117101.awb")

						arg_357_1:RecordAudio("117101088", var_360_12)
						arg_357_1:RecordAudio("117101088", var_360_12)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_117101", "117101088", "story_v_out_117101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_117101", "117101088", "story_v_out_117101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_13 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_13 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_13

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_13 and arg_357_1.time_ < var_360_5 + var_360_13 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play117101089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 117101089
		arg_361_1.duration_ = 10.63

		local var_361_0 = {
			zh = 6.666,
			ja = 10.633
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play117101090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.675

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:GetWordFromCfg(117101089)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 27 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 27)

				if (27 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 27)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101089", "story_v_out_117101.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101089", "story_v_out_117101.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_117101", "117101089", "story_v_out_117101.awb")

						arg_361_1:RecordAudio("117101089", var_364_6)
						arg_361_1:RecordAudio("117101089", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_117101", "117101089", "story_v_out_117101.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_117101", "117101089", "story_v_out_117101.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play117101090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 117101090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play117101091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				local var_368_0 = arg_365_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_368_0 then
					arg_365_1.var_.alphaOldValue1132 = var_368_0.alpha
					arg_365_1.var_.characterEffect1132 = var_368_0
				end

				arg_365_1.var_.alphaOldValue1132 = 1
			end

			local var_368_1 = 0.333333333333333

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_1 then
				if arg_365_1.var_.characterEffect1132 then
					arg_365_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_365_1.var_.alphaOldValue1132, 0, (arg_365_1.time_ - 0) / var_368_1)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_1 and arg_365_1.time_ < 0 + var_368_1 + arg_368_0 and arg_365_1.var_.characterEffect1132 then
				arg_365_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				local var_368_2 = arg_365_1.actors_["10036"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_368_2 then
					arg_365_1.var_.alphaOldValue10036 = var_368_2.alpha
					arg_365_1.var_.characterEffect10036 = var_368_2
				end

				arg_365_1.var_.alphaOldValue10036 = 1
			end

			local var_368_3 = 0.333333333333333

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 then
				if arg_365_1.var_.characterEffect10036 then
					arg_365_1.var_.characterEffect10036.alpha = Mathf.Lerp(arg_365_1.var_.alphaOldValue10036, 0, (arg_365_1.time_ - 0) / var_368_3)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and arg_365_1.var_.characterEffect10036 then
				arg_365_1.var_.characterEffect10036.alpha = 0
			end

			local var_368_4 = 0
			local var_368_5 = 1.025

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(117101090).content)

				arg_365_1.text_.text = var_368_6

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_8 = 41 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_6) / 41)

				if (41 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_6) / 41)) > 0 and var_368_5 < var_368_8 then
					arg_365_1.talkMaxDuration = var_368_8

					if var_368_8 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_6
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_9 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_9 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_9

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_9 and arg_365_1.time_ < var_368_4 + var_368_9 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play117101091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 117101091
		arg_369_1.duration_ = 1.83

		local var_369_0 = {
			zh = 1.4,
			ja = 1.833
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play117101092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1132 = arg_369_1.actors_["1132"].transform.localPosition
				arg_369_1.actors_["1132"].transform.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1132", 4)

				for iter_372_0 = 0, arg_369_1.actors_["1132"].transform.childCount - 1 do
					local var_372_0 = arg_369_1.actors_["1132"].transform:GetChild(iter_372_0)

					if var_372_0.name == "split_6" or not string.find(var_372_0.name, "split") then
						var_372_0.gameObject:SetActive(true)
					else
						var_372_0.gameObject:SetActive(false)
					end
				end
			end

			local var_372_1 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_1 then
				arg_369_1.actors_["1132"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1132, Vector3.New(390, -413, -185), (arg_369_1.time_ - 0) / var_372_1)
			end

			if arg_369_1.time_ >= 0 + var_372_1 and arg_369_1.time_ < 0 + var_372_1 + arg_372_0 then
				arg_369_1.actors_["1132"].transform.localPosition = Vector3.New(390, -413, -185)
			end

			local var_372_2 = arg_369_1.actors_["10036"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10036 = var_372_2.localPosition
				var_372_2.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10036", 2)

				for iter_372_1 = 0, var_372_2.childCount - 1 do
					local var_372_3 = var_372_2:GetChild(iter_372_1)

					if var_372_3.name == "split_1" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_2.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10036, Vector3.New(-390, -445, -290), (arg_369_1.time_ - 0) / var_372_4)
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_2.localPosition = Vector3.New(-390, -445, -290)
			end

			local var_372_5 = arg_369_1.actors_["10036"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10036 == nil then
				arg_369_1.var_.actorSpriteComps10036 = var_372_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_6 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_6 and not isNil(var_372_5) then
				if arg_369_1.var_.actorSpriteComps10036 then
					for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_372_3 then
							if arg_369_1.isInRecall_ then
								iter_372_3.color = Color.New(Mathf.Lerp(iter_372_3.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_6), Mathf.Lerp(iter_372_3.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_6), (Mathf.Lerp(iter_372_3.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_6)))
							else
								local var_372_7 = Mathf.Lerp(iter_372_3.color.r, 1, (arg_369_1.time_ - 0) / var_372_6)

								iter_372_3.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_6 and arg_369_1.time_ < 0 + var_372_6 + arg_372_0 and not isNil(var_372_5) and arg_369_1.var_.actorSpriteComps10036 then
				for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_372_5 then
						iter_372_5.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10036 = nil
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_8 = arg_369_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_372_8 then
					arg_369_1.var_.alphaOldValue1132 = var_372_8.alpha
					arg_369_1.var_.characterEffect1132 = var_372_8
				end

				arg_369_1.var_.alphaOldValue1132 = 0
			end

			local var_372_9 = 0.333333333333333

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_9 then
				if arg_369_1.var_.characterEffect1132 then
					arg_369_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_369_1.var_.alphaOldValue1132, 1, (arg_369_1.time_ - 0) / var_372_9)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_9 and arg_369_1.time_ < 0 + var_372_9 + arg_372_0 and arg_369_1.var_.characterEffect1132 then
				arg_369_1.var_.characterEffect1132.alpha = 1
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_10 = arg_369_1.actors_["10036"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_372_10 then
					arg_369_1.var_.alphaOldValue10036 = var_372_10.alpha
					arg_369_1.var_.characterEffect10036 = var_372_10
				end

				arg_369_1.var_.alphaOldValue10036 = 0
			end

			local var_372_11 = 0.333333333333333

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_11 then
				if arg_369_1.var_.characterEffect10036 then
					arg_369_1.var_.characterEffect10036.alpha = Mathf.Lerp(arg_369_1.var_.alphaOldValue10036, 1, (arg_369_1.time_ - 0) / var_372_11)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_11 and arg_369_1.time_ < 0 + var_372_11 + arg_372_0 and arg_369_1.var_.characterEffect10036 then
				arg_369_1.var_.characterEffect10036.alpha = 1
			end

			local var_372_12 = arg_369_1.actors_["1132"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_12) and arg_369_1.var_.actorSpriteComps1132 == nil then
				arg_369_1.var_.actorSpriteComps1132 = var_372_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_13 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_13 and not isNil(var_372_12) then
				if arg_369_1.var_.actorSpriteComps1132 then
					for iter_372_6, iter_372_7 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_372_7 then
							if arg_369_1.isInRecall_ then
								iter_372_7.color = Color.New(Mathf.Lerp(iter_372_7.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_13), Mathf.Lerp(iter_372_7.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_13), (Mathf.Lerp(iter_372_7.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_13)))
							else
								local var_372_14 = Mathf.Lerp(iter_372_7.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_13)

								iter_372_7.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_13 and arg_369_1.time_ < 0 + var_372_13 + arg_372_0 and not isNil(var_372_12) and arg_369_1.var_.actorSpriteComps1132 then
				for iter_372_8, iter_372_9 in pairs(arg_369_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_372_9 then
						iter_372_9.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps1132 = nil
			end

			local var_372_15 = 0
			local var_372_16 = 0.1

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_17 = arg_369_1:GetWordFromCfg(117101091)
				local var_372_18 = arg_369_1:FormatText(var_372_17.content)

				arg_369_1.text_.text = var_372_18

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 4 <= 0 and var_372_16 or var_372_16 * (utf8.len(var_372_18) / 4)

				if (4 <= 0 and var_372_16 or var_372_16 * (utf8.len(var_372_18) / 4)) > 0 and var_372_16 < var_372_20 then
					arg_369_1.talkMaxDuration = var_372_20

					if var_372_20 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_20 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_18
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101091", "story_v_out_117101.awb") ~= 0 then
					local var_372_21 = manager.audio:GetVoiceLength("story_v_out_117101", "117101091", "story_v_out_117101.awb") / 1000

					if var_372_21 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_21 + var_372_15
					end

					if var_372_17.prefab_name ~= "" and arg_369_1.actors_[var_372_17.prefab_name] ~= nil then
						local var_372_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_17.prefab_name].transform, "story_v_out_117101", "117101091", "story_v_out_117101.awb")

						arg_369_1:RecordAudio("117101091", var_372_22)
						arg_369_1:RecordAudio("117101091", var_372_22)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_117101", "117101091", "story_v_out_117101.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_117101", "117101091", "story_v_out_117101.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_23 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_23 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_23

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_23 and arg_369_1.time_ < var_372_15 + var_372_23 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1132",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play117101092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 117101092
		arg_373_1.duration_ = 10.5

		local var_373_0 = {
			zh = 10.5,
			ja = 4.233
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play117101093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10036"]) and arg_373_1.var_.actorSpriteComps10036 == nil then
				arg_373_1.var_.actorSpriteComps10036 = arg_373_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10036"]) then
				if arg_373_1.var_.actorSpriteComps10036 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10036"]) and arg_373_1.var_.actorSpriteComps10036 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10036 = nil
			end

			local var_376_2 = arg_373_1.actors_["1132"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1132 == nil then
				arg_373_1.var_.actorSpriteComps1132 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps1132 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								iter_376_5.color = Color.New(Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_5.color.r, 1, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_5.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps1132 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_376_7 then
						iter_376_7.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps1132 = nil
			end

			local var_376_5 = 0
			local var_376_6 = 1.1

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_5 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_7 = arg_373_1:GetWordFromCfg(117101092)
				local var_376_8 = arg_373_1:FormatText(var_376_7.content)

				arg_373_1.text_.text = var_376_8

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 44 <= 0 and var_376_6 or var_376_6 * (utf8.len(var_376_8) / 44)

				if (44 <= 0 and var_376_6 or var_376_6 * (utf8.len(var_376_8) / 44)) > 0 and var_376_6 < var_376_10 then
					arg_373_1.talkMaxDuration = var_376_10

					if var_376_10 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_5
					end
				end

				arg_373_1.text_.text = var_376_8
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101092", "story_v_out_117101.awb") ~= 0 then
					local var_376_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101092", "story_v_out_117101.awb") / 1000

					if var_376_11 + var_376_5 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_11 + var_376_5
					end

					if var_376_7.prefab_name ~= "" and arg_373_1.actors_[var_376_7.prefab_name] ~= nil then
						local var_376_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_7.prefab_name].transform, "story_v_out_117101", "117101092", "story_v_out_117101.awb")

						arg_373_1:RecordAudio("117101092", var_376_12)
						arg_373_1:RecordAudio("117101092", var_376_12)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_117101", "117101092", "story_v_out_117101.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_117101", "117101092", "story_v_out_117101.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_13 = math.max(var_376_6, arg_373_1.talkMaxDuration)

			if var_376_5 <= arg_373_1.time_ and arg_373_1.time_ < var_376_5 + var_376_13 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_5) / var_376_13

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_5 + var_376_13 and arg_373_1.time_ < var_376_5 + var_376_13 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play117101093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 117101093
		arg_377_1.duration_ = 2.27

		local var_377_0 = {
			zh = 1.4,
			ja = 2.266
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
				arg_377_0:Play117101094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.15

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:GetWordFromCfg(117101093)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 6 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 6)

				if (6 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 6)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101093", "story_v_out_117101.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101093", "story_v_out_117101.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_117101", "117101093", "story_v_out_117101.awb")

						arg_377_1:RecordAudio("117101093", var_380_6)
						arg_377_1:RecordAudio("117101093", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_117101", "117101093", "story_v_out_117101.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_117101", "117101093", "story_v_out_117101.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play117101094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 117101094
		arg_381_1.duration_ = 8.77

		local var_381_0 = {
			zh = 4.466,
			ja = 8.766
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
				arg_381_0:Play117101095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10036"]) and arg_381_1.var_.actorSpriteComps10036 == nil then
				arg_381_1.var_.actorSpriteComps10036 = arg_381_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10036"]) then
				if arg_381_1.var_.actorSpriteComps10036 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								iter_384_1.color = Color.New(Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_0), Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_0), (Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_0)))
							else
								local var_384_1 = Mathf.Lerp(iter_384_1.color.r, 1, (arg_381_1.time_ - 0) / var_384_0)

								iter_384_1.color = Color.New(var_384_1, var_384_1, var_384_1)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10036"]) and arg_381_1.var_.actorSpriteComps10036 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10036 = nil
			end

			local var_384_2 = arg_381_1.actors_["1132"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1132 == nil then
				arg_381_1.var_.actorSpriteComps1132 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps1132 then
					for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_384_5 then
							if arg_381_1.isInRecall_ then
								iter_384_5.color = Color.New(Mathf.Lerp(iter_384_5.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_5.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_5.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_5.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_5.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps1132 then
				for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_384_7 then
						iter_384_7.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps1132 = nil
			end

			local var_384_5 = 0
			local var_384_6 = 0.45

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:GetWordFromCfg(117101094)
				local var_384_8 = arg_381_1:FormatText(var_384_7.content)

				arg_381_1.text_.text = var_384_8

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_10 = 18 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 18)

				if (18 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 18)) > 0 and var_384_6 < var_384_10 then
					arg_381_1.talkMaxDuration = var_384_10

					if var_384_10 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_5
					end
				end

				arg_381_1.text_.text = var_384_8
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101094", "story_v_out_117101.awb") ~= 0 then
					local var_384_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101094", "story_v_out_117101.awb") / 1000

					if var_384_11 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_5
					end

					if var_384_7.prefab_name ~= "" and arg_381_1.actors_[var_384_7.prefab_name] ~= nil then
						local var_384_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_7.prefab_name].transform, "story_v_out_117101", "117101094", "story_v_out_117101.awb")

						arg_381_1:RecordAudio("117101094", var_384_12)
						arg_381_1:RecordAudio("117101094", var_384_12)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_117101", "117101094", "story_v_out_117101.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_117101", "117101094", "story_v_out_117101.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_13 = math.max(var_384_6, arg_381_1.talkMaxDuration)

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_13 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_5) / var_384_13

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_5 + var_384_13 and arg_381_1.time_ < var_384_5 + var_384_13 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play117101095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 117101095
		arg_385_1.duration_ = 7.43

		local var_385_0 = {
			zh = 7.433,
			ja = 2.1
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
				arg_385_0:Play117101096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10036"]) and arg_385_1.var_.actorSpriteComps10036 == nil then
				arg_385_1.var_.actorSpriteComps10036 = arg_385_1.actors_["10036"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10036"]) then
				if arg_385_1.var_.actorSpriteComps10036 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10036"]) and arg_385_1.var_.actorSpriteComps10036 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps10036 = nil
			end

			local var_388_2 = arg_385_1.actors_["1132"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1132 == nil then
				arg_385_1.var_.actorSpriteComps1132 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps1132 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								iter_388_5.color = Color.New(Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_5.color.r, 1, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_5.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps1132 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps1132 = nil
			end

			local var_388_5 = 0
			local var_388_6 = 0.85

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:GetWordFromCfg(117101095)
				local var_388_8 = arg_385_1:FormatText(var_388_7.content)

				arg_385_1.text_.text = var_388_8

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 34 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 34)

				if (34 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 34)) > 0 and var_388_6 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_8
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101095", "story_v_out_117101.awb") ~= 0 then
					local var_388_11 = manager.audio:GetVoiceLength("story_v_out_117101", "117101095", "story_v_out_117101.awb") / 1000

					if var_388_11 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_5
					end

					if var_388_7.prefab_name ~= "" and arg_385_1.actors_[var_388_7.prefab_name] ~= nil then
						local var_388_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_7.prefab_name].transform, "story_v_out_117101", "117101095", "story_v_out_117101.awb")

						arg_385_1:RecordAudio("117101095", var_388_12)
						arg_385_1:RecordAudio("117101095", var_388_12)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_117101", "117101095", "story_v_out_117101.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_117101", "117101095", "story_v_out_117101.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_13 and arg_385_1.time_ < var_388_5 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play117101096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 117101096
		arg_389_1.duration_ = 7.73

		local var_389_0 = {
			zh = 6.1,
			ja = 7.733
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
				arg_389_0:Play117101097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.75

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:GetWordFromCfg(117101096)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 30 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 30)

				if (30 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 30)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101096", "story_v_out_117101.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101096", "story_v_out_117101.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_117101", "117101096", "story_v_out_117101.awb")

						arg_389_1:RecordAudio("117101096", var_392_6)
						arg_389_1:RecordAudio("117101096", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_117101", "117101096", "story_v_out_117101.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_117101", "117101096", "story_v_out_117101.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play117101097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 117101097
		arg_393_1.duration_ = 4.37

		local var_393_0 = {
			zh = 4.366,
			ja = 4.133
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
				arg_393_0:Play117101098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.375

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(117101097)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 15)

				if (15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 15)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101097", "story_v_out_117101.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_117101", "117101097", "story_v_out_117101.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_117101", "117101097", "story_v_out_117101.awb")

						arg_393_1:RecordAudio("117101097", var_396_6)
						arg_393_1:RecordAudio("117101097", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_117101", "117101097", "story_v_out_117101.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_117101", "117101097", "story_v_out_117101.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play117101098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 117101098
		arg_397_1.duration_ = 3.43

		local var_397_0 = {
			zh = 2.966,
			ja = 3.433
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
				arg_397_0:Play117101099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10036 = arg_397_1.actors_["10036"].transform.localPosition
				arg_397_1.actors_["10036"].transform.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10036", 2)

				for iter_400_0 = 0, arg_397_1.actors_["10036"].transform.childCount - 1 do
					local var_400_0 = arg_397_1.actors_["10036"].transform:GetChild(iter_400_0)

					if var_400_0.name == "split_5" or not string.find(var_400_0.name, "split") then
						var_400_0.gameObject:SetActive(true)
					else
						var_400_0.gameObject:SetActive(false)
					end
				end
			end

			local var_400_1 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["10036"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10036, Vector3.New(-390, -445, -290), (arg_397_1.time_ - 0) / var_400_1)
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["10036"].transform.localPosition = Vector3.New(-390, -445, -290)
			end

			local var_400_2 = arg_397_1.actors_["10036"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10036 == nil then
				arg_397_1.var_.actorSpriteComps10036 = var_400_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_3 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_3 and not isNil(var_400_2) then
				if arg_397_1.var_.actorSpriteComps10036 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps10036:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								iter_400_2.color = Color.New(Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_3), Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_3), (Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_3)))
							else
								local var_400_4 = Mathf.Lerp(iter_400_2.color.r, 1, (arg_397_1.time_ - 0) / var_400_3)

								iter_400_2.color = Color.New(var_400_4, var_400_4, var_400_4)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_3 and arg_397_1.time_ < 0 + var_400_3 + arg_400_0 and not isNil(var_400_2) and arg_397_1.var_.actorSpriteComps10036 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps10036:ToTable()) do
					if iter_400_4 then
						iter_400_4.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10036 = nil
			end

			local var_400_5 = arg_397_1.actors_["1132"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.actorSpriteComps1132 == nil then
				arg_397_1.var_.actorSpriteComps1132 = var_400_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_6 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_6 and not isNil(var_400_5) then
				if arg_397_1.var_.actorSpriteComps1132 then
					for iter_400_5, iter_400_6 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
						if iter_400_6 then
							if arg_397_1.isInRecall_ then
								iter_400_6.color = Color.New(Mathf.Lerp(iter_400_6.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_6), Mathf.Lerp(iter_400_6.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_6), (Mathf.Lerp(iter_400_6.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_6)))
							else
								local var_400_7 = Mathf.Lerp(iter_400_6.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_6)

								iter_400_6.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_6 and arg_397_1.time_ < 0 + var_400_6 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.actorSpriteComps1132 then
				for iter_400_7, iter_400_8 in pairs(arg_397_1.var_.actorSpriteComps1132:ToTable()) do
					if iter_400_8 then
						iter_400_8.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps1132 = nil
			end

			local var_400_8 = manager.ui.mainCamera.transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.shakeOldPos = var_400_8.localPosition
			end

			local var_400_9 = 0.6

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_9 then
				local var_400_10, var_400_11 = math.modf((arg_397_1.time_ - 0) / 0.066)

				var_400_8.localPosition = Vector3.New(var_400_11 * 0.13, var_400_11 * 0.13, var_400_11 * 0.13) + arg_397_1.var_.shakeOldPos
			end

			if arg_397_1.time_ >= 0 + var_400_9 and arg_397_1.time_ < 0 + var_400_9 + arg_400_0 then
				var_400_8.localPosition = arg_397_1.var_.shakeOldPos
			end

			local var_400_12 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_12 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			if arg_397_1.time_ >= var_400_12 + 0.6 and arg_397_1.time_ < var_400_12 + 0.6 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_13 = 0
			local var_400_14 = 0.225

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_13 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[370].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_15 = arg_397_1:GetWordFromCfg(117101098)
				local var_400_16 = arg_397_1:FormatText(var_400_15.content)

				arg_397_1.text_.text = var_400_16

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_18 = 9 <= 0 and var_400_14 or var_400_14 * (utf8.len(var_400_16) / 9)

				if (9 <= 0 and var_400_14 or var_400_14 * (utf8.len(var_400_16) / 9)) > 0 and var_400_14 < var_400_18 then
					arg_397_1.talkMaxDuration = var_400_18

					if var_400_18 + var_400_13 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_18 + var_400_13
					end
				end

				arg_397_1.text_.text = var_400_16
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117101", "117101098", "story_v_out_117101.awb") ~= 0 then
					local var_400_19 = manager.audio:GetVoiceLength("story_v_out_117101", "117101098", "story_v_out_117101.awb") / 1000

					if var_400_19 + var_400_13 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_19 + var_400_13
					end

					if var_400_15.prefab_name ~= "" and arg_397_1.actors_[var_400_15.prefab_name] ~= nil then
						local var_400_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_15.prefab_name].transform, "story_v_out_117101", "117101098", "story_v_out_117101.awb")

						arg_397_1:RecordAudio("117101098", var_400_20)
						arg_397_1:RecordAudio("117101098", var_400_20)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_117101", "117101098", "story_v_out_117101.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_117101", "117101098", "story_v_out_117101.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_21 = math.max(var_400_14, arg_397_1.talkMaxDuration)

			if var_400_13 <= arg_397_1.time_ and arg_397_1.time_ < var_400_13 + var_400_21 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_13) / var_400_21

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_13 + var_400_21 and arg_397_1.time_ < var_400_13 + var_400_21 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play117101099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 117101099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play117101100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				local var_404_0 = arg_401_1.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_0 then
					arg_401_1.var_.alphaOldValue1132 = var_404_0.alpha
					arg_401_1.var_.characterEffect1132 = var_404_0
				end

				arg_401_1.var_.alphaOldValue1132 = 1
			end

			local var_404_1 = 0.333333333333333

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_1 then
				if arg_401_1.var_.characterEffect1132 then
					arg_401_1.var_.characterEffect1132.alpha = Mathf.Lerp(arg_401_1.var_.alphaOldValue1132, 0, (arg_401_1.time_ - 0) / var_404_1)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_1 and arg_401_1.time_ < 0 + var_404_1 + arg_404_0 and arg_401_1.var_.characterEffect1132 then
				arg_401_1.var_.characterEffect1132.alpha = 0
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				local var_404_2 = arg_401_1.actors_["10036"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_404_2 then
					arg_401_1.var_.alphaOldValue10036 = var_404_2.alpha
					arg_401_1.var_.characterEffect10036 = var_404_2
				end

				arg_401_1.var_.alphaOldValue10036 = 1
			end

			local var_404_3 = 0.333333333333333

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_3 then
				if arg_401_1.var_.characterEffect10036 then
					arg_401_1.var_.characterEffect10036.alpha = Mathf.Lerp(arg_401_1.var_.alphaOldValue10036, 0, (arg_401_1.time_ - 0) / var_404_3)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_3 and arg_401_1.time_ < 0 + var_404_3 + arg_404_0 and arg_401_1.var_.characterEffect10036 then
				arg_401_1.var_.characterEffect10036.alpha = 0
			end

			local var_404_4 = 0
			local var_404_5 = 0.975

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(117101099).content)

				arg_401_1.text_.text = var_404_6

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_8 = 39 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_6) / 39)

				if (39 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_6) / 39)) > 0 and var_404_5 < var_404_8 then
					arg_401_1.talkMaxDuration = var_404_8

					if var_404_8 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_6
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_9 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_9 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_9

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_9 and arg_401_1.time_ < var_404_4 + var_404_9 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play117101100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 117101100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play117101101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_9000

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				local var_408_0 = arg_405_1.var_.effectniuqu1

				if not arg_405_1.var_.effectniuqu1 then
					var_408_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_408_0.name = "niuqu1"
					arg_405_1.var_.effectniuqu1 = var_408_0
				else
					var_408_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_408_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_408_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_408_2 = 0

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_3 = 2

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_3 then
				local var_408_4 = Color.New(0.735849, 0.1910944, 0.03818085)

				var_408_4.a = Mathf.Lerp(1, 0, (arg_405_1.time_ - var_408_2) / var_408_3)
				arg_405_1.mask_.color = var_408_4
			end

			if arg_405_1.time_ >= var_408_2 + var_408_3 and arg_405_1.time_ < var_408_2 + var_408_3 + arg_408_0 then
				local var_408_5 = Color.New(0.735849, 0.1910944, 0.03818085)

				arg_405_1.mask_.enabled = false
				var_408_5.a = 0
				arg_405_1.mask_.color = var_408_5
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				local var_408_6 = arg_405_1.var_.effectred

				if not arg_405_1.var_.effectred then
					var_408_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), manager.ui.mainCamera.transform)
					var_408_6.name = "red"
					arg_405_1.var_.effectred = var_408_6
				else
					var_408_6.transform:SetParent(var_408_9000)
				end

				var_408_6.transform.localPosition = Vector3.New(0, 0.06, 0.18)
				var_408_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_17", "se_story_17_bell", "")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_17", "se_story_17_fire_loop", "")
			end

			local var_408_10 = 0
			local var_408_11 = 1.3

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_12 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(117101100).content)

				arg_405_1.text_.text = var_408_12

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_14 = 52 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_12) / 52)

				if (52 <= 0 and var_408_11 or var_408_11 * (utf8.len(var_408_12) / 52)) > 0 and var_408_11 < var_408_14 then
					arg_405_1.talkMaxDuration = var_408_14

					if var_408_14 + var_408_10 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_10
					end
				end

				arg_405_1.text_.text = var_408_12
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_15 = math.max(var_408_11, arg_405_1.talkMaxDuration)

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_15 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_10) / var_408_15

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_10 + var_408_15 and arg_405_1.time_ < var_408_10 + var_408_15 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play117101101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 117101101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
			arg_409_1.auto_ = false
		end

		function arg_409_1.playNext_(arg_411_0)
			arg_409_1.onStoryFinished_()
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_412_0 = 0.6

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				local var_412_1, var_412_2 = math.modf((arg_409_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_412_2 * 0.13, var_412_2 * 0.13, var_412_2 * 0.13) + arg_409_1.var_.shakeOldPos
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				manager.ui.mainCamera.transform.localPosition = arg_409_1.var_.shakeOldPos
			end

			local var_412_3 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.allBtn_.enabled = false
			end

			if arg_409_1.time_ >= var_412_3 + 0.6 and arg_409_1.time_ < var_412_3 + 0.6 + arg_412_0 then
				arg_409_1.allBtn_.enabled = true
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster03", "")
			end

			local var_412_5 = 0
			local var_412_6 = 0.075

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_7 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(117101101).content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 3 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 3)

				if (3 <= 0 and var_412_6 or var_412_6 * (utf8.len(var_412_7) / 3)) > 0 and var_412_6 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_5 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_5
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_6, arg_409_1.talkMaxDuration)

			if var_412_5 <= arg_409_1.time_ and arg_409_1.time_ < var_412_5 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_5) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_5 + var_412_10 and arg_409_1.time_ < var_412_5 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST24a",
		"TextureConfig/Background/B01c",
		"TextureConfig/Background/B01b"
	},
	voices = {
		"story_v_out_117101.awb"
	}
}
