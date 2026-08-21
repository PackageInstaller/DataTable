return {
	Play900701001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 900701001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play900701002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST22a"

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
				local var_4_5 = arg_1_1.bgs_.ST22a

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
					if iter_4_0 ~= "ST22a" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_28 = 1.96666666666667
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2
			local var_4_35 = 1.125

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(900701001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 45
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play900701002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 900701002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play900701003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.5

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(900701002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 20
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play900701003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 900701003
		arg_13_1.duration_ = 5.2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play900701004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10022"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["10022"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 2)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_6" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(-390, -350, -180)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_16_11 = arg_13_1.actors_["10022"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				local var_16_13 = var_16_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_13 then
					arg_13_1.var_.alphaOldValue10022 = var_16_13.alpha
					arg_13_1.var_.characterEffect10022 = var_16_13
				end

				arg_13_1.var_.alphaOldValue10022 = 0
			end

			local var_16_14 = 0.2

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_14 then
				local var_16_15 = (arg_13_1.time_ - var_16_12) / var_16_14
				local var_16_16 = Mathf.Lerp(arg_13_1.var_.alphaOldValue10022, 1, var_16_15)

				if arg_13_1.var_.characterEffect10022 then
					arg_13_1.var_.characterEffect10022.alpha = var_16_16
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_14 and arg_13_1.time_ < var_16_12 + var_16_14 + arg_16_0 and arg_13_1.var_.characterEffect10022 then
				arg_13_1.var_.characterEffect10022.alpha = 1
			end

			local var_16_17 = arg_13_1.actors_["10022"]
			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_19 = 0.2

			if var_16_18 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 and not isNil(var_16_17) then
				local var_16_20 = (arg_13_1.time_ - var_16_18) / var_16_19

				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_21 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_20)
								local var_16_22 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_20)
								local var_16_23 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_20)

								iter_16_4.color = Color.New(var_16_21, var_16_22, var_16_23)
							else
								local var_16_24 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_20)

								iter_16_4.color = Color.New(var_16_24, var_16_24, var_16_24)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 and not isNil(var_16_17) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_25 = 0.2
			local var_16_26 = 0.3

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_27 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_27:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_28 = arg_13_1:FormatText(StoryNameCfg[235].name)

				arg_13_1.leftNameTxt_.text = var_16_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_29 = arg_13_1:GetWordFromCfg(900701003)
				local var_16_30 = arg_13_1:FormatText(var_16_29.content)

				arg_13_1.text_.text = var_16_30

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_31 = 12
				local var_16_32 = utf8.len(var_16_30)
				local var_16_33 = var_16_31 <= 0 and var_16_26 or var_16_26 * (var_16_32 / var_16_31)

				if var_16_33 > 0 and var_16_26 < var_16_33 then
					arg_13_1.talkMaxDuration = var_16_33
					var_16_25 = var_16_25 + 0.3

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_30
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_34 = var_16_25 + 0.3
			local var_16_35 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_34 <= arg_13_1.time_ and arg_13_1.time_ < var_16_34 + var_16_35 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_34) / var_16_35

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_34 + var_16_35 and arg_13_1.time_ < var_16_34 + var_16_35 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play900701004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 900701004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play900701005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1033"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(var_22_1, arg_19_1.canvasGo_.transform)

					var_22_2.transform:SetSiblingIndex(1)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs(var_22_3) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_4 = arg_19_1.actors_["1033"].transform
			local var_22_5 = 0

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.var_.moveOldPos1033 = var_22_4.localPosition
				var_22_4.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1033", 4)

				local var_22_6 = var_22_4.childCount

				for iter_22_2 = 0, var_22_6 - 1 do
					local var_22_7 = var_22_4:GetChild(iter_22_2)

					if var_22_7.name == "split_5" or not string.find(var_22_7.name, "split") then
						var_22_7.gameObject:SetActive(true)
					else
						var_22_7.gameObject:SetActive(false)
					end
				end
			end

			local var_22_8 = 0.001

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_8 then
				local var_22_9 = (arg_19_1.time_ - var_22_5) / var_22_8
				local var_22_10 = Vector3.New(390, -420, 0)

				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1033, var_22_10, var_22_9)
			end

			if arg_19_1.time_ >= var_22_5 + var_22_8 and arg_19_1.time_ < var_22_5 + var_22_8 + arg_22_0 then
				var_22_4.localPosition = Vector3.New(390, -420, 0)
			end

			local var_22_11 = arg_19_1.actors_["1033"]
			local var_22_12 = 0

			if var_22_12 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				local var_22_13 = var_22_11:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_13 then
					arg_19_1.var_.alphaOldValue1033 = var_22_13.alpha
					arg_19_1.var_.characterEffect1033 = var_22_13
				end

				arg_19_1.var_.alphaOldValue1033 = 0
			end

			local var_22_14 = 0.2

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_14 then
				local var_22_15 = (arg_19_1.time_ - var_22_12) / var_22_14
				local var_22_16 = Mathf.Lerp(arg_19_1.var_.alphaOldValue1033, 1, var_22_15)

				if arg_19_1.var_.characterEffect1033 then
					arg_19_1.var_.characterEffect1033.alpha = var_22_16
				end
			end

			if arg_19_1.time_ >= var_22_12 + var_22_14 and arg_19_1.time_ < var_22_12 + var_22_14 + arg_22_0 and arg_19_1.var_.characterEffect1033 then
				arg_19_1.var_.characterEffect1033.alpha = 1
			end

			local var_22_17 = arg_19_1.actors_["1033"]
			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 and not isNil(var_22_17) and arg_19_1.var_.actorSpriteComps1033 == nil then
				arg_19_1.var_.actorSpriteComps1033 = var_22_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_19 = 0.2

			if var_22_18 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 and not isNil(var_22_17) then
				local var_22_20 = (arg_19_1.time_ - var_22_18) / var_22_19

				if arg_19_1.var_.actorSpriteComps1033 then
					for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_22_4 then
							if arg_19_1.isInRecall_ then
								local var_22_21 = Mathf.Lerp(iter_22_4.color.r, arg_19_1.hightColor1.r, var_22_20)
								local var_22_22 = Mathf.Lerp(iter_22_4.color.g, arg_19_1.hightColor1.g, var_22_20)
								local var_22_23 = Mathf.Lerp(iter_22_4.color.b, arg_19_1.hightColor1.b, var_22_20)

								iter_22_4.color = Color.New(var_22_21, var_22_22, var_22_23)
							else
								local var_22_24 = Mathf.Lerp(iter_22_4.color.r, 1, var_22_20)

								iter_22_4.color = Color.New(var_22_24, var_22_24, var_22_24)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 and not isNil(var_22_17) and arg_19_1.var_.actorSpriteComps1033 then
				for iter_22_5, iter_22_6 in pairs(arg_19_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_22_6 then
						if arg_19_1.isInRecall_ then
							iter_22_6.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_22_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps1033 = nil
			end

			local var_22_25 = arg_19_1.actors_["10022"]
			local var_22_26 = 0

			if var_22_26 < arg_19_1.time_ and arg_19_1.time_ <= var_22_26 + arg_22_0 and not isNil(var_22_25) and arg_19_1.var_.actorSpriteComps10022 == nil then
				arg_19_1.var_.actorSpriteComps10022 = var_22_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_27 = 0.2

			if var_22_26 <= arg_19_1.time_ and arg_19_1.time_ < var_22_26 + var_22_27 and not isNil(var_22_25) then
				local var_22_28 = (arg_19_1.time_ - var_22_26) / var_22_27

				if arg_19_1.var_.actorSpriteComps10022 then
					for iter_22_7, iter_22_8 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_22_8 then
							if arg_19_1.isInRecall_ then
								local var_22_29 = Mathf.Lerp(iter_22_8.color.r, arg_19_1.hightColor2.r, var_22_28)
								local var_22_30 = Mathf.Lerp(iter_22_8.color.g, arg_19_1.hightColor2.g, var_22_28)
								local var_22_31 = Mathf.Lerp(iter_22_8.color.b, arg_19_1.hightColor2.b, var_22_28)

								iter_22_8.color = Color.New(var_22_29, var_22_30, var_22_31)
							else
								local var_22_32 = Mathf.Lerp(iter_22_8.color.r, 0.5, var_22_28)

								iter_22_8.color = Color.New(var_22_32, var_22_32, var_22_32)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_26 + var_22_27 and arg_19_1.time_ < var_22_26 + var_22_27 + arg_22_0 and not isNil(var_22_25) and arg_19_1.var_.actorSpriteComps10022 then
				for iter_22_9, iter_22_10 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_22_10 then
						if arg_19_1.isInRecall_ then
							iter_22_10.color = arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_22_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps10022 = nil
			end

			local var_22_33 = 0
			local var_22_34 = 0.875

			if var_22_33 < arg_19_1.time_ and arg_19_1.time_ <= var_22_33 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_35 = arg_19_1:FormatText(StoryNameCfg[236].name)

				arg_19_1.leftNameTxt_.text = var_22_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_36 = arg_19_1:GetWordFromCfg(900701004)
				local var_22_37 = arg_19_1:FormatText(var_22_36.content)

				arg_19_1.text_.text = var_22_37

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_38 = 35
				local var_22_39 = utf8.len(var_22_37)
				local var_22_40 = var_22_38 <= 0 and var_22_34 or var_22_34 * (var_22_39 / var_22_38)

				if var_22_40 > 0 and var_22_34 < var_22_40 then
					arg_19_1.talkMaxDuration = var_22_40

					if var_22_40 + var_22_33 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_40 + var_22_33
					end
				end

				arg_19_1.text_.text = var_22_37
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_41 = math.max(var_22_34, arg_19_1.talkMaxDuration)

			if var_22_33 <= arg_19_1.time_ and arg_19_1.time_ < var_22_33 + var_22_41 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_33) / var_22_41

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_33 + var_22_41 and arg_19_1.time_ < var_22_33 + var_22_41 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play900701005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 900701005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play900701006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.75

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[236].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_3 = arg_23_1:GetWordFromCfg(900701005)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 30
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play900701006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 900701006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play900701007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1033"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1033 == nil then
				arg_27_1.var_.actorSpriteComps1033 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1033 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1033 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps1033 = nil
			end

			local var_30_8 = arg_27_1.actors_["10022"]
			local var_30_9 = 0

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.actorSpriteComps10022 == nil then
				arg_27_1.var_.actorSpriteComps10022 = var_30_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_10 = 0.2

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_10 and not isNil(var_30_8) then
				local var_30_11 = (arg_27_1.time_ - var_30_9) / var_30_10

				if arg_27_1.var_.actorSpriteComps10022 then
					for iter_30_4, iter_30_5 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_30_5 then
							if arg_27_1.isInRecall_ then
								local var_30_12 = Mathf.Lerp(iter_30_5.color.r, arg_27_1.hightColor1.r, var_30_11)
								local var_30_13 = Mathf.Lerp(iter_30_5.color.g, arg_27_1.hightColor1.g, var_30_11)
								local var_30_14 = Mathf.Lerp(iter_30_5.color.b, arg_27_1.hightColor1.b, var_30_11)

								iter_30_5.color = Color.New(var_30_12, var_30_13, var_30_14)
							else
								local var_30_15 = Mathf.Lerp(iter_30_5.color.r, 1, var_30_11)

								iter_30_5.color = Color.New(var_30_15, var_30_15, var_30_15)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_9 + var_30_10 and arg_27_1.time_ < var_30_9 + var_30_10 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.actorSpriteComps10022 then
				for iter_30_6, iter_30_7 in pairs(arg_27_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_30_7 then
						if arg_27_1.isInRecall_ then
							iter_30_7.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_30_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10022 = nil
			end

			local var_30_16 = 0
			local var_30_17 = 0.675

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_18 = arg_27_1:FormatText(StoryNameCfg[235].name)

				arg_27_1.leftNameTxt_.text = var_30_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_19 = arg_27_1:GetWordFromCfg(900701006)
				local var_30_20 = arg_27_1:FormatText(var_30_19.content)

				arg_27_1.text_.text = var_30_20

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_21 = 27
				local var_30_22 = utf8.len(var_30_20)
				local var_30_23 = var_30_21 <= 0 and var_30_17 or var_30_17 * (var_30_22 / var_30_21)

				if var_30_23 > 0 and var_30_17 < var_30_23 then
					arg_27_1.talkMaxDuration = var_30_23

					if var_30_23 + var_30_16 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_23 + var_30_16
					end
				end

				arg_27_1.text_.text = var_30_20
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_24 = math.max(var_30_17, arg_27_1.talkMaxDuration)

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_24 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_16) / var_30_24

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_16 + var_30_24 and arg_27_1.time_ < var_30_16 + var_30_24 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play900701007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 900701007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play900701008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1033"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1033 == nil then
				arg_31_1.var_.actorSpriteComps1033 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 0.2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps1033 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								local var_34_4 = Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor1.r, var_34_3)
								local var_34_5 = Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor1.g, var_34_3)
								local var_34_6 = Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor1.b, var_34_3)

								iter_34_1.color = Color.New(var_34_4, var_34_5, var_34_6)
							else
								local var_34_7 = Mathf.Lerp(iter_34_1.color.r, 1, var_34_3)

								iter_34_1.color = Color.New(var_34_7, var_34_7, var_34_7)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps1033 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps1033 = nil
			end

			local var_34_8 = arg_31_1.actors_["10022"]
			local var_34_9 = 0

			if var_34_9 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = var_34_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_10 = 0.2

			if var_34_9 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_10 and not isNil(var_34_8) then
				local var_34_11 = (arg_31_1.time_ - var_34_9) / var_34_10

				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_34_5 then
							if arg_31_1.isInRecall_ then
								local var_34_12 = Mathf.Lerp(iter_34_5.color.r, arg_31_1.hightColor2.r, var_34_11)
								local var_34_13 = Mathf.Lerp(iter_34_5.color.g, arg_31_1.hightColor2.g, var_34_11)
								local var_34_14 = Mathf.Lerp(iter_34_5.color.b, arg_31_1.hightColor2.b, var_34_11)

								iter_34_5.color = Color.New(var_34_12, var_34_13, var_34_14)
							else
								local var_34_15 = Mathf.Lerp(iter_34_5.color.r, 0.5, var_34_11)

								iter_34_5.color = Color.New(var_34_15, var_34_15, var_34_15)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_9 + var_34_10 and arg_31_1.time_ < var_34_9 + var_34_10 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_6, iter_34_7 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_7 then
						if arg_31_1.isInRecall_ then
							iter_34_7.color = arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_34_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_16 = 0
			local var_34_17 = 0.975

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_18 = arg_31_1:FormatText(StoryNameCfg[236].name)

				arg_31_1.leftNameTxt_.text = var_34_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_19 = arg_31_1:GetWordFromCfg(900701007)
				local var_34_20 = arg_31_1:FormatText(var_34_19.content)

				arg_31_1.text_.text = var_34_20

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_21 = 39
				local var_34_22 = utf8.len(var_34_20)
				local var_34_23 = var_34_21 <= 0 and var_34_17 or var_34_17 * (var_34_22 / var_34_21)

				if var_34_23 > 0 and var_34_17 < var_34_23 then
					arg_31_1.talkMaxDuration = var_34_23

					if var_34_23 + var_34_16 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_16
					end
				end

				arg_31_1.text_.text = var_34_20
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_24 = math.max(var_34_17, arg_31_1.talkMaxDuration)

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_24 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_16) / var_34_24

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_16 + var_34_24 and arg_31_1.time_ < var_34_16 + var_34_24 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play900701008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 900701008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play900701009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.6

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[236].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(900701008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 24
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_8 and arg_35_1.time_ < var_38_0 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play900701009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 900701009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play900701010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1033"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1033 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1033", 4)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_5" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(390, -420, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1033, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_42_7 = 0
			local var_42_8 = 0.875

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_9 = arg_39_1:FormatText(StoryNameCfg[236].name)

				arg_39_1.leftNameTxt_.text = var_42_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(900701009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_12 = 35
				local var_42_13 = utf8.len(var_42_11)
				local var_42_14 = var_42_12 <= 0 and var_42_8 or var_42_8 * (var_42_13 / var_42_12)

				if var_42_14 > 0 and var_42_8 < var_42_14 then
					arg_39_1.talkMaxDuration = var_42_14

					if var_42_14 + var_42_7 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_7
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_15 = math.max(var_42_8, arg_39_1.talkMaxDuration)

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_15 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_7) / var_42_15

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_7 + var_42_15 and arg_39_1.time_ < var_42_7 + var_42_15 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play900701010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 900701010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play900701011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10022"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10022 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10022", 2)

				local var_46_2 = var_46_0.childCount

				for iter_46_0 = 0, var_46_2 - 1 do
					local var_46_3 = var_46_0:GetChild(iter_46_0)

					if var_46_3.name == "split_3" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_4 then
				local var_46_5 = (arg_43_1.time_ - var_46_1) / var_46_4
				local var_46_6 = Vector3.New(-390, -350, -180)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10022, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_46_7 = arg_43_1.actors_["10022"]
			local var_46_8 = 0

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10022 == nil then
				arg_43_1.var_.actorSpriteComps10022 = var_46_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 0.2

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 and not isNil(var_46_7) then
				local var_46_10 = (arg_43_1.time_ - var_46_8) / var_46_9

				if arg_43_1.var_.actorSpriteComps10022 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								local var_46_11 = Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor1.r, var_46_10)
								local var_46_12 = Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor1.g, var_46_10)
								local var_46_13 = Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor1.b, var_46_10)

								iter_46_2.color = Color.New(var_46_11, var_46_12, var_46_13)
							else
								local var_46_14 = Mathf.Lerp(iter_46_2.color.r, 1, var_46_10)

								iter_46_2.color = Color.New(var_46_14, var_46_14, var_46_14)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10022 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_46_4 then
						if arg_43_1.isInRecall_ then
							iter_46_4.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10022 = nil
			end

			local var_46_15 = arg_43_1.actors_["1033"]
			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.actorSpriteComps1033 == nil then
				arg_43_1.var_.actorSpriteComps1033 = var_46_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_17 = 0.2

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 and not isNil(var_46_15) then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17

				if arg_43_1.var_.actorSpriteComps1033 then
					for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_46_6 then
							if arg_43_1.isInRecall_ then
								local var_46_19 = Mathf.Lerp(iter_46_6.color.r, arg_43_1.hightColor2.r, var_46_18)
								local var_46_20 = Mathf.Lerp(iter_46_6.color.g, arg_43_1.hightColor2.g, var_46_18)
								local var_46_21 = Mathf.Lerp(iter_46_6.color.b, arg_43_1.hightColor2.b, var_46_18)

								iter_46_6.color = Color.New(var_46_19, var_46_20, var_46_21)
							else
								local var_46_22 = Mathf.Lerp(iter_46_6.color.r, 0.5, var_46_18)

								iter_46_6.color = Color.New(var_46_22, var_46_22, var_46_22)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.actorSpriteComps1033 then
				for iter_46_7, iter_46_8 in pairs(arg_43_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_46_8 then
						if arg_43_1.isInRecall_ then
							iter_46_8.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1033 = nil
			end

			local var_46_23 = 0
			local var_46_24 = 0.25

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_25 = arg_43_1:FormatText(StoryNameCfg[235].name)

				arg_43_1.leftNameTxt_.text = var_46_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_26 = arg_43_1:GetWordFromCfg(900701010)
				local var_46_27 = arg_43_1:FormatText(var_46_26.content)

				arg_43_1.text_.text = var_46_27

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_28 = 10
				local var_46_29 = utf8.len(var_46_27)
				local var_46_30 = var_46_28 <= 0 and var_46_24 or var_46_24 * (var_46_29 / var_46_28)

				if var_46_30 > 0 and var_46_24 < var_46_30 then
					arg_43_1.talkMaxDuration = var_46_30

					if var_46_30 + var_46_23 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_30 + var_46_23
					end
				end

				arg_43_1.text_.text = var_46_27
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_31 = math.max(var_46_24, arg_43_1.talkMaxDuration)

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_31 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_23) / var_46_31

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_23 + var_46_31 and arg_43_1.time_ < var_46_23 + var_46_31 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play900701011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 900701011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play900701012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1033"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1033 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("1033", 4)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_4" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(390, -420, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1033, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_50_7 = arg_47_1.actors_["10022"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10022 == nil then
				arg_47_1.var_.actorSpriteComps10022 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 0.2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 and not isNil(var_50_7) then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps10022 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								local var_50_11 = Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor2.r, var_50_10)
								local var_50_12 = Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor2.g, var_50_10)
								local var_50_13 = Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor2.b, var_50_10)

								iter_50_2.color = Color.New(var_50_11, var_50_12, var_50_13)
							else
								local var_50_14 = Mathf.Lerp(iter_50_2.color.r, 0.5, var_50_10)

								iter_50_2.color = Color.New(var_50_14, var_50_14, var_50_14)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10022 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_50_4 then
						if arg_47_1.isInRecall_ then
							iter_50_4.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10022 = nil
			end

			local var_50_15 = arg_47_1.actors_["1033"]
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps1033 == nil then
				arg_47_1.var_.actorSpriteComps1033 = var_50_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_17 = 0.2

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 and not isNil(var_50_15) then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17

				if arg_47_1.var_.actorSpriteComps1033 then
					for iter_50_5, iter_50_6 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_50_6 then
							if arg_47_1.isInRecall_ then
								local var_50_19 = Mathf.Lerp(iter_50_6.color.r, arg_47_1.hightColor1.r, var_50_18)
								local var_50_20 = Mathf.Lerp(iter_50_6.color.g, arg_47_1.hightColor1.g, var_50_18)
								local var_50_21 = Mathf.Lerp(iter_50_6.color.b, arg_47_1.hightColor1.b, var_50_18)

								iter_50_6.color = Color.New(var_50_19, var_50_20, var_50_21)
							else
								local var_50_22 = Mathf.Lerp(iter_50_6.color.r, 1, var_50_18)

								iter_50_6.color = Color.New(var_50_22, var_50_22, var_50_22)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.actorSpriteComps1033 then
				for iter_50_7, iter_50_8 in pairs(arg_47_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_50_8 then
						if arg_47_1.isInRecall_ then
							iter_50_8.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1033 = nil
			end

			local var_50_23 = 0
			local var_50_24 = 0.075

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_25 = arg_47_1:FormatText(StoryNameCfg[236].name)

				arg_47_1.leftNameTxt_.text = var_50_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_26 = arg_47_1:GetWordFromCfg(900701011)
				local var_50_27 = arg_47_1:FormatText(var_50_26.content)

				arg_47_1.text_.text = var_50_27

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_28 = 3
				local var_50_29 = utf8.len(var_50_27)
				local var_50_30 = var_50_28 <= 0 and var_50_24 or var_50_24 * (var_50_29 / var_50_28)

				if var_50_30 > 0 and var_50_24 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30

					if var_50_30 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_23
					end
				end

				arg_47_1.text_.text = var_50_27
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_31 = math.max(var_50_24, arg_47_1.talkMaxDuration)

			if var_50_23 <= arg_47_1.time_ and arg_47_1.time_ < var_50_23 + var_50_31 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_23) / var_50_31

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_23 + var_50_31 and arg_47_1.time_ < var_50_23 + var_50_31 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play900701012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 900701012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play900701013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1033"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1033 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1033", 4)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "split_2" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(390, -420, 0)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1033, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_54_7 = arg_51_1.actors_["1033"]
			local var_54_8 = 0

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps1033 == nil then
				arg_51_1.var_.actorSpriteComps1033 = var_54_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 0.2

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 and not isNil(var_54_7) then
				local var_54_10 = (arg_51_1.time_ - var_54_8) / var_54_9

				if arg_51_1.var_.actorSpriteComps1033 then
					for iter_54_1, iter_54_2 in pairs(arg_51_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_54_2 then
							if arg_51_1.isInRecall_ then
								local var_54_11 = Mathf.Lerp(iter_54_2.color.r, arg_51_1.hightColor1.r, var_54_10)
								local var_54_12 = Mathf.Lerp(iter_54_2.color.g, arg_51_1.hightColor1.g, var_54_10)
								local var_54_13 = Mathf.Lerp(iter_54_2.color.b, arg_51_1.hightColor1.b, var_54_10)

								iter_54_2.color = Color.New(var_54_11, var_54_12, var_54_13)
							else
								local var_54_14 = Mathf.Lerp(iter_54_2.color.r, 1, var_54_10)

								iter_54_2.color = Color.New(var_54_14, var_54_14, var_54_14)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.actorSpriteComps1033 then
				for iter_54_3, iter_54_4 in pairs(arg_51_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_54_4 then
						if arg_51_1.isInRecall_ then
							iter_54_4.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1033 = nil
			end

			local var_54_15 = arg_51_1.actors_["10022"].transform
			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.var_.moveOldPos10022 = var_54_15.localPosition
				var_54_15.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10022", 2)

				local var_54_17 = var_54_15.childCount

				for iter_54_5 = 0, var_54_17 - 1 do
					local var_54_18 = var_54_15:GetChild(iter_54_5)

					if var_54_18.name == "split_6" or not string.find(var_54_18.name, "split") then
						var_54_18.gameObject:SetActive(true)
					else
						var_54_18.gameObject:SetActive(false)
					end
				end
			end

			local var_54_19 = 0.001

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_19 then
				local var_54_20 = (arg_51_1.time_ - var_54_16) / var_54_19
				local var_54_21 = Vector3.New(-390, -350, -180)

				var_54_15.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10022, var_54_21, var_54_20)
			end

			if arg_51_1.time_ >= var_54_16 + var_54_19 and arg_51_1.time_ < var_54_16 + var_54_19 + arg_54_0 then
				var_54_15.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_54_22 = arg_51_1.actors_["10022"]
			local var_54_23 = 0

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.actorSpriteComps10022 == nil then
				arg_51_1.var_.actorSpriteComps10022 = var_54_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_24 = 0.2

			if var_54_23 <= arg_51_1.time_ and arg_51_1.time_ < var_54_23 + var_54_24 and not isNil(var_54_22) then
				local var_54_25 = (arg_51_1.time_ - var_54_23) / var_54_24

				if arg_51_1.var_.actorSpriteComps10022 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								local var_54_26 = Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, var_54_25)
								local var_54_27 = Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, var_54_25)
								local var_54_28 = Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, var_54_25)

								iter_54_7.color = Color.New(var_54_26, var_54_27, var_54_28)
							else
								local var_54_29 = Mathf.Lerp(iter_54_7.color.r, 0.5, var_54_25)

								iter_54_7.color = Color.New(var_54_29, var_54_29, var_54_29)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_23 + var_54_24 and arg_51_1.time_ < var_54_23 + var_54_24 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.actorSpriteComps10022 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_54_9 then
						if arg_51_1.isInRecall_ then
							iter_54_9.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10022 = nil
			end

			local var_54_30 = 0
			local var_54_31 = 0.15

			if var_54_30 < arg_51_1.time_ and arg_51_1.time_ <= var_54_30 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_32 = arg_51_1:FormatText(StoryNameCfg[236].name)

				arg_51_1.leftNameTxt_.text = var_54_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_33 = arg_51_1:GetWordFromCfg(900701012)
				local var_54_34 = arg_51_1:FormatText(var_54_33.content)

				arg_51_1.text_.text = var_54_34

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_35 = 6
				local var_54_36 = utf8.len(var_54_34)
				local var_54_37 = var_54_35 <= 0 and var_54_31 or var_54_31 * (var_54_36 / var_54_35)

				if var_54_37 > 0 and var_54_31 < var_54_37 then
					arg_51_1.talkMaxDuration = var_54_37

					if var_54_37 + var_54_30 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_37 + var_54_30
					end
				end

				arg_51_1.text_.text = var_54_34
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_38 = math.max(var_54_31, arg_51_1.talkMaxDuration)

			if var_54_30 <= arg_51_1.time_ and arg_51_1.time_ < var_54_30 + var_54_38 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_30) / var_54_38

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_30 + var_54_38 and arg_51_1.time_ < var_54_30 + var_54_38 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play900701013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 900701013
		arg_55_1.duration_ = 6.5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play900701014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "F01a"

			if arg_55_1.bgs_[var_58_0] == nil then
				local var_58_1 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_58_0)
				var_58_1.name = var_58_0
				var_58_1.transform.parent = arg_55_1.stage_.transform
				var_58_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_[var_58_0] = var_58_1
			end

			local var_58_2 = 0.500666666666667

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				local var_58_3 = manager.ui.mainCamera.transform.localPosition
				local var_58_4 = Vector3.New(0, 0, 10) + Vector3.New(var_58_3.x, var_58_3.y, 0)
				local var_58_5 = arg_55_1.bgs_.F01a

				var_58_5.transform.localPosition = var_58_4
				var_58_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_6 = var_58_5:GetComponent("SpriteRenderer")

				if var_58_6 and var_58_6.sprite then
					local var_58_7 = (var_58_5.transform.localPosition - var_58_3).z
					local var_58_8 = manager.ui.mainCameraCom_
					local var_58_9 = 2 * var_58_7 * Mathf.Tan(var_58_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_58_10 = var_58_9 * var_58_8.aspect
					local var_58_11 = var_58_6.sprite.bounds.size.x
					local var_58_12 = var_58_6.sprite.bounds.size.y
					local var_58_13 = var_58_10 / var_58_11
					local var_58_14 = var_58_9 / var_58_12
					local var_58_15 = var_58_14 < var_58_13 and var_58_13 or var_58_14

					var_58_5.transform.localScale = Vector3.New(var_58_15, var_58_15, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "F01a" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_17 = 0.5

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17
				local var_58_19 = Color.New(1, 1, 1)

				var_58_19.a = Mathf.Lerp(0, 1, var_58_18)
				arg_55_1.mask_.color = var_58_19
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				local var_58_20 = Color.New(1, 1, 1)

				var_58_20.a = 1
				arg_55_1.mask_.color = var_58_20
			end

			local var_58_21 = 0.500666666666667

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_22 = 1

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 then
				local var_58_23 = (arg_55_1.time_ - var_58_21) / var_58_22
				local var_58_24 = Color.New(1, 1, 1)

				var_58_24.a = Mathf.Lerp(1, 0, var_58_23)
				arg_55_1.mask_.color = var_58_24
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 then
				local var_58_25 = Color.New(1, 1, 1)
				local var_58_26 = 0

				arg_55_1.mask_.enabled = false
				var_58_25.a = var_58_26
				arg_55_1.mask_.color = var_58_25
			end

			local var_58_27 = arg_55_1.actors_["1033"].transform
			local var_58_28 = 0.466666666666667

			if var_58_28 < arg_55_1.time_ and arg_55_1.time_ <= var_58_28 + arg_58_0 then
				arg_55_1.var_.moveOldPos1033 = var_58_27.localPosition
				var_58_27.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1033", 7)

				local var_58_29 = var_58_27.childCount

				for iter_58_2 = 0, var_58_29 - 1 do
					local var_58_30 = var_58_27:GetChild(iter_58_2)

					if var_58_30.name == "split_2" or not string.find(var_58_30.name, "split") then
						var_58_30.gameObject:SetActive(true)
					else
						var_58_30.gameObject:SetActive(false)
					end
				end
			end

			local var_58_31 = 0.001

			if var_58_28 <= arg_55_1.time_ and arg_55_1.time_ < var_58_28 + var_58_31 then
				local var_58_32 = (arg_55_1.time_ - var_58_28) / var_58_31
				local var_58_33 = Vector3.New(0, -2000, 0)

				var_58_27.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1033, var_58_33, var_58_32)
			end

			if arg_55_1.time_ >= var_58_28 + var_58_31 and arg_55_1.time_ < var_58_28 + var_58_31 + arg_58_0 then
				var_58_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_34 = arg_55_1.actors_["1033"].transform
			local var_58_35 = 1.36666666666667

			if var_58_35 < arg_55_1.time_ and arg_55_1.time_ <= var_58_35 + arg_58_0 then
				arg_55_1.var_.moveOldPos1033 = var_58_34.localPosition
				var_58_34.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1033", 2)

				local var_58_36 = var_58_34.childCount

				for iter_58_3 = 0, var_58_36 - 1 do
					local var_58_37 = var_58_34:GetChild(iter_58_3)

					if var_58_37.name == "split_1" or not string.find(var_58_37.name, "split") then
						var_58_37.gameObject:SetActive(true)
					else
						var_58_37.gameObject:SetActive(false)
					end
				end
			end

			local var_58_38 = 0.001

			if var_58_35 <= arg_55_1.time_ and arg_55_1.time_ < var_58_35 + var_58_38 then
				local var_58_39 = (arg_55_1.time_ - var_58_35) / var_58_38
				local var_58_40 = Vector3.New(-390, -420, 0)

				var_58_34.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1033, var_58_40, var_58_39)
			end

			if arg_55_1.time_ >= var_58_35 + var_58_38 and arg_55_1.time_ < var_58_35 + var_58_38 + arg_58_0 then
				var_58_34.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_58_41 = arg_55_1.actors_["10022"].transform
			local var_58_42 = 0.466666666666667

			if var_58_42 < arg_55_1.time_ and arg_55_1.time_ <= var_58_42 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = var_58_41.localPosition
				var_58_41.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 7)

				local var_58_43 = var_58_41.childCount

				for iter_58_4 = 0, var_58_43 - 1 do
					local var_58_44 = var_58_41:GetChild(iter_58_4)

					if var_58_44.name == "split_6" or not string.find(var_58_44.name, "split") then
						var_58_44.gameObject:SetActive(true)
					else
						var_58_44.gameObject:SetActive(false)
					end
				end
			end

			local var_58_45 = 0.001

			if var_58_42 <= arg_55_1.time_ and arg_55_1.time_ < var_58_42 + var_58_45 then
				local var_58_46 = (arg_55_1.time_ - var_58_42) / var_58_45
				local var_58_47 = Vector3.New(0, -2000, -180)

				var_58_41.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, var_58_47, var_58_46)
			end

			if arg_55_1.time_ >= var_58_42 + var_58_45 and arg_55_1.time_ < var_58_42 + var_58_45 + arg_58_0 then
				var_58_41.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_58_48 = "1038"

			if arg_55_1.actors_[var_58_48] == nil then
				local var_58_49 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1038")

				if not isNil(var_58_49) then
					local var_58_50 = Object.Instantiate(var_58_49, arg_55_1.canvasGo_.transform)

					var_58_50.transform:SetSiblingIndex(1)

					var_58_50.name = var_58_48
					var_58_50.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_55_1.actors_[var_58_48] = var_58_50

					local var_58_51 = var_58_50:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_55_1.isInRecall_ then
						for iter_58_5, iter_58_6 in ipairs(var_58_51) do
							iter_58_6.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_58_52 = arg_55_1.actors_["1038"].transform
			local var_58_53 = 1.36666666666667

			if var_58_53 < arg_55_1.time_ and arg_55_1.time_ <= var_58_53 + arg_58_0 then
				arg_55_1.var_.moveOldPos1038 = var_58_52.localPosition
				var_58_52.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1038", 4)

				local var_58_54 = var_58_52.childCount

				for iter_58_7 = 0, var_58_54 - 1 do
					local var_58_55 = var_58_52:GetChild(iter_58_7)

					if var_58_55.name == "split_1" or not string.find(var_58_55.name, "split") then
						var_58_55.gameObject:SetActive(true)
					else
						var_58_55.gameObject:SetActive(false)
					end
				end
			end

			local var_58_56 = 0.001

			if var_58_53 <= arg_55_1.time_ and arg_55_1.time_ < var_58_53 + var_58_56 then
				local var_58_57 = (arg_55_1.time_ - var_58_53) / var_58_56
				local var_58_58 = Vector3.New(390, -400, 0)

				var_58_52.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1038, var_58_58, var_58_57)
			end

			if arg_55_1.time_ >= var_58_53 + var_58_56 and arg_55_1.time_ < var_58_53 + var_58_56 + arg_58_0 then
				var_58_52.localPosition = Vector3.New(390, -400, 0)
			end

			local var_58_59 = arg_55_1.actors_["1038"]
			local var_58_60 = 1.36666666666667

			if var_58_60 < arg_55_1.time_ and arg_55_1.time_ <= var_58_60 + arg_58_0 and not isNil(var_58_59) and arg_55_1.var_.actorSpriteComps1038 == nil then
				arg_55_1.var_.actorSpriteComps1038 = var_58_59:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_61 = 0.034

			if var_58_60 <= arg_55_1.time_ and arg_55_1.time_ < var_58_60 + var_58_61 and not isNil(var_58_59) then
				local var_58_62 = (arg_55_1.time_ - var_58_60) / var_58_61

				if arg_55_1.var_.actorSpriteComps1038 then
					for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_58_9 then
							if arg_55_1.isInRecall_ then
								local var_58_63 = Mathf.Lerp(iter_58_9.color.r, arg_55_1.hightColor2.r, var_58_62)
								local var_58_64 = Mathf.Lerp(iter_58_9.color.g, arg_55_1.hightColor2.g, var_58_62)
								local var_58_65 = Mathf.Lerp(iter_58_9.color.b, arg_55_1.hightColor2.b, var_58_62)

								iter_58_9.color = Color.New(var_58_63, var_58_64, var_58_65)
							else
								local var_58_66 = Mathf.Lerp(iter_58_9.color.r, 0.5, var_58_62)

								iter_58_9.color = Color.New(var_58_66, var_58_66, var_58_66)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_60 + var_58_61 and arg_55_1.time_ < var_58_60 + var_58_61 + arg_58_0 and not isNil(var_58_59) and arg_55_1.var_.actorSpriteComps1038 then
				for iter_58_10, iter_58_11 in pairs(arg_55_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_58_11 then
						if arg_55_1.isInRecall_ then
							iter_58_11.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1038 = nil
			end

			local var_58_67 = arg_55_1.actors_["1033"]
			local var_58_68 = 1.36666666666667

			if var_58_68 < arg_55_1.time_ and arg_55_1.time_ <= var_58_68 + arg_58_0 and not isNil(var_58_67) and arg_55_1.var_.actorSpriteComps1033 == nil then
				arg_55_1.var_.actorSpriteComps1033 = var_58_67:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_69 = 0.034

			if var_58_68 <= arg_55_1.time_ and arg_55_1.time_ < var_58_68 + var_58_69 and not isNil(var_58_67) then
				local var_58_70 = (arg_55_1.time_ - var_58_68) / var_58_69

				if arg_55_1.var_.actorSpriteComps1033 then
					for iter_58_12, iter_58_13 in pairs(arg_55_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_58_13 then
							if arg_55_1.isInRecall_ then
								local var_58_71 = Mathf.Lerp(iter_58_13.color.r, arg_55_1.hightColor1.r, var_58_70)
								local var_58_72 = Mathf.Lerp(iter_58_13.color.g, arg_55_1.hightColor1.g, var_58_70)
								local var_58_73 = Mathf.Lerp(iter_58_13.color.b, arg_55_1.hightColor1.b, var_58_70)

								iter_58_13.color = Color.New(var_58_71, var_58_72, var_58_73)
							else
								local var_58_74 = Mathf.Lerp(iter_58_13.color.r, 1, var_58_70)

								iter_58_13.color = Color.New(var_58_74, var_58_74, var_58_74)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_68 + var_58_69 and arg_55_1.time_ < var_58_68 + var_58_69 + arg_58_0 and not isNil(var_58_67) and arg_55_1.var_.actorSpriteComps1033 then
				for iter_58_14, iter_58_15 in pairs(arg_55_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_58_15 then
						if arg_55_1.isInRecall_ then
							iter_58_15.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_15.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1033 = nil
			end

			local var_58_75 = arg_55_1.actors_["1033"]
			local var_58_76 = 1.36666666666667

			if var_58_76 < arg_55_1.time_ and arg_55_1.time_ <= var_58_76 + arg_58_0 then
				local var_58_77 = var_58_75:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_77 then
					arg_55_1.var_.alphaOldValue1033 = var_58_77.alpha
					arg_55_1.var_.characterEffect1033 = var_58_77
				end

				arg_55_1.var_.alphaOldValue1033 = 0
			end

			local var_58_78 = 0.2

			if var_58_76 <= arg_55_1.time_ and arg_55_1.time_ < var_58_76 + var_58_78 then
				local var_58_79 = (arg_55_1.time_ - var_58_76) / var_58_78
				local var_58_80 = Mathf.Lerp(arg_55_1.var_.alphaOldValue1033, 1, var_58_79)

				if arg_55_1.var_.characterEffect1033 then
					arg_55_1.var_.characterEffect1033.alpha = var_58_80
				end
			end

			if arg_55_1.time_ >= var_58_76 + var_58_78 and arg_55_1.time_ < var_58_76 + var_58_78 + arg_58_0 and arg_55_1.var_.characterEffect1033 then
				arg_55_1.var_.characterEffect1033.alpha = 1
			end

			local var_58_81 = arg_55_1.actors_["1038"]
			local var_58_82 = 1.36666666666667

			if var_58_82 < arg_55_1.time_ and arg_55_1.time_ <= var_58_82 + arg_58_0 then
				local var_58_83 = var_58_81:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_83 then
					arg_55_1.var_.alphaOldValue1038 = var_58_83.alpha
					arg_55_1.var_.characterEffect1038 = var_58_83
				end

				arg_55_1.var_.alphaOldValue1038 = 0
			end

			local var_58_84 = 0.2

			if var_58_82 <= arg_55_1.time_ and arg_55_1.time_ < var_58_82 + var_58_84 then
				local var_58_85 = (arg_55_1.time_ - var_58_82) / var_58_84
				local var_58_86 = Mathf.Lerp(arg_55_1.var_.alphaOldValue1038, 1, var_58_85)

				if arg_55_1.var_.characterEffect1038 then
					arg_55_1.var_.characterEffect1038.alpha = var_58_86
				end
			end

			if arg_55_1.time_ >= var_58_82 + var_58_84 and arg_55_1.time_ < var_58_82 + var_58_84 + arg_58_0 and arg_55_1.var_.characterEffect1038 then
				arg_55_1.var_.characterEffect1038.alpha = 1
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_87 = 1.50066666666667
			local var_58_88 = 0.675

			if var_58_87 < arg_55_1.time_ and arg_55_1.time_ <= var_58_87 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_89 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_89:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_89:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_89:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_90 = arg_55_1:FormatText(StoryNameCfg[236].name)

				arg_55_1.leftNameTxt_.text = var_58_90

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_91 = arg_55_1:GetWordFromCfg(900701013)
				local var_58_92 = arg_55_1:FormatText(var_58_91.content)

				arg_55_1.text_.text = var_58_92

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_93 = 27
				local var_58_94 = utf8.len(var_58_92)
				local var_58_95 = var_58_93 <= 0 and var_58_88 or var_58_88 * (var_58_94 / var_58_93)

				if var_58_95 > 0 and var_58_88 < var_58_95 then
					arg_55_1.talkMaxDuration = var_58_95
					var_58_87 = var_58_87 + 0.3

					if var_58_95 + var_58_87 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_95 + var_58_87
					end
				end

				arg_55_1.text_.text = var_58_92
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_96 = var_58_87 + 0.3
			local var_58_97 = math.max(var_58_88, arg_55_1.talkMaxDuration)

			if var_58_96 <= arg_55_1.time_ and arg_55_1.time_ < var_58_96 + var_58_97 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_96) / var_58_97

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_96 + var_58_97 and arg_55_1.time_ < var_58_96 + var_58_97 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play900701014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 900701014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play900701015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1038"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1038 == nil then
				arg_61_1.var_.actorSpriteComps1038 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1038 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1038 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1038 = nil
			end

			local var_64_8 = arg_61_1.actors_["1033"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1033 == nil then
				arg_61_1.var_.actorSpriteComps1033 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps1033 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps1033 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1033 = nil
			end

			local var_64_16 = 0
			local var_64_17 = 0.7

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_18 = arg_61_1:FormatText(StoryNameCfg[94].name)

				arg_61_1.leftNameTxt_.text = var_64_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_19 = arg_61_1:GetWordFromCfg(900701014)
				local var_64_20 = arg_61_1:FormatText(var_64_19.content)

				arg_61_1.text_.text = var_64_20

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_21 = 28
				local var_64_22 = utf8.len(var_64_20)
				local var_64_23 = var_64_21 <= 0 and var_64_17 or var_64_17 * (var_64_22 / var_64_21)

				if var_64_23 > 0 and var_64_17 < var_64_23 then
					arg_61_1.talkMaxDuration = var_64_23

					if var_64_23 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_20
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_24 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_24 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_24

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_24 and arg_61_1.time_ < var_64_16 + var_64_24 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play900701015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 900701015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play900701016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1038"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1038 == nil then
				arg_65_1.var_.actorSpriteComps1038 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1038 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1038:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1038 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1038 = nil
			end

			local var_68_8 = arg_65_1.actors_["1033"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1033 == nil then
				arg_65_1.var_.actorSpriteComps1033 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps1033 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor1.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor1.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor1.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 1, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps1033 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1033 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.975

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[236].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(900701015)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 39
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_24 and arg_65_1.time_ < var_68_16 + var_68_24 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play900701016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 900701016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play900701017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.025

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[236].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(900701016)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 41
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play900701017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 900701017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play900701018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1033"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1033 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1033", 2)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_2" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(-390, -420, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1033, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_76_7 = 0
			local var_76_8 = 0.175

			if var_76_7 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_9 = arg_73_1:FormatText(StoryNameCfg[236].name)

				arg_73_1.leftNameTxt_.text = var_76_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(900701017)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 7
				local var_76_13 = utf8.len(var_76_11)
				local var_76_14 = var_76_12 <= 0 and var_76_8 or var_76_8 * (var_76_13 / var_76_12)

				if var_76_14 > 0 and var_76_8 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_15 and arg_73_1.time_ < var_76_7 + var_76_15 + arg_76_0 then
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
	Play900701018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 900701018
		arg_77_1.duration_ = 6.33

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play900701019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.5

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				local var_80_1 = manager.ui.mainCamera.transform.localPosition
				local var_80_2 = Vector3.New(0, 0, 10) + Vector3.New(var_80_1.x, var_80_1.y, 0)
				local var_80_3 = arg_77_1.bgs_.ST22a

				var_80_3.transform.localPosition = var_80_2
				var_80_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_4 = var_80_3:GetComponent("SpriteRenderer")

				if var_80_4 and var_80_4.sprite then
					local var_80_5 = (var_80_3.transform.localPosition - var_80_1).z
					local var_80_6 = manager.ui.mainCameraCom_
					local var_80_7 = 2 * var_80_5 * Mathf.Tan(var_80_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_8 = var_80_7 * var_80_6.aspect
					local var_80_9 = var_80_4.sprite.bounds.size.x
					local var_80_10 = var_80_4.sprite.bounds.size.y
					local var_80_11 = var_80_8 / var_80_9
					local var_80_12 = var_80_7 / var_80_10
					local var_80_13 = var_80_12 < var_80_11 and var_80_11 or var_80_12

					var_80_3.transform.localScale = Vector3.New(var_80_13, var_80_13, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "ST22a" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_15 = 0.5

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_15 then
				local var_80_16 = (arg_77_1.time_ - var_80_14) / var_80_15
				local var_80_17 = Color.New(1, 1, 1)

				var_80_17.a = Mathf.Lerp(0, 1, var_80_16)
				arg_77_1.mask_.color = var_80_17
			end

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 then
				local var_80_18 = Color.New(1, 1, 1)

				var_80_18.a = 1
				arg_77_1.mask_.color = var_80_18
			end

			local var_80_19 = 0.5

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_20 = 1

			if var_80_19 <= arg_77_1.time_ and arg_77_1.time_ < var_80_19 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_19) / var_80_20
				local var_80_22 = Color.New(1, 1, 1)

				var_80_22.a = Mathf.Lerp(1, 0, var_80_21)
				arg_77_1.mask_.color = var_80_22
			end

			if arg_77_1.time_ >= var_80_19 + var_80_20 and arg_77_1.time_ < var_80_19 + var_80_20 + arg_80_0 then
				local var_80_23 = Color.New(1, 1, 1)
				local var_80_24 = 0

				arg_77_1.mask_.enabled = false
				var_80_23.a = var_80_24
				arg_77_1.mask_.color = var_80_23
			end

			local var_80_25 = arg_77_1.actors_["1033"].transform
			local var_80_26 = 0.466666666666667

			if var_80_26 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_25.localPosition
				var_80_25.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 7)

				local var_80_27 = var_80_25.childCount

				for iter_80_2 = 0, var_80_27 - 1 do
					local var_80_28 = var_80_25:GetChild(iter_80_2)

					if var_80_28.name == "split_1" or not string.find(var_80_28.name, "split") then
						var_80_28.gameObject:SetActive(true)
					else
						var_80_28.gameObject:SetActive(false)
					end
				end
			end

			local var_80_29 = 0.001

			if var_80_26 <= arg_77_1.time_ and arg_77_1.time_ < var_80_26 + var_80_29 then
				local var_80_30 = (arg_77_1.time_ - var_80_26) / var_80_29
				local var_80_31 = Vector3.New(0, -2000, 0)

				var_80_25.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, var_80_31, var_80_30)
			end

			if arg_77_1.time_ >= var_80_26 + var_80_29 and arg_77_1.time_ < var_80_26 + var_80_29 + arg_80_0 then
				var_80_25.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_32 = arg_77_1.actors_["1033"].transform
			local var_80_33 = 0.500666666666667

			if var_80_33 < arg_77_1.time_ and arg_77_1.time_ <= var_80_33 + arg_80_0 then
				arg_77_1.var_.moveOldPos1033 = var_80_32.localPosition
				var_80_32.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1033", 4)

				local var_80_34 = var_80_32.childCount

				for iter_80_3 = 0, var_80_34 - 1 do
					local var_80_35 = var_80_32:GetChild(iter_80_3)

					if var_80_35.name == "split_2" or not string.find(var_80_35.name, "split") then
						var_80_35.gameObject:SetActive(true)
					else
						var_80_35.gameObject:SetActive(false)
					end
				end
			end

			local var_80_36 = 0.001

			if var_80_33 <= arg_77_1.time_ and arg_77_1.time_ < var_80_33 + var_80_36 then
				local var_80_37 = (arg_77_1.time_ - var_80_33) / var_80_36
				local var_80_38 = Vector3.New(390, -420, 0)

				var_80_32.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1033, var_80_38, var_80_37)
			end

			if arg_77_1.time_ >= var_80_33 + var_80_36 and arg_77_1.time_ < var_80_33 + var_80_36 + arg_80_0 then
				var_80_32.localPosition = Vector3.New(390, -420, 0)
			end

			local var_80_39 = arg_77_1.actors_["1038"].transform
			local var_80_40 = 0.466666666666667

			if var_80_40 < arg_77_1.time_ and arg_77_1.time_ <= var_80_40 + arg_80_0 then
				arg_77_1.var_.moveOldPos1038 = var_80_39.localPosition
				var_80_39.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1038", 7)

				local var_80_41 = var_80_39.childCount

				for iter_80_4 = 0, var_80_41 - 1 do
					local var_80_42 = var_80_39:GetChild(iter_80_4)

					if var_80_42.name == "split_1" or not string.find(var_80_42.name, "split") then
						var_80_42.gameObject:SetActive(true)
					else
						var_80_42.gameObject:SetActive(false)
					end
				end
			end

			local var_80_43 = 0.001

			if var_80_40 <= arg_77_1.time_ and arg_77_1.time_ < var_80_40 + var_80_43 then
				local var_80_44 = (arg_77_1.time_ - var_80_40) / var_80_43
				local var_80_45 = Vector3.New(0, -2000, 0)

				var_80_39.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1038, var_80_45, var_80_44)
			end

			if arg_77_1.time_ >= var_80_40 + var_80_43 and arg_77_1.time_ < var_80_40 + var_80_43 + arg_80_0 then
				var_80_39.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_46 = arg_77_1.actors_["10022"].transform
			local var_80_47 = 0.500666666666667

			if var_80_47 < arg_77_1.time_ and arg_77_1.time_ <= var_80_47 + arg_80_0 then
				arg_77_1.var_.moveOldPos10022 = var_80_46.localPosition
				var_80_46.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10022", 2)

				local var_80_48 = var_80_46.childCount

				for iter_80_5 = 0, var_80_48 - 1 do
					local var_80_49 = var_80_46:GetChild(iter_80_5)

					if var_80_49.name == "split_6" or not string.find(var_80_49.name, "split") then
						var_80_49.gameObject:SetActive(true)
					else
						var_80_49.gameObject:SetActive(false)
					end
				end
			end

			local var_80_50 = 0.001

			if var_80_47 <= arg_77_1.time_ and arg_77_1.time_ < var_80_47 + var_80_50 then
				local var_80_51 = (arg_77_1.time_ - var_80_47) / var_80_50
				local var_80_52 = Vector3.New(-390, -350, -180)

				var_80_46.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10022, var_80_52, var_80_51)
			end

			if arg_77_1.time_ >= var_80_47 + var_80_50 and arg_77_1.time_ < var_80_47 + var_80_50 + arg_80_0 then
				var_80_46.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_80_53 = arg_77_1.actors_["10022"]
			local var_80_54 = 0.5

			if var_80_54 < arg_77_1.time_ and arg_77_1.time_ <= var_80_54 + arg_80_0 and not isNil(var_80_53) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_53:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_55 = 0.0346666666666666

			if var_80_54 <= arg_77_1.time_ and arg_77_1.time_ < var_80_54 + var_80_55 and not isNil(var_80_53) then
				local var_80_56 = (arg_77_1.time_ - var_80_54) / var_80_55

				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								local var_80_57 = Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor2.r, var_80_56)
								local var_80_58 = Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor2.g, var_80_56)
								local var_80_59 = Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor2.b, var_80_56)

								iter_80_7.color = Color.New(var_80_57, var_80_58, var_80_59)
							else
								local var_80_60 = Mathf.Lerp(iter_80_7.color.r, 0.5, var_80_56)

								iter_80_7.color = Color.New(var_80_60, var_80_60, var_80_60)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_54 + var_80_55 and arg_77_1.time_ < var_80_54 + var_80_55 + arg_80_0 and not isNil(var_80_53) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_9 then
						if arg_77_1.isInRecall_ then
							iter_80_9.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_61 = arg_77_1.actors_["1033"]
			local var_80_62 = 0.5

			if var_80_62 < arg_77_1.time_ and arg_77_1.time_ <= var_80_62 + arg_80_0 and not isNil(var_80_61) and arg_77_1.var_.actorSpriteComps1033 == nil then
				arg_77_1.var_.actorSpriteComps1033 = var_80_61:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_63 = 0.034

			if var_80_62 <= arg_77_1.time_ and arg_77_1.time_ < var_80_62 + var_80_63 and not isNil(var_80_61) then
				local var_80_64 = (arg_77_1.time_ - var_80_62) / var_80_63

				if arg_77_1.var_.actorSpriteComps1033 then
					for iter_80_10, iter_80_11 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_80_11 then
							if arg_77_1.isInRecall_ then
								local var_80_65 = Mathf.Lerp(iter_80_11.color.r, arg_77_1.hightColor1.r, var_80_64)
								local var_80_66 = Mathf.Lerp(iter_80_11.color.g, arg_77_1.hightColor1.g, var_80_64)
								local var_80_67 = Mathf.Lerp(iter_80_11.color.b, arg_77_1.hightColor1.b, var_80_64)

								iter_80_11.color = Color.New(var_80_65, var_80_66, var_80_67)
							else
								local var_80_68 = Mathf.Lerp(iter_80_11.color.r, 1, var_80_64)

								iter_80_11.color = Color.New(var_80_68, var_80_68, var_80_68)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_62 + var_80_63 and arg_77_1.time_ < var_80_62 + var_80_63 + arg_80_0 and not isNil(var_80_61) and arg_77_1.var_.actorSpriteComps1033 then
				for iter_80_12, iter_80_13 in pairs(arg_77_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_80_13 then
						if arg_77_1.isInRecall_ then
							iter_80_13.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_13.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1033 = nil
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_69 = 1.33333333333333
			local var_80_70 = 0.825

			if var_80_69 < arg_77_1.time_ and arg_77_1.time_ <= var_80_69 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_71 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_71:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_72 = arg_77_1:FormatText(StoryNameCfg[236].name)

				arg_77_1.leftNameTxt_.text = var_80_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_73 = arg_77_1:GetWordFromCfg(900701018)
				local var_80_74 = arg_77_1:FormatText(var_80_73.content)

				arg_77_1.text_.text = var_80_74

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_75 = 33
				local var_80_76 = utf8.len(var_80_74)
				local var_80_77 = var_80_75 <= 0 and var_80_70 or var_80_70 * (var_80_76 / var_80_75)

				if var_80_77 > 0 and var_80_70 < var_80_77 then
					arg_77_1.talkMaxDuration = var_80_77
					var_80_69 = var_80_69 + 0.3

					if var_80_77 + var_80_69 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_77 + var_80_69
					end
				end

				arg_77_1.text_.text = var_80_74
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_78 = var_80_69 + 0.3
			local var_80_79 = math.max(var_80_70, arg_77_1.talkMaxDuration)

			if var_80_78 <= arg_77_1.time_ and arg_77_1.time_ < var_80_78 + var_80_79 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_78) / var_80_79

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_78 + var_80_79 and arg_77_1.time_ < var_80_78 + var_80_79 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.500666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.500666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play900701019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 900701019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play900701020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1033"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1033 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("1033", 4)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "split_5" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(390, -420, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1033, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_86_7 = arg_83_1.actors_["1033"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps1033 == nil then
				arg_83_1.var_.actorSpriteComps1033 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 0.034

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps1033 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								local var_86_11 = Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, var_86_10)
								local var_86_12 = Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, var_86_10)
								local var_86_13 = Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, var_86_10)

								iter_86_2.color = Color.New(var_86_11, var_86_12, var_86_13)
							else
								local var_86_14 = Mathf.Lerp(iter_86_2.color.r, 1, var_86_10)

								iter_86_2.color = Color.New(var_86_14, var_86_14, var_86_14)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps1033 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1033 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 0.1

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[236].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(900701019)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 4
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_23 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_23 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_23

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_23 and arg_83_1.time_ < var_86_15 + var_86_23 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play900701020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 900701020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play900701021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10022"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps10022 == nil then
				arg_87_1.var_.actorSpriteComps10022 = var_90_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_2 = 0.1

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.actorSpriteComps10022 then
					for iter_90_0, iter_90_1 in pairs(arg_87_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_90_1 then
							if arg_87_1.isInRecall_ then
								local var_90_4 = Mathf.Lerp(iter_90_1.color.r, arg_87_1.hightColor1.r, var_90_3)
								local var_90_5 = Mathf.Lerp(iter_90_1.color.g, arg_87_1.hightColor1.g, var_90_3)
								local var_90_6 = Mathf.Lerp(iter_90_1.color.b, arg_87_1.hightColor1.b, var_90_3)

								iter_90_1.color = Color.New(var_90_4, var_90_5, var_90_6)
							else
								local var_90_7 = Mathf.Lerp(iter_90_1.color.r, 1, var_90_3)

								iter_90_1.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.actorSpriteComps10022 then
				for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_90_3 then
						if arg_87_1.isInRecall_ then
							iter_90_3.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10022 = nil
			end

			local var_90_8 = arg_87_1.actors_["1033"]
			local var_90_9 = 0

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps1033 == nil then
				arg_87_1.var_.actorSpriteComps1033 = var_90_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_10 = 0.1

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 and not isNil(var_90_8) then
				local var_90_11 = (arg_87_1.time_ - var_90_9) / var_90_10

				if arg_87_1.var_.actorSpriteComps1033 then
					for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_90_5 then
							if arg_87_1.isInRecall_ then
								local var_90_12 = Mathf.Lerp(iter_90_5.color.r, arg_87_1.hightColor2.r, var_90_11)
								local var_90_13 = Mathf.Lerp(iter_90_5.color.g, arg_87_1.hightColor2.g, var_90_11)
								local var_90_14 = Mathf.Lerp(iter_90_5.color.b, arg_87_1.hightColor2.b, var_90_11)

								iter_90_5.color = Color.New(var_90_12, var_90_13, var_90_14)
							else
								local var_90_15 = Mathf.Lerp(iter_90_5.color.r, 0.5, var_90_11)

								iter_90_5.color = Color.New(var_90_15, var_90_15, var_90_15)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 and not isNil(var_90_8) and arg_87_1.var_.actorSpriteComps1033 then
				for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_90_7 then
						if arg_87_1.isInRecall_ then
							iter_90_7.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1033 = nil
			end

			local var_90_16 = 0
			local var_90_17 = 0.1

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_18 = arg_87_1:FormatText(StoryNameCfg[235].name)

				arg_87_1.leftNameTxt_.text = var_90_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_19 = arg_87_1:GetWordFromCfg(900701020)
				local var_90_20 = arg_87_1:FormatText(var_90_19.content)

				arg_87_1.text_.text = var_90_20

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_21 = 4
				local var_90_22 = utf8.len(var_90_20)
				local var_90_23 = var_90_21 <= 0 and var_90_17 or var_90_17 * (var_90_22 / var_90_21)

				if var_90_23 > 0 and var_90_17 < var_90_23 then
					arg_87_1.talkMaxDuration = var_90_23

					if var_90_23 + var_90_16 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_16
					end
				end

				arg_87_1.text_.text = var_90_20
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_24 = math.max(var_90_17, arg_87_1.talkMaxDuration)

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_24 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_16) / var_90_24

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_16 + var_90_24 and arg_87_1.time_ < var_90_16 + var_90_24 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play900701021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 900701021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play900701022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10022"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10022 == nil then
				arg_91_1.var_.actorSpriteComps10022 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.1

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps10022 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 0.5, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps10022 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10022 = nil
			end

			local var_94_8 = arg_91_1.actors_["1033"]
			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps1033 == nil then
				arg_91_1.var_.actorSpriteComps1033 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_10 = 0.1

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_10 and not isNil(var_94_8) then
				local var_94_11 = (arg_91_1.time_ - var_94_9) / var_94_10

				if arg_91_1.var_.actorSpriteComps1033 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								local var_94_12 = Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor1.r, var_94_11)
								local var_94_13 = Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor1.g, var_94_11)
								local var_94_14 = Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor1.b, var_94_11)

								iter_94_5.color = Color.New(var_94_12, var_94_13, var_94_14)
							else
								local var_94_15 = Mathf.Lerp(iter_94_5.color.r, 1, var_94_11)

								iter_94_5.color = Color.New(var_94_15, var_94_15, var_94_15)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_9 + var_94_10 and arg_91_1.time_ < var_94_9 + var_94_10 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps1033 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_94_7 then
						if arg_91_1.isInRecall_ then
							iter_94_7.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1033 = nil
			end

			local var_94_16 = 0
			local var_94_17 = 0.875

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_18 = arg_91_1:FormatText(StoryNameCfg[236].name)

				arg_91_1.leftNameTxt_.text = var_94_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:GetWordFromCfg(900701021)
				local var_94_20 = arg_91_1:FormatText(var_94_19.content)

				arg_91_1.text_.text = var_94_20

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 35
				local var_94_22 = utf8.len(var_94_20)
				local var_94_23 = var_94_21 <= 0 and var_94_17 or var_94_17 * (var_94_22 / var_94_21)

				if var_94_23 > 0 and var_94_17 < var_94_23 then
					arg_91_1.talkMaxDuration = var_94_23

					if var_94_23 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_16
					end
				end

				arg_91_1.text_.text = var_94_20
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_24 = math.max(var_94_17, arg_91_1.talkMaxDuration)

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_24 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_16) / var_94_24

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_16 + var_94_24 and arg_91_1.time_ < var_94_16 + var_94_24 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play900701022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 900701022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play900701023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.325

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[236].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(900701022)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 13
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play900701023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 900701023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play900701024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10022"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10022 == nil then
				arg_99_1.var_.actorSpriteComps10022 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.1

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps10022 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								local var_102_4 = Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor1.r, var_102_3)
								local var_102_5 = Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor1.g, var_102_3)
								local var_102_6 = Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor1.b, var_102_3)

								iter_102_1.color = Color.New(var_102_4, var_102_5, var_102_6)
							else
								local var_102_7 = Mathf.Lerp(iter_102_1.color.r, 1, var_102_3)

								iter_102_1.color = Color.New(var_102_7, var_102_7, var_102_7)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps10022 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps10022 = nil
			end

			local var_102_8 = arg_99_1.actors_["1033"]
			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps1033 == nil then
				arg_99_1.var_.actorSpriteComps1033 = var_102_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_10 = 0.1

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_10 and not isNil(var_102_8) then
				local var_102_11 = (arg_99_1.time_ - var_102_9) / var_102_10

				if arg_99_1.var_.actorSpriteComps1033 then
					for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_102_5 then
							if arg_99_1.isInRecall_ then
								local var_102_12 = Mathf.Lerp(iter_102_5.color.r, arg_99_1.hightColor2.r, var_102_11)
								local var_102_13 = Mathf.Lerp(iter_102_5.color.g, arg_99_1.hightColor2.g, var_102_11)
								local var_102_14 = Mathf.Lerp(iter_102_5.color.b, arg_99_1.hightColor2.b, var_102_11)

								iter_102_5.color = Color.New(var_102_12, var_102_13, var_102_14)
							else
								local var_102_15 = Mathf.Lerp(iter_102_5.color.r, 0.5, var_102_11)

								iter_102_5.color = Color.New(var_102_15, var_102_15, var_102_15)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_9 + var_102_10 and arg_99_1.time_ < var_102_9 + var_102_10 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps1033 then
				for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_102_7 then
						if arg_99_1.isInRecall_ then
							iter_102_7.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1033 = nil
			end

			local var_102_16 = 0
			local var_102_17 = 0.525

			if var_102_16 < arg_99_1.time_ and arg_99_1.time_ <= var_102_16 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_18 = arg_99_1:FormatText(StoryNameCfg[235].name)

				arg_99_1.leftNameTxt_.text = var_102_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_19 = arg_99_1:GetWordFromCfg(900701023)
				local var_102_20 = arg_99_1:FormatText(var_102_19.content)

				arg_99_1.text_.text = var_102_20

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_21 = 21
				local var_102_22 = utf8.len(var_102_20)
				local var_102_23 = var_102_21 <= 0 and var_102_17 or var_102_17 * (var_102_22 / var_102_21)

				if var_102_23 > 0 and var_102_17 < var_102_23 then
					arg_99_1.talkMaxDuration = var_102_23

					if var_102_23 + var_102_16 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_16
					end
				end

				arg_99_1.text_.text = var_102_20
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_24 = math.max(var_102_17, arg_99_1.talkMaxDuration)

			if var_102_16 <= arg_99_1.time_ and arg_99_1.time_ < var_102_16 + var_102_24 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_16) / var_102_24

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_16 + var_102_24 and arg_99_1.time_ < var_102_16 + var_102_24 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play900701024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 900701024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play900701025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10022"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10022 == nil then
				arg_103_1.var_.actorSpriteComps10022 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.1

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps10022 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 0.5, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps10022 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10022 = nil
			end

			local var_106_8 = arg_103_1.actors_["1033"]
			local var_106_9 = 0

			if var_106_9 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps1033 == nil then
				arg_103_1.var_.actorSpriteComps1033 = var_106_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_10 = 0.1

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 and not isNil(var_106_8) then
				local var_106_11 = (arg_103_1.time_ - var_106_9) / var_106_10

				if arg_103_1.var_.actorSpriteComps1033 then
					for iter_106_4, iter_106_5 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_106_5 then
							if arg_103_1.isInRecall_ then
								local var_106_12 = Mathf.Lerp(iter_106_5.color.r, arg_103_1.hightColor1.r, var_106_11)
								local var_106_13 = Mathf.Lerp(iter_106_5.color.g, arg_103_1.hightColor1.g, var_106_11)
								local var_106_14 = Mathf.Lerp(iter_106_5.color.b, arg_103_1.hightColor1.b, var_106_11)

								iter_106_5.color = Color.New(var_106_12, var_106_13, var_106_14)
							else
								local var_106_15 = Mathf.Lerp(iter_106_5.color.r, 1, var_106_11)

								iter_106_5.color = Color.New(var_106_15, var_106_15, var_106_15)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps1033 then
				for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_106_7 then
						if arg_103_1.isInRecall_ then
							iter_106_7.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1033 = nil
			end

			local var_106_16 = 0
			local var_106_17 = 0.5

			if var_106_16 < arg_103_1.time_ and arg_103_1.time_ <= var_106_16 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_18 = arg_103_1:FormatText(StoryNameCfg[236].name)

				arg_103_1.leftNameTxt_.text = var_106_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_19 = arg_103_1:GetWordFromCfg(900701024)
				local var_106_20 = arg_103_1:FormatText(var_106_19.content)

				arg_103_1.text_.text = var_106_20

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_21 = 20
				local var_106_22 = utf8.len(var_106_20)
				local var_106_23 = var_106_21 <= 0 and var_106_17 or var_106_17 * (var_106_22 / var_106_21)

				if var_106_23 > 0 and var_106_17 < var_106_23 then
					arg_103_1.talkMaxDuration = var_106_23

					if var_106_23 + var_106_16 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_16
					end
				end

				arg_103_1.text_.text = var_106_20
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_24 = math.max(var_106_17, arg_103_1.talkMaxDuration)

			if var_106_16 <= arg_103_1.time_ and arg_103_1.time_ < var_106_16 + var_106_24 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_16) / var_106_24

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_16 + var_106_24 and arg_103_1.time_ < var_106_16 + var_106_24 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play900701025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 900701025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play900701026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10022"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10022 == nil then
				arg_107_1.var_.actorSpriteComps10022 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.1

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps10022 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 1, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps10022 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10022 = nil
			end

			local var_110_8 = arg_107_1.actors_["1033"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1033 == nil then
				arg_107_1.var_.actorSpriteComps1033 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.1

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps1033 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								local var_110_12 = Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor2.r, var_110_11)
								local var_110_13 = Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor2.g, var_110_11)
								local var_110_14 = Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor2.b, var_110_11)

								iter_110_5.color = Color.New(var_110_12, var_110_13, var_110_14)
							else
								local var_110_15 = Mathf.Lerp(iter_110_5.color.r, 0.5, var_110_11)

								iter_110_5.color = Color.New(var_110_15, var_110_15, var_110_15)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps1033 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1033 = nil
			end

			local var_110_16 = 0
			local var_110_17 = 0.95

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_18 = arg_107_1:FormatText(StoryNameCfg[235].name)

				arg_107_1.leftNameTxt_.text = var_110_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_19 = arg_107_1:GetWordFromCfg(900701025)
				local var_110_20 = arg_107_1:FormatText(var_110_19.content)

				arg_107_1.text_.text = var_110_20

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_21 = 38
				local var_110_22 = utf8.len(var_110_20)
				local var_110_23 = var_110_21 <= 0 and var_110_17 or var_110_17 * (var_110_22 / var_110_21)

				if var_110_23 > 0 and var_110_17 < var_110_23 then
					arg_107_1.talkMaxDuration = var_110_23

					if var_110_23 + var_110_16 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_16
					end
				end

				arg_107_1.text_.text = var_110_20
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_24 = math.max(var_110_17, arg_107_1.talkMaxDuration)

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_24 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_16) / var_110_24

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_16 + var_110_24 and arg_107_1.time_ < var_110_16 + var_110_24 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play900701026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 900701026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play900701027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.925

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[235].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(900701026)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 37
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play900701027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 900701027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play900701028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.95

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[235].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(900701027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 38
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play900701028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 900701028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play900701029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10022"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10022 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10022", 2)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_7" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(-390, -350, -180)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10022, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_122_7 = 0
			local var_122_8 = 0.325

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_9 = arg_119_1:FormatText(StoryNameCfg[235].name)

				arg_119_1.leftNameTxt_.text = var_122_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(900701028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_12 = 13
				local var_122_13 = utf8.len(var_122_11)
				local var_122_14 = var_122_12 <= 0 and var_122_8 or var_122_8 * (var_122_13 / var_122_12)

				if var_122_14 > 0 and var_122_8 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14

					if var_122_14 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_15 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_15 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_15

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_15 and arg_119_1.time_ < var_122_7 + var_122_15 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play900701029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 900701029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play900701030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1033"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1033 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1033", 4)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "split_6" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(390, -420, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1033, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(390, -420, 0)
			end

			local var_126_7 = arg_123_1.actors_["10022"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.1

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								local var_126_11 = Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor2.r, var_126_10)
								local var_126_12 = Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor2.g, var_126_10)
								local var_126_13 = Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor2.b, var_126_10)

								iter_126_2.color = Color.New(var_126_11, var_126_12, var_126_13)
							else
								local var_126_14 = Mathf.Lerp(iter_126_2.color.r, 0.5, var_126_10)

								iter_126_2.color = Color.New(var_126_14, var_126_14, var_126_14)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_15 = arg_123_1.actors_["1033"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.actorSpriteComps1033 == nil then
				arg_123_1.var_.actorSpriteComps1033 = var_126_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_17 = 0.1

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.actorSpriteComps1033 then
					for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_126_6 then
							if arg_123_1.isInRecall_ then
								local var_126_19 = Mathf.Lerp(iter_126_6.color.r, arg_123_1.hightColor1.r, var_126_18)
								local var_126_20 = Mathf.Lerp(iter_126_6.color.g, arg_123_1.hightColor1.g, var_126_18)
								local var_126_21 = Mathf.Lerp(iter_126_6.color.b, arg_123_1.hightColor1.b, var_126_18)

								iter_126_6.color = Color.New(var_126_19, var_126_20, var_126_21)
							else
								local var_126_22 = Mathf.Lerp(iter_126_6.color.r, 1, var_126_18)

								iter_126_6.color = Color.New(var_126_22, var_126_22, var_126_22)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.actorSpriteComps1033 then
				for iter_126_7, iter_126_8 in pairs(arg_123_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_126_8 then
						if arg_123_1.isInRecall_ then
							iter_126_8.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1033 = nil
			end

			local var_126_23 = 0
			local var_126_24 = 0.175

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_25 = arg_123_1:FormatText(StoryNameCfg[236].name)

				arg_123_1.leftNameTxt_.text = var_126_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_26 = arg_123_1:GetWordFromCfg(900701029)
				local var_126_27 = arg_123_1:FormatText(var_126_26.content)

				arg_123_1.text_.text = var_126_27

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_28 = 7
				local var_126_29 = utf8.len(var_126_27)
				local var_126_30 = var_126_28 <= 0 and var_126_24 or var_126_24 * (var_126_29 / var_126_28)

				if var_126_30 > 0 and var_126_24 < var_126_30 then
					arg_123_1.talkMaxDuration = var_126_30

					if var_126_30 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_30 + var_126_23
					end
				end

				arg_123_1.text_.text = var_126_27
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = math.max(var_126_24, arg_123_1.talkMaxDuration)

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_31 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_23) / var_126_31

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_23 + var_126_31 and arg_123_1.time_ < var_126_23 + var_126_31 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play900701030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 900701030
		arg_127_1.duration_ = 8

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play900701031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "OM0602"

			if arg_127_1.bgs_[var_130_0] == nil then
				local var_130_1 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_130_0)
				var_130_1.name = var_130_0
				var_130_1.transform.parent = arg_127_1.stage_.transform
				var_130_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_[var_130_0] = var_130_1
			end

			local var_130_2 = 2

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				local var_130_3 = manager.ui.mainCamera.transform.localPosition
				local var_130_4 = Vector3.New(0, 0, 10) + Vector3.New(var_130_3.x, var_130_3.y, 0)
				local var_130_5 = arg_127_1.bgs_.OM0602

				var_130_5.transform.localPosition = var_130_4
				var_130_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_6 = var_130_5:GetComponent("SpriteRenderer")

				if var_130_6 and var_130_6.sprite then
					local var_130_7 = (var_130_5.transform.localPosition - var_130_3).z
					local var_130_8 = manager.ui.mainCameraCom_
					local var_130_9 = 2 * var_130_7 * Mathf.Tan(var_130_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_10 = var_130_9 * var_130_8.aspect
					local var_130_11 = var_130_6.sprite.bounds.size.x
					local var_130_12 = var_130_6.sprite.bounds.size.y
					local var_130_13 = var_130_10 / var_130_11
					local var_130_14 = var_130_9 / var_130_12
					local var_130_15 = var_130_14 < var_130_13 and var_130_13 or var_130_14

					var_130_5.transform.localScale = Vector3.New(var_130_15, var_130_15, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "OM0602" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_17 = 2

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Color.New(0, 0, 0)

				var_130_19.a = Mathf.Lerp(0, 1, var_130_18)
				arg_127_1.mask_.color = var_130_19
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				local var_130_20 = Color.New(0, 0, 0)

				var_130_20.a = 1
				arg_127_1.mask_.color = var_130_20
			end

			local var_130_21 = 2

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_22 = 1

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_22 then
				local var_130_23 = (arg_127_1.time_ - var_130_21) / var_130_22
				local var_130_24 = Color.New(0, 0, 0)

				var_130_24.a = Mathf.Lerp(1, 0, var_130_23)
				arg_127_1.mask_.color = var_130_24
			end

			if arg_127_1.time_ >= var_130_21 + var_130_22 and arg_127_1.time_ < var_130_21 + var_130_22 + arg_130_0 then
				local var_130_25 = Color.New(0, 0, 0)
				local var_130_26 = 0

				arg_127_1.mask_.enabled = false
				var_130_25.a = var_130_26
				arg_127_1.mask_.color = var_130_25
			end

			local var_130_27 = arg_127_1.actors_["1033"].transform
			local var_130_28 = 1.966

			if var_130_28 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				arg_127_1.var_.moveOldPos1033 = var_130_27.localPosition
				var_130_27.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1033", 7)

				local var_130_29 = var_130_27.childCount

				for iter_130_2 = 0, var_130_29 - 1 do
					local var_130_30 = var_130_27:GetChild(iter_130_2)

					if var_130_30.name == "split_6" or not string.find(var_130_30.name, "split") then
						var_130_30.gameObject:SetActive(true)
					else
						var_130_30.gameObject:SetActive(false)
					end
				end
			end

			local var_130_31 = 0.001

			if var_130_28 <= arg_127_1.time_ and arg_127_1.time_ < var_130_28 + var_130_31 then
				local var_130_32 = (arg_127_1.time_ - var_130_28) / var_130_31
				local var_130_33 = Vector3.New(0, -2000, 0)

				var_130_27.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1033, var_130_33, var_130_32)
			end

			if arg_127_1.time_ >= var_130_28 + var_130_31 and arg_127_1.time_ < var_130_28 + var_130_31 + arg_130_0 then
				var_130_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_34 = arg_127_1.actors_["10022"].transform
			local var_130_35 = 1.966

			if var_130_35 < arg_127_1.time_ and arg_127_1.time_ <= var_130_35 + arg_130_0 then
				arg_127_1.var_.moveOldPos10022 = var_130_34.localPosition
				var_130_34.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10022", 7)

				local var_130_36 = var_130_34.childCount

				for iter_130_3 = 0, var_130_36 - 1 do
					local var_130_37 = var_130_34:GetChild(iter_130_3)

					if var_130_37.name == "split_7" or not string.find(var_130_37.name, "split") then
						var_130_37.gameObject:SetActive(true)
					else
						var_130_37.gameObject:SetActive(false)
					end
				end
			end

			local var_130_38 = 0.001

			if var_130_35 <= arg_127_1.time_ and arg_127_1.time_ < var_130_35 + var_130_38 then
				local var_130_39 = (arg_127_1.time_ - var_130_35) / var_130_38
				local var_130_40 = Vector3.New(0, -2000, 0)

				var_130_34.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10022, var_130_40, var_130_39)
			end

			if arg_127_1.time_ >= var_130_35 + var_130_38 and arg_127_1.time_ < var_130_35 + var_130_38 + arg_130_0 then
				var_130_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_41 = manager.ui.mainCamera.transform
			local var_130_42 = 2.034

			if var_130_42 < arg_127_1.time_ and arg_127_1.time_ <= var_130_42 + arg_130_0 then
				arg_127_1.var_.shakeOldPos = var_130_41.localPosition
			end

			local var_130_43 = 1.166

			if var_130_42 <= arg_127_1.time_ and arg_127_1.time_ < var_130_42 + var_130_43 then
				local var_130_44 = (arg_127_1.time_ - var_130_42) / 0.066
				local var_130_45, var_130_46 = math.modf(var_130_44)

				var_130_41.localPosition = Vector3.New(var_130_46 * 0.13, var_130_46 * 0.13, var_130_46 * 0.13) + arg_127_1.var_.shakeOldPos
			end

			if arg_127_1.time_ >= var_130_42 + var_130_43 and arg_127_1.time_ < var_130_42 + var_130_43 + arg_130_0 then
				var_130_41.localPosition = arg_127_1.var_.shakeOldPos
			end

			local var_130_47 = arg_127_1.bgs_.OM0602.transform
			local var_130_48 = 2

			if var_130_48 < arg_127_1.time_ and arg_127_1.time_ <= var_130_48 + arg_130_0 then
				arg_127_1.var_.moveOldPosOM0602 = var_130_47.localPosition
				var_130_47.localScale = Vector3.New(1, 1, 1)
			end

			local var_130_49 = 0.001

			if var_130_48 <= arg_127_1.time_ and arg_127_1.time_ < var_130_48 + var_130_49 then
				local var_130_50 = (arg_127_1.time_ - var_130_48) / var_130_49
				local var_130_51 = Vector3.New(3.79, -0.64, 4.5)

				var_130_47.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPosOM0602, var_130_51, var_130_50)
			end

			if arg_127_1.time_ >= var_130_48 + var_130_49 and arg_127_1.time_ < var_130_48 + var_130_49 + arg_130_0 then
				var_130_47.localPosition = Vector3.New(3.79, -0.64, 4.5)
			end

			local var_130_52 = 3.1

			if var_130_52 < arg_127_1.time_ and arg_127_1.time_ <= var_130_52 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_53 = 0.3

			if var_130_52 <= arg_127_1.time_ and arg_127_1.time_ < var_130_52 + var_130_53 then
				local var_130_54 = (arg_127_1.time_ - var_130_52) / var_130_53
				local var_130_55 = Color.New(1, 1, 1)

				var_130_55.a = Mathf.Lerp(1, 0, var_130_54)
				arg_127_1.mask_.color = var_130_55
			end

			if arg_127_1.time_ >= var_130_52 + var_130_53 and arg_127_1.time_ < var_130_52 + var_130_53 + arg_130_0 then
				local var_130_56 = Color.New(1, 1, 1)
				local var_130_57 = 0

				arg_127_1.mask_.enabled = false
				var_130_56.a = var_130_57
				arg_127_1.mask_.color = var_130_56
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_58 = 3
			local var_130_59 = 0.2

			if var_130_58 < arg_127_1.time_ and arg_127_1.time_ <= var_130_58 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_60 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_60:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_61 = arg_127_1:FormatText(StoryNameCfg[236].name)

				arg_127_1.leftNameTxt_.text = var_130_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_62 = arg_127_1:GetWordFromCfg(900701030)
				local var_130_63 = arg_127_1:FormatText(var_130_62.content)

				arg_127_1.text_.text = var_130_63

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_64 = 8
				local var_130_65 = utf8.len(var_130_63)
				local var_130_66 = var_130_64 <= 0 and var_130_59 or var_130_59 * (var_130_65 / var_130_64)

				if var_130_66 > 0 and var_130_59 < var_130_66 then
					arg_127_1.talkMaxDuration = var_130_66
					var_130_58 = var_130_58 + 0.3

					if var_130_66 + var_130_58 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_66 + var_130_58
					end
				end

				arg_127_1.text_.text = var_130_63
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_67 = var_130_58 + 0.3
			local var_130_68 = math.max(var_130_59, arg_127_1.talkMaxDuration)

			if var_130_67 <= arg_127_1.time_ and arg_127_1.time_ < var_130_67 + var_130_68 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_67) / var_130_68

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_67 + var_130_68 and arg_127_1.time_ < var_130_67 + var_130_68 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play900701031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 900701031
		arg_133_1.duration_ = 5.57

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play900701032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.bgs_.OM0602.transform
			local var_136_1 = 0.0339999999999998

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPosOM0602 = var_136_0.localPosition
			end

			local var_136_2 = 1.091

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, 1, 10)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosOM0602, var_136_4, var_136_3)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_136_5 = arg_133_1.bgs_.OM0602.transform
			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.var_.moveOldPosOM0602 = var_136_5.localPosition
				var_136_5.localScale = Vector3.New(1, 1, 1)
			end

			local var_136_7 = 0.001

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_7 then
				local var_136_8 = (arg_133_1.time_ - var_136_6) / var_136_7
				local var_136_9 = Vector3.New(3.79, -0.64, 4.5)

				var_136_5.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPosOM0602, var_136_9, var_136_8)
			end

			if arg_133_1.time_ >= var_136_6 + var_136_7 and arg_133_1.time_ < var_136_6 + var_136_7 + arg_136_0 then
				var_136_5.localPosition = Vector3.New(3.79, -0.64, 4.5)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_10 = 0.566666666666667
			local var_136_11 = 0.125

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_12 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_12:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_13 = arg_133_1:FormatText(StoryNameCfg[235].name)

				arg_133_1.leftNameTxt_.text = var_136_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_14 = arg_133_1:GetWordFromCfg(900701031)
				local var_136_15 = arg_133_1:FormatText(var_136_14.content)

				arg_133_1.text_.text = var_136_15

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_16 = 5
				local var_136_17 = utf8.len(var_136_15)
				local var_136_18 = var_136_16 <= 0 and var_136_11 or var_136_11 * (var_136_17 / var_136_16)

				if var_136_18 > 0 and var_136_11 < var_136_18 then
					arg_133_1.talkMaxDuration = var_136_18
					var_136_10 = var_136_10 + 0.3

					if var_136_18 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_10
					end
				end

				arg_133_1.text_.text = var_136_15
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_19 = var_136_10 + 0.3
			local var_136_20 = math.max(var_136_11, arg_133_1.talkMaxDuration)

			if var_136_19 <= arg_133_1.time_ and arg_133_1.time_ < var_136_19 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_19) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_19 + var_136_20 and arg_133_1.time_ < var_136_19 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.091,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play900701032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 900701032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play900701033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.15

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[13].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119_1_split_1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(900701032)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 6
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play900701033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 900701033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play900701034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.425

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[68].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3021")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(900701033)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 17
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play900701034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 900701034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play900701035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.325

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[236].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(900701034)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 13
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play900701035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 900701035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play900701036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.6

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[235].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(900701035)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 24
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play900701036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 900701036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play900701037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.2

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[94].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1138_split_7")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(900701036)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 8
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play900701037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 900701037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play900701038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.075

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[236].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(900701037)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 3
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play900701038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 900701038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play900701039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.625

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[235].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(900701038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 25
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play900701039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 900701039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play900701040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.375

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[235].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(900701039)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 15
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play900701040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 900701040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play900701041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.175

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[236].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(900701040)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 7
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play900701041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 900701041
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play900701042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.45

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[13].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1119_1_split_6")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(900701041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 16
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play900701042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 900701042
		arg_179_1.duration_ = 7

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play900701043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = "OM0601"

			if arg_179_1.bgs_[var_182_0] == nil then
				local var_182_1 = Object.Instantiate(arg_179_1.paintGo_)

				var_182_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_182_0)
				var_182_1.name = var_182_0
				var_182_1.transform.parent = arg_179_1.stage_.transform
				var_182_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.bgs_[var_182_0] = var_182_1
			end

			local var_182_2 = 1

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				local var_182_3 = manager.ui.mainCamera.transform.localPosition
				local var_182_4 = Vector3.New(0, 0, 10) + Vector3.New(var_182_3.x, var_182_3.y, 0)
				local var_182_5 = arg_179_1.bgs_.OM0601

				var_182_5.transform.localPosition = var_182_4
				var_182_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_6 = var_182_5:GetComponent("SpriteRenderer")

				if var_182_6 and var_182_6.sprite then
					local var_182_7 = (var_182_5.transform.localPosition - var_182_3).z
					local var_182_8 = manager.ui.mainCameraCom_
					local var_182_9 = 2 * var_182_7 * Mathf.Tan(var_182_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_182_10 = var_182_9 * var_182_8.aspect
					local var_182_11 = var_182_6.sprite.bounds.size.x
					local var_182_12 = var_182_6.sprite.bounds.size.y
					local var_182_13 = var_182_10 / var_182_11
					local var_182_14 = var_182_9 / var_182_12
					local var_182_15 = var_182_14 < var_182_13 and var_182_13 or var_182_14

					var_182_5.transform.localScale = Vector3.New(var_182_15, var_182_15, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "OM0601" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_17 = 1

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17
				local var_182_19 = Color.New(1, 1, 1)

				var_182_19.a = Mathf.Lerp(0, 1, var_182_18)
				arg_179_1.mask_.color = var_182_19
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 then
				local var_182_20 = Color.New(1, 1, 1)

				var_182_20.a = 1
				arg_179_1.mask_.color = var_182_20
			end

			local var_182_21 = 1

			if var_182_21 < arg_179_1.time_ and arg_179_1.time_ <= var_182_21 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_22 = 1

			if var_182_21 <= arg_179_1.time_ and arg_179_1.time_ < var_182_21 + var_182_22 then
				local var_182_23 = (arg_179_1.time_ - var_182_21) / var_182_22
				local var_182_24 = Color.New(1, 1, 1)

				var_182_24.a = Mathf.Lerp(1, 0, var_182_23)
				arg_179_1.mask_.color = var_182_24
			end

			if arg_179_1.time_ >= var_182_21 + var_182_22 and arg_179_1.time_ < var_182_21 + var_182_22 + arg_182_0 then
				local var_182_25 = Color.New(1, 1, 1)
				local var_182_26 = 0

				arg_179_1.mask_.enabled = false
				var_182_25.a = var_182_26
				arg_179_1.mask_.color = var_182_25
			end

			local var_182_27 = arg_179_1.bgs_.OM0602.transform
			local var_182_28 = 0.966

			if var_182_28 < arg_179_1.time_ and arg_179_1.time_ <= var_182_28 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0602 = var_182_27.localPosition
			end

			local var_182_29 = 0.001

			if var_182_28 <= arg_179_1.time_ and arg_179_1.time_ < var_182_28 + var_182_29 then
				local var_182_30 = (arg_179_1.time_ - var_182_28) / var_182_29
				local var_182_31 = Vector3.New(0, 100, 10)

				var_182_27.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0602, var_182_31, var_182_30)
			end

			if arg_179_1.time_ >= var_182_28 + var_182_29 and arg_179_1.time_ < var_182_28 + var_182_29 + arg_182_0 then
				var_182_27.localPosition = Vector3.New(0, 100, 10)
			end

			local var_182_32 = arg_179_1.bgs_.OM0601.transform
			local var_182_33 = 1

			if var_182_33 < arg_179_1.time_ and arg_179_1.time_ <= var_182_33 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0601 = var_182_32.localPosition
			end

			local var_182_34 = 0.001

			if var_182_33 <= arg_179_1.time_ and arg_179_1.time_ < var_182_33 + var_182_34 then
				local var_182_35 = (arg_179_1.time_ - var_182_33) / var_182_34
				local var_182_36 = Vector3.New(-3.43, 1.67, 3.5)

				var_182_32.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0601, var_182_36, var_182_35)
			end

			if arg_179_1.time_ >= var_182_33 + var_182_34 and arg_179_1.time_ < var_182_33 + var_182_34 + arg_182_0 then
				var_182_32.localPosition = Vector3.New(-3.43, 1.67, 3.5)
			end

			local var_182_37 = arg_179_1.bgs_.OM0601.transform
			local var_182_38 = 1.034

			if var_182_38 < arg_179_1.time_ and arg_179_1.time_ <= var_182_38 + arg_182_0 then
				arg_179_1.var_.moveOldPosOM0601 = var_182_37.localPosition
			end

			local var_182_39 = 1.291

			if var_182_38 <= arg_179_1.time_ and arg_179_1.time_ < var_182_38 + var_182_39 then
				local var_182_40 = (arg_179_1.time_ - var_182_38) / var_182_39
				local var_182_41 = Vector3.New(-3.43, -0.25, 3.5)

				var_182_37.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPosOM0601, var_182_41, var_182_40)
			end

			if arg_179_1.time_ >= var_182_38 + var_182_39 and arg_179_1.time_ < var_182_38 + var_182_39 + arg_182_0 then
				var_182_37.localPosition = Vector3.New(-3.43, -0.25, 3.5)
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_42 = 2
			local var_182_43 = 0.325

			if var_182_42 < arg_179_1.time_ and arg_179_1.time_ <= var_182_42 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_44 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_44:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_45 = arg_179_1:FormatText(StoryNameCfg[13].name)

				arg_179_1.leftNameTxt_.text = var_182_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_46 = arg_179_1:GetWordFromCfg(900701042)
				local var_182_47 = arg_179_1:FormatText(var_182_46.content)

				arg_179_1.text_.text = var_182_47

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_48 = 13
				local var_182_49 = utf8.len(var_182_47)
				local var_182_50 = var_182_48 <= 0 and var_182_43 or var_182_43 * (var_182_49 / var_182_48)

				if var_182_50 > 0 and var_182_43 < var_182_50 then
					arg_179_1.talkMaxDuration = var_182_50
					var_182_42 = var_182_42 + 0.3

					if var_182_50 + var_182_42 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_50 + var_182_42
					end
				end

				arg_179_1.text_.text = var_182_47
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_51 = var_182_42 + 0.3
			local var_182_52 = math.max(var_182_43, arg_179_1.talkMaxDuration)

			if var_182_51 <= arg_179_1.time_ and arg_179_1.time_ < var_182_51 + var_182_52 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_51) / var_182_52

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_51 + var_182_52 and arg_179_1.time_ < var_182_51 + var_182_52 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.291,
				className = "StoryMoveNode",
				startTime = 1.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play900701043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 900701043
		arg_185_1.duration_ = 5.62

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play900701044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.bgs_.OM0601.transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPosOM0601 = var_188_0.localPosition
			end

			local var_188_2 = 1.5

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(3.75, 0.07, 3)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosOM0601, var_188_4, var_188_3)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(3.75, 0.07, 3)
			end

			local var_188_5 = 0.625
			local var_188_6 = 0.375

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_7 = arg_185_1:FormatText(StoryNameCfg[94].name)

				arg_185_1.leftNameTxt_.text = var_188_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(900701043)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 15
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_6 or var_188_6 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_6 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play900701044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 900701044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play900701045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.25

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[94].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(900701044)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 10
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play900701045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 900701045
		arg_193_1.duration_ = 5.37

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play900701046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.bgs_.OM0601.transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPosOM0601 = var_196_0.localPosition
			end

			local var_196_2 = 0.533333333333333

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, 1, 10)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPosOM0601, var_196_4, var_196_3)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_196_5 = 0.367333333333333
			local var_196_6 = 0.2

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_7 = arg_193_1:FormatText(StoryNameCfg[13].name)

				arg_193_1.leftNameTxt_.text = var_196_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(900701045)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 8
				local var_196_11 = utf8.len(var_196_9)
				local var_196_12 = var_196_10 <= 0 and var_196_6 or var_196_6 * (var_196_11 / var_196_10)

				if var_196_12 > 0 and var_196_6 < var_196_12 then
					arg_193_1.talkMaxDuration = var_196_12

					if var_196_12 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.533333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play900701046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 900701046
		arg_197_1.duration_ = 7.38

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play900701047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_1 = manager.ui.mainCamera.transform.localPosition
				local var_200_2 = Vector3.New(0, 0, 10) + Vector3.New(var_200_1.x, var_200_1.y, 0)
				local var_200_3 = arg_197_1.bgs_.OM0601

				var_200_3.transform.localPosition = var_200_2
				var_200_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_4 = var_200_3:GetComponent("SpriteRenderer")

				if var_200_4 and var_200_4.sprite then
					local var_200_5 = (var_200_3.transform.localPosition - var_200_1).z
					local var_200_6 = manager.ui.mainCameraCom_
					local var_200_7 = 2 * var_200_5 * Mathf.Tan(var_200_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_8 = var_200_7 * var_200_6.aspect
					local var_200_9 = var_200_4.sprite.bounds.size.x
					local var_200_10 = var_200_4.sprite.bounds.size.y
					local var_200_11 = var_200_8 / var_200_9
					local var_200_12 = var_200_7 / var_200_10
					local var_200_13 = var_200_12 < var_200_11 and var_200_11 or var_200_12

					var_200_3.transform.localScale = Vector3.New(var_200_13, var_200_13, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "OM0601" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_14 = manager.ui.mainCamera.transform
			local var_200_15 = 0

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 then
				arg_197_1.var_.shakeOldPos = var_200_14.localPosition
			end

			local var_200_16 = 2.53333333333333

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_16 then
				local var_200_17 = (arg_197_1.time_ - var_200_15) / 0.066
				local var_200_18, var_200_19 = math.modf(var_200_17)

				var_200_14.localPosition = Vector3.New(var_200_19 * 0.13, var_200_19 * 0.13, var_200_19 * 0.13) + arg_197_1.var_.shakeOldPos
			end

			if arg_197_1.time_ >= var_200_15 + var_200_16 and arg_197_1.time_ < var_200_15 + var_200_16 + arg_200_0 then
				var_200_14.localPosition = arg_197_1.var_.shakeOldPos
			end

			local var_200_20 = arg_197_1.bgs_.OM0601
			local var_200_21 = 0

			if var_200_21 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				local var_200_22 = var_200_20:GetComponent("SpriteRenderer")

				if var_200_22 then
					arg_197_1.var_.alphaOldValueOM0601 = var_200_22.color.a
					arg_197_1.var_.alphaMatValueOM0601 = var_200_22
				end

				arg_197_1.var_.alphaOldValueOM0601 = 1
			end

			local var_200_23 = 1.6

			if var_200_21 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_23 then
				local var_200_24 = (arg_197_1.time_ - var_200_21) / var_200_23
				local var_200_25 = Mathf.Lerp(arg_197_1.var_.alphaOldValueOM0601, 0, var_200_24)

				if arg_197_1.var_.alphaMatValueOM0601 then
					local var_200_26 = arg_197_1.var_.alphaMatValueOM0601.color

					var_200_26.a = var_200_25
					arg_197_1.var_.alphaMatValueOM0601.color = var_200_26
				end
			end

			if arg_197_1.time_ >= var_200_21 + var_200_23 and arg_197_1.time_ < var_200_21 + var_200_23 + arg_200_0 and arg_197_1.var_.alphaMatValueOM0601 then
				local var_200_27 = arg_197_1.var_.alphaMatValueOM0601
				local var_200_28 = var_200_27.color

				var_200_28.a = 0
				var_200_27.color = var_200_28
			end

			local var_200_29 = 0

			if var_200_29 < arg_197_1.time_ and arg_197_1.time_ <= var_200_29 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_30 = 0.15

			if var_200_29 <= arg_197_1.time_ and arg_197_1.time_ < var_200_29 + var_200_30 then
				local var_200_31 = (arg_197_1.time_ - var_200_29) / var_200_30
				local var_200_32 = Color.New(1, 1, 1)

				var_200_32.a = Mathf.Lerp(1, 0, var_200_31)
				arg_197_1.mask_.color = var_200_32
			end

			if arg_197_1.time_ >= var_200_29 + var_200_30 and arg_197_1.time_ < var_200_29 + var_200_30 + arg_200_0 then
				local var_200_33 = Color.New(1, 1, 1)
				local var_200_34 = 0

				arg_197_1.mask_.enabled = false
				var_200_33.a = var_200_34
				arg_197_1.mask_.color = var_200_33
			end

			local var_200_35 = 0.6

			if var_200_35 < arg_197_1.time_ and arg_197_1.time_ <= var_200_35 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_36 = 1

			if var_200_35 <= arg_197_1.time_ and arg_197_1.time_ < var_200_35 + var_200_36 then
				local var_200_37 = (arg_197_1.time_ - var_200_35) / var_200_36
				local var_200_38 = Color.New(1, 1, 1)

				var_200_38.a = Mathf.Lerp(0, 1, var_200_37)
				arg_197_1.mask_.color = var_200_38
			end

			if arg_197_1.time_ >= var_200_35 + var_200_36 and arg_197_1.time_ < var_200_35 + var_200_36 + arg_200_0 then
				local var_200_39 = Color.New(1, 1, 1)

				var_200_39.a = 1
				arg_197_1.mask_.color = var_200_39
			end

			local var_200_40 = 1.6

			if var_200_40 < arg_197_1.time_ and arg_197_1.time_ <= var_200_40 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_41 = 1

			if var_200_40 <= arg_197_1.time_ and arg_197_1.time_ < var_200_40 + var_200_41 then
				local var_200_42 = (arg_197_1.time_ - var_200_40) / var_200_41
				local var_200_43 = Color.New(1, 1, 1)

				var_200_43.a = Mathf.Lerp(1, 0, var_200_42)
				arg_197_1.mask_.color = var_200_43
			end

			if arg_197_1.time_ >= var_200_40 + var_200_41 and arg_197_1.time_ < var_200_40 + var_200_41 + arg_200_0 then
				local var_200_44 = Color.New(1, 1, 1)
				local var_200_45 = 0

				arg_197_1.mask_.enabled = false
				var_200_44.a = var_200_45
				arg_197_1.mask_.color = var_200_44
			end

			local var_200_46 = "STwhite"

			if arg_197_1.bgs_[var_200_46] == nil then
				local var_200_47 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_47:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_46)
				var_200_47.name = var_200_46
				var_200_47.transform.parent = arg_197_1.stage_.transform
				var_200_47.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_46] = var_200_47
			end

			local var_200_48 = arg_197_1.bgs_.STwhite.transform
			local var_200_49 = 1.6

			if var_200_49 < arg_197_1.time_ and arg_197_1.time_ <= var_200_49 + arg_200_0 then
				arg_197_1.var_.moveOldPosSTwhite = var_200_48.localPosition
				var_200_48.localScale = Vector3.New(13, 13, 13)
			end

			local var_200_50 = 0.001

			if var_200_49 <= arg_197_1.time_ and arg_197_1.time_ < var_200_49 + var_200_50 then
				local var_200_51 = (arg_197_1.time_ - var_200_49) / var_200_50
				local var_200_52 = Vector3.New(0, 0, 0)

				var_200_48.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPosSTwhite, var_200_52, var_200_51)
			end

			if arg_197_1.time_ >= var_200_49 + var_200_50 and arg_197_1.time_ < var_200_49 + var_200_50 + arg_200_0 then
				var_200_48.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_53 = 2.38333333333333
			local var_200_54 = 0.15

			if var_200_53 < arg_197_1.time_ and arg_197_1.time_ <= var_200_53 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_55 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_55:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_56 = arg_197_1:FormatText(StoryNameCfg[68].name)

				arg_197_1.leftNameTxt_.text = var_200_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3021")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_57 = arg_197_1:GetWordFromCfg(900701046)
				local var_200_58 = arg_197_1:FormatText(var_200_57.content)

				arg_197_1.text_.text = var_200_58

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_59 = 6
				local var_200_60 = utf8.len(var_200_58)
				local var_200_61 = var_200_59 <= 0 and var_200_54 or var_200_54 * (var_200_60 / var_200_59)

				if var_200_61 > 0 and var_200_54 < var_200_61 then
					arg_197_1.talkMaxDuration = var_200_61
					var_200_53 = var_200_53 + 0.3

					if var_200_61 + var_200_53 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_61 + var_200_53
					end
				end

				arg_197_1.text_.text = var_200_58
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_62 = var_200_53 + 0.3
			local var_200_63 = math.max(var_200_54, arg_197_1.talkMaxDuration)

			if var_200_62 <= arg_197_1.time_ and arg_197_1.time_ < var_200_62 + var_200_63 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_62) / var_200_63

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_62 + var_200_63 and arg_197_1.time_ < var_200_62 + var_200_63 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play900701047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 900701047
		arg_203_1.duration_ = 7.5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play900701048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 1.5

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				local var_206_1 = manager.ui.mainCamera.transform.localPosition
				local var_206_2 = Vector3.New(0, 0, 10) + Vector3.New(var_206_1.x, var_206_1.y, 0)
				local var_206_3 = arg_203_1.bgs_.OM0602

				var_206_3.transform.localPosition = var_206_2
				var_206_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_4 = var_206_3:GetComponent("SpriteRenderer")

				if var_206_4 and var_206_4.sprite then
					local var_206_5 = (var_206_3.transform.localPosition - var_206_1).z
					local var_206_6 = manager.ui.mainCameraCom_
					local var_206_7 = 2 * var_206_5 * Mathf.Tan(var_206_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_8 = var_206_7 * var_206_6.aspect
					local var_206_9 = var_206_4.sprite.bounds.size.x
					local var_206_10 = var_206_4.sprite.bounds.size.y
					local var_206_11 = var_206_8 / var_206_9
					local var_206_12 = var_206_7 / var_206_10
					local var_206_13 = var_206_12 < var_206_11 and var_206_11 or var_206_12

					var_206_3.transform.localScale = Vector3.New(var_206_13, var_206_13, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "OM0602" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_15 = 1.5

			if var_206_14 <= arg_203_1.time_ and arg_203_1.time_ < var_206_14 + var_206_15 then
				local var_206_16 = (arg_203_1.time_ - var_206_14) / var_206_15
				local var_206_17 = Color.New(0, 0, 0)

				var_206_17.a = Mathf.Lerp(0, 1, var_206_16)
				arg_203_1.mask_.color = var_206_17
			end

			if arg_203_1.time_ >= var_206_14 + var_206_15 and arg_203_1.time_ < var_206_14 + var_206_15 + arg_206_0 then
				local var_206_18 = Color.New(0, 0, 0)

				var_206_18.a = 1
				arg_203_1.mask_.color = var_206_18
			end

			local var_206_19 = 1.5

			if var_206_19 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = false

				arg_203_1:SetGaussion(false)
			end

			local var_206_20 = 1

			if var_206_19 <= arg_203_1.time_ and arg_203_1.time_ < var_206_19 + var_206_20 then
				local var_206_21 = (arg_203_1.time_ - var_206_19) / var_206_20
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = Mathf.Lerp(1, 0, var_206_21)
				arg_203_1.mask_.color = var_206_22
			end

			if arg_203_1.time_ >= var_206_19 + var_206_20 and arg_203_1.time_ < var_206_19 + var_206_20 + arg_206_0 then
				local var_206_23 = Color.New(0, 0, 0)
				local var_206_24 = 0

				arg_203_1.mask_.enabled = false
				var_206_23.a = var_206_24
				arg_203_1.mask_.color = var_206_23
			end

			local var_206_25 = manager.ui.mainCamera.transform
			local var_206_26 = 1.5

			if var_206_26 < arg_203_1.time_ and arg_203_1.time_ <= var_206_26 + arg_206_0 then
				local var_206_27 = arg_203_1.var_.effect1234
				local var_206_28
				local var_206_29 = var_206_25

				if not var_206_27 then
					var_206_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_red"), var_206_29)
					var_206_27.name = "1234"
					arg_203_1.var_.effect1234 = var_206_27
				else
					var_206_27.transform:SetParent(var_206_29)
				end

				var_206_27.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_206_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_206_30 = 2.03333333333333

			if var_206_30 < arg_203_1.time_ and arg_203_1.time_ <= var_206_30 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_31 = 0.466666666666666

			if var_206_30 <= arg_203_1.time_ and arg_203_1.time_ < var_206_30 + var_206_31 then
				local var_206_32 = (arg_203_1.time_ - var_206_30) / var_206_31
				local var_206_33 = Color.New(1, 1, 1)

				var_206_33.a = Mathf.Lerp(1, 0, var_206_32)
				arg_203_1.mask_.color = var_206_33
			end

			if arg_203_1.time_ >= var_206_30 + var_206_31 and arg_203_1.time_ < var_206_30 + var_206_31 + arg_206_0 then
				local var_206_34 = Color.New(1, 1, 1)
				local var_206_35 = 0

				arg_203_1.mask_.enabled = false
				var_206_34.a = var_206_35
				arg_203_1.mask_.color = var_206_34
			end

			local var_206_36 = arg_203_1.bgs_.OM0602.transform
			local var_206_37 = 1.5

			if var_206_37 < arg_203_1.time_ and arg_203_1.time_ <= var_206_37 + arg_206_0 then
				arg_203_1.var_.moveOldPosOM0602 = var_206_36.localPosition
			end

			local var_206_38 = 0.001

			if var_206_37 <= arg_203_1.time_ and arg_203_1.time_ < var_206_37 + var_206_38 then
				local var_206_39 = (arg_203_1.time_ - var_206_37) / var_206_38
				local var_206_40 = Vector3.New(0.5, 1.96, 8)

				var_206_36.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosOM0602, var_206_40, var_206_39)
			end

			if arg_203_1.time_ >= var_206_37 + var_206_38 and arg_203_1.time_ < var_206_37 + var_206_38 + arg_206_0 then
				var_206_36.localPosition = Vector3.New(0.5, 1.96, 8)
			end

			local var_206_41 = arg_203_1.bgs_.OM0602.transform
			local var_206_42 = 1.534

			if var_206_42 < arg_203_1.time_ and arg_203_1.time_ <= var_206_42 + arg_206_0 then
				arg_203_1.var_.moveOldPosOM0602 = var_206_41.localPosition
			end

			local var_206_43 = 0.499333333333334

			if var_206_42 <= arg_203_1.time_ and arg_203_1.time_ < var_206_42 + var_206_43 then
				local var_206_44 = (arg_203_1.time_ - var_206_42) / var_206_43
				local var_206_45 = Vector3.New(-2.1, 0.45, 8)

				var_206_41.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPosOM0602, var_206_45, var_206_44)
			end

			if arg_203_1.time_ >= var_206_42 + var_206_43 and arg_203_1.time_ < var_206_42 + var_206_43 + arg_206_0 then
				var_206_41.localPosition = Vector3.New(-2.1, 0.45, 8)
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_46 = 2.5
			local var_206_47 = 0.275

			if var_206_46 < arg_203_1.time_ and arg_203_1.time_ <= var_206_46 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_48 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_48:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_49 = arg_203_1:FormatText(StoryNameCfg[235].name)

				arg_203_1.leftNameTxt_.text = var_206_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_50 = arg_203_1:GetWordFromCfg(900701047)
				local var_206_51 = arg_203_1:FormatText(var_206_50.content)

				arg_203_1.text_.text = var_206_51

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_52 = 11
				local var_206_53 = utf8.len(var_206_51)
				local var_206_54 = var_206_52 <= 0 and var_206_47 or var_206_47 * (var_206_53 / var_206_52)

				if var_206_54 > 0 and var_206_47 < var_206_54 then
					arg_203_1.talkMaxDuration = var_206_54
					var_206_46 = var_206_46 + 0.3

					if var_206_54 + var_206_46 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_54 + var_206_46
					end
				end

				arg_203_1.text_.text = var_206_51
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_55 = var_206_46 + 0.3
			local var_206_56 = math.max(var_206_47, arg_203_1.talkMaxDuration)

			if var_206_55 <= arg_203_1.time_ and arg_203_1.time_ < var_206_55 + var_206_56 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_55) / var_206_56

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_55 + var_206_56 and arg_203_1.time_ < var_206_55 + var_206_56 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.499333333333334,
				className = "StoryMoveNode",
				startTime = 1.534,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play900701048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 900701048
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play900701049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.225

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[235].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:GetWordFromCfg(900701048)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 9
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play900701049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 900701049
		arg_213_1.duration_ = 5.2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play900701050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = manager.ui.mainCamera.transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.shakeOldPos = var_216_0.localPosition
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / 0.099
				local var_216_4, var_216_5 = math.modf(var_216_3)

				var_216_0.localPosition = Vector3.New(var_216_5 * 0.13, var_216_5 * 0.13, var_216_5 * 0.13) + arg_213_1.var_.shakeOldPos
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = arg_213_1.var_.shakeOldPos
			end

			local var_216_6 = arg_213_1.bgs_.OM0602.transform
			local var_216_7 = 0.2

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 then
				arg_213_1.var_.moveOldPosOM0602 = var_216_6.localPosition
			end

			local var_216_8 = 0.001

			if var_216_7 <= arg_213_1.time_ and arg_213_1.time_ < var_216_7 + var_216_8 then
				local var_216_9 = (arg_213_1.time_ - var_216_7) / var_216_8
				local var_216_10 = Vector3.New(3.73, -0.25, 3)

				var_216_6.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPosOM0602, var_216_10, var_216_9)
			end

			if arg_213_1.time_ >= var_216_7 + var_216_8 and arg_213_1.time_ < var_216_7 + var_216_8 + arg_216_0 then
				var_216_6.localPosition = Vector3.New(3.73, -0.25, 3)
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_11 = 0.2
			local var_216_12 = 0.2

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_13 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_13:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_14 = arg_213_1:FormatText(StoryNameCfg[236].name)

				arg_213_1.leftNameTxt_.text = var_216_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_15 = arg_213_1:GetWordFromCfg(900701049)
				local var_216_16 = arg_213_1:FormatText(var_216_15.content)

				arg_213_1.text_.text = var_216_16

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_17 = 8
				local var_216_18 = utf8.len(var_216_16)
				local var_216_19 = var_216_17 <= 0 and var_216_12 or var_216_12 * (var_216_18 / var_216_17)

				if var_216_19 > 0 and var_216_12 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19
					var_216_11 = var_216_11 + 0.3

					if var_216_19 + var_216_11 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_11
					end
				end

				arg_213_1.text_.text = var_216_16
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = var_216_11 + 0.3
			local var_216_21 = math.max(var_216_12, arg_213_1.talkMaxDuration)

			if var_216_20 <= arg_213_1.time_ and arg_213_1.time_ < var_216_20 + var_216_21 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_20) / var_216_21

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_20 + var_216_21 and arg_213_1.time_ < var_216_20 + var_216_21 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play900701050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 900701050
		arg_219_1.duration_ = 7

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play900701051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_1 = 1

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_1 then
				local var_222_2 = (arg_219_1.time_ - var_222_0) / var_222_1
				local var_222_3 = Color.New(1, 1, 1)

				var_222_3.a = Mathf.Lerp(0, 1, var_222_2)
				arg_219_1.mask_.color = var_222_3
			end

			if arg_219_1.time_ >= var_222_0 + var_222_1 and arg_219_1.time_ < var_222_0 + var_222_1 + arg_222_0 then
				local var_222_4 = Color.New(1, 1, 1)

				var_222_4.a = 1
				arg_219_1.mask_.color = var_222_4
			end

			local var_222_5 = 1

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_6 = 1

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / var_222_6
				local var_222_8 = Color.New(1, 1, 1)

				var_222_8.a = Mathf.Lerp(1, 0, var_222_7)
				arg_219_1.mask_.color = var_222_8
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				local var_222_9 = Color.New(1, 1, 1)
				local var_222_10 = 0

				arg_219_1.mask_.enabled = false
				var_222_9.a = var_222_10
				arg_219_1.mask_.color = var_222_9
			end

			local var_222_11 = manager.ui.mainCamera.transform
			local var_222_12 = 0

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				local var_222_13 = arg_219_1.var_.effect1234

				if var_222_13 then
					Object.Destroy(var_222_13)

					arg_219_1.var_.effect1234 = nil
				end
			end

			local var_222_14 = arg_219_1.bgs_.STwhite.transform
			local var_222_15 = 1

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.var_.moveOldPosSTwhite = var_222_14.localPosition
				var_222_14.localScale = Vector3.New(10, 10, 10)
			end

			local var_222_16 = 0.001

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16
				local var_222_18 = Vector3.New(0, 0, 0)

				var_222_14.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPosSTwhite, var_222_18, var_222_17)
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				var_222_14.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_19 = 2
			local var_222_20 = 1.15

			if var_222_19 < arg_219_1.time_ and arg_219_1.time_ <= var_222_19 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_21 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_21:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_22 = arg_219_1:GetWordFromCfg(900701050)
				local var_222_23 = arg_219_1:FormatText(var_222_22.content)

				arg_219_1.text_.text = var_222_23

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_24 = 46
				local var_222_25 = utf8.len(var_222_23)
				local var_222_26 = var_222_24 <= 0 and var_222_20 or var_222_20 * (var_222_25 / var_222_24)

				if var_222_26 > 0 and var_222_20 < var_222_26 then
					arg_219_1.talkMaxDuration = var_222_26
					var_222_19 = var_222_19 + 0.3

					if var_222_26 + var_222_19 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_26 + var_222_19
					end
				end

				arg_219_1.text_.text = var_222_23
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_27 = var_222_19 + 0.3
			local var_222_28 = math.max(var_222_20, arg_219_1.talkMaxDuration)

			if var_222_27 <= arg_219_1.time_ and arg_219_1.time_ < var_222_27 + var_222_28 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_27) / var_222_28

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_27 + var_222_28 and arg_219_1.time_ < var_222_27 + var_222_28 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play900701051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 900701051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play900701052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_2 = "play"
				local var_228_3 = "music"

				arg_225_1:AudioAction(var_228_2, var_228_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_228_4 = ""
				local var_228_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_228_5 ~= "" then
					if arg_225_1.bgmTxt_.text ~= var_228_5 and arg_225_1.bgmTxt_.text ~= "" then
						if arg_225_1.bgmTxt2_.text ~= "" then
							arg_225_1.bgmTxt_.text = arg_225_1.bgmTxt2_.text
						end

						arg_225_1.bgmTxt2_.text = var_228_5

						arg_225_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_225_1.bgmTxt_.text = var_228_5
						arg_225_1.bgmTxt2_.text = var_228_5
					end

					if arg_225_1.bgmTimer then
						arg_225_1.bgmTimer:Stop()

						arg_225_1.bgmTimer = nil
					end

					if arg_225_1.settingData.show_music_name == 1 then
						arg_225_1.musicController:SetSelectedState("show")
						arg_225_1.musicAnimator_:Play("open", 0, 0)

						if arg_225_1.settingData.music_time ~= 0 then
							arg_225_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_225_1.settingData.music_time), function()
								if arg_225_1 == nil or isNil(arg_225_1.bgmTxt_) then
									return
								end

								arg_225_1.musicController:SetSelectedState("hide")
								arg_225_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_228_6 = 0
			local var_228_7 = 0.75

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(900701051)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 30
				local var_228_11 = utf8.len(var_228_9)
				local var_228_12 = var_228_10 <= 0 and var_228_7 or var_228_7 * (var_228_11 / var_228_10)

				if var_228_12 > 0 and var_228_7 < var_228_12 then
					arg_225_1.talkMaxDuration = var_228_12

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_13 and arg_225_1.time_ < var_228_6 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play900701052 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 900701052
		arg_230_1.duration_ = 7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play900701053(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				local var_233_1 = manager.ui.mainCamera.transform.localPosition
				local var_233_2 = Vector3.New(0, 0, 10) + Vector3.New(var_233_1.x, var_233_1.y, 0)
				local var_233_3 = arg_230_1.bgs_.ST22a

				var_233_3.transform.localPosition = var_233_2
				var_233_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_4 = var_233_3:GetComponent("SpriteRenderer")

				if var_233_4 and var_233_4.sprite then
					local var_233_5 = (var_233_3.transform.localPosition - var_233_1).z
					local var_233_6 = manager.ui.mainCameraCom_
					local var_233_7 = 2 * var_233_5 * Mathf.Tan(var_233_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_8 = var_233_7 * var_233_6.aspect
					local var_233_9 = var_233_4.sprite.bounds.size.x
					local var_233_10 = var_233_4.sprite.bounds.size.y
					local var_233_11 = var_233_8 / var_233_9
					local var_233_12 = var_233_7 / var_233_10
					local var_233_13 = var_233_12 < var_233_11 and var_233_11 or var_233_12

					var_233_3.transform.localScale = Vector3.New(var_233_13, var_233_13, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST22a" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_14 = 0

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_15 = 2

			if var_233_14 <= arg_230_1.time_ and arg_230_1.time_ < var_233_14 + var_233_15 then
				local var_233_16 = (arg_230_1.time_ - var_233_14) / var_233_15
				local var_233_17 = Color.New(1, 1, 1)

				var_233_17.a = Mathf.Lerp(1, 0, var_233_16)
				arg_230_1.mask_.color = var_233_17
			end

			if arg_230_1.time_ >= var_233_14 + var_233_15 and arg_230_1.time_ < var_233_14 + var_233_15 + arg_233_0 then
				local var_233_18 = Color.New(1, 1, 1)
				local var_233_19 = 0

				arg_230_1.mask_.enabled = false
				var_233_18.a = var_233_19
				arg_230_1.mask_.color = var_233_18
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_20 = 2
			local var_233_21 = 0.85

			if var_233_20 < arg_230_1.time_ and arg_230_1.time_ <= var_233_20 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_22 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_22:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_23 = arg_230_1:GetWordFromCfg(900701052)
				local var_233_24 = arg_230_1:FormatText(var_233_23.content)

				arg_230_1.text_.text = var_233_24

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_25 = 34
				local var_233_26 = utf8.len(var_233_24)
				local var_233_27 = var_233_25 <= 0 and var_233_21 or var_233_21 * (var_233_26 / var_233_25)

				if var_233_27 > 0 and var_233_21 < var_233_27 then
					arg_230_1.talkMaxDuration = var_233_27
					var_233_20 = var_233_20 + 0.3

					if var_233_27 + var_233_20 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_27 + var_233_20
					end
				end

				arg_230_1.text_.text = var_233_24
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_28 = var_233_20 + 0.3
			local var_233_29 = math.max(var_233_21, arg_230_1.talkMaxDuration)

			if var_233_28 <= arg_230_1.time_ and arg_230_1.time_ < var_233_28 + var_233_29 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_28) / var_233_29

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_28 + var_233_29 and arg_230_1.time_ < var_233_28 + var_233_29 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play900701053 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 900701053
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play900701054(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1033"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1033 = var_239_0.localPosition
				var_239_0.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1033", 2)

				local var_239_2 = var_239_0.childCount

				for iter_239_0 = 0, var_239_2 - 1 do
					local var_239_3 = var_239_0:GetChild(iter_239_0)

					if var_239_3.name == "split_5" or not string.find(var_239_3.name, "split") then
						var_239_3.gameObject:SetActive(true)
					else
						var_239_3.gameObject:SetActive(false)
					end
				end
			end

			local var_239_4 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_4 then
				local var_239_5 = (arg_236_1.time_ - var_239_1) / var_239_4
				local var_239_6 = Vector3.New(-390, -420, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1033, var_239_6, var_239_5)
			end

			if arg_236_1.time_ >= var_239_1 + var_239_4 and arg_236_1.time_ < var_239_1 + var_239_4 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_239_7 = arg_236_1.actors_["1033"]
			local var_239_8 = 0

			if var_239_8 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.actorSpriteComps1033 == nil then
				arg_236_1.var_.actorSpriteComps1033 = var_239_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_9 = 0.2

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_9 and not isNil(var_239_7) then
				local var_239_10 = (arg_236_1.time_ - var_239_8) / var_239_9

				if arg_236_1.var_.actorSpriteComps1033 then
					for iter_239_1, iter_239_2 in pairs(arg_236_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_239_2 then
							if arg_236_1.isInRecall_ then
								local var_239_11 = Mathf.Lerp(iter_239_2.color.r, arg_236_1.hightColor2.r, var_239_10)
								local var_239_12 = Mathf.Lerp(iter_239_2.color.g, arg_236_1.hightColor2.g, var_239_10)
								local var_239_13 = Mathf.Lerp(iter_239_2.color.b, arg_236_1.hightColor2.b, var_239_10)

								iter_239_2.color = Color.New(var_239_11, var_239_12, var_239_13)
							else
								local var_239_14 = Mathf.Lerp(iter_239_2.color.r, 0.5, var_239_10)

								iter_239_2.color = Color.New(var_239_14, var_239_14, var_239_14)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_8 + var_239_9 and arg_236_1.time_ < var_239_8 + var_239_9 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.actorSpriteComps1033 then
				for iter_239_3, iter_239_4 in pairs(arg_236_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_239_4 then
						if arg_236_1.isInRecall_ then
							iter_239_4.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps1033 = nil
			end

			local var_239_15 = arg_236_1.actors_["10022"].transform
			local var_239_16 = 0

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 then
				arg_236_1.var_.moveOldPos10022 = var_239_15.localPosition
				var_239_15.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10022", 4)

				local var_239_17 = var_239_15.childCount

				for iter_239_5 = 0, var_239_17 - 1 do
					local var_239_18 = var_239_15:GetChild(iter_239_5)

					if var_239_18.name == "split_3" or not string.find(var_239_18.name, "split") then
						var_239_18.gameObject:SetActive(true)
					else
						var_239_18.gameObject:SetActive(false)
					end
				end
			end

			local var_239_19 = 0.001

			if var_239_16 <= arg_236_1.time_ and arg_236_1.time_ < var_239_16 + var_239_19 then
				local var_239_20 = (arg_236_1.time_ - var_239_16) / var_239_19
				local var_239_21 = Vector3.New(390, -350, -180)

				var_239_15.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10022, var_239_21, var_239_20)
			end

			if arg_236_1.time_ >= var_239_16 + var_239_19 and arg_236_1.time_ < var_239_16 + var_239_19 + arg_239_0 then
				var_239_15.localPosition = Vector3.New(390, -350, -180)
			end

			local var_239_22 = arg_236_1.actors_["10022"]
			local var_239_23 = 0

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 and not isNil(var_239_22) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_24 = 0.2

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_24 and not isNil(var_239_22) then
				local var_239_25 = (arg_236_1.time_ - var_239_23) / var_239_24

				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_6, iter_239_7 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_7 then
							if arg_236_1.isInRecall_ then
								local var_239_26 = Mathf.Lerp(iter_239_7.color.r, arg_236_1.hightColor1.r, var_239_25)
								local var_239_27 = Mathf.Lerp(iter_239_7.color.g, arg_236_1.hightColor1.g, var_239_25)
								local var_239_28 = Mathf.Lerp(iter_239_7.color.b, arg_236_1.hightColor1.b, var_239_25)

								iter_239_7.color = Color.New(var_239_26, var_239_27, var_239_28)
							else
								local var_239_29 = Mathf.Lerp(iter_239_7.color.r, 1, var_239_25)

								iter_239_7.color = Color.New(var_239_29, var_239_29, var_239_29)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_23 + var_239_24 and arg_236_1.time_ < var_239_23 + var_239_24 + arg_239_0 and not isNil(var_239_22) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_8, iter_239_9 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_9 then
						if arg_236_1.isInRecall_ then
							iter_239_9.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_30 = arg_236_1.actors_["1033"]
			local var_239_31 = 0

			if var_239_31 < arg_236_1.time_ and arg_236_1.time_ <= var_239_31 + arg_239_0 then
				local var_239_32 = var_239_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_239_32 then
					arg_236_1.var_.alphaOldValue1033 = var_239_32.alpha
					arg_236_1.var_.characterEffect1033 = var_239_32
				end

				arg_236_1.var_.alphaOldValue1033 = 0
			end

			local var_239_33 = 0.2

			if var_239_31 <= arg_236_1.time_ and arg_236_1.time_ < var_239_31 + var_239_33 then
				local var_239_34 = (arg_236_1.time_ - var_239_31) / var_239_33
				local var_239_35 = Mathf.Lerp(arg_236_1.var_.alphaOldValue1033, 1, var_239_34)

				if arg_236_1.var_.characterEffect1033 then
					arg_236_1.var_.characterEffect1033.alpha = var_239_35
				end
			end

			if arg_236_1.time_ >= var_239_31 + var_239_33 and arg_236_1.time_ < var_239_31 + var_239_33 + arg_239_0 and arg_236_1.var_.characterEffect1033 then
				arg_236_1.var_.characterEffect1033.alpha = 1
			end

			local var_239_36 = arg_236_1.actors_["10022"]
			local var_239_37 = 0

			if var_239_37 < arg_236_1.time_ and arg_236_1.time_ <= var_239_37 + arg_239_0 then
				local var_239_38 = var_239_36:GetComponentInChildren(typeof(CanvasGroup))

				if var_239_38 then
					arg_236_1.var_.alphaOldValue10022 = var_239_38.alpha
					arg_236_1.var_.characterEffect10022 = var_239_38
				end

				arg_236_1.var_.alphaOldValue10022 = 0
			end

			local var_239_39 = 0.2

			if var_239_37 <= arg_236_1.time_ and arg_236_1.time_ < var_239_37 + var_239_39 then
				local var_239_40 = (arg_236_1.time_ - var_239_37) / var_239_39
				local var_239_41 = Mathf.Lerp(arg_236_1.var_.alphaOldValue10022, 1, var_239_40)

				if arg_236_1.var_.characterEffect10022 then
					arg_236_1.var_.characterEffect10022.alpha = var_239_41
				end
			end

			if arg_236_1.time_ >= var_239_37 + var_239_39 and arg_236_1.time_ < var_239_37 + var_239_39 + arg_239_0 and arg_236_1.var_.characterEffect10022 then
				arg_236_1.var_.characterEffect10022.alpha = 1
			end

			local var_239_42 = 0
			local var_239_43 = 0.275

			if var_239_42 < arg_236_1.time_ and arg_236_1.time_ <= var_239_42 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_44 = arg_236_1:FormatText(StoryNameCfg[235].name)

				arg_236_1.leftNameTxt_.text = var_239_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_45 = arg_236_1:GetWordFromCfg(900701053)
				local var_239_46 = arg_236_1:FormatText(var_239_45.content)

				arg_236_1.text_.text = var_239_46

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_47 = 11
				local var_239_48 = utf8.len(var_239_46)
				local var_239_49 = var_239_47 <= 0 and var_239_43 or var_239_43 * (var_239_48 / var_239_47)

				if var_239_49 > 0 and var_239_43 < var_239_49 then
					arg_236_1.talkMaxDuration = var_239_49

					if var_239_49 + var_239_42 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_49 + var_239_42
					end
				end

				arg_236_1.text_.text = var_239_46
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_50 = math.max(var_239_43, arg_236_1.talkMaxDuration)

			if var_239_42 <= arg_236_1.time_ and arg_236_1.time_ < var_239_42 + var_239_50 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_42) / var_239_50

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_42 + var_239_50 and arg_236_1.time_ < var_239_42 + var_239_50 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play900701054 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 900701054
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play900701055(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1033"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1033 == nil then
				arg_240_1.var_.actorSpriteComps1033 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps1033 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 1, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1033 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_243_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps1033 = nil
			end

			local var_243_8 = arg_240_1.actors_["10022"]
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10022 == nil then
				arg_240_1.var_.actorSpriteComps10022 = var_243_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_10 = 0.2

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_10 and not isNil(var_243_8) then
				local var_243_11 = (arg_240_1.time_ - var_243_9) / var_243_10

				if arg_240_1.var_.actorSpriteComps10022 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								local var_243_12 = Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, var_243_11)
								local var_243_13 = Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, var_243_11)
								local var_243_14 = Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, var_243_11)

								iter_243_5.color = Color.New(var_243_12, var_243_13, var_243_14)
							else
								local var_243_15 = Mathf.Lerp(iter_243_5.color.r, 0.5, var_243_11)

								iter_243_5.color = Color.New(var_243_15, var_243_15, var_243_15)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_9 + var_243_10 and arg_240_1.time_ < var_243_9 + var_243_10 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10022 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_243_7 then
						if arg_240_1.isInRecall_ then
							iter_243_7.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10022 = nil
			end

			local var_243_16 = 0
			local var_243_17 = 0.675

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_18 = arg_240_1:FormatText(StoryNameCfg[236].name)

				arg_240_1.leftNameTxt_.text = var_243_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_19 = arg_240_1:GetWordFromCfg(900701054)
				local var_243_20 = arg_240_1:FormatText(var_243_19.content)

				arg_240_1.text_.text = var_243_20

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_21 = 27
				local var_243_22 = utf8.len(var_243_20)
				local var_243_23 = var_243_21 <= 0 and var_243_17 or var_243_17 * (var_243_22 / var_243_21)

				if var_243_23 > 0 and var_243_17 < var_243_23 then
					arg_240_1.talkMaxDuration = var_243_23

					if var_243_23 + var_243_16 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_16
					end
				end

				arg_240_1.text_.text = var_243_20
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_24 = math.max(var_243_17, arg_240_1.talkMaxDuration)

			if var_243_16 <= arg_240_1.time_ and arg_240_1.time_ < var_243_16 + var_243_24 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_16) / var_243_24

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_16 + var_243_24 and arg_240_1.time_ < var_243_16 + var_243_24 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play900701055 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 900701055
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play900701056(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1033"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1033 = var_247_0.localPosition
				var_247_0.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1033", 7)

				local var_247_2 = var_247_0.childCount

				for iter_247_0 = 0, var_247_2 - 1 do
					local var_247_3 = var_247_0:GetChild(iter_247_0)

					if var_247_3.name == "split_5" or not string.find(var_247_3.name, "split") then
						var_247_3.gameObject:SetActive(true)
					else
						var_247_3.gameObject:SetActive(false)
					end
				end
			end

			local var_247_4 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_4 then
				local var_247_5 = (arg_244_1.time_ - var_247_1) / var_247_4
				local var_247_6 = Vector3.New(0, -2000, 0)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1033, var_247_6, var_247_5)
			end

			if arg_244_1.time_ >= var_247_1 + var_247_4 and arg_244_1.time_ < var_247_1 + var_247_4 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_247_7 = arg_244_1.actors_["10022"].transform
			local var_247_8 = 0

			if var_247_8 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.var_.moveOldPos10022 = var_247_7.localPosition
				var_247_7.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10022", 7)

				local var_247_9 = var_247_7.childCount

				for iter_247_1 = 0, var_247_9 - 1 do
					local var_247_10 = var_247_7:GetChild(iter_247_1)

					if var_247_10.name == "split_3" or not string.find(var_247_10.name, "split") then
						var_247_10.gameObject:SetActive(true)
					else
						var_247_10.gameObject:SetActive(false)
					end
				end
			end

			local var_247_11 = 0.001

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_11 then
				local var_247_12 = (arg_244_1.time_ - var_247_8) / var_247_11
				local var_247_13 = Vector3.New(0, -2000, -180)

				var_247_7.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10022, var_247_13, var_247_12)
			end

			if arg_244_1.time_ >= var_247_8 + var_247_11 and arg_244_1.time_ < var_247_8 + var_247_11 + arg_247_0 then
				var_247_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_247_14 = 0
			local var_247_15 = 0.675

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_16 = arg_244_1:GetWordFromCfg(900701055)
				local var_247_17 = arg_244_1:FormatText(var_247_16.content)

				arg_244_1.text_.text = var_247_17

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_18 = 27
				local var_247_19 = utf8.len(var_247_17)
				local var_247_20 = var_247_18 <= 0 and var_247_15 or var_247_15 * (var_247_19 / var_247_18)

				if var_247_20 > 0 and var_247_15 < var_247_20 then
					arg_244_1.talkMaxDuration = var_247_20

					if var_247_20 + var_247_14 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_20 + var_247_14
					end
				end

				arg_244_1.text_.text = var_247_17
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_21 = math.max(var_247_15, arg_244_1.talkMaxDuration)

			if var_247_14 <= arg_244_1.time_ and arg_244_1.time_ < var_247_14 + var_247_21 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_14) / var_247_21

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_14 + var_247_21 and arg_244_1.time_ < var_247_14 + var_247_21 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play900701056 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 900701056
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play900701057(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1038"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1038 = var_251_0.localPosition
				var_251_0.localScale = Vector3.New(-1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("1038", 4)

				local var_251_2 = var_251_0.childCount

				for iter_251_0 = 0, var_251_2 - 1 do
					local var_251_3 = var_251_0:GetChild(iter_251_0)

					if var_251_3.name == "split_1" or not string.find(var_251_3.name, "split") then
						var_251_3.gameObject:SetActive(true)
					else
						var_251_3.gameObject:SetActive(false)
					end
				end
			end

			local var_251_4 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_4 then
				local var_251_5 = (arg_248_1.time_ - var_251_1) / var_251_4
				local var_251_6 = Vector3.New(390, -400, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1038, var_251_6, var_251_5)
			end

			if arg_248_1.time_ >= var_251_1 + var_251_4 and arg_248_1.time_ < var_251_1 + var_251_4 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_251_7 = arg_248_1.actors_["1038"]
			local var_251_8 = 0

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.actorSpriteComps1038 == nil then
				arg_248_1.var_.actorSpriteComps1038 = var_251_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_9 = 0.2

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_9 and not isNil(var_251_7) then
				local var_251_10 = (arg_248_1.time_ - var_251_8) / var_251_9

				if arg_248_1.var_.actorSpriteComps1038 then
					for iter_251_1, iter_251_2 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_251_2 then
							if arg_248_1.isInRecall_ then
								local var_251_11 = Mathf.Lerp(iter_251_2.color.r, arg_248_1.hightColor1.r, var_251_10)
								local var_251_12 = Mathf.Lerp(iter_251_2.color.g, arg_248_1.hightColor1.g, var_251_10)
								local var_251_13 = Mathf.Lerp(iter_251_2.color.b, arg_248_1.hightColor1.b, var_251_10)

								iter_251_2.color = Color.New(var_251_11, var_251_12, var_251_13)
							else
								local var_251_14 = Mathf.Lerp(iter_251_2.color.r, 1, var_251_10)

								iter_251_2.color = Color.New(var_251_14, var_251_14, var_251_14)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_8 + var_251_9 and arg_248_1.time_ < var_251_8 + var_251_9 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.actorSpriteComps1038 then
				for iter_251_3, iter_251_4 in pairs(arg_248_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_251_4 then
						if arg_248_1.isInRecall_ then
							iter_251_4.color = arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_251_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1038 = nil
			end

			local var_251_15 = arg_248_1.actors_["1038"]
			local var_251_16 = 0

			if var_251_16 < arg_248_1.time_ and arg_248_1.time_ <= var_251_16 + arg_251_0 then
				local var_251_17 = var_251_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_251_17 then
					arg_248_1.var_.alphaOldValue1038 = var_251_17.alpha
					arg_248_1.var_.characterEffect1038 = var_251_17
				end

				arg_248_1.var_.alphaOldValue1038 = 0
			end

			local var_251_18 = 0.2

			if var_251_16 <= arg_248_1.time_ and arg_248_1.time_ < var_251_16 + var_251_18 then
				local var_251_19 = (arg_248_1.time_ - var_251_16) / var_251_18
				local var_251_20 = Mathf.Lerp(arg_248_1.var_.alphaOldValue1038, 1, var_251_19)

				if arg_248_1.var_.characterEffect1038 then
					arg_248_1.var_.characterEffect1038.alpha = var_251_20
				end
			end

			if arg_248_1.time_ >= var_251_16 + var_251_18 and arg_248_1.time_ < var_251_16 + var_251_18 + arg_251_0 and arg_248_1.var_.characterEffect1038 then
				arg_248_1.var_.characterEffect1038.alpha = 1
			end

			local var_251_21 = 0
			local var_251_22 = 0.25

			if var_251_21 < arg_248_1.time_ and arg_248_1.time_ <= var_251_21 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				arg_248_1.dialog_:SetActive(true)

				arg_248_1.dialogCg_.alpha = 0

				local var_251_23 = LeanTween.value(arg_248_1.dialog_, 0, 1, 0.3)

				var_251_23:setOnUpdate(LuaHelper.FloatAction(function(arg_252_0)
					arg_248_1.dialogCg_.alpha = arg_252_0
				end))
				var_251_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_248_1.dialog_)
					var_251_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_248_1.duration_ = arg_248_1.duration_ + 0.3

				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_24 = arg_248_1:FormatText(StoryNameCfg[94].name)

				arg_248_1.leftNameTxt_.text = var_251_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_25 = arg_248_1:GetWordFromCfg(900701056)
				local var_251_26 = arg_248_1:FormatText(var_251_25.content)

				arg_248_1.text_.text = var_251_26

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_27 = 10
				local var_251_28 = utf8.len(var_251_26)
				local var_251_29 = var_251_27 <= 0 and var_251_22 or var_251_22 * (var_251_28 / var_251_27)

				if var_251_29 > 0 and var_251_22 < var_251_29 then
					arg_248_1.talkMaxDuration = var_251_29
					var_251_21 = var_251_21 + 0.3

					if var_251_29 + var_251_21 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_29 + var_251_21
					end
				end

				arg_248_1.text_.text = var_251_26
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_30 = var_251_21 + 0.3
			local var_251_31 = math.max(var_251_22, arg_248_1.talkMaxDuration)

			if var_251_30 <= arg_248_1.time_ and arg_248_1.time_ < var_251_30 + var_251_31 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_30) / var_251_31

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_30 + var_251_31 and arg_248_1.time_ < var_251_30 + var_251_31 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play900701057 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 900701057
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play900701058(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = "1019"

			if arg_254_1.actors_[var_257_0] == nil then
				local var_257_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1019")

				if not isNil(var_257_1) then
					local var_257_2 = Object.Instantiate(var_257_1, arg_254_1.canvasGo_.transform)

					var_257_2.transform:SetSiblingIndex(1)

					var_257_2.name = var_257_0
					var_257_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_254_1.actors_[var_257_0] = var_257_2

					local var_257_3 = var_257_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_254_1.isInRecall_ then
						for iter_257_0, iter_257_1 in ipairs(var_257_3) do
							iter_257_1.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_257_4 = arg_254_1.actors_["1019"].transform
			local var_257_5 = 0

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.var_.moveOldPos1019 = var_257_4.localPosition
				var_257_4.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1019", 2)

				local var_257_6 = var_257_4.childCount

				for iter_257_2 = 0, var_257_6 - 1 do
					local var_257_7 = var_257_4:GetChild(iter_257_2)

					if var_257_7.name == "split_1" or not string.find(var_257_7.name, "split") then
						var_257_7.gameObject:SetActive(true)
					else
						var_257_7.gameObject:SetActive(false)
					end
				end
			end

			local var_257_8 = 0.001

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_8 then
				local var_257_9 = (arg_254_1.time_ - var_257_5) / var_257_8
				local var_257_10 = Vector3.New(-600, -340, 200)

				var_257_4.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1019, var_257_10, var_257_9)
			end

			if arg_254_1.time_ >= var_257_5 + var_257_8 and arg_254_1.time_ < var_257_5 + var_257_8 + arg_257_0 then
				var_257_4.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_257_11 = arg_254_1.actors_["1019"]
			local var_257_12 = 0

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.actorSpriteComps1019 == nil then
				arg_254_1.var_.actorSpriteComps1019 = var_257_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_13 = 0.2

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_13 and not isNil(var_257_11) then
				local var_257_14 = (arg_254_1.time_ - var_257_12) / var_257_13

				if arg_254_1.var_.actorSpriteComps1019 then
					for iter_257_3, iter_257_4 in pairs(arg_254_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_257_4 then
							if arg_254_1.isInRecall_ then
								local var_257_15 = Mathf.Lerp(iter_257_4.color.r, arg_254_1.hightColor1.r, var_257_14)
								local var_257_16 = Mathf.Lerp(iter_257_4.color.g, arg_254_1.hightColor1.g, var_257_14)
								local var_257_17 = Mathf.Lerp(iter_257_4.color.b, arg_254_1.hightColor1.b, var_257_14)

								iter_257_4.color = Color.New(var_257_15, var_257_16, var_257_17)
							else
								local var_257_18 = Mathf.Lerp(iter_257_4.color.r, 1, var_257_14)

								iter_257_4.color = Color.New(var_257_18, var_257_18, var_257_18)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_12 + var_257_13 and arg_254_1.time_ < var_257_12 + var_257_13 + arg_257_0 and not isNil(var_257_11) and arg_254_1.var_.actorSpriteComps1019 then
				for iter_257_5, iter_257_6 in pairs(arg_254_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_257_6 then
						if arg_254_1.isInRecall_ then
							iter_257_6.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1019 = nil
			end

			local var_257_19 = arg_254_1.actors_["1038"]
			local var_257_20 = 0

			if var_257_20 < arg_254_1.time_ and arg_254_1.time_ <= var_257_20 + arg_257_0 and not isNil(var_257_19) and arg_254_1.var_.actorSpriteComps1038 == nil then
				arg_254_1.var_.actorSpriteComps1038 = var_257_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_21 = 0.2

			if var_257_20 <= arg_254_1.time_ and arg_254_1.time_ < var_257_20 + var_257_21 and not isNil(var_257_19) then
				local var_257_22 = (arg_254_1.time_ - var_257_20) / var_257_21

				if arg_254_1.var_.actorSpriteComps1038 then
					for iter_257_7, iter_257_8 in pairs(arg_254_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_257_8 then
							if arg_254_1.isInRecall_ then
								local var_257_23 = Mathf.Lerp(iter_257_8.color.r, arg_254_1.hightColor2.r, var_257_22)
								local var_257_24 = Mathf.Lerp(iter_257_8.color.g, arg_254_1.hightColor2.g, var_257_22)
								local var_257_25 = Mathf.Lerp(iter_257_8.color.b, arg_254_1.hightColor2.b, var_257_22)

								iter_257_8.color = Color.New(var_257_23, var_257_24, var_257_25)
							else
								local var_257_26 = Mathf.Lerp(iter_257_8.color.r, 0.5, var_257_22)

								iter_257_8.color = Color.New(var_257_26, var_257_26, var_257_26)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_20 + var_257_21 and arg_254_1.time_ < var_257_20 + var_257_21 + arg_257_0 and not isNil(var_257_19) and arg_254_1.var_.actorSpriteComps1038 then
				for iter_257_9, iter_257_10 in pairs(arg_254_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_257_10 then
						if arg_254_1.isInRecall_ then
							iter_257_10.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1038 = nil
			end

			local var_257_27 = arg_254_1.actors_["1019"]
			local var_257_28 = 0

			if var_257_28 < arg_254_1.time_ and arg_254_1.time_ <= var_257_28 + arg_257_0 then
				local var_257_29 = var_257_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_257_29 then
					arg_254_1.var_.alphaOldValue1019 = var_257_29.alpha
					arg_254_1.var_.characterEffect1019 = var_257_29
				end

				arg_254_1.var_.alphaOldValue1019 = 0
			end

			local var_257_30 = 0.2

			if var_257_28 <= arg_254_1.time_ and arg_254_1.time_ < var_257_28 + var_257_30 then
				local var_257_31 = (arg_254_1.time_ - var_257_28) / var_257_30
				local var_257_32 = Mathf.Lerp(arg_254_1.var_.alphaOldValue1019, 1, var_257_31)

				if arg_254_1.var_.characterEffect1019 then
					arg_254_1.var_.characterEffect1019.alpha = var_257_32
				end
			end

			if arg_254_1.time_ >= var_257_28 + var_257_30 and arg_254_1.time_ < var_257_28 + var_257_30 + arg_257_0 and arg_254_1.var_.characterEffect1019 then
				arg_254_1.var_.characterEffect1019.alpha = 1
			end

			local var_257_33 = 0
			local var_257_34 = 0.25

			if var_257_33 < arg_254_1.time_ and arg_254_1.time_ <= var_257_33 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_35 = arg_254_1:FormatText(StoryNameCfg[13].name)

				arg_254_1.leftNameTxt_.text = var_257_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_36 = arg_254_1:GetWordFromCfg(900701057)
				local var_257_37 = arg_254_1:FormatText(var_257_36.content)

				arg_254_1.text_.text = var_257_37

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_38 = 10
				local var_257_39 = utf8.len(var_257_37)
				local var_257_40 = var_257_38 <= 0 and var_257_34 or var_257_34 * (var_257_39 / var_257_38)

				if var_257_40 > 0 and var_257_34 < var_257_40 then
					arg_254_1.talkMaxDuration = var_257_40

					if var_257_40 + var_257_33 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_40 + var_257_33
					end
				end

				arg_254_1.text_.text = var_257_37
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_41 = math.max(var_257_34, arg_254_1.talkMaxDuration)

			if var_257_33 <= arg_254_1.time_ and arg_254_1.time_ < var_257_33 + var_257_41 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_33) / var_257_41

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_33 + var_257_41 and arg_254_1.time_ < var_257_33 + var_257_41 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play900701058 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 900701058
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play900701059(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1019"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1019 = var_261_0.localPosition
				var_261_0.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1019", 7)

				local var_261_2 = var_261_0.childCount

				for iter_261_0 = 0, var_261_2 - 1 do
					local var_261_3 = var_261_0:GetChild(iter_261_0)

					if var_261_3.name == "split_1" or not string.find(var_261_3.name, "split") then
						var_261_3.gameObject:SetActive(true)
					else
						var_261_3.gameObject:SetActive(false)
					end
				end
			end

			local var_261_4 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_4 then
				local var_261_5 = (arg_258_1.time_ - var_261_1) / var_261_4
				local var_261_6 = Vector3.New(0, -2000, 200)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1019, var_261_6, var_261_5)
			end

			if arg_258_1.time_ >= var_261_1 + var_261_4 and arg_258_1.time_ < var_261_1 + var_261_4 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_261_7 = arg_258_1.actors_["1038"].transform
			local var_261_8 = 0

			if var_261_8 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.var_.moveOldPos1038 = var_261_7.localPosition
				var_261_7.localScale = Vector3.New(-1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1038", 7)

				local var_261_9 = var_261_7.childCount

				for iter_261_1 = 0, var_261_9 - 1 do
					local var_261_10 = var_261_7:GetChild(iter_261_1)

					if var_261_10.name == "split_1" or not string.find(var_261_10.name, "split") then
						var_261_10.gameObject:SetActive(true)
					else
						var_261_10.gameObject:SetActive(false)
					end
				end
			end

			local var_261_11 = 0.001

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_11 then
				local var_261_12 = (arg_258_1.time_ - var_261_8) / var_261_11
				local var_261_13 = Vector3.New(0, -2000, 0)

				var_261_7.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1038, var_261_13, var_261_12)
			end

			if arg_258_1.time_ >= var_261_8 + var_261_11 and arg_258_1.time_ < var_261_8 + var_261_11 + arg_261_0 then
				var_261_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_14 = arg_258_1.actors_["1033"].transform
			local var_261_15 = 0

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.var_.moveOldPos1033 = var_261_14.localPosition
				var_261_14.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1033", 3)

				local var_261_16 = var_261_14.childCount

				for iter_261_2 = 0, var_261_16 - 1 do
					local var_261_17 = var_261_14:GetChild(iter_261_2)

					if var_261_17.name == "split_4" or not string.find(var_261_17.name, "split") then
						var_261_17.gameObject:SetActive(true)
					else
						var_261_17.gameObject:SetActive(false)
					end
				end
			end

			local var_261_18 = 0.001

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_18 then
				local var_261_19 = (arg_258_1.time_ - var_261_15) / var_261_18
				local var_261_20 = Vector3.New(0, -420, 0)

				var_261_14.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1033, var_261_20, var_261_19)
			end

			if arg_258_1.time_ >= var_261_15 + var_261_18 and arg_258_1.time_ < var_261_15 + var_261_18 + arg_261_0 then
				var_261_14.localPosition = Vector3.New(0, -420, 0)
			end

			local var_261_21 = arg_258_1.actors_["1033"]
			local var_261_22 = 0

			if var_261_22 < arg_258_1.time_ and arg_258_1.time_ <= var_261_22 + arg_261_0 and not isNil(var_261_21) and arg_258_1.var_.actorSpriteComps1033 == nil then
				arg_258_1.var_.actorSpriteComps1033 = var_261_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_23 = 0.2

			if var_261_22 <= arg_258_1.time_ and arg_258_1.time_ < var_261_22 + var_261_23 and not isNil(var_261_21) then
				local var_261_24 = (arg_258_1.time_ - var_261_22) / var_261_23

				if arg_258_1.var_.actorSpriteComps1033 then
					for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_261_4 then
							if arg_258_1.isInRecall_ then
								local var_261_25 = Mathf.Lerp(iter_261_4.color.r, arg_258_1.hightColor1.r, var_261_24)
								local var_261_26 = Mathf.Lerp(iter_261_4.color.g, arg_258_1.hightColor1.g, var_261_24)
								local var_261_27 = Mathf.Lerp(iter_261_4.color.b, arg_258_1.hightColor1.b, var_261_24)

								iter_261_4.color = Color.New(var_261_25, var_261_26, var_261_27)
							else
								local var_261_28 = Mathf.Lerp(iter_261_4.color.r, 1, var_261_24)

								iter_261_4.color = Color.New(var_261_28, var_261_28, var_261_28)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_22 + var_261_23 and arg_258_1.time_ < var_261_22 + var_261_23 + arg_261_0 and not isNil(var_261_21) and arg_258_1.var_.actorSpriteComps1033 then
				for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_261_6 then
						if arg_258_1.isInRecall_ then
							iter_261_6.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps1033 = nil
			end

			local var_261_29 = 0
			local var_261_30 = 0.325

			if var_261_29 < arg_258_1.time_ and arg_258_1.time_ <= var_261_29 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_31 = arg_258_1:FormatText(StoryNameCfg[236].name)

				arg_258_1.leftNameTxt_.text = var_261_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_32 = arg_258_1:GetWordFromCfg(900701058)
				local var_261_33 = arg_258_1:FormatText(var_261_32.content)

				arg_258_1.text_.text = var_261_33

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_34 = 13
				local var_261_35 = utf8.len(var_261_33)
				local var_261_36 = var_261_34 <= 0 and var_261_30 or var_261_30 * (var_261_35 / var_261_34)

				if var_261_36 > 0 and var_261_30 < var_261_36 then
					arg_258_1.talkMaxDuration = var_261_36

					if var_261_36 + var_261_29 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_36 + var_261_29
					end
				end

				arg_258_1.text_.text = var_261_33
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_37 = math.max(var_261_30, arg_258_1.talkMaxDuration)

			if var_261_29 <= arg_258_1.time_ and arg_258_1.time_ < var_261_29 + var_261_37 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_29) / var_261_37

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_29 + var_261_37 and arg_258_1.time_ < var_261_29 + var_261_37 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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

		arg_258_1:InitPlayNodeList()
	end,
	Play900701059 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 900701059
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play900701060(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1019"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1019 = var_265_0.localPosition
				var_265_0.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1019", 2)

				local var_265_2 = var_265_0.childCount

				for iter_265_0 = 0, var_265_2 - 1 do
					local var_265_3 = var_265_0:GetChild(iter_265_0)

					if var_265_3.name == "split_1" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_4 then
				local var_265_5 = (arg_262_1.time_ - var_265_1) / var_265_4
				local var_265_6 = Vector3.New(-600, -340, 200)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1019, var_265_6, var_265_5)
			end

			if arg_262_1.time_ >= var_265_1 + var_265_4 and arg_262_1.time_ < var_265_1 + var_265_4 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_265_7 = arg_262_1.actors_["1038"].transform
			local var_265_8 = 0

			if var_265_8 < arg_262_1.time_ and arg_262_1.time_ <= var_265_8 + arg_265_0 then
				arg_262_1.var_.moveOldPos1038 = var_265_7.localPosition
				var_265_7.localScale = Vector3.New(-1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1038", 4)

				local var_265_9 = var_265_7.childCount

				for iter_265_1 = 0, var_265_9 - 1 do
					local var_265_10 = var_265_7:GetChild(iter_265_1)

					if var_265_10.name == "split_2" or not string.find(var_265_10.name, "split") then
						var_265_10.gameObject:SetActive(true)
					else
						var_265_10.gameObject:SetActive(false)
					end
				end
			end

			local var_265_11 = 0.001

			if var_265_8 <= arg_262_1.time_ and arg_262_1.time_ < var_265_8 + var_265_11 then
				local var_265_12 = (arg_262_1.time_ - var_265_8) / var_265_11
				local var_265_13 = Vector3.New(390, -400, 0)

				var_265_7.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1038, var_265_13, var_265_12)
			end

			if arg_262_1.time_ >= var_265_8 + var_265_11 and arg_262_1.time_ < var_265_8 + var_265_11 + arg_265_0 then
				var_265_7.localPosition = Vector3.New(390, -400, 0)
			end

			local var_265_14 = arg_262_1.actors_["1019"]
			local var_265_15 = 0

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 and not isNil(var_265_14) and arg_262_1.var_.actorSpriteComps1019 == nil then
				arg_262_1.var_.actorSpriteComps1019 = var_265_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_16 = 0.2

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_16 and not isNil(var_265_14) then
				local var_265_17 = (arg_262_1.time_ - var_265_15) / var_265_16

				if arg_262_1.var_.actorSpriteComps1019 then
					for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_265_3 then
							if arg_262_1.isInRecall_ then
								local var_265_18 = Mathf.Lerp(iter_265_3.color.r, arg_262_1.hightColor2.r, var_265_17)
								local var_265_19 = Mathf.Lerp(iter_265_3.color.g, arg_262_1.hightColor2.g, var_265_17)
								local var_265_20 = Mathf.Lerp(iter_265_3.color.b, arg_262_1.hightColor2.b, var_265_17)

								iter_265_3.color = Color.New(var_265_18, var_265_19, var_265_20)
							else
								local var_265_21 = Mathf.Lerp(iter_265_3.color.r, 0.5, var_265_17)

								iter_265_3.color = Color.New(var_265_21, var_265_21, var_265_21)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_15 + var_265_16 and arg_262_1.time_ < var_265_15 + var_265_16 + arg_265_0 and not isNil(var_265_14) and arg_262_1.var_.actorSpriteComps1019 then
				for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_265_5 then
						if arg_262_1.isInRecall_ then
							iter_265_5.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps1019 = nil
			end

			local var_265_22 = arg_262_1.actors_["1038"]
			local var_265_23 = 0

			if var_265_23 < arg_262_1.time_ and arg_262_1.time_ <= var_265_23 + arg_265_0 and not isNil(var_265_22) and arg_262_1.var_.actorSpriteComps1038 == nil then
				arg_262_1.var_.actorSpriteComps1038 = var_265_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_24 = 0.2

			if var_265_23 <= arg_262_1.time_ and arg_262_1.time_ < var_265_23 + var_265_24 and not isNil(var_265_22) then
				local var_265_25 = (arg_262_1.time_ - var_265_23) / var_265_24

				if arg_262_1.var_.actorSpriteComps1038 then
					for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_265_7 then
							if arg_262_1.isInRecall_ then
								local var_265_26 = Mathf.Lerp(iter_265_7.color.r, arg_262_1.hightColor1.r, var_265_25)
								local var_265_27 = Mathf.Lerp(iter_265_7.color.g, arg_262_1.hightColor1.g, var_265_25)
								local var_265_28 = Mathf.Lerp(iter_265_7.color.b, arg_262_1.hightColor1.b, var_265_25)

								iter_265_7.color = Color.New(var_265_26, var_265_27, var_265_28)
							else
								local var_265_29 = Mathf.Lerp(iter_265_7.color.r, 1, var_265_25)

								iter_265_7.color = Color.New(var_265_29, var_265_29, var_265_29)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_23 + var_265_24 and arg_262_1.time_ < var_265_23 + var_265_24 + arg_265_0 and not isNil(var_265_22) and arg_262_1.var_.actorSpriteComps1038 then
				for iter_265_8, iter_265_9 in pairs(arg_262_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_265_9 then
						if arg_262_1.isInRecall_ then
							iter_265_9.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps1038 = nil
			end

			local var_265_30 = arg_262_1.actors_["1033"].transform
			local var_265_31 = 0

			if var_265_31 < arg_262_1.time_ and arg_262_1.time_ <= var_265_31 + arg_265_0 then
				arg_262_1.var_.moveOldPos1033 = var_265_30.localPosition
				var_265_30.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("1033", 7)

				local var_265_32 = var_265_30.childCount

				for iter_265_10 = 0, var_265_32 - 1 do
					local var_265_33 = var_265_30:GetChild(iter_265_10)

					if var_265_33.name == "split_4" or not string.find(var_265_33.name, "split") then
						var_265_33.gameObject:SetActive(true)
					else
						var_265_33.gameObject:SetActive(false)
					end
				end
			end

			local var_265_34 = 0.001

			if var_265_31 <= arg_262_1.time_ and arg_262_1.time_ < var_265_31 + var_265_34 then
				local var_265_35 = (arg_262_1.time_ - var_265_31) / var_265_34
				local var_265_36 = Vector3.New(0, -2000, 0)

				var_265_30.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1033, var_265_36, var_265_35)
			end

			if arg_262_1.time_ >= var_265_31 + var_265_34 and arg_262_1.time_ < var_265_31 + var_265_34 + arg_265_0 then
				var_265_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_37 = 0
			local var_265_38 = 0.475

			if var_265_37 < arg_262_1.time_ and arg_262_1.time_ <= var_265_37 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_39 = arg_262_1:FormatText(StoryNameCfg[94].name)

				arg_262_1.leftNameTxt_.text = var_265_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_40 = arg_262_1:GetWordFromCfg(900701059)
				local var_265_41 = arg_262_1:FormatText(var_265_40.content)

				arg_262_1.text_.text = var_265_41

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_42 = 19
				local var_265_43 = utf8.len(var_265_41)
				local var_265_44 = var_265_42 <= 0 and var_265_38 or var_265_38 * (var_265_43 / var_265_42)

				if var_265_44 > 0 and var_265_38 < var_265_44 then
					arg_262_1.talkMaxDuration = var_265_44

					if var_265_44 + var_265_37 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_44 + var_265_37
					end
				end

				arg_262_1.text_.text = var_265_41
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_45 = math.max(var_265_38, arg_262_1.talkMaxDuration)

			if var_265_37 <= arg_262_1.time_ and arg_262_1.time_ < var_265_37 + var_265_45 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_37) / var_265_45

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_37 + var_265_45 and arg_262_1.time_ < var_265_37 + var_265_45 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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

		arg_262_1:InitPlayNodeList()
	end,
	Play900701060 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 900701060
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play900701061(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1019"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps1019 == nil then
				arg_266_1.var_.actorSpriteComps1019 = var_269_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.actorSpriteComps1019 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								local var_269_4 = Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, var_269_3)
								local var_269_5 = Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, var_269_3)
								local var_269_6 = Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, var_269_3)

								iter_269_1.color = Color.New(var_269_4, var_269_5, var_269_6)
							else
								local var_269_7 = Mathf.Lerp(iter_269_1.color.r, 1, var_269_3)

								iter_269_1.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps1019 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_269_3 then
						if arg_266_1.isInRecall_ then
							iter_269_3.color = arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_269_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps1019 = nil
			end

			local var_269_8 = arg_266_1.actors_["1038"]
			local var_269_9 = 0

			if var_269_9 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 and not isNil(var_269_8) and arg_266_1.var_.actorSpriteComps1038 == nil then
				arg_266_1.var_.actorSpriteComps1038 = var_269_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_10 = 0.2

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_10 and not isNil(var_269_8) then
				local var_269_11 = (arg_266_1.time_ - var_269_9) / var_269_10

				if arg_266_1.var_.actorSpriteComps1038 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_269_5 then
							if arg_266_1.isInRecall_ then
								local var_269_12 = Mathf.Lerp(iter_269_5.color.r, arg_266_1.hightColor2.r, var_269_11)
								local var_269_13 = Mathf.Lerp(iter_269_5.color.g, arg_266_1.hightColor2.g, var_269_11)
								local var_269_14 = Mathf.Lerp(iter_269_5.color.b, arg_266_1.hightColor2.b, var_269_11)

								iter_269_5.color = Color.New(var_269_12, var_269_13, var_269_14)
							else
								local var_269_15 = Mathf.Lerp(iter_269_5.color.r, 0.5, var_269_11)

								iter_269_5.color = Color.New(var_269_15, var_269_15, var_269_15)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_9 + var_269_10 and arg_266_1.time_ < var_269_9 + var_269_10 + arg_269_0 and not isNil(var_269_8) and arg_266_1.var_.actorSpriteComps1038 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_269_7 then
						if arg_266_1.isInRecall_ then
							iter_269_7.color = arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_269_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps1038 = nil
			end

			local var_269_16 = 0
			local var_269_17 = 0.275

			if var_269_16 < arg_266_1.time_ and arg_266_1.time_ <= var_269_16 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_18 = arg_266_1:FormatText(StoryNameCfg[13].name)

				arg_266_1.leftNameTxt_.text = var_269_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_19 = arg_266_1:GetWordFromCfg(900701060)
				local var_269_20 = arg_266_1:FormatText(var_269_19.content)

				arg_266_1.text_.text = var_269_20

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_21 = 11
				local var_269_22 = utf8.len(var_269_20)
				local var_269_23 = var_269_21 <= 0 and var_269_17 or var_269_17 * (var_269_22 / var_269_21)

				if var_269_23 > 0 and var_269_17 < var_269_23 then
					arg_266_1.talkMaxDuration = var_269_23

					if var_269_23 + var_269_16 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_16
					end
				end

				arg_266_1.text_.text = var_269_20
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_24 = math.max(var_269_17, arg_266_1.talkMaxDuration)

			if var_269_16 <= arg_266_1.time_ and arg_266_1.time_ < var_269_16 + var_269_24 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_16) / var_269_24

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_16 + var_269_24 and arg_266_1.time_ < var_269_16 + var_269_24 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play900701061 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 900701061
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play900701062(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1033"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1033 = var_273_0.localPosition
				var_273_0.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1033", 3)

				local var_273_2 = var_273_0.childCount

				for iter_273_0 = 0, var_273_2 - 1 do
					local var_273_3 = var_273_0:GetChild(iter_273_0)

					if var_273_3.name == "split_2" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_4 then
				local var_273_5 = (arg_270_1.time_ - var_273_1) / var_273_4
				local var_273_6 = Vector3.New(0, -420, 0)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1033, var_273_6, var_273_5)
			end

			if arg_270_1.time_ >= var_273_1 + var_273_4 and arg_270_1.time_ < var_273_1 + var_273_4 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -420, 0)
			end

			local var_273_7 = arg_270_1.actors_["1033"]
			local var_273_8 = 0

			if var_273_8 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps1033 == nil then
				arg_270_1.var_.actorSpriteComps1033 = var_273_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_9 = 0.2

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_9 and not isNil(var_273_7) then
				local var_273_10 = (arg_270_1.time_ - var_273_8) / var_273_9

				if arg_270_1.var_.actorSpriteComps1033 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								local var_273_11 = Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, var_273_10)
								local var_273_12 = Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, var_273_10)
								local var_273_13 = Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, var_273_10)

								iter_273_2.color = Color.New(var_273_11, var_273_12, var_273_13)
							else
								local var_273_14 = Mathf.Lerp(iter_273_2.color.r, 1, var_273_10)

								iter_273_2.color = Color.New(var_273_14, var_273_14, var_273_14)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_8 + var_273_9 and arg_270_1.time_ < var_273_8 + var_273_9 + arg_273_0 and not isNil(var_273_7) and arg_270_1.var_.actorSpriteComps1033 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_273_4 then
						if arg_270_1.isInRecall_ then
							iter_273_4.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps1033 = nil
			end

			local var_273_15 = arg_270_1.actors_["1019"].transform
			local var_273_16 = 0

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1.var_.moveOldPos1019 = var_273_15.localPosition
				var_273_15.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1019", 7)

				local var_273_17 = var_273_15.childCount

				for iter_273_5 = 0, var_273_17 - 1 do
					local var_273_18 = var_273_15:GetChild(iter_273_5)

					if var_273_18.name == "split_1" or not string.find(var_273_18.name, "split") then
						var_273_18.gameObject:SetActive(true)
					else
						var_273_18.gameObject:SetActive(false)
					end
				end
			end

			local var_273_19 = 0.001

			if var_273_16 <= arg_270_1.time_ and arg_270_1.time_ < var_273_16 + var_273_19 then
				local var_273_20 = (arg_270_1.time_ - var_273_16) / var_273_19
				local var_273_21 = Vector3.New(0, -2000, 200)

				var_273_15.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1019, var_273_21, var_273_20)
			end

			if arg_270_1.time_ >= var_273_16 + var_273_19 and arg_270_1.time_ < var_273_16 + var_273_19 + arg_273_0 then
				var_273_15.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_273_22 = arg_270_1.actors_["1038"].transform
			local var_273_23 = 0

			if var_273_23 < arg_270_1.time_ and arg_270_1.time_ <= var_273_23 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038 = var_273_22.localPosition
				var_273_22.localScale = Vector3.New(-1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1038", 7)

				local var_273_24 = var_273_22.childCount

				for iter_273_6 = 0, var_273_24 - 1 do
					local var_273_25 = var_273_22:GetChild(iter_273_6)

					if var_273_25.name == "split_2" or not string.find(var_273_25.name, "split") then
						var_273_25.gameObject:SetActive(true)
					else
						var_273_25.gameObject:SetActive(false)
					end
				end
			end

			local var_273_26 = 0.001

			if var_273_23 <= arg_270_1.time_ and arg_270_1.time_ < var_273_23 + var_273_26 then
				local var_273_27 = (arg_270_1.time_ - var_273_23) / var_273_26
				local var_273_28 = Vector3.New(0, -2000, 0)

				var_273_22.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038, var_273_28, var_273_27)
			end

			if arg_270_1.time_ >= var_273_23 + var_273_26 and arg_270_1.time_ < var_273_23 + var_273_26 + arg_273_0 then
				var_273_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_273_29 = 0
			local var_273_30 = 0.3

			if var_273_29 < arg_270_1.time_ and arg_270_1.time_ <= var_273_29 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_31 = arg_270_1:FormatText(StoryNameCfg[236].name)

				arg_270_1.leftNameTxt_.text = var_273_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_32 = arg_270_1:GetWordFromCfg(900701061)
				local var_273_33 = arg_270_1:FormatText(var_273_32.content)

				arg_270_1.text_.text = var_273_33

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_34 = 12
				local var_273_35 = utf8.len(var_273_33)
				local var_273_36 = var_273_34 <= 0 and var_273_30 or var_273_30 * (var_273_35 / var_273_34)

				if var_273_36 > 0 and var_273_30 < var_273_36 then
					arg_270_1.talkMaxDuration = var_273_36

					if var_273_36 + var_273_29 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_36 + var_273_29
					end
				end

				arg_270_1.text_.text = var_273_33
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_37 = math.max(var_273_30, arg_270_1.talkMaxDuration)

			if var_273_29 <= arg_270_1.time_ and arg_270_1.time_ < var_273_29 + var_273_37 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_29) / var_273_37

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_29 + var_273_37 and arg_270_1.time_ < var_273_29 + var_273_37 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
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
	Play900701062 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 900701062
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play900701063(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1033"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1033 = var_277_0.localPosition
				var_277_0.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1033", 7)

				local var_277_2 = var_277_0.childCount

				for iter_277_0 = 0, var_277_2 - 1 do
					local var_277_3 = var_277_0:GetChild(iter_277_0)

					if var_277_3.name == "split_2" or not string.find(var_277_3.name, "split") then
						var_277_3.gameObject:SetActive(true)
					else
						var_277_3.gameObject:SetActive(false)
					end
				end
			end

			local var_277_4 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_4 then
				local var_277_5 = (arg_274_1.time_ - var_277_1) / var_277_4
				local var_277_6 = Vector3.New(0, -2000, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1033, var_277_6, var_277_5)
			end

			if arg_274_1.time_ >= var_277_1 + var_277_4 and arg_274_1.time_ < var_277_1 + var_277_4 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_277_7 = arg_274_1.actors_["1038"]
			local var_277_8 = 0

			if var_277_8 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 and not isNil(var_277_7) and arg_274_1.var_.actorSpriteComps1038 == nil then
				arg_274_1.var_.actorSpriteComps1038 = var_277_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_9 = 0.2

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_9 and not isNil(var_277_7) then
				local var_277_10 = (arg_274_1.time_ - var_277_8) / var_277_9

				if arg_274_1.var_.actorSpriteComps1038 then
					for iter_277_1, iter_277_2 in pairs(arg_274_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_277_2 then
							if arg_274_1.isInRecall_ then
								local var_277_11 = Mathf.Lerp(iter_277_2.color.r, arg_274_1.hightColor1.r, var_277_10)
								local var_277_12 = Mathf.Lerp(iter_277_2.color.g, arg_274_1.hightColor1.g, var_277_10)
								local var_277_13 = Mathf.Lerp(iter_277_2.color.b, arg_274_1.hightColor1.b, var_277_10)

								iter_277_2.color = Color.New(var_277_11, var_277_12, var_277_13)
							else
								local var_277_14 = Mathf.Lerp(iter_277_2.color.r, 1, var_277_10)

								iter_277_2.color = Color.New(var_277_14, var_277_14, var_277_14)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_8 + var_277_9 and arg_274_1.time_ < var_277_8 + var_277_9 + arg_277_0 and not isNil(var_277_7) and arg_274_1.var_.actorSpriteComps1038 then
				for iter_277_3, iter_277_4 in pairs(arg_274_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_277_4 then
						if arg_274_1.isInRecall_ then
							iter_277_4.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_277_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1038 = nil
			end

			local var_277_15 = arg_274_1.actors_["1019"].transform
			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.var_.moveOldPos1019 = var_277_15.localPosition
				var_277_15.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1019", 7)

				local var_277_17 = var_277_15.childCount

				for iter_277_5 = 0, var_277_17 - 1 do
					local var_277_18 = var_277_15:GetChild(iter_277_5)

					if var_277_18.name == "split_1" or not string.find(var_277_18.name, "split") then
						var_277_18.gameObject:SetActive(true)
					else
						var_277_18.gameObject:SetActive(false)
					end
				end
			end

			local var_277_19 = 0.001

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_19 then
				local var_277_20 = (arg_274_1.time_ - var_277_16) / var_277_19
				local var_277_21 = Vector3.New(0, -2000, 200)

				var_277_15.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1019, var_277_21, var_277_20)
			end

			if arg_274_1.time_ >= var_277_16 + var_277_19 and arg_274_1.time_ < var_277_16 + var_277_19 + arg_277_0 then
				var_277_15.localPosition = Vector3.New(0, -2000, 200)
			end

			local var_277_22 = arg_274_1.actors_["1038"].transform
			local var_277_23 = 0

			if var_277_23 < arg_274_1.time_ and arg_274_1.time_ <= var_277_23 + arg_277_0 then
				arg_274_1.var_.moveOldPos1038 = var_277_22.localPosition
				var_277_22.localScale = Vector3.New(-1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1038", 4)

				local var_277_24 = var_277_22.childCount

				for iter_277_6 = 0, var_277_24 - 1 do
					local var_277_25 = var_277_22:GetChild(iter_277_6)

					if var_277_25.name == "split_9" or not string.find(var_277_25.name, "split") then
						var_277_25.gameObject:SetActive(true)
					else
						var_277_25.gameObject:SetActive(false)
					end
				end
			end

			local var_277_26 = 0.001

			if var_277_23 <= arg_274_1.time_ and arg_274_1.time_ < var_277_23 + var_277_26 then
				local var_277_27 = (arg_274_1.time_ - var_277_23) / var_277_26
				local var_277_28 = Vector3.New(390, -400, 0)

				var_277_22.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1038, var_277_28, var_277_27)
			end

			if arg_274_1.time_ >= var_277_23 + var_277_26 and arg_274_1.time_ < var_277_23 + var_277_26 + arg_277_0 then
				var_277_22.localPosition = Vector3.New(390, -400, 0)
			end

			local var_277_29 = 0
			local var_277_30 = 0.65

			if var_277_29 < arg_274_1.time_ and arg_274_1.time_ <= var_277_29 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_31 = arg_274_1:FormatText(StoryNameCfg[94].name)

				arg_274_1.leftNameTxt_.text = var_277_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_32 = arg_274_1:GetWordFromCfg(900701062)
				local var_277_33 = arg_274_1:FormatText(var_277_32.content)

				arg_274_1.text_.text = var_277_33

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_34 = 26
				local var_277_35 = utf8.len(var_277_33)
				local var_277_36 = var_277_34 <= 0 and var_277_30 or var_277_30 * (var_277_35 / var_277_34)

				if var_277_36 > 0 and var_277_30 < var_277_36 then
					arg_274_1.talkMaxDuration = var_277_36

					if var_277_36 + var_277_29 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_36 + var_277_29
					end
				end

				arg_274_1.text_.text = var_277_33
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_37 = math.max(var_277_30, arg_274_1.talkMaxDuration)

			if var_277_29 <= arg_274_1.time_ and arg_274_1.time_ < var_277_29 + var_277_37 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_29) / var_277_37

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_29 + var_277_37 and arg_274_1.time_ < var_277_29 + var_277_37 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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
				actorName = "1019",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play900701063 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 900701063
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play900701064(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1019"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos1019 = var_281_0.localPosition
				var_281_0.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("1019", 2)

				local var_281_2 = var_281_0.childCount

				for iter_281_0 = 0, var_281_2 - 1 do
					local var_281_3 = var_281_0:GetChild(iter_281_0)

					if var_281_3.name == "split_1" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_4 then
				local var_281_5 = (arg_278_1.time_ - var_281_1) / var_281_4
				local var_281_6 = Vector3.New(-600, -340, 200)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1019, var_281_6, var_281_5)
			end

			if arg_278_1.time_ >= var_281_1 + var_281_4 and arg_278_1.time_ < var_281_1 + var_281_4 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(-600, -340, 200)
			end

			local var_281_7 = arg_278_1.actors_["1019"]
			local var_281_8 = 0

			if var_281_8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 and not isNil(var_281_7) and arg_278_1.var_.actorSpriteComps1019 == nil then
				arg_278_1.var_.actorSpriteComps1019 = var_281_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_9 = 0.2

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_9 and not isNil(var_281_7) then
				local var_281_10 = (arg_278_1.time_ - var_281_8) / var_281_9

				if arg_278_1.var_.actorSpriteComps1019 then
					for iter_281_1, iter_281_2 in pairs(arg_278_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_281_2 then
							if arg_278_1.isInRecall_ then
								local var_281_11 = Mathf.Lerp(iter_281_2.color.r, arg_278_1.hightColor1.r, var_281_10)
								local var_281_12 = Mathf.Lerp(iter_281_2.color.g, arg_278_1.hightColor1.g, var_281_10)
								local var_281_13 = Mathf.Lerp(iter_281_2.color.b, arg_278_1.hightColor1.b, var_281_10)

								iter_281_2.color = Color.New(var_281_11, var_281_12, var_281_13)
							else
								local var_281_14 = Mathf.Lerp(iter_281_2.color.r, 1, var_281_10)

								iter_281_2.color = Color.New(var_281_14, var_281_14, var_281_14)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_8 + var_281_9 and arg_278_1.time_ < var_281_8 + var_281_9 + arg_281_0 and not isNil(var_281_7) and arg_278_1.var_.actorSpriteComps1019 then
				for iter_281_3, iter_281_4 in pairs(arg_278_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_281_4 then
						if arg_278_1.isInRecall_ then
							iter_281_4.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1019 = nil
			end

			local var_281_15 = arg_278_1.actors_["1038"]
			local var_281_16 = 0

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.actorSpriteComps1038 == nil then
				arg_278_1.var_.actorSpriteComps1038 = var_281_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_17 = 0.2

			if var_281_16 <= arg_278_1.time_ and arg_278_1.time_ < var_281_16 + var_281_17 and not isNil(var_281_15) then
				local var_281_18 = (arg_278_1.time_ - var_281_16) / var_281_17

				if arg_278_1.var_.actorSpriteComps1038 then
					for iter_281_5, iter_281_6 in pairs(arg_278_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_281_6 then
							if arg_278_1.isInRecall_ then
								local var_281_19 = Mathf.Lerp(iter_281_6.color.r, arg_278_1.hightColor2.r, var_281_18)
								local var_281_20 = Mathf.Lerp(iter_281_6.color.g, arg_278_1.hightColor2.g, var_281_18)
								local var_281_21 = Mathf.Lerp(iter_281_6.color.b, arg_278_1.hightColor2.b, var_281_18)

								iter_281_6.color = Color.New(var_281_19, var_281_20, var_281_21)
							else
								local var_281_22 = Mathf.Lerp(iter_281_6.color.r, 0.5, var_281_18)

								iter_281_6.color = Color.New(var_281_22, var_281_22, var_281_22)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 and not isNil(var_281_15) and arg_278_1.var_.actorSpriteComps1038 then
				for iter_281_7, iter_281_8 in pairs(arg_278_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_281_8 then
						if arg_278_1.isInRecall_ then
							iter_281_8.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1038 = nil
			end

			local var_281_23 = 0
			local var_281_24 = 0.2

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_25 = arg_278_1:FormatText(StoryNameCfg[13].name)

				arg_278_1.leftNameTxt_.text = var_281_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_26 = arg_278_1:GetWordFromCfg(900701063)
				local var_281_27 = arg_278_1:FormatText(var_281_26.content)

				arg_278_1.text_.text = var_281_27

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_28 = 8
				local var_281_29 = utf8.len(var_281_27)
				local var_281_30 = var_281_28 <= 0 and var_281_24 or var_281_24 * (var_281_29 / var_281_28)

				if var_281_30 > 0 and var_281_24 < var_281_30 then
					arg_278_1.talkMaxDuration = var_281_30

					if var_281_30 + var_281_23 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_30 + var_281_23
					end
				end

				arg_278_1.text_.text = var_281_27
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_31 = math.max(var_281_24, arg_278_1.talkMaxDuration)

			if var_281_23 <= arg_278_1.time_ and arg_278_1.time_ < var_281_23 + var_281_31 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_23) / var_281_31

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_23 + var_281_31 and arg_278_1.time_ < var_281_23 + var_281_31 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019",
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
	Play900701064 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 900701064
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play900701065(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1038"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1038 = var_285_0.localPosition
				var_285_0.localScale = Vector3.New(-1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("1038", 4)

				local var_285_2 = var_285_0.childCount

				for iter_285_0 = 0, var_285_2 - 1 do
					local var_285_3 = var_285_0:GetChild(iter_285_0)

					if var_285_3.name == "split_5" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_4 then
				local var_285_5 = (arg_282_1.time_ - var_285_1) / var_285_4
				local var_285_6 = Vector3.New(390, -400, 0)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1038, var_285_6, var_285_5)
			end

			if arg_282_1.time_ >= var_285_1 + var_285_4 and arg_282_1.time_ < var_285_1 + var_285_4 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(390, -400, 0)
			end

			local var_285_7 = arg_282_1.actors_["1038"]
			local var_285_8 = 0

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.actorSpriteComps1038 == nil then
				arg_282_1.var_.actorSpriteComps1038 = var_285_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_9 = 0.2

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_9 and not isNil(var_285_7) then
				local var_285_10 = (arg_282_1.time_ - var_285_8) / var_285_9

				if arg_282_1.var_.actorSpriteComps1038 then
					for iter_285_1, iter_285_2 in pairs(arg_282_1.var_.actorSpriteComps1038:ToTable()) do
						if iter_285_2 then
							if arg_282_1.isInRecall_ then
								local var_285_11 = Mathf.Lerp(iter_285_2.color.r, arg_282_1.hightColor1.r, var_285_10)
								local var_285_12 = Mathf.Lerp(iter_285_2.color.g, arg_282_1.hightColor1.g, var_285_10)
								local var_285_13 = Mathf.Lerp(iter_285_2.color.b, arg_282_1.hightColor1.b, var_285_10)

								iter_285_2.color = Color.New(var_285_11, var_285_12, var_285_13)
							else
								local var_285_14 = Mathf.Lerp(iter_285_2.color.r, 1, var_285_10)

								iter_285_2.color = Color.New(var_285_14, var_285_14, var_285_14)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_8 + var_285_9 and arg_282_1.time_ < var_285_8 + var_285_9 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.actorSpriteComps1038 then
				for iter_285_3, iter_285_4 in pairs(arg_282_1.var_.actorSpriteComps1038:ToTable()) do
					if iter_285_4 then
						if arg_282_1.isInRecall_ then
							iter_285_4.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1038 = nil
			end

			local var_285_15 = arg_282_1.actors_["1019"]
			local var_285_16 = 0

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 and not isNil(var_285_15) and arg_282_1.var_.actorSpriteComps1019 == nil then
				arg_282_1.var_.actorSpriteComps1019 = var_285_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_17 = 0.2

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_17 and not isNil(var_285_15) then
				local var_285_18 = (arg_282_1.time_ - var_285_16) / var_285_17

				if arg_282_1.var_.actorSpriteComps1019 then
					for iter_285_5, iter_285_6 in pairs(arg_282_1.var_.actorSpriteComps1019:ToTable()) do
						if iter_285_6 then
							if arg_282_1.isInRecall_ then
								local var_285_19 = Mathf.Lerp(iter_285_6.color.r, arg_282_1.hightColor2.r, var_285_18)
								local var_285_20 = Mathf.Lerp(iter_285_6.color.g, arg_282_1.hightColor2.g, var_285_18)
								local var_285_21 = Mathf.Lerp(iter_285_6.color.b, arg_282_1.hightColor2.b, var_285_18)

								iter_285_6.color = Color.New(var_285_19, var_285_20, var_285_21)
							else
								local var_285_22 = Mathf.Lerp(iter_285_6.color.r, 0.5, var_285_18)

								iter_285_6.color = Color.New(var_285_22, var_285_22, var_285_22)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_16 + var_285_17 and arg_282_1.time_ < var_285_16 + var_285_17 + arg_285_0 and not isNil(var_285_15) and arg_282_1.var_.actorSpriteComps1019 then
				for iter_285_7, iter_285_8 in pairs(arg_282_1.var_.actorSpriteComps1019:ToTable()) do
					if iter_285_8 then
						if arg_282_1.isInRecall_ then
							iter_285_8.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1019 = nil
			end

			local var_285_23 = 0
			local var_285_24 = 0.125

			if var_285_23 < arg_282_1.time_ and arg_282_1.time_ <= var_285_23 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_25 = arg_282_1:FormatText(StoryNameCfg[94].name)

				arg_282_1.leftNameTxt_.text = var_285_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_26 = arg_282_1:GetWordFromCfg(900701064)
				local var_285_27 = arg_282_1:FormatText(var_285_26.content)

				arg_282_1.text_.text = var_285_27

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_28 = 6
				local var_285_29 = utf8.len(var_285_27)
				local var_285_30 = var_285_28 <= 0 and var_285_24 or var_285_24 * (var_285_29 / var_285_28)

				if var_285_30 > 0 and var_285_24 < var_285_30 then
					arg_282_1.talkMaxDuration = var_285_30

					if var_285_30 + var_285_23 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_30 + var_285_23
					end
				end

				arg_282_1.text_.text = var_285_27
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_31 = math.max(var_285_24, arg_282_1.talkMaxDuration)

			if var_285_23 <= arg_282_1.time_ and arg_282_1.time_ < var_285_23 + var_285_31 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_23) / var_285_31

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_23 + var_285_31 and arg_282_1.time_ < var_285_23 + var_285_31 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play900701065 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 900701065
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
			arg_286_1.auto_ = false
		end

		function arg_286_1.playNext_(arg_288_0)
			arg_286_1.onStoryFinished_()
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.75

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[13].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:GetWordFromCfg(900701065)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 30
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
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/OM0602",
		"TextureConfig/Background/OM0601"
	},
	voices = {}
}
