return {
	Play938081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STwhite"

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
				local var_4_5 = arg_1_1.bgs_.STwhite

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
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 1
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = "104701"

			if arg_1_1.actors_[var_4_28] == nil then
				local var_4_29 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_4_29) then
					local var_4_30 = Object.Instantiate(var_4_29, arg_1_1.canvasGo_.transform)

					var_4_30.transform:SetSiblingIndex(1)

					var_4_30.name = var_4_28
					var_4_30.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_28] = var_4_30

					local var_4_31 = var_4_30:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_31) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_32 = arg_1_1.actors_["104701"]
			local var_4_33 = 2

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = var_4_32:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_34 then
					arg_1_1.var_.alphaOldValue104701 = var_4_34.alpha
					arg_1_1.var_.characterEffect104701 = var_4_34
				end

				arg_1_1.var_.alphaOldValue104701 = 0
			end

			local var_4_35 = 0.5

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_33) / var_4_35
				local var_4_37 = Mathf.Lerp(arg_1_1.var_.alphaOldValue104701, 1, var_4_36)

				if arg_1_1.var_.characterEffect104701 then
					arg_1_1.var_.characterEffect104701.alpha = var_4_37
				end
			end

			if arg_1_1.time_ >= var_4_33 + var_4_35 and arg_1_1.time_ < var_4_33 + var_4_35 + arg_4_0 and arg_1_1.var_.characterEffect104701 then
				arg_1_1.var_.characterEffect104701.alpha = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.4

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(938081001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 16
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938081002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.cswbg_:SetActive(false)

				local var_11_1 = arg_8_1.cswt_:GetComponent("RectTransform")

				arg_8_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_11_1.offsetMin = Vector2.New(400, 105)
				var_11_1.offsetMax = Vector2.New(-400, -200)

				local var_11_2 = arg_8_1:GetWordFromCfg(419196)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.cswt_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.cswt_)

				arg_8_1.cswt_.fontSize = 108
				arg_8_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_8_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_8_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_8_1.cswbg_:SetActive(true)
			end

			local var_11_4 = 0
			local var_11_5 = 0.875

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(938081002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 35
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938081003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(938081003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 40
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play938081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938081004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["104701"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps104701 == nil then
				arg_16_1.var_.actorSpriteComps104701 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps104701 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 0.5, var_19_3)

								iter_19_1.color = Color.New(var_19_7, var_19_7, var_19_7)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps104701 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps104701 = nil
			end

			local var_19_8 = 0
			local var_19_9 = 0.425

			if var_19_8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_10 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_11 = arg_16_1:GetWordFromCfg(938081004)
				local var_19_12 = arg_16_1:FormatText(var_19_11.content)

				arg_16_1.text_.text = var_19_12

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 17
				local var_19_14 = utf8.len(var_19_12)
				local var_19_15 = var_19_13 <= 0 and var_19_9 or var_19_9 * (var_19_14 / var_19_13)

				if var_19_15 > 0 and var_19_9 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_12
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play938081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938081005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938081006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.525

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(938081005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 21
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play938081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938081006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["104701"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps104701 == nil then
				arg_24_1.var_.actorSpriteComps104701 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps104701 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 0.5, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps104701 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps104701 = nil
			end

			local var_27_8 = 0
			local var_27_9 = 0.525

			if var_27_8 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_10 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_11 = arg_24_1:GetWordFromCfg(938081006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 21
				local var_27_14 = utf8.len(var_27_12)
				local var_27_15 = var_27_13 <= 0 and var_27_9 or var_27_9 * (var_27_14 / var_27_13)

				if var_27_15 > 0 and var_27_9 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_16 and arg_24_1.time_ < var_27_8 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play938081007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938081007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938081008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.8

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(938081007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 32
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play938081008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938081008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938081009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.9

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(938081008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 36
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play938081009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938081009
		arg_36_1.duration_ = 9

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938081010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "I20f"

			if arg_36_1.bgs_[var_39_0] == nil then
				local var_39_1 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_0)
				var_39_1.name = var_39_0
				var_39_1.transform.parent = arg_36_1.stage_.transform
				var_39_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_0] = var_39_1
			end

			local var_39_2 = 2

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				local var_39_3 = manager.ui.mainCamera.transform.localPosition
				local var_39_4 = Vector3.New(0, 0, 10) + Vector3.New(var_39_3.x, var_39_3.y, 0)
				local var_39_5 = arg_36_1.bgs_.I20f

				var_39_5.transform.localPosition = var_39_4
				var_39_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_6 = var_39_5:GetComponent("SpriteRenderer")

				if var_39_6 and var_39_6.sprite then
					local var_39_7 = (var_39_5.transform.localPosition - var_39_3).z
					local var_39_8 = manager.ui.mainCameraCom_
					local var_39_9 = 2 * var_39_7 * Mathf.Tan(var_39_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_10 = var_39_9 * var_39_8.aspect
					local var_39_11 = var_39_6.sprite.bounds.size.x
					local var_39_12 = var_39_6.sprite.bounds.size.y
					local var_39_13 = var_39_10 / var_39_11
					local var_39_14 = var_39_9 / var_39_12
					local var_39_15 = var_39_14 < var_39_13 and var_39_13 or var_39_14

					var_39_5.transform.localScale = Vector3.New(var_39_15, var_39_15, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "I20f" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_16 = 4

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_17 = 0.3

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_19 = 2

			if var_39_18 <= arg_36_1.time_ and arg_36_1.time_ < var_39_18 + var_39_19 then
				local var_39_20 = (arg_36_1.time_ - var_39_18) / var_39_19
				local var_39_21 = Color.New(0, 0, 0)

				var_39_21.a = Mathf.Lerp(0, 1, var_39_20)
				arg_36_1.mask_.color = var_39_21
			end

			if arg_36_1.time_ >= var_39_18 + var_39_19 and arg_36_1.time_ < var_39_18 + var_39_19 + arg_39_0 then
				local var_39_22 = Color.New(0, 0, 0)

				var_39_22.a = 1
				arg_36_1.mask_.color = var_39_22
			end

			local var_39_23 = 2

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_24 = 2

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24
				local var_39_26 = Color.New(0, 0, 0)

				var_39_26.a = Mathf.Lerp(1, 0, var_39_25)
				arg_36_1.mask_.color = var_39_26
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 then
				local var_39_27 = Color.New(0, 0, 0)
				local var_39_28 = 0

				arg_36_1.mask_.enabled = false
				var_39_27.a = var_39_28
				arg_36_1.mask_.color = var_39_27
			end

			local var_39_29 = 2.2
			local var_39_30 = 1

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				local var_39_31 = "play"
				local var_39_32 = "effect"

				arg_36_1:AudioAction(var_39_31, var_39_32, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_39_33 = 2.9
			local var_39_34 = 1

			if var_39_33 < arg_36_1.time_ and arg_36_1.time_ <= var_39_33 + arg_39_0 then
				local var_39_35 = "play"
				local var_39_36 = "music"

				arg_36_1:AudioAction(var_39_35, var_39_36, "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_39_37 = ""
				local var_39_38 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

				if var_39_38 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_38 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_38

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_38
						arg_36_1.bgmTxt2_.text = var_39_38
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_39 = 2

			if var_39_39 < arg_36_1.time_ and arg_36_1.time_ <= var_39_39 + arg_39_0 then
				arg_36_1.cswbg_:SetActive(false)
			end

			local var_39_40 = manager.ui.mainCamera.transform
			local var_39_41 = 2

			if var_39_41 < arg_36_1.time_ and arg_36_1.time_ <= var_39_41 + arg_39_0 then
				local var_39_42 = arg_36_1.var_.effectweisheng1

				if var_39_42 then
					Object.Destroy(var_39_42)

					arg_36_1.var_.effectweisheng1 = nil
				end
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_43 = 4
			local var_39_44 = 1.1

			if var_39_43 < arg_36_1.time_ and arg_36_1.time_ <= var_39_43 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_45 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_45:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_36_1.dialogCg_.alpha = arg_41_0
				end))
				var_39_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_46 = arg_36_1:GetWordFromCfg(938081009)
				local var_39_47 = arg_36_1:FormatText(var_39_46.content)

				arg_36_1.text_.text = var_39_47

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_48 = 44
				local var_39_49 = utf8.len(var_39_47)
				local var_39_50 = var_39_48 <= 0 and var_39_44 or var_39_44 * (var_39_49 / var_39_48)

				if var_39_50 > 0 and var_39_44 < var_39_50 then
					arg_36_1.talkMaxDuration = var_39_50
					var_39_43 = var_39_43 + 0.3

					if var_39_50 + var_39_43 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_50 + var_39_43
					end
				end

				arg_36_1.text_.text = var_39_47
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_51 = var_39_43 + 0.3
			local var_39_52 = math.max(var_39_44, arg_36_1.talkMaxDuration)

			if var_39_51 <= arg_36_1.time_ and arg_36_1.time_ < var_39_51 + var_39_52 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_51) / var_39_52

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_51 + var_39_52 and arg_36_1.time_ < var_39_51 + var_39_52 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play938081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 938081010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play938081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.875

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(938081010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 35
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play938081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 938081011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play938081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "10144"

			if arg_47_1.actors_[var_50_0] == nil then
				local var_50_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_50_1) then
					local var_50_2 = Object.Instantiate(var_50_1, arg_47_1.canvasGo_.transform)

					var_50_2.transform:SetSiblingIndex(1)

					var_50_2.name = var_50_0
					var_50_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_47_1.actors_[var_50_0] = var_50_2

					local var_50_3 = var_50_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_47_1.isInRecall_ then
						for iter_50_0, iter_50_1 in ipairs(var_50_3) do
							iter_50_1.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_50_4 = arg_47_1.actors_["10144"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10144 == nil then
				arg_47_1.var_.actorSpriteComps10144 = var_50_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_6 = 0.2

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 and not isNil(var_50_4) then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.actorSpriteComps10144 then
					for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_50_3 then
							if arg_47_1.isInRecall_ then
								local var_50_8 = Mathf.Lerp(iter_50_3.color.r, arg_47_1.hightColor1.r, var_50_7)
								local var_50_9 = Mathf.Lerp(iter_50_3.color.g, arg_47_1.hightColor1.g, var_50_7)
								local var_50_10 = Mathf.Lerp(iter_50_3.color.b, arg_47_1.hightColor1.b, var_50_7)

								iter_50_3.color = Color.New(var_50_8, var_50_9, var_50_10)
							else
								local var_50_11 = Mathf.Lerp(iter_50_3.color.r, 1, var_50_7)

								iter_50_3.color = Color.New(var_50_11, var_50_11, var_50_11)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10144 then
				for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_50_5 then
						if arg_47_1.isInRecall_ then
							iter_50_5.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10144 = nil
			end

			local var_50_12 = arg_47_1.actors_["10144"].transform
			local var_50_13 = 0

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1.var_.moveOldPos10144 = var_50_12.localPosition
				var_50_12.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10144", 2)

				local var_50_14 = var_50_12.childCount

				for iter_50_6 = 0, var_50_14 - 1 do
					local var_50_15 = var_50_12:GetChild(iter_50_6)

					if var_50_15.name == "split_14" or not string.find(var_50_15.name, "split") then
						var_50_15.gameObject:SetActive(true)
					else
						var_50_15.gameObject:SetActive(false)
					end
				end
			end

			local var_50_16 = 0.001

			if var_50_13 <= arg_47_1.time_ and arg_47_1.time_ < var_50_13 + var_50_16 then
				local var_50_17 = (arg_47_1.time_ - var_50_13) / var_50_16
				local var_50_18 = Vector3.New(-507.9, -381.1, -285.9)

				var_50_12.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10144, var_50_18, var_50_17)
			end

			if arg_47_1.time_ >= var_50_13 + var_50_16 and arg_47_1.time_ < var_50_13 + var_50_16 + arg_50_0 then
				var_50_12.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_50_19 = 0
			local var_50_20 = 0.65

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_21 = arg_47_1:FormatText(StoryNameCfg[1297].name)

				arg_47_1.leftNameTxt_.text = var_50_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_22 = arg_47_1:GetWordFromCfg(938081011)
				local var_50_23 = arg_47_1:FormatText(var_50_22.content)

				arg_47_1.text_.text = var_50_23

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_24 = 26
				local var_50_25 = utf8.len(var_50_23)
				local var_50_26 = var_50_24 <= 0 and var_50_20 or var_50_20 * (var_50_25 / var_50_24)

				if var_50_26 > 0 and var_50_20 < var_50_26 then
					arg_47_1.talkMaxDuration = var_50_26

					if var_50_26 + var_50_19 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_26 + var_50_19
					end
				end

				arg_47_1.text_.text = var_50_23
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_27 = math.max(var_50_20, arg_47_1.talkMaxDuration)

			if var_50_19 <= arg_47_1.time_ and arg_47_1.time_ < var_50_19 + var_50_27 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_19) / var_50_27

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_19 + var_50_27 and arg_47_1.time_ < var_50_19 + var_50_27 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play938081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 938081012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play938081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = "10183"

			if arg_51_1.actors_[var_54_0] == nil then
				local var_54_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_54_1) then
					local var_54_2 = Object.Instantiate(var_54_1, arg_51_1.canvasGo_.transform)

					var_54_2.transform:SetSiblingIndex(1)

					var_54_2.name = var_54_0
					var_54_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_51_1.actors_[var_54_0] = var_54_2

					local var_54_3 = var_54_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_51_1.isInRecall_ then
						for iter_54_0, iter_54_1 in ipairs(var_54_3) do
							iter_54_1.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_54_4 = arg_51_1.actors_["10183"]
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.actorSpriteComps10183 == nil then
				arg_51_1.var_.actorSpriteComps10183 = var_54_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 0.2

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 and not isNil(var_54_4) then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6

				if arg_51_1.var_.actorSpriteComps10183 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								local var_54_8 = Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, var_54_7)
								local var_54_9 = Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, var_54_7)
								local var_54_10 = Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, var_54_7)

								iter_54_3.color = Color.New(var_54_8, var_54_9, var_54_10)
							else
								local var_54_11 = Mathf.Lerp(iter_54_3.color.r, 1, var_54_7)

								iter_54_3.color = Color.New(var_54_11, var_54_11, var_54_11)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.actorSpriteComps10183 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_54_5 then
						if arg_51_1.isInRecall_ then
							iter_54_5.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10183 = nil
			end

			local var_54_12 = arg_51_1.actors_["10144"]
			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 and not isNil(var_54_12) and arg_51_1.var_.actorSpriteComps10144 == nil then
				arg_51_1.var_.actorSpriteComps10144 = var_54_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_14 = 0.2

			if var_54_13 <= arg_51_1.time_ and arg_51_1.time_ < var_54_13 + var_54_14 and not isNil(var_54_12) then
				local var_54_15 = (arg_51_1.time_ - var_54_13) / var_54_14

				if arg_51_1.var_.actorSpriteComps10144 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								local var_54_16 = Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, var_54_15)
								local var_54_17 = Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, var_54_15)
								local var_54_18 = Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, var_54_15)

								iter_54_7.color = Color.New(var_54_16, var_54_17, var_54_18)
							else
								local var_54_19 = Mathf.Lerp(iter_54_7.color.r, 0.5, var_54_15)

								iter_54_7.color = Color.New(var_54_19, var_54_19, var_54_19)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_13 + var_54_14 and arg_51_1.time_ < var_54_13 + var_54_14 + arg_54_0 and not isNil(var_54_12) and arg_51_1.var_.actorSpriteComps10144 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_54_9 then
						if arg_51_1.isInRecall_ then
							iter_54_9.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10144 = nil
			end

			local var_54_20 = arg_51_1.actors_["10183"].transform
			local var_54_21 = 0

			if var_54_21 < arg_51_1.time_ and arg_51_1.time_ <= var_54_21 + arg_54_0 then
				arg_51_1.var_.moveOldPos10183 = var_54_20.localPosition
				var_54_20.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10183", 4)

				local var_54_22 = var_54_20.childCount

				for iter_54_10 = 0, var_54_22 - 1 do
					local var_54_23 = var_54_20:GetChild(iter_54_10)

					if var_54_23.name == "split_9" or not string.find(var_54_23.name, "split") then
						var_54_23.gameObject:SetActive(true)
					else
						var_54_23.gameObject:SetActive(false)
					end
				end
			end

			local var_54_24 = 0.001

			if var_54_21 <= arg_51_1.time_ and arg_51_1.time_ < var_54_21 + var_54_24 then
				local var_54_25 = (arg_51_1.time_ - var_54_21) / var_54_24
				local var_54_26 = Vector3.New(300, -475, -325)

				var_54_20.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10183, var_54_26, var_54_25)
			end

			if arg_51_1.time_ >= var_54_21 + var_54_24 and arg_51_1.time_ < var_54_21 + var_54_24 + arg_54_0 then
				var_54_20.localPosition = Vector3.New(300, -475, -325)
			end

			local var_54_27 = 0
			local var_54_28 = 0.35

			if var_54_27 < arg_51_1.time_ and arg_51_1.time_ <= var_54_27 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_29 = arg_51_1:FormatText(StoryNameCfg[1562].name)

				arg_51_1.leftNameTxt_.text = var_54_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_30 = arg_51_1:GetWordFromCfg(938081012)
				local var_54_31 = arg_51_1:FormatText(var_54_30.content)

				arg_51_1.text_.text = var_54_31

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_32 = 14
				local var_54_33 = utf8.len(var_54_31)
				local var_54_34 = var_54_32 <= 0 and var_54_28 or var_54_28 * (var_54_33 / var_54_32)

				if var_54_34 > 0 and var_54_28 < var_54_34 then
					arg_51_1.talkMaxDuration = var_54_34

					if var_54_34 + var_54_27 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_34 + var_54_27
					end
				end

				arg_51_1.text_.text = var_54_31
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_35 = math.max(var_54_28, arg_51_1.talkMaxDuration)

			if var_54_27 <= arg_51_1.time_ and arg_51_1.time_ < var_54_27 + var_54_35 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_27) / var_54_35

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_27 + var_54_35 and arg_51_1.time_ < var_54_27 + var_54_35 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play938081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 938081013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play938081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10144"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10144 == nil then
				arg_55_1.var_.actorSpriteComps10144 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps10144 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor1.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor1.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor1.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 1, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10144 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10144 = nil
			end

			local var_58_8 = arg_55_1.actors_["10183"]
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10183 == nil then
				arg_55_1.var_.actorSpriteComps10183 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_10 = 0.2

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 and not isNil(var_58_8) then
				local var_58_11 = (arg_55_1.time_ - var_58_9) / var_58_10

				if arg_55_1.var_.actorSpriteComps10183 then
					for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_58_5 then
							if arg_55_1.isInRecall_ then
								local var_58_12 = Mathf.Lerp(iter_58_5.color.r, arg_55_1.hightColor2.r, var_58_11)
								local var_58_13 = Mathf.Lerp(iter_58_5.color.g, arg_55_1.hightColor2.g, var_58_11)
								local var_58_14 = Mathf.Lerp(iter_58_5.color.b, arg_55_1.hightColor2.b, var_58_11)

								iter_58_5.color = Color.New(var_58_12, var_58_13, var_58_14)
							else
								local var_58_15 = Mathf.Lerp(iter_58_5.color.r, 0.5, var_58_11)

								iter_58_5.color = Color.New(var_58_15, var_58_15, var_58_15)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10183 then
				for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_58_7 then
						if arg_55_1.isInRecall_ then
							iter_58_7.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10183 = nil
			end

			local var_58_16 = 0
			local var_58_17 = 0.575

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_18 = arg_55_1:FormatText(StoryNameCfg[1297].name)

				arg_55_1.leftNameTxt_.text = var_58_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_19 = arg_55_1:GetWordFromCfg(938081013)
				local var_58_20 = arg_55_1:FormatText(var_58_19.content)

				arg_55_1.text_.text = var_58_20

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 23
				local var_58_22 = utf8.len(var_58_20)
				local var_58_23 = var_58_21 <= 0 and var_58_17 or var_58_17 * (var_58_22 / var_58_21)

				if var_58_23 > 0 and var_58_17 < var_58_23 then
					arg_55_1.talkMaxDuration = var_58_23

					if var_58_23 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_23 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_20
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_16) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_24 and arg_55_1.time_ < var_58_16 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play938081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 938081014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play938081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10183"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps10183 == nil then
				arg_59_1.var_.actorSpriteComps10183 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps10183 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								local var_62_4 = Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, var_62_3)
								local var_62_5 = Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, var_62_3)
								local var_62_6 = Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, var_62_3)

								iter_62_1.color = Color.New(var_62_4, var_62_5, var_62_6)
							else
								local var_62_7 = Mathf.Lerp(iter_62_1.color.r, 1, var_62_3)

								iter_62_1.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps10183 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10183 = nil
			end

			local var_62_8 = arg_59_1.actors_["10144"]
			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10144 == nil then
				arg_59_1.var_.actorSpriteComps10144 = var_62_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_10 = 0.2

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_10 and not isNil(var_62_8) then
				local var_62_11 = (arg_59_1.time_ - var_62_9) / var_62_10

				if arg_59_1.var_.actorSpriteComps10144 then
					for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_62_5 then
							if arg_59_1.isInRecall_ then
								local var_62_12 = Mathf.Lerp(iter_62_5.color.r, arg_59_1.hightColor2.r, var_62_11)
								local var_62_13 = Mathf.Lerp(iter_62_5.color.g, arg_59_1.hightColor2.g, var_62_11)
								local var_62_14 = Mathf.Lerp(iter_62_5.color.b, arg_59_1.hightColor2.b, var_62_11)

								iter_62_5.color = Color.New(var_62_12, var_62_13, var_62_14)
							else
								local var_62_15 = Mathf.Lerp(iter_62_5.color.r, 0.5, var_62_11)

								iter_62_5.color = Color.New(var_62_15, var_62_15, var_62_15)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_9 + var_62_10 and arg_59_1.time_ < var_62_9 + var_62_10 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10144 then
				for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_62_7 then
						if arg_59_1.isInRecall_ then
							iter_62_7.color = arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_62_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10144 = nil
			end

			local var_62_16 = arg_59_1.actors_["10183"].transform
			local var_62_17 = 0

			if var_62_17 < arg_59_1.time_ and arg_59_1.time_ <= var_62_17 + arg_62_0 then
				arg_59_1.var_.moveOldPos10183 = var_62_16.localPosition
				var_62_16.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10183", 4)

				local var_62_18 = var_62_16.childCount

				for iter_62_8 = 0, var_62_18 - 1 do
					local var_62_19 = var_62_16:GetChild(iter_62_8)

					if var_62_19.name == "split_12" or not string.find(var_62_19.name, "split") then
						var_62_19.gameObject:SetActive(true)
					else
						var_62_19.gameObject:SetActive(false)
					end
				end
			end

			local var_62_20 = 0.001

			if var_62_17 <= arg_59_1.time_ and arg_59_1.time_ < var_62_17 + var_62_20 then
				local var_62_21 = (arg_59_1.time_ - var_62_17) / var_62_20
				local var_62_22 = Vector3.New(300, -475, -325)

				var_62_16.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10183, var_62_22, var_62_21)
			end

			if arg_59_1.time_ >= var_62_17 + var_62_20 and arg_59_1.time_ < var_62_17 + var_62_20 + arg_62_0 then
				var_62_16.localPosition = Vector3.New(300, -475, -325)
			end

			local var_62_23 = manager.ui.mainCamera.transform
			local var_62_24 = 0

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_23.localPosition
			end

			local var_62_25 = 0.4

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_25 then
				local var_62_26 = (arg_59_1.time_ - var_62_24) / 0.066
				local var_62_27, var_62_28 = math.modf(var_62_26)

				var_62_23.localPosition = Vector3.New(var_62_28 * 0.13, var_62_28 * 0.13, var_62_28 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= var_62_24 + var_62_25 and arg_59_1.time_ < var_62_24 + var_62_25 + arg_62_0 then
				var_62_23.localPosition = arg_59_1.var_.shakeOldPos
			end

			local var_62_29 = arg_59_1.actors_["10183"].transform
			local var_62_30 = 0

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.var_.moveOldPos10183 = var_62_29.localPosition
				var_62_29.localScale = Vector3.New(1, 1, 1)

				local var_62_31 = var_62_29.childCount

				for iter_62_9 = 0, var_62_31 - 1 do
					local var_62_32 = var_62_29:GetChild(iter_62_9)

					if var_62_32.name == "" or not string.find(var_62_32.name, "split") then
						var_62_32.gameObject:SetActive(true)
					else
						var_62_32.gameObject:SetActive(false)
					end
				end
			end

			local var_62_33 = 0.4

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_33 then
				local var_62_34 = (arg_59_1.time_ - var_62_30) / var_62_33
				local var_62_35 = Vector3.New(300, 28000, 88888)

				var_62_29.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10183, var_62_35, var_62_34)
			end

			if arg_59_1.time_ >= var_62_30 + var_62_33 and arg_59_1.time_ < var_62_30 + var_62_33 + arg_62_0 then
				var_62_29.localPosition = Vector3.New(300, 28000, 88888)
			end

			local var_62_36 = arg_59_1.actors_["10144"].transform
			local var_62_37 = 0

			if var_62_37 < arg_59_1.time_ and arg_59_1.time_ <= var_62_37 + arg_62_0 then
				arg_59_1.var_.moveOldPos10144 = var_62_36.localPosition
				var_62_36.localScale = Vector3.New(1, 1, 1)

				local var_62_38 = var_62_36.childCount

				for iter_62_10 = 0, var_62_38 - 1 do
					local var_62_39 = var_62_36:GetChild(iter_62_10)

					if var_62_39.name == "split_14" or not string.find(var_62_39.name, "split") then
						var_62_39.gameObject:SetActive(true)
					else
						var_62_39.gameObject:SetActive(false)
					end
				end
			end

			local var_62_40 = 0.533333333333333

			if var_62_37 <= arg_59_1.time_ and arg_59_1.time_ < var_62_37 + var_62_40 then
				local var_62_41 = (arg_59_1.time_ - var_62_37) / var_62_40
				local var_62_42 = Vector3.New(-480, -381.1, -285.9)

				var_62_36.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10144, var_62_42, var_62_41)
			end

			if arg_59_1.time_ >= var_62_37 + var_62_40 and arg_59_1.time_ < var_62_37 + var_62_40 + arg_62_0 then
				var_62_36.localPosition = Vector3.New(-480, -381.1, -285.9)
			end

			local var_62_43 = arg_59_1.actors_["10144"].transform
			local var_62_44 = 0.533333333333333

			if var_62_44 < arg_59_1.time_ and arg_59_1.time_ <= var_62_44 + arg_62_0 then
				arg_59_1.var_.moveOldPos10144 = var_62_43.localPosition
				var_62_43.localScale = Vector3.New(1, 1, 1)

				local var_62_45 = var_62_43.childCount

				for iter_62_11 = 0, var_62_45 - 1 do
					local var_62_46 = var_62_43:GetChild(iter_62_11)

					if var_62_46.name == "split_14" or not string.find(var_62_46.name, "split") then
						var_62_46.gameObject:SetActive(true)
					else
						var_62_46.gameObject:SetActive(false)
					end
				end
			end

			local var_62_47 = 0.001

			if var_62_44 <= arg_59_1.time_ and arg_59_1.time_ < var_62_44 + var_62_47 then
				local var_62_48 = (arg_59_1.time_ - var_62_44) / var_62_47
				local var_62_49 = Vector3.New(-507.9, -381.1, -285.9)

				var_62_43.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10144, var_62_49, var_62_48)
			end

			if arg_59_1.time_ >= var_62_44 + var_62_47 and arg_59_1.time_ < var_62_44 + var_62_47 + arg_62_0 then
				var_62_43.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_62_50 = 0

			if var_62_50 < arg_59_1.time_ and arg_59_1.time_ <= var_62_50 + arg_62_0 then
				arg_59_1.allBtn_.enabled = false
			end

			local var_62_51 = 0.566880501341075

			if arg_59_1.time_ >= var_62_50 + var_62_51 and arg_59_1.time_ < var_62_50 + var_62_51 + arg_62_0 then
				arg_59_1.allBtn_.enabled = true
			end

			local var_62_52 = 0
			local var_62_53 = 0.4

			if var_62_52 < arg_59_1.time_ and arg_59_1.time_ <= var_62_52 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_54 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_54:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_55 = arg_59_1:FormatText(StoryNameCfg[1562].name)

				arg_59_1.leftNameTxt_.text = var_62_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_56 = arg_59_1:GetWordFromCfg(938081014)
				local var_62_57 = arg_59_1:FormatText(var_62_56.content)

				arg_59_1.text_.text = var_62_57

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_58 = 16
				local var_62_59 = utf8.len(var_62_57)
				local var_62_60 = var_62_58 <= 0 and var_62_53 or var_62_53 * (var_62_59 / var_62_58)

				if var_62_60 > 0 and var_62_53 < var_62_60 then
					arg_59_1.talkMaxDuration = var_62_60
					var_62_52 = var_62_52 + 0.3

					if var_62_60 + var_62_52 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_60 + var_62_52
					end
				end

				arg_59_1.text_.text = var_62_57
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_61 = var_62_52 + 0.3
			local var_62_62 = math.max(var_62_53, arg_59_1.talkMaxDuration)

			if var_62_61 <= arg_59_1.time_ and arg_59_1.time_ < var_62_61 + var_62_62 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_61) / var_62_62

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_61 + var_62_62 and arg_59_1.time_ < var_62_61 + var_62_62 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(300, -475, -325),
					endPos = Vector3.New(300, 28000, 88888),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-507.9, -381.1, -285.9),
					endPos = Vector3.New(-480, -381.1, -285.9),
					easeType = LeanTweenType.easeShake
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "10144",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.0335471680077414,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-507.9, -381.1, -285.9),
					endPos = Vector3.New(-507.9, -381.1, -285.9),
					easeType = LeanTweenType.easeShake
				}
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play938081015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 938081015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play938081016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10183"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10183 == nil then
				arg_65_1.var_.actorSpriteComps10183 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10183 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor2.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor2.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor2.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 0.5, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10183 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10183 = nil
			end

			local var_68_8 = arg_65_1.actors_["10183"].transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPos10183 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10183", 7)

				local var_68_10 = var_68_8.childCount

				for iter_68_4 = 0, var_68_10 - 1 do
					local var_68_11 = var_68_8:GetChild(iter_68_4)

					if var_68_11.name == "" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_9) / var_68_12
				local var_68_14 = Vector3.New(0, -2000, 0)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10183, var_68_14, var_68_13)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_12 and arg_65_1.time_ < var_68_9 + var_68_12 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_15 = arg_65_1.actors_["10144"].transform
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_15.localPosition
				var_68_15.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 7)

				local var_68_17 = var_68_15.childCount

				for iter_68_5 = 0, var_68_17 - 1 do
					local var_68_18 = var_68_15:GetChild(iter_68_5)

					if var_68_18.name == "" or not string.find(var_68_18.name, "split") then
						var_68_18.gameObject:SetActive(true)
					else
						var_68_18.gameObject:SetActive(false)
					end
				end
			end

			local var_68_19 = 0.001

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_19 then
				local var_68_20 = (arg_65_1.time_ - var_68_16) / var_68_19
				local var_68_21 = Vector3.New(0, -2000, 0)

				var_68_15.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, var_68_21, var_68_20)
			end

			if arg_65_1.time_ >= var_68_16 + var_68_19 and arg_65_1.time_ < var_68_16 + var_68_19 + arg_68_0 then
				var_68_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_22 = 0
			local var_68_23 = 1.375

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(938081015)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 55
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_23 or var_68_23 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_23 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_22 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_22
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_29 = math.max(var_68_23, arg_65_1.talkMaxDuration)

			if var_68_22 <= arg_65_1.time_ and arg_65_1.time_ < var_68_22 + var_68_29 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_22) / var_68_29

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_22 + var_68_29 and arg_65_1.time_ < var_68_22 + var_68_29 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play938081016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 938081016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play938081017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10144"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10144 == nil then
				arg_69_1.var_.actorSpriteComps10144 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10144 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10144 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10144 = nil
			end

			local var_72_8 = arg_69_1.actors_["10144"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "split_13" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_72_15 = 0
			local var_72_16 = 1.25

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[1297].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(938081016)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 50
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_23 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_23 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_23

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_23 and arg_69_1.time_ < var_72_15 + var_72_23 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play938081017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 938081017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play938081018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10144"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10144 == nil then
				arg_73_1.var_.actorSpriteComps10144 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10144 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.225

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_10

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

				local var_76_11 = arg_73_1:GetWordFromCfg(938081017)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 9
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_9 or var_76_9 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_9 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
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

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play938081018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 938081018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play938081019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "108301"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(var_80_1, arg_77_1.canvasGo_.transform)

					var_80_2.transform:SetSiblingIndex(1)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs(var_80_3) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_4 = arg_77_1.actors_["108301"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.actorSpriteComps108301 == nil then
				arg_77_1.var_.actorSpriteComps108301 = var_80_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.actorSpriteComps108301 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								local var_80_8 = Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, var_80_7)
								local var_80_9 = Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, var_80_7)
								local var_80_10 = Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, var_80_7)

								iter_80_3.color = Color.New(var_80_8, var_80_9, var_80_10)
							else
								local var_80_11 = Mathf.Lerp(iter_80_3.color.r, 1, var_80_7)

								iter_80_3.color = Color.New(var_80_11, var_80_11, var_80_11)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.actorSpriteComps108301 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_80_5 then
						if arg_77_1.isInRecall_ then
							iter_80_5.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps108301 = nil
			end

			local var_80_12 = arg_77_1.actors_["108301"].transform
			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1.var_.moveOldPos108301 = var_80_12.localPosition
				var_80_12.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("108301", 4)

				local var_80_14 = var_80_12.childCount

				for iter_80_6 = 0, var_80_14 - 1 do
					local var_80_15 = var_80_12:GetChild(iter_80_6)

					if var_80_15.name == "split_7" or not string.find(var_80_15.name, "split") then
						var_80_15.gameObject:SetActive(true)
					else
						var_80_15.gameObject:SetActive(false)
					end
				end
			end

			local var_80_16 = 0.001

			if var_80_13 <= arg_77_1.time_ and arg_77_1.time_ < var_80_13 + var_80_16 then
				local var_80_17 = (arg_77_1.time_ - var_80_13) / var_80_16
				local var_80_18 = Vector3.New(460, -360, -195)

				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos108301, var_80_18, var_80_17)
			end

			if arg_77_1.time_ >= var_80_13 + var_80_16 and arg_77_1.time_ < var_80_13 + var_80_16 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(460, -360, -195)
			end

			local var_80_19 = arg_77_1.actors_["10144"].transform
			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = var_80_19.localPosition
				var_80_19.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 2)

				local var_80_21 = var_80_19.childCount

				for iter_80_7 = 0, var_80_21 - 1 do
					local var_80_22 = var_80_19:GetChild(iter_80_7)

					if var_80_22.name == "split_13" or not string.find(var_80_22.name, "split") then
						var_80_22.gameObject:SetActive(true)
					else
						var_80_22.gameObject:SetActive(false)
					end
				end
			end

			local var_80_23 = 0.001

			if var_80_20 <= arg_77_1.time_ and arg_77_1.time_ < var_80_20 + var_80_23 then
				local var_80_24 = (arg_77_1.time_ - var_80_20) / var_80_23
				local var_80_25 = Vector3.New(-507.9, -381.1, -285.9)

				var_80_19.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, var_80_25, var_80_24)
			end

			if arg_77_1.time_ >= var_80_20 + var_80_23 and arg_77_1.time_ < var_80_20 + var_80_23 + arg_80_0 then
				var_80_19.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_80_26 = 0
			local var_80_27 = 0.525

			if var_80_26 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_28 = arg_77_1:FormatText(StoryNameCfg[1332].name)

				arg_77_1.leftNameTxt_.text = var_80_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_29 = arg_77_1:GetWordFromCfg(938081018)
				local var_80_30 = arg_77_1:FormatText(var_80_29.content)

				arg_77_1.text_.text = var_80_30

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_31 = 21
				local var_80_32 = utf8.len(var_80_30)
				local var_80_33 = var_80_31 <= 0 and var_80_27 or var_80_27 * (var_80_32 / var_80_31)

				if var_80_33 > 0 and var_80_27 < var_80_33 then
					arg_77_1.talkMaxDuration = var_80_33

					if var_80_33 + var_80_26 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_33 + var_80_26
					end
				end

				arg_77_1.text_.text = var_80_30
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_34 = math.max(var_80_27, arg_77_1.talkMaxDuration)

			if var_80_26 <= arg_77_1.time_ and arg_77_1.time_ < var_80_26 + var_80_34 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_26) / var_80_34

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_26 + var_80_34 and arg_77_1.time_ < var_80_26 + var_80_34 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play938081019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 938081019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play938081020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10144"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10144 == nil then
				arg_81_1.var_.actorSpriteComps10144 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10144 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10144 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10144 = nil
			end

			local var_84_8 = arg_81_1.actors_["108301"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps108301 == nil then
				arg_81_1.var_.actorSpriteComps108301 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps108301 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 0.5, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps108301 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps108301 = nil
			end

			local var_84_16 = arg_81_1.actors_["10144"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos10144 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10144", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_11" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10144, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_84_23 = 0
			local var_84_24 = 0.925

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[1297].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(938081019)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 37
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_31 and arg_81_1.time_ < var_84_23 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 938081020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play938081021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = "128404"

			if arg_85_1.actors_[var_88_0] == nil then
				local var_88_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_88_1) then
					local var_88_2 = Object.Instantiate(var_88_1, arg_85_1.canvasGo_.transform)

					var_88_2.transform:SetSiblingIndex(1)

					var_88_2.name = var_88_0
					var_88_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_85_1.actors_[var_88_0] = var_88_2

					local var_88_3 = var_88_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_85_1.isInRecall_ then
						for iter_88_0, iter_88_1 in ipairs(var_88_3) do
							iter_88_1.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_88_4 = arg_85_1.actors_["128404"]
			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.actorSpriteComps128404 == nil then
				arg_85_1.var_.actorSpriteComps128404 = var_88_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_6 = 0.2

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 and not isNil(var_88_4) then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / var_88_6

				if arg_85_1.var_.actorSpriteComps128404 then
					for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_88_3 then
							if arg_85_1.isInRecall_ then
								local var_88_8 = Mathf.Lerp(iter_88_3.color.r, arg_85_1.hightColor1.r, var_88_7)
								local var_88_9 = Mathf.Lerp(iter_88_3.color.g, arg_85_1.hightColor1.g, var_88_7)
								local var_88_10 = Mathf.Lerp(iter_88_3.color.b, arg_85_1.hightColor1.b, var_88_7)

								iter_88_3.color = Color.New(var_88_8, var_88_9, var_88_10)
							else
								local var_88_11 = Mathf.Lerp(iter_88_3.color.r, 1, var_88_7)

								iter_88_3.color = Color.New(var_88_11, var_88_11, var_88_11)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.actorSpriteComps128404 then
				for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_88_5 then
						if arg_85_1.isInRecall_ then
							iter_88_5.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps128404 = nil
			end

			local var_88_12 = arg_85_1.actors_["10144"]
			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 and not isNil(var_88_12) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = var_88_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_14 = 0.2

			if var_88_13 <= arg_85_1.time_ and arg_85_1.time_ < var_88_13 + var_88_14 and not isNil(var_88_12) then
				local var_88_15 = (arg_85_1.time_ - var_88_13) / var_88_14

				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_88_7 then
							if arg_85_1.isInRecall_ then
								local var_88_16 = Mathf.Lerp(iter_88_7.color.r, arg_85_1.hightColor2.r, var_88_15)
								local var_88_17 = Mathf.Lerp(iter_88_7.color.g, arg_85_1.hightColor2.g, var_88_15)
								local var_88_18 = Mathf.Lerp(iter_88_7.color.b, arg_85_1.hightColor2.b, var_88_15)

								iter_88_7.color = Color.New(var_88_16, var_88_17, var_88_18)
							else
								local var_88_19 = Mathf.Lerp(iter_88_7.color.r, 0.5, var_88_15)

								iter_88_7.color = Color.New(var_88_19, var_88_19, var_88_19)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_13 + var_88_14 and arg_85_1.time_ < var_88_13 + var_88_14 + arg_88_0 and not isNil(var_88_12) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_8, iter_88_9 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_9 then
						if arg_85_1.isInRecall_ then
							iter_88_9.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_20 = arg_85_1.actors_["128404"].transform
			local var_88_21 = 0

			if var_88_21 < arg_85_1.time_ and arg_85_1.time_ <= var_88_21 + arg_88_0 then
				arg_85_1.var_.moveOldPos128404 = var_88_20.localPosition
				var_88_20.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("128404", 4)

				local var_88_22 = var_88_20.childCount

				for iter_88_10 = 0, var_88_22 - 1 do
					local var_88_23 = var_88_20:GetChild(iter_88_10)

					if var_88_23.name == "split_9" or not string.find(var_88_23.name, "split") then
						var_88_23.gameObject:SetActive(true)
					else
						var_88_23.gameObject:SetActive(false)
					end
				end
			end

			local var_88_24 = 0.001

			if var_88_21 <= arg_85_1.time_ and arg_85_1.time_ < var_88_21 + var_88_24 then
				local var_88_25 = (arg_85_1.time_ - var_88_21) / var_88_24
				local var_88_26 = Vector3.New(390.2, -356, -362.3)

				var_88_20.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos128404, var_88_26, var_88_25)
			end

			if arg_85_1.time_ >= var_88_21 + var_88_24 and arg_85_1.time_ < var_88_21 + var_88_24 + arg_88_0 then
				var_88_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_88_27 = arg_85_1.actors_["108301"].transform
			local var_88_28 = 0

			if var_88_28 < arg_85_1.time_ and arg_85_1.time_ <= var_88_28 + arg_88_0 then
				arg_85_1.var_.moveOldPos108301 = var_88_27.localPosition
				var_88_27.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("108301", 7)

				local var_88_29 = var_88_27.childCount

				for iter_88_11 = 0, var_88_29 - 1 do
					local var_88_30 = var_88_27:GetChild(iter_88_11)

					if var_88_30.name == "split_4" or not string.find(var_88_30.name, "split") then
						var_88_30.gameObject:SetActive(true)
					else
						var_88_30.gameObject:SetActive(false)
					end
				end
			end

			local var_88_31 = 0.001

			if var_88_28 <= arg_85_1.time_ and arg_85_1.time_ < var_88_28 + var_88_31 then
				local var_88_32 = (arg_85_1.time_ - var_88_28) / var_88_31
				local var_88_33 = Vector3.New(0, -2000, 0)

				var_88_27.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos108301, var_88_33, var_88_32)
			end

			if arg_85_1.time_ >= var_88_28 + var_88_31 and arg_85_1.time_ < var_88_28 + var_88_31 + arg_88_0 then
				var_88_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_88_34 = 0
			local var_88_35 = 0.425

			if var_88_34 < arg_85_1.time_ and arg_85_1.time_ <= var_88_34 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_36 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_37 = arg_85_1:GetWordFromCfg(938081020)
				local var_88_38 = arg_85_1:FormatText(var_88_37.content)

				arg_85_1.text_.text = var_88_38

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_39 = 17
				local var_88_40 = utf8.len(var_88_38)
				local var_88_41 = var_88_39 <= 0 and var_88_35 or var_88_35 * (var_88_40 / var_88_39)

				if var_88_41 > 0 and var_88_35 < var_88_41 then
					arg_85_1.talkMaxDuration = var_88_41

					if var_88_41 + var_88_34 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_41 + var_88_34
					end
				end

				arg_85_1.text_.text = var_88_38
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_42 = math.max(var_88_35, arg_85_1.talkMaxDuration)

			if var_88_34 <= arg_85_1.time_ and arg_85_1.time_ < var_88_34 + var_88_42 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_34) / var_88_42

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_34 + var_88_42 and arg_85_1.time_ < var_88_34 + var_88_42 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
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
	Play938081021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 938081021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play938081022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10144"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10144 == nil then
				arg_89_1.var_.actorSpriteComps10144 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10144 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10144 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10144 = nil
			end

			local var_92_8 = arg_89_1.actors_["128404"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps128404 == nil then
				arg_89_1.var_.actorSpriteComps128404 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps128404 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps128404 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps128404 = nil
			end

			local var_92_16 = arg_89_1.actors_["10144"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 2)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "split_11" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_92_23 = 0
			local var_92_24 = 0.4

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[1297].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(938081021)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 16
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_31 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_31 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_31

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_31 and arg_89_1.time_ < var_92_23 + var_92_31 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 938081022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play938081023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.15

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1297].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(938081022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 46
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play938081023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 938081023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play938081024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.45

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[1297].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(938081023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 18
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play938081024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 938081024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play938081025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "106603"

			if arg_101_1.actors_[var_104_0] == nil then
				local var_104_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_104_1) then
					local var_104_2 = Object.Instantiate(var_104_1, arg_101_1.canvasGo_.transform)

					var_104_2.transform:SetSiblingIndex(1)

					var_104_2.name = var_104_0
					var_104_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_[var_104_0] = var_104_2

					local var_104_3 = var_104_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs(var_104_3) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_4 = arg_101_1.actors_["106603"]
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.actorSpriteComps106603 == nil then
				arg_101_1.var_.actorSpriteComps106603 = var_104_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.2

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 and not isNil(var_104_4) then
				local var_104_7 = (arg_101_1.time_ - var_104_5) / var_104_6

				if arg_101_1.var_.actorSpriteComps106603 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								local var_104_8 = Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, var_104_7)
								local var_104_9 = Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, var_104_7)
								local var_104_10 = Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, var_104_7)

								iter_104_3.color = Color.New(var_104_8, var_104_9, var_104_10)
							else
								local var_104_11 = Mathf.Lerp(iter_104_3.color.r, 1, var_104_7)

								iter_104_3.color = Color.New(var_104_11, var_104_11, var_104_11)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.actorSpriteComps106603 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_104_5 then
						if arg_101_1.isInRecall_ then
							iter_104_5.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps106603 = nil
			end

			local var_104_12 = arg_101_1.actors_["10144"]
			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 and not isNil(var_104_12) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = var_104_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_14 = 0.2

			if var_104_13 <= arg_101_1.time_ and arg_101_1.time_ < var_104_13 + var_104_14 and not isNil(var_104_12) then
				local var_104_15 = (arg_101_1.time_ - var_104_13) / var_104_14

				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_104_7 then
							if arg_101_1.isInRecall_ then
								local var_104_16 = Mathf.Lerp(iter_104_7.color.r, arg_101_1.hightColor2.r, var_104_15)
								local var_104_17 = Mathf.Lerp(iter_104_7.color.g, arg_101_1.hightColor2.g, var_104_15)
								local var_104_18 = Mathf.Lerp(iter_104_7.color.b, arg_101_1.hightColor2.b, var_104_15)

								iter_104_7.color = Color.New(var_104_16, var_104_17, var_104_18)
							else
								local var_104_19 = Mathf.Lerp(iter_104_7.color.r, 0.5, var_104_15)

								iter_104_7.color = Color.New(var_104_19, var_104_19, var_104_19)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_13 + var_104_14 and arg_101_1.time_ < var_104_13 + var_104_14 + arg_104_0 and not isNil(var_104_12) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_8, iter_104_9 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_9 then
						if arg_101_1.isInRecall_ then
							iter_104_9.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_20 = arg_101_1.actors_["106603"].transform
			local var_104_21 = 0

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.var_.moveOldPos106603 = var_104_20.localPosition
				var_104_20.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("106603", 2)

				local var_104_22 = var_104_20.childCount

				for iter_104_10 = 0, var_104_22 - 1 do
					local var_104_23 = var_104_20:GetChild(iter_104_10)

					if var_104_23.name == "split_12" or not string.find(var_104_23.name, "split") then
						var_104_23.gameObject:SetActive(true)
					else
						var_104_23.gameObject:SetActive(false)
					end
				end
			end

			local var_104_24 = 0.001

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_24 then
				local var_104_25 = (arg_101_1.time_ - var_104_21) / var_104_24
				local var_104_26 = Vector3.New(-510.9, -399.1, -303.3)

				var_104_20.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos106603, var_104_26, var_104_25)
			end

			if arg_101_1.time_ >= var_104_21 + var_104_24 and arg_101_1.time_ < var_104_21 + var_104_24 + arg_104_0 then
				var_104_20.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_104_27 = arg_101_1.actors_["10144"].transform
			local var_104_28 = 0

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.var_.moveOldPos10144 = var_104_27.localPosition
				var_104_27.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10144", 7)

				local var_104_29 = var_104_27.childCount

				for iter_104_11 = 0, var_104_29 - 1 do
					local var_104_30 = var_104_27:GetChild(iter_104_11)

					if var_104_30.name == "" or not string.find(var_104_30.name, "split") then
						var_104_30.gameObject:SetActive(true)
					else
						var_104_30.gameObject:SetActive(false)
					end
				end
			end

			local var_104_31 = 0.001

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_31 then
				local var_104_32 = (arg_101_1.time_ - var_104_28) / var_104_31
				local var_104_33 = Vector3.New(0, -2000, 0)

				var_104_27.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10144, var_104_33, var_104_32)
			end

			if arg_101_1.time_ >= var_104_28 + var_104_31 and arg_101_1.time_ < var_104_28 + var_104_31 + arg_104_0 then
				var_104_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_34 = 0
			local var_104_35 = 0.15

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_36 = arg_101_1:FormatText(StoryNameCfg[32].name)

				arg_101_1.leftNameTxt_.text = var_104_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_37 = arg_101_1:GetWordFromCfg(938081024)
				local var_104_38 = arg_101_1:FormatText(var_104_37.content)

				arg_101_1.text_.text = var_104_38

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_39 = 6
				local var_104_40 = utf8.len(var_104_38)
				local var_104_41 = var_104_39 <= 0 and var_104_35 or var_104_35 * (var_104_40 / var_104_39)

				if var_104_41 > 0 and var_104_35 < var_104_41 then
					arg_101_1.talkMaxDuration = var_104_41

					if var_104_41 + var_104_34 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_41 + var_104_34
					end
				end

				arg_101_1.text_.text = var_104_38
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_42 = math.max(var_104_35, arg_101_1.talkMaxDuration)

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_42 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_34) / var_104_42

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_34 + var_104_42 and arg_101_1.time_ < var_104_34 + var_104_42 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play938081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 938081025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play938081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["128404"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps128404 == nil then
				arg_105_1.var_.actorSpriteComps128404 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps128404 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps128404 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps128404 = nil
			end

			local var_108_8 = arg_105_1.actors_["106603"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps106603 == nil then
				arg_105_1.var_.actorSpriteComps106603 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps106603 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps106603 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps106603 = nil
			end

			local var_108_16 = arg_105_1.actors_["128404"].transform
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 then
				arg_105_1.var_.moveOldPos128404 = var_108_16.localPosition
				var_108_16.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("128404", 4)

				local var_108_18 = var_108_16.childCount

				for iter_108_8 = 0, var_108_18 - 1 do
					local var_108_19 = var_108_16:GetChild(iter_108_8)

					if var_108_19.name == "split_9" or not string.find(var_108_19.name, "split") then
						var_108_19.gameObject:SetActive(true)
					else
						var_108_19.gameObject:SetActive(false)
					end
				end
			end

			local var_108_20 = 0.001

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_20 then
				local var_108_21 = (arg_105_1.time_ - var_108_17) / var_108_20
				local var_108_22 = Vector3.New(390.2, -356, -362.3)

				var_108_16.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos128404, var_108_22, var_108_21)
			end

			if arg_105_1.time_ >= var_108_17 + var_108_20 and arg_105_1.time_ < var_108_17 + var_108_20 + arg_108_0 then
				var_108_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_108_23 = 0
			local var_108_24 = 0.45

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(938081025)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 18
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_31 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_31 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_31

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_31 and arg_105_1.time_ < var_108_23 + var_108_31 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play938081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 938081026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play938081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10144"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10144 == nil then
				arg_109_1.var_.actorSpriteComps10144 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps10144 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 1, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps10144 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10144 = nil
			end

			local var_112_8 = arg_109_1.actors_["128404"]
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps128404 == nil then
				arg_109_1.var_.actorSpriteComps128404 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_10 = 0.2

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 and not isNil(var_112_8) then
				local var_112_11 = (arg_109_1.time_ - var_112_9) / var_112_10

				if arg_109_1.var_.actorSpriteComps128404 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								local var_112_12 = Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor2.r, var_112_11)
								local var_112_13 = Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor2.g, var_112_11)
								local var_112_14 = Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor2.b, var_112_11)

								iter_112_5.color = Color.New(var_112_12, var_112_13, var_112_14)
							else
								local var_112_15 = Mathf.Lerp(iter_112_5.color.r, 0.5, var_112_11)

								iter_112_5.color = Color.New(var_112_15, var_112_15, var_112_15)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps128404 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_112_7 then
						if arg_109_1.isInRecall_ then
							iter_112_7.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps128404 = nil
			end

			local var_112_16 = arg_109_1.actors_["10144"].transform
			local var_112_17 = 0

			if var_112_17 < arg_109_1.time_ and arg_109_1.time_ <= var_112_17 + arg_112_0 then
				arg_109_1.var_.moveOldPos10144 = var_112_16.localPosition
				var_112_16.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10144", 2)

				local var_112_18 = var_112_16.childCount

				for iter_112_8 = 0, var_112_18 - 1 do
					local var_112_19 = var_112_16:GetChild(iter_112_8)

					if var_112_19.name == "split_11" or not string.find(var_112_19.name, "split") then
						var_112_19.gameObject:SetActive(true)
					else
						var_112_19.gameObject:SetActive(false)
					end
				end
			end

			local var_112_20 = 0.001

			if var_112_17 <= arg_109_1.time_ and arg_109_1.time_ < var_112_17 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_17) / var_112_20
				local var_112_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_112_16.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10144, var_112_22, var_112_21)
			end

			if arg_109_1.time_ >= var_112_17 + var_112_20 and arg_109_1.time_ < var_112_17 + var_112_20 + arg_112_0 then
				var_112_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_112_23 = arg_109_1.actors_["106603"].transform
			local var_112_24 = 0

			if var_112_24 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.var_.moveOldPos106603 = var_112_23.localPosition
				var_112_23.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("106603", 7)

				local var_112_25 = var_112_23.childCount

				for iter_112_9 = 0, var_112_25 - 1 do
					local var_112_26 = var_112_23:GetChild(iter_112_9)

					if var_112_26.name == "" or not string.find(var_112_26.name, "split") then
						var_112_26.gameObject:SetActive(true)
					else
						var_112_26.gameObject:SetActive(false)
					end
				end
			end

			local var_112_27 = 0.001

			if var_112_24 <= arg_109_1.time_ and arg_109_1.time_ < var_112_24 + var_112_27 then
				local var_112_28 = (arg_109_1.time_ - var_112_24) / var_112_27
				local var_112_29 = Vector3.New(0, -2000, 0)

				var_112_23.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos106603, var_112_29, var_112_28)
			end

			if arg_109_1.time_ >= var_112_24 + var_112_27 and arg_109_1.time_ < var_112_24 + var_112_27 + arg_112_0 then
				var_112_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_30 = 0
			local var_112_31 = 0.75

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_32 = arg_109_1:FormatText(StoryNameCfg[1297].name)

				arg_109_1.leftNameTxt_.text = var_112_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_33 = arg_109_1:GetWordFromCfg(938081026)
				local var_112_34 = arg_109_1:FormatText(var_112_33.content)

				arg_109_1.text_.text = var_112_34

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_35 = 30
				local var_112_36 = utf8.len(var_112_34)
				local var_112_37 = var_112_35 <= 0 and var_112_31 or var_112_31 * (var_112_36 / var_112_35)

				if var_112_37 > 0 and var_112_31 < var_112_37 then
					arg_109_1.talkMaxDuration = var_112_37

					if var_112_37 + var_112_30 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_37 + var_112_30
					end
				end

				arg_109_1.text_.text = var_112_34
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_38 = math.max(var_112_31, arg_109_1.talkMaxDuration)

			if var_112_30 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_38 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_30) / var_112_38

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_30 + var_112_38 and arg_109_1.time_ < var_112_30 + var_112_38 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play938081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 938081027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play938081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[1297].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(938081027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 40
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play938081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 938081028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play938081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10144"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_8 = 0
			local var_120_9 = 0.2

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_10 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_10

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

				local var_120_11 = arg_117_1:GetWordFromCfg(938081028)
				local var_120_12 = arg_117_1:FormatText(var_120_11.content)

				arg_117_1.text_.text = var_120_12

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 8
				local var_120_14 = utf8.len(var_120_12)
				local var_120_15 = var_120_13 <= 0 and var_120_9 or var_120_9 * (var_120_14 / var_120_13)

				if var_120_15 > 0 and var_120_9 < var_120_15 then
					arg_117_1.talkMaxDuration = var_120_15

					if var_120_15 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_15 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_12
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play938081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 938081029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play938081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10144"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10144 == nil then
				arg_121_1.var_.actorSpriteComps10144 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10144 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10144 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10144 = nil
			end

			local var_124_8 = arg_121_1.actors_["10144"].transform
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.var_.moveOldPos10144 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10144", 2)

				local var_124_10 = var_124_8.childCount

				for iter_124_4 = 0, var_124_10 - 1 do
					local var_124_11 = var_124_8:GetChild(iter_124_4)

					if var_124_11.name == "split_12" or not string.find(var_124_11.name, "split") then
						var_124_11.gameObject:SetActive(true)
					else
						var_124_11.gameObject:SetActive(false)
					end
				end
			end

			local var_124_12 = 0.001

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_12 then
				local var_124_13 = (arg_121_1.time_ - var_124_9) / var_124_12
				local var_124_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10144, var_124_14, var_124_13)
			end

			if arg_121_1.time_ >= var_124_9 + var_124_12 and arg_121_1.time_ < var_124_9 + var_124_12 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_124_15 = 0
			local var_124_16 = 0.875

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[1297].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(938081029)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 35
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_23 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_23 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_23

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_23 and arg_121_1.time_ < var_124_15 + var_124_23 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play938081030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 938081030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play938081031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["106603"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps106603 == nil then
				arg_125_1.var_.actorSpriteComps106603 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps106603 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 1, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps106603 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps106603 = nil
			end

			local var_128_8 = arg_125_1.actors_["10144"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10144 == nil then
				arg_125_1.var_.actorSpriteComps10144 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps10144 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 0.5, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10144 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10144 = nil
			end

			local var_128_16 = arg_125_1.actors_["106603"].transform
			local var_128_17 = 0

			if var_128_17 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.var_.moveOldPos106603 = var_128_16.localPosition
				var_128_16.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("106603", 4)

				local var_128_18 = var_128_16.childCount

				for iter_128_8 = 0, var_128_18 - 1 do
					local var_128_19 = var_128_16:GetChild(iter_128_8)

					if var_128_19.name == "split_12" or not string.find(var_128_19.name, "split") then
						var_128_19.gameObject:SetActive(true)
					else
						var_128_19.gameObject:SetActive(false)
					end
				end
			end

			local var_128_20 = 0.001

			if var_128_17 <= arg_125_1.time_ and arg_125_1.time_ < var_128_17 + var_128_20 then
				local var_128_21 = (arg_125_1.time_ - var_128_17) / var_128_20
				local var_128_22 = Vector3.New(453.9, -399.1, -303.3)

				var_128_16.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos106603, var_128_22, var_128_21)
			end

			if arg_125_1.time_ >= var_128_17 + var_128_20 and arg_125_1.time_ < var_128_17 + var_128_20 + arg_128_0 then
				var_128_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_128_23 = arg_125_1.actors_["128404"].transform
			local var_128_24 = 0

			if var_128_24 < arg_125_1.time_ and arg_125_1.time_ <= var_128_24 + arg_128_0 then
				arg_125_1.var_.moveOldPos128404 = var_128_23.localPosition
				var_128_23.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("128404", 7)

				local var_128_25 = var_128_23.childCount

				for iter_128_9 = 0, var_128_25 - 1 do
					local var_128_26 = var_128_23:GetChild(iter_128_9)

					if var_128_26.name == "split_10" or not string.find(var_128_26.name, "split") then
						var_128_26.gameObject:SetActive(true)
					else
						var_128_26.gameObject:SetActive(false)
					end
				end
			end

			local var_128_27 = 0.001

			if var_128_24 <= arg_125_1.time_ and arg_125_1.time_ < var_128_24 + var_128_27 then
				local var_128_28 = (arg_125_1.time_ - var_128_24) / var_128_27
				local var_128_29 = Vector3.New(0, -2000, 0)

				var_128_23.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos128404, var_128_29, var_128_28)
			end

			if arg_125_1.time_ >= var_128_24 + var_128_27 and arg_125_1.time_ < var_128_24 + var_128_27 + arg_128_0 then
				var_128_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_30 = 0
			local var_128_31 = 0.4

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_32 = arg_125_1:FormatText(StoryNameCfg[32].name)

				arg_125_1.leftNameTxt_.text = var_128_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_33 = arg_125_1:GetWordFromCfg(938081030)
				local var_128_34 = arg_125_1:FormatText(var_128_33.content)

				arg_125_1.text_.text = var_128_34

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_35 = 16
				local var_128_36 = utf8.len(var_128_34)
				local var_128_37 = var_128_35 <= 0 and var_128_31 or var_128_31 * (var_128_36 / var_128_35)

				if var_128_37 > 0 and var_128_31 < var_128_37 then
					arg_125_1.talkMaxDuration = var_128_37

					if var_128_37 + var_128_30 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_37 + var_128_30
					end
				end

				arg_125_1.text_.text = var_128_34
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_38 = math.max(var_128_31, arg_125_1.talkMaxDuration)

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_38 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_30) / var_128_38

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_30 + var_128_38 and arg_125_1.time_ < var_128_30 + var_128_38 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play938081031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 938081031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play938081032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10144"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_8 = arg_129_1.actors_["106603"]
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps106603 == nil then
				arg_129_1.var_.actorSpriteComps106603 = var_132_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_10 = 0.2

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_10 and not isNil(var_132_8) then
				local var_132_11 = (arg_129_1.time_ - var_132_9) / var_132_10

				if arg_129_1.var_.actorSpriteComps106603 then
					for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_132_5 then
							if arg_129_1.isInRecall_ then
								local var_132_12 = Mathf.Lerp(iter_132_5.color.r, arg_129_1.hightColor2.r, var_132_11)
								local var_132_13 = Mathf.Lerp(iter_132_5.color.g, arg_129_1.hightColor2.g, var_132_11)
								local var_132_14 = Mathf.Lerp(iter_132_5.color.b, arg_129_1.hightColor2.b, var_132_11)

								iter_132_5.color = Color.New(var_132_12, var_132_13, var_132_14)
							else
								local var_132_15 = Mathf.Lerp(iter_132_5.color.r, 0.5, var_132_11)

								iter_132_5.color = Color.New(var_132_15, var_132_15, var_132_15)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_9 + var_132_10 and arg_129_1.time_ < var_132_9 + var_132_10 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps106603 then
				for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_132_7 then
						if arg_129_1.isInRecall_ then
							iter_132_7.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps106603 = nil
			end

			local var_132_16 = arg_129_1.actors_["10144"].transform
			local var_132_17 = 0

			if var_132_17 < arg_129_1.time_ and arg_129_1.time_ <= var_132_17 + arg_132_0 then
				arg_129_1.var_.moveOldPos10144 = var_132_16.localPosition
				var_132_16.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10144", 2)

				local var_132_18 = var_132_16.childCount

				for iter_132_8 = 0, var_132_18 - 1 do
					local var_132_19 = var_132_16:GetChild(iter_132_8)

					if var_132_19.name == "split_11" or not string.find(var_132_19.name, "split") then
						var_132_19.gameObject:SetActive(true)
					else
						var_132_19.gameObject:SetActive(false)
					end
				end
			end

			local var_132_20 = 0.001

			if var_132_17 <= arg_129_1.time_ and arg_129_1.time_ < var_132_17 + var_132_20 then
				local var_132_21 = (arg_129_1.time_ - var_132_17) / var_132_20
				local var_132_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_132_16.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10144, var_132_22, var_132_21)
			end

			if arg_129_1.time_ >= var_132_17 + var_132_20 and arg_129_1.time_ < var_132_17 + var_132_20 + arg_132_0 then
				var_132_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_132_23 = 0
			local var_132_24 = 1.175

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_25 = arg_129_1:FormatText(StoryNameCfg[1297].name)

				arg_129_1.leftNameTxt_.text = var_132_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_26 = arg_129_1:GetWordFromCfg(938081031)
				local var_132_27 = arg_129_1:FormatText(var_132_26.content)

				arg_129_1.text_.text = var_132_27

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_28 = 47
				local var_132_29 = utf8.len(var_132_27)
				local var_132_30 = var_132_28 <= 0 and var_132_24 or var_132_24 * (var_132_29 / var_132_28)

				if var_132_30 > 0 and var_132_24 < var_132_30 then
					arg_129_1.talkMaxDuration = var_132_30

					if var_132_30 + var_132_23 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_30 + var_132_23
					end
				end

				arg_129_1.text_.text = var_132_27
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_31 = math.max(var_132_24, arg_129_1.talkMaxDuration)

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_31 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_23) / var_132_31

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_23 + var_132_31 and arg_129_1.time_ < var_132_23 + var_132_31 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play938081032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 938081032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play938081033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.725

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[1297].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(938081032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 29
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play938081033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 938081033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play938081034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10144"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 0.5, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.775

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_10

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

				local var_140_11 = arg_137_1:GetWordFromCfg(938081033)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 31
				local var_140_14 = utf8.len(var_140_12)
				local var_140_15 = var_140_13 <= 0 and var_140_9 or var_140_9 * (var_140_14 / var_140_13)

				if var_140_15 > 0 and var_140_9 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_12
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
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

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play938081034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 938081034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play938081035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10144"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 1, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_8 = arg_141_1.actors_["10144"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 2)

				local var_144_10 = var_144_8.childCount

				for iter_144_4 = 0, var_144_10 - 1 do
					local var_144_11 = var_144_8:GetChild(iter_144_4)

					if var_144_11.name == "split_12" then
						var_144_11:SetAsLastSibling()
						var_144_11.gameObject:SetActive(true)

						arg_141_1.var_.actorSpriteSplit10144 = var_144_11.gameObject:GetComponent(typeof(Image))

						arg_141_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_144_12 = 0.5

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_9) / var_144_12
				local var_144_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, var_144_14, var_144_13)

				if arg_141_1.var_.actorSpriteSplit10144 ~= nil then
					arg_141_1.var_.actorSpriteSplit10144:SetAlpha(var_144_13)
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_12 and arg_141_1.time_ < var_144_9 + var_144_12 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_141_1.var_.actorSpriteSplit10144 ~= nil then
					arg_141_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_144_15 = 0
			local var_144_16 = 0.875

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[1297].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(938081034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 35
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_23 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_23 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_23

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_23 and arg_141_1.time_ < var_144_15 + var_144_23 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play938081035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 938081035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play938081036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = "104902"

			if arg_145_1.actors_[var_148_0] == nil then
				local var_148_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_148_1) then
					local var_148_2 = Object.Instantiate(var_148_1, arg_145_1.canvasGo_.transform)

					var_148_2.transform:SetSiblingIndex(1)

					var_148_2.name = var_148_0
					var_148_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_145_1.actors_[var_148_0] = var_148_2

					local var_148_3 = var_148_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_145_1.isInRecall_ then
						for iter_148_0, iter_148_1 in ipairs(var_148_3) do
							iter_148_1.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_148_4 = arg_145_1.actors_["104902"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.actorSpriteComps104902 == nil then
				arg_145_1.var_.actorSpriteComps104902 = var_148_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.2

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.actorSpriteComps104902 then
					for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_148_3 then
							if arg_145_1.isInRecall_ then
								local var_148_8 = Mathf.Lerp(iter_148_3.color.r, arg_145_1.hightColor1.r, var_148_7)
								local var_148_9 = Mathf.Lerp(iter_148_3.color.g, arg_145_1.hightColor1.g, var_148_7)
								local var_148_10 = Mathf.Lerp(iter_148_3.color.b, arg_145_1.hightColor1.b, var_148_7)

								iter_148_3.color = Color.New(var_148_8, var_148_9, var_148_10)
							else
								local var_148_11 = Mathf.Lerp(iter_148_3.color.r, 1, var_148_7)

								iter_148_3.color = Color.New(var_148_11, var_148_11, var_148_11)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.actorSpriteComps104902 then
				for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_148_5 then
						if arg_145_1.isInRecall_ then
							iter_148_5.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps104902 = nil
			end

			local var_148_12 = arg_145_1.actors_["10144"]
			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 and not isNil(var_148_12) and arg_145_1.var_.actorSpriteComps10144 == nil then
				arg_145_1.var_.actorSpriteComps10144 = var_148_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_14 = 0.2

			if var_148_13 <= arg_145_1.time_ and arg_145_1.time_ < var_148_13 + var_148_14 and not isNil(var_148_12) then
				local var_148_15 = (arg_145_1.time_ - var_148_13) / var_148_14

				if arg_145_1.var_.actorSpriteComps10144 then
					for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_148_7 then
							if arg_145_1.isInRecall_ then
								local var_148_16 = Mathf.Lerp(iter_148_7.color.r, arg_145_1.hightColor2.r, var_148_15)
								local var_148_17 = Mathf.Lerp(iter_148_7.color.g, arg_145_1.hightColor2.g, var_148_15)
								local var_148_18 = Mathf.Lerp(iter_148_7.color.b, arg_145_1.hightColor2.b, var_148_15)

								iter_148_7.color = Color.New(var_148_16, var_148_17, var_148_18)
							else
								local var_148_19 = Mathf.Lerp(iter_148_7.color.r, 0.5, var_148_15)

								iter_148_7.color = Color.New(var_148_19, var_148_19, var_148_19)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_13 + var_148_14 and arg_145_1.time_ < var_148_13 + var_148_14 + arg_148_0 and not isNil(var_148_12) and arg_145_1.var_.actorSpriteComps10144 then
				for iter_148_8, iter_148_9 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_148_9 then
						if arg_145_1.isInRecall_ then
							iter_148_9.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10144 = nil
			end

			local var_148_20 = arg_145_1.actors_["104902"].transform
			local var_148_21 = 0

			if var_148_21 < arg_145_1.time_ and arg_145_1.time_ <= var_148_21 + arg_148_0 then
				arg_145_1.var_.moveOldPos104902 = var_148_20.localPosition
				var_148_20.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("104902", 4)

				local var_148_22 = var_148_20.childCount

				for iter_148_10 = 0, var_148_22 - 1 do
					local var_148_23 = var_148_20:GetChild(iter_148_10)

					if var_148_23.name == "split_8" or not string.find(var_148_23.name, "split") then
						var_148_23.gameObject:SetActive(true)
					else
						var_148_23.gameObject:SetActive(false)
					end
				end
			end

			local var_148_24 = 0.001

			if var_148_21 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_24 then
				local var_148_25 = (arg_145_1.time_ - var_148_21) / var_148_24
				local var_148_26 = Vector3.New(390, -335, -360)

				var_148_20.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos104902, var_148_26, var_148_25)
			end

			if arg_145_1.time_ >= var_148_21 + var_148_24 and arg_145_1.time_ < var_148_21 + var_148_24 + arg_148_0 then
				var_148_20.localPosition = Vector3.New(390, -335, -360)
			end

			local var_148_27 = arg_145_1.actors_["106603"].transform
			local var_148_28 = 0

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1.var_.moveOldPos106603 = var_148_27.localPosition
				var_148_27.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("106603", 7)

				local var_148_29 = var_148_27.childCount

				for iter_148_11 = 0, var_148_29 - 1 do
					local var_148_30 = var_148_27:GetChild(iter_148_11)

					if var_148_30.name == "" or not string.find(var_148_30.name, "split") then
						var_148_30.gameObject:SetActive(true)
					else
						var_148_30.gameObject:SetActive(false)
					end
				end
			end

			local var_148_31 = 0.001

			if var_148_28 <= arg_145_1.time_ and arg_145_1.time_ < var_148_28 + var_148_31 then
				local var_148_32 = (arg_145_1.time_ - var_148_28) / var_148_31
				local var_148_33 = Vector3.New(0, -2000, 0)

				var_148_27.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos106603, var_148_33, var_148_32)
			end

			if arg_145_1.time_ >= var_148_28 + var_148_31 and arg_145_1.time_ < var_148_28 + var_148_31 + arg_148_0 then
				var_148_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_148_34 = 0
			local var_148_35 = 0.425

			if var_148_34 < arg_145_1.time_ and arg_145_1.time_ <= var_148_34 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_36 = arg_145_1:FormatText(StoryNameCfg[562].name)

				arg_145_1.leftNameTxt_.text = var_148_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_37 = arg_145_1:GetWordFromCfg(938081035)
				local var_148_38 = arg_145_1:FormatText(var_148_37.content)

				arg_145_1.text_.text = var_148_38

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_39 = 17
				local var_148_40 = utf8.len(var_148_38)
				local var_148_41 = var_148_39 <= 0 and var_148_35 or var_148_35 * (var_148_40 / var_148_39)

				if var_148_41 > 0 and var_148_35 < var_148_41 then
					arg_145_1.talkMaxDuration = var_148_41

					if var_148_41 + var_148_34 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_41 + var_148_34
					end
				end

				arg_145_1.text_.text = var_148_38
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_42 = math.max(var_148_35, arg_145_1.talkMaxDuration)

			if var_148_34 <= arg_145_1.time_ and arg_145_1.time_ < var_148_34 + var_148_42 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_34) / var_148_42

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_34 + var_148_42 and arg_145_1.time_ < var_148_34 + var_148_42 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
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
	Play938081036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 938081036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play938081037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10144"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 1, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_152_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_8 = arg_149_1.actors_["104902"]
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps104902 == nil then
				arg_149_1.var_.actorSpriteComps104902 = var_152_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_10 = 0.2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 and not isNil(var_152_8) then
				local var_152_11 = (arg_149_1.time_ - var_152_9) / var_152_10

				if arg_149_1.var_.actorSpriteComps104902 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								local var_152_12 = Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor2.r, var_152_11)
								local var_152_13 = Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor2.g, var_152_11)
								local var_152_14 = Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor2.b, var_152_11)

								iter_152_5.color = Color.New(var_152_12, var_152_13, var_152_14)
							else
								local var_152_15 = Mathf.Lerp(iter_152_5.color.r, 0.5, var_152_11)

								iter_152_5.color = Color.New(var_152_15, var_152_15, var_152_15)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.actorSpriteComps104902 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_152_7 then
						if arg_149_1.isInRecall_ then
							iter_152_7.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps104902 = nil
			end

			local var_152_16 = arg_149_1.actors_["10144"].transform
			local var_152_17 = 0

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.var_.moveOldPos10144 = var_152_16.localPosition
				var_152_16.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10144", 2)

				local var_152_18 = var_152_16.childCount

				for iter_152_8 = 0, var_152_18 - 1 do
					local var_152_19 = var_152_16:GetChild(iter_152_8)

					if var_152_19.name == "split_11" then
						var_152_19:SetAsLastSibling()
						var_152_19.gameObject:SetActive(true)

						arg_149_1.var_.actorSpriteSplit10144 = var_152_19.gameObject:GetComponent(typeof(Image))

						arg_149_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_152_20 = 0.5

			if var_152_17 <= arg_149_1.time_ and arg_149_1.time_ < var_152_17 + var_152_20 then
				local var_152_21 = (arg_149_1.time_ - var_152_17) / var_152_20
				local var_152_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_152_16.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10144, var_152_22, var_152_21)

				if arg_149_1.var_.actorSpriteSplit10144 ~= nil then
					arg_149_1.var_.actorSpriteSplit10144:SetAlpha(var_152_21)
				end
			end

			if arg_149_1.time_ >= var_152_17 + var_152_20 and arg_149_1.time_ < var_152_17 + var_152_20 + arg_152_0 then
				var_152_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_149_1.var_.actorSpriteSplit10144 ~= nil then
					arg_149_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_152_23 = 0
			local var_152_24 = 0.475

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_25 = arg_149_1:FormatText(StoryNameCfg[1297].name)

				arg_149_1.leftNameTxt_.text = var_152_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_26 = arg_149_1:GetWordFromCfg(938081036)
				local var_152_27 = arg_149_1:FormatText(var_152_26.content)

				arg_149_1.text_.text = var_152_27

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_28 = 19
				local var_152_29 = utf8.len(var_152_27)
				local var_152_30 = var_152_28 <= 0 and var_152_24 or var_152_24 * (var_152_29 / var_152_28)

				if var_152_30 > 0 and var_152_24 < var_152_30 then
					arg_149_1.talkMaxDuration = var_152_30

					if var_152_30 + var_152_23 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_30 + var_152_23
					end
				end

				arg_149_1.text_.text = var_152_27
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_31 = math.max(var_152_24, arg_149_1.talkMaxDuration)

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_31 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_23) / var_152_31

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_23 + var_152_31 and arg_149_1.time_ < var_152_23 + var_152_31 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play938081037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 938081037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play938081038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.075

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1297].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(938081037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 43
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play938081038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 938081038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play938081039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10144"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 0.5, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_8 = arg_157_1.actors_["10144"].transform
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.var_.moveOldPos10144 = var_160_8.localPosition
				var_160_8.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10144", 7)

				local var_160_10 = var_160_8.childCount

				for iter_160_4 = 0, var_160_10 - 1 do
					local var_160_11 = var_160_8:GetChild(iter_160_4)

					if var_160_11.name == "" or not string.find(var_160_11.name, "split") then
						var_160_11.gameObject:SetActive(true)
					else
						var_160_11.gameObject:SetActive(false)
					end
				end
			end

			local var_160_12 = 0.001

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_12 then
				local var_160_13 = (arg_157_1.time_ - var_160_9) / var_160_12
				local var_160_14 = Vector3.New(0, -2000, 0)

				var_160_8.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10144, var_160_14, var_160_13)
			end

			if arg_157_1.time_ >= var_160_9 + var_160_12 and arg_157_1.time_ < var_160_9 + var_160_12 + arg_160_0 then
				var_160_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_15 = arg_157_1.actors_["104902"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos104902 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("104902", 7)

				local var_160_17 = var_160_15.childCount

				for iter_160_5 = 0, var_160_17 - 1 do
					local var_160_18 = var_160_15:GetChild(iter_160_5)

					if var_160_18.name == "" or not string.find(var_160_18.name, "split") then
						var_160_18.gameObject:SetActive(true)
					else
						var_160_18.gameObject:SetActive(false)
					end
				end
			end

			local var_160_19 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_19 then
				local var_160_20 = (arg_157_1.time_ - var_160_16) / var_160_19
				local var_160_21 = Vector3.New(0, -2000, -360)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos104902, var_160_21, var_160_20)
			end

			if arg_157_1.time_ >= var_160_16 + var_160_19 and arg_157_1.time_ < var_160_16 + var_160_19 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_160_22 = 0
			local var_160_23 = 0.85

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(938081038)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 34
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_23 or var_160_23 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_23 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_22
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_29 = math.max(var_160_23, arg_157_1.talkMaxDuration)

			if var_160_22 <= arg_157_1.time_ and arg_157_1.time_ < var_160_22 + var_160_29 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_22) / var_160_29

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_22 + var_160_29 and arg_157_1.time_ < var_160_22 + var_160_29 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play938081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 938081039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play938081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.475

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

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

				local var_164_3 = arg_161_1:GetWordFromCfg(938081039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 19
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play938081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 938081040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play938081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10144"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_8 = arg_165_1.actors_["10144"].transform
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_8.localPosition
				var_168_8.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 2)

				local var_168_10 = var_168_8.childCount

				for iter_168_4 = 0, var_168_10 - 1 do
					local var_168_11 = var_168_8:GetChild(iter_168_4)

					if var_168_11.name == "split_14" or not string.find(var_168_11.name, "split") then
						var_168_11.gameObject:SetActive(true)
					else
						var_168_11.gameObject:SetActive(false)
					end
				end
			end

			local var_168_12 = 0.001

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_9) / var_168_12
				local var_168_14 = Vector3.New(-507.9, -381.1, -285.9)

				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, var_168_14, var_168_13)
			end

			if arg_165_1.time_ >= var_168_9 + var_168_12 and arg_165_1.time_ < var_168_9 + var_168_12 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_168_15 = 0
			local var_168_16 = 0.275

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[1297].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(938081040)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 11
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
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
				actorName = "10144",
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
	Play938081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 938081041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play938081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["128404"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps128404 == nil then
				arg_169_1.var_.actorSpriteComps128404 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps128404 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor1.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor1.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor1.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 1, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps128404 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_172_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps128404 = nil
			end

			local var_172_8 = arg_169_1.actors_["10144"]
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10144 == nil then
				arg_169_1.var_.actorSpriteComps10144 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_10 = 0.2

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 and not isNil(var_172_8) then
				local var_172_11 = (arg_169_1.time_ - var_172_9) / var_172_10

				if arg_169_1.var_.actorSpriteComps10144 then
					for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_172_5 then
							if arg_169_1.isInRecall_ then
								local var_172_12 = Mathf.Lerp(iter_172_5.color.r, arg_169_1.hightColor2.r, var_172_11)
								local var_172_13 = Mathf.Lerp(iter_172_5.color.g, arg_169_1.hightColor2.g, var_172_11)
								local var_172_14 = Mathf.Lerp(iter_172_5.color.b, arg_169_1.hightColor2.b, var_172_11)

								iter_172_5.color = Color.New(var_172_12, var_172_13, var_172_14)
							else
								local var_172_15 = Mathf.Lerp(iter_172_5.color.r, 0.5, var_172_11)

								iter_172_5.color = Color.New(var_172_15, var_172_15, var_172_15)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10144 then
				for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_172_7 then
						if arg_169_1.isInRecall_ then
							iter_172_7.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10144 = nil
			end

			local var_172_16 = arg_169_1.actors_["128404"].transform
			local var_172_17 = 0

			if var_172_17 < arg_169_1.time_ and arg_169_1.time_ <= var_172_17 + arg_172_0 then
				arg_169_1.var_.moveOldPos128404 = var_172_16.localPosition
				var_172_16.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("128404", 4)

				local var_172_18 = var_172_16.childCount

				for iter_172_8 = 0, var_172_18 - 1 do
					local var_172_19 = var_172_16:GetChild(iter_172_8)

					if var_172_19.name == "split_10" or not string.find(var_172_19.name, "split") then
						var_172_19.gameObject:SetActive(true)
					else
						var_172_19.gameObject:SetActive(false)
					end
				end
			end

			local var_172_20 = 0.001

			if var_172_17 <= arg_169_1.time_ and arg_169_1.time_ < var_172_17 + var_172_20 then
				local var_172_21 = (arg_169_1.time_ - var_172_17) / var_172_20
				local var_172_22 = Vector3.New(390.2, -356, -362.3)

				var_172_16.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos128404, var_172_22, var_172_21)
			end

			if arg_169_1.time_ >= var_172_17 + var_172_20 and arg_169_1.time_ < var_172_17 + var_172_20 + arg_172_0 then
				var_172_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_172_23 = 0
			local var_172_24 = 0.125

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_25 = arg_169_1:FormatText(StoryNameCfg[6].name)

				arg_169_1.leftNameTxt_.text = var_172_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(938081041)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 5
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_31 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_23) / var_172_31

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_23 + var_172_31 and arg_169_1.time_ < var_172_23 + var_172_31 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play938081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 938081042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play938081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10144"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10144 == nil then
				arg_173_1.var_.actorSpriteComps10144 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps10144 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps10144 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10144 = nil
			end

			local var_176_8 = arg_173_1.actors_["128404"]
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps128404 == nil then
				arg_173_1.var_.actorSpriteComps128404 = var_176_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_10 = 0.2

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_10 and not isNil(var_176_8) then
				local var_176_11 = (arg_173_1.time_ - var_176_9) / var_176_10

				if arg_173_1.var_.actorSpriteComps128404 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								local var_176_12 = Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, var_176_11)
								local var_176_13 = Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, var_176_11)
								local var_176_14 = Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, var_176_11)

								iter_176_5.color = Color.New(var_176_12, var_176_13, var_176_14)
							else
								local var_176_15 = Mathf.Lerp(iter_176_5.color.r, 0.5, var_176_11)

								iter_176_5.color = Color.New(var_176_15, var_176_15, var_176_15)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_9 + var_176_10 and arg_173_1.time_ < var_176_9 + var_176_10 + arg_176_0 and not isNil(var_176_8) and arg_173_1.var_.actorSpriteComps128404 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_176_7 then
						if arg_173_1.isInRecall_ then
							iter_176_7.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps128404 = nil
			end

			local var_176_16 = arg_173_1.actors_["10144"].transform
			local var_176_17 = 0

			if var_176_17 < arg_173_1.time_ and arg_173_1.time_ <= var_176_17 + arg_176_0 then
				arg_173_1.var_.moveOldPos10144 = var_176_16.localPosition
				var_176_16.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10144", 2)

				local var_176_18 = var_176_16.childCount

				for iter_176_8 = 0, var_176_18 - 1 do
					local var_176_19 = var_176_16:GetChild(iter_176_8)

					if var_176_19.name == "split_11" then
						var_176_19:SetAsLastSibling()
						var_176_19.gameObject:SetActive(true)

						arg_173_1.var_.actorSpriteSplit10144 = var_176_19.gameObject:GetComponent(typeof(Image))

						arg_173_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_176_20 = 0.5

			if var_176_17 <= arg_173_1.time_ and arg_173_1.time_ < var_176_17 + var_176_20 then
				local var_176_21 = (arg_173_1.time_ - var_176_17) / var_176_20
				local var_176_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_176_16.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10144, var_176_22, var_176_21)

				if arg_173_1.var_.actorSpriteSplit10144 ~= nil then
					arg_173_1.var_.actorSpriteSplit10144:SetAlpha(var_176_21)
				end
			end

			if arg_173_1.time_ >= var_176_17 + var_176_20 and arg_173_1.time_ < var_176_17 + var_176_20 + arg_176_0 then
				var_176_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_173_1.var_.actorSpriteSplit10144 ~= nil then
					arg_173_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_176_23 = 0
			local var_176_24 = 0.45

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_25 = arg_173_1:FormatText(StoryNameCfg[1297].name)

				arg_173_1.leftNameTxt_.text = var_176_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(938081042)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_28 = 18
				local var_176_29 = utf8.len(var_176_27)
				local var_176_30 = var_176_28 <= 0 and var_176_24 or var_176_24 * (var_176_29 / var_176_28)

				if var_176_30 > 0 and var_176_24 < var_176_30 then
					arg_173_1.talkMaxDuration = var_176_30

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_31 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_31 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_23) / var_176_31

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_23 + var_176_31 and arg_173_1.time_ < var_176_23 + var_176_31 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play938081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 938081043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play938081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["106603"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps106603 == nil then
				arg_177_1.var_.actorSpriteComps106603 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps106603 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps106603 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps106603 = nil
			end

			local var_180_8 = arg_177_1.actors_["10144"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_16 = arg_177_1.actors_["106603"].transform
			local var_180_17 = 0

			if var_180_17 < arg_177_1.time_ and arg_177_1.time_ <= var_180_17 + arg_180_0 then
				arg_177_1.var_.moveOldPos106603 = var_180_16.localPosition
				var_180_16.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("106603", 4)

				local var_180_18 = var_180_16.childCount

				for iter_180_8 = 0, var_180_18 - 1 do
					local var_180_19 = var_180_16:GetChild(iter_180_8)

					if var_180_19.name == "split_12" or not string.find(var_180_19.name, "split") then
						var_180_19.gameObject:SetActive(true)
					else
						var_180_19.gameObject:SetActive(false)
					end
				end
			end

			local var_180_20 = 0.001

			if var_180_17 <= arg_177_1.time_ and arg_177_1.time_ < var_180_17 + var_180_20 then
				local var_180_21 = (arg_177_1.time_ - var_180_17) / var_180_20
				local var_180_22 = Vector3.New(453.9, -399.1, -303.3)

				var_180_16.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos106603, var_180_22, var_180_21)
			end

			if arg_177_1.time_ >= var_180_17 + var_180_20 and arg_177_1.time_ < var_180_17 + var_180_20 + arg_180_0 then
				var_180_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_180_23 = arg_177_1.actors_["128404"].transform
			local var_180_24 = 0

			if var_180_24 < arg_177_1.time_ and arg_177_1.time_ <= var_180_24 + arg_180_0 then
				arg_177_1.var_.moveOldPos128404 = var_180_23.localPosition
				var_180_23.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("128404", 7)

				local var_180_25 = var_180_23.childCount

				for iter_180_9 = 0, var_180_25 - 1 do
					local var_180_26 = var_180_23:GetChild(iter_180_9)

					if var_180_26.name == "" or not string.find(var_180_26.name, "split") then
						var_180_26.gameObject:SetActive(true)
					else
						var_180_26.gameObject:SetActive(false)
					end
				end
			end

			local var_180_27 = 0.001

			if var_180_24 <= arg_177_1.time_ and arg_177_1.time_ < var_180_24 + var_180_27 then
				local var_180_28 = (arg_177_1.time_ - var_180_24) / var_180_27
				local var_180_29 = Vector3.New(0, -2000, 0)

				var_180_23.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos128404, var_180_29, var_180_28)
			end

			if arg_177_1.time_ >= var_180_24 + var_180_27 and arg_177_1.time_ < var_180_24 + var_180_27 + arg_180_0 then
				var_180_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_180_30 = 0
			local var_180_31 = 0.6

			if var_180_30 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_32 = arg_177_1:FormatText(StoryNameCfg[32].name)

				arg_177_1.leftNameTxt_.text = var_180_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_33 = arg_177_1:GetWordFromCfg(938081043)
				local var_180_34 = arg_177_1:FormatText(var_180_33.content)

				arg_177_1.text_.text = var_180_34

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_35 = 24
				local var_180_36 = utf8.len(var_180_34)
				local var_180_37 = var_180_35 <= 0 and var_180_31 or var_180_31 * (var_180_36 / var_180_35)

				if var_180_37 > 0 and var_180_31 < var_180_37 then
					arg_177_1.talkMaxDuration = var_180_37

					if var_180_37 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_37 + var_180_30
					end
				end

				arg_177_1.text_.text = var_180_34
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_38 = math.max(var_180_31, arg_177_1.talkMaxDuration)

			if var_180_30 <= arg_177_1.time_ and arg_177_1.time_ < var_180_30 + var_180_38 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_30) / var_180_38

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_30 + var_180_38 and arg_177_1.time_ < var_180_30 + var_180_38 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play938081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 938081044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play938081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10144"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10144 == nil then
				arg_181_1.var_.actorSpriteComps10144 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10144 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10144 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10144 = nil
			end

			local var_184_8 = arg_181_1.actors_["106603"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps106603 == nil then
				arg_181_1.var_.actorSpriteComps106603 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps106603 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps106603 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps106603 = nil
			end

			local var_184_16 = arg_181_1.actors_["10144"].transform
			local var_184_17 = 0

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				arg_181_1.var_.moveOldPos10144 = var_184_16.localPosition
				var_184_16.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10144", 2)

				local var_184_18 = var_184_16.childCount

				for iter_184_8 = 0, var_184_18 - 1 do
					local var_184_19 = var_184_16:GetChild(iter_184_8)

					if var_184_19.name == "split_11" or not string.find(var_184_19.name, "split") then
						var_184_19.gameObject:SetActive(true)
					else
						var_184_19.gameObject:SetActive(false)
					end
				end
			end

			local var_184_20 = 0.001

			if var_184_17 <= arg_181_1.time_ and arg_181_1.time_ < var_184_17 + var_184_20 then
				local var_184_21 = (arg_181_1.time_ - var_184_17) / var_184_20
				local var_184_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_184_16.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10144, var_184_22, var_184_21)
			end

			if arg_181_1.time_ >= var_184_17 + var_184_20 and arg_181_1.time_ < var_184_17 + var_184_20 + arg_184_0 then
				var_184_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_184_23 = 0
			local var_184_24 = 0.725

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[1297].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(938081044)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 29
				local var_184_29 = utf8.len(var_184_27)
				local var_184_30 = var_184_28 <= 0 and var_184_24 or var_184_24 * (var_184_29 / var_184_28)

				if var_184_30 > 0 and var_184_24 < var_184_30 then
					arg_181_1.talkMaxDuration = var_184_30

					if var_184_30 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_30 + var_184_23
					end
				end

				arg_181_1.text_.text = var_184_27
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = math.max(var_184_24, arg_181_1.talkMaxDuration)

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_31 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_23) / var_184_31

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_23 + var_184_31 and arg_181_1.time_ < var_184_23 + var_184_31 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play938081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 938081045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play938081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10144"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10144 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10144", 2)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "split_12" then
						var_188_3:SetAsLastSibling()
						var_188_3.gameObject:SetActive(true)

						arg_185_1.var_.actorSpriteSplit10144 = var_188_3.gameObject:GetComponent(typeof(Image))

						arg_185_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_188_4 = 0.5

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(-507.9, -381.1, -285.9)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10144, var_188_6, var_188_5)

				if arg_185_1.var_.actorSpriteSplit10144 ~= nil then
					arg_185_1.var_.actorSpriteSplit10144:SetAlpha(var_188_5)
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-507.9, -381.1, -285.9)

				if arg_185_1.var_.actorSpriteSplit10144 ~= nil then
					arg_185_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_188_7 = 0
			local var_188_8 = 0.55

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_9 = arg_185_1:FormatText(StoryNameCfg[1297].name)

				arg_185_1.leftNameTxt_.text = var_188_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(938081045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_12 = 22
				local var_188_13 = utf8.len(var_188_11)
				local var_188_14 = var_188_12 <= 0 and var_188_8 or var_188_8 * (var_188_13 / var_188_12)

				if var_188_14 > 0 and var_188_8 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_7
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_15 = math.max(var_188_8, arg_185_1.talkMaxDuration)

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_15 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_7) / var_188_15

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_7 + var_188_15 and arg_185_1.time_ < var_188_7 + var_188_15 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play938081046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 938081046
		arg_189_1.duration_ = 6

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play938081047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10144"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10144 == nil then
				arg_189_1.var_.actorSpriteComps10144 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10144 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10144 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10144 = nil
			end

			local var_192_8 = arg_189_1.actors_["10144"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos10144 = var_192_8.localPosition
				var_192_8.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10144", 7)

				local var_192_10 = var_192_8.childCount

				for iter_192_4 = 0, var_192_10 - 1 do
					local var_192_11 = var_192_8:GetChild(iter_192_4)

					if var_192_11.name == "" or not string.find(var_192_11.name, "split") then
						var_192_11.gameObject:SetActive(true)
					else
						var_192_11.gameObject:SetActive(false)
					end
				end
			end

			local var_192_12 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_12 then
				local var_192_13 = (arg_189_1.time_ - var_192_9) / var_192_12
				local var_192_14 = Vector3.New(0, -2000, 0)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10144, var_192_14, var_192_13)
			end

			if arg_189_1.time_ >= var_192_9 + var_192_12 and arg_189_1.time_ < var_192_9 + var_192_12 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_15 = arg_189_1.actors_["106603"].transform
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.var_.moveOldPos106603 = var_192_15.localPosition
				var_192_15.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("106603", 7)

				local var_192_17 = var_192_15.childCount

				for iter_192_5 = 0, var_192_17 - 1 do
					local var_192_18 = var_192_15:GetChild(iter_192_5)

					if var_192_18.name == "" or not string.find(var_192_18.name, "split") then
						var_192_18.gameObject:SetActive(true)
					else
						var_192_18.gameObject:SetActive(false)
					end
				end
			end

			local var_192_19 = 0.001

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_19 then
				local var_192_20 = (arg_189_1.time_ - var_192_16) / var_192_19
				local var_192_21 = Vector3.New(0, -2000, 0)

				var_192_15.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos106603, var_192_21, var_192_20)
			end

			if arg_189_1.time_ >= var_192_16 + var_192_19 and arg_189_1.time_ < var_192_16 + var_192_19 + arg_192_0 then
				var_192_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_22 = manager.ui.mainCamera.transform
			local var_192_23 = 0

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				arg_189_1.var_.shakeOldPos = var_192_22.localPosition
			end

			local var_192_24 = 0.6

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_24 then
				local var_192_25 = (arg_189_1.time_ - var_192_23) / 0.066
				local var_192_26, var_192_27 = math.modf(var_192_25)

				var_192_22.localPosition = Vector3.New(var_192_27 * 0.13, var_192_27 * 0.13, var_192_27 * 0.13) + arg_189_1.var_.shakeOldPos
			end

			if arg_189_1.time_ >= var_192_23 + var_192_24 and arg_189_1.time_ < var_192_23 + var_192_24 + arg_192_0 then
				var_192_22.localPosition = arg_189_1.var_.shakeOldPos
			end

			local var_192_28 = manager.ui.mainCamera.transform
			local var_192_29 = 0

			if var_192_29 < arg_189_1.time_ and arg_189_1.time_ <= var_192_29 + arg_192_0 then
				local var_192_30 = arg_189_1.var_.effecttengkongerqi
				local var_192_31
				local var_192_32 = var_192_28

				if not var_192_30 then
					var_192_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_192_32)
					var_192_30.name = "tengkongerqi"
					arg_189_1.var_.effecttengkongerqi = var_192_30
				else
					var_192_30.transform:SetParent(var_192_32)
				end

				var_192_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_192_33 = 0

			if var_192_33 < arg_189_1.time_ and arg_189_1.time_ <= var_192_33 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_34 = 1.5

			if arg_189_1.time_ >= var_192_33 + var_192_34 and arg_189_1.time_ < var_192_33 + var_192_34 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_35 = 1
			local var_192_36 = 1.225

			if var_192_35 < arg_189_1.time_ and arg_189_1.time_ <= var_192_35 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_37 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_37:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_38 = arg_189_1:GetWordFromCfg(938081046)
				local var_192_39 = arg_189_1:FormatText(var_192_38.content)

				arg_189_1.text_.text = var_192_39

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_40 = 49
				local var_192_41 = utf8.len(var_192_39)
				local var_192_42 = var_192_40 <= 0 and var_192_36 or var_192_36 * (var_192_41 / var_192_40)

				if var_192_42 > 0 and var_192_36 < var_192_42 then
					arg_189_1.talkMaxDuration = var_192_42
					var_192_35 = var_192_35 + 0.3

					if var_192_42 + var_192_35 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_42 + var_192_35
					end
				end

				arg_189_1.text_.text = var_192_39
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_43 = var_192_35 + 0.3
			local var_192_44 = math.max(var_192_36, arg_189_1.talkMaxDuration)

			if var_192_43 <= arg_189_1.time_ and arg_189_1.time_ < var_192_43 + var_192_44 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_43) / var_192_44

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_43 + var_192_44 and arg_189_1.time_ < var_192_43 + var_192_44 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play938081047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 938081047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play938081048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.35

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_2

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

				local var_198_3 = arg_195_1:GetWordFromCfg(938081047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 14
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play938081048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 938081048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play938081049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["128404"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps128404 == nil then
				arg_199_1.var_.actorSpriteComps128404 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 0.2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps128404 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 1, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps128404 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps128404 = nil
			end

			local var_202_8 = arg_199_1.actors_["128404"].transform
			local var_202_9 = 0

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.var_.moveOldPos128404 = var_202_8.localPosition
				var_202_8.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("128404", 2)

				local var_202_10 = var_202_8.childCount

				for iter_202_4 = 0, var_202_10 - 1 do
					local var_202_11 = var_202_8:GetChild(iter_202_4)

					if var_202_11.name == "split_9" or not string.find(var_202_11.name, "split") then
						var_202_11.gameObject:SetActive(true)
					else
						var_202_11.gameObject:SetActive(false)
					end
				end
			end

			local var_202_12 = 0.001

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_12 then
				local var_202_13 = (arg_199_1.time_ - var_202_9) / var_202_12
				local var_202_14 = Vector3.New(-428.5, -356, -362.3)

				var_202_8.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos128404, var_202_14, var_202_13)
			end

			if arg_199_1.time_ >= var_202_9 + var_202_12 and arg_199_1.time_ < var_202_9 + var_202_12 + arg_202_0 then
				var_202_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_202_15 = 0
			local var_202_16 = 0.5

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[6].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(938081048)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 20
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_23 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_23 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_23

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_23 and arg_199_1.time_ < var_202_15 + var_202_23 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play938081049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 938081049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play938081050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["104902"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps104902 == nil then
				arg_203_1.var_.actorSpriteComps104902 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps104902 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor1.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor1.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor1.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 1, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps104902 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps104902 = nil
			end

			local var_206_8 = arg_203_1.actors_["128404"]
			local var_206_9 = 0

			if var_206_9 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps128404 == nil then
				arg_203_1.var_.actorSpriteComps128404 = var_206_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_10 = 0.2

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 and not isNil(var_206_8) then
				local var_206_11 = (arg_203_1.time_ - var_206_9) / var_206_10

				if arg_203_1.var_.actorSpriteComps128404 then
					for iter_206_4, iter_206_5 in pairs(arg_203_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_206_5 then
							if arg_203_1.isInRecall_ then
								local var_206_12 = Mathf.Lerp(iter_206_5.color.r, arg_203_1.hightColor2.r, var_206_11)
								local var_206_13 = Mathf.Lerp(iter_206_5.color.g, arg_203_1.hightColor2.g, var_206_11)
								local var_206_14 = Mathf.Lerp(iter_206_5.color.b, arg_203_1.hightColor2.b, var_206_11)

								iter_206_5.color = Color.New(var_206_12, var_206_13, var_206_14)
							else
								local var_206_15 = Mathf.Lerp(iter_206_5.color.r, 0.5, var_206_11)

								iter_206_5.color = Color.New(var_206_15, var_206_15, var_206_15)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.actorSpriteComps128404 then
				for iter_206_6, iter_206_7 in pairs(arg_203_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_206_7 then
						if arg_203_1.isInRecall_ then
							iter_206_7.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps128404 = nil
			end

			local var_206_16 = arg_203_1.actors_["104902"].transform
			local var_206_17 = 0

			if var_206_17 < arg_203_1.time_ and arg_203_1.time_ <= var_206_17 + arg_206_0 then
				arg_203_1.var_.moveOldPos104902 = var_206_16.localPosition
				var_206_16.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("104902", 4)

				local var_206_18 = var_206_16.childCount

				for iter_206_8 = 0, var_206_18 - 1 do
					local var_206_19 = var_206_16:GetChild(iter_206_8)

					if var_206_19.name == "split_8" or not string.find(var_206_19.name, "split") then
						var_206_19.gameObject:SetActive(true)
					else
						var_206_19.gameObject:SetActive(false)
					end
				end
			end

			local var_206_20 = 0.001

			if var_206_17 <= arg_203_1.time_ and arg_203_1.time_ < var_206_17 + var_206_20 then
				local var_206_21 = (arg_203_1.time_ - var_206_17) / var_206_20
				local var_206_22 = Vector3.New(390, -335, -360)

				var_206_16.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos104902, var_206_22, var_206_21)
			end

			if arg_203_1.time_ >= var_206_17 + var_206_20 and arg_203_1.time_ < var_206_17 + var_206_20 + arg_206_0 then
				var_206_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_206_23 = 0
			local var_206_24 = 0.35

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_25 = arg_203_1:FormatText(StoryNameCfg[562].name)

				arg_203_1.leftNameTxt_.text = var_206_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_26 = arg_203_1:GetWordFromCfg(938081049)
				local var_206_27 = arg_203_1:FormatText(var_206_26.content)

				arg_203_1.text_.text = var_206_27

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_28 = 14
				local var_206_29 = utf8.len(var_206_27)
				local var_206_30 = var_206_28 <= 0 and var_206_24 or var_206_24 * (var_206_29 / var_206_28)

				if var_206_30 > 0 and var_206_24 < var_206_30 then
					arg_203_1.talkMaxDuration = var_206_30

					if var_206_30 + var_206_23 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_30 + var_206_23
					end
				end

				arg_203_1.text_.text = var_206_27
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_31 = math.max(var_206_24, arg_203_1.talkMaxDuration)

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_31 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_23) / var_206_31

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_23 + var_206_31 and arg_203_1.time_ < var_206_23 + var_206_31 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play938081050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 938081050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play938081051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["106603"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps106603 == nil then
				arg_207_1.var_.actorSpriteComps106603 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps106603 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 1, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps106603 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps106603 = nil
			end

			local var_210_8 = arg_207_1.actors_["104902"]
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps104902 == nil then
				arg_207_1.var_.actorSpriteComps104902 = var_210_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_10 = 0.2

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_10 and not isNil(var_210_8) then
				local var_210_11 = (arg_207_1.time_ - var_210_9) / var_210_10

				if arg_207_1.var_.actorSpriteComps104902 then
					for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_210_5 then
							if arg_207_1.isInRecall_ then
								local var_210_12 = Mathf.Lerp(iter_210_5.color.r, arg_207_1.hightColor2.r, var_210_11)
								local var_210_13 = Mathf.Lerp(iter_210_5.color.g, arg_207_1.hightColor2.g, var_210_11)
								local var_210_14 = Mathf.Lerp(iter_210_5.color.b, arg_207_1.hightColor2.b, var_210_11)

								iter_210_5.color = Color.New(var_210_12, var_210_13, var_210_14)
							else
								local var_210_15 = Mathf.Lerp(iter_210_5.color.r, 0.5, var_210_11)

								iter_210_5.color = Color.New(var_210_15, var_210_15, var_210_15)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_9 + var_210_10 and arg_207_1.time_ < var_210_9 + var_210_10 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.actorSpriteComps104902 then
				for iter_210_6, iter_210_7 in pairs(arg_207_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_210_7 then
						if arg_207_1.isInRecall_ then
							iter_210_7.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps104902 = nil
			end

			local var_210_16 = arg_207_1.actors_["106603"].transform
			local var_210_17 = 0

			if var_210_17 < arg_207_1.time_ and arg_207_1.time_ <= var_210_17 + arg_210_0 then
				arg_207_1.var_.moveOldPos106603 = var_210_16.localPosition
				var_210_16.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("106603", 2)

				local var_210_18 = var_210_16.childCount

				for iter_210_8 = 0, var_210_18 - 1 do
					local var_210_19 = var_210_16:GetChild(iter_210_8)

					if var_210_19.name == "split_12" or not string.find(var_210_19.name, "split") then
						var_210_19.gameObject:SetActive(true)
					else
						var_210_19.gameObject:SetActive(false)
					end
				end
			end

			local var_210_20 = 0.001

			if var_210_17 <= arg_207_1.time_ and arg_207_1.time_ < var_210_17 + var_210_20 then
				local var_210_21 = (arg_207_1.time_ - var_210_17) / var_210_20
				local var_210_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_210_16.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos106603, var_210_22, var_210_21)
			end

			if arg_207_1.time_ >= var_210_17 + var_210_20 and arg_207_1.time_ < var_210_17 + var_210_20 + arg_210_0 then
				var_210_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_210_23 = arg_207_1.actors_["128404"].transform
			local var_210_24 = 0

			if var_210_24 < arg_207_1.time_ and arg_207_1.time_ <= var_210_24 + arg_210_0 then
				arg_207_1.var_.moveOldPos128404 = var_210_23.localPosition
				var_210_23.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("128404", 7)

				local var_210_25 = var_210_23.childCount

				for iter_210_9 = 0, var_210_25 - 1 do
					local var_210_26 = var_210_23:GetChild(iter_210_9)

					if var_210_26.name == "" or not string.find(var_210_26.name, "split") then
						var_210_26.gameObject:SetActive(true)
					else
						var_210_26.gameObject:SetActive(false)
					end
				end
			end

			local var_210_27 = 0.001

			if var_210_24 <= arg_207_1.time_ and arg_207_1.time_ < var_210_24 + var_210_27 then
				local var_210_28 = (arg_207_1.time_ - var_210_24) / var_210_27
				local var_210_29 = Vector3.New(0, -2000, 0)

				var_210_23.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos128404, var_210_29, var_210_28)
			end

			if arg_207_1.time_ >= var_210_24 + var_210_27 and arg_207_1.time_ < var_210_24 + var_210_27 + arg_210_0 then
				var_210_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_30 = 0
			local var_210_31 = 1.1

			if var_210_30 < arg_207_1.time_ and arg_207_1.time_ <= var_210_30 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_32 = arg_207_1:FormatText(StoryNameCfg[32].name)

				arg_207_1.leftNameTxt_.text = var_210_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_33 = arg_207_1:GetWordFromCfg(938081050)
				local var_210_34 = arg_207_1:FormatText(var_210_33.content)

				arg_207_1.text_.text = var_210_34

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_35 = 44
				local var_210_36 = utf8.len(var_210_34)
				local var_210_37 = var_210_35 <= 0 and var_210_31 or var_210_31 * (var_210_36 / var_210_35)

				if var_210_37 > 0 and var_210_31 < var_210_37 then
					arg_207_1.talkMaxDuration = var_210_37

					if var_210_37 + var_210_30 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_30
					end
				end

				arg_207_1.text_.text = var_210_34
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_38 = math.max(var_210_31, arg_207_1.talkMaxDuration)

			if var_210_30 <= arg_207_1.time_ and arg_207_1.time_ < var_210_30 + var_210_38 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_30) / var_210_38

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_30 + var_210_38 and arg_207_1.time_ < var_210_30 + var_210_38 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play938081051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 938081051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play938081052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["106603"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps106603 == nil then
				arg_211_1.var_.actorSpriteComps106603 = var_214_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.actorSpriteComps106603 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								local var_214_4 = Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, var_214_3)
								local var_214_5 = Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, var_214_3)
								local var_214_6 = Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, var_214_3)

								iter_214_1.color = Color.New(var_214_4, var_214_5, var_214_6)
							else
								local var_214_7 = Mathf.Lerp(iter_214_1.color.r, 0.5, var_214_3)

								iter_214_1.color = Color.New(var_214_7, var_214_7, var_214_7)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.actorSpriteComps106603 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_214_3 then
						if arg_211_1.isInRecall_ then
							iter_214_3.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps106603 = nil
			end

			local var_214_8 = arg_211_1.actors_["106603"].transform
			local var_214_9 = 0

			if var_214_9 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.var_.moveOldPos106603 = var_214_8.localPosition
				var_214_8.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("106603", 7)

				local var_214_10 = var_214_8.childCount

				for iter_214_4 = 0, var_214_10 - 1 do
					local var_214_11 = var_214_8:GetChild(iter_214_4)

					if var_214_11.name == "" or not string.find(var_214_11.name, "split") then
						var_214_11.gameObject:SetActive(true)
					else
						var_214_11.gameObject:SetActive(false)
					end
				end
			end

			local var_214_12 = 0.001

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_12 then
				local var_214_13 = (arg_211_1.time_ - var_214_9) / var_214_12
				local var_214_14 = Vector3.New(0, -2000, 0)

				var_214_8.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos106603, var_214_14, var_214_13)
			end

			if arg_211_1.time_ >= var_214_9 + var_214_12 and arg_211_1.time_ < var_214_9 + var_214_12 + arg_214_0 then
				var_214_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_15 = arg_211_1.actors_["104902"].transform
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.var_.moveOldPos104902 = var_214_15.localPosition
				var_214_15.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("104902", 7)

				local var_214_17 = var_214_15.childCount

				for iter_214_5 = 0, var_214_17 - 1 do
					local var_214_18 = var_214_15:GetChild(iter_214_5)

					if var_214_18.name == "" or not string.find(var_214_18.name, "split") then
						var_214_18.gameObject:SetActive(true)
					else
						var_214_18.gameObject:SetActive(false)
					end
				end
			end

			local var_214_19 = 0.001

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_19 then
				local var_214_20 = (arg_211_1.time_ - var_214_16) / var_214_19
				local var_214_21 = Vector3.New(0, -2000, -360)

				var_214_15.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos104902, var_214_21, var_214_20)
			end

			if arg_211_1.time_ >= var_214_16 + var_214_19 and arg_211_1.time_ < var_214_16 + var_214_19 + arg_214_0 then
				var_214_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_214_22 = 0
			local var_214_23 = 1.125

			if var_214_22 < arg_211_1.time_ and arg_211_1.time_ <= var_214_22 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_24 = arg_211_1:GetWordFromCfg(938081051)
				local var_214_25 = arg_211_1:FormatText(var_214_24.content)

				arg_211_1.text_.text = var_214_25

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_26 = 45
				local var_214_27 = utf8.len(var_214_25)
				local var_214_28 = var_214_26 <= 0 and var_214_23 or var_214_23 * (var_214_27 / var_214_26)

				if var_214_28 > 0 and var_214_23 < var_214_28 then
					arg_211_1.talkMaxDuration = var_214_28

					if var_214_28 + var_214_22 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_28 + var_214_22
					end
				end

				arg_211_1.text_.text = var_214_25
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_29 = math.max(var_214_23, arg_211_1.talkMaxDuration)

			if var_214_22 <= arg_211_1.time_ and arg_211_1.time_ < var_214_22 + var_214_29 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_22) / var_214_29

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_22 + var_214_29 and arg_211_1.time_ < var_214_22 + var_214_29 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play938081052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 938081052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play938081053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["128404"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps128404 == nil then
				arg_215_1.var_.actorSpriteComps128404 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps128404 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 1, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps128404 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps128404 = nil
			end

			local var_218_8 = arg_215_1.actors_["128404"].transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPos128404 = var_218_8.localPosition
				var_218_8.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("128404", 2)

				local var_218_10 = var_218_8.childCount

				for iter_218_4 = 0, var_218_10 - 1 do
					local var_218_11 = var_218_8:GetChild(iter_218_4)

					if var_218_11.name == "split_8" or not string.find(var_218_11.name, "split") then
						var_218_11.gameObject:SetActive(true)
					else
						var_218_11.gameObject:SetActive(false)
					end
				end
			end

			local var_218_12 = 0.001

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_9) / var_218_12
				local var_218_14 = Vector3.New(-428.5, -356, -362.3)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos128404, var_218_14, var_218_13)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_12 and arg_215_1.time_ < var_218_9 + var_218_12 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_218_15 = 0
			local var_218_16 = 0.425

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[6].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(938081052)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 17
				local var_218_21 = utf8.len(var_218_19)
				local var_218_22 = var_218_20 <= 0 and var_218_16 or var_218_16 * (var_218_21 / var_218_20)

				if var_218_22 > 0 and var_218_16 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22

					if var_218_22 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_23 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_23 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_23

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_23 and arg_215_1.time_ < var_218_15 + var_218_23 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play938081053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 938081053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play938081054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["104902"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps104902 == nil then
				arg_219_1.var_.actorSpriteComps104902 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps104902 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 1, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps104902 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps104902 = nil
			end

			local var_222_8 = arg_219_1.actors_["128404"]
			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps128404 == nil then
				arg_219_1.var_.actorSpriteComps128404 = var_222_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_10 = 0.2

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 and not isNil(var_222_8) then
				local var_222_11 = (arg_219_1.time_ - var_222_9) / var_222_10

				if arg_219_1.var_.actorSpriteComps128404 then
					for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_222_5 then
							if arg_219_1.isInRecall_ then
								local var_222_12 = Mathf.Lerp(iter_222_5.color.r, arg_219_1.hightColor2.r, var_222_11)
								local var_222_13 = Mathf.Lerp(iter_222_5.color.g, arg_219_1.hightColor2.g, var_222_11)
								local var_222_14 = Mathf.Lerp(iter_222_5.color.b, arg_219_1.hightColor2.b, var_222_11)

								iter_222_5.color = Color.New(var_222_12, var_222_13, var_222_14)
							else
								local var_222_15 = Mathf.Lerp(iter_222_5.color.r, 0.5, var_222_11)

								iter_222_5.color = Color.New(var_222_15, var_222_15, var_222_15)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps128404 then
				for iter_222_6, iter_222_7 in pairs(arg_219_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_222_7 then
						if arg_219_1.isInRecall_ then
							iter_222_7.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps128404 = nil
			end

			local var_222_16 = arg_219_1.actors_["104902"].transform
			local var_222_17 = 0

			if var_222_17 < arg_219_1.time_ and arg_219_1.time_ <= var_222_17 + arg_222_0 then
				arg_219_1.var_.moveOldPos104902 = var_222_16.localPosition
				var_222_16.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("104902", 4)

				local var_222_18 = var_222_16.childCount

				for iter_222_8 = 0, var_222_18 - 1 do
					local var_222_19 = var_222_16:GetChild(iter_222_8)

					if var_222_19.name == "split_6" or not string.find(var_222_19.name, "split") then
						var_222_19.gameObject:SetActive(true)
					else
						var_222_19.gameObject:SetActive(false)
					end
				end
			end

			local var_222_20 = 0.001

			if var_222_17 <= arg_219_1.time_ and arg_219_1.time_ < var_222_17 + var_222_20 then
				local var_222_21 = (arg_219_1.time_ - var_222_17) / var_222_20
				local var_222_22 = Vector3.New(390, -335, -360)

				var_222_16.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos104902, var_222_22, var_222_21)
			end

			if arg_219_1.time_ >= var_222_17 + var_222_20 and arg_219_1.time_ < var_222_17 + var_222_20 + arg_222_0 then
				var_222_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_222_23 = 0
			local var_222_24 = 0.675

			if var_222_23 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_25 = arg_219_1:FormatText(StoryNameCfg[562].name)

				arg_219_1.leftNameTxt_.text = var_222_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_26 = arg_219_1:GetWordFromCfg(938081053)
				local var_222_27 = arg_219_1:FormatText(var_222_26.content)

				arg_219_1.text_.text = var_222_27

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_28 = 27
				local var_222_29 = utf8.len(var_222_27)
				local var_222_30 = var_222_28 <= 0 and var_222_24 or var_222_24 * (var_222_29 / var_222_28)

				if var_222_30 > 0 and var_222_24 < var_222_30 then
					arg_219_1.talkMaxDuration = var_222_30

					if var_222_30 + var_222_23 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_30 + var_222_23
					end
				end

				arg_219_1.text_.text = var_222_27
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_31 = math.max(var_222_24, arg_219_1.talkMaxDuration)

			if var_222_23 <= arg_219_1.time_ and arg_219_1.time_ < var_222_23 + var_222_31 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_23) / var_222_31

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_23 + var_222_31 and arg_219_1.time_ < var_222_23 + var_222_31 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play938081054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 938081054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play938081055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["106603"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps106603 == nil then
				arg_223_1.var_.actorSpriteComps106603 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps106603 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 1, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps106603 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps106603 = nil
			end

			local var_226_8 = arg_223_1.actors_["104902"]
			local var_226_9 = 0

			if var_226_9 < arg_223_1.time_ and arg_223_1.time_ <= var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps104902 == nil then
				arg_223_1.var_.actorSpriteComps104902 = var_226_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_10 = 0.2

			if var_226_9 <= arg_223_1.time_ and arg_223_1.time_ < var_226_9 + var_226_10 and not isNil(var_226_8) then
				local var_226_11 = (arg_223_1.time_ - var_226_9) / var_226_10

				if arg_223_1.var_.actorSpriteComps104902 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								local var_226_12 = Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, var_226_11)
								local var_226_13 = Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, var_226_11)
								local var_226_14 = Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, var_226_11)

								iter_226_5.color = Color.New(var_226_12, var_226_13, var_226_14)
							else
								local var_226_15 = Mathf.Lerp(iter_226_5.color.r, 0.5, var_226_11)

								iter_226_5.color = Color.New(var_226_15, var_226_15, var_226_15)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_9 + var_226_10 and arg_223_1.time_ < var_226_9 + var_226_10 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.actorSpriteComps104902 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_226_7 then
						if arg_223_1.isInRecall_ then
							iter_226_7.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps104902 = nil
			end

			local var_226_16 = arg_223_1.actors_["106603"].transform
			local var_226_17 = 0

			if var_226_17 < arg_223_1.time_ and arg_223_1.time_ <= var_226_17 + arg_226_0 then
				arg_223_1.var_.moveOldPos106603 = var_226_16.localPosition
				var_226_16.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("106603", 2)

				local var_226_18 = var_226_16.childCount

				for iter_226_8 = 0, var_226_18 - 1 do
					local var_226_19 = var_226_16:GetChild(iter_226_8)

					if var_226_19.name == "split_7" or not string.find(var_226_19.name, "split") then
						var_226_19.gameObject:SetActive(true)
					else
						var_226_19.gameObject:SetActive(false)
					end
				end
			end

			local var_226_20 = 0.001

			if var_226_17 <= arg_223_1.time_ and arg_223_1.time_ < var_226_17 + var_226_20 then
				local var_226_21 = (arg_223_1.time_ - var_226_17) / var_226_20
				local var_226_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_226_16.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos106603, var_226_22, var_226_21)
			end

			if arg_223_1.time_ >= var_226_17 + var_226_20 and arg_223_1.time_ < var_226_17 + var_226_20 + arg_226_0 then
				var_226_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_226_23 = arg_223_1.actors_["128404"].transform
			local var_226_24 = 0

			if var_226_24 < arg_223_1.time_ and arg_223_1.time_ <= var_226_24 + arg_226_0 then
				arg_223_1.var_.moveOldPos128404 = var_226_23.localPosition
				var_226_23.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("128404", 7)

				local var_226_25 = var_226_23.childCount

				for iter_226_9 = 0, var_226_25 - 1 do
					local var_226_26 = var_226_23:GetChild(iter_226_9)

					if var_226_26.name == "" or not string.find(var_226_26.name, "split") then
						var_226_26.gameObject:SetActive(true)
					else
						var_226_26.gameObject:SetActive(false)
					end
				end
			end

			local var_226_27 = 0.001

			if var_226_24 <= arg_223_1.time_ and arg_223_1.time_ < var_226_24 + var_226_27 then
				local var_226_28 = (arg_223_1.time_ - var_226_24) / var_226_27
				local var_226_29 = Vector3.New(0, -2000, 0)

				var_226_23.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos128404, var_226_29, var_226_28)
			end

			if arg_223_1.time_ >= var_226_24 + var_226_27 and arg_223_1.time_ < var_226_24 + var_226_27 + arg_226_0 then
				var_226_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_226_30 = 0
			local var_226_31 = 0.4

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_32 = arg_223_1:FormatText(StoryNameCfg[32].name)

				arg_223_1.leftNameTxt_.text = var_226_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_33 = arg_223_1:GetWordFromCfg(938081054)
				local var_226_34 = arg_223_1:FormatText(var_226_33.content)

				arg_223_1.text_.text = var_226_34

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_35 = 16
				local var_226_36 = utf8.len(var_226_34)
				local var_226_37 = var_226_35 <= 0 and var_226_31 or var_226_31 * (var_226_36 / var_226_35)

				if var_226_37 > 0 and var_226_31 < var_226_37 then
					arg_223_1.talkMaxDuration = var_226_37

					if var_226_37 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_37 + var_226_30
					end
				end

				arg_223_1.text_.text = var_226_34
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_38 = math.max(var_226_31, arg_223_1.talkMaxDuration)

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_38 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_38

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_38 and arg_223_1.time_ < var_226_30 + var_226_38 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play938081055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 938081055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play938081056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["106603"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps106603 == nil then
				arg_227_1.var_.actorSpriteComps106603 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps106603 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor2.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor2.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor2.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 0.5, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps106603 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps106603 = nil
			end

			local var_230_8 = 0
			local var_230_9 = 0.3

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_10 = arg_227_1:FormatText(StoryNameCfg[7].name)

				arg_227_1.leftNameTxt_.text = var_230_10

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

				local var_230_11 = arg_227_1:GetWordFromCfg(938081055)
				local var_230_12 = arg_227_1:FormatText(var_230_11.content)

				arg_227_1.text_.text = var_230_12

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 12
				local var_230_14 = utf8.len(var_230_12)
				local var_230_15 = var_230_13 <= 0 and var_230_9 or var_230_9 * (var_230_14 / var_230_13)

				if var_230_15 > 0 and var_230_9 < var_230_15 then
					arg_227_1.talkMaxDuration = var_230_15

					if var_230_15 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_15 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_12
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play938081056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 938081056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play938081057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["104902"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps104902 == nil then
				arg_231_1.var_.actorSpriteComps104902 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps104902 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 1, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps104902 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps104902 = nil
			end

			local var_234_8 = arg_231_1.actors_["104902"].transform
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.var_.moveOldPos104902 = var_234_8.localPosition
				var_234_8.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104902", 4)

				local var_234_10 = var_234_8.childCount

				for iter_234_4 = 0, var_234_10 - 1 do
					local var_234_11 = var_234_8:GetChild(iter_234_4)

					if var_234_11.name == "split_8" or not string.find(var_234_11.name, "split") then
						var_234_11.gameObject:SetActive(true)
					else
						var_234_11.gameObject:SetActive(false)
					end
				end
			end

			local var_234_12 = 0.001

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_9) / var_234_12
				local var_234_14 = Vector3.New(390, -335, -360)

				var_234_8.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104902, var_234_14, var_234_13)
			end

			if arg_231_1.time_ >= var_234_9 + var_234_12 and arg_231_1.time_ < var_234_9 + var_234_12 + arg_234_0 then
				var_234_8.localPosition = Vector3.New(390, -335, -360)
			end

			local var_234_15 = 0
			local var_234_16 = 0.275

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_17 = arg_231_1:FormatText(StoryNameCfg[562].name)

				arg_231_1.leftNameTxt_.text = var_234_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_18 = arg_231_1:GetWordFromCfg(938081056)
				local var_234_19 = arg_231_1:FormatText(var_234_18.content)

				arg_231_1.text_.text = var_234_19

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_20 = 11
				local var_234_21 = utf8.len(var_234_19)
				local var_234_22 = var_234_20 <= 0 and var_234_16 or var_234_16 * (var_234_21 / var_234_20)

				if var_234_22 > 0 and var_234_16 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22

					if var_234_22 + var_234_15 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_15
					end
				end

				arg_231_1.text_.text = var_234_19
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_23 = math.max(var_234_16, arg_231_1.talkMaxDuration)

			if var_234_15 <= arg_231_1.time_ and arg_231_1.time_ < var_234_15 + var_234_23 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_15) / var_234_23

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_15 + var_234_23 and arg_231_1.time_ < var_234_15 + var_234_23 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play938081057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 938081057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play938081058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["128404"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps128404 == nil then
				arg_235_1.var_.actorSpriteComps128404 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps128404 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 1, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps128404 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps128404 = nil
			end

			local var_238_8 = arg_235_1.actors_["104902"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps104902 == nil then
				arg_235_1.var_.actorSpriteComps104902 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps104902 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								local var_238_12 = Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, var_238_11)
								local var_238_13 = Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, var_238_11)
								local var_238_14 = Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, var_238_11)

								iter_238_5.color = Color.New(var_238_12, var_238_13, var_238_14)
							else
								local var_238_15 = Mathf.Lerp(iter_238_5.color.r, 0.5, var_238_11)

								iter_238_5.color = Color.New(var_238_15, var_238_15, var_238_15)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps104902 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps104902 = nil
			end

			local var_238_16 = arg_235_1.actors_["128404"].transform
			local var_238_17 = 0

			if var_238_17 < arg_235_1.time_ and arg_235_1.time_ <= var_238_17 + arg_238_0 then
				arg_235_1.var_.moveOldPos128404 = var_238_16.localPosition
				var_238_16.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("128404", 2)

				local var_238_18 = var_238_16.childCount

				for iter_238_8 = 0, var_238_18 - 1 do
					local var_238_19 = var_238_16:GetChild(iter_238_8)

					if var_238_19.name == "split_9" or not string.find(var_238_19.name, "split") then
						var_238_19.gameObject:SetActive(true)
					else
						var_238_19.gameObject:SetActive(false)
					end
				end
			end

			local var_238_20 = 0.001

			if var_238_17 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_20 then
				local var_238_21 = (arg_235_1.time_ - var_238_17) / var_238_20
				local var_238_22 = Vector3.New(-428.5, -356, -362.3)

				var_238_16.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos128404, var_238_22, var_238_21)
			end

			if arg_235_1.time_ >= var_238_17 + var_238_20 and arg_235_1.time_ < var_238_17 + var_238_20 + arg_238_0 then
				var_238_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_238_23 = arg_235_1.actors_["106603"].transform
			local var_238_24 = 0

			if var_238_24 < arg_235_1.time_ and arg_235_1.time_ <= var_238_24 + arg_238_0 then
				arg_235_1.var_.moveOldPos106603 = var_238_23.localPosition
				var_238_23.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("106603", 7)

				local var_238_25 = var_238_23.childCount

				for iter_238_9 = 0, var_238_25 - 1 do
					local var_238_26 = var_238_23:GetChild(iter_238_9)

					if var_238_26.name == "" or not string.find(var_238_26.name, "split") then
						var_238_26.gameObject:SetActive(true)
					else
						var_238_26.gameObject:SetActive(false)
					end
				end
			end

			local var_238_27 = 0.001

			if var_238_24 <= arg_235_1.time_ and arg_235_1.time_ < var_238_24 + var_238_27 then
				local var_238_28 = (arg_235_1.time_ - var_238_24) / var_238_27
				local var_238_29 = Vector3.New(0, -2000, 0)

				var_238_23.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos106603, var_238_29, var_238_28)
			end

			if arg_235_1.time_ >= var_238_24 + var_238_27 and arg_235_1.time_ < var_238_24 + var_238_27 + arg_238_0 then
				var_238_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_238_30 = 0
			local var_238_31 = 0.375

			if var_238_30 < arg_235_1.time_ and arg_235_1.time_ <= var_238_30 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_32 = arg_235_1:FormatText(StoryNameCfg[6].name)

				arg_235_1.leftNameTxt_.text = var_238_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_33 = arg_235_1:GetWordFromCfg(938081057)
				local var_238_34 = arg_235_1:FormatText(var_238_33.content)

				arg_235_1.text_.text = var_238_34

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_35 = 15
				local var_238_36 = utf8.len(var_238_34)
				local var_238_37 = var_238_35 <= 0 and var_238_31 or var_238_31 * (var_238_36 / var_238_35)

				if var_238_37 > 0 and var_238_31 < var_238_37 then
					arg_235_1.talkMaxDuration = var_238_37

					if var_238_37 + var_238_30 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_37 + var_238_30
					end
				end

				arg_235_1.text_.text = var_238_34
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_38 = math.max(var_238_31, arg_235_1.talkMaxDuration)

			if var_238_30 <= arg_235_1.time_ and arg_235_1.time_ < var_238_30 + var_238_38 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_30) / var_238_38

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_30 + var_238_38 and arg_235_1.time_ < var_238_30 + var_238_38 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play938081058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 938081058
		arg_239_1.duration_ = 1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"

			SetActive(arg_239_1.choicesGo_, true)

			for iter_240_0, iter_240_1 in ipairs(arg_239_1.choices_) do
				local var_240_0 = iter_240_0 <= 1

				SetActive(iter_240_1.go, var_240_0)
			end

			arg_239_1.choices_[1].txt.text = arg_239_1:FormatText(StoryChoiceCfg[1791].name)
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play938081059(arg_239_1)
			end

			arg_239_1:RecordChoiceLog(938081058, 1791)
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["128404"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps128404 == nil then
				arg_239_1.var_.actorSpriteComps128404 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps128404 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								local var_242_4 = Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, var_242_3)
								local var_242_5 = Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, var_242_3)
								local var_242_6 = Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, var_242_3)

								iter_242_1.color = Color.New(var_242_4, var_242_5, var_242_6)
							else
								local var_242_7 = Mathf.Lerp(iter_242_1.color.r, 0.5, var_242_3)

								iter_242_1.color = Color.New(var_242_7, var_242_7, var_242_7)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps128404 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps128404 = nil
			end

			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_9 = 0.6

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play938081059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 938081059
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play938081060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = "H02a"

			if arg_243_1.bgs_[var_246_0] == nil then
				local var_246_1 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_0)
				var_246_1.name = var_246_0
				var_246_1.transform.parent = arg_243_1.stage_.transform
				var_246_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_0] = var_246_1
			end

			local var_246_2 = 1.999999999999

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				local var_246_3 = manager.ui.mainCamera.transform.localPosition
				local var_246_4 = Vector3.New(0, 0, 10) + Vector3.New(var_246_3.x, var_246_3.y, 0)
				local var_246_5 = arg_243_1.bgs_.H02a

				var_246_5.transform.localPosition = var_246_4
				var_246_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_6 = var_246_5:GetComponent("SpriteRenderer")

				if var_246_6 and var_246_6.sprite then
					local var_246_7 = (var_246_5.transform.localPosition - var_246_3).z
					local var_246_8 = manager.ui.mainCameraCom_
					local var_246_9 = 2 * var_246_7 * Mathf.Tan(var_246_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_246_10 = var_246_9 * var_246_8.aspect
					local var_246_11 = var_246_6.sprite.bounds.size.x
					local var_246_12 = var_246_6.sprite.bounds.size.y
					local var_246_13 = var_246_10 / var_246_11
					local var_246_14 = var_246_9 / var_246_12
					local var_246_15 = var_246_14 < var_246_13 and var_246_13 or var_246_14

					var_246_5.transform.localScale = Vector3.New(var_246_15, var_246_15, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "H02a" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_16 = 4.034

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			local var_246_17 = 0.3

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_18 = 0

			if var_246_18 < arg_243_1.time_ and arg_243_1.time_ <= var_246_18 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_19 = 2

			if var_246_18 <= arg_243_1.time_ and arg_243_1.time_ < var_246_18 + var_246_19 then
				local var_246_20 = (arg_243_1.time_ - var_246_18) / var_246_19
				local var_246_21 = Color.New(0, 0, 0)

				var_246_21.a = Mathf.Lerp(0, 1, var_246_20)
				arg_243_1.mask_.color = var_246_21
			end

			if arg_243_1.time_ >= var_246_18 + var_246_19 and arg_243_1.time_ < var_246_18 + var_246_19 + arg_246_0 then
				local var_246_22 = Color.New(0, 0, 0)

				var_246_22.a = 1
				arg_243_1.mask_.color = var_246_22
			end

			local var_246_23 = 2

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_24 = 2

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24
				local var_246_26 = Color.New(0, 0, 0)

				var_246_26.a = Mathf.Lerp(1, 0, var_246_25)
				arg_243_1.mask_.color = var_246_26
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 then
				local var_246_27 = Color.New(0, 0, 0)
				local var_246_28 = 0

				arg_243_1.mask_.enabled = false
				var_246_27.a = var_246_28
				arg_243_1.mask_.color = var_246_27
			end

			local var_246_29 = arg_243_1.actors_["108301"]
			local var_246_30 = 3.999999999999

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 and not isNil(var_246_29) and arg_243_1.var_.actorSpriteComps108301 == nil then
				arg_243_1.var_.actorSpriteComps108301 = var_246_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_31 = 0.2

			if var_246_30 <= arg_243_1.time_ and arg_243_1.time_ < var_246_30 + var_246_31 and not isNil(var_246_29) then
				local var_246_32 = (arg_243_1.time_ - var_246_30) / var_246_31

				if arg_243_1.var_.actorSpriteComps108301 then
					for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_246_3 then
							if arg_243_1.isInRecall_ then
								local var_246_33 = Mathf.Lerp(iter_246_3.color.r, arg_243_1.hightColor1.r, var_246_32)
								local var_246_34 = Mathf.Lerp(iter_246_3.color.g, arg_243_1.hightColor1.g, var_246_32)
								local var_246_35 = Mathf.Lerp(iter_246_3.color.b, arg_243_1.hightColor1.b, var_246_32)

								iter_246_3.color = Color.New(var_246_33, var_246_34, var_246_35)
							else
								local var_246_36 = Mathf.Lerp(iter_246_3.color.r, 1, var_246_32)

								iter_246_3.color = Color.New(var_246_36, var_246_36, var_246_36)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_30 + var_246_31 and arg_243_1.time_ < var_246_30 + var_246_31 + arg_246_0 and not isNil(var_246_29) and arg_243_1.var_.actorSpriteComps108301 then
				for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_246_5 then
						if arg_243_1.isInRecall_ then
							iter_246_5.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps108301 = nil
			end

			local var_246_37 = arg_243_1.actors_["108301"].transform
			local var_246_38 = 4

			if var_246_38 < arg_243_1.time_ and arg_243_1.time_ <= var_246_38 + arg_246_0 then
				arg_243_1.var_.moveOldPos108301 = var_246_37.localPosition
				var_246_37.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("108301", 2)

				local var_246_39 = var_246_37.childCount

				for iter_246_6 = 0, var_246_39 - 1 do
					local var_246_40 = var_246_37:GetChild(iter_246_6)

					if var_246_40.name == "split_5" or not string.find(var_246_40.name, "split") then
						var_246_40.gameObject:SetActive(true)
					else
						var_246_40.gameObject:SetActive(false)
					end
				end
			end

			local var_246_41 = 0.001

			if var_246_38 <= arg_243_1.time_ and arg_243_1.time_ < var_246_38 + var_246_41 then
				local var_246_42 = (arg_243_1.time_ - var_246_38) / var_246_41
				local var_246_43 = Vector3.New(-420, -360, -195)

				var_246_37.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos108301, var_246_43, var_246_42)
			end

			if arg_243_1.time_ >= var_246_38 + var_246_41 and arg_243_1.time_ < var_246_38 + var_246_41 + arg_246_0 then
				var_246_37.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_246_44 = 2.9
			local var_246_45 = 1

			if var_246_44 < arg_243_1.time_ and arg_243_1.time_ <= var_246_44 + arg_246_0 then
				local var_246_46 = "play"
				local var_246_47 = "effect"

				arg_243_1:AudioAction(var_246_46, var_246_47, "se_story_133", "se_story_133_sea", "")
			end

			local var_246_48 = 2.2
			local var_246_49 = 1

			if var_246_48 < arg_243_1.time_ and arg_243_1.time_ <= var_246_48 + arg_246_0 then
				local var_246_50 = "stop"
				local var_246_51 = "effect"

				arg_243_1:AudioAction(var_246_50, var_246_51, "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_246_52 = 2.9
			local var_246_53 = 1

			if var_246_52 < arg_243_1.time_ and arg_243_1.time_ <= var_246_52 + arg_246_0 then
				local var_246_54 = "play"
				local var_246_55 = "music"

				arg_243_1:AudioAction(var_246_54, var_246_55, "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_246_56 = ""
				local var_246_57 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if var_246_57 ~= "" then
					if arg_243_1.bgmTxt_.text ~= var_246_57 and arg_243_1.bgmTxt_.text ~= "" then
						if arg_243_1.bgmTxt2_.text ~= "" then
							arg_243_1.bgmTxt_.text = arg_243_1.bgmTxt2_.text
						end

						arg_243_1.bgmTxt2_.text = var_246_57

						arg_243_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_243_1.bgmTxt_.text = var_246_57
						arg_243_1.bgmTxt2_.text = var_246_57
					end

					if arg_243_1.bgmTimer then
						arg_243_1.bgmTimer:Stop()

						arg_243_1.bgmTimer = nil
					end

					if arg_243_1.settingData.show_music_name == 1 then
						arg_243_1.musicController:SetSelectedState("show")
						arg_243_1.musicAnimator_:Play("open", 0, 0)

						if arg_243_1.settingData.music_time ~= 0 then
							arg_243_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_243_1.settingData.music_time), function()
								if arg_243_1 == nil or isNil(arg_243_1.bgmTxt_) then
									return
								end

								arg_243_1.musicController:SetSelectedState("hide")
								arg_243_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_246_58 = arg_243_1.actors_["104902"].transform
			local var_246_59 = 1.966

			if var_246_59 < arg_243_1.time_ and arg_243_1.time_ <= var_246_59 + arg_246_0 then
				arg_243_1.var_.moveOldPos104902 = var_246_58.localPosition
				var_246_58.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("104902", 7)

				local var_246_60 = var_246_58.childCount

				for iter_246_7 = 0, var_246_60 - 1 do
					local var_246_61 = var_246_58:GetChild(iter_246_7)

					if var_246_61.name == "" or not string.find(var_246_61.name, "split") then
						var_246_61.gameObject:SetActive(true)
					else
						var_246_61.gameObject:SetActive(false)
					end
				end
			end

			local var_246_62 = 0.001

			if var_246_59 <= arg_243_1.time_ and arg_243_1.time_ < var_246_59 + var_246_62 then
				local var_246_63 = (arg_243_1.time_ - var_246_59) / var_246_62
				local var_246_64 = Vector3.New(0, -2000, -360)

				var_246_58.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos104902, var_246_64, var_246_63)
			end

			if arg_243_1.time_ >= var_246_59 + var_246_62 and arg_243_1.time_ < var_246_59 + var_246_62 + arg_246_0 then
				var_246_58.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_246_65 = arg_243_1.actors_["128404"].transform
			local var_246_66 = 1.966

			if var_246_66 < arg_243_1.time_ and arg_243_1.time_ <= var_246_66 + arg_246_0 then
				arg_243_1.var_.moveOldPos128404 = var_246_65.localPosition
				var_246_65.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("128404", 7)

				local var_246_67 = var_246_65.childCount

				for iter_246_8 = 0, var_246_67 - 1 do
					local var_246_68 = var_246_65:GetChild(iter_246_8)

					if var_246_68.name == "" or not string.find(var_246_68.name, "split") then
						var_246_68.gameObject:SetActive(true)
					else
						var_246_68.gameObject:SetActive(false)
					end
				end
			end

			local var_246_69 = 0.001

			if var_246_66 <= arg_243_1.time_ and arg_243_1.time_ < var_246_66 + var_246_69 then
				local var_246_70 = (arg_243_1.time_ - var_246_66) / var_246_69
				local var_246_71 = Vector3.New(0, -2000, 0)

				var_246_65.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos128404, var_246_71, var_246_70)
			end

			if arg_243_1.time_ >= var_246_66 + var_246_69 and arg_243_1.time_ < var_246_66 + var_246_69 + arg_246_0 then
				var_246_65.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_72 = 3.999999999999
			local var_246_73 = 1.1

			if var_246_72 < arg_243_1.time_ and arg_243_1.time_ <= var_246_72 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_74 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_74:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_243_1.dialogCg_.alpha = arg_248_0
				end))
				var_246_74:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_74:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_75 = arg_243_1:FormatText(StoryNameCfg[1332].name)

				arg_243_1.leftNameTxt_.text = var_246_75

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_76 = arg_243_1:GetWordFromCfg(938081059)
				local var_246_77 = arg_243_1:FormatText(var_246_76.content)

				arg_243_1.text_.text = var_246_77

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_78 = 44
				local var_246_79 = utf8.len(var_246_77)
				local var_246_80 = var_246_78 <= 0 and var_246_73 or var_246_73 * (var_246_79 / var_246_78)

				if var_246_80 > 0 and var_246_73 < var_246_80 then
					arg_243_1.talkMaxDuration = var_246_80
					var_246_72 = var_246_72 + 0.3

					if var_246_80 + var_246_72 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_80 + var_246_72
					end
				end

				arg_243_1.text_.text = var_246_77
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_81 = var_246_72 + 0.3
			local var_246_82 = math.max(var_246_73, arg_243_1.talkMaxDuration)

			if var_246_81 <= arg_243_1.time_ and arg_243_1.time_ < var_246_81 + var_246_82 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_81) / var_246_82

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_81 + var_246_82 and arg_243_1.time_ < var_246_81 + var_246_82 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play938081060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938081060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938081061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["106603"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps106603 == nil then
				arg_250_1.var_.actorSpriteComps106603 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps106603 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 1, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps106603 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_253_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps106603 = nil
			end

			local var_253_8 = arg_250_1.actors_["108301"]
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 and not isNil(var_253_8) and arg_250_1.var_.actorSpriteComps108301 == nil then
				arg_250_1.var_.actorSpriteComps108301 = var_253_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_10 = 0.2

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_10 and not isNil(var_253_8) then
				local var_253_11 = (arg_250_1.time_ - var_253_9) / var_253_10

				if arg_250_1.var_.actorSpriteComps108301 then
					for iter_253_4, iter_253_5 in pairs(arg_250_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_253_5 then
							if arg_250_1.isInRecall_ then
								local var_253_12 = Mathf.Lerp(iter_253_5.color.r, arg_250_1.hightColor2.r, var_253_11)
								local var_253_13 = Mathf.Lerp(iter_253_5.color.g, arg_250_1.hightColor2.g, var_253_11)
								local var_253_14 = Mathf.Lerp(iter_253_5.color.b, arg_250_1.hightColor2.b, var_253_11)

								iter_253_5.color = Color.New(var_253_12, var_253_13, var_253_14)
							else
								local var_253_15 = Mathf.Lerp(iter_253_5.color.r, 0.5, var_253_11)

								iter_253_5.color = Color.New(var_253_15, var_253_15, var_253_15)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_9 + var_253_10 and arg_250_1.time_ < var_253_9 + var_253_10 + arg_253_0 and not isNil(var_253_8) and arg_250_1.var_.actorSpriteComps108301 then
				for iter_253_6, iter_253_7 in pairs(arg_250_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_253_7 then
						if arg_250_1.isInRecall_ then
							iter_253_7.color = arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_253_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps108301 = nil
			end

			local var_253_16 = arg_250_1.actors_["106603"].transform
			local var_253_17 = 0

			if var_253_17 < arg_250_1.time_ and arg_250_1.time_ <= var_253_17 + arg_253_0 then
				arg_250_1.var_.moveOldPos106603 = var_253_16.localPosition
				var_253_16.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("106603", 4)

				local var_253_18 = var_253_16.childCount

				for iter_253_8 = 0, var_253_18 - 1 do
					local var_253_19 = var_253_16:GetChild(iter_253_8)

					if var_253_19.name == "split_6" or not string.find(var_253_19.name, "split") then
						var_253_19.gameObject:SetActive(true)
					else
						var_253_19.gameObject:SetActive(false)
					end
				end
			end

			local var_253_20 = 0.001

			if var_253_17 <= arg_250_1.time_ and arg_250_1.time_ < var_253_17 + var_253_20 then
				local var_253_21 = (arg_250_1.time_ - var_253_17) / var_253_20
				local var_253_22 = Vector3.New(453.9, -399.1, -303.3)

				var_253_16.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos106603, var_253_22, var_253_21)
			end

			if arg_250_1.time_ >= var_253_17 + var_253_20 and arg_250_1.time_ < var_253_17 + var_253_20 + arg_253_0 then
				var_253_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_253_23 = 0
			local var_253_24 = 0.5

			if var_253_23 < arg_250_1.time_ and arg_250_1.time_ <= var_253_23 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_25 = arg_250_1:FormatText(StoryNameCfg[32].name)

				arg_250_1.leftNameTxt_.text = var_253_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_26 = arg_250_1:GetWordFromCfg(938081060)
				local var_253_27 = arg_250_1:FormatText(var_253_26.content)

				arg_250_1.text_.text = var_253_27

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_28 = 20
				local var_253_29 = utf8.len(var_253_27)
				local var_253_30 = var_253_28 <= 0 and var_253_24 or var_253_24 * (var_253_29 / var_253_28)

				if var_253_30 > 0 and var_253_24 < var_253_30 then
					arg_250_1.talkMaxDuration = var_253_30

					if var_253_30 + var_253_23 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_30 + var_253_23
					end
				end

				arg_250_1.text_.text = var_253_27
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_31 = math.max(var_253_24, arg_250_1.talkMaxDuration)

			if var_253_23 <= arg_250_1.time_ and arg_250_1.time_ < var_253_23 + var_253_31 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_23) / var_253_31

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_23 + var_253_31 and arg_250_1.time_ < var_253_23 + var_253_31 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play938081061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938081061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938081062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["108301"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps108301 == nil then
				arg_254_1.var_.actorSpriteComps108301 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps108301 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 1, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps108301 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps108301 = nil
			end

			local var_257_8 = arg_254_1.actors_["106603"]
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps106603 == nil then
				arg_254_1.var_.actorSpriteComps106603 = var_257_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_10 = 0.2

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_10 and not isNil(var_257_8) then
				local var_257_11 = (arg_254_1.time_ - var_257_9) / var_257_10

				if arg_254_1.var_.actorSpriteComps106603 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								local var_257_12 = Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, var_257_11)
								local var_257_13 = Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, var_257_11)
								local var_257_14 = Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, var_257_11)

								iter_257_5.color = Color.New(var_257_12, var_257_13, var_257_14)
							else
								local var_257_15 = Mathf.Lerp(iter_257_5.color.r, 0.5, var_257_11)

								iter_257_5.color = Color.New(var_257_15, var_257_15, var_257_15)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_9 + var_257_10 and arg_254_1.time_ < var_257_9 + var_257_10 + arg_257_0 and not isNil(var_257_8) and arg_254_1.var_.actorSpriteComps106603 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_257_7 then
						if arg_254_1.isInRecall_ then
							iter_257_7.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps106603 = nil
			end

			local var_257_16 = arg_254_1.actors_["108301"].transform
			local var_257_17 = 0

			if var_257_17 < arg_254_1.time_ and arg_254_1.time_ <= var_257_17 + arg_257_0 then
				arg_254_1.var_.moveOldPos108301 = var_257_16.localPosition
				var_257_16.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("108301", 2)

				local var_257_18 = var_257_16.childCount

				for iter_257_8 = 0, var_257_18 - 1 do
					local var_257_19 = var_257_16:GetChild(iter_257_8)

					if var_257_19.name == "split_1" then
						var_257_19:SetAsLastSibling()
						var_257_19.gameObject:SetActive(true)

						arg_254_1.var_.actorSpriteSplit108301 = var_257_19.gameObject:GetComponent(typeof(Image))

						arg_254_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_257_20 = 0.5

			if var_257_17 <= arg_254_1.time_ and arg_254_1.time_ < var_257_17 + var_257_20 then
				local var_257_21 = (arg_254_1.time_ - var_257_17) / var_257_20
				local var_257_22 = Vector3.New(-420, -360, -195)

				var_257_16.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos108301, var_257_22, var_257_21)

				if arg_254_1.var_.actorSpriteSplit108301 ~= nil then
					arg_254_1.var_.actorSpriteSplit108301:SetAlpha(var_257_21)
				end
			end

			if arg_254_1.time_ >= var_257_17 + var_257_20 and arg_254_1.time_ < var_257_17 + var_257_20 + arg_257_0 then
				var_257_16.localPosition = Vector3.New(-420, -360, -195)

				if arg_254_1.var_.actorSpriteSplit108301 ~= nil then
					arg_254_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_257_23 = 0
			local var_257_24 = 0.35

			if var_257_23 < arg_254_1.time_ and arg_254_1.time_ <= var_257_23 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_25 = arg_254_1:FormatText(StoryNameCfg[1332].name)

				arg_254_1.leftNameTxt_.text = var_257_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_26 = arg_254_1:GetWordFromCfg(938081061)
				local var_257_27 = arg_254_1:FormatText(var_257_26.content)

				arg_254_1.text_.text = var_257_27

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_28 = 14
				local var_257_29 = utf8.len(var_257_27)
				local var_257_30 = var_257_28 <= 0 and var_257_24 or var_257_24 * (var_257_29 / var_257_28)

				if var_257_30 > 0 and var_257_24 < var_257_30 then
					arg_254_1.talkMaxDuration = var_257_30

					if var_257_30 + var_257_23 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_30 + var_257_23
					end
				end

				arg_254_1.text_.text = var_257_27
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_31 = math.max(var_257_24, arg_254_1.talkMaxDuration)

			if var_257_23 <= arg_254_1.time_ and arg_254_1.time_ < var_257_23 + var_257_31 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_23) / var_257_31

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_23 + var_257_31 and arg_254_1.time_ < var_257_23 + var_257_31 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play938081062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938081062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938081063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["106603"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps106603 == nil then
				arg_258_1.var_.actorSpriteComps106603 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps106603 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								local var_261_4 = Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, var_261_3)
								local var_261_5 = Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, var_261_3)
								local var_261_6 = Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, var_261_3)

								iter_261_1.color = Color.New(var_261_4, var_261_5, var_261_6)
							else
								local var_261_7 = Mathf.Lerp(iter_261_1.color.r, 1, var_261_3)

								iter_261_1.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps106603 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps106603 = nil
			end

			local var_261_8 = arg_258_1.actors_["108301"]
			local var_261_9 = 0

			if var_261_9 < arg_258_1.time_ and arg_258_1.time_ <= var_261_9 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps108301 == nil then
				arg_258_1.var_.actorSpriteComps108301 = var_261_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_10 = 0.2

			if var_261_9 <= arg_258_1.time_ and arg_258_1.time_ < var_261_9 + var_261_10 and not isNil(var_261_8) then
				local var_261_11 = (arg_258_1.time_ - var_261_9) / var_261_10

				if arg_258_1.var_.actorSpriteComps108301 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								local var_261_12 = Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, var_261_11)
								local var_261_13 = Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, var_261_11)
								local var_261_14 = Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, var_261_11)

								iter_261_5.color = Color.New(var_261_12, var_261_13, var_261_14)
							else
								local var_261_15 = Mathf.Lerp(iter_261_5.color.r, 0.5, var_261_11)

								iter_261_5.color = Color.New(var_261_15, var_261_15, var_261_15)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_9 + var_261_10 and arg_258_1.time_ < var_261_9 + var_261_10 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps108301 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_261_7 then
						if arg_258_1.isInRecall_ then
							iter_261_7.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps108301 = nil
			end

			local var_261_16 = arg_258_1.actors_["106603"].transform
			local var_261_17 = 0

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.var_.moveOldPos106603 = var_261_16.localPosition
				var_261_16.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("106603", 4)

				local var_261_18 = var_261_16.childCount

				for iter_261_8 = 0, var_261_18 - 1 do
					local var_261_19 = var_261_16:GetChild(iter_261_8)

					if var_261_19.name == "split_1" then
						var_261_19:SetAsLastSibling()
						var_261_19.gameObject:SetActive(true)

						arg_258_1.var_.actorSpriteSplit106603 = var_261_19.gameObject:GetComponent(typeof(Image))

						arg_258_1.var_.actorSpriteSplit106603:SetAlpha(0)
					end
				end
			end

			local var_261_20 = 0.5

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_20 then
				local var_261_21 = (arg_258_1.time_ - var_261_17) / var_261_20
				local var_261_22 = Vector3.New(453.9, -399.1, -303.3)

				var_261_16.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos106603, var_261_22, var_261_21)

				if arg_258_1.var_.actorSpriteSplit106603 ~= nil then
					arg_258_1.var_.actorSpriteSplit106603:SetAlpha(var_261_21)
				end
			end

			if arg_258_1.time_ >= var_261_17 + var_261_20 and arg_258_1.time_ < var_261_17 + var_261_20 + arg_261_0 then
				var_261_16.localPosition = Vector3.New(453.9, -399.1, -303.3)

				if arg_258_1.var_.actorSpriteSplit106603 ~= nil then
					arg_258_1.var_.actorSpriteSplit106603:SetAlpha(1)
				end
			end

			local var_261_23 = 0
			local var_261_24 = 0.2

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_25 = arg_258_1:FormatText(StoryNameCfg[32].name)

				arg_258_1.leftNameTxt_.text = var_261_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_26 = arg_258_1:GetWordFromCfg(938081062)
				local var_261_27 = arg_258_1:FormatText(var_261_26.content)

				arg_258_1.text_.text = var_261_27

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_28 = 8
				local var_261_29 = utf8.len(var_261_27)
				local var_261_30 = var_261_28 <= 0 and var_261_24 or var_261_24 * (var_261_29 / var_261_28)

				if var_261_30 > 0 and var_261_24 < var_261_30 then
					arg_258_1.talkMaxDuration = var_261_30

					if var_261_30 + var_261_23 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_30 + var_261_23
					end
				end

				arg_258_1.text_.text = var_261_27
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_31 = math.max(var_261_24, arg_258_1.talkMaxDuration)

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_31 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_23) / var_261_31

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_23 + var_261_31 and arg_258_1.time_ < var_261_23 + var_261_31 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play938081063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938081063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938081064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["128404"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps128404 == nil then
				arg_262_1.var_.actorSpriteComps128404 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps128404 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								local var_265_4 = Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, var_265_3)
								local var_265_5 = Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, var_265_3)
								local var_265_6 = Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, var_265_3)

								iter_265_1.color = Color.New(var_265_4, var_265_5, var_265_6)
							else
								local var_265_7 = Mathf.Lerp(iter_265_1.color.r, 1, var_265_3)

								iter_265_1.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps128404 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps128404 = nil
			end

			local var_265_8 = arg_262_1.actors_["106603"]
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps106603 == nil then
				arg_262_1.var_.actorSpriteComps106603 = var_265_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_10 = 0.2

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_10 and not isNil(var_265_8) then
				local var_265_11 = (arg_262_1.time_ - var_265_9) / var_265_10

				if arg_262_1.var_.actorSpriteComps106603 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								local var_265_12 = Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, var_265_11)
								local var_265_13 = Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, var_265_11)
								local var_265_14 = Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, var_265_11)

								iter_265_5.color = Color.New(var_265_12, var_265_13, var_265_14)
							else
								local var_265_15 = Mathf.Lerp(iter_265_5.color.r, 0.5, var_265_11)

								iter_265_5.color = Color.New(var_265_15, var_265_15, var_265_15)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_9 + var_265_10 and arg_262_1.time_ < var_265_9 + var_265_10 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps106603 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_265_7 then
						if arg_262_1.isInRecall_ then
							iter_265_7.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps106603 = nil
			end

			local var_265_16 = arg_262_1.actors_["128404"].transform
			local var_265_17 = 0

			if var_265_17 < arg_262_1.time_ and arg_262_1.time_ <= var_265_17 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = var_265_16.localPosition
				var_265_16.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 2)

				local var_265_18 = var_265_16.childCount

				for iter_265_8 = 0, var_265_18 - 1 do
					local var_265_19 = var_265_16:GetChild(iter_265_8)

					if var_265_19.name == "split_2" or not string.find(var_265_19.name, "split") then
						var_265_19.gameObject:SetActive(true)
					else
						var_265_19.gameObject:SetActive(false)
					end
				end
			end

			local var_265_20 = 0.001

			if var_265_17 <= arg_262_1.time_ and arg_262_1.time_ < var_265_17 + var_265_20 then
				local var_265_21 = (arg_262_1.time_ - var_265_17) / var_265_20
				local var_265_22 = Vector3.New(-428.5, -356, -362.3)

				var_265_16.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, var_265_22, var_265_21)
			end

			if arg_262_1.time_ >= var_265_17 + var_265_20 and arg_262_1.time_ < var_265_17 + var_265_20 + arg_265_0 then
				var_265_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_265_23 = arg_262_1.actors_["108301"].transform
			local var_265_24 = 0

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 then
				arg_262_1.var_.moveOldPos108301 = var_265_23.localPosition
				var_265_23.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("108301", 7)

				local var_265_25 = var_265_23.childCount

				for iter_265_9 = 0, var_265_25 - 1 do
					local var_265_26 = var_265_23:GetChild(iter_265_9)

					if var_265_26.name == "" or not string.find(var_265_26.name, "split") then
						var_265_26.gameObject:SetActive(true)
					else
						var_265_26.gameObject:SetActive(false)
					end
				end
			end

			local var_265_27 = 0.001

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_27 then
				local var_265_28 = (arg_262_1.time_ - var_265_24) / var_265_27
				local var_265_29 = Vector3.New(0, -2000, 0)

				var_265_23.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos108301, var_265_29, var_265_28)
			end

			if arg_262_1.time_ >= var_265_24 + var_265_27 and arg_262_1.time_ < var_265_24 + var_265_27 + arg_265_0 then
				var_265_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_30 = 0
			local var_265_31 = 0.425

			if var_265_30 < arg_262_1.time_ and arg_262_1.time_ <= var_265_30 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_32 = arg_262_1:FormatText(StoryNameCfg[6].name)

				arg_262_1.leftNameTxt_.text = var_265_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_33 = arg_262_1:GetWordFromCfg(938081063)
				local var_265_34 = arg_262_1:FormatText(var_265_33.content)

				arg_262_1.text_.text = var_265_34

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_35 = 17
				local var_265_36 = utf8.len(var_265_34)
				local var_265_37 = var_265_35 <= 0 and var_265_31 or var_265_31 * (var_265_36 / var_265_35)

				if var_265_37 > 0 and var_265_31 < var_265_37 then
					arg_262_1.talkMaxDuration = var_265_37

					if var_265_37 + var_265_30 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_37 + var_265_30
					end
				end

				arg_262_1.text_.text = var_265_34
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_38 = math.max(var_265_31, arg_262_1.talkMaxDuration)

			if var_265_30 <= arg_262_1.time_ and arg_262_1.time_ < var_265_30 + var_265_38 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_30) / var_265_38

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_30 + var_265_38 and arg_262_1.time_ < var_265_30 + var_265_38 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938081064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938081064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938081065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["128404"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos128404 = var_269_0.localPosition
				var_269_0.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("128404", 2)

				local var_269_2 = var_269_0.childCount

				for iter_269_0 = 0, var_269_2 - 1 do
					local var_269_3 = var_269_0:GetChild(iter_269_0)

					if var_269_3.name == "split_1" then
						var_269_3:SetAsLastSibling()
						var_269_3.gameObject:SetActive(true)

						arg_266_1.var_.actorSpriteSplit128404 = var_269_3.gameObject:GetComponent(typeof(Image))

						arg_266_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_269_4 = 0.5

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_4 then
				local var_269_5 = (arg_266_1.time_ - var_269_1) / var_269_4
				local var_269_6 = Vector3.New(-428.5, -356, -362.3)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos128404, var_269_6, var_269_5)

				if arg_266_1.var_.actorSpriteSplit128404 ~= nil then
					arg_266_1.var_.actorSpriteSplit128404:SetAlpha(var_269_5)
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_4 and arg_266_1.time_ < var_269_1 + var_269_4 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_266_1.var_.actorSpriteSplit128404 ~= nil then
					arg_266_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_269_7 = 0
			local var_269_8 = 0.95

			if var_269_7 < arg_266_1.time_ and arg_266_1.time_ <= var_269_7 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_9 = arg_266_1:FormatText(StoryNameCfg[6].name)

				arg_266_1.leftNameTxt_.text = var_269_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(938081064)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_12 = 38
				local var_269_13 = utf8.len(var_269_11)
				local var_269_14 = var_269_12 <= 0 and var_269_8 or var_269_8 * (var_269_13 / var_269_12)

				if var_269_14 > 0 and var_269_8 < var_269_14 then
					arg_266_1.talkMaxDuration = var_269_14

					if var_269_14 + var_269_7 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_7
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_15 = math.max(var_269_8, arg_266_1.talkMaxDuration)

			if var_269_7 <= arg_266_1.time_ and arg_266_1.time_ < var_269_7 + var_269_15 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_7) / var_269_15

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_7 + var_269_15 and arg_266_1.time_ < var_269_7 + var_269_15 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play938081065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938081065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938081066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["104902"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps104902 == nil then
				arg_270_1.var_.actorSpriteComps104902 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps104902 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 1, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps104902 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps104902 = nil
			end

			local var_273_8 = arg_270_1.actors_["128404"]
			local var_273_9 = 0

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.actorSpriteComps128404 == nil then
				arg_270_1.var_.actorSpriteComps128404 = var_273_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_10 = 0.2

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_10 and not isNil(var_273_8) then
				local var_273_11 = (arg_270_1.time_ - var_273_9) / var_273_10

				if arg_270_1.var_.actorSpriteComps128404 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_273_5 then
							if arg_270_1.isInRecall_ then
								local var_273_12 = Mathf.Lerp(iter_273_5.color.r, arg_270_1.hightColor2.r, var_273_11)
								local var_273_13 = Mathf.Lerp(iter_273_5.color.g, arg_270_1.hightColor2.g, var_273_11)
								local var_273_14 = Mathf.Lerp(iter_273_5.color.b, arg_270_1.hightColor2.b, var_273_11)

								iter_273_5.color = Color.New(var_273_12, var_273_13, var_273_14)
							else
								local var_273_15 = Mathf.Lerp(iter_273_5.color.r, 0.5, var_273_11)

								iter_273_5.color = Color.New(var_273_15, var_273_15, var_273_15)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_9 + var_273_10 and arg_270_1.time_ < var_273_9 + var_273_10 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.actorSpriteComps128404 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_273_7 then
						if arg_270_1.isInRecall_ then
							iter_273_7.color = arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_273_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps128404 = nil
			end

			local var_273_16 = arg_270_1.actors_["104902"].transform
			local var_273_17 = 0

			if var_273_17 < arg_270_1.time_ and arg_270_1.time_ <= var_273_17 + arg_273_0 then
				arg_270_1.var_.moveOldPos104902 = var_273_16.localPosition
				var_273_16.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("104902", 4)

				local var_273_18 = var_273_16.childCount

				for iter_273_8 = 0, var_273_18 - 1 do
					local var_273_19 = var_273_16:GetChild(iter_273_8)

					if var_273_19.name == "split_2" or not string.find(var_273_19.name, "split") then
						var_273_19.gameObject:SetActive(true)
					else
						var_273_19.gameObject:SetActive(false)
					end
				end
			end

			local var_273_20 = 0.001

			if var_273_17 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_20 then
				local var_273_21 = (arg_270_1.time_ - var_273_17) / var_273_20
				local var_273_22 = Vector3.New(390, -335, -360)

				var_273_16.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos104902, var_273_22, var_273_21)
			end

			if arg_270_1.time_ >= var_273_17 + var_273_20 and arg_270_1.time_ < var_273_17 + var_273_20 + arg_273_0 then
				var_273_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_273_23 = arg_270_1.actors_["106603"].transform
			local var_273_24 = 0

			if var_273_24 < arg_270_1.time_ and arg_270_1.time_ <= var_273_24 + arg_273_0 then
				arg_270_1.var_.moveOldPos106603 = var_273_23.localPosition
				var_273_23.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("106603", 7)

				local var_273_25 = var_273_23.childCount

				for iter_273_9 = 0, var_273_25 - 1 do
					local var_273_26 = var_273_23:GetChild(iter_273_9)

					if var_273_26.name == "" or not string.find(var_273_26.name, "split") then
						var_273_26.gameObject:SetActive(true)
					else
						var_273_26.gameObject:SetActive(false)
					end
				end
			end

			local var_273_27 = 0.001

			if var_273_24 <= arg_270_1.time_ and arg_270_1.time_ < var_273_24 + var_273_27 then
				local var_273_28 = (arg_270_1.time_ - var_273_24) / var_273_27
				local var_273_29 = Vector3.New(0, -2000, 0)

				var_273_23.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos106603, var_273_29, var_273_28)
			end

			if arg_270_1.time_ >= var_273_24 + var_273_27 and arg_270_1.time_ < var_273_24 + var_273_27 + arg_273_0 then
				var_273_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_30 = 0
			local var_273_31 = 1

			if var_273_30 < arg_270_1.time_ and arg_270_1.time_ <= var_273_30 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_32 = arg_270_1:FormatText(StoryNameCfg[562].name)

				arg_270_1.leftNameTxt_.text = var_273_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_33 = arg_270_1:GetWordFromCfg(938081065)
				local var_273_34 = arg_270_1:FormatText(var_273_33.content)

				arg_270_1.text_.text = var_273_34

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_35 = 40
				local var_273_36 = utf8.len(var_273_34)
				local var_273_37 = var_273_35 <= 0 and var_273_31 or var_273_31 * (var_273_36 / var_273_35)

				if var_273_37 > 0 and var_273_31 < var_273_37 then
					arg_270_1.talkMaxDuration = var_273_37

					if var_273_37 + var_273_30 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_37 + var_273_30
					end
				end

				arg_270_1.text_.text = var_273_34
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_38 = math.max(var_273_31, arg_270_1.talkMaxDuration)

			if var_273_30 <= arg_270_1.time_ and arg_270_1.time_ < var_273_30 + var_273_38 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_30) / var_273_38

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_30 + var_273_38 and arg_270_1.time_ < var_273_30 + var_273_38 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play938081066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938081066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938081067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["104902"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps104902 == nil then
				arg_274_1.var_.actorSpriteComps104902 = var_277_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.actorSpriteComps104902 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								local var_277_4 = Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, var_277_3)
								local var_277_5 = Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, var_277_3)
								local var_277_6 = Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, var_277_3)

								iter_277_1.color = Color.New(var_277_4, var_277_5, var_277_6)
							else
								local var_277_7 = Mathf.Lerp(iter_277_1.color.r, 0.5, var_277_3)

								iter_277_1.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps104902 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_277_3 then
						if arg_274_1.isInRecall_ then
							iter_277_3.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps104902 = nil
			end

			local var_277_8 = 0
			local var_277_9 = 0.45

			if var_277_8 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_10 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_11 = arg_274_1:GetWordFromCfg(938081066)
				local var_277_12 = arg_274_1:FormatText(var_277_11.content)

				arg_274_1.text_.text = var_277_12

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_13 = 18
				local var_277_14 = utf8.len(var_277_12)
				local var_277_15 = var_277_13 <= 0 and var_277_9 or var_277_9 * (var_277_14 / var_277_13)

				if var_277_15 > 0 and var_277_9 < var_277_15 then
					arg_274_1.talkMaxDuration = var_277_15

					if var_277_15 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_15 + var_277_8
					end
				end

				arg_274_1.text_.text = var_277_12
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_9, arg_274_1.talkMaxDuration)

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_8) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_8 + var_277_16 and arg_274_1.time_ < var_277_8 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938081067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938081067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938081068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["104902"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos104902 = var_281_0.localPosition
				var_281_0.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("104902", 7)

				local var_281_2 = var_281_0.childCount

				for iter_281_0 = 0, var_281_2 - 1 do
					local var_281_3 = var_281_0:GetChild(iter_281_0)

					if var_281_3.name == "" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_4 then
				local var_281_5 = (arg_278_1.time_ - var_281_1) / var_281_4
				local var_281_6 = Vector3.New(0, -2000, -360)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos104902, var_281_6, var_281_5)
			end

			if arg_278_1.time_ >= var_281_1 + var_281_4 and arg_278_1.time_ < var_281_1 + var_281_4 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_281_7 = arg_278_1.actors_["128404"].transform
			local var_281_8 = 0

			if var_281_8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.var_.moveOldPos128404 = var_281_7.localPosition
				var_281_7.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("128404", 7)

				local var_281_9 = var_281_7.childCount

				for iter_281_1 = 0, var_281_9 - 1 do
					local var_281_10 = var_281_7:GetChild(iter_281_1)

					if var_281_10.name == "" or not string.find(var_281_10.name, "split") then
						var_281_10.gameObject:SetActive(true)
					else
						var_281_10.gameObject:SetActive(false)
					end
				end
			end

			local var_281_11 = 0.001

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_11 then
				local var_281_12 = (arg_278_1.time_ - var_281_8) / var_281_11
				local var_281_13 = Vector3.New(0, -2000, 0)

				var_281_7.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos128404, var_281_13, var_281_12)
			end

			if arg_278_1.time_ >= var_281_8 + var_281_11 and arg_278_1.time_ < var_281_8 + var_281_11 + arg_281_0 then
				var_281_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_281_14 = 0
			local var_281_15 = 1.05

			if var_281_14 < arg_278_1.time_ and arg_278_1.time_ <= var_281_14 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_16 = arg_278_1:GetWordFromCfg(938081067)
				local var_281_17 = arg_278_1:FormatText(var_281_16.content)

				arg_278_1.text_.text = var_281_17

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_18 = 42
				local var_281_19 = utf8.len(var_281_17)
				local var_281_20 = var_281_18 <= 0 and var_281_15 or var_281_15 * (var_281_19 / var_281_18)

				if var_281_20 > 0 and var_281_15 < var_281_20 then
					arg_278_1.talkMaxDuration = var_281_20

					if var_281_20 + var_281_14 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_20 + var_281_14
					end
				end

				arg_278_1.text_.text = var_281_17
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_21 = math.max(var_281_15, arg_278_1.talkMaxDuration)

			if var_281_14 <= arg_278_1.time_ and arg_278_1.time_ < var_281_14 + var_281_21 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_14) / var_281_21

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_14 + var_281_21 and arg_278_1.time_ < var_281_14 + var_281_21 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play938081068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 938081068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play938081069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.6

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(938081068)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 24
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play938081069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 938081069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play938081070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.3

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(938081069)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 12
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play938081070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938081070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938081071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10183"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps10183 == nil then
				arg_290_1.var_.actorSpriteComps10183 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps10183 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor1.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor1.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor1.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 1, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps10183 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_293_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps10183 = nil
			end

			local var_293_8 = arg_290_1.actors_["10183"].transform
			local var_293_9 = 0

			if var_293_9 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.var_.moveOldPos10183 = var_293_8.localPosition
				var_293_8.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10183", 2)

				local var_293_10 = var_293_8.childCount

				for iter_293_4 = 0, var_293_10 - 1 do
					local var_293_11 = var_293_8:GetChild(iter_293_4)

					if var_293_11.name == "split_7" or not string.find(var_293_11.name, "split") then
						var_293_11.gameObject:SetActive(true)
					else
						var_293_11.gameObject:SetActive(false)
					end
				end
			end

			local var_293_12 = 0.001

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_12 then
				local var_293_13 = (arg_290_1.time_ - var_293_9) / var_293_12
				local var_293_14 = Vector3.New(-300, -475, -325)

				var_293_8.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10183, var_293_14, var_293_13)
			end

			if arg_290_1.time_ >= var_293_9 + var_293_12 and arg_290_1.time_ < var_293_9 + var_293_12 + arg_293_0 then
				var_293_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_293_15 = arg_290_1.actors_["10183"]
			local var_293_16 = 0

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				local var_293_17 = var_293_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_293_17 then
					arg_290_1.var_.alphaOldValue10183 = var_293_17.alpha
					arg_290_1.var_.characterEffect10183 = var_293_17
				end

				arg_290_1.var_.alphaOldValue10183 = 0
			end

			local var_293_18 = 0.0333333333333333

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_18 then
				local var_293_19 = (arg_290_1.time_ - var_293_16) / var_293_18
				local var_293_20 = Mathf.Lerp(arg_290_1.var_.alphaOldValue10183, 1, var_293_19)

				if arg_290_1.var_.characterEffect10183 then
					arg_290_1.var_.characterEffect10183.alpha = var_293_20
				end
			end

			if arg_290_1.time_ >= var_293_16 + var_293_18 and arg_290_1.time_ < var_293_16 + var_293_18 + arg_293_0 and arg_290_1.var_.characterEffect10183 then
				arg_290_1.var_.characterEffect10183.alpha = 1
			end

			local var_293_21 = 0
			local var_293_22 = 0.5

			if var_293_21 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_23 = arg_290_1:FormatText(StoryNameCfg[1562].name)

				arg_290_1.leftNameTxt_.text = var_293_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_24 = arg_290_1:GetWordFromCfg(938081070)
				local var_293_25 = arg_290_1:FormatText(var_293_24.content)

				arg_290_1.text_.text = var_293_25

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_26 = 20
				local var_293_27 = utf8.len(var_293_25)
				local var_293_28 = var_293_26 <= 0 and var_293_22 or var_293_22 * (var_293_27 / var_293_26)

				if var_293_28 > 0 and var_293_22 < var_293_28 then
					arg_290_1.talkMaxDuration = var_293_28

					if var_293_28 + var_293_21 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_28 + var_293_21
					end
				end

				arg_290_1.text_.text = var_293_25
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_29 = math.max(var_293_22, arg_290_1.talkMaxDuration)

			if var_293_21 <= arg_290_1.time_ and arg_290_1.time_ < var_293_21 + var_293_29 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_21) / var_293_29

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_21 + var_293_29 and arg_290_1.time_ < var_293_21 + var_293_29 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play938081071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938081071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938081072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["128404"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps128404 == nil then
				arg_294_1.var_.actorSpriteComps128404 = var_297_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_2 = 0.2

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.actorSpriteComps128404 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								local var_297_4 = Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, var_297_3)
								local var_297_5 = Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, var_297_3)
								local var_297_6 = Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, var_297_3)

								iter_297_1.color = Color.New(var_297_4, var_297_5, var_297_6)
							else
								local var_297_7 = Mathf.Lerp(iter_297_1.color.r, 1, var_297_3)

								iter_297_1.color = Color.New(var_297_7, var_297_7, var_297_7)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps128404 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_297_3 then
						if arg_294_1.isInRecall_ then
							iter_297_3.color = arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_297_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps128404 = nil
			end

			local var_297_8 = arg_294_1.actors_["10183"]
			local var_297_9 = 0

			if var_297_9 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 and not isNil(var_297_8) and arg_294_1.var_.actorSpriteComps10183 == nil then
				arg_294_1.var_.actorSpriteComps10183 = var_297_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_10 = 0.2

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_10 and not isNil(var_297_8) then
				local var_297_11 = (arg_294_1.time_ - var_297_9) / var_297_10

				if arg_294_1.var_.actorSpriteComps10183 then
					for iter_297_4, iter_297_5 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_297_5 then
							if arg_294_1.isInRecall_ then
								local var_297_12 = Mathf.Lerp(iter_297_5.color.r, arg_294_1.hightColor2.r, var_297_11)
								local var_297_13 = Mathf.Lerp(iter_297_5.color.g, arg_294_1.hightColor2.g, var_297_11)
								local var_297_14 = Mathf.Lerp(iter_297_5.color.b, arg_294_1.hightColor2.b, var_297_11)

								iter_297_5.color = Color.New(var_297_12, var_297_13, var_297_14)
							else
								local var_297_15 = Mathf.Lerp(iter_297_5.color.r, 0.5, var_297_11)

								iter_297_5.color = Color.New(var_297_15, var_297_15, var_297_15)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_9 + var_297_10 and arg_294_1.time_ < var_297_9 + var_297_10 + arg_297_0 and not isNil(var_297_8) and arg_294_1.var_.actorSpriteComps10183 then
				for iter_297_6, iter_297_7 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_297_7 then
						if arg_294_1.isInRecall_ then
							iter_297_7.color = arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_297_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps10183 = nil
			end

			local var_297_16 = arg_294_1.actors_["128404"].transform
			local var_297_17 = 0

			if var_297_17 < arg_294_1.time_ and arg_294_1.time_ <= var_297_17 + arg_297_0 then
				arg_294_1.var_.moveOldPos128404 = var_297_16.localPosition
				var_297_16.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("128404", 4)

				local var_297_18 = var_297_16.childCount

				for iter_297_8 = 0, var_297_18 - 1 do
					local var_297_19 = var_297_16:GetChild(iter_297_8)

					if var_297_19.name == "split_2" or not string.find(var_297_19.name, "split") then
						var_297_19.gameObject:SetActive(true)
					else
						var_297_19.gameObject:SetActive(false)
					end
				end
			end

			local var_297_20 = 0.001

			if var_297_17 <= arg_294_1.time_ and arg_294_1.time_ < var_297_17 + var_297_20 then
				local var_297_21 = (arg_294_1.time_ - var_297_17) / var_297_20
				local var_297_22 = Vector3.New(390.2, -356, -362.3)

				var_297_16.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos128404, var_297_22, var_297_21)
			end

			if arg_294_1.time_ >= var_297_17 + var_297_20 and arg_294_1.time_ < var_297_17 + var_297_20 + arg_297_0 then
				var_297_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_297_23 = 0
			local var_297_24 = 0.4

			if var_297_23 < arg_294_1.time_ and arg_294_1.time_ <= var_297_23 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_25 = arg_294_1:FormatText(StoryNameCfg[6].name)

				arg_294_1.leftNameTxt_.text = var_297_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_26 = arg_294_1:GetWordFromCfg(938081071)
				local var_297_27 = arg_294_1:FormatText(var_297_26.content)

				arg_294_1.text_.text = var_297_27

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_28 = 16
				local var_297_29 = utf8.len(var_297_27)
				local var_297_30 = var_297_28 <= 0 and var_297_24 or var_297_24 * (var_297_29 / var_297_28)

				if var_297_30 > 0 and var_297_24 < var_297_30 then
					arg_294_1.talkMaxDuration = var_297_30

					if var_297_30 + var_297_23 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_30 + var_297_23
					end
				end

				arg_294_1.text_.text = var_297_27
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_31 = math.max(var_297_24, arg_294_1.talkMaxDuration)

			if var_297_23 <= arg_294_1.time_ and arg_294_1.time_ < var_297_23 + var_297_31 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_23) / var_297_31

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_23 + var_297_31 and arg_294_1.time_ < var_297_23 + var_297_31 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play938081072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 938081072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play938081073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["128404"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps128404 == nil then
				arg_298_1.var_.actorSpriteComps128404 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps128404 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 0.5, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps128404 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_301_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps128404 = nil
			end

			local var_301_8 = 0
			local var_301_9 = 0.275

			if var_301_8 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_10 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_11 = arg_298_1:GetWordFromCfg(938081072)
				local var_301_12 = arg_298_1:FormatText(var_301_11.content)

				arg_298_1.text_.text = var_301_12

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 11
				local var_301_14 = utf8.len(var_301_12)
				local var_301_15 = var_301_13 <= 0 and var_301_9 or var_301_9 * (var_301_14 / var_301_13)

				if var_301_15 > 0 and var_301_9 < var_301_15 then
					arg_298_1.talkMaxDuration = var_301_15

					if var_301_15 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_15 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_12
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_16 and arg_298_1.time_ < var_301_8 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play938081073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 938081073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play938081074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["106603"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps106603 == nil then
				arg_302_1.var_.actorSpriteComps106603 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps106603 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 1, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps106603 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_305_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps106603 = nil
			end

			local var_305_8 = arg_302_1.actors_["106603"].transform
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				arg_302_1.var_.moveOldPos106603 = var_305_8.localPosition
				var_305_8.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("106603", 4)

				local var_305_10 = var_305_8.childCount

				for iter_305_4 = 0, var_305_10 - 1 do
					local var_305_11 = var_305_8:GetChild(iter_305_4)

					if var_305_11.name == "split_2" or not string.find(var_305_11.name, "split") then
						var_305_11.gameObject:SetActive(true)
					else
						var_305_11.gameObject:SetActive(false)
					end
				end
			end

			local var_305_12 = 0.001

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_12 then
				local var_305_13 = (arg_302_1.time_ - var_305_9) / var_305_12
				local var_305_14 = Vector3.New(453.9, -399.1, -303.3)

				var_305_8.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos106603, var_305_14, var_305_13)
			end

			if arg_302_1.time_ >= var_305_9 + var_305_12 and arg_302_1.time_ < var_305_9 + var_305_12 + arg_305_0 then
				var_305_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_305_15 = arg_302_1.actors_["128404"].transform
			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.var_.moveOldPos128404 = var_305_15.localPosition
				var_305_15.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("128404", 7)

				local var_305_17 = var_305_15.childCount

				for iter_305_5 = 0, var_305_17 - 1 do
					local var_305_18 = var_305_15:GetChild(iter_305_5)

					if var_305_18.name == "" or not string.find(var_305_18.name, "split") then
						var_305_18.gameObject:SetActive(true)
					else
						var_305_18.gameObject:SetActive(false)
					end
				end
			end

			local var_305_19 = 0.001

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_19 then
				local var_305_20 = (arg_302_1.time_ - var_305_16) / var_305_19
				local var_305_21 = Vector3.New(0, -2000, 0)

				var_305_15.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos128404, var_305_21, var_305_20)
			end

			if arg_302_1.time_ >= var_305_16 + var_305_19 and arg_302_1.time_ < var_305_16 + var_305_19 + arg_305_0 then
				var_305_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_305_22 = 0
			local var_305_23 = 0.225

			if var_305_22 < arg_302_1.time_ and arg_302_1.time_ <= var_305_22 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_24 = arg_302_1:FormatText(StoryNameCfg[32].name)

				arg_302_1.leftNameTxt_.text = var_305_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_25 = arg_302_1:GetWordFromCfg(938081073)
				local var_305_26 = arg_302_1:FormatText(var_305_25.content)

				arg_302_1.text_.text = var_305_26

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_27 = 9
				local var_305_28 = utf8.len(var_305_26)
				local var_305_29 = var_305_27 <= 0 and var_305_23 or var_305_23 * (var_305_28 / var_305_27)

				if var_305_29 > 0 and var_305_23 < var_305_29 then
					arg_302_1.talkMaxDuration = var_305_29

					if var_305_29 + var_305_22 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_29 + var_305_22
					end
				end

				arg_302_1.text_.text = var_305_26
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_30 = math.max(var_305_23, arg_302_1.talkMaxDuration)

			if var_305_22 <= arg_302_1.time_ and arg_302_1.time_ < var_305_22 + var_305_30 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_22) / var_305_30

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_22 + var_305_30 and arg_302_1.time_ < var_305_22 + var_305_30 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play938081074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938081074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938081075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10183"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps10183 == nil then
				arg_306_1.var_.actorSpriteComps10183 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps10183 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 1, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps10183 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps10183 = nil
			end

			local var_309_8 = arg_306_1.actors_["106603"]
			local var_309_9 = 0

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps106603 == nil then
				arg_306_1.var_.actorSpriteComps106603 = var_309_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_10 = 0.2

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_10 and not isNil(var_309_8) then
				local var_309_11 = (arg_306_1.time_ - var_309_9) / var_309_10

				if arg_306_1.var_.actorSpriteComps106603 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								local var_309_12 = Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, var_309_11)
								local var_309_13 = Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, var_309_11)
								local var_309_14 = Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, var_309_11)

								iter_309_5.color = Color.New(var_309_12, var_309_13, var_309_14)
							else
								local var_309_15 = Mathf.Lerp(iter_309_5.color.r, 0.5, var_309_11)

								iter_309_5.color = Color.New(var_309_15, var_309_15, var_309_15)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_9 + var_309_10 and arg_306_1.time_ < var_309_9 + var_309_10 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps106603 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_309_7 then
						if arg_306_1.isInRecall_ then
							iter_309_7.color = arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_309_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps106603 = nil
			end

			local var_309_16 = arg_306_1.actors_["10183"].transform
			local var_309_17 = 0

			if var_309_17 < arg_306_1.time_ and arg_306_1.time_ <= var_309_17 + arg_309_0 then
				arg_306_1.var_.moveOldPos10183 = var_309_16.localPosition
				var_309_16.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10183", 2)

				local var_309_18 = var_309_16.childCount

				for iter_309_8 = 0, var_309_18 - 1 do
					local var_309_19 = var_309_16:GetChild(iter_309_8)

					if var_309_19.name == "split_3" then
						var_309_19:SetAsLastSibling()
						var_309_19.gameObject:SetActive(true)

						arg_306_1.var_.actorSpriteSplit10183 = var_309_19.gameObject:GetComponent(typeof(Image))

						arg_306_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_309_20 = 0.5

			if var_309_17 <= arg_306_1.time_ and arg_306_1.time_ < var_309_17 + var_309_20 then
				local var_309_21 = (arg_306_1.time_ - var_309_17) / var_309_20
				local var_309_22 = Vector3.New(-300, -475, -325)

				var_309_16.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10183, var_309_22, var_309_21)

				if arg_306_1.var_.actorSpriteSplit10183 ~= nil then
					arg_306_1.var_.actorSpriteSplit10183:SetAlpha(var_309_21)
				end
			end

			if arg_306_1.time_ >= var_309_17 + var_309_20 and arg_306_1.time_ < var_309_17 + var_309_20 + arg_309_0 then
				var_309_16.localPosition = Vector3.New(-300, -475, -325)

				if arg_306_1.var_.actorSpriteSplit10183 ~= nil then
					arg_306_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_309_23 = 0
			local var_309_24 = 0.225

			if var_309_23 < arg_306_1.time_ and arg_306_1.time_ <= var_309_23 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_25 = arg_306_1:FormatText(StoryNameCfg[1332].name)

				arg_306_1.leftNameTxt_.text = var_309_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_26 = arg_306_1:GetWordFromCfg(938081074)
				local var_309_27 = arg_306_1:FormatText(var_309_26.content)

				arg_306_1.text_.text = var_309_27

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_28 = 9
				local var_309_29 = utf8.len(var_309_27)
				local var_309_30 = var_309_28 <= 0 and var_309_24 or var_309_24 * (var_309_29 / var_309_28)

				if var_309_30 > 0 and var_309_24 < var_309_30 then
					arg_306_1.talkMaxDuration = var_309_30

					if var_309_30 + var_309_23 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_30 + var_309_23
					end
				end

				arg_306_1.text_.text = var_309_27
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_31 = math.max(var_309_24, arg_306_1.talkMaxDuration)

			if var_309_23 <= arg_306_1.time_ and arg_306_1.time_ < var_309_23 + var_309_31 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_23) / var_309_31

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_23 + var_309_31 and arg_306_1.time_ < var_309_23 + var_309_31 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play938081075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938081075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938081076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10183"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10183 == nil then
				arg_310_1.var_.actorSpriteComps10183 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps10183 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 0.5, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10183 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10183 = nil
			end

			local var_313_8 = 0
			local var_313_9 = 0.6

			if var_313_8 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_10 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_11 = arg_310_1:GetWordFromCfg(938081075)
				local var_313_12 = arg_310_1:FormatText(var_313_11.content)

				arg_310_1.text_.text = var_313_12

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 24
				local var_313_14 = utf8.len(var_313_12)
				local var_313_15 = var_313_13 <= 0 and var_313_9 or var_313_9 * (var_313_14 / var_313_13)

				if var_313_15 > 0 and var_313_9 < var_313_15 then
					arg_310_1.talkMaxDuration = var_313_15

					if var_313_15 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_15 + var_313_8
					end
				end

				arg_310_1.text_.text = var_313_12
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_9, arg_310_1.talkMaxDuration)

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_8) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_8 + var_313_16 and arg_310_1.time_ < var_313_8 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938081076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938081076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938081077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10183"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10183 == nil then
				arg_314_1.var_.actorSpriteComps10183 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps10183 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 1, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10183 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10183 = nil
			end

			local var_317_8 = arg_314_1.actors_["10183"].transform
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 then
				arg_314_1.var_.moveOldPos10183 = var_317_8.localPosition
				var_317_8.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10183", 2)

				local var_317_10 = var_317_8.childCount

				for iter_317_4 = 0, var_317_10 - 1 do
					local var_317_11 = var_317_8:GetChild(iter_317_4)

					if var_317_11.name == "split_1" then
						var_317_11:SetAsLastSibling()
						var_317_11.gameObject:SetActive(true)

						arg_314_1.var_.actorSpriteSplit10183 = var_317_11.gameObject:GetComponent(typeof(Image))

						arg_314_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_317_12 = 0.5

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_12 then
				local var_317_13 = (arg_314_1.time_ - var_317_9) / var_317_12
				local var_317_14 = Vector3.New(-300, -475, -325)

				var_317_8.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10183, var_317_14, var_317_13)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(var_317_13)
				end
			end

			if arg_314_1.time_ >= var_317_9 + var_317_12 and arg_314_1.time_ < var_317_9 + var_317_12 + arg_317_0 then
				var_317_8.localPosition = Vector3.New(-300, -475, -325)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_317_15 = 0
			local var_317_16 = 0.525

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_17 = arg_314_1:FormatText(StoryNameCfg[1562].name)

				arg_314_1.leftNameTxt_.text = var_317_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_18 = arg_314_1:GetWordFromCfg(938081076)
				local var_317_19 = arg_314_1:FormatText(var_317_18.content)

				arg_314_1.text_.text = var_317_19

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_20 = 21
				local var_317_21 = utf8.len(var_317_19)
				local var_317_22 = var_317_20 <= 0 and var_317_16 or var_317_16 * (var_317_21 / var_317_20)

				if var_317_22 > 0 and var_317_16 < var_317_22 then
					arg_314_1.talkMaxDuration = var_317_22

					if var_317_22 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_22 + var_317_15
					end
				end

				arg_314_1.text_.text = var_317_19
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_23 = math.max(var_317_16, arg_314_1.talkMaxDuration)

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_23 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_15) / var_317_23

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_15 + var_317_23 and arg_314_1.time_ < var_317_15 + var_317_23 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play938081077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938081077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play938081078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["10183"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps10183 == nil then
				arg_318_1.var_.actorSpriteComps10183 = var_321_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_2 = 0.2

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.actorSpriteComps10183 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								local var_321_4 = Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor2.r, var_321_3)
								local var_321_5 = Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor2.g, var_321_3)
								local var_321_6 = Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor2.b, var_321_3)

								iter_321_1.color = Color.New(var_321_4, var_321_5, var_321_6)
							else
								local var_321_7 = Mathf.Lerp(iter_321_1.color.r, 0.5, var_321_3)

								iter_321_1.color = Color.New(var_321_7, var_321_7, var_321_7)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.actorSpriteComps10183 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_321_3 then
						if arg_318_1.isInRecall_ then
							iter_321_3.color = arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_321_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_318_1.var_.actorSpriteComps10183 = nil
			end

			local var_321_8 = 0
			local var_321_9 = 0.375

			if var_321_8 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_10 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_11 = arg_318_1:GetWordFromCfg(938081077)
				local var_321_12 = arg_318_1:FormatText(var_321_11.content)

				arg_318_1.text_.text = var_321_12

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 15
				local var_321_14 = utf8.len(var_321_12)
				local var_321_15 = var_321_13 <= 0 and var_321_9 or var_321_9 * (var_321_14 / var_321_13)

				if var_321_15 > 0 and var_321_9 < var_321_15 then
					arg_318_1.talkMaxDuration = var_321_15

					if var_321_15 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_8
					end
				end

				arg_318_1.text_.text = var_321_12
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_9, arg_318_1.talkMaxDuration)

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_8) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_8 + var_321_16 and arg_318_1.time_ < var_321_8 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play938081078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 938081078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play938081079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10183"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10183 == nil then
				arg_322_1.var_.actorSpriteComps10183 = var_325_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_2 = 0.2

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.actorSpriteComps10183 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								local var_325_4 = Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, var_325_3)
								local var_325_5 = Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, var_325_3)
								local var_325_6 = Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, var_325_3)

								iter_325_1.color = Color.New(var_325_4, var_325_5, var_325_6)
							else
								local var_325_7 = Mathf.Lerp(iter_325_1.color.r, 1, var_325_3)

								iter_325_1.color = Color.New(var_325_7, var_325_7, var_325_7)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.actorSpriteComps10183 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_325_3 then
						if arg_322_1.isInRecall_ then
							iter_325_3.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_325_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps10183 = nil
			end

			local var_325_8 = arg_322_1.actors_["10183"].transform
			local var_325_9 = 0

			if var_325_9 < arg_322_1.time_ and arg_322_1.time_ <= var_325_9 + arg_325_0 then
				arg_322_1.var_.moveOldPos10183 = var_325_8.localPosition
				var_325_8.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10183", 2)

				local var_325_10 = var_325_8.childCount

				for iter_325_4 = 0, var_325_10 - 1 do
					local var_325_11 = var_325_8:GetChild(iter_325_4)

					if var_325_11.name == "split_7" then
						var_325_11:SetAsLastSibling()
						var_325_11.gameObject:SetActive(true)

						arg_322_1.var_.actorSpriteSplit10183 = var_325_11.gameObject:GetComponent(typeof(Image))

						arg_322_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_325_12 = 0.5

			if var_325_9 <= arg_322_1.time_ and arg_322_1.time_ < var_325_9 + var_325_12 then
				local var_325_13 = (arg_322_1.time_ - var_325_9) / var_325_12
				local var_325_14 = Vector3.New(-300, -475, -325)

				var_325_8.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10183, var_325_14, var_325_13)

				if arg_322_1.var_.actorSpriteSplit10183 ~= nil then
					arg_322_1.var_.actorSpriteSplit10183:SetAlpha(var_325_13)
				end
			end

			if arg_322_1.time_ >= var_325_9 + var_325_12 and arg_322_1.time_ < var_325_9 + var_325_12 + arg_325_0 then
				var_325_8.localPosition = Vector3.New(-300, -475, -325)

				if arg_322_1.var_.actorSpriteSplit10183 ~= nil then
					arg_322_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_325_15 = 0
			local var_325_16 = 1.45

			if var_325_15 < arg_322_1.time_ and arg_322_1.time_ <= var_325_15 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_17 = arg_322_1:FormatText(StoryNameCfg[1562].name)

				arg_322_1.leftNameTxt_.text = var_325_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_18 = arg_322_1:GetWordFromCfg(938081078)
				local var_325_19 = arg_322_1:FormatText(var_325_18.content)

				arg_322_1.text_.text = var_325_19

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_20 = 58
				local var_325_21 = utf8.len(var_325_19)
				local var_325_22 = var_325_20 <= 0 and var_325_16 or var_325_16 * (var_325_21 / var_325_20)

				if var_325_22 > 0 and var_325_16 < var_325_22 then
					arg_322_1.talkMaxDuration = var_325_22

					if var_325_22 + var_325_15 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_22 + var_325_15
					end
				end

				arg_322_1.text_.text = var_325_19
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_23 = math.max(var_325_16, arg_322_1.talkMaxDuration)

			if var_325_15 <= arg_322_1.time_ and arg_322_1.time_ < var_325_15 + var_325_23 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_15) / var_325_23

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_15 + var_325_23 and arg_322_1.time_ < var_325_15 + var_325_23 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play938081079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 938081079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play938081080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10183"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10183 == nil then
				arg_326_1.var_.actorSpriteComps10183 = var_329_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_2 = 0.2

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.actorSpriteComps10183 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								local var_329_4 = Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, var_329_3)
								local var_329_5 = Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, var_329_3)
								local var_329_6 = Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, var_329_3)

								iter_329_1.color = Color.New(var_329_4, var_329_5, var_329_6)
							else
								local var_329_7 = Mathf.Lerp(iter_329_1.color.r, 0.5, var_329_3)

								iter_329_1.color = Color.New(var_329_7, var_329_7, var_329_7)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.actorSpriteComps10183 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_329_3 then
						if arg_326_1.isInRecall_ then
							iter_329_3.color = arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_329_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_326_1.var_.actorSpriteComps10183 = nil
			end

			local var_329_8 = 0
			local var_329_9 = 0.575

			if var_329_8 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_10 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_11 = arg_326_1:GetWordFromCfg(938081079)
				local var_329_12 = arg_326_1:FormatText(var_329_11.content)

				arg_326_1.text_.text = var_329_12

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_13 = 23
				local var_329_14 = utf8.len(var_329_12)
				local var_329_15 = var_329_13 <= 0 and var_329_9 or var_329_9 * (var_329_14 / var_329_13)

				if var_329_15 > 0 and var_329_9 < var_329_15 then
					arg_326_1.talkMaxDuration = var_329_15

					if var_329_15 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_15 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_12
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_16 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_16 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_16

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_16 and arg_326_1.time_ < var_329_8 + var_329_16 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play938081080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 938081080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play938081081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["128404"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps128404 == nil then
				arg_330_1.var_.actorSpriteComps128404 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps128404 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 1, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps128404 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps128404 = nil
			end

			local var_333_8 = arg_330_1.actors_["128404"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos128404 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("128404", 4)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "split_2" or not string.find(var_333_11.name, "split") then
						var_333_11.gameObject:SetActive(true)
					else
						var_333_11.gameObject:SetActive(false)
					end
				end
			end

			local var_333_12 = 0.001

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(390.2, -356, -362.3)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos128404, var_333_14, var_333_13)
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_333_15 = arg_330_1.actors_["106603"].transform
			local var_333_16 = 0

			if var_333_16 < arg_330_1.time_ and arg_330_1.time_ <= var_333_16 + arg_333_0 then
				arg_330_1.var_.moveOldPos106603 = var_333_15.localPosition
				var_333_15.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("106603", 7)

				local var_333_17 = var_333_15.childCount

				for iter_333_5 = 0, var_333_17 - 1 do
					local var_333_18 = var_333_15:GetChild(iter_333_5)

					if var_333_18.name == "" or not string.find(var_333_18.name, "split") then
						var_333_18.gameObject:SetActive(true)
					else
						var_333_18.gameObject:SetActive(false)
					end
				end
			end

			local var_333_19 = 0.001

			if var_333_16 <= arg_330_1.time_ and arg_330_1.time_ < var_333_16 + var_333_19 then
				local var_333_20 = (arg_330_1.time_ - var_333_16) / var_333_19
				local var_333_21 = Vector3.New(0, -2000, 0)

				var_333_15.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos106603, var_333_21, var_333_20)
			end

			if arg_330_1.time_ >= var_333_16 + var_333_19 and arg_330_1.time_ < var_333_16 + var_333_19 + arg_333_0 then
				var_333_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_333_22 = 0
			local var_333_23 = 0.2

			if var_333_22 < arg_330_1.time_ and arg_330_1.time_ <= var_333_22 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_24 = arg_330_1:FormatText(StoryNameCfg[6].name)

				arg_330_1.leftNameTxt_.text = var_333_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_25 = arg_330_1:GetWordFromCfg(938081080)
				local var_333_26 = arg_330_1:FormatText(var_333_25.content)

				arg_330_1.text_.text = var_333_26

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_27 = 8
				local var_333_28 = utf8.len(var_333_26)
				local var_333_29 = var_333_27 <= 0 and var_333_23 or var_333_23 * (var_333_28 / var_333_27)

				if var_333_29 > 0 and var_333_23 < var_333_29 then
					arg_330_1.talkMaxDuration = var_333_29

					if var_333_29 + var_333_22 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_29 + var_333_22
					end
				end

				arg_330_1.text_.text = var_333_26
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_30 = math.max(var_333_23, arg_330_1.talkMaxDuration)

			if var_333_22 <= arg_330_1.time_ and arg_330_1.time_ < var_333_22 + var_333_30 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_22) / var_333_30

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_22 + var_333_30 and arg_330_1.time_ < var_333_22 + var_333_30 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play938081081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 938081081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play938081082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["108301"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps108301 == nil then
				arg_334_1.var_.actorSpriteComps108301 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps108301 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 1, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps108301 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_337_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps108301 = nil
			end

			local var_337_8 = arg_334_1.actors_["128404"]
			local var_337_9 = 0

			if var_337_9 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps128404 == nil then
				arg_334_1.var_.actorSpriteComps128404 = var_337_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_10 = 0.2

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_10 and not isNil(var_337_8) then
				local var_337_11 = (arg_334_1.time_ - var_337_9) / var_337_10

				if arg_334_1.var_.actorSpriteComps128404 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								local var_337_12 = Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor2.r, var_337_11)
								local var_337_13 = Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor2.g, var_337_11)
								local var_337_14 = Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor2.b, var_337_11)

								iter_337_5.color = Color.New(var_337_12, var_337_13, var_337_14)
							else
								local var_337_15 = Mathf.Lerp(iter_337_5.color.r, 0.5, var_337_11)

								iter_337_5.color = Color.New(var_337_15, var_337_15, var_337_15)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_9 + var_337_10 and arg_334_1.time_ < var_337_9 + var_337_10 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps128404 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_337_7 then
						if arg_334_1.isInRecall_ then
							iter_337_7.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps128404 = nil
			end

			local var_337_16 = arg_334_1.actors_["108301"].transform
			local var_337_17 = 0

			if var_337_17 < arg_334_1.time_ and arg_334_1.time_ <= var_337_17 + arg_337_0 then
				arg_334_1.var_.moveOldPos108301 = var_337_16.localPosition
				var_337_16.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("108301", 2)

				local var_337_18 = var_337_16.childCount

				for iter_337_8 = 0, var_337_18 - 1 do
					local var_337_19 = var_337_16:GetChild(iter_337_8)

					if var_337_19.name == "split_5" or not string.find(var_337_19.name, "split") then
						var_337_19.gameObject:SetActive(true)
					else
						var_337_19.gameObject:SetActive(false)
					end
				end
			end

			local var_337_20 = 0.001

			if var_337_17 <= arg_334_1.time_ and arg_334_1.time_ < var_337_17 + var_337_20 then
				local var_337_21 = (arg_334_1.time_ - var_337_17) / var_337_20
				local var_337_22 = Vector3.New(-420, -360, -195)

				var_337_16.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos108301, var_337_22, var_337_21)
			end

			if arg_334_1.time_ >= var_337_17 + var_337_20 and arg_334_1.time_ < var_337_17 + var_337_20 + arg_337_0 then
				var_337_16.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_337_23 = arg_334_1.actors_["10183"].transform
			local var_337_24 = 0

			if var_337_24 < arg_334_1.time_ and arg_334_1.time_ <= var_337_24 + arg_337_0 then
				arg_334_1.var_.moveOldPos10183 = var_337_23.localPosition
				var_337_23.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10183", 7)

				local var_337_25 = var_337_23.childCount

				for iter_337_9 = 0, var_337_25 - 1 do
					local var_337_26 = var_337_23:GetChild(iter_337_9)

					if var_337_26.name == "" or not string.find(var_337_26.name, "split") then
						var_337_26.gameObject:SetActive(true)
					else
						var_337_26.gameObject:SetActive(false)
					end
				end
			end

			local var_337_27 = 0.001

			if var_337_24 <= arg_334_1.time_ and arg_334_1.time_ < var_337_24 + var_337_27 then
				local var_337_28 = (arg_334_1.time_ - var_337_24) / var_337_27
				local var_337_29 = Vector3.New(0, -2000, 0)

				var_337_23.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10183, var_337_29, var_337_28)
			end

			if arg_334_1.time_ >= var_337_24 + var_337_27 and arg_334_1.time_ < var_337_24 + var_337_27 + arg_337_0 then
				var_337_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_337_30 = 0
			local var_337_31 = 0.2

			if var_337_30 < arg_334_1.time_ and arg_334_1.time_ <= var_337_30 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_32 = arg_334_1:FormatText(StoryNameCfg[1332].name)

				arg_334_1.leftNameTxt_.text = var_337_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_33 = arg_334_1:GetWordFromCfg(938081081)
				local var_337_34 = arg_334_1:FormatText(var_337_33.content)

				arg_334_1.text_.text = var_337_34

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_35 = 8
				local var_337_36 = utf8.len(var_337_34)
				local var_337_37 = var_337_35 <= 0 and var_337_31 or var_337_31 * (var_337_36 / var_337_35)

				if var_337_37 > 0 and var_337_31 < var_337_37 then
					arg_334_1.talkMaxDuration = var_337_37

					if var_337_37 + var_337_30 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_37 + var_337_30
					end
				end

				arg_334_1.text_.text = var_337_34
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_38 = math.max(var_337_31, arg_334_1.talkMaxDuration)

			if var_337_30 <= arg_334_1.time_ and arg_334_1.time_ < var_337_30 + var_337_38 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_30) / var_337_38

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_30 + var_337_38 and arg_334_1.time_ < var_337_30 + var_337_38 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play938081082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938081082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938081083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["106603"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps106603 == nil then
				arg_338_1.var_.actorSpriteComps106603 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps106603 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps106603 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps106603 = nil
			end

			local var_341_8 = arg_338_1.actors_["108301"]
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 and not isNil(var_341_8) and arg_338_1.var_.actorSpriteComps108301 == nil then
				arg_338_1.var_.actorSpriteComps108301 = var_341_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_10 = 0.2

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_10 and not isNil(var_341_8) then
				local var_341_11 = (arg_338_1.time_ - var_341_9) / var_341_10

				if arg_338_1.var_.actorSpriteComps108301 then
					for iter_341_4, iter_341_5 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_341_5 then
							if arg_338_1.isInRecall_ then
								local var_341_12 = Mathf.Lerp(iter_341_5.color.r, arg_338_1.hightColor2.r, var_341_11)
								local var_341_13 = Mathf.Lerp(iter_341_5.color.g, arg_338_1.hightColor2.g, var_341_11)
								local var_341_14 = Mathf.Lerp(iter_341_5.color.b, arg_338_1.hightColor2.b, var_341_11)

								iter_341_5.color = Color.New(var_341_12, var_341_13, var_341_14)
							else
								local var_341_15 = Mathf.Lerp(iter_341_5.color.r, 0.5, var_341_11)

								iter_341_5.color = Color.New(var_341_15, var_341_15, var_341_15)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_9 + var_341_10 and arg_338_1.time_ < var_341_9 + var_341_10 + arg_341_0 and not isNil(var_341_8) and arg_338_1.var_.actorSpriteComps108301 then
				for iter_341_6, iter_341_7 in pairs(arg_338_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_341_7 then
						if arg_338_1.isInRecall_ then
							iter_341_7.color = arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_341_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps108301 = nil
			end

			local var_341_16 = arg_338_1.actors_["106603"].transform
			local var_341_17 = 0

			if var_341_17 < arg_338_1.time_ and arg_338_1.time_ <= var_341_17 + arg_341_0 then
				arg_338_1.var_.moveOldPos106603 = var_341_16.localPosition
				var_341_16.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("106603", 4)

				local var_341_18 = var_341_16.childCount

				for iter_341_8 = 0, var_341_18 - 1 do
					local var_341_19 = var_341_16:GetChild(iter_341_8)

					if var_341_19.name == "split_4" or not string.find(var_341_19.name, "split") then
						var_341_19.gameObject:SetActive(true)
					else
						var_341_19.gameObject:SetActive(false)
					end
				end
			end

			local var_341_20 = 0.001

			if var_341_17 <= arg_338_1.time_ and arg_338_1.time_ < var_341_17 + var_341_20 then
				local var_341_21 = (arg_338_1.time_ - var_341_17) / var_341_20
				local var_341_22 = Vector3.New(453.9, -399.1, -303.3)

				var_341_16.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos106603, var_341_22, var_341_21)
			end

			if arg_338_1.time_ >= var_341_17 + var_341_20 and arg_338_1.time_ < var_341_17 + var_341_20 + arg_341_0 then
				var_341_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_341_23 = arg_338_1.actors_["128404"].transform
			local var_341_24 = 0

			if var_341_24 < arg_338_1.time_ and arg_338_1.time_ <= var_341_24 + arg_341_0 then
				arg_338_1.var_.moveOldPos128404 = var_341_23.localPosition
				var_341_23.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("128404", 7)

				local var_341_25 = var_341_23.childCount

				for iter_341_9 = 0, var_341_25 - 1 do
					local var_341_26 = var_341_23:GetChild(iter_341_9)

					if var_341_26.name == "" or not string.find(var_341_26.name, "split") then
						var_341_26.gameObject:SetActive(true)
					else
						var_341_26.gameObject:SetActive(false)
					end
				end
			end

			local var_341_27 = 0.001

			if var_341_24 <= arg_338_1.time_ and arg_338_1.time_ < var_341_24 + var_341_27 then
				local var_341_28 = (arg_338_1.time_ - var_341_24) / var_341_27
				local var_341_29 = Vector3.New(0, -2000, 0)

				var_341_23.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos128404, var_341_29, var_341_28)
			end

			if arg_338_1.time_ >= var_341_24 + var_341_27 and arg_338_1.time_ < var_341_24 + var_341_27 + arg_341_0 then
				var_341_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_30 = 0
			local var_341_31 = 0.275

			if var_341_30 < arg_338_1.time_ and arg_338_1.time_ <= var_341_30 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_32 = arg_338_1:FormatText(StoryNameCfg[32].name)

				arg_338_1.leftNameTxt_.text = var_341_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_33 = arg_338_1:GetWordFromCfg(938081082)
				local var_341_34 = arg_338_1:FormatText(var_341_33.content)

				arg_338_1.text_.text = var_341_34

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_35 = 11
				local var_341_36 = utf8.len(var_341_34)
				local var_341_37 = var_341_35 <= 0 and var_341_31 or var_341_31 * (var_341_36 / var_341_35)

				if var_341_37 > 0 and var_341_31 < var_341_37 then
					arg_338_1.talkMaxDuration = var_341_37

					if var_341_37 + var_341_30 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_37 + var_341_30
					end
				end

				arg_338_1.text_.text = var_341_34
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_38 = math.max(var_341_31, arg_338_1.talkMaxDuration)

			if var_341_30 <= arg_338_1.time_ and arg_338_1.time_ < var_341_30 + var_341_38 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_30) / var_341_38

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_30 + var_341_38 and arg_338_1.time_ < var_341_30 + var_341_38 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play938081083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938081083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play938081084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10183"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10183 == nil then
				arg_342_1.var_.actorSpriteComps10183 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps10183 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 1, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10183 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_345_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10183 = nil
			end

			local var_345_8 = arg_342_1.actors_["106603"]
			local var_345_9 = 0

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps106603 == nil then
				arg_342_1.var_.actorSpriteComps106603 = var_345_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_10 = 0.2

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_10 and not isNil(var_345_8) then
				local var_345_11 = (arg_342_1.time_ - var_345_9) / var_345_10

				if arg_342_1.var_.actorSpriteComps106603 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								local var_345_12 = Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, var_345_11)
								local var_345_13 = Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, var_345_11)
								local var_345_14 = Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, var_345_11)

								iter_345_5.color = Color.New(var_345_12, var_345_13, var_345_14)
							else
								local var_345_15 = Mathf.Lerp(iter_345_5.color.r, 0.5, var_345_11)

								iter_345_5.color = Color.New(var_345_15, var_345_15, var_345_15)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_9 + var_345_10 and arg_342_1.time_ < var_345_9 + var_345_10 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps106603 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_345_7 then
						if arg_342_1.isInRecall_ then
							iter_345_7.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps106603 = nil
			end

			local var_345_16 = arg_342_1.actors_["10183"].transform
			local var_345_17 = 0

			if var_345_17 < arg_342_1.time_ and arg_342_1.time_ <= var_345_17 + arg_345_0 then
				arg_342_1.var_.moveOldPos10183 = var_345_16.localPosition
				var_345_16.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10183", 2)

				local var_345_18 = var_345_16.childCount

				for iter_345_8 = 0, var_345_18 - 1 do
					local var_345_19 = var_345_16:GetChild(iter_345_8)

					if var_345_19.name == "split_2" or not string.find(var_345_19.name, "split") then
						var_345_19.gameObject:SetActive(true)
					else
						var_345_19.gameObject:SetActive(false)
					end
				end
			end

			local var_345_20 = 0.001

			if var_345_17 <= arg_342_1.time_ and arg_342_1.time_ < var_345_17 + var_345_20 then
				local var_345_21 = (arg_342_1.time_ - var_345_17) / var_345_20
				local var_345_22 = Vector3.New(-300, -475, -325)

				var_345_16.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10183, var_345_22, var_345_21)
			end

			if arg_342_1.time_ >= var_345_17 + var_345_20 and arg_342_1.time_ < var_345_17 + var_345_20 + arg_345_0 then
				var_345_16.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_345_23 = arg_342_1.actors_["108301"].transform
			local var_345_24 = 0

			if var_345_24 < arg_342_1.time_ and arg_342_1.time_ <= var_345_24 + arg_345_0 then
				arg_342_1.var_.moveOldPos108301 = var_345_23.localPosition
				var_345_23.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("108301", 7)

				local var_345_25 = var_345_23.childCount

				for iter_345_9 = 0, var_345_25 - 1 do
					local var_345_26 = var_345_23:GetChild(iter_345_9)

					if var_345_26.name == "" or not string.find(var_345_26.name, "split") then
						var_345_26.gameObject:SetActive(true)
					else
						var_345_26.gameObject:SetActive(false)
					end
				end
			end

			local var_345_27 = 0.001

			if var_345_24 <= arg_342_1.time_ and arg_342_1.time_ < var_345_24 + var_345_27 then
				local var_345_28 = (arg_342_1.time_ - var_345_24) / var_345_27
				local var_345_29 = Vector3.New(0, -2000, 0)

				var_345_23.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos108301, var_345_29, var_345_28)
			end

			if arg_342_1.time_ >= var_345_24 + var_345_27 and arg_342_1.time_ < var_345_24 + var_345_27 + arg_345_0 then
				var_345_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_345_30 = 0
			local var_345_31 = 0.4

			if var_345_30 < arg_342_1.time_ and arg_342_1.time_ <= var_345_30 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_32 = arg_342_1:FormatText(StoryNameCfg[1562].name)

				arg_342_1.leftNameTxt_.text = var_345_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_33 = arg_342_1:GetWordFromCfg(938081083)
				local var_345_34 = arg_342_1:FormatText(var_345_33.content)

				arg_342_1.text_.text = var_345_34

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_35 = 16
				local var_345_36 = utf8.len(var_345_34)
				local var_345_37 = var_345_35 <= 0 and var_345_31 or var_345_31 * (var_345_36 / var_345_35)

				if var_345_37 > 0 and var_345_31 < var_345_37 then
					arg_342_1.talkMaxDuration = var_345_37

					if var_345_37 + var_345_30 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_37 + var_345_30
					end
				end

				arg_342_1.text_.text = var_345_34
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_38 = math.max(var_345_31, arg_342_1.talkMaxDuration)

			if var_345_30 <= arg_342_1.time_ and arg_342_1.time_ < var_345_30 + var_345_38 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_30) / var_345_38

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_30 + var_345_38 and arg_342_1.time_ < var_345_30 + var_345_38 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play938081084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 938081084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play938081085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10183"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10183 == nil then
				arg_346_1.var_.actorSpriteComps10183 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.2

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps10183 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor2.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor2.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor2.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 0.5, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10183 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_349_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps10183 = nil
			end

			local var_349_8 = arg_346_1.actors_["10183"].transform
			local var_349_9 = 0

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.var_.moveOldPos10183 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10183", 7)

				local var_349_10 = var_349_8.childCount

				for iter_349_4 = 0, var_349_10 - 1 do
					local var_349_11 = var_349_8:GetChild(iter_349_4)

					if var_349_11.name == "" or not string.find(var_349_11.name, "split") then
						var_349_11.gameObject:SetActive(true)
					else
						var_349_11.gameObject:SetActive(false)
					end
				end
			end

			local var_349_12 = 0.001

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_9) / var_349_12
				local var_349_14 = Vector3.New(0, -2000, 0)

				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10183, var_349_14, var_349_13)
			end

			if arg_346_1.time_ >= var_349_9 + var_349_12 and arg_346_1.time_ < var_349_9 + var_349_12 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_15 = arg_346_1.actors_["106603"].transform
			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 then
				arg_346_1.var_.moveOldPos106603 = var_349_15.localPosition
				var_349_15.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("106603", 7)

				local var_349_17 = var_349_15.childCount

				for iter_349_5 = 0, var_349_17 - 1 do
					local var_349_18 = var_349_15:GetChild(iter_349_5)

					if var_349_18.name == "" or not string.find(var_349_18.name, "split") then
						var_349_18.gameObject:SetActive(true)
					else
						var_349_18.gameObject:SetActive(false)
					end
				end
			end

			local var_349_19 = 0.001

			if var_349_16 <= arg_346_1.time_ and arg_346_1.time_ < var_349_16 + var_349_19 then
				local var_349_20 = (arg_346_1.time_ - var_349_16) / var_349_19
				local var_349_21 = Vector3.New(0, -2000, 0)

				var_349_15.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos106603, var_349_21, var_349_20)
			end

			if arg_346_1.time_ >= var_349_16 + var_349_19 and arg_346_1.time_ < var_349_16 + var_349_19 + arg_349_0 then
				var_349_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_349_22 = 0
			local var_349_23 = 1.075

			if var_349_22 < arg_346_1.time_ and arg_346_1.time_ <= var_349_22 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_24 = arg_346_1:GetWordFromCfg(938081084)
				local var_349_25 = arg_346_1:FormatText(var_349_24.content)

				arg_346_1.text_.text = var_349_25

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_26 = 43
				local var_349_27 = utf8.len(var_349_25)
				local var_349_28 = var_349_26 <= 0 and var_349_23 or var_349_23 * (var_349_27 / var_349_26)

				if var_349_28 > 0 and var_349_23 < var_349_28 then
					arg_346_1.talkMaxDuration = var_349_28

					if var_349_28 + var_349_22 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_28 + var_349_22
					end
				end

				arg_346_1.text_.text = var_349_25
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_29 = math.max(var_349_23, arg_346_1.talkMaxDuration)

			if var_349_22 <= arg_346_1.time_ and arg_346_1.time_ < var_349_22 + var_349_29 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_22) / var_349_29

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_22 + var_349_29 and arg_346_1.time_ < var_349_22 + var_349_29 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play938081085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 938081085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play938081086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["106603"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps106603 == nil then
				arg_350_1.var_.actorSpriteComps106603 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps106603 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 1, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps106603 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps106603 = nil
			end

			local var_353_8 = arg_350_1.actors_["106603"].transform
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.var_.moveOldPos106603 = var_353_8.localPosition
				var_353_8.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("106603", 2)

				local var_353_10 = var_353_8.childCount

				for iter_353_4 = 0, var_353_10 - 1 do
					local var_353_11 = var_353_8:GetChild(iter_353_4)

					if var_353_11.name == "split_4" or not string.find(var_353_11.name, "split") then
						var_353_11.gameObject:SetActive(true)
					else
						var_353_11.gameObject:SetActive(false)
					end
				end
			end

			local var_353_12 = 0.001

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_12 then
				local var_353_13 = (arg_350_1.time_ - var_353_9) / var_353_12
				local var_353_14 = Vector3.New(-510.9, -399.1, -303.3)

				var_353_8.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos106603, var_353_14, var_353_13)
			end

			if arg_350_1.time_ >= var_353_9 + var_353_12 and arg_350_1.time_ < var_353_9 + var_353_12 + arg_353_0 then
				var_353_8.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_353_15 = 0
			local var_353_16 = 0.575

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[32].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(938081085)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 23
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_23 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_23 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_23

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_23 and arg_350_1.time_ < var_353_15 + var_353_23 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play938081086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 938081086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play938081087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["106603"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps106603 == nil then
				arg_354_1.var_.actorSpriteComps106603 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps106603 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 0.5, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps106603 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_357_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps106603 = nil
			end

			local var_357_8 = 0
			local var_357_9 = 0.65

			if var_357_8 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_10 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_11 = arg_354_1:GetWordFromCfg(938081086)
				local var_357_12 = arg_354_1:FormatText(var_357_11.content)

				arg_354_1.text_.text = var_357_12

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_13 = 26
				local var_357_14 = utf8.len(var_357_12)
				local var_357_15 = var_357_13 <= 0 and var_357_9 or var_357_9 * (var_357_14 / var_357_13)

				if var_357_15 > 0 and var_357_9 < var_357_15 then
					arg_354_1.talkMaxDuration = var_357_15

					if var_357_15 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_15 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_12
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_8 <= arg_354_1.time_ and arg_354_1.time_ < var_357_8 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_8) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_8 + var_357_16 and arg_354_1.time_ < var_357_8 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play938081087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 938081087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play938081088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["10183"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps10183 == nil then
				arg_358_1.var_.actorSpriteComps10183 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps10183 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 1, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps10183 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_361_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps10183 = nil
			end

			local var_361_8 = arg_358_1.actors_["10183"].transform
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 then
				arg_358_1.var_.moveOldPos10183 = var_361_8.localPosition
				var_361_8.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10183", 4)

				local var_361_10 = var_361_8.childCount

				for iter_361_4 = 0, var_361_10 - 1 do
					local var_361_11 = var_361_8:GetChild(iter_361_4)

					if var_361_11.name == "split_1" or not string.find(var_361_11.name, "split") then
						var_361_11.gameObject:SetActive(true)
					else
						var_361_11.gameObject:SetActive(false)
					end
				end
			end

			local var_361_12 = 0.001

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_12 then
				local var_361_13 = (arg_358_1.time_ - var_361_9) / var_361_12
				local var_361_14 = Vector3.New(300, -475, -325)

				var_361_8.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10183, var_361_14, var_361_13)
			end

			if arg_358_1.time_ >= var_361_9 + var_361_12 and arg_358_1.time_ < var_361_9 + var_361_12 + arg_361_0 then
				var_361_8.localPosition = Vector3.New(300, -475, -325)
			end

			local var_361_15 = 0
			local var_361_16 = 0.725

			if var_361_15 < arg_358_1.time_ and arg_358_1.time_ <= var_361_15 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_17 = arg_358_1:FormatText(StoryNameCfg[1562].name)

				arg_358_1.leftNameTxt_.text = var_361_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_18 = arg_358_1:GetWordFromCfg(938081087)
				local var_361_19 = arg_358_1:FormatText(var_361_18.content)

				arg_358_1.text_.text = var_361_19

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_20 = 29
				local var_361_21 = utf8.len(var_361_19)
				local var_361_22 = var_361_20 <= 0 and var_361_16 or var_361_16 * (var_361_21 / var_361_20)

				if var_361_22 > 0 and var_361_16 < var_361_22 then
					arg_358_1.talkMaxDuration = var_361_22

					if var_361_22 + var_361_15 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_22 + var_361_15
					end
				end

				arg_358_1.text_.text = var_361_19
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_23 = math.max(var_361_16, arg_358_1.talkMaxDuration)

			if var_361_15 <= arg_358_1.time_ and arg_358_1.time_ < var_361_15 + var_361_23 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_15) / var_361_23

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_15 + var_361_23 and arg_358_1.time_ < var_361_15 + var_361_23 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play938081088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 938081088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play938081089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10183"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos10183 = var_365_0.localPosition
				var_365_0.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10183", 4)

				local var_365_2 = var_365_0.childCount

				for iter_365_0 = 0, var_365_2 - 1 do
					local var_365_3 = var_365_0:GetChild(iter_365_0)

					if var_365_3.name == "" or not string.find(var_365_3.name, "split") then
						var_365_3.gameObject:SetActive(true)
					else
						var_365_3.gameObject:SetActive(false)
					end
				end
			end

			local var_365_4 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_4 then
				local var_365_5 = (arg_362_1.time_ - var_365_1) / var_365_4
				local var_365_6 = Vector3.New(300, -475, -325)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10183, var_365_6, var_365_5)
			end

			if arg_362_1.time_ >= var_365_1 + var_365_4 and arg_362_1.time_ < var_365_1 + var_365_4 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(300, -475, -325)
			end

			local var_365_7 = 0
			local var_365_8 = 1.175

			if var_365_7 < arg_362_1.time_ and arg_362_1.time_ <= var_365_7 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_9 = arg_362_1:FormatText(StoryNameCfg[1562].name)

				arg_362_1.leftNameTxt_.text = var_365_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:GetWordFromCfg(938081088)
				local var_365_11 = arg_362_1:FormatText(var_365_10.content)

				arg_362_1.text_.text = var_365_11

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_12 = 47
				local var_365_13 = utf8.len(var_365_11)
				local var_365_14 = var_365_12 <= 0 and var_365_8 or var_365_8 * (var_365_13 / var_365_12)

				if var_365_14 > 0 and var_365_8 < var_365_14 then
					arg_362_1.talkMaxDuration = var_365_14

					if var_365_14 + var_365_7 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_7
					end
				end

				arg_362_1.text_.text = var_365_11
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_15 = math.max(var_365_8, arg_362_1.talkMaxDuration)

			if var_365_7 <= arg_362_1.time_ and arg_362_1.time_ < var_365_7 + var_365_15 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_7) / var_365_15

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_7 + var_365_15 and arg_362_1.time_ < var_365_7 + var_365_15 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play938081089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 938081089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play938081090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10183"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps10183 == nil then
				arg_366_1.var_.actorSpriteComps10183 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.2

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps10183 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								local var_369_4 = Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, var_369_3)
								local var_369_5 = Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, var_369_3)
								local var_369_6 = Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, var_369_3)

								iter_369_1.color = Color.New(var_369_4, var_369_5, var_369_6)
							else
								local var_369_7 = Mathf.Lerp(iter_369_1.color.r, 0.5, var_369_3)

								iter_369_1.color = Color.New(var_369_7, var_369_7, var_369_7)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps10183 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps10183 = nil
			end

			local var_369_8 = arg_366_1.actors_["10183"].transform
			local var_369_9 = 0

			if var_369_9 < arg_366_1.time_ and arg_366_1.time_ <= var_369_9 + arg_369_0 then
				arg_366_1.var_.moveOldPos10183 = var_369_8.localPosition
				var_369_8.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10183", 7)

				local var_369_10 = var_369_8.childCount

				for iter_369_4 = 0, var_369_10 - 1 do
					local var_369_11 = var_369_8:GetChild(iter_369_4)

					if var_369_11.name == "" or not string.find(var_369_11.name, "split") then
						var_369_11.gameObject:SetActive(true)
					else
						var_369_11.gameObject:SetActive(false)
					end
				end
			end

			local var_369_12 = 0.001

			if var_369_9 <= arg_366_1.time_ and arg_366_1.time_ < var_369_9 + var_369_12 then
				local var_369_13 = (arg_366_1.time_ - var_369_9) / var_369_12
				local var_369_14 = Vector3.New(0, -2000, 0)

				var_369_8.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10183, var_369_14, var_369_13)
			end

			if arg_366_1.time_ >= var_369_9 + var_369_12 and arg_366_1.time_ < var_369_9 + var_369_12 + arg_369_0 then
				var_369_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_15 = arg_366_1.actors_["106603"].transform
			local var_369_16 = 0

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 then
				arg_366_1.var_.moveOldPos106603 = var_369_15.localPosition
				var_369_15.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("106603", 7)

				local var_369_17 = var_369_15.childCount

				for iter_369_5 = 0, var_369_17 - 1 do
					local var_369_18 = var_369_15:GetChild(iter_369_5)

					if var_369_18.name == "" or not string.find(var_369_18.name, "split") then
						var_369_18.gameObject:SetActive(true)
					else
						var_369_18.gameObject:SetActive(false)
					end
				end
			end

			local var_369_19 = 0.001

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_19 then
				local var_369_20 = (arg_366_1.time_ - var_369_16) / var_369_19
				local var_369_21 = Vector3.New(0, -2000, 0)

				var_369_15.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos106603, var_369_21, var_369_20)
			end

			if arg_366_1.time_ >= var_369_16 + var_369_19 and arg_366_1.time_ < var_369_16 + var_369_19 + arg_369_0 then
				var_369_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_369_22 = 0
			local var_369_23 = 1.15

			if var_369_22 < arg_366_1.time_ and arg_366_1.time_ <= var_369_22 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_24 = arg_366_1:GetWordFromCfg(938081089)
				local var_369_25 = arg_366_1:FormatText(var_369_24.content)

				arg_366_1.text_.text = var_369_25

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_26 = 46
				local var_369_27 = utf8.len(var_369_25)
				local var_369_28 = var_369_26 <= 0 and var_369_23 or var_369_23 * (var_369_27 / var_369_26)

				if var_369_28 > 0 and var_369_23 < var_369_28 then
					arg_366_1.talkMaxDuration = var_369_28

					if var_369_28 + var_369_22 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_28 + var_369_22
					end
				end

				arg_366_1.text_.text = var_369_25
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_29 = math.max(var_369_23, arg_366_1.talkMaxDuration)

			if var_369_22 <= arg_366_1.time_ and arg_366_1.time_ < var_369_22 + var_369_29 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_22) / var_369_29

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_22 + var_369_29 and arg_366_1.time_ < var_369_22 + var_369_29 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play938081090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 938081090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play938081091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10183"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10183 == nil then
				arg_370_1.var_.actorSpriteComps10183 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps10183 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								local var_373_4 = Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, var_373_3)
								local var_373_5 = Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, var_373_3)
								local var_373_6 = Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, var_373_3)

								iter_373_1.color = Color.New(var_373_4, var_373_5, var_373_6)
							else
								local var_373_7 = Mathf.Lerp(iter_373_1.color.r, 1, var_373_3)

								iter_373_1.color = Color.New(var_373_7, var_373_7, var_373_7)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10183 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10183 = nil
			end

			local var_373_8 = arg_370_1.actors_["10183"].transform
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 then
				arg_370_1.var_.moveOldPos10183 = var_373_8.localPosition
				var_373_8.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10183", 3)

				local var_373_10 = var_373_8.childCount

				for iter_373_4 = 0, var_373_10 - 1 do
					local var_373_11 = var_373_8:GetChild(iter_373_4)

					if var_373_11.name == "split_8" or not string.find(var_373_11.name, "split") then
						var_373_11.gameObject:SetActive(true)
					else
						var_373_11.gameObject:SetActive(false)
					end
				end
			end

			local var_373_12 = 0.001

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_12 then
				local var_373_13 = (arg_370_1.time_ - var_373_9) / var_373_12
				local var_373_14 = Vector3.New(0, -475, -325)

				var_373_8.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10183, var_373_14, var_373_13)
			end

			if arg_370_1.time_ >= var_373_9 + var_373_12 and arg_370_1.time_ < var_373_9 + var_373_12 + arg_373_0 then
				var_373_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_373_15 = 0
			local var_373_16 = 0.7

			if var_373_15 < arg_370_1.time_ and arg_370_1.time_ <= var_373_15 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_17 = arg_370_1:FormatText(StoryNameCfg[1562].name)

				arg_370_1.leftNameTxt_.text = var_373_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_18 = arg_370_1:GetWordFromCfg(938081090)
				local var_373_19 = arg_370_1:FormatText(var_373_18.content)

				arg_370_1.text_.text = var_373_19

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_20 = 28
				local var_373_21 = utf8.len(var_373_19)
				local var_373_22 = var_373_20 <= 0 and var_373_16 or var_373_16 * (var_373_21 / var_373_20)

				if var_373_22 > 0 and var_373_16 < var_373_22 then
					arg_370_1.talkMaxDuration = var_373_22

					if var_373_22 + var_373_15 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_22 + var_373_15
					end
				end

				arg_370_1.text_.text = var_373_19
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_23 = math.max(var_373_16, arg_370_1.talkMaxDuration)

			if var_373_15 <= arg_370_1.time_ and arg_370_1.time_ < var_373_15 + var_373_23 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_15) / var_373_23

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_15 + var_373_23 and arg_370_1.time_ < var_373_15 + var_373_23 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play938081091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 938081091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play938081092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["10183"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10183 == nil then
				arg_374_1.var_.actorSpriteComps10183 = var_377_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.actorSpriteComps10183 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								local var_377_4 = Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, var_377_3)
								local var_377_5 = Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, var_377_3)
								local var_377_6 = Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, var_377_3)

								iter_377_1.color = Color.New(var_377_4, var_377_5, var_377_6)
							else
								local var_377_7 = Mathf.Lerp(iter_377_1.color.r, 0.5, var_377_3)

								iter_377_1.color = Color.New(var_377_7, var_377_7, var_377_7)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.actorSpriteComps10183 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_377_3 then
						if arg_374_1.isInRecall_ then
							iter_377_3.color = arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_377_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps10183 = nil
			end

			local var_377_8 = manager.ui.mainCamera.transform
			local var_377_9 = 0

			if var_377_9 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.var_.shakeOldPos = var_377_8.localPosition
			end

			local var_377_10 = 0.5

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 then
				local var_377_11 = (arg_374_1.time_ - var_377_9) / 0.066
				local var_377_12, var_377_13 = math.modf(var_377_11)

				var_377_8.localPosition = Vector3.New(var_377_13 * 0.13, var_377_13 * 0.13, var_377_13 * 0.13) + arg_374_1.var_.shakeOldPos
			end

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 then
				var_377_8.localPosition = arg_374_1.var_.shakeOldPos
			end

			local var_377_14 = 0

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			local var_377_15 = 0.5

			if arg_374_1.time_ >= var_377_14 + var_377_15 and arg_374_1.time_ < var_377_14 + var_377_15 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_16 = 0
			local var_377_17 = 0.075

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_18 = arg_374_1:FormatText(StoryNameCfg[1565].name)

				arg_374_1.leftNameTxt_.text = var_377_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_19 = arg_374_1:GetWordFromCfg(938081091)
				local var_377_20 = arg_374_1:FormatText(var_377_19.content)

				arg_374_1.text_.text = var_377_20

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_21 = 3
				local var_377_22 = utf8.len(var_377_20)
				local var_377_23 = var_377_21 <= 0 and var_377_17 or var_377_17 * (var_377_22 / var_377_21)

				if var_377_23 > 0 and var_377_17 < var_377_23 then
					arg_374_1.talkMaxDuration = var_377_23

					if var_377_23 + var_377_16 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_16
					end
				end

				arg_374_1.text_.text = var_377_20
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_24 = math.max(var_377_17, arg_374_1.talkMaxDuration)

			if var_377_16 <= arg_374_1.time_ and arg_374_1.time_ < var_377_16 + var_377_24 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_16) / var_377_24

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_16 + var_377_24 and arg_374_1.time_ < var_377_16 + var_377_24 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play938081092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 938081092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play938081093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["128404"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps128404 == nil then
				arg_378_1.var_.actorSpriteComps128404 = var_381_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_2 = 0.2

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.actorSpriteComps128404 then
					for iter_381_0, iter_381_1 in pairs(arg_378_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_381_1 then
							if arg_378_1.isInRecall_ then
								local var_381_4 = Mathf.Lerp(iter_381_1.color.r, arg_378_1.hightColor1.r, var_381_3)
								local var_381_5 = Mathf.Lerp(iter_381_1.color.g, arg_378_1.hightColor1.g, var_381_3)
								local var_381_6 = Mathf.Lerp(iter_381_1.color.b, arg_378_1.hightColor1.b, var_381_3)

								iter_381_1.color = Color.New(var_381_4, var_381_5, var_381_6)
							else
								local var_381_7 = Mathf.Lerp(iter_381_1.color.r, 1, var_381_3)

								iter_381_1.color = Color.New(var_381_7, var_381_7, var_381_7)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.actorSpriteComps128404 then
				for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_381_3 then
						if arg_378_1.isInRecall_ then
							iter_381_3.color = arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_381_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps128404 = nil
			end

			local var_381_8 = arg_378_1.actors_["10183"].transform
			local var_381_9 = 0

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1.var_.moveOldPos10183 = var_381_8.localPosition
				var_381_8.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10183", 7)

				local var_381_10 = var_381_8.childCount

				for iter_381_4 = 0, var_381_10 - 1 do
					local var_381_11 = var_381_8:GetChild(iter_381_4)

					if var_381_11.name == "split_2" or not string.find(var_381_11.name, "split") then
						var_381_11.gameObject:SetActive(true)
					else
						var_381_11.gameObject:SetActive(false)
					end
				end
			end

			local var_381_12 = 0.001

			if var_381_9 <= arg_378_1.time_ and arg_378_1.time_ < var_381_9 + var_381_12 then
				local var_381_13 = (arg_378_1.time_ - var_381_9) / var_381_12
				local var_381_14 = Vector3.New(0, -2000, 0)

				var_381_8.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10183, var_381_14, var_381_13)
			end

			if arg_378_1.time_ >= var_381_9 + var_381_12 and arg_378_1.time_ < var_381_9 + var_381_12 + arg_381_0 then
				var_381_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_381_15 = arg_378_1.actors_["128404"].transform
			local var_381_16 = 0

			if var_381_16 < arg_378_1.time_ and arg_378_1.time_ <= var_381_16 + arg_381_0 then
				arg_378_1.var_.moveOldPos128404 = var_381_15.localPosition
				var_381_15.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("128404", 2)

				local var_381_17 = var_381_15.childCount

				for iter_381_5 = 0, var_381_17 - 1 do
					local var_381_18 = var_381_15:GetChild(iter_381_5)

					if var_381_18.name == "" or not string.find(var_381_18.name, "split") then
						var_381_18.gameObject:SetActive(true)
					else
						var_381_18.gameObject:SetActive(false)
					end
				end
			end

			local var_381_19 = 0.001

			if var_381_16 <= arg_378_1.time_ and arg_378_1.time_ < var_381_16 + var_381_19 then
				local var_381_20 = (arg_378_1.time_ - var_381_16) / var_381_19
				local var_381_21 = Vector3.New(-428.5, -356, -362.3)

				var_381_15.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos128404, var_381_21, var_381_20)
			end

			if arg_378_1.time_ >= var_381_16 + var_381_19 and arg_378_1.time_ < var_381_16 + var_381_19 + arg_381_0 then
				var_381_15.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_381_22 = 0
			local var_381_23 = 0.45

			if var_381_22 < arg_378_1.time_ and arg_378_1.time_ <= var_381_22 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_24 = arg_378_1:FormatText(StoryNameCfg[6].name)

				arg_378_1.leftNameTxt_.text = var_381_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_25 = arg_378_1:GetWordFromCfg(938081092)
				local var_381_26 = arg_378_1:FormatText(var_381_25.content)

				arg_378_1.text_.text = var_381_26

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_27 = 18
				local var_381_28 = utf8.len(var_381_26)
				local var_381_29 = var_381_27 <= 0 and var_381_23 or var_381_23 * (var_381_28 / var_381_27)

				if var_381_29 > 0 and var_381_23 < var_381_29 then
					arg_378_1.talkMaxDuration = var_381_29

					if var_381_29 + var_381_22 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_29 + var_381_22
					end
				end

				arg_378_1.text_.text = var_381_26
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_30 = math.max(var_381_23, arg_378_1.talkMaxDuration)

			if var_381_22 <= arg_378_1.time_ and arg_378_1.time_ < var_381_22 + var_381_30 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_22) / var_381_30

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_22 + var_381_30 and arg_378_1.time_ < var_381_22 + var_381_30 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play938081093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 938081093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play938081094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["106603"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps106603 == nil then
				arg_382_1.var_.actorSpriteComps106603 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps106603 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 1, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps106603 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps106603 = nil
			end

			local var_385_8 = arg_382_1.actors_["128404"]
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps128404 == nil then
				arg_382_1.var_.actorSpriteComps128404 = var_385_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_10 = 0.2

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_10 and not isNil(var_385_8) then
				local var_385_11 = (arg_382_1.time_ - var_385_9) / var_385_10

				if arg_382_1.var_.actorSpriteComps128404 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								local var_385_12 = Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, var_385_11)
								local var_385_13 = Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, var_385_11)
								local var_385_14 = Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, var_385_11)

								iter_385_5.color = Color.New(var_385_12, var_385_13, var_385_14)
							else
								local var_385_15 = Mathf.Lerp(iter_385_5.color.r, 0.5, var_385_11)

								iter_385_5.color = Color.New(var_385_15, var_385_15, var_385_15)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_9 + var_385_10 and arg_382_1.time_ < var_385_9 + var_385_10 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps128404 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_385_7 then
						if arg_382_1.isInRecall_ then
							iter_385_7.color = arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_385_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps128404 = nil
			end

			local var_385_16 = arg_382_1.actors_["106603"].transform
			local var_385_17 = 0

			if var_385_17 < arg_382_1.time_ and arg_382_1.time_ <= var_385_17 + arg_385_0 then
				arg_382_1.var_.moveOldPos106603 = var_385_16.localPosition
				var_385_16.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("106603", 4)

				local var_385_18 = var_385_16.childCount

				for iter_385_8 = 0, var_385_18 - 1 do
					local var_385_19 = var_385_16:GetChild(iter_385_8)

					if var_385_19.name == "split_5" or not string.find(var_385_19.name, "split") then
						var_385_19.gameObject:SetActive(true)
					else
						var_385_19.gameObject:SetActive(false)
					end
				end
			end

			local var_385_20 = 0.001

			if var_385_17 <= arg_382_1.time_ and arg_382_1.time_ < var_385_17 + var_385_20 then
				local var_385_21 = (arg_382_1.time_ - var_385_17) / var_385_20
				local var_385_22 = Vector3.New(453.9, -399.1, -303.3)

				var_385_16.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos106603, var_385_22, var_385_21)
			end

			if arg_382_1.time_ >= var_385_17 + var_385_20 and arg_382_1.time_ < var_385_17 + var_385_20 + arg_385_0 then
				var_385_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_385_23 = 0
			local var_385_24 = 0.25

			if var_385_23 < arg_382_1.time_ and arg_382_1.time_ <= var_385_23 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_25 = arg_382_1:FormatText(StoryNameCfg[32].name)

				arg_382_1.leftNameTxt_.text = var_385_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_26 = arg_382_1:GetWordFromCfg(938081093)
				local var_385_27 = arg_382_1:FormatText(var_385_26.content)

				arg_382_1.text_.text = var_385_27

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_28 = 10
				local var_385_29 = utf8.len(var_385_27)
				local var_385_30 = var_385_28 <= 0 and var_385_24 or var_385_24 * (var_385_29 / var_385_28)

				if var_385_30 > 0 and var_385_24 < var_385_30 then
					arg_382_1.talkMaxDuration = var_385_30

					if var_385_30 + var_385_23 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_30 + var_385_23
					end
				end

				arg_382_1.text_.text = var_385_27
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_31 = math.max(var_385_24, arg_382_1.talkMaxDuration)

			if var_385_23 <= arg_382_1.time_ and arg_382_1.time_ < var_385_23 + var_385_31 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_23) / var_385_31

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_23 + var_385_31 and arg_382_1.time_ < var_385_23 + var_385_31 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play938081094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 938081094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play938081095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["106603"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps106603 == nil then
				arg_386_1.var_.actorSpriteComps106603 = var_389_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_2 = 0.2

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.actorSpriteComps106603 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								local var_389_4 = Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, var_389_3)
								local var_389_5 = Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, var_389_3)
								local var_389_6 = Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, var_389_3)

								iter_389_1.color = Color.New(var_389_4, var_389_5, var_389_6)
							else
								local var_389_7 = Mathf.Lerp(iter_389_1.color.r, 0.5, var_389_3)

								iter_389_1.color = Color.New(var_389_7, var_389_7, var_389_7)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps106603 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_389_3 then
						if arg_386_1.isInRecall_ then
							iter_389_3.color = arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_389_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps106603 = nil
			end

			local var_389_8 = 0
			local var_389_9 = 0.7

			if var_389_8 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_10 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_11 = arg_386_1:GetWordFromCfg(938081094)
				local var_389_12 = arg_386_1:FormatText(var_389_11.content)

				arg_386_1.text_.text = var_389_12

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_13 = 28
				local var_389_14 = utf8.len(var_389_12)
				local var_389_15 = var_389_13 <= 0 and var_389_9 or var_389_9 * (var_389_14 / var_389_13)

				if var_389_15 > 0 and var_389_9 < var_389_15 then
					arg_386_1.talkMaxDuration = var_389_15

					if var_389_15 + var_389_8 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_15 + var_389_8
					end
				end

				arg_386_1.text_.text = var_389_12
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_16 = math.max(var_389_9, arg_386_1.talkMaxDuration)

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_16 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_8) / var_389_16

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_8 + var_389_16 and arg_386_1.time_ < var_389_8 + var_389_16 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play938081095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 938081095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play938081096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["10183"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps10183 == nil then
				arg_390_1.var_.actorSpriteComps10183 = var_393_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_2 = 0.2

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.actorSpriteComps10183 then
					for iter_393_0, iter_393_1 in pairs(arg_390_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_393_1 then
							if arg_390_1.isInRecall_ then
								local var_393_4 = Mathf.Lerp(iter_393_1.color.r, arg_390_1.hightColor1.r, var_393_3)
								local var_393_5 = Mathf.Lerp(iter_393_1.color.g, arg_390_1.hightColor1.g, var_393_3)
								local var_393_6 = Mathf.Lerp(iter_393_1.color.b, arg_390_1.hightColor1.b, var_393_3)

								iter_393_1.color = Color.New(var_393_4, var_393_5, var_393_6)
							else
								local var_393_7 = Mathf.Lerp(iter_393_1.color.r, 1, var_393_3)

								iter_393_1.color = Color.New(var_393_7, var_393_7, var_393_7)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.actorSpriteComps10183 then
				for iter_393_2, iter_393_3 in pairs(arg_390_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_393_3 then
						if arg_390_1.isInRecall_ then
							iter_393_3.color = arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_393_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps10183 = nil
			end

			local var_393_8 = arg_390_1.actors_["106603"].transform
			local var_393_9 = 0

			if var_393_9 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 then
				arg_390_1.var_.moveOldPos106603 = var_393_8.localPosition
				var_393_8.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("106603", 7)

				local var_393_10 = var_393_8.childCount

				for iter_393_4 = 0, var_393_10 - 1 do
					local var_393_11 = var_393_8:GetChild(iter_393_4)

					if var_393_11.name == "" or not string.find(var_393_11.name, "split") then
						var_393_11.gameObject:SetActive(true)
					else
						var_393_11.gameObject:SetActive(false)
					end
				end
			end

			local var_393_12 = 0.001

			if var_393_9 <= arg_390_1.time_ and arg_390_1.time_ < var_393_9 + var_393_12 then
				local var_393_13 = (arg_390_1.time_ - var_393_9) / var_393_12
				local var_393_14 = Vector3.New(0, -2000, 0)

				var_393_8.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos106603, var_393_14, var_393_13)
			end

			if arg_390_1.time_ >= var_393_9 + var_393_12 and arg_390_1.time_ < var_393_9 + var_393_12 + arg_393_0 then
				var_393_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_393_15 = arg_390_1.actors_["10183"].transform
			local var_393_16 = 0

			if var_393_16 < arg_390_1.time_ and arg_390_1.time_ <= var_393_16 + arg_393_0 then
				arg_390_1.var_.moveOldPos10183 = var_393_15.localPosition
				var_393_15.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10183", 3)

				local var_393_17 = var_393_15.childCount

				for iter_393_5 = 0, var_393_17 - 1 do
					local var_393_18 = var_393_15:GetChild(iter_393_5)

					if var_393_18.name == "split_8" or not string.find(var_393_18.name, "split") then
						var_393_18.gameObject:SetActive(true)
					else
						var_393_18.gameObject:SetActive(false)
					end
				end
			end

			local var_393_19 = 0.001

			if var_393_16 <= arg_390_1.time_ and arg_390_1.time_ < var_393_16 + var_393_19 then
				local var_393_20 = (arg_390_1.time_ - var_393_16) / var_393_19
				local var_393_21 = Vector3.New(0, -475, -325)

				var_393_15.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10183, var_393_21, var_393_20)
			end

			if arg_390_1.time_ >= var_393_16 + var_393_19 and arg_390_1.time_ < var_393_16 + var_393_19 + arg_393_0 then
				var_393_15.localPosition = Vector3.New(0, -475, -325)
			end

			local var_393_22 = arg_390_1.actors_["128404"].transform
			local var_393_23 = 0

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 then
				arg_390_1.var_.moveOldPos128404 = var_393_22.localPosition
				var_393_22.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("128404", 7)

				local var_393_24 = var_393_22.childCount

				for iter_393_6 = 0, var_393_24 - 1 do
					local var_393_25 = var_393_22:GetChild(iter_393_6)

					if var_393_25.name == "" or not string.find(var_393_25.name, "split") then
						var_393_25.gameObject:SetActive(true)
					else
						var_393_25.gameObject:SetActive(false)
					end
				end
			end

			local var_393_26 = 0.001

			if var_393_23 <= arg_390_1.time_ and arg_390_1.time_ < var_393_23 + var_393_26 then
				local var_393_27 = (arg_390_1.time_ - var_393_23) / var_393_26
				local var_393_28 = Vector3.New(0, -2000, 0)

				var_393_22.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos128404, var_393_28, var_393_27)
			end

			if arg_390_1.time_ >= var_393_23 + var_393_26 and arg_390_1.time_ < var_393_23 + var_393_26 + arg_393_0 then
				var_393_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_393_29 = 0
			local var_393_30 = 0.775

			if var_393_29 < arg_390_1.time_ and arg_390_1.time_ <= var_393_29 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_31 = arg_390_1:FormatText(StoryNameCfg[1562].name)

				arg_390_1.leftNameTxt_.text = var_393_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_32 = arg_390_1:GetWordFromCfg(938081095)
				local var_393_33 = arg_390_1:FormatText(var_393_32.content)

				arg_390_1.text_.text = var_393_33

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_34 = 31
				local var_393_35 = utf8.len(var_393_33)
				local var_393_36 = var_393_34 <= 0 and var_393_30 or var_393_30 * (var_393_35 / var_393_34)

				if var_393_36 > 0 and var_393_30 < var_393_36 then
					arg_390_1.talkMaxDuration = var_393_36

					if var_393_36 + var_393_29 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_36 + var_393_29
					end
				end

				arg_390_1.text_.text = var_393_33
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_37 = math.max(var_393_30, arg_390_1.talkMaxDuration)

			if var_393_29 <= arg_390_1.time_ and arg_390_1.time_ < var_393_29 + var_393_37 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_29) / var_393_37

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_29 + var_393_37 and arg_390_1.time_ < var_393_29 + var_393_37 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play938081096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 938081096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play938081097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["10183"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos10183 = var_397_0.localPosition
				var_397_0.localScale = Vector3.New(1, 1, 1)

				arg_394_1:CheckSpriteTmpPos("10183", 3)

				local var_397_2 = var_397_0.childCount

				for iter_397_0 = 0, var_397_2 - 1 do
					local var_397_3 = var_397_0:GetChild(iter_397_0)

					if var_397_3.name == "split_1" then
						var_397_3:SetAsLastSibling()
						var_397_3.gameObject:SetActive(true)

						arg_394_1.var_.actorSpriteSplit10183 = var_397_3.gameObject:GetComponent(typeof(Image))

						arg_394_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_397_4 = 0.5

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_4 then
				local var_397_5 = (arg_394_1.time_ - var_397_1) / var_397_4
				local var_397_6 = Vector3.New(0, -475, -325)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10183, var_397_6, var_397_5)

				if arg_394_1.var_.actorSpriteSplit10183 ~= nil then
					arg_394_1.var_.actorSpriteSplit10183:SetAlpha(var_397_5)
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_4 and arg_394_1.time_ < var_397_1 + var_397_4 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(0, -475, -325)

				if arg_394_1.var_.actorSpriteSplit10183 ~= nil then
					arg_394_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_397_7 = 0
			local var_397_8 = 0.95

			if var_397_7 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_9 = arg_394_1:FormatText(StoryNameCfg[1562].name)

				arg_394_1.leftNameTxt_.text = var_397_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_10 = arg_394_1:GetWordFromCfg(938081096)
				local var_397_11 = arg_394_1:FormatText(var_397_10.content)

				arg_394_1.text_.text = var_397_11

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_12 = 38
				local var_397_13 = utf8.len(var_397_11)
				local var_397_14 = var_397_12 <= 0 and var_397_8 or var_397_8 * (var_397_13 / var_397_12)

				if var_397_14 > 0 and var_397_8 < var_397_14 then
					arg_394_1.talkMaxDuration = var_397_14

					if var_397_14 + var_397_7 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_7
					end
				end

				arg_394_1.text_.text = var_397_11
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_15 = math.max(var_397_8, arg_394_1.talkMaxDuration)

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_15 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_7) / var_397_15

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_7 + var_397_15 and arg_394_1.time_ < var_397_7 + var_397_15 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play938081097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 938081097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play938081098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["10183"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos10183 = var_401_0.localPosition
				var_401_0.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("10183", 3)

				local var_401_2 = var_401_0.childCount

				for iter_401_0 = 0, var_401_2 - 1 do
					local var_401_3 = var_401_0:GetChild(iter_401_0)

					if var_401_3.name == "split_8" then
						var_401_3:SetAsLastSibling()
						var_401_3.gameObject:SetActive(true)

						arg_398_1.var_.actorSpriteSplit10183 = var_401_3.gameObject:GetComponent(typeof(Image))

						arg_398_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_401_4 = 0.5

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_4 then
				local var_401_5 = (arg_398_1.time_ - var_401_1) / var_401_4
				local var_401_6 = Vector3.New(0, -475, -325)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10183, var_401_6, var_401_5)

				if arg_398_1.var_.actorSpriteSplit10183 ~= nil then
					arg_398_1.var_.actorSpriteSplit10183:SetAlpha(var_401_5)
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_4 and arg_398_1.time_ < var_401_1 + var_401_4 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0, -475, -325)

				if arg_398_1.var_.actorSpriteSplit10183 ~= nil then
					arg_398_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_401_7 = 0
			local var_401_8 = 0.325

			if var_401_7 < arg_398_1.time_ and arg_398_1.time_ <= var_401_7 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_9 = arg_398_1:FormatText(StoryNameCfg[1562].name)

				arg_398_1.leftNameTxt_.text = var_401_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_10 = arg_398_1:GetWordFromCfg(938081097)
				local var_401_11 = arg_398_1:FormatText(var_401_10.content)

				arg_398_1.text_.text = var_401_11

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_12 = 13
				local var_401_13 = utf8.len(var_401_11)
				local var_401_14 = var_401_12 <= 0 and var_401_8 or var_401_8 * (var_401_13 / var_401_12)

				if var_401_14 > 0 and var_401_8 < var_401_14 then
					arg_398_1.talkMaxDuration = var_401_14

					if var_401_14 + var_401_7 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_14 + var_401_7
					end
				end

				arg_398_1.text_.text = var_401_11
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_15 = math.max(var_401_8, arg_398_1.talkMaxDuration)

			if var_401_7 <= arg_398_1.time_ and arg_398_1.time_ < var_401_7 + var_401_15 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_7) / var_401_15

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_7 + var_401_15 and arg_398_1.time_ < var_401_7 + var_401_15 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play938081098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 938081098
		arg_402_1.duration_ = 1

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"

			SetActive(arg_402_1.choicesGo_, true)

			for iter_403_0, iter_403_1 in ipairs(arg_402_1.choices_) do
				local var_403_0 = iter_403_0 <= 1

				SetActive(iter_403_1.go, var_403_0)
			end

			arg_402_1.choices_[1].txt.text = arg_402_1:FormatText(StoryChoiceCfg[1792].name)
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play938081099(arg_402_1)
			end

			arg_402_1:RecordChoiceLog(938081098, 1792)
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10183"]
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps10183 == nil then
				arg_402_1.var_.actorSpriteComps10183 = var_405_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_2 = 0.2

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 and not isNil(var_405_0) then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2

				if arg_402_1.var_.actorSpriteComps10183 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								local var_405_4 = Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor2.r, var_405_3)
								local var_405_5 = Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor2.g, var_405_3)
								local var_405_6 = Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor2.b, var_405_3)

								iter_405_1.color = Color.New(var_405_4, var_405_5, var_405_6)
							else
								local var_405_7 = Mathf.Lerp(iter_405_1.color.r, 0.5, var_405_3)

								iter_405_1.color = Color.New(var_405_7, var_405_7, var_405_7)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 and not isNil(var_405_0) and arg_402_1.var_.actorSpriteComps10183 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_405_3 then
						if arg_402_1.isInRecall_ then
							iter_405_3.color = arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_405_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_402_1.var_.actorSpriteComps10183 = nil
			end

			local var_405_8 = 0

			if var_405_8 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 then
				arg_402_1.allBtn_.enabled = false
			end

			local var_405_9 = 0.6

			if arg_402_1.time_ >= var_405_8 + var_405_9 and arg_402_1.time_ < var_405_8 + var_405_9 + arg_405_0 then
				arg_402_1.allBtn_.enabled = true
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play938081099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 938081099
		arg_406_1.duration_ = 9

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play938081100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 2

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				local var_409_1 = manager.ui.mainCamera.transform.localPosition
				local var_409_2 = Vector3.New(0, 0, 10) + Vector3.New(var_409_1.x, var_409_1.y, 0)
				local var_409_3 = arg_406_1.bgs_.H02a

				var_409_3.transform.localPosition = var_409_2
				var_409_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_4 = var_409_3:GetComponent("SpriteRenderer")

				if var_409_4 and var_409_4.sprite then
					local var_409_5 = (var_409_3.transform.localPosition - var_409_1).z
					local var_409_6 = manager.ui.mainCameraCom_
					local var_409_7 = 2 * var_409_5 * Mathf.Tan(var_409_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_409_8 = var_409_7 * var_409_6.aspect
					local var_409_9 = var_409_4.sprite.bounds.size.x
					local var_409_10 = var_409_4.sprite.bounds.size.y
					local var_409_11 = var_409_8 / var_409_9
					local var_409_12 = var_409_7 / var_409_10
					local var_409_13 = var_409_12 < var_409_11 and var_409_11 or var_409_12

					var_409_3.transform.localScale = Vector3.New(var_409_13, var_409_13, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "H02a" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_14 = 4

			if var_409_14 < arg_406_1.time_ and arg_406_1.time_ <= var_409_14 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			local var_409_15 = 0.3

			if arg_406_1.time_ >= var_409_14 + var_409_15 and arg_406_1.time_ < var_409_14 + var_409_15 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_16 = 0

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_17 = 2

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_17 then
				local var_409_18 = (arg_406_1.time_ - var_409_16) / var_409_17
				local var_409_19 = Color.New(0, 0, 0)

				var_409_19.a = Mathf.Lerp(0, 1, var_409_18)
				arg_406_1.mask_.color = var_409_19
			end

			if arg_406_1.time_ >= var_409_16 + var_409_17 and arg_406_1.time_ < var_409_16 + var_409_17 + arg_409_0 then
				local var_409_20 = Color.New(0, 0, 0)

				var_409_20.a = 1
				arg_406_1.mask_.color = var_409_20
			end

			local var_409_21 = 2

			if var_409_21 < arg_406_1.time_ and arg_406_1.time_ <= var_409_21 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_22 = 2

			if var_409_21 <= arg_406_1.time_ and arg_406_1.time_ < var_409_21 + var_409_22 then
				local var_409_23 = (arg_406_1.time_ - var_409_21) / var_409_22
				local var_409_24 = Color.New(0, 0, 0)

				var_409_24.a = Mathf.Lerp(1, 0, var_409_23)
				arg_406_1.mask_.color = var_409_24
			end

			if arg_406_1.time_ >= var_409_21 + var_409_22 and arg_406_1.time_ < var_409_21 + var_409_22 + arg_409_0 then
				local var_409_25 = Color.New(0, 0, 0)
				local var_409_26 = 0

				arg_406_1.mask_.enabled = false
				var_409_25.a = var_409_26
				arg_406_1.mask_.color = var_409_25
			end

			local var_409_27 = arg_406_1.actors_["10183"].transform
			local var_409_28 = 1.966

			if var_409_28 < arg_406_1.time_ and arg_406_1.time_ <= var_409_28 + arg_409_0 then
				arg_406_1.var_.moveOldPos10183 = var_409_27.localPosition
				var_409_27.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("10183", 7)

				local var_409_29 = var_409_27.childCount

				for iter_409_2 = 0, var_409_29 - 1 do
					local var_409_30 = var_409_27:GetChild(iter_409_2)

					if var_409_30.name == "" or not string.find(var_409_30.name, "split") then
						var_409_30.gameObject:SetActive(true)
					else
						var_409_30.gameObject:SetActive(false)
					end
				end
			end

			local var_409_31 = 0.001

			if var_409_28 <= arg_406_1.time_ and arg_406_1.time_ < var_409_28 + var_409_31 then
				local var_409_32 = (arg_406_1.time_ - var_409_28) / var_409_31
				local var_409_33 = Vector3.New(0, -2000, -360)

				var_409_27.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos10183, var_409_33, var_409_32)
			end

			if arg_406_1.time_ >= var_409_28 + var_409_31 and arg_406_1.time_ < var_409_28 + var_409_31 + arg_409_0 then
				var_409_27.localPosition = Vector3.New(0, -2000, -360)
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_34 = 4
			local var_409_35 = 1.3

			if var_409_34 < arg_406_1.time_ and arg_406_1.time_ <= var_409_34 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_36 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_36:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_37 = arg_406_1:GetWordFromCfg(938081099)
				local var_409_38 = arg_406_1:FormatText(var_409_37.content)

				arg_406_1.text_.text = var_409_38

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_39 = 52
				local var_409_40 = utf8.len(var_409_38)
				local var_409_41 = var_409_39 <= 0 and var_409_35 or var_409_35 * (var_409_40 / var_409_39)

				if var_409_41 > 0 and var_409_35 < var_409_41 then
					arg_406_1.talkMaxDuration = var_409_41
					var_409_34 = var_409_34 + 0.3

					if var_409_41 + var_409_34 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_41 + var_409_34
					end
				end

				arg_406_1.text_.text = var_409_38
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_42 = var_409_34 + 0.3
			local var_409_43 = math.max(var_409_35, arg_406_1.talkMaxDuration)

			if var_409_42 <= arg_406_1.time_ and arg_406_1.time_ < var_409_42 + var_409_43 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_42) / var_409_43

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_42 + var_409_43 and arg_406_1.time_ < var_409_42 + var_409_43 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play938081100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 938081100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play938081101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10183"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps10183 == nil then
				arg_412_1.var_.actorSpriteComps10183 = var_415_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_2 = 0.2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.actorSpriteComps10183 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								local var_415_4 = Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor1.r, var_415_3)
								local var_415_5 = Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor1.g, var_415_3)
								local var_415_6 = Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor1.b, var_415_3)

								iter_415_1.color = Color.New(var_415_4, var_415_5, var_415_6)
							else
								local var_415_7 = Mathf.Lerp(iter_415_1.color.r, 1, var_415_3)

								iter_415_1.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps10183 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_415_3 then
						if arg_412_1.isInRecall_ then
							iter_415_3.color = arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_415_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps10183 = nil
			end

			local var_415_8 = arg_412_1.actors_["10183"].transform
			local var_415_9 = 0

			if var_415_9 < arg_412_1.time_ and arg_412_1.time_ <= var_415_9 + arg_415_0 then
				arg_412_1.var_.moveOldPos10183 = var_415_8.localPosition
				var_415_8.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10183", 3)

				local var_415_10 = var_415_8.childCount

				for iter_415_4 = 0, var_415_10 - 1 do
					local var_415_11 = var_415_8:GetChild(iter_415_4)

					if var_415_11.name == "split_1" or not string.find(var_415_11.name, "split") then
						var_415_11.gameObject:SetActive(true)
					else
						var_415_11.gameObject:SetActive(false)
					end
				end
			end

			local var_415_12 = 0.001

			if var_415_9 <= arg_412_1.time_ and arg_412_1.time_ < var_415_9 + var_415_12 then
				local var_415_13 = (arg_412_1.time_ - var_415_9) / var_415_12
				local var_415_14 = Vector3.New(0, -475, -325)

				var_415_8.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10183, var_415_14, var_415_13)
			end

			if arg_412_1.time_ >= var_415_9 + var_415_12 and arg_412_1.time_ < var_415_9 + var_415_12 + arg_415_0 then
				var_415_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_415_15 = 0
			local var_415_16 = 0.475

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[1562].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(938081100)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 19
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_23 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_23 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_15) / var_415_23

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_15 + var_415_23 and arg_412_1.time_ < var_415_15 + var_415_23 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play938081101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 938081101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play938081102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10183"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10183 == nil then
				arg_416_1.var_.actorSpriteComps10183 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps10183 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 0.5, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10183 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10183 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 0.35

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_10 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_11 = arg_416_1:GetWordFromCfg(938081101)
				local var_419_12 = arg_416_1:FormatText(var_419_11.content)

				arg_416_1.text_.text = var_419_12

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 14
				local var_419_14 = utf8.len(var_419_12)
				local var_419_15 = var_419_13 <= 0 and var_419_9 or var_419_9 * (var_419_14 / var_419_13)

				if var_419_15 > 0 and var_419_9 < var_419_15 then
					arg_416_1.talkMaxDuration = var_419_15

					if var_419_15 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_15 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_12
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_16 and arg_416_1.time_ < var_419_8 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play938081102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 938081102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play938081103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10183"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10183 == nil then
				arg_420_1.var_.actorSpriteComps10183 = var_423_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.actorSpriteComps10183 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								local var_423_4 = Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor1.r, var_423_3)
								local var_423_5 = Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor1.g, var_423_3)
								local var_423_6 = Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor1.b, var_423_3)

								iter_423_1.color = Color.New(var_423_4, var_423_5, var_423_6)
							else
								local var_423_7 = Mathf.Lerp(iter_423_1.color.r, 1, var_423_3)

								iter_423_1.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10183 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_423_3 then
						if arg_420_1.isInRecall_ then
							iter_423_3.color = arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_423_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10183 = nil
			end

			local var_423_8 = arg_420_1.actors_["10183"].transform
			local var_423_9 = 0

			if var_423_9 < arg_420_1.time_ and arg_420_1.time_ <= var_423_9 + arg_423_0 then
				arg_420_1.var_.moveOldPos10183 = var_423_8.localPosition
				var_423_8.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10183", 3)

				local var_423_10 = var_423_8.childCount

				for iter_423_4 = 0, var_423_10 - 1 do
					local var_423_11 = var_423_8:GetChild(iter_423_4)

					if var_423_11.name == "split_1" or not string.find(var_423_11.name, "split") then
						var_423_11.gameObject:SetActive(true)
					else
						var_423_11.gameObject:SetActive(false)
					end
				end
			end

			local var_423_12 = 0.001

			if var_423_9 <= arg_420_1.time_ and arg_420_1.time_ < var_423_9 + var_423_12 then
				local var_423_13 = (arg_420_1.time_ - var_423_9) / var_423_12
				local var_423_14 = Vector3.New(0, -475, -325)

				var_423_8.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10183, var_423_14, var_423_13)
			end

			if arg_420_1.time_ >= var_423_9 + var_423_12 and arg_420_1.time_ < var_423_9 + var_423_12 + arg_423_0 then
				var_423_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_423_15 = 0
			local var_423_16 = 0.825

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_17 = arg_420_1:FormatText(StoryNameCfg[1562].name)

				arg_420_1.leftNameTxt_.text = var_423_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_18 = arg_420_1:GetWordFromCfg(938081102)
				local var_423_19 = arg_420_1:FormatText(var_423_18.content)

				arg_420_1.text_.text = var_423_19

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_20 = 33
				local var_423_21 = utf8.len(var_423_19)
				local var_423_22 = var_423_20 <= 0 and var_423_16 or var_423_16 * (var_423_21 / var_423_20)

				if var_423_22 > 0 and var_423_16 < var_423_22 then
					arg_420_1.talkMaxDuration = var_423_22

					if var_423_22 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_22 + var_423_15
					end
				end

				arg_420_1.text_.text = var_423_19
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_23 = math.max(var_423_16, arg_420_1.talkMaxDuration)

			if var_423_15 <= arg_420_1.time_ and arg_420_1.time_ < var_423_15 + var_423_23 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_15) / var_423_23

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_15 + var_423_23 and arg_420_1.time_ < var_423_15 + var_423_23 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play938081103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 938081103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play938081104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0
			local var_427_1 = 1

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_2 = arg_424_1:FormatText(StoryNameCfg[1562].name)

				arg_424_1.leftNameTxt_.text = var_427_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_3 = arg_424_1:GetWordFromCfg(938081103)
				local var_427_4 = arg_424_1:FormatText(var_427_3.content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 40
				local var_427_6 = utf8.len(var_427_4)
				local var_427_7 = var_427_5 <= 0 and var_427_1 or var_427_1 * (var_427_6 / var_427_5)

				if var_427_7 > 0 and var_427_1 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_0
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_1, arg_424_1.talkMaxDuration)

			if var_427_0 <= arg_424_1.time_ and arg_424_1.time_ < var_427_0 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_0) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_0 + var_427_8 and arg_424_1.time_ < var_427_0 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play938081104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 938081104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play938081105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10183"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos10183 = var_431_0.localPosition
				var_431_0.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10183", 3)

				local var_431_2 = var_431_0.childCount

				for iter_431_0 = 0, var_431_2 - 1 do
					local var_431_3 = var_431_0:GetChild(iter_431_0)

					if var_431_3.name == "split_7" then
						var_431_3:SetAsLastSibling()
						var_431_3.gameObject:SetActive(true)

						arg_428_1.var_.actorSpriteSplit10183 = var_431_3.gameObject:GetComponent(typeof(Image))

						arg_428_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_431_4 = 0.5

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_4 then
				local var_431_5 = (arg_428_1.time_ - var_431_1) / var_431_4
				local var_431_6 = Vector3.New(0, -475, -325)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10183, var_431_6, var_431_5)

				if arg_428_1.var_.actorSpriteSplit10183 ~= nil then
					arg_428_1.var_.actorSpriteSplit10183:SetAlpha(var_431_5)
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_4 and arg_428_1.time_ < var_431_1 + var_431_4 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0, -475, -325)

				if arg_428_1.var_.actorSpriteSplit10183 ~= nil then
					arg_428_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_431_7 = manager.ui.mainCamera.transform
			local var_431_8 = 0

			if var_431_8 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				local var_431_9 = arg_428_1.var_.effectfensewenfei1
				local var_431_10
				local var_431_11 = var_431_7

				if not var_431_9 then
					var_431_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_pinkbubble_in_keep"), var_431_11)
					var_431_9.name = "fensewenfei1"
					arg_428_1.var_.effectfensewenfei1 = var_431_9
				else
					var_431_9.transform:SetParent(var_431_11)
				end

				var_431_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_431_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_431_12 = 1.7777777777777777
				local var_431_13 = Screen.width / Screen.height
				local var_431_14 = var_431_13 / var_431_12
				local var_431_15 = Mathf.Max(var_431_12 / var_431_13, 1)

				var_431_9.transform.localScale = Vector3.New(var_431_9.transform.localScale.x * var_431_14, var_431_9.transform.localScale.y * var_431_15, var_431_9.transform.localScale.z)
			end

			local var_431_16 = 0
			local var_431_17 = 1.125

			if var_431_16 < arg_428_1.time_ and arg_428_1.time_ <= var_431_16 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_18 = arg_428_1:FormatText(StoryNameCfg[1562].name)

				arg_428_1.leftNameTxt_.text = var_431_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_19 = arg_428_1:GetWordFromCfg(938081104)
				local var_431_20 = arg_428_1:FormatText(var_431_19.content)

				arg_428_1.text_.text = var_431_20

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_21 = 45
				local var_431_22 = utf8.len(var_431_20)
				local var_431_23 = var_431_21 <= 0 and var_431_17 or var_431_17 * (var_431_22 / var_431_21)

				if var_431_23 > 0 and var_431_17 < var_431_23 then
					arg_428_1.talkMaxDuration = var_431_23

					if var_431_23 + var_431_16 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_23 + var_431_16
					end
				end

				arg_428_1.text_.text = var_431_20
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_24 = math.max(var_431_17, arg_428_1.talkMaxDuration)

			if var_431_16 <= arg_428_1.time_ and arg_428_1.time_ < var_431_16 + var_431_24 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_16) / var_431_24

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_16 + var_431_24 and arg_428_1.time_ < var_431_16 + var_431_24 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play938081105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 938081105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play938081106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["10183"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps10183 == nil then
				arg_432_1.var_.actorSpriteComps10183 = var_435_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_2 = 0.2

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.actorSpriteComps10183 then
					for iter_435_0, iter_435_1 in pairs(arg_432_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_435_1 then
							if arg_432_1.isInRecall_ then
								local var_435_4 = Mathf.Lerp(iter_435_1.color.r, arg_432_1.hightColor2.r, var_435_3)
								local var_435_5 = Mathf.Lerp(iter_435_1.color.g, arg_432_1.hightColor2.g, var_435_3)
								local var_435_6 = Mathf.Lerp(iter_435_1.color.b, arg_432_1.hightColor2.b, var_435_3)

								iter_435_1.color = Color.New(var_435_4, var_435_5, var_435_6)
							else
								local var_435_7 = Mathf.Lerp(iter_435_1.color.r, 0.5, var_435_3)

								iter_435_1.color = Color.New(var_435_7, var_435_7, var_435_7)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.actorSpriteComps10183 then
				for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_435_3 then
						if arg_432_1.isInRecall_ then
							iter_435_3.color = arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_435_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps10183 = nil
			end

			local var_435_8 = 0
			local var_435_9 = 0.275

			if var_435_8 < arg_432_1.time_ and arg_432_1.time_ <= var_435_8 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_10 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_11 = arg_432_1:GetWordFromCfg(938081105)
				local var_435_12 = arg_432_1:FormatText(var_435_11.content)

				arg_432_1.text_.text = var_435_12

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_13 = 11
				local var_435_14 = utf8.len(var_435_12)
				local var_435_15 = var_435_13 <= 0 and var_435_9 or var_435_9 * (var_435_14 / var_435_13)

				if var_435_15 > 0 and var_435_9 < var_435_15 then
					arg_432_1.talkMaxDuration = var_435_15

					if var_435_15 + var_435_8 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_15 + var_435_8
					end
				end

				arg_432_1.text_.text = var_435_12
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_9, arg_432_1.talkMaxDuration)

			if var_435_8 <= arg_432_1.time_ and arg_432_1.time_ < var_435_8 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_8) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_8 + var_435_16 and arg_432_1.time_ < var_435_8 + var_435_16 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play938081106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 938081106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play938081107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10183"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10183 == nil then
				arg_436_1.var_.actorSpriteComps10183 = var_439_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.actorSpriteComps10183 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								local var_439_4 = Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, var_439_3)
								local var_439_5 = Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, var_439_3)
								local var_439_6 = Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, var_439_3)

								iter_439_1.color = Color.New(var_439_4, var_439_5, var_439_6)
							else
								local var_439_7 = Mathf.Lerp(iter_439_1.color.r, 1, var_439_3)

								iter_439_1.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10183 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_439_3 then
						if arg_436_1.isInRecall_ then
							iter_439_3.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_439_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps10183 = nil
			end

			local var_439_8 = arg_436_1.actors_["10183"].transform
			local var_439_9 = 0

			if var_439_9 < arg_436_1.time_ and arg_436_1.time_ <= var_439_9 + arg_439_0 then
				arg_436_1.var_.moveOldPos10183 = var_439_8.localPosition
				var_439_8.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10183", 3)

				local var_439_10 = var_439_8.childCount

				for iter_439_4 = 0, var_439_10 - 1 do
					local var_439_11 = var_439_8:GetChild(iter_439_4)

					if var_439_11.name == "split_8" then
						var_439_11:SetAsLastSibling()
						var_439_11.gameObject:SetActive(true)

						arg_436_1.var_.actorSpriteSplit10183 = var_439_11.gameObject:GetComponent(typeof(Image))

						arg_436_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_439_12 = 0.5

			if var_439_9 <= arg_436_1.time_ and arg_436_1.time_ < var_439_9 + var_439_12 then
				local var_439_13 = (arg_436_1.time_ - var_439_9) / var_439_12
				local var_439_14 = Vector3.New(0, -475, -325)

				var_439_8.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10183, var_439_14, var_439_13)

				if arg_436_1.var_.actorSpriteSplit10183 ~= nil then
					arg_436_1.var_.actorSpriteSplit10183:SetAlpha(var_439_13)
				end
			end

			if arg_436_1.time_ >= var_439_9 + var_439_12 and arg_436_1.time_ < var_439_9 + var_439_12 + arg_439_0 then
				var_439_8.localPosition = Vector3.New(0, -475, -325)

				if arg_436_1.var_.actorSpriteSplit10183 ~= nil then
					arg_436_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_439_15 = manager.ui.mainCamera.transform
			local var_439_16 = 0

			if var_439_16 < arg_436_1.time_ and arg_436_1.time_ <= var_439_16 + arg_439_0 then
				arg_436_1.var_.shakeOldPos = var_439_15.localPosition
			end

			local var_439_17 = 0.6

			if var_439_16 <= arg_436_1.time_ and arg_436_1.time_ < var_439_16 + var_439_17 then
				local var_439_18 = (arg_436_1.time_ - var_439_16) / 0.066
				local var_439_19, var_439_20 = math.modf(var_439_18)

				var_439_15.localPosition = Vector3.New(var_439_20 * 0.13, var_439_20 * 0.13, var_439_20 * 0.13) + arg_436_1.var_.shakeOldPos
			end

			if arg_436_1.time_ >= var_439_16 + var_439_17 and arg_436_1.time_ < var_439_16 + var_439_17 + arg_439_0 then
				var_439_15.localPosition = arg_436_1.var_.shakeOldPos
			end

			local var_439_21 = 0

			if var_439_21 < arg_436_1.time_ and arg_436_1.time_ <= var_439_21 + arg_439_0 then
				arg_436_1.allBtn_.enabled = false
			end

			local var_439_22 = 0.6

			if arg_436_1.time_ >= var_439_21 + var_439_22 and arg_436_1.time_ < var_439_21 + var_439_22 + arg_439_0 then
				arg_436_1.allBtn_.enabled = true
			end

			local var_439_23 = manager.ui.mainCamera.transform
			local var_439_24 = 0

			if var_439_24 < arg_436_1.time_ and arg_436_1.time_ <= var_439_24 + arg_439_0 then
				local var_439_25 = arg_436_1.var_.effectfensewenfei1

				if var_439_25 then
					Object.Destroy(var_439_25)

					arg_436_1.var_.effectfensewenfei1 = nil
				end
			end

			local var_439_26 = 0
			local var_439_27 = 1.225

			if var_439_26 < arg_436_1.time_ and arg_436_1.time_ <= var_439_26 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_28 = arg_436_1:FormatText(StoryNameCfg[1562].name)

				arg_436_1.leftNameTxt_.text = var_439_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_29 = arg_436_1:GetWordFromCfg(938081106)
				local var_439_30 = arg_436_1:FormatText(var_439_29.content)

				arg_436_1.text_.text = var_439_30

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_31 = 49
				local var_439_32 = utf8.len(var_439_30)
				local var_439_33 = var_439_31 <= 0 and var_439_27 or var_439_27 * (var_439_32 / var_439_31)

				if var_439_33 > 0 and var_439_27 < var_439_33 then
					arg_436_1.talkMaxDuration = var_439_33

					if var_439_33 + var_439_26 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_33 + var_439_26
					end
				end

				arg_436_1.text_.text = var_439_30
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_34 = math.max(var_439_27, arg_436_1.talkMaxDuration)

			if var_439_26 <= arg_436_1.time_ and arg_436_1.time_ < var_439_26 + var_439_34 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_26) / var_439_34

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_26 + var_439_34 and arg_436_1.time_ < var_439_26 + var_439_34 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play938081107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 938081107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play938081108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.925

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[1562].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_3 = arg_440_1:GetWordFromCfg(938081107)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 37
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play938081108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 938081108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play938081109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10183"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos10183 = var_447_0.localPosition
				var_447_0.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10183", 3)

				local var_447_2 = var_447_0.childCount

				for iter_447_0 = 0, var_447_2 - 1 do
					local var_447_3 = var_447_0:GetChild(iter_447_0)

					if var_447_3.name == "split_1" then
						var_447_3:SetAsLastSibling()
						var_447_3.gameObject:SetActive(true)

						arg_444_1.var_.actorSpriteSplit10183 = var_447_3.gameObject:GetComponent(typeof(Image))

						arg_444_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_447_4 = 0.5

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_4 then
				local var_447_5 = (arg_444_1.time_ - var_447_1) / var_447_4
				local var_447_6 = Vector3.New(0, -475, -325)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10183, var_447_6, var_447_5)

				if arg_444_1.var_.actorSpriteSplit10183 ~= nil then
					arg_444_1.var_.actorSpriteSplit10183:SetAlpha(var_447_5)
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_4 and arg_444_1.time_ < var_447_1 + var_447_4 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, -475, -325)

				if arg_444_1.var_.actorSpriteSplit10183 ~= nil then
					arg_444_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_447_7 = 0
			local var_447_8 = 0.85

			if var_447_7 < arg_444_1.time_ and arg_444_1.time_ <= var_447_7 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_9 = arg_444_1:FormatText(StoryNameCfg[1562].name)

				arg_444_1.leftNameTxt_.text = var_447_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_10 = arg_444_1:GetWordFromCfg(938081108)
				local var_447_11 = arg_444_1:FormatText(var_447_10.content)

				arg_444_1.text_.text = var_447_11

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_12 = 34
				local var_447_13 = utf8.len(var_447_11)
				local var_447_14 = var_447_12 <= 0 and var_447_8 or var_447_8 * (var_447_13 / var_447_12)

				if var_447_14 > 0 and var_447_8 < var_447_14 then
					arg_444_1.talkMaxDuration = var_447_14

					if var_447_14 + var_447_7 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_14 + var_447_7
					end
				end

				arg_444_1.text_.text = var_447_11
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_15 = math.max(var_447_8, arg_444_1.talkMaxDuration)

			if var_447_7 <= arg_444_1.time_ and arg_444_1.time_ < var_447_7 + var_447_15 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_7) / var_447_15

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_7 + var_447_15 and arg_444_1.time_ < var_447_7 + var_447_15 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play938081109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 938081109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play938081110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10183"].transform
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.var_.moveOldPos10183 = var_451_0.localPosition
				var_451_0.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10183", 3)

				local var_451_2 = var_451_0.childCount

				for iter_451_0 = 0, var_451_2 - 1 do
					local var_451_3 = var_451_0:GetChild(iter_451_0)

					if var_451_3.name == "" or not string.find(var_451_3.name, "split") then
						var_451_3.gameObject:SetActive(true)
					else
						var_451_3.gameObject:SetActive(false)
					end
				end
			end

			local var_451_4 = 0.001

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_4 then
				local var_451_5 = (arg_448_1.time_ - var_451_1) / var_451_4
				local var_451_6 = Vector3.New(0, -475, -325)

				var_451_0.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10183, var_451_6, var_451_5)
			end

			if arg_448_1.time_ >= var_451_1 + var_451_4 and arg_448_1.time_ < var_451_1 + var_451_4 + arg_451_0 then
				var_451_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_451_7 = 0
			local var_451_8 = 0.7

			if var_451_7 < arg_448_1.time_ and arg_448_1.time_ <= var_451_7 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_9 = arg_448_1:FormatText(StoryNameCfg[1562].name)

				arg_448_1.leftNameTxt_.text = var_451_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_10 = arg_448_1:GetWordFromCfg(938081109)
				local var_451_11 = arg_448_1:FormatText(var_451_10.content)

				arg_448_1.text_.text = var_451_11

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_12 = 28
				local var_451_13 = utf8.len(var_451_11)
				local var_451_14 = var_451_12 <= 0 and var_451_8 or var_451_8 * (var_451_13 / var_451_12)

				if var_451_14 > 0 and var_451_8 < var_451_14 then
					arg_448_1.talkMaxDuration = var_451_14

					if var_451_14 + var_451_7 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_14 + var_451_7
					end
				end

				arg_448_1.text_.text = var_451_11
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_15 = math.max(var_451_8, arg_448_1.talkMaxDuration)

			if var_451_7 <= arg_448_1.time_ and arg_448_1.time_ < var_451_7 + var_451_15 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_7) / var_451_15

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_7 + var_451_15 and arg_448_1.time_ < var_451_7 + var_451_15 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play938081110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 938081110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play938081111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["10183"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10183 == nil then
				arg_452_1.var_.actorSpriteComps10183 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps10183 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								local var_455_4 = Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, var_455_3)
								local var_455_5 = Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, var_455_3)
								local var_455_6 = Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, var_455_3)

								iter_455_1.color = Color.New(var_455_4, var_455_5, var_455_6)
							else
								local var_455_7 = Mathf.Lerp(iter_455_1.color.r, 0.5, var_455_3)

								iter_455_1.color = Color.New(var_455_7, var_455_7, var_455_7)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10183 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_455_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps10183 = nil
			end

			local var_455_8 = 0
			local var_455_9 = 0.225

			if var_455_8 < arg_452_1.time_ and arg_452_1.time_ <= var_455_8 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_10 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_11 = arg_452_1:GetWordFromCfg(938081110)
				local var_455_12 = arg_452_1:FormatText(var_455_11.content)

				arg_452_1.text_.text = var_455_12

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_13 = 9
				local var_455_14 = utf8.len(var_455_12)
				local var_455_15 = var_455_13 <= 0 and var_455_9 or var_455_9 * (var_455_14 / var_455_13)

				if var_455_15 > 0 and var_455_9 < var_455_15 then
					arg_452_1.talkMaxDuration = var_455_15

					if var_455_15 + var_455_8 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_15 + var_455_8
					end
				end

				arg_452_1.text_.text = var_455_12
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_16 = math.max(var_455_9, arg_452_1.talkMaxDuration)

			if var_455_8 <= arg_452_1.time_ and arg_452_1.time_ < var_455_8 + var_455_16 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_8) / var_455_16

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_8 + var_455_16 and arg_452_1.time_ < var_455_8 + var_455_16 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play938081111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 938081111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play938081112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["10183"]
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps10183 == nil then
				arg_456_1.var_.actorSpriteComps10183 = var_459_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_2 = 0.2

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 and not isNil(var_459_0) then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2

				if arg_456_1.var_.actorSpriteComps10183 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								local var_459_4 = Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, var_459_3)
								local var_459_5 = Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, var_459_3)
								local var_459_6 = Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, var_459_3)

								iter_459_1.color = Color.New(var_459_4, var_459_5, var_459_6)
							else
								local var_459_7 = Mathf.Lerp(iter_459_1.color.r, 1, var_459_3)

								iter_459_1.color = Color.New(var_459_7, var_459_7, var_459_7)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 and not isNil(var_459_0) and arg_456_1.var_.actorSpriteComps10183 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_459_3 then
						if arg_456_1.isInRecall_ then
							iter_459_3.color = arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_459_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_456_1.var_.actorSpriteComps10183 = nil
			end

			local var_459_8 = arg_456_1.actors_["10183"].transform
			local var_459_9 = 0

			if var_459_9 < arg_456_1.time_ and arg_456_1.time_ <= var_459_9 + arg_459_0 then
				arg_456_1.var_.moveOldPos10183 = var_459_8.localPosition
				var_459_8.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10183", 3)

				local var_459_10 = var_459_8.childCount

				for iter_459_4 = 0, var_459_10 - 1 do
					local var_459_11 = var_459_8:GetChild(iter_459_4)

					if var_459_11.name == "" or not string.find(var_459_11.name, "split") then
						var_459_11.gameObject:SetActive(true)
					else
						var_459_11.gameObject:SetActive(false)
					end
				end
			end

			local var_459_12 = 0.001

			if var_459_9 <= arg_456_1.time_ and arg_456_1.time_ < var_459_9 + var_459_12 then
				local var_459_13 = (arg_456_1.time_ - var_459_9) / var_459_12
				local var_459_14 = Vector3.New(0, -475, -325)

				var_459_8.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10183, var_459_14, var_459_13)
			end

			if arg_456_1.time_ >= var_459_9 + var_459_12 and arg_456_1.time_ < var_459_9 + var_459_12 + arg_459_0 then
				var_459_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_459_15 = arg_456_1.actors_["10183"].transform
			local var_459_16 = 0

			if var_459_16 < arg_456_1.time_ and arg_456_1.time_ <= var_459_16 + arg_459_0 then
				arg_456_1.var_.moveOldPos10183 = var_459_15.localPosition
				var_459_15.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("10183", 3)

				local var_459_17 = var_459_15.childCount

				for iter_459_5 = 0, var_459_17 - 1 do
					local var_459_18 = var_459_15:GetChild(iter_459_5)

					if var_459_18.name == "split_7" then
						var_459_18:SetAsLastSibling()
						var_459_18.gameObject:SetActive(true)

						arg_456_1.var_.actorSpriteSplit10183 = var_459_18.gameObject:GetComponent(typeof(Image))

						arg_456_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_459_19 = 0.5

			if var_459_16 <= arg_456_1.time_ and arg_456_1.time_ < var_459_16 + var_459_19 then
				local var_459_20 = (arg_456_1.time_ - var_459_16) / var_459_19
				local var_459_21 = Vector3.New(0, -475, -325)

				var_459_15.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10183, var_459_21, var_459_20)

				if arg_456_1.var_.actorSpriteSplit10183 ~= nil then
					arg_456_1.var_.actorSpriteSplit10183:SetAlpha(var_459_20)
				end
			end

			if arg_456_1.time_ >= var_459_16 + var_459_19 and arg_456_1.time_ < var_459_16 + var_459_19 + arg_459_0 then
				var_459_15.localPosition = Vector3.New(0, -475, -325)

				if arg_456_1.var_.actorSpriteSplit10183 ~= nil then
					arg_456_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_459_22 = 0
			local var_459_23 = 1.125

			if var_459_22 < arg_456_1.time_ and arg_456_1.time_ <= var_459_22 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_24 = arg_456_1:FormatText(StoryNameCfg[1562].name)

				arg_456_1.leftNameTxt_.text = var_459_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_25 = arg_456_1:GetWordFromCfg(938081111)
				local var_459_26 = arg_456_1:FormatText(var_459_25.content)

				arg_456_1.text_.text = var_459_26

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_27 = 45
				local var_459_28 = utf8.len(var_459_26)
				local var_459_29 = var_459_27 <= 0 and var_459_23 or var_459_23 * (var_459_28 / var_459_27)

				if var_459_29 > 0 and var_459_23 < var_459_29 then
					arg_456_1.talkMaxDuration = var_459_29

					if var_459_29 + var_459_22 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_29 + var_459_22
					end
				end

				arg_456_1.text_.text = var_459_26
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_30 = math.max(var_459_23, arg_456_1.talkMaxDuration)

			if var_459_22 <= arg_456_1.time_ and arg_456_1.time_ < var_459_22 + var_459_30 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_22) / var_459_30

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_22 + var_459_30 and arg_456_1.time_ < var_459_22 + var_459_30 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play938081112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 938081112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play938081113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["10183"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos10183 = var_463_0.localPosition
				var_463_0.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10183", 3)

				local var_463_2 = var_463_0.childCount

				for iter_463_0 = 0, var_463_2 - 1 do
					local var_463_3 = var_463_0:GetChild(iter_463_0)

					if var_463_3.name == "split_8" then
						var_463_3:SetAsLastSibling()
						var_463_3.gameObject:SetActive(true)

						arg_460_1.var_.actorSpriteSplit10183 = var_463_3.gameObject:GetComponent(typeof(Image))

						arg_460_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_463_4 = 0.5

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_4 then
				local var_463_5 = (arg_460_1.time_ - var_463_1) / var_463_4
				local var_463_6 = Vector3.New(0, -475, -325)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10183, var_463_6, var_463_5)

				if arg_460_1.var_.actorSpriteSplit10183 ~= nil then
					arg_460_1.var_.actorSpriteSplit10183:SetAlpha(var_463_5)
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_4 and arg_460_1.time_ < var_463_1 + var_463_4 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0, -475, -325)

				if arg_460_1.var_.actorSpriteSplit10183 ~= nil then
					arg_460_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_463_7 = 0
			local var_463_8 = 1.025

			if var_463_7 < arg_460_1.time_ and arg_460_1.time_ <= var_463_7 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_9 = arg_460_1:FormatText(StoryNameCfg[1562].name)

				arg_460_1.leftNameTxt_.text = var_463_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_10 = arg_460_1:GetWordFromCfg(938081112)
				local var_463_11 = arg_460_1:FormatText(var_463_10.content)

				arg_460_1.text_.text = var_463_11

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_12 = 41
				local var_463_13 = utf8.len(var_463_11)
				local var_463_14 = var_463_12 <= 0 and var_463_8 or var_463_8 * (var_463_13 / var_463_12)

				if var_463_14 > 0 and var_463_8 < var_463_14 then
					arg_460_1.talkMaxDuration = var_463_14

					if var_463_14 + var_463_7 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_14 + var_463_7
					end
				end

				arg_460_1.text_.text = var_463_11
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_15 = math.max(var_463_8, arg_460_1.talkMaxDuration)

			if var_463_7 <= arg_460_1.time_ and arg_460_1.time_ < var_463_7 + var_463_15 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_7) / var_463_15

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_7 + var_463_15 and arg_460_1.time_ < var_463_7 + var_463_15 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play938081113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 938081113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play938081114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["10183"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10183 == nil then
				arg_464_1.var_.actorSpriteComps10183 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps10183 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								local var_467_4 = Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor2.r, var_467_3)
								local var_467_5 = Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor2.g, var_467_3)
								local var_467_6 = Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor2.b, var_467_3)

								iter_467_1.color = Color.New(var_467_4, var_467_5, var_467_6)
							else
								local var_467_7 = Mathf.Lerp(iter_467_1.color.r, 0.5, var_467_3)

								iter_467_1.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10183 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10183 = nil
			end

			local var_467_8 = arg_464_1.actors_["10183"].transform
			local var_467_9 = 0

			if var_467_9 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 then
				arg_464_1.var_.moveOldPos10183 = var_467_8.localPosition
				var_467_8.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10183", 3)

				local var_467_10 = var_467_8.childCount

				for iter_467_4 = 0, var_467_10 - 1 do
					local var_467_11 = var_467_8:GetChild(iter_467_4)

					if var_467_11.name == "" or not string.find(var_467_11.name, "split") then
						var_467_11.gameObject:SetActive(true)
					else
						var_467_11.gameObject:SetActive(false)
					end
				end
			end

			local var_467_12 = 0.6

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_12 then
				local var_467_13 = (arg_464_1.time_ - var_467_9) / var_467_12
				local var_467_14 = Vector3.New(-800, -475, -325)

				var_467_8.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10183, var_467_14, var_467_13)
			end

			if arg_464_1.time_ >= var_467_9 + var_467_12 and arg_464_1.time_ < var_467_9 + var_467_12 + arg_467_0 then
				var_467_8.localPosition = Vector3.New(-800, -475, -325)
			end

			local var_467_15 = 0
			local var_467_16 = 0.95

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_17 = arg_464_1:GetWordFromCfg(938081113)
				local var_467_18 = arg_464_1:FormatText(var_467_17.content)

				arg_464_1.text_.text = var_467_18

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_19 = 38
				local var_467_20 = utf8.len(var_467_18)
				local var_467_21 = var_467_19 <= 0 and var_467_16 or var_467_16 * (var_467_20 / var_467_19)

				if var_467_21 > 0 and var_467_16 < var_467_21 then
					arg_464_1.talkMaxDuration = var_467_21

					if var_467_21 + var_467_15 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_21 + var_467_15
					end
				end

				arg_464_1.text_.text = var_467_18
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_22 = math.max(var_467_16, arg_464_1.talkMaxDuration)

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_22 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_15) / var_467_22

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_15 + var_467_22 and arg_464_1.time_ < var_467_15 + var_467_22 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "10183",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -475, -325),
					endPos = Vector3.New(-800, -475, -325),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play938081114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 938081114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play938081115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.85

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(938081114)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 34
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play938081115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 938081115
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play938081116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 1.05

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_2 = arg_472_1:GetWordFromCfg(938081115)
				local var_475_3 = arg_472_1:FormatText(var_475_2.content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 42
				local var_475_5 = utf8.len(var_475_3)
				local var_475_6 = var_475_4 <= 0 and var_475_1 or var_475_1 * (var_475_5 / var_475_4)

				if var_475_6 > 0 and var_475_1 < var_475_6 then
					arg_472_1.talkMaxDuration = var_475_6

					if var_475_6 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_7 and arg_472_1.time_ < var_475_0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play938081116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 938081116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play938081117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 1

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_2 = arg_476_1:GetWordFromCfg(938081116)
				local var_479_3 = arg_476_1:FormatText(var_479_2.content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 40
				local var_479_5 = utf8.len(var_479_3)
				local var_479_6 = var_479_4 <= 0 and var_479_1 or var_479_1 * (var_479_5 / var_479_4)

				if var_479_6 > 0 and var_479_1 < var_479_6 then
					arg_476_1.talkMaxDuration = var_479_6

					if var_479_6 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_7 and arg_476_1.time_ < var_479_0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play938081117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 938081117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
			arg_480_1.auto_ = false
		end

		function arg_480_1.playNext_(arg_482_0)
			arg_480_1.onStoryFinished_()
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.3

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[7].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_3 = arg_480_1:GetWordFromCfg(938081117)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 12
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_8 and arg_480_1.time_ < var_483_0 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I20f",
		"TextureConfig/Background/H02a"
	},
	voices = {}
}
