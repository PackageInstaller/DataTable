return {
	Play413071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F10g"

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
				local var_4_5 = arg_1_1.bgs_.F10g

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
					if iter_4_0 ~= "F10g" then
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
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story", "se_story_alarmloop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.266666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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
			local var_4_35 = 1.4

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_37 = arg_1_1:GetWordFromCfg(413071001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 56
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
	Play413071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 413071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play413071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.2

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(413071002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 48
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play413071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 413071003
		arg_12_1.duration_ = 7.31

		local var_12_0 = {
			zh = 3.975,
			ja = 7.308
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play413071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "10092"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(var_15_1, arg_12_1.canvasGo_.transform)

					var_15_2.transform:SetSiblingIndex(1)

					var_15_2.name = var_15_0
					var_15_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_12_1.actors_[var_15_0] = var_15_2

					local var_15_3 = var_15_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_12_1.isInRecall_ then
						for iter_15_0, iter_15_1 in ipairs(var_15_3) do
							iter_15_1.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_15_4 = arg_12_1.actors_["10092"].transform
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.var_.moveOldPos10092 = var_15_4.localPosition
				var_15_4.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10092", 2)

				local var_15_6 = var_15_4.childCount

				for iter_15_2 = 0, var_15_6 - 1 do
					local var_15_7 = var_15_4:GetChild(iter_15_2)

					if var_15_7.name == "split_8" or not string.find(var_15_7.name, "split") then
						var_15_7.gameObject:SetActive(true)
					else
						var_15_7.gameObject:SetActive(false)
					end
				end
			end

			local var_15_8 = 0.001

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_8 then
				local var_15_9 = (arg_12_1.time_ - var_15_5) / var_15_8
				local var_15_10 = Vector3.New(-389.49, -300, -295)

				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10092, var_15_10, var_15_9)
			end

			if arg_12_1.time_ >= var_15_5 + var_15_8 and arg_12_1.time_ < var_15_5 + var_15_8 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_15_11 = arg_12_1.actors_["10092"]
			local var_15_12 = 0

			if var_15_12 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.actorSpriteComps10092 == nil then
				arg_12_1.var_.actorSpriteComps10092 = var_15_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_13 = 2

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_13 and not isNil(var_15_11) then
				local var_15_14 = (arg_12_1.time_ - var_15_12) / var_15_13

				if arg_12_1.var_.actorSpriteComps10092 then
					for iter_15_3, iter_15_4 in pairs(arg_12_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_15_4 then
							if arg_12_1.isInRecall_ then
								local var_15_15 = Mathf.Lerp(iter_15_4.color.r, arg_12_1.hightColor1.r, var_15_14)
								local var_15_16 = Mathf.Lerp(iter_15_4.color.g, arg_12_1.hightColor1.g, var_15_14)
								local var_15_17 = Mathf.Lerp(iter_15_4.color.b, arg_12_1.hightColor1.b, var_15_14)

								iter_15_4.color = Color.New(var_15_15, var_15_16, var_15_17)
							else
								local var_15_18 = Mathf.Lerp(iter_15_4.color.r, 1, var_15_14)

								iter_15_4.color = Color.New(var_15_18, var_15_18, var_15_18)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_12 + var_15_13 and arg_12_1.time_ < var_15_12 + var_15_13 + arg_15_0 and not isNil(var_15_11) and arg_12_1.var_.actorSpriteComps10092 then
				for iter_15_5, iter_15_6 in pairs(arg_12_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_15_6 then
						if arg_12_1.isInRecall_ then
							iter_15_6.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10092 = nil
			end

			local var_15_19 = arg_12_1.actors_["10092"]
			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				local var_15_21 = var_15_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_15_21 then
					arg_12_1.var_.alphaOldValue10092 = var_15_21.alpha
					arg_12_1.var_.characterEffect10092 = var_15_21
				end

				arg_12_1.var_.alphaOldValue10092 = 0
			end

			local var_15_22 = 0.5

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_22 then
				local var_15_23 = (arg_12_1.time_ - var_15_20) / var_15_22
				local var_15_24 = Mathf.Lerp(arg_12_1.var_.alphaOldValue10092, 1, var_15_23)

				if arg_12_1.var_.characterEffect10092 then
					arg_12_1.var_.characterEffect10092.alpha = var_15_24
				end
			end

			if arg_12_1.time_ >= var_15_20 + var_15_22 and arg_12_1.time_ < var_15_20 + var_15_22 + arg_15_0 and arg_12_1.var_.characterEffect10092 then
				arg_12_1.var_.characterEffect10092.alpha = 1
			end

			local var_15_25 = 0
			local var_15_26 = 0.833333333333333

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				local var_15_27 = "play"
				local var_15_28 = "music"

				arg_12_1:AudioAction(var_15_27, var_15_28, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_15_29 = ""
				local var_15_30 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if var_15_30 ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_30 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_30

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_30
						arg_12_1.bgmTxt2_.text = var_15_30
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_31 = 0.475
			local var_15_32 = 0.525

			if var_15_31 < arg_12_1.time_ and arg_12_1.time_ <= var_15_31 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_33 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_33:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_12_1.dialogCg_.alpha = arg_17_0
				end))
				var_15_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_34 = arg_12_1:FormatText(StoryNameCfg[996].name)

				arg_12_1.leftNameTxt_.text = var_15_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_35 = arg_12_1:GetWordFromCfg(413071003)
				local var_15_36 = arg_12_1:FormatText(var_15_35.content)

				arg_12_1.text_.text = var_15_36

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_37 = 21
				local var_15_38 = utf8.len(var_15_36)
				local var_15_39 = var_15_37 <= 0 and var_15_32 or var_15_32 * (var_15_38 / var_15_37)

				if var_15_39 > 0 and var_15_32 < var_15_39 then
					arg_12_1.talkMaxDuration = var_15_39
					var_15_31 = var_15_31 + 0.3

					if var_15_39 + var_15_31 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_39 + var_15_31
					end
				end

				arg_12_1.text_.text = var_15_36
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071003", "story_v_out_413071.awb") ~= 0 then
					local var_15_40 = manager.audio:GetVoiceLength("story_v_out_413071", "413071003", "story_v_out_413071.awb") / 1000

					if var_15_40 + var_15_31 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_40 + var_15_31
					end

					if var_15_35.prefab_name ~= "" and arg_12_1.actors_[var_15_35.prefab_name] ~= nil then
						local var_15_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_35.prefab_name].transform, "story_v_out_413071", "413071003", "story_v_out_413071.awb")

						arg_12_1:RecordAudio("413071003", var_15_41)
						arg_12_1:RecordAudio("413071003", var_15_41)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_413071", "413071003", "story_v_out_413071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_413071", "413071003", "story_v_out_413071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_42 = var_15_31 + 0.3
			local var_15_43 = math.max(var_15_32, arg_12_1.talkMaxDuration)

			if var_15_42 <= arg_12_1.time_ and arg_12_1.time_ < var_15_42 + var_15_43 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_42) / var_15_43

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_42 + var_15_43 and arg_12_1.time_ < var_15_42 + var_15_43 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play413071004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413071004
		arg_19_1.duration_ = 6

		local var_19_0 = {
			zh = 2.7,
			ja = 6
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play413071005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "10094"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

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

			local var_22_4 = arg_19_1.actors_["10094"].transform
			local var_22_5 = 0

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.var_.moveOldPos10094 = var_22_4.localPosition
				var_22_4.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("10094", 4)

				local var_22_6 = var_22_4.childCount

				for iter_22_2 = 0, var_22_6 - 1 do
					local var_22_7 = var_22_4:GetChild(iter_22_2)

					if var_22_7.name == "" or not string.find(var_22_7.name, "split") then
						var_22_7.gameObject:SetActive(true)
					else
						var_22_7.gameObject:SetActive(false)
					end
				end
			end

			local var_22_8 = 0.001

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_8 then
				local var_22_9 = (arg_19_1.time_ - var_22_5) / var_22_8
				local var_22_10 = Vector3.New(390, -340, -414)

				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos10094, var_22_10, var_22_9)
			end

			if arg_19_1.time_ >= var_22_5 + var_22_8 and arg_19_1.time_ < var_22_5 + var_22_8 + arg_22_0 then
				var_22_4.localPosition = Vector3.New(390, -340, -414)
			end

			local var_22_11 = arg_19_1.actors_["10092"]
			local var_22_12 = 0

			if var_22_12 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 and not isNil(var_22_11) and arg_19_1.var_.actorSpriteComps10092 == nil then
				arg_19_1.var_.actorSpriteComps10092 = var_22_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_13 = 2

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_13 and not isNil(var_22_11) then
				local var_22_14 = (arg_19_1.time_ - var_22_12) / var_22_13

				if arg_19_1.var_.actorSpriteComps10092 then
					for iter_22_3, iter_22_4 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_22_4 then
							if arg_19_1.isInRecall_ then
								local var_22_15 = Mathf.Lerp(iter_22_4.color.r, arg_19_1.hightColor2.r, var_22_14)
								local var_22_16 = Mathf.Lerp(iter_22_4.color.g, arg_19_1.hightColor2.g, var_22_14)
								local var_22_17 = Mathf.Lerp(iter_22_4.color.b, arg_19_1.hightColor2.b, var_22_14)

								iter_22_4.color = Color.New(var_22_15, var_22_16, var_22_17)
							else
								local var_22_18 = Mathf.Lerp(iter_22_4.color.r, 0.5, var_22_14)

								iter_22_4.color = Color.New(var_22_18, var_22_18, var_22_18)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_12 + var_22_13 and arg_19_1.time_ < var_22_12 + var_22_13 + arg_22_0 and not isNil(var_22_11) and arg_19_1.var_.actorSpriteComps10092 then
				for iter_22_5, iter_22_6 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_22_6 then
						if arg_19_1.isInRecall_ then
							iter_22_6.color = arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_22_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps10092 = nil
			end

			local var_22_19 = arg_19_1.actors_["10094"]
			local var_22_20 = 0

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 and not isNil(var_22_19) and arg_19_1.var_.actorSpriteComps10094 == nil then
				arg_19_1.var_.actorSpriteComps10094 = var_22_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_21 = 2

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_21 and not isNil(var_22_19) then
				local var_22_22 = (arg_19_1.time_ - var_22_20) / var_22_21

				if arg_19_1.var_.actorSpriteComps10094 then
					for iter_22_7, iter_22_8 in pairs(arg_19_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_22_8 then
							if arg_19_1.isInRecall_ then
								local var_22_23 = Mathf.Lerp(iter_22_8.color.r, arg_19_1.hightColor1.r, var_22_22)
								local var_22_24 = Mathf.Lerp(iter_22_8.color.g, arg_19_1.hightColor1.g, var_22_22)
								local var_22_25 = Mathf.Lerp(iter_22_8.color.b, arg_19_1.hightColor1.b, var_22_22)

								iter_22_8.color = Color.New(var_22_23, var_22_24, var_22_25)
							else
								local var_22_26 = Mathf.Lerp(iter_22_8.color.r, 1, var_22_22)

								iter_22_8.color = Color.New(var_22_26, var_22_26, var_22_26)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_20 + var_22_21 and arg_19_1.time_ < var_22_20 + var_22_21 + arg_22_0 and not isNil(var_22_19) and arg_19_1.var_.actorSpriteComps10094 then
				for iter_22_9, iter_22_10 in pairs(arg_19_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_22_10 then
						if arg_19_1.isInRecall_ then
							iter_22_10.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_22_10.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps10094 = nil
			end

			local var_22_27 = arg_19_1.actors_["10094"]
			local var_22_28 = 0

			if var_22_28 < arg_19_1.time_ and arg_19_1.time_ <= var_22_28 + arg_22_0 then
				local var_22_29 = var_22_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_29 then
					arg_19_1.var_.alphaOldValue10094 = var_22_29.alpha
					arg_19_1.var_.characterEffect10094 = var_22_29
				end

				arg_19_1.var_.alphaOldValue10094 = 0
			end

			local var_22_30 = 0.5

			if var_22_28 <= arg_19_1.time_ and arg_19_1.time_ < var_22_28 + var_22_30 then
				local var_22_31 = (arg_19_1.time_ - var_22_28) / var_22_30
				local var_22_32 = Mathf.Lerp(arg_19_1.var_.alphaOldValue10094, 1, var_22_31)

				if arg_19_1.var_.characterEffect10094 then
					arg_19_1.var_.characterEffect10094.alpha = var_22_32
				end
			end

			if arg_19_1.time_ >= var_22_28 + var_22_30 and arg_19_1.time_ < var_22_28 + var_22_30 + arg_22_0 and arg_19_1.var_.characterEffect10094 then
				arg_19_1.var_.characterEffect10094.alpha = 1
			end

			local var_22_33 = 0
			local var_22_34 = 0.35

			if var_22_33 < arg_19_1.time_ and arg_19_1.time_ <= var_22_33 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_35 = arg_19_1:FormatText(StoryNameCfg[259].name)

				arg_19_1.leftNameTxt_.text = var_22_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_36 = arg_19_1:GetWordFromCfg(413071004)
				local var_22_37 = arg_19_1:FormatText(var_22_36.content)

				arg_19_1.text_.text = var_22_37

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_38 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071004", "story_v_out_413071.awb") ~= 0 then
					local var_22_41 = manager.audio:GetVoiceLength("story_v_out_413071", "413071004", "story_v_out_413071.awb") / 1000

					if var_22_41 + var_22_33 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_41 + var_22_33
					end

					if var_22_36.prefab_name ~= "" and arg_19_1.actors_[var_22_36.prefab_name] ~= nil then
						local var_22_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_36.prefab_name].transform, "story_v_out_413071", "413071004", "story_v_out_413071.awb")

						arg_19_1:RecordAudio("413071004", var_22_42)
						arg_19_1:RecordAudio("413071004", var_22_42)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413071", "413071004", "story_v_out_413071.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413071", "413071004", "story_v_out_413071.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_43 = math.max(var_22_34, arg_19_1.talkMaxDuration)

			if var_22_33 <= arg_19_1.time_ and arg_19_1.time_ < var_22_33 + var_22_43 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_33) / var_22_43

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_33 + var_22_43 and arg_19_1.time_ < var_22_33 + var_22_43 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413071005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413071005
		arg_23_1.duration_ = 5.53

		local var_23_0 = {
			zh = 3.733,
			ja = 5.533
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413071006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10092"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos10092 = var_26_0.localPosition
				var_26_0.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10092", 2)

				local var_26_2 = var_26_0.childCount

				for iter_26_0 = 0, var_26_2 - 1 do
					local var_26_3 = var_26_0:GetChild(iter_26_0)

					if var_26_3.name == "split_8" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_4 then
				local var_26_5 = (arg_23_1.time_ - var_26_1) / var_26_4
				local var_26_6 = Vector3.New(-389.49, -300, -295)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10092, var_26_6, var_26_5)
			end

			if arg_23_1.time_ >= var_26_1 + var_26_4 and arg_23_1.time_ < var_26_1 + var_26_4 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_26_7 = arg_23_1.actors_["10094"].transform
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.var_.moveOldPos10094 = var_26_7.localPosition
				var_26_7.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10094", 4)

				local var_26_9 = var_26_7.childCount

				for iter_26_1 = 0, var_26_9 - 1 do
					local var_26_10 = var_26_7:GetChild(iter_26_1)

					if var_26_10.name == "" or not string.find(var_26_10.name, "split") then
						var_26_10.gameObject:SetActive(true)
					else
						var_26_10.gameObject:SetActive(false)
					end
				end
			end

			local var_26_11 = 0.001

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_8) / var_26_11
				local var_26_13 = Vector3.New(390, -340, -414)

				var_26_7.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10094, var_26_13, var_26_12)
			end

			if arg_23_1.time_ >= var_26_8 + var_26_11 and arg_23_1.time_ < var_26_8 + var_26_11 + arg_26_0 then
				var_26_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_26_14 = arg_23_1.actors_["10092"]
			local var_26_15 = 0

			if var_26_15 < arg_23_1.time_ and arg_23_1.time_ <= var_26_15 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.actorSpriteComps10092 == nil then
				arg_23_1.var_.actorSpriteComps10092 = var_26_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_16 = 2

			if var_26_15 <= arg_23_1.time_ and arg_23_1.time_ < var_26_15 + var_26_16 and not isNil(var_26_14) then
				local var_26_17 = (arg_23_1.time_ - var_26_15) / var_26_16

				if arg_23_1.var_.actorSpriteComps10092 then
					for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_26_3 then
							if arg_23_1.isInRecall_ then
								local var_26_18 = Mathf.Lerp(iter_26_3.color.r, arg_23_1.hightColor1.r, var_26_17)
								local var_26_19 = Mathf.Lerp(iter_26_3.color.g, arg_23_1.hightColor1.g, var_26_17)
								local var_26_20 = Mathf.Lerp(iter_26_3.color.b, arg_23_1.hightColor1.b, var_26_17)

								iter_26_3.color = Color.New(var_26_18, var_26_19, var_26_20)
							else
								local var_26_21 = Mathf.Lerp(iter_26_3.color.r, 1, var_26_17)

								iter_26_3.color = Color.New(var_26_21, var_26_21, var_26_21)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_15 + var_26_16 and arg_23_1.time_ < var_26_15 + var_26_16 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.actorSpriteComps10092 then
				for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_26_5 then
						if arg_23_1.isInRecall_ then
							iter_26_5.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_26_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps10092 = nil
			end

			local var_26_22 = arg_23_1.actors_["10094"]
			local var_26_23 = 0

			if var_26_23 < arg_23_1.time_ and arg_23_1.time_ <= var_26_23 + arg_26_0 and not isNil(var_26_22) and arg_23_1.var_.actorSpriteComps10094 == nil then
				arg_23_1.var_.actorSpriteComps10094 = var_26_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_24 = 2

			if var_26_23 <= arg_23_1.time_ and arg_23_1.time_ < var_26_23 + var_26_24 and not isNil(var_26_22) then
				local var_26_25 = (arg_23_1.time_ - var_26_23) / var_26_24

				if arg_23_1.var_.actorSpriteComps10094 then
					for iter_26_6, iter_26_7 in pairs(arg_23_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_26_7 then
							if arg_23_1.isInRecall_ then
								local var_26_26 = Mathf.Lerp(iter_26_7.color.r, arg_23_1.hightColor2.r, var_26_25)
								local var_26_27 = Mathf.Lerp(iter_26_7.color.g, arg_23_1.hightColor2.g, var_26_25)
								local var_26_28 = Mathf.Lerp(iter_26_7.color.b, arg_23_1.hightColor2.b, var_26_25)

								iter_26_7.color = Color.New(var_26_26, var_26_27, var_26_28)
							else
								local var_26_29 = Mathf.Lerp(iter_26_7.color.r, 0.5, var_26_25)

								iter_26_7.color = Color.New(var_26_29, var_26_29, var_26_29)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_23 + var_26_24 and arg_23_1.time_ < var_26_23 + var_26_24 + arg_26_0 and not isNil(var_26_22) and arg_23_1.var_.actorSpriteComps10094 then
				for iter_26_8, iter_26_9 in pairs(arg_23_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_26_9 then
						if arg_23_1.isInRecall_ then
							iter_26_9.color = arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_26_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps10094 = nil
			end

			local var_26_30 = 0
			local var_26_31 = 0.55

			if var_26_30 < arg_23_1.time_ and arg_23_1.time_ <= var_26_30 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_32 = arg_23_1:FormatText(StoryNameCfg[996].name)

				arg_23_1.leftNameTxt_.text = var_26_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_33 = arg_23_1:GetWordFromCfg(413071005)
				local var_26_34 = arg_23_1:FormatText(var_26_33.content)

				arg_23_1.text_.text = var_26_34

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_35 = 22
				local var_26_36 = utf8.len(var_26_34)
				local var_26_37 = var_26_35 <= 0 and var_26_31 or var_26_31 * (var_26_36 / var_26_35)

				if var_26_37 > 0 and var_26_31 < var_26_37 then
					arg_23_1.talkMaxDuration = var_26_37

					if var_26_37 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_37 + var_26_30
					end
				end

				arg_23_1.text_.text = var_26_34
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071005", "story_v_out_413071.awb") ~= 0 then
					local var_26_38 = manager.audio:GetVoiceLength("story_v_out_413071", "413071005", "story_v_out_413071.awb") / 1000

					if var_26_38 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_38 + var_26_30
					end

					if var_26_33.prefab_name ~= "" and arg_23_1.actors_[var_26_33.prefab_name] ~= nil then
						local var_26_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_33.prefab_name].transform, "story_v_out_413071", "413071005", "story_v_out_413071.awb")

						arg_23_1:RecordAudio("413071005", var_26_39)
						arg_23_1:RecordAudio("413071005", var_26_39)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413071", "413071005", "story_v_out_413071.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413071", "413071005", "story_v_out_413071.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_40 = math.max(var_26_31, arg_23_1.talkMaxDuration)

			if var_26_30 <= arg_23_1.time_ and arg_23_1.time_ < var_26_30 + var_26_40 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_30) / var_26_40

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_30 + var_26_40 and arg_23_1.time_ < var_26_30 + var_26_40 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play413071006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413071006
		arg_27_1.duration_ = 8.37

		local var_27_0 = {
			zh = 3.166,
			ja = 8.366
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play413071007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10094"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos10094 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10094", 4)

				local var_30_2 = var_30_0.childCount

				for iter_30_0 = 0, var_30_2 - 1 do
					local var_30_3 = var_30_0:GetChild(iter_30_0)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_4 then
				local var_30_5 = (arg_27_1.time_ - var_30_1) / var_30_4
				local var_30_6 = Vector3.New(390, -340, -414)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10094, var_30_6, var_30_5)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_4 and arg_27_1.time_ < var_30_1 + var_30_4 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_30_7 = arg_27_1.actors_["10092"]
			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.actorSpriteComps10092 == nil then
				arg_27_1.var_.actorSpriteComps10092 = var_30_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_9 = 2

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 and not isNil(var_30_7) then
				local var_30_10 = (arg_27_1.time_ - var_30_8) / var_30_9

				if arg_27_1.var_.actorSpriteComps10092 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								local var_30_11 = Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor2.r, var_30_10)
								local var_30_12 = Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor2.g, var_30_10)
								local var_30_13 = Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor2.b, var_30_10)

								iter_30_2.color = Color.New(var_30_11, var_30_12, var_30_13)
							else
								local var_30_14 = Mathf.Lerp(iter_30_2.color.r, 0.5, var_30_10)

								iter_30_2.color = Color.New(var_30_14, var_30_14, var_30_14)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.actorSpriteComps10092 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_30_4 then
						if arg_27_1.isInRecall_ then
							iter_30_4.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10092 = nil
			end

			local var_30_15 = arg_27_1.actors_["10094"]
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.actorSpriteComps10094 == nil then
				arg_27_1.var_.actorSpriteComps10094 = var_30_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_17 = 2

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 and not isNil(var_30_15) then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17

				if arg_27_1.var_.actorSpriteComps10094 then
					for iter_30_5, iter_30_6 in pairs(arg_27_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_30_6 then
							if arg_27_1.isInRecall_ then
								local var_30_19 = Mathf.Lerp(iter_30_6.color.r, arg_27_1.hightColor1.r, var_30_18)
								local var_30_20 = Mathf.Lerp(iter_30_6.color.g, arg_27_1.hightColor1.g, var_30_18)
								local var_30_21 = Mathf.Lerp(iter_30_6.color.b, arg_27_1.hightColor1.b, var_30_18)

								iter_30_6.color = Color.New(var_30_19, var_30_20, var_30_21)
							else
								local var_30_22 = Mathf.Lerp(iter_30_6.color.r, 1, var_30_18)

								iter_30_6.color = Color.New(var_30_22, var_30_22, var_30_22)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.actorSpriteComps10094 then
				for iter_30_7, iter_30_8 in pairs(arg_27_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_30_8 then
						if arg_27_1.isInRecall_ then
							iter_30_8.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_30_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10094 = nil
			end

			local var_30_23 = 0
			local var_30_24 = 0.425

			if var_30_23 < arg_27_1.time_ and arg_27_1.time_ <= var_30_23 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_25 = arg_27_1:FormatText(StoryNameCfg[259].name)

				arg_27_1.leftNameTxt_.text = var_30_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_26 = arg_27_1:GetWordFromCfg(413071006)
				local var_30_27 = arg_27_1:FormatText(var_30_26.content)

				arg_27_1.text_.text = var_30_27

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_28 = 17
				local var_30_29 = utf8.len(var_30_27)
				local var_30_30 = var_30_28 <= 0 and var_30_24 or var_30_24 * (var_30_29 / var_30_28)

				if var_30_30 > 0 and var_30_24 < var_30_30 then
					arg_27_1.talkMaxDuration = var_30_30

					if var_30_30 + var_30_23 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_30 + var_30_23
					end
				end

				arg_27_1.text_.text = var_30_27
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071006", "story_v_out_413071.awb") ~= 0 then
					local var_30_31 = manager.audio:GetVoiceLength("story_v_out_413071", "413071006", "story_v_out_413071.awb") / 1000

					if var_30_31 + var_30_23 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_31 + var_30_23
					end

					if var_30_26.prefab_name ~= "" and arg_27_1.actors_[var_30_26.prefab_name] ~= nil then
						local var_30_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_26.prefab_name].transform, "story_v_out_413071", "413071006", "story_v_out_413071.awb")

						arg_27_1:RecordAudio("413071006", var_30_32)
						arg_27_1:RecordAudio("413071006", var_30_32)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413071", "413071006", "story_v_out_413071.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413071", "413071006", "story_v_out_413071.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_33 = math.max(var_30_24, arg_27_1.talkMaxDuration)

			if var_30_23 <= arg_27_1.time_ and arg_27_1.time_ < var_30_23 + var_30_33 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_23) / var_30_33

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_23 + var_30_33 and arg_27_1.time_ < var_30_23 + var_30_33 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play413071007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413071007
		arg_31_1.duration_ = 6.4

		local var_31_0 = {
			zh = 3.133,
			ja = 6.4
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play413071008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.45

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[259].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(413071007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 18
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071007", "story_v_out_413071.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071007", "story_v_out_413071.awb") / 1000

					if var_34_8 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_413071", "413071007", "story_v_out_413071.awb")

						arg_31_1:RecordAudio("413071007", var_34_9)
						arg_31_1:RecordAudio("413071007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413071", "413071007", "story_v_out_413071.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413071", "413071007", "story_v_out_413071.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_10 and arg_31_1.time_ < var_34_0 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play413071008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413071008
		arg_35_1.duration_ = 4.7

		local var_35_0 = {
			zh = 2.766,
			ja = 4.7
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413071009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10092"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = var_38_0.localPosition
				var_38_0.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 2)

				local var_38_2 = var_38_0.childCount

				for iter_38_0 = 0, var_38_2 - 1 do
					local var_38_3 = var_38_0:GetChild(iter_38_0)

					if var_38_3.name == "split_8" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_1) / var_38_4
				local var_38_6 = Vector3.New(-389.49, -300, -295)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, var_38_6, var_38_5)
			end

			if arg_35_1.time_ >= var_38_1 + var_38_4 and arg_35_1.time_ < var_38_1 + var_38_4 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_38_7 = arg_35_1.actors_["10094"].transform
			local var_38_8 = 0

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.var_.moveOldPos10094 = var_38_7.localPosition
				var_38_7.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10094", 4)

				local var_38_9 = var_38_7.childCount

				for iter_38_1 = 0, var_38_9 - 1 do
					local var_38_10 = var_38_7:GetChild(iter_38_1)

					if var_38_10.name == "split_1" or not string.find(var_38_10.name, "split") then
						var_38_10.gameObject:SetActive(true)
					else
						var_38_10.gameObject:SetActive(false)
					end
				end
			end

			local var_38_11 = 0.001

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_11 then
				local var_38_12 = (arg_35_1.time_ - var_38_8) / var_38_11
				local var_38_13 = Vector3.New(390, -340, -414)

				var_38_7.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10094, var_38_13, var_38_12)
			end

			if arg_35_1.time_ >= var_38_8 + var_38_11 and arg_35_1.time_ < var_38_8 + var_38_11 + arg_38_0 then
				var_38_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_38_14 = arg_35_1.actors_["10092"]
			local var_38_15 = 0

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.actorSpriteComps10092 == nil then
				arg_35_1.var_.actorSpriteComps10092 = var_38_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_16 = 2

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_16 and not isNil(var_38_14) then
				local var_38_17 = (arg_35_1.time_ - var_38_15) / var_38_16

				if arg_35_1.var_.actorSpriteComps10092 then
					for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_38_3 then
							if arg_35_1.isInRecall_ then
								local var_38_18 = Mathf.Lerp(iter_38_3.color.r, arg_35_1.hightColor1.r, var_38_17)
								local var_38_19 = Mathf.Lerp(iter_38_3.color.g, arg_35_1.hightColor1.g, var_38_17)
								local var_38_20 = Mathf.Lerp(iter_38_3.color.b, arg_35_1.hightColor1.b, var_38_17)

								iter_38_3.color = Color.New(var_38_18, var_38_19, var_38_20)
							else
								local var_38_21 = Mathf.Lerp(iter_38_3.color.r, 1, var_38_17)

								iter_38_3.color = Color.New(var_38_21, var_38_21, var_38_21)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_15 + var_38_16 and arg_35_1.time_ < var_38_15 + var_38_16 + arg_38_0 and not isNil(var_38_14) and arg_35_1.var_.actorSpriteComps10092 then
				for iter_38_4, iter_38_5 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_38_5 then
						if arg_35_1.isInRecall_ then
							iter_38_5.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_38_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps10092 = nil
			end

			local var_38_22 = arg_35_1.actors_["10094"]
			local var_38_23 = 0

			if var_38_23 < arg_35_1.time_ and arg_35_1.time_ <= var_38_23 + arg_38_0 and not isNil(var_38_22) and arg_35_1.var_.actorSpriteComps10094 == nil then
				arg_35_1.var_.actorSpriteComps10094 = var_38_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_24 = 2

			if var_38_23 <= arg_35_1.time_ and arg_35_1.time_ < var_38_23 + var_38_24 and not isNil(var_38_22) then
				local var_38_25 = (arg_35_1.time_ - var_38_23) / var_38_24

				if arg_35_1.var_.actorSpriteComps10094 then
					for iter_38_6, iter_38_7 in pairs(arg_35_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_38_7 then
							if arg_35_1.isInRecall_ then
								local var_38_26 = Mathf.Lerp(iter_38_7.color.r, arg_35_1.hightColor2.r, var_38_25)
								local var_38_27 = Mathf.Lerp(iter_38_7.color.g, arg_35_1.hightColor2.g, var_38_25)
								local var_38_28 = Mathf.Lerp(iter_38_7.color.b, arg_35_1.hightColor2.b, var_38_25)

								iter_38_7.color = Color.New(var_38_26, var_38_27, var_38_28)
							else
								local var_38_29 = Mathf.Lerp(iter_38_7.color.r, 0.5, var_38_25)

								iter_38_7.color = Color.New(var_38_29, var_38_29, var_38_29)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_23 + var_38_24 and arg_35_1.time_ < var_38_23 + var_38_24 + arg_38_0 and not isNil(var_38_22) and arg_35_1.var_.actorSpriteComps10094 then
				for iter_38_8, iter_38_9 in pairs(arg_35_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_38_9 then
						if arg_35_1.isInRecall_ then
							iter_38_9.color = arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_38_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps10094 = nil
			end

			local var_38_30 = 0
			local var_38_31 = 0.4

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_32 = arg_35_1:FormatText(StoryNameCfg[996].name)

				arg_35_1.leftNameTxt_.text = var_38_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_33 = arg_35_1:GetWordFromCfg(413071008)
				local var_38_34 = arg_35_1:FormatText(var_38_33.content)

				arg_35_1.text_.text = var_38_34

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_35 = 16
				local var_38_36 = utf8.len(var_38_34)
				local var_38_37 = var_38_35 <= 0 and var_38_31 or var_38_31 * (var_38_36 / var_38_35)

				if var_38_37 > 0 and var_38_31 < var_38_37 then
					arg_35_1.talkMaxDuration = var_38_37

					if var_38_37 + var_38_30 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_37 + var_38_30
					end
				end

				arg_35_1.text_.text = var_38_34
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071008", "story_v_out_413071.awb") ~= 0 then
					local var_38_38 = manager.audio:GetVoiceLength("story_v_out_413071", "413071008", "story_v_out_413071.awb") / 1000

					if var_38_38 + var_38_30 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_38 + var_38_30
					end

					if var_38_33.prefab_name ~= "" and arg_35_1.actors_[var_38_33.prefab_name] ~= nil then
						local var_38_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_33.prefab_name].transform, "story_v_out_413071", "413071008", "story_v_out_413071.awb")

						arg_35_1:RecordAudio("413071008", var_38_39)
						arg_35_1:RecordAudio("413071008", var_38_39)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413071", "413071008", "story_v_out_413071.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413071", "413071008", "story_v_out_413071.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_40 = math.max(var_38_31, arg_35_1.talkMaxDuration)

			if var_38_30 <= arg_35_1.time_ and arg_35_1.time_ < var_38_30 + var_38_40 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_30) / var_38_40

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_30 + var_38_40 and arg_35_1.time_ < var_38_30 + var_38_40 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play413071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413071009
		arg_39_1.duration_ = 8.9

		local var_39_0 = {
			zh = 4.7,
			ja = 8.9
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10092"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos10092 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10092", 2)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_8" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(-389.49, -300, -295)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10092, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_42_7 = 0
			local var_42_8 = 0.675

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_9 = arg_39_1:FormatText(StoryNameCfg[996].name)

				arg_39_1.leftNameTxt_.text = var_42_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(413071009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_12 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071009", "story_v_out_413071.awb") ~= 0 then
					local var_42_15 = manager.audio:GetVoiceLength("story_v_out_413071", "413071009", "story_v_out_413071.awb") / 1000

					if var_42_15 + var_42_7 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_7
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_413071", "413071009", "story_v_out_413071.awb")

						arg_39_1:RecordAudio("413071009", var_42_16)
						arg_39_1:RecordAudio("413071009", var_42_16)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413071", "413071009", "story_v_out_413071.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413071", "413071009", "story_v_out_413071.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_17 = math.max(var_42_8, arg_39_1.talkMaxDuration)

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_17 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_7) / var_42_17

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_7 + var_42_17 and arg_39_1.time_ < var_42_7 + var_42_17 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413071010
		arg_43_1.duration_ = 5.17

		local var_43_0 = {
			zh = 3.8,
			ja = 5.166
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10094"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10094 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10094", 4)

				local var_46_2 = var_46_0.childCount

				for iter_46_0 = 0, var_46_2 - 1 do
					local var_46_3 = var_46_0:GetChild(iter_46_0)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_4 then
				local var_46_5 = (arg_43_1.time_ - var_46_1) / var_46_4
				local var_46_6 = Vector3.New(390, -340, -414)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10094, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_46_7 = arg_43_1.actors_["10092"]
			local var_46_8 = 0

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10092 == nil then
				arg_43_1.var_.actorSpriteComps10092 = var_46_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 2

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 and not isNil(var_46_7) then
				local var_46_10 = (arg_43_1.time_ - var_46_8) / var_46_9

				if arg_43_1.var_.actorSpriteComps10092 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_46_2 then
							if arg_43_1.isInRecall_ then
								local var_46_11 = Mathf.Lerp(iter_46_2.color.r, arg_43_1.hightColor2.r, var_46_10)
								local var_46_12 = Mathf.Lerp(iter_46_2.color.g, arg_43_1.hightColor2.g, var_46_10)
								local var_46_13 = Mathf.Lerp(iter_46_2.color.b, arg_43_1.hightColor2.b, var_46_10)

								iter_46_2.color = Color.New(var_46_11, var_46_12, var_46_13)
							else
								local var_46_14 = Mathf.Lerp(iter_46_2.color.r, 0.5, var_46_10)

								iter_46_2.color = Color.New(var_46_14, var_46_14, var_46_14)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10092 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_46_4 then
						if arg_43_1.isInRecall_ then
							iter_46_4.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10092 = nil
			end

			local var_46_15 = arg_43_1.actors_["10094"]
			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.actorSpriteComps10094 == nil then
				arg_43_1.var_.actorSpriteComps10094 = var_46_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_17 = 2

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 and not isNil(var_46_15) then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17

				if arg_43_1.var_.actorSpriteComps10094 then
					for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_46_6 then
							if arg_43_1.isInRecall_ then
								local var_46_19 = Mathf.Lerp(iter_46_6.color.r, arg_43_1.hightColor1.r, var_46_18)
								local var_46_20 = Mathf.Lerp(iter_46_6.color.g, arg_43_1.hightColor1.g, var_46_18)
								local var_46_21 = Mathf.Lerp(iter_46_6.color.b, arg_43_1.hightColor1.b, var_46_18)

								iter_46_6.color = Color.New(var_46_19, var_46_20, var_46_21)
							else
								local var_46_22 = Mathf.Lerp(iter_46_6.color.r, 1, var_46_18)

								iter_46_6.color = Color.New(var_46_22, var_46_22, var_46_22)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.actorSpriteComps10094 then
				for iter_46_7, iter_46_8 in pairs(arg_43_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_46_8 then
						if arg_43_1.isInRecall_ then
							iter_46_8.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10094 = nil
			end

			local var_46_23 = 0
			local var_46_24 = 0.5

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_25 = arg_43_1:FormatText(StoryNameCfg[259].name)

				arg_43_1.leftNameTxt_.text = var_46_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_26 = arg_43_1:GetWordFromCfg(413071010)
				local var_46_27 = arg_43_1:FormatText(var_46_26.content)

				arg_43_1.text_.text = var_46_27

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_28 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071010", "story_v_out_413071.awb") ~= 0 then
					local var_46_31 = manager.audio:GetVoiceLength("story_v_out_413071", "413071010", "story_v_out_413071.awb") / 1000

					if var_46_31 + var_46_23 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_31 + var_46_23
					end

					if var_46_26.prefab_name ~= "" and arg_43_1.actors_[var_46_26.prefab_name] ~= nil then
						local var_46_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_26.prefab_name].transform, "story_v_out_413071", "413071010", "story_v_out_413071.awb")

						arg_43_1:RecordAudio("413071010", var_46_32)
						arg_43_1:RecordAudio("413071010", var_46_32)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413071", "413071010", "story_v_out_413071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413071", "413071010", "story_v_out_413071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_33 = math.max(var_46_24, arg_43_1.talkMaxDuration)

			if var_46_23 <= arg_43_1.time_ and arg_43_1.time_ < var_46_23 + var_46_33 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_23) / var_46_33

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_23 + var_46_33 and arg_43_1.time_ < var_46_23 + var_46_33 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413071011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413071011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413071012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10092"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10092 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10092", 7)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -2000, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10092, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_7 = arg_47_1.actors_["10094"].transform
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.var_.moveOldPos10094 = var_50_7.localPosition
				var_50_7.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10094", 7)

				local var_50_9 = var_50_7.childCount

				for iter_50_1 = 0, var_50_9 - 1 do
					local var_50_10 = var_50_7:GetChild(iter_50_1)

					if var_50_10.name == "" or not string.find(var_50_10.name, "split") then
						var_50_10.gameObject:SetActive(true)
					else
						var_50_10.gameObject:SetActive(false)
					end
				end
			end

			local var_50_11 = 0.001

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_11 then
				local var_50_12 = (arg_47_1.time_ - var_50_8) / var_50_11
				local var_50_13 = Vector3.New(0, -2000, 0)

				var_50_7.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10094, var_50_13, var_50_12)
			end

			if arg_47_1.time_ >= var_50_8 + var_50_11 and arg_47_1.time_ < var_50_8 + var_50_11 + arg_50_0 then
				var_50_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_14 = 0.133333333333333
			local var_50_15 = 1

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				local var_50_16 = "play"
				local var_50_17 = "effect"

				arg_47_1:AudioAction(var_50_16, var_50_17, "se_story_134_01", "se_story_134_01_engine", "")
			end

			local var_50_18 = 0

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			local var_50_19 = 1.56666666666667

			if arg_47_1.time_ >= var_50_18 + var_50_19 and arg_47_1.time_ < var_50_18 + var_50_19 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_20 = 0
			local var_50_21 = 1.75

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_22 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_22:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_23 = arg_47_1:GetWordFromCfg(413071011)
				local var_50_24 = arg_47_1:FormatText(var_50_23.content)

				arg_47_1.text_.text = var_50_24

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_25 = 70
				local var_50_26 = utf8.len(var_50_24)
				local var_50_27 = var_50_25 <= 0 and var_50_21 or var_50_21 * (var_50_26 / var_50_25)

				if var_50_27 > 0 and var_50_21 < var_50_27 then
					arg_47_1.talkMaxDuration = var_50_27
					var_50_20 = var_50_20 + 0.3

					if var_50_27 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_27 + var_50_20
					end
				end

				arg_47_1.text_.text = var_50_24
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_28 = var_50_20 + 0.3
			local var_50_29 = math.max(var_50_21, arg_47_1.talkMaxDuration)

			if var_50_28 <= arg_47_1.time_ and arg_47_1.time_ < var_50_28 + var_50_29 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_28) / var_50_29

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_28 + var_50_29 and arg_47_1.time_ < var_50_28 + var_50_29 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413071012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413071012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play413071013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.15

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_2 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_2:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(413071012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 46
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7
					var_56_0 = var_56_0 + 0.3

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = var_56_0 + 0.3
			local var_56_9 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413071013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413071013
		arg_59_1.duration_ = 4.3

		local var_59_0 = {
			zh = 4.2,
			ja = 4.3
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play413071014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10092"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10092 = var_62_0.localPosition
				var_62_0.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10092", 3)

				local var_62_2 = var_62_0.childCount

				for iter_62_0 = 0, var_62_2 - 1 do
					local var_62_3 = var_62_0:GetChild(iter_62_0)

					if var_62_3.name == "split_8" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_4 then
				local var_62_5 = (arg_59_1.time_ - var_62_1) / var_62_4
				local var_62_6 = Vector3.New(0, -300, -295)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10092, var_62_6, var_62_5)
			end

			if arg_59_1.time_ >= var_62_1 + var_62_4 and arg_59_1.time_ < var_62_1 + var_62_4 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_62_7 = arg_59_1.actors_["10092"]
			local var_62_8 = 0

			if var_62_8 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.actorSpriteComps10092 == nil then
				arg_59_1.var_.actorSpriteComps10092 = var_62_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_9 = 2

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_9 and not isNil(var_62_7) then
				local var_62_10 = (arg_59_1.time_ - var_62_8) / var_62_9

				if arg_59_1.var_.actorSpriteComps10092 then
					for iter_62_1, iter_62_2 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_62_2 then
							if arg_59_1.isInRecall_ then
								local var_62_11 = Mathf.Lerp(iter_62_2.color.r, arg_59_1.hightColor1.r, var_62_10)
								local var_62_12 = Mathf.Lerp(iter_62_2.color.g, arg_59_1.hightColor1.g, var_62_10)
								local var_62_13 = Mathf.Lerp(iter_62_2.color.b, arg_59_1.hightColor1.b, var_62_10)

								iter_62_2.color = Color.New(var_62_11, var_62_12, var_62_13)
							else
								local var_62_14 = Mathf.Lerp(iter_62_2.color.r, 1, var_62_10)

								iter_62_2.color = Color.New(var_62_14, var_62_14, var_62_14)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= var_62_8 + var_62_9 and arg_59_1.time_ < var_62_8 + var_62_9 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.actorSpriteComps10092 then
				for iter_62_3, iter_62_4 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_62_4 then
						if arg_59_1.isInRecall_ then
							iter_62_4.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps10092 = nil
			end

			local var_62_15 = 0
			local var_62_16 = 0.575

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[996].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(413071013)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 23
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071013", "story_v_out_413071.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071013", "story_v_out_413071.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_413071", "413071013", "story_v_out_413071.awb")

						arg_59_1:RecordAudio("413071013", var_62_24)
						arg_59_1:RecordAudio("413071013", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413071", "413071013", "story_v_out_413071.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413071", "413071013", "story_v_out_413071.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play413071014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413071014
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413071015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 2

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				local var_66_1 = manager.ui.mainCamera.transform.localPosition
				local var_66_2 = Vector3.New(0, 0, 10) + Vector3.New(var_66_1.x, var_66_1.y, 0)
				local var_66_3 = arg_63_1.bgs_.F10g

				var_66_3.transform.localPosition = var_66_2
				var_66_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_4 = var_66_3:GetComponent("SpriteRenderer")

				if var_66_4 and var_66_4.sprite then
					local var_66_5 = (var_66_3.transform.localPosition - var_66_1).z
					local var_66_6 = manager.ui.mainCameraCom_
					local var_66_7 = 2 * var_66_5 * Mathf.Tan(var_66_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_8 = var_66_7 * var_66_6.aspect
					local var_66_9 = var_66_4.sprite.bounds.size.x
					local var_66_10 = var_66_4.sprite.bounds.size.y
					local var_66_11 = var_66_8 / var_66_9
					local var_66_12 = var_66_7 / var_66_10
					local var_66_13 = var_66_12 < var_66_11 and var_66_11 or var_66_12

					var_66_3.transform.localScale = Vector3.New(var_66_13, var_66_13, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "F10g" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_14 = 4

			if var_66_14 < arg_63_1.time_ and arg_63_1.time_ <= var_66_14 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			local var_66_15 = 0.3

			if arg_63_1.time_ >= var_66_14 + var_66_15 and arg_63_1.time_ < var_66_14 + var_66_15 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_17 = 2

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Color.New(0, 0, 0)

				var_66_19.a = Mathf.Lerp(0, 1, var_66_18)
				arg_63_1.mask_.color = var_66_19
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				local var_66_20 = Color.New(0, 0, 0)

				var_66_20.a = 1
				arg_63_1.mask_.color = var_66_20
			end

			local var_66_21 = 2

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_22 = 2

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Color.New(0, 0, 0)

				var_66_24.a = Mathf.Lerp(1, 0, var_66_23)
				arg_63_1.mask_.color = var_66_24
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				local var_66_25 = Color.New(0, 0, 0)
				local var_66_26 = 0

				arg_63_1.mask_.enabled = false
				var_66_25.a = var_66_26
				arg_63_1.mask_.color = var_66_25
			end

			local var_66_27 = arg_63_1.actors_["10092"].transform
			local var_66_28 = 1.966

			if var_66_28 < arg_63_1.time_ and arg_63_1.time_ <= var_66_28 + arg_66_0 then
				arg_63_1.var_.moveOldPos10092 = var_66_27.localPosition
				var_66_27.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10092", 0)

				local var_66_29 = var_66_27.childCount

				for iter_66_2 = 0, var_66_29 - 1 do
					local var_66_30 = var_66_27:GetChild(iter_66_2)

					if var_66_30.name == "" or not string.find(var_66_30.name, "split") then
						var_66_30.gameObject:SetActive(true)
					else
						var_66_30.gameObject:SetActive(false)
					end
				end
			end

			local var_66_31 = 0.001

			if var_66_28 <= arg_63_1.time_ and arg_63_1.time_ < var_66_28 + var_66_31 then
				local var_66_32 = (arg_63_1.time_ - var_66_28) / var_66_31
				local var_66_33 = Vector3.New(0, -5000, 0)

				var_66_27.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10092, var_66_33, var_66_32)
			end

			if arg_63_1.time_ >= var_66_28 + var_66_31 and arg_63_1.time_ < var_66_28 + var_66_31 + arg_66_0 then
				var_66_27.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_66_34 = arg_63_1.actors_["10094"].transform
			local var_66_35 = 1.966

			if var_66_35 < arg_63_1.time_ and arg_63_1.time_ <= var_66_35 + arg_66_0 then
				arg_63_1.var_.moveOldPos10094 = var_66_34.localPosition
				var_66_34.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10094", 7)

				local var_66_36 = var_66_34.childCount

				for iter_66_3 = 0, var_66_36 - 1 do
					local var_66_37 = var_66_34:GetChild(iter_66_3)

					if var_66_37.name == "" or not string.find(var_66_37.name, "split") then
						var_66_37.gameObject:SetActive(true)
					else
						var_66_37.gameObject:SetActive(false)
					end
				end
			end

			local var_66_38 = 0.001

			if var_66_35 <= arg_63_1.time_ and arg_63_1.time_ < var_66_35 + var_66_38 then
				local var_66_39 = (arg_63_1.time_ - var_66_35) / var_66_38
				local var_66_40 = Vector3.New(0, -2000, 0)

				var_66_34.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10094, var_66_40, var_66_39)
			end

			if arg_63_1.time_ >= var_66_35 + var_66_38 and arg_63_1.time_ < var_66_35 + var_66_38 + arg_66_0 then
				var_66_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_41 = arg_63_1.actors_["10092"]
			local var_66_42 = 1.966

			if var_66_42 < arg_63_1.time_ and arg_63_1.time_ <= var_66_42 + arg_66_0 and not isNil(var_66_41) and arg_63_1.var_.actorSpriteComps10092 == nil then
				arg_63_1.var_.actorSpriteComps10092 = var_66_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_43 = 0.034

			if var_66_42 <= arg_63_1.time_ and arg_63_1.time_ < var_66_42 + var_66_43 and not isNil(var_66_41) then
				local var_66_44 = (arg_63_1.time_ - var_66_42) / var_66_43

				if arg_63_1.var_.actorSpriteComps10092 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								local var_66_45 = Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, var_66_44)
								local var_66_46 = Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, var_66_44)
								local var_66_47 = Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, var_66_44)

								iter_66_5.color = Color.New(var_66_45, var_66_46, var_66_47)
							else
								local var_66_48 = Mathf.Lerp(iter_66_5.color.r, 0.5, var_66_44)

								iter_66_5.color = Color.New(var_66_48, var_66_48, var_66_48)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_42 + var_66_43 and arg_63_1.time_ < var_66_42 + var_66_43 + arg_66_0 and not isNil(var_66_41) and arg_63_1.var_.actorSpriteComps10092 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_66_7 then
						if arg_63_1.isInRecall_ then
							iter_66_7.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10092 = nil
			end

			local var_66_49 = arg_63_1.actors_["10094"]
			local var_66_50 = 3.8

			if var_66_50 < arg_63_1.time_ and arg_63_1.time_ <= var_66_50 + arg_66_0 and not isNil(var_66_49) and arg_63_1.var_.actorSpriteComps10094 == nil then
				arg_63_1.var_.actorSpriteComps10094 = var_66_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_51 = 0.2

			if var_66_50 <= arg_63_1.time_ and arg_63_1.time_ < var_66_50 + var_66_51 and not isNil(var_66_49) then
				local var_66_52 = (arg_63_1.time_ - var_66_50) / var_66_51

				if arg_63_1.var_.actorSpriteComps10094 then
					for iter_66_8, iter_66_9 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_66_9 then
							if arg_63_1.isInRecall_ then
								local var_66_53 = Mathf.Lerp(iter_66_9.color.r, arg_63_1.hightColor2.r, var_66_52)
								local var_66_54 = Mathf.Lerp(iter_66_9.color.g, arg_63_1.hightColor2.g, var_66_52)
								local var_66_55 = Mathf.Lerp(iter_66_9.color.b, arg_63_1.hightColor2.b, var_66_52)

								iter_66_9.color = Color.New(var_66_53, var_66_54, var_66_55)
							else
								local var_66_56 = Mathf.Lerp(iter_66_9.color.r, 0.5, var_66_52)

								iter_66_9.color = Color.New(var_66_56, var_66_56, var_66_56)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_50 + var_66_51 and arg_63_1.time_ < var_66_50 + var_66_51 + arg_66_0 and not isNil(var_66_49) and arg_63_1.var_.actorSpriteComps10094 then
				for iter_66_10, iter_66_11 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_66_11 then
						if arg_63_1.isInRecall_ then
							iter_66_11.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10094 = nil
			end

			local var_66_57 = 0.366666666666667
			local var_66_58 = 1

			if var_66_57 < arg_63_1.time_ and arg_63_1.time_ <= var_66_57 + arg_66_0 then
				local var_66_59 = "play"
				local var_66_60 = "effect"

				arg_63_1:AudioAction(var_66_59, var_66_60, "se_story_122_03", "se_story_122_03_arrow1", "")
			end

			local var_66_61 = 2.8
			local var_66_62 = 1

			if var_66_61 < arg_63_1.time_ and arg_63_1.time_ <= var_66_61 + arg_66_0 then
				local var_66_63 = "play"
				local var_66_64 = "effect"

				arg_63_1:AudioAction(var_66_63, var_66_64, "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_65 = 4
			local var_66_66 = 1.3

			if var_66_65 < arg_63_1.time_ and arg_63_1.time_ <= var_66_65 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_67 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_67:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_68 = arg_63_1:GetWordFromCfg(413071014)
				local var_66_69 = arg_63_1:FormatText(var_66_68.content)

				arg_63_1.text_.text = var_66_69

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_70 = 52
				local var_66_71 = utf8.len(var_66_69)
				local var_66_72 = var_66_70 <= 0 and var_66_66 or var_66_66 * (var_66_71 / var_66_70)

				if var_66_72 > 0 and var_66_66 < var_66_72 then
					arg_63_1.talkMaxDuration = var_66_72
					var_66_65 = var_66_65 + 0.3

					if var_66_72 + var_66_65 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_72 + var_66_65
					end
				end

				arg_63_1.text_.text = var_66_69
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_73 = var_66_65 + 0.3
			local var_66_74 = math.max(var_66_66, arg_63_1.talkMaxDuration)

			if var_66_73 <= arg_63_1.time_ and arg_63_1.time_ < var_66_73 + var_66_74 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_73) / var_66_74

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_73 + var_66_74 and arg_63_1.time_ < var_66_73 + var_66_74 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play413071015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413071015
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413071016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "10093"

			if arg_69_1.actors_[var_72_0] == nil then
				local var_72_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_72_1) then
					local var_72_2 = Object.Instantiate(var_72_1, arg_69_1.canvasGo_.transform)

					var_72_2.transform:SetSiblingIndex(1)

					var_72_2.name = var_72_0
					var_72_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_69_1.actors_[var_72_0] = var_72_2

					local var_72_3 = var_72_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_69_1.isInRecall_ then
						for iter_72_0, iter_72_1 in ipairs(var_72_3) do
							iter_72_1.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_72_4 = arg_69_1.actors_["10093"].transform
			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.var_.moveOldPos10093 = var_72_4.localPosition
				var_72_4.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10093", 3)

				local var_72_6 = var_72_4.childCount

				for iter_72_2 = 0, var_72_6 - 1 do
					local var_72_7 = var_72_4:GetChild(iter_72_2)

					if var_72_7.name == "split_5" or not string.find(var_72_7.name, "split") then
						var_72_7.gameObject:SetActive(true)
					else
						var_72_7.gameObject:SetActive(false)
					end
				end
			end

			local var_72_8 = 0.001

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_8 then
				local var_72_9 = (arg_69_1.time_ - var_72_5) / var_72_8
				local var_72_10 = Vector3.New(0, -345, -245)

				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10093, var_72_10, var_72_9)
			end

			if arg_69_1.time_ >= var_72_5 + var_72_8 and arg_69_1.time_ < var_72_5 + var_72_8 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0, -345, -245)
			end

			local var_72_11 = arg_69_1.actors_["10093"]
			local var_72_12 = 0

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10093 == nil then
				arg_69_1.var_.actorSpriteComps10093 = var_72_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_13 = 2

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_13 and not isNil(var_72_11) then
				local var_72_14 = (arg_69_1.time_ - var_72_12) / var_72_13

				if arg_69_1.var_.actorSpriteComps10093 then
					for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_72_4 then
							if arg_69_1.isInRecall_ then
								local var_72_15 = Mathf.Lerp(iter_72_4.color.r, arg_69_1.hightColor1.r, var_72_14)
								local var_72_16 = Mathf.Lerp(iter_72_4.color.g, arg_69_1.hightColor1.g, var_72_14)
								local var_72_17 = Mathf.Lerp(iter_72_4.color.b, arg_69_1.hightColor1.b, var_72_14)

								iter_72_4.color = Color.New(var_72_15, var_72_16, var_72_17)
							else
								local var_72_18 = Mathf.Lerp(iter_72_4.color.r, 1, var_72_14)

								iter_72_4.color = Color.New(var_72_18, var_72_18, var_72_18)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_12 + var_72_13 and arg_69_1.time_ < var_72_12 + var_72_13 + arg_72_0 and not isNil(var_72_11) and arg_69_1.var_.actorSpriteComps10093 then
				for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_72_6 then
						if arg_69_1.isInRecall_ then
							iter_72_6.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10093 = nil
			end

			local var_72_19 = arg_69_1.actors_["10093"].transform
			local var_72_20 = 0

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.var_.shakeOldPos10093 = var_72_19.localPosition
			end

			local var_72_21 = 0.6

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_21 then
				local var_72_22 = (arg_69_1.time_ - var_72_20) / 0.066
				local var_72_23, var_72_24 = math.modf(var_72_22)

				var_72_19.localPosition = Vector3.New(var_72_24 * 0.13, var_72_24 * 0.13, var_72_24 * 0.13) + arg_69_1.var_.shakeOldPos10093
			end

			if arg_69_1.time_ >= var_72_20 + var_72_21 and arg_69_1.time_ < var_72_20 + var_72_21 + arg_72_0 then
				var_72_19.localPosition = arg_69_1.var_.shakeOldPos10093
			end

			local var_72_25 = 0

			if var_72_25 < arg_69_1.time_ and arg_69_1.time_ <= var_72_25 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_26 = 0.6

			if arg_69_1.time_ >= var_72_25 + var_72_26 and arg_69_1.time_ < var_72_25 + var_72_26 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_27 = 0
			local var_72_28 = 0.2

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_29 = arg_69_1:FormatText(StoryNameCfg[28].name)

				arg_69_1.leftNameTxt_.text = var_72_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_30 = arg_69_1:GetWordFromCfg(413071015)
				local var_72_31 = arg_69_1:FormatText(var_72_30.content)

				arg_69_1.text_.text = var_72_31

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_32 = 8
				local var_72_33 = utf8.len(var_72_31)
				local var_72_34 = var_72_32 <= 0 and var_72_28 or var_72_28 * (var_72_33 / var_72_32)

				if var_72_34 > 0 and var_72_28 < var_72_34 then
					arg_69_1.talkMaxDuration = var_72_34

					if var_72_34 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_34 + var_72_27
					end
				end

				arg_69_1.text_.text = var_72_31
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071015", "story_v_out_413071.awb") ~= 0 then
					local var_72_35 = manager.audio:GetVoiceLength("story_v_out_413071", "413071015", "story_v_out_413071.awb") / 1000

					if var_72_35 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_35 + var_72_27
					end

					if var_72_30.prefab_name ~= "" and arg_69_1.actors_[var_72_30.prefab_name] ~= nil then
						local var_72_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_30.prefab_name].transform, "story_v_out_413071", "413071015", "story_v_out_413071.awb")

						arg_69_1:RecordAudio("413071015", var_72_36)
						arg_69_1:RecordAudio("413071015", var_72_36)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413071", "413071015", "story_v_out_413071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413071", "413071015", "story_v_out_413071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_37 = math.max(var_72_28, arg_69_1.talkMaxDuration)

			if var_72_27 <= arg_69_1.time_ and arg_69_1.time_ < var_72_27 + var_72_37 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_27) / var_72_37

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_27 + var_72_37 and arg_69_1.time_ < var_72_27 + var_72_37 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413071016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413071016
		arg_73_1.duration_ = 2.5

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 2.5
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
				arg_73_0:Play413071017(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.8

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				local var_76_2 = "play"
				local var_76_3 = "effect"

				arg_73_1:AudioAction(var_76_2, var_76_3, "se_story_10", "se_story_10_sword", "")
			end

			local var_76_4 = arg_73_1.actors_["10093"]
			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.actorSpriteComps10093 == nil then
				arg_73_1.var_.actorSpriteComps10093 = var_76_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_6 = 2

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 and not isNil(var_76_4) then
				local var_76_7 = (arg_73_1.time_ - var_76_5) / var_76_6

				if arg_73_1.var_.actorSpriteComps10093 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_8 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_7)
								local var_76_9 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_7)
								local var_76_10 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_7)

								iter_76_1.color = Color.New(var_76_8, var_76_9, var_76_10)
							else
								local var_76_11 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_7)

								iter_76_1.color = Color.New(var_76_11, var_76_11, var_76_11)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.actorSpriteComps10093 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10093 = nil
			end

			local var_76_12 = 0
			local var_76_13 = 0.225

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_14 = arg_73_1:FormatText(StoryNameCfg[996].name)

				arg_73_1.leftNameTxt_.text = var_76_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_15 = arg_73_1:GetWordFromCfg(413071016)
				local var_76_16 = arg_73_1:FormatText(var_76_15.content)

				arg_73_1.text_.text = var_76_16

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_17 = 9
				local var_76_18 = utf8.len(var_76_16)
				local var_76_19 = var_76_17 <= 0 and var_76_13 or var_76_13 * (var_76_18 / var_76_17)

				if var_76_19 > 0 and var_76_13 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_12
					end
				end

				arg_73_1.text_.text = var_76_16
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071016", "story_v_out_413071.awb") ~= 0 then
					local var_76_20 = manager.audio:GetVoiceLength("story_v_out_413071", "413071016", "story_v_out_413071.awb") / 1000

					if var_76_20 + var_76_12 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_20 + var_76_12
					end

					if var_76_15.prefab_name ~= "" and arg_73_1.actors_[var_76_15.prefab_name] ~= nil then
						local var_76_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_15.prefab_name].transform, "story_v_out_413071", "413071016", "story_v_out_413071.awb")

						arg_73_1:RecordAudio("413071016", var_76_21)
						arg_73_1:RecordAudio("413071016", var_76_21)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413071", "413071016", "story_v_out_413071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413071", "413071016", "story_v_out_413071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_13, arg_73_1.talkMaxDuration)

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_12) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_12 + var_76_22 and arg_73_1.time_ < var_76_12 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413071017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413071017
		arg_77_1.duration_ = 5.93

		local var_77_0 = {
			zh = 5.933,
			ja = 4.633
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
				arg_77_0:Play413071018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10093"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10093 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10093", 3)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_6" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(0, -345, -245)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10093, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_80_7 = arg_77_1.actors_["10093"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_15 = 0
			local var_80_16 = 0.5

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[28].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(413071017)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 20
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071017", "story_v_out_413071.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071017", "story_v_out_413071.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_413071", "413071017", "story_v_out_413071.awb")

						arg_77_1:RecordAudio("413071017", var_80_24)
						arg_77_1:RecordAudio("413071017", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413071", "413071017", "story_v_out_413071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413071", "413071017", "story_v_out_413071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413071018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413071018
		arg_81_1.duration_ = 3.9

		local var_81_0 = {
			zh = 3.733,
			ja = 3.9
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
				arg_81_0:Play413071019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.45

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[28].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(413071018)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 18
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071018", "story_v_out_413071.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071018", "story_v_out_413071.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_413071", "413071018", "story_v_out_413071.awb")

						arg_81_1:RecordAudio("413071018", var_84_9)
						arg_81_1:RecordAudio("413071018", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413071", "413071018", "story_v_out_413071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413071", "413071018", "story_v_out_413071.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413071019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413071019
		arg_85_1.duration_ = 5.57

		local var_85_0 = {
			zh = 4.166,
			ja = 5.566
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
				arg_85_0:Play413071020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10093"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10093 == nil then
				arg_85_1.var_.actorSpriteComps10093 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10093 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10093 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10093 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.575

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_11 = arg_85_1:GetWordFromCfg(413071019)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 23
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071019", "story_v_out_413071.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071019", "story_v_out_413071.awb") / 1000

					if var_88_16 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_8
					end

					if var_88_11.prefab_name ~= "" and arg_85_1.actors_[var_88_11.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_11.prefab_name].transform, "story_v_out_413071", "413071019", "story_v_out_413071.awb")

						arg_85_1:RecordAudio("413071019", var_88_17)
						arg_85_1:RecordAudio("413071019", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413071", "413071019", "story_v_out_413071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413071", "413071019", "story_v_out_413071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_18 and arg_85_1.time_ < var_88_8 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413071020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413071020
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play413071021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10093"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10093 == nil then
				arg_89_1.var_.actorSpriteComps10093 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10093 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10093 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10093 = nil
			end

			local var_92_8 = arg_89_1.actors_["10093"].transform
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 3)

				local var_92_10 = var_92_8.childCount

				for iter_92_4 = 0, var_92_10 - 1 do
					local var_92_11 = var_92_8:GetChild(iter_92_4)

					if var_92_11.name == "split_1" or not string.find(var_92_11.name, "split") then
						var_92_11.gameObject:SetActive(true)
					else
						var_92_11.gameObject:SetActive(false)
					end
				end
			end

			local var_92_12 = 0.001

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_12 then
				local var_92_13 = (arg_89_1.time_ - var_92_9) / var_92_12
				local var_92_14 = Vector3.New(0, -345, -245)

				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, var_92_14, var_92_13)
			end

			if arg_89_1.time_ >= var_92_9 + var_92_12 and arg_89_1.time_ < var_92_9 + var_92_12 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(0, -345, -245)
			end

			local var_92_15 = 0
			local var_92_16 = 0.1

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[28].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(413071020)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 4
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071020", "story_v_out_413071.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071020", "story_v_out_413071.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_413071", "413071020", "story_v_out_413071.awb")

						arg_89_1:RecordAudio("413071020", var_92_24)
						arg_89_1:RecordAudio("413071020", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413071", "413071020", "story_v_out_413071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413071", "413071020", "story_v_out_413071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413071021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413071021
		arg_93_1.duration_ = 8.9

		local var_93_0 = {
			zh = 3.766,
			ja = 8.9
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
				arg_93_0:Play413071022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10093"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_8 = 0
			local var_96_9 = 0.475

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_10 = arg_93_1:FormatText(StoryNameCfg[996].name)

				arg_93_1.leftNameTxt_.text = var_96_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_11 = arg_93_1:GetWordFromCfg(413071021)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 19
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_9 or var_96_9 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_9 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071021", "story_v_out_413071.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071021", "story_v_out_413071.awb") / 1000

					if var_96_16 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_8
					end

					if var_96_11.prefab_name ~= "" and arg_93_1.actors_[var_96_11.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_11.prefab_name].transform, "story_v_out_413071", "413071021", "story_v_out_413071.awb")

						arg_93_1:RecordAudio("413071021", var_96_17)
						arg_93_1:RecordAudio("413071021", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413071", "413071021", "story_v_out_413071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413071", "413071021", "story_v_out_413071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_18 and arg_93_1.time_ < var_96_8 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play413071022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413071022
		arg_97_1.duration_ = 8.83

		local var_97_0 = {
			zh = 4.8,
			ja = 8.833
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
				arg_97_0:Play413071023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.675

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[996].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(413071022)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071022", "story_v_out_413071.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071022", "story_v_out_413071.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_413071", "413071022", "story_v_out_413071.awb")

						arg_97_1:RecordAudio("413071022", var_100_9)
						arg_97_1:RecordAudio("413071022", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413071", "413071022", "story_v_out_413071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413071", "413071022", "story_v_out_413071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413071023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413071023
		arg_101_1.duration_ = 2.23

		local var_101_0 = {
			zh = 2,
			ja = 2.233
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
				arg_101_0:Play413071024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10093"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_8 = 0
			local var_104_9 = 0.275

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_10 = arg_101_1:FormatText(StoryNameCfg[28].name)

				arg_101_1.leftNameTxt_.text = var_104_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:GetWordFromCfg(413071023)
				local var_104_12 = arg_101_1:FormatText(var_104_11.content)

				arg_101_1.text_.text = var_104_12

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 11
				local var_104_14 = utf8.len(var_104_12)
				local var_104_15 = var_104_13 <= 0 and var_104_9 or var_104_9 * (var_104_14 / var_104_13)

				if var_104_15 > 0 and var_104_9 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_12
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071023", "story_v_out_413071.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071023", "story_v_out_413071.awb") / 1000

					if var_104_16 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_8
					end

					if var_104_11.prefab_name ~= "" and arg_101_1.actors_[var_104_11.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_11.prefab_name].transform, "story_v_out_413071", "413071023", "story_v_out_413071.awb")

						arg_101_1:RecordAudio("413071023", var_104_17)
						arg_101_1:RecordAudio("413071023", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413071", "413071023", "story_v_out_413071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413071", "413071023", "story_v_out_413071.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_18 and arg_101_1.time_ < var_104_8 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413071024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413071024
		arg_105_1.duration_ = 7.1

		local var_105_0 = {
			zh = 3.166,
			ja = 7.1
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
				arg_105_0:Play413071025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10093"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 0.5, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.425

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[996].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_2")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_11 = arg_105_1:GetWordFromCfg(413071024)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 17
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_9 or var_108_9 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_9 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071024", "story_v_out_413071.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071024", "story_v_out_413071.awb") / 1000

					if var_108_16 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_8
					end

					if var_108_11.prefab_name ~= "" and arg_105_1.actors_[var_108_11.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_11.prefab_name].transform, "story_v_out_413071", "413071024", "story_v_out_413071.awb")

						arg_105_1:RecordAudio("413071024", var_108_17)
						arg_105_1:RecordAudio("413071024", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413071", "413071024", "story_v_out_413071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413071", "413071024", "story_v_out_413071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_18 and arg_105_1.time_ < var_108_8 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play413071025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413071025
		arg_109_1.duration_ = 8.3

		local var_109_0 = {
			zh = 5.766,
			ja = 8.3
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
				arg_109_0:Play413071026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10093"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10093 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10093", 3)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -345, -245)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10093, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_112_7 = arg_109_1.actors_["10093"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10093 == nil then
				arg_109_1.var_.actorSpriteComps10093 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 2

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10093 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10093 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10093 = nil
			end

			local var_112_15 = 0
			local var_112_16 = 0.75

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[28].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(413071025)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 30
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071025", "story_v_out_413071.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071025", "story_v_out_413071.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_413071", "413071025", "story_v_out_413071.awb")

						arg_109_1:RecordAudio("413071025", var_112_24)
						arg_109_1:RecordAudio("413071025", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413071", "413071025", "story_v_out_413071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413071", "413071025", "story_v_out_413071.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413071026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413071026
		arg_113_1.duration_ = 5.5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play413071027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10092"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10092 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10092", 7)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(0, -2000, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10092, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_7 = arg_113_1.actors_["10093"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor2.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor2.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor2.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 0.5, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			local var_116_15 = arg_113_1.actors_["10093"].transform
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_15.localPosition
				var_116_15.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 7)

				local var_116_17 = var_116_15.childCount

				for iter_116_5 = 0, var_116_17 - 1 do
					local var_116_18 = var_116_15:GetChild(iter_116_5)

					if var_116_18.name == "" or not string.find(var_116_18.name, "split") then
						var_116_18.gameObject:SetActive(true)
					else
						var_116_18.gameObject:SetActive(false)
					end
				end
			end

			local var_116_19 = 0.001

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_19 then
				local var_116_20 = (arg_113_1.time_ - var_116_16) / var_116_19
				local var_116_21 = Vector3.New(0, -2000, 0)

				var_116_15.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, var_116_21, var_116_20)
			end

			if arg_113_1.time_ >= var_116_16 + var_116_19 and arg_113_1.time_ < var_116_16 + var_116_19 + arg_116_0 then
				var_116_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_22 = manager.ui.mainCamera.transform
			local var_116_23 = 0.2

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = var_116_22.localPosition
			end

			local var_116_24 = 0.6

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / 0.066
				local var_116_26, var_116_27 = math.modf(var_116_25)

				var_116_22.localPosition = Vector3.New(var_116_27 * 0.13, var_116_27 * 0.13, var_116_27 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 then
				var_116_22.localPosition = arg_113_1.var_.shakeOldPos
			end

			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_29 = 0.5

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_30 = 0.0666666666666667
			local var_116_31 = 1.36666666666667

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 then
				local var_116_32 = "play"
				local var_116_33 = "effect"

				arg_113_1:AudioAction(var_116_32, var_116_33, "se_story_134_01", "se_story_134_01_wave", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_34 = 0.5
			local var_116_35 = 1.125

			if var_116_34 < arg_113_1.time_ and arg_113_1.time_ <= var_116_34 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_36 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_36:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_37 = arg_113_1:GetWordFromCfg(413071026)
				local var_116_38 = arg_113_1:FormatText(var_116_37.content)

				arg_113_1.text_.text = var_116_38

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_39 = 45
				local var_116_40 = utf8.len(var_116_38)
				local var_116_41 = var_116_39 <= 0 and var_116_35 or var_116_35 * (var_116_40 / var_116_39)

				if var_116_41 > 0 and var_116_35 < var_116_41 then
					arg_113_1.talkMaxDuration = var_116_41
					var_116_34 = var_116_34 + 0.3

					if var_116_41 + var_116_34 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_41 + var_116_34
					end
				end

				arg_113_1.text_.text = var_116_38
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_42 = var_116_34 + 0.3
			local var_116_43 = math.max(var_116_35, arg_113_1.talkMaxDuration)

			if var_116_42 <= arg_113_1.time_ and arg_113_1.time_ < var_116_42 + var_116_43 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_42) / var_116_43

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_42 + var_116_43 and arg_113_1.time_ < var_116_42 + var_116_43 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play413071027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413071027
		arg_119_1.duration_ = 2.33

		local var_119_0 = {
			zh = 2.333,
			ja = 2.266
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play413071028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10093"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10093 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10093", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_5" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -345, -245)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10093, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_122_7 = arg_119_1.actors_["10093"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10093 == nil then
				arg_119_1.var_.actorSpriteComps10093 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 2

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10093 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								local var_122_11 = Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, var_122_10)
								local var_122_12 = Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, var_122_10)
								local var_122_13 = Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, var_122_10)

								iter_122_2.color = Color.New(var_122_11, var_122_12, var_122_13)
							else
								local var_122_14 = Mathf.Lerp(iter_122_2.color.r, 1, var_122_10)

								iter_122_2.color = Color.New(var_122_14, var_122_14, var_122_14)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10093 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10093 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 0.175

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[28].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(413071027)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 7
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071027", "story_v_out_413071.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071027", "story_v_out_413071.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_413071", "413071027", "story_v_out_413071.awb")

						arg_119_1:RecordAudio("413071027", var_122_24)
						arg_119_1:RecordAudio("413071027", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413071", "413071027", "story_v_out_413071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413071", "413071027", "story_v_out_413071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
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
	Play413071028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413071028
		arg_123_1.duration_ = 8.2

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413071029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10093"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10093 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10093", 7)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(0, -2000, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10093, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_7 = arg_123_1.actors_["10092"].transform
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.var_.moveOldPos10092 = var_126_7.localPosition
				var_126_7.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10092", 7)

				local var_126_9 = var_126_7.childCount

				for iter_126_1 = 0, var_126_9 - 1 do
					local var_126_10 = var_126_7:GetChild(iter_126_1)

					if var_126_10.name == "" or not string.find(var_126_10.name, "split") then
						var_126_10.gameObject:SetActive(true)
					else
						var_126_10.gameObject:SetActive(false)
					end
				end
			end

			local var_126_11 = 0.001

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_11 then
				local var_126_12 = (arg_123_1.time_ - var_126_8) / var_126_11
				local var_126_13 = Vector3.New(0, -2000, 0)

				var_126_7.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10092, var_126_13, var_126_12)
			end

			if arg_123_1.time_ >= var_126_8 + var_126_11 and arg_123_1.time_ < var_126_8 + var_126_11 + arg_126_0 then
				var_126_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_14 = "SS1305"

			if arg_123_1.bgs_[var_126_14] == nil then
				local var_126_15 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_14)
				var_126_15.name = var_126_14
				var_126_15.transform.parent = arg_123_1.stage_.transform
				var_126_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_14] = var_126_15
			end

			local var_126_16 = 1.33333333333333

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				local var_126_17 = manager.ui.mainCamera.transform.localPosition
				local var_126_18 = Vector3.New(0, 0, 10) + Vector3.New(var_126_17.x, var_126_17.y, 0)
				local var_126_19 = arg_123_1.bgs_.SS1305

				var_126_19.transform.localPosition = var_126_18
				var_126_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_20 = var_126_19:GetComponent("SpriteRenderer")

				if var_126_20 and var_126_20.sprite then
					local var_126_21 = (var_126_19.transform.localPosition - var_126_17).z
					local var_126_22 = manager.ui.mainCameraCom_
					local var_126_23 = 2 * var_126_21 * Mathf.Tan(var_126_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_24 = var_126_23 * var_126_22.aspect
					local var_126_25 = var_126_20.sprite.bounds.size.x
					local var_126_26 = var_126_20.sprite.bounds.size.y
					local var_126_27 = var_126_24 / var_126_25
					local var_126_28 = var_126_23 / var_126_26
					local var_126_29 = var_126_28 < var_126_27 and var_126_27 or var_126_28

					var_126_19.transform.localScale = Vector3.New(var_126_29, var_126_29, 0)
				end

				for iter_126_2, iter_126_3 in pairs(arg_123_1.bgs_) do
					if iter_126_2 ~= "SS1305" then
						iter_126_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_30 = 0

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_31 = 1.33333333333333

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_31 then
				local var_126_32 = (arg_123_1.time_ - var_126_30) / var_126_31
				local var_126_33 = Color.New(0, 0, 0)

				var_126_33.a = Mathf.Lerp(0, 1, var_126_32)
				arg_123_1.mask_.color = var_126_33
			end

			if arg_123_1.time_ >= var_126_30 + var_126_31 and arg_123_1.time_ < var_126_30 + var_126_31 + arg_126_0 then
				local var_126_34 = Color.New(0, 0, 0)

				var_126_34.a = 1
				arg_123_1.mask_.color = var_126_34
			end

			local var_126_35 = 1.33333333333333

			if var_126_35 < arg_123_1.time_ and arg_123_1.time_ <= var_126_35 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_36 = 2

			if var_126_35 <= arg_123_1.time_ and arg_123_1.time_ < var_126_35 + var_126_36 then
				local var_126_37 = (arg_123_1.time_ - var_126_35) / var_126_36
				local var_126_38 = Color.New(0, 0, 0)

				var_126_38.a = Mathf.Lerp(1, 0, var_126_37)
				arg_123_1.mask_.color = var_126_38
			end

			if arg_123_1.time_ >= var_126_35 + var_126_36 and arg_123_1.time_ < var_126_35 + var_126_36 + arg_126_0 then
				local var_126_39 = Color.New(0, 0, 0)
				local var_126_40 = 0

				arg_123_1.mask_.enabled = false
				var_126_39.a = var_126_40
				arg_123_1.mask_.color = var_126_39
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_41 = 3.2
			local var_126_42 = 1.5

			if var_126_41 < arg_123_1.time_ and arg_123_1.time_ <= var_126_41 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_43 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_43:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_44 = arg_123_1:GetWordFromCfg(413071028)
				local var_126_45 = arg_123_1:FormatText(var_126_44.content)

				arg_123_1.text_.text = var_126_45

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_46 = 60
				local var_126_47 = utf8.len(var_126_45)
				local var_126_48 = var_126_46 <= 0 and var_126_42 or var_126_42 * (var_126_47 / var_126_46)

				if var_126_48 > 0 and var_126_42 < var_126_48 then
					arg_123_1.talkMaxDuration = var_126_48
					var_126_41 = var_126_41 + 0.3

					if var_126_48 + var_126_41 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_48 + var_126_41
					end
				end

				arg_123_1.text_.text = var_126_45
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_49 = var_126_41 + 0.3
			local var_126_50 = math.max(var_126_42, arg_123_1.talkMaxDuration)

			if var_126_49 <= arg_123_1.time_ and arg_123_1.time_ < var_126_49 + var_126_50 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_49) / var_126_50

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_49 + var_126_50 and arg_123_1.time_ < var_126_49 + var_126_50 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
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
	Play413071029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413071029
		arg_129_1.duration_ = 4.3

		local var_129_0 = {
			zh = 2.766,
			ja = 4.3
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
				arg_129_0:Play413071030(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.35

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[994].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(413071029)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 14
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071029", "story_v_out_413071.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071029", "story_v_out_413071.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_413071", "413071029", "story_v_out_413071.awb")

						arg_129_1:RecordAudio("413071029", var_132_9)
						arg_129_1:RecordAudio("413071029", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413071", "413071029", "story_v_out_413071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413071", "413071029", "story_v_out_413071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413071030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413071030
		arg_133_1.duration_ = 5.17

		local var_133_0 = {
			zh = 2.7,
			ja = 5.166
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
				arg_133_0:Play413071031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.375

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[28].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(413071030)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071030", "story_v_out_413071.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071030", "story_v_out_413071.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_413071", "413071030", "story_v_out_413071.awb")

						arg_133_1:RecordAudio("413071030", var_136_9)
						arg_133_1:RecordAudio("413071030", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413071", "413071030", "story_v_out_413071.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413071", "413071030", "story_v_out_413071.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play413071031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413071031
		arg_137_1.duration_ = 6.37

		local var_137_0 = {
			zh = 4.8,
			ja = 6.366
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
				arg_137_0:Play413071032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.45

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[994].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(413071031)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 18
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071031", "story_v_out_413071.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071031", "story_v_out_413071.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_413071", "413071031", "story_v_out_413071.awb")

						arg_137_1:RecordAudio("413071031", var_140_9)
						arg_137_1:RecordAudio("413071031", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413071", "413071031", "story_v_out_413071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413071", "413071031", "story_v_out_413071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play413071032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413071032
		arg_141_1.duration_ = 3.4

		local var_141_0 = {
			zh = 3.4,
			ja = 2.833
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
				arg_141_0:Play413071033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.3

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[28].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(413071032)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 12
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071032", "story_v_out_413071.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071032", "story_v_out_413071.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_413071", "413071032", "story_v_out_413071.awb")

						arg_141_1:RecordAudio("413071032", var_144_9)
						arg_141_1:RecordAudio("413071032", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413071", "413071032", "story_v_out_413071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413071", "413071032", "story_v_out_413071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play413071033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413071033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play413071034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 1.05

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(413071033)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 42
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play413071034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413071034
		arg_149_1.duration_ = 7.3

		local var_149_0 = {
			zh = 4.7,
			ja = 7.3
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
				arg_149_0:Play413071035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.375

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[28].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(413071034)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 15
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071034", "story_v_out_413071.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071034", "story_v_out_413071.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_413071", "413071034", "story_v_out_413071.awb")

						arg_149_1:RecordAudio("413071034", var_152_9)
						arg_149_1:RecordAudio("413071034", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413071", "413071034", "story_v_out_413071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413071", "413071034", "story_v_out_413071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_10 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_10 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_10

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_10 and arg_149_1.time_ < var_152_0 + var_152_10 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play413071035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413071035
		arg_153_1.duration_ = 4.6

		local var_153_0 = {
			zh = 4.6,
			ja = 3.766
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play413071036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.4

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[994].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(413071035)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071035", "story_v_out_413071.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071035", "story_v_out_413071.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_413071", "413071035", "story_v_out_413071.awb")

						arg_153_1:RecordAudio("413071035", var_156_9)
						arg_153_1:RecordAudio("413071035", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413071", "413071035", "story_v_out_413071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413071", "413071035", "story_v_out_413071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_10 and arg_153_1.time_ < var_156_0 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play413071036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413071036
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413071037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.825

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(413071036)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 33
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play413071037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413071037
		arg_161_1.duration_ = 2.5

		local var_161_0 = {
			zh = 1.233,
			ja = 2.5
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
				arg_161_0:Play413071038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.1

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[28].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(413071037)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071037", "story_v_out_413071.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071037", "story_v_out_413071.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_413071", "413071037", "story_v_out_413071.awb")

						arg_161_1:RecordAudio("413071037", var_164_9)
						arg_161_1:RecordAudio("413071037", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413071", "413071037", "story_v_out_413071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413071", "413071037", "story_v_out_413071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play413071038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413071038
		arg_165_1.duration_ = 6.9

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play413071039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = false

				arg_165_1:SetGaussion(false)
			end

			local var_168_1 = 0.633333333333333

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_1 then
				local var_168_2 = (arg_165_1.time_ - var_168_0) / var_168_1
				local var_168_3 = Color.New(1, 1, 1)

				var_168_3.a = Mathf.Lerp(1, 0, var_168_2)
				arg_165_1.mask_.color = var_168_3
			end

			if arg_165_1.time_ >= var_168_0 + var_168_1 and arg_165_1.time_ < var_168_0 + var_168_1 + arg_168_0 then
				local var_168_4 = Color.New(1, 1, 1)
				local var_168_5 = 0

				arg_165_1.mask_.enabled = false
				var_168_4.a = var_168_5
				arg_165_1.mask_.color = var_168_4
			end

			local var_168_6 = arg_165_1.bgs_.SS1305.transform
			local var_168_7 = 0.266666666666667

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.var_.moveOldPosSS1305 = var_168_6.localPosition
			end

			local var_168_8 = 0.001

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8
				local var_168_10 = Vector3.New(0, 1, 10)

				var_168_6.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSS1305, var_168_10, var_168_9)
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 then
				var_168_6.localPosition = Vector3.New(0, 1, 10)
			end

			local var_168_11 = arg_165_1.bgs_.SS1305.transform
			local var_168_12 = 0.300666666666667

			if var_168_12 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.var_.moveOldPosSS1305 = var_168_11.localPosition
			end

			local var_168_13 = 1.83266666666667

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_13 then
				local var_168_14 = (arg_165_1.time_ - var_168_12) / var_168_13
				local var_168_15 = Vector3.New(0, 1, 8.97)

				var_168_11.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSS1305, var_168_15, var_168_14)
			end

			if arg_165_1.time_ >= var_168_12 + var_168_13 and arg_165_1.time_ < var_168_12 + var_168_13 + arg_168_0 then
				var_168_11.localPosition = Vector3.New(0, 1, 8.97)
			end

			local var_168_16 = 0.266666666666667

			if var_168_16 < arg_165_1.time_ and arg_165_1.time_ <= var_168_16 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			local var_168_17 = 1.86666666666667

			if arg_165_1.time_ >= var_168_16 + var_168_17 and arg_165_1.time_ < var_168_16 + var_168_17 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_18 = 1.9
			local var_168_19 = 1.3

			if var_168_18 < arg_165_1.time_ and arg_165_1.time_ <= var_168_18 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_20 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_20:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_21 = arg_165_1:GetWordFromCfg(413071038)
				local var_168_22 = arg_165_1:FormatText(var_168_21.content)

				arg_165_1.text_.text = var_168_22

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_23 = 52
				local var_168_24 = utf8.len(var_168_22)
				local var_168_25 = var_168_23 <= 0 and var_168_19 or var_168_19 * (var_168_24 / var_168_23)

				if var_168_25 > 0 and var_168_19 < var_168_25 then
					arg_165_1.talkMaxDuration = var_168_25
					var_168_18 = var_168_18 + 0.3

					if var_168_25 + var_168_18 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_25 + var_168_18
					end
				end

				arg_165_1.text_.text = var_168_22
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_26 = var_168_18 + 0.3
			local var_168_27 = math.max(var_168_19, arg_165_1.talkMaxDuration)

			if var_168_26 <= arg_165_1.time_ and arg_165_1.time_ < var_168_26 + var_168_27 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_26) / var_168_27

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_26 + var_168_27 and arg_165_1.time_ < var_168_26 + var_168_27 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.266666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1305",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.83266666666667,
				className = "StoryMoveNode",
				startTime = 0.300666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play413071039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413071039
		arg_171_1.duration_ = 2.77

		local var_171_0 = {
			zh = 1.9,
			ja = 2.766
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play413071040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.2

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[28].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(413071039)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071039", "story_v_out_413071.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071039", "story_v_out_413071.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_413071", "413071039", "story_v_out_413071.awb")

						arg_171_1:RecordAudio("413071039", var_174_9)
						arg_171_1:RecordAudio("413071039", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413071", "413071039", "story_v_out_413071.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413071", "413071039", "story_v_out_413071.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play413071040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413071040
		arg_175_1.duration_ = 7.8

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413071041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = "F08i"

			if arg_175_1.bgs_[var_178_0] == nil then
				local var_178_1 = Object.Instantiate(arg_175_1.paintGo_)

				var_178_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_178_0)
				var_178_1.name = var_178_0
				var_178_1.transform.parent = arg_175_1.stage_.transform
				var_178_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.bgs_[var_178_0] = var_178_1
			end

			local var_178_2 = 1.3

			if var_178_2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				local var_178_3 = manager.ui.mainCamera.transform.localPosition
				local var_178_4 = Vector3.New(0, 0, 10) + Vector3.New(var_178_3.x, var_178_3.y, 0)
				local var_178_5 = arg_175_1.bgs_.F08i

				var_178_5.transform.localPosition = var_178_4
				var_178_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_6 = var_178_5:GetComponent("SpriteRenderer")

				if var_178_6 and var_178_6.sprite then
					local var_178_7 = (var_178_5.transform.localPosition - var_178_3).z
					local var_178_8 = manager.ui.mainCameraCom_
					local var_178_9 = 2 * var_178_7 * Mathf.Tan(var_178_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_10 = var_178_9 * var_178_8.aspect
					local var_178_11 = var_178_6.sprite.bounds.size.x
					local var_178_12 = var_178_6.sprite.bounds.size.y
					local var_178_13 = var_178_10 / var_178_11
					local var_178_14 = var_178_9 / var_178_12
					local var_178_15 = var_178_14 < var_178_13 and var_178_13 or var_178_14

					var_178_5.transform.localScale = Vector3.New(var_178_15, var_178_15, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "F08i" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_16 = 2.5

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_17 = 0.3

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_18 = 0

			if var_178_18 < arg_175_1.time_ and arg_175_1.time_ <= var_178_18 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_19 = 1.3

			if var_178_18 <= arg_175_1.time_ and arg_175_1.time_ < var_178_18 + var_178_19 then
				local var_178_20 = (arg_175_1.time_ - var_178_18) / var_178_19
				local var_178_21 = Color.New(0, 0, 0)

				var_178_21.a = Mathf.Lerp(0, 1, var_178_20)
				arg_175_1.mask_.color = var_178_21
			end

			if arg_175_1.time_ >= var_178_18 + var_178_19 and arg_175_1.time_ < var_178_18 + var_178_19 + arg_178_0 then
				local var_178_22 = Color.New(0, 0, 0)

				var_178_22.a = 1
				arg_175_1.mask_.color = var_178_22
			end

			local var_178_23 = 1.3

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_24 = 1.5

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_24 then
				local var_178_25 = (arg_175_1.time_ - var_178_23) / var_178_24
				local var_178_26 = Color.New(0, 0, 0)

				var_178_26.a = Mathf.Lerp(1, 0, var_178_25)
				arg_175_1.mask_.color = var_178_26
			end

			if arg_175_1.time_ >= var_178_23 + var_178_24 and arg_175_1.time_ < var_178_23 + var_178_24 + arg_178_0 then
				local var_178_27 = Color.New(0, 0, 0)
				local var_178_28 = 0

				arg_175_1.mask_.enabled = false
				var_178_27.a = var_178_28
				arg_175_1.mask_.color = var_178_27
			end

			local var_178_29 = 0

			if var_178_29 < arg_175_1.time_ and arg_175_1.time_ <= var_178_29 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_30 = 0.5

			if arg_175_1.time_ >= var_178_29 + var_178_30 and arg_175_1.time_ < var_178_29 + var_178_30 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_31 = 1.5
			local var_178_32 = 1

			if var_178_31 < arg_175_1.time_ and arg_175_1.time_ <= var_178_31 + arg_178_0 then
				local var_178_33 = "play"
				local var_178_34 = "effect"

				arg_175_1:AudioAction(var_178_33, var_178_34, "se_story", "se_story_alarmloop", "")
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_35 = 2.8
			local var_178_36 = 1.6

			if var_178_35 < arg_175_1.time_ and arg_175_1.time_ <= var_178_35 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_37 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_37:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_38 = arg_175_1:GetWordFromCfg(413071040)
				local var_178_39 = arg_175_1:FormatText(var_178_38.content)

				arg_175_1.text_.text = var_178_39

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_40 = 64
				local var_178_41 = utf8.len(var_178_39)
				local var_178_42 = var_178_40 <= 0 and var_178_36 or var_178_36 * (var_178_41 / var_178_40)

				if var_178_42 > 0 and var_178_36 < var_178_42 then
					arg_175_1.talkMaxDuration = var_178_42
					var_178_35 = var_178_35 + 0.3

					if var_178_42 + var_178_35 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_42 + var_178_35
					end
				end

				arg_175_1.text_.text = var_178_39
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_43 = var_178_35 + 0.3
			local var_178_44 = math.max(var_178_36, arg_175_1.talkMaxDuration)

			if var_178_43 <= arg_175_1.time_ and arg_175_1.time_ < var_178_43 + var_178_44 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_43) / var_178_44

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_43 + var_178_44 and arg_175_1.time_ < var_178_43 + var_178_44 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play413071041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413071041
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play413071042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.2

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(413071041)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 48
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413071042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413071042
		arg_185_1.duration_ = 6.17

		local var_185_0 = {
			zh = 6.166,
			ja = 5.7
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
				arg_185_0:Play413071043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.575

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[993].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(413071042)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 23
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071042", "story_v_out_413071.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071042", "story_v_out_413071.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_413071", "413071042", "story_v_out_413071.awb")

						arg_185_1:RecordAudio("413071042", var_188_9)
						arg_185_1:RecordAudio("413071042", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413071", "413071042", "story_v_out_413071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413071", "413071042", "story_v_out_413071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413071043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413071043
		arg_189_1.duration_ = 8.67

		local var_189_0 = {
			zh = 7.9,
			ja = 8.666
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
				arg_189_0:Play413071044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.475

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[993].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(413071043)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071043", "story_v_out_413071.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071043", "story_v_out_413071.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_413071", "413071043", "story_v_out_413071.awb")

						arg_189_1:RecordAudio("413071043", var_192_9)
						arg_189_1:RecordAudio("413071043", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413071", "413071043", "story_v_out_413071.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413071", "413071043", "story_v_out_413071.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play413071044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413071044
		arg_193_1.duration_ = 8.78

		local var_193_0 = {
			zh = 6.816,
			ja = 8.783
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
				arg_193_0:Play413071045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "10096"

			if arg_193_1.actors_[var_196_0] == nil then
				local var_196_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_196_1) then
					local var_196_2 = Object.Instantiate(var_196_1, arg_193_1.canvasGo_.transform)

					var_196_2.transform:SetSiblingIndex(1)

					var_196_2.name = var_196_0
					var_196_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_193_1.actors_[var_196_0] = var_196_2

					local var_196_3 = var_196_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_193_1.isInRecall_ then
						for iter_196_0, iter_196_1 in ipairs(var_196_3) do
							iter_196_1.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_196_4 = arg_193_1.actors_["10096"].transform
			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.var_.moveOldPos10096 = var_196_4.localPosition
				var_196_4.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10096", 3)

				local var_196_6 = var_196_4.childCount

				for iter_196_2 = 0, var_196_6 - 1 do
					local var_196_7 = var_196_4:GetChild(iter_196_2)

					if var_196_7.name == "" or not string.find(var_196_7.name, "split") then
						var_196_7.gameObject:SetActive(true)
					else
						var_196_7.gameObject:SetActive(false)
					end
				end
			end

			local var_196_8 = 0.001

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_8 then
				local var_196_9 = (arg_193_1.time_ - var_196_5) / var_196_8
				local var_196_10 = Vector3.New(0, -350, -210)

				var_196_4.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10096, var_196_10, var_196_9)
			end

			if arg_193_1.time_ >= var_196_5 + var_196_8 and arg_193_1.time_ < var_196_5 + var_196_8 + arg_196_0 then
				var_196_4.localPosition = Vector3.New(0, -350, -210)
			end

			local var_196_11 = arg_193_1.actors_["10096"]
			local var_196_12 = 0

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 and not isNil(var_196_11) and arg_193_1.var_.actorSpriteComps10096 == nil then
				arg_193_1.var_.actorSpriteComps10096 = var_196_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_13 = 2

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_13 and not isNil(var_196_11) then
				local var_196_14 = (arg_193_1.time_ - var_196_12) / var_196_13

				if arg_193_1.var_.actorSpriteComps10096 then
					for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_196_4 then
							if arg_193_1.isInRecall_ then
								local var_196_15 = Mathf.Lerp(iter_196_4.color.r, arg_193_1.hightColor1.r, var_196_14)
								local var_196_16 = Mathf.Lerp(iter_196_4.color.g, arg_193_1.hightColor1.g, var_196_14)
								local var_196_17 = Mathf.Lerp(iter_196_4.color.b, arg_193_1.hightColor1.b, var_196_14)

								iter_196_4.color = Color.New(var_196_15, var_196_16, var_196_17)
							else
								local var_196_18 = Mathf.Lerp(iter_196_4.color.r, 1, var_196_14)

								iter_196_4.color = Color.New(var_196_18, var_196_18, var_196_18)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_12 + var_196_13 and arg_193_1.time_ < var_196_12 + var_196_13 + arg_196_0 and not isNil(var_196_11) and arg_193_1.var_.actorSpriteComps10096 then
				for iter_196_5, iter_196_6 in pairs(arg_193_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_196_6 then
						if arg_193_1.isInRecall_ then
							iter_196_6.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10096 = nil
			end

			local var_196_19 = arg_193_1.actors_["10096"]
			local var_196_20 = 0

			if var_196_20 < arg_193_1.time_ and arg_193_1.time_ <= var_196_20 + arg_196_0 then
				local var_196_21 = var_196_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_21 then
					arg_193_1.var_.alphaOldValue10096 = var_196_21.alpha
					arg_193_1.var_.characterEffect10096 = var_196_21
				end

				arg_193_1.var_.alphaOldValue10096 = 0
			end

			local var_196_22 = 0.5

			if var_196_20 <= arg_193_1.time_ and arg_193_1.time_ < var_196_20 + var_196_22 then
				local var_196_23 = (arg_193_1.time_ - var_196_20) / var_196_22
				local var_196_24 = Mathf.Lerp(arg_193_1.var_.alphaOldValue10096, 1, var_196_23)

				if arg_193_1.var_.characterEffect10096 then
					arg_193_1.var_.characterEffect10096.alpha = var_196_24
				end
			end

			if arg_193_1.time_ >= var_196_20 + var_196_22 and arg_193_1.time_ < var_196_20 + var_196_22 + arg_196_0 and arg_193_1.var_.characterEffect10096 then
				arg_193_1.var_.characterEffect10096.alpha = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_25 = 0.25
			local var_196_26 = 0.25

			if var_196_25 < arg_193_1.time_ and arg_193_1.time_ <= var_196_25 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_27 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_27:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_28 = arg_193_1:FormatText(StoryNameCfg[995].name)

				arg_193_1.leftNameTxt_.text = var_196_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_29 = arg_193_1:GetWordFromCfg(413071044)
				local var_196_30 = arg_193_1:FormatText(var_196_29.content)

				arg_193_1.text_.text = var_196_30

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_31 = 10
				local var_196_32 = utf8.len(var_196_30)
				local var_196_33 = var_196_31 <= 0 and var_196_26 or var_196_26 * (var_196_32 / var_196_31)

				if var_196_33 > 0 and var_196_26 < var_196_33 then
					arg_193_1.talkMaxDuration = var_196_33
					var_196_25 = var_196_25 + 0.3

					if var_196_33 + var_196_25 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_33 + var_196_25
					end
				end

				arg_193_1.text_.text = var_196_30
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071044", "story_v_out_413071.awb") ~= 0 then
					local var_196_34 = manager.audio:GetVoiceLength("story_v_out_413071", "413071044", "story_v_out_413071.awb") / 1000

					if var_196_34 + var_196_25 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_34 + var_196_25
					end

					if var_196_29.prefab_name ~= "" and arg_193_1.actors_[var_196_29.prefab_name] ~= nil then
						local var_196_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_29.prefab_name].transform, "story_v_out_413071", "413071044", "story_v_out_413071.awb")

						arg_193_1:RecordAudio("413071044", var_196_35)
						arg_193_1:RecordAudio("413071044", var_196_35)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413071", "413071044", "story_v_out_413071.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413071", "413071044", "story_v_out_413071.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_36 = var_196_25 + 0.3
			local var_196_37 = math.max(var_196_26, arg_193_1.talkMaxDuration)

			if var_196_36 <= arg_193_1.time_ and arg_193_1.time_ < var_196_36 + var_196_37 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_36) / var_196_37

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_36 + var_196_37 and arg_193_1.time_ < var_196_36 + var_196_37 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413071045
		arg_199_1.duration_ = 6.2

		local var_199_0 = {
			zh = 5.333,
			ja = 6.2
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play413071046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10096"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10096 == nil then
				arg_199_1.var_.actorSpriteComps10096 = var_202_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_2 = 2

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.actorSpriteComps10096 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								local var_202_4 = Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, var_202_3)
								local var_202_5 = Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, var_202_3)
								local var_202_6 = Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, var_202_3)

								iter_202_1.color = Color.New(var_202_4, var_202_5, var_202_6)
							else
								local var_202_7 = Mathf.Lerp(iter_202_1.color.r, 0.5, var_202_3)

								iter_202_1.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.actorSpriteComps10096 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_202_3 then
						if arg_199_1.isInRecall_ then
							iter_202_3.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10096 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.525

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_10 = arg_199_1:FormatText(StoryNameCfg[993].name)

				arg_199_1.leftNameTxt_.text = var_202_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_11 = arg_199_1:GetWordFromCfg(413071045)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 21
				local var_202_14 = utf8.len(var_202_12)
				local var_202_15 = var_202_13 <= 0 and var_202_9 or var_202_9 * (var_202_14 / var_202_13)

				if var_202_15 > 0 and var_202_9 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_12
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071045", "story_v_out_413071.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071045", "story_v_out_413071.awb") / 1000

					if var_202_16 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_8
					end

					if var_202_11.prefab_name ~= "" and arg_199_1.actors_[var_202_11.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_11.prefab_name].transform, "story_v_out_413071", "413071045", "story_v_out_413071.awb")

						arg_199_1:RecordAudio("413071045", var_202_17)
						arg_199_1:RecordAudio("413071045", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413071", "413071045", "story_v_out_413071.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413071", "413071045", "story_v_out_413071.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_18 and arg_199_1.time_ < var_202_8 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play413071046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413071046
		arg_203_1.duration_ = 6.8

		local var_203_0 = {
			zh = 4.7,
			ja = 6.8
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
				arg_203_0:Play413071047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10096"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos10096 = var_206_0.localPosition
				var_206_0.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10096", 3)

				local var_206_2 = var_206_0.childCount

				for iter_206_0 = 0, var_206_2 - 1 do
					local var_206_3 = var_206_0:GetChild(iter_206_0)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_4 then
				local var_206_5 = (arg_203_1.time_ - var_206_1) / var_206_4
				local var_206_6 = Vector3.New(0, -350, -210)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10096, var_206_6, var_206_5)
			end

			if arg_203_1.time_ >= var_206_1 + var_206_4 and arg_203_1.time_ < var_206_1 + var_206_4 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_206_7 = arg_203_1.actors_["10096"]
			local var_206_8 = 0

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps10096 == nil then
				arg_203_1.var_.actorSpriteComps10096 = var_206_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_9 = 2

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 and not isNil(var_206_7) then
				local var_206_10 = (arg_203_1.time_ - var_206_8) / var_206_9

				if arg_203_1.var_.actorSpriteComps10096 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								local var_206_11 = Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, var_206_10)
								local var_206_12 = Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, var_206_10)
								local var_206_13 = Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, var_206_10)

								iter_206_2.color = Color.New(var_206_11, var_206_12, var_206_13)
							else
								local var_206_14 = Mathf.Lerp(iter_206_2.color.r, 1, var_206_10)

								iter_206_2.color = Color.New(var_206_14, var_206_14, var_206_14)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps10096 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_206_4 then
						if arg_203_1.isInRecall_ then
							iter_206_4.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10096 = nil
			end

			local var_206_15 = 0
			local var_206_16 = 0.2

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[995].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(413071046)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 8
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071046", "story_v_out_413071.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071046", "story_v_out_413071.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_out_413071", "413071046", "story_v_out_413071.awb")

						arg_203_1:RecordAudio("413071046", var_206_24)
						arg_203_1:RecordAudio("413071046", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_413071", "413071046", "story_v_out_413071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_413071", "413071046", "story_v_out_413071.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 413071047
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play413071048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10096"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10096 = var_210_0.localPosition
				var_210_0.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10096", 7)

				local var_210_2 = var_210_0.childCount

				for iter_210_0 = 0, var_210_2 - 1 do
					local var_210_3 = var_210_0:GetChild(iter_210_0)

					if var_210_3.name == "" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_4 then
				local var_210_5 = (arg_207_1.time_ - var_210_1) / var_210_4
				local var_210_6 = Vector3.New(0, -2000, -180)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10096, var_210_6, var_210_5)
			end

			if arg_207_1.time_ >= var_210_1 + var_210_4 and arg_207_1.time_ < var_210_1 + var_210_4 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_210_7 = arg_207_1.actors_["10096"]
			local var_210_8 = 0

			if var_210_8 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10096 == nil then
				arg_207_1.var_.actorSpriteComps10096 = var_210_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_9 = 2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 and not isNil(var_210_7) then
				local var_210_10 = (arg_207_1.time_ - var_210_8) / var_210_9

				if arg_207_1.var_.actorSpriteComps10096 then
					for iter_210_1, iter_210_2 in pairs(arg_207_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_210_2 then
							if arg_207_1.isInRecall_ then
								local var_210_11 = Mathf.Lerp(iter_210_2.color.r, arg_207_1.hightColor2.r, var_210_10)
								local var_210_12 = Mathf.Lerp(iter_210_2.color.g, arg_207_1.hightColor2.g, var_210_10)
								local var_210_13 = Mathf.Lerp(iter_210_2.color.b, arg_207_1.hightColor2.b, var_210_10)

								iter_210_2.color = Color.New(var_210_11, var_210_12, var_210_13)
							else
								local var_210_14 = Mathf.Lerp(iter_210_2.color.r, 0.5, var_210_10)

								iter_210_2.color = Color.New(var_210_14, var_210_14, var_210_14)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 and not isNil(var_210_7) and arg_207_1.var_.actorSpriteComps10096 then
				for iter_210_3, iter_210_4 in pairs(arg_207_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_210_4 then
						if arg_207_1.isInRecall_ then
							iter_210_4.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10096 = nil
			end

			local var_210_15 = 0
			local var_210_16 = 1.6

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:GetWordFromCfg(413071047)
				local var_210_18 = arg_207_1:FormatText(var_210_17.content)

				arg_207_1.text_.text = var_210_18

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 64
				local var_210_20 = utf8.len(var_210_18)
				local var_210_21 = var_210_19 <= 0 and var_210_16 or var_210_16 * (var_210_20 / var_210_19)

				if var_210_21 > 0 and var_210_16 < var_210_21 then
					arg_207_1.talkMaxDuration = var_210_21

					if var_210_21 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_21 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_18
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_22 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_22 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_22

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_22 and arg_207_1.time_ < var_210_15 + var_210_22 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413071048
		arg_211_1.duration_ = 5.5

		local var_211_0 = {
			zh = 4.133,
			ja = 5.5
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
				arg_211_0:Play413071049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.5

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[993].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(413071048)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 20
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071048", "story_v_out_413071.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071048", "story_v_out_413071.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_413071", "413071048", "story_v_out_413071.awb")

						arg_211_1:RecordAudio("413071048", var_214_9)
						arg_211_1:RecordAudio("413071048", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_413071", "413071048", "story_v_out_413071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_413071", "413071048", "story_v_out_413071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play413071049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413071049
		arg_215_1.duration_ = 4.57

		local var_215_0 = {
			zh = 4.433,
			ja = 4.566
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play413071050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.8

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				local var_218_2 = "play"
				local var_218_3 = "effect"

				arg_215_1:AudioAction(var_218_2, var_218_3, "se_story_129", "se_story_129_break", "")
			end

			local var_218_4 = 0
			local var_218_5 = 0.175

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_6 = arg_215_1:FormatText(StoryNameCfg[36].name)

				arg_215_1.leftNameTxt_.text = var_218_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_7 = arg_215_1:GetWordFromCfg(413071049)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 7
				local var_218_10 = utf8.len(var_218_8)
				local var_218_11 = var_218_9 <= 0 and var_218_5 or var_218_5 * (var_218_10 / var_218_9)

				if var_218_11 > 0 and var_218_5 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071049", "story_v_out_413071.awb") ~= 0 then
					local var_218_12 = manager.audio:GetVoiceLength("story_v_out_413071", "413071049", "story_v_out_413071.awb") / 1000

					if var_218_12 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_4
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_413071", "413071049", "story_v_out_413071.awb")

						arg_215_1:RecordAudio("413071049", var_218_13)
						arg_215_1:RecordAudio("413071049", var_218_13)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413071", "413071049", "story_v_out_413071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413071", "413071049", "story_v_out_413071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_14 and arg_215_1.time_ < var_218_4 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play413071050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413071050
		arg_219_1.duration_ = 7.53

		local var_219_0 = {
			zh = 5.266,
			ja = 7.533
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play413071051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10096"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10096 == nil then
				arg_219_1.var_.actorSpriteComps10096 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps10096 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor2.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor2.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor2.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 0.5, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10096 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10096 = nil
			end

			local var_222_8 = 0
			local var_222_9 = 0.475

			if var_222_8 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_10 = arg_219_1:FormatText(StoryNameCfg[993].name)

				arg_219_1.leftNameTxt_.text = var_222_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_11 = arg_219_1:GetWordFromCfg(413071050)
				local var_222_12 = arg_219_1:FormatText(var_222_11.content)

				arg_219_1.text_.text = var_222_12

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 19
				local var_222_14 = utf8.len(var_222_12)
				local var_222_15 = var_222_13 <= 0 and var_222_9 or var_222_9 * (var_222_14 / var_222_13)

				if var_222_15 > 0 and var_222_9 < var_222_15 then
					arg_219_1.talkMaxDuration = var_222_15

					if var_222_15 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_15 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_12
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071050", "story_v_out_413071.awb") ~= 0 then
					local var_222_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071050", "story_v_out_413071.awb") / 1000

					if var_222_16 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_16 + var_222_8
					end

					if var_222_11.prefab_name ~= "" and arg_219_1.actors_[var_222_11.prefab_name] ~= nil then
						local var_222_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_11.prefab_name].transform, "story_v_out_413071", "413071050", "story_v_out_413071.awb")

						arg_219_1:RecordAudio("413071050", var_222_17)
						arg_219_1:RecordAudio("413071050", var_222_17)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_413071", "413071050", "story_v_out_413071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_413071", "413071050", "story_v_out_413071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_18 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_18 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_18

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_18 and arg_219_1.time_ < var_222_8 + var_222_18 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play413071051 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413071051
		arg_223_1.duration_ = 4.8

		local var_223_0 = {
			zh = 3.9,
			ja = 4.8
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play413071052(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.15

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[995].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(413071051)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 6
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071051", "story_v_out_413071.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071051", "story_v_out_413071.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_413071", "413071051", "story_v_out_413071.awb")

						arg_223_1:RecordAudio("413071051", var_226_9)
						arg_223_1:RecordAudio("413071051", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413071", "413071051", "story_v_out_413071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413071", "413071051", "story_v_out_413071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play413071052 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413071052
		arg_227_1.duration_ = 4.97

		local var_227_0 = {
			zh = 4.3,
			ja = 4.966
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play413071053(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.325

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[993].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(413071052)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 13
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071052", "story_v_out_413071.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071052", "story_v_out_413071.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_413071", "413071052", "story_v_out_413071.awb")

						arg_227_1:RecordAudio("413071052", var_230_9)
						arg_227_1:RecordAudio("413071052", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413071", "413071052", "story_v_out_413071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413071", "413071052", "story_v_out_413071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play413071053 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413071053
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413071054(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10096"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos10096 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10096", 7)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(0, -2000, -180)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10096, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_234_7 = arg_231_1.actors_["10096"]
			local var_234_8 = 0

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10096 == nil then
				arg_231_1.var_.actorSpriteComps10096 = var_234_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_9 = 2

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 and not isNil(var_234_7) then
				local var_234_10 = (arg_231_1.time_ - var_234_8) / var_234_9

				if arg_231_1.var_.actorSpriteComps10096 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								local var_234_11 = Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor2.r, var_234_10)
								local var_234_12 = Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor2.g, var_234_10)
								local var_234_13 = Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor2.b, var_234_10)

								iter_234_2.color = Color.New(var_234_11, var_234_12, var_234_13)
							else
								local var_234_14 = Mathf.Lerp(iter_234_2.color.r, 0.5, var_234_10)

								iter_234_2.color = Color.New(var_234_14, var_234_14, var_234_14)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 and not isNil(var_234_7) and arg_231_1.var_.actorSpriteComps10096 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_234_4 then
						if arg_231_1.isInRecall_ then
							iter_234_4.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10096 = nil
			end

			local var_234_15 = manager.ui.mainCamera.transform
			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				local var_234_17 = arg_231_1.var_.effect逃离1
				local var_234_18
				local var_234_19 = var_234_15

				if not var_234_17 then
					var_234_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_234_19)
					var_234_17.name = "逃离1"
					arg_231_1.var_.effect逃离1 = var_234_17
				else
					var_234_17.transform:SetParent(var_234_19)
				end

				var_234_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_234_20 = 0
			local var_234_21 = 1.9

			if var_234_20 < arg_231_1.time_ and arg_231_1.time_ <= var_234_20 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_22 = arg_231_1:GetWordFromCfg(413071053)
				local var_234_23 = arg_231_1:FormatText(var_234_22.content)

				arg_231_1.text_.text = var_234_23

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_24 = 76
				local var_234_25 = utf8.len(var_234_23)
				local var_234_26 = var_234_24 <= 0 and var_234_21 or var_234_21 * (var_234_25 / var_234_24)

				if var_234_26 > 0 and var_234_21 < var_234_26 then
					arg_231_1.talkMaxDuration = var_234_26

					if var_234_26 + var_234_20 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_26 + var_234_20
					end
				end

				arg_231_1.text_.text = var_234_23
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_27 = math.max(var_234_21, arg_231_1.talkMaxDuration)

			if var_234_20 <= arg_231_1.time_ and arg_231_1.time_ < var_234_20 + var_234_27 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_20) / var_234_27

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_20 + var_234_27 and arg_231_1.time_ < var_234_20 + var_234_27 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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
	Play413071054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413071054
		arg_235_1.duration_ = 10.03

		local var_235_0 = {
			zh = 7.833,
			ja = 10.033
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413071055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = "F08g"

			if arg_235_1.bgs_[var_238_0] == nil then
				local var_238_1 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_238_0)
				var_238_1.name = var_238_0
				var_238_1.transform.parent = arg_235_1.stage_.transform
				var_238_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_[var_238_0] = var_238_1
			end

			local var_238_2 = 2

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				local var_238_3 = manager.ui.mainCamera.transform.localPosition
				local var_238_4 = Vector3.New(0, 0, 10) + Vector3.New(var_238_3.x, var_238_3.y, 0)
				local var_238_5 = arg_235_1.bgs_.F08g

				var_238_5.transform.localPosition = var_238_4
				var_238_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_6 = var_238_5:GetComponent("SpriteRenderer")

				if var_238_6 and var_238_6.sprite then
					local var_238_7 = (var_238_5.transform.localPosition - var_238_3).z
					local var_238_8 = manager.ui.mainCameraCom_
					local var_238_9 = 2 * var_238_7 * Mathf.Tan(var_238_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_238_10 = var_238_9 * var_238_8.aspect
					local var_238_11 = var_238_6.sprite.bounds.size.x
					local var_238_12 = var_238_6.sprite.bounds.size.y
					local var_238_13 = var_238_10 / var_238_11
					local var_238_14 = var_238_9 / var_238_12
					local var_238_15 = var_238_14 < var_238_13 and var_238_13 or var_238_14

					var_238_5.transform.localScale = Vector3.New(var_238_15, var_238_15, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "F08g" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_238_16 = 4

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.allBtn_.enabled = false
			end

			local var_238_17 = 0.3

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				arg_235_1.allBtn_.enabled = true
			end

			local var_238_18 = 0

			if var_238_18 < arg_235_1.time_ and arg_235_1.time_ <= var_238_18 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_19 = 2

			if var_238_18 <= arg_235_1.time_ and arg_235_1.time_ < var_238_18 + var_238_19 then
				local var_238_20 = (arg_235_1.time_ - var_238_18) / var_238_19
				local var_238_21 = Color.New(0, 0, 0)

				var_238_21.a = Mathf.Lerp(0, 1, var_238_20)
				arg_235_1.mask_.color = var_238_21
			end

			if arg_235_1.time_ >= var_238_18 + var_238_19 and arg_235_1.time_ < var_238_18 + var_238_19 + arg_238_0 then
				local var_238_22 = Color.New(0, 0, 0)

				var_238_22.a = 1
				arg_235_1.mask_.color = var_238_22
			end

			local var_238_23 = 2

			if var_238_23 < arg_235_1.time_ and arg_235_1.time_ <= var_238_23 + arg_238_0 then
				arg_235_1.mask_.enabled = true
				arg_235_1.mask_.raycastTarget = true

				arg_235_1:SetGaussion(false)
			end

			local var_238_24 = 2

			if var_238_23 <= arg_235_1.time_ and arg_235_1.time_ < var_238_23 + var_238_24 then
				local var_238_25 = (arg_235_1.time_ - var_238_23) / var_238_24
				local var_238_26 = Color.New(0, 0, 0)

				var_238_26.a = Mathf.Lerp(1, 0, var_238_25)
				arg_235_1.mask_.color = var_238_26
			end

			if arg_235_1.time_ >= var_238_23 + var_238_24 and arg_235_1.time_ < var_238_23 + var_238_24 + arg_238_0 then
				local var_238_27 = Color.New(0, 0, 0)
				local var_238_28 = 0

				arg_235_1.mask_.enabled = false
				var_238_27.a = var_238_28
				arg_235_1.mask_.color = var_238_27
			end

			local var_238_29 = "10022"

			if arg_235_1.actors_[var_238_29] == nil then
				local var_238_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_238_30) then
					local var_238_31 = Object.Instantiate(var_238_30, arg_235_1.canvasGo_.transform)

					var_238_31.transform:SetSiblingIndex(1)

					var_238_31.name = var_238_29
					var_238_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_235_1.actors_[var_238_29] = var_238_31

					local var_238_32 = var_238_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_235_1.isInRecall_ then
						for iter_238_2, iter_238_3 in ipairs(var_238_32) do
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_238_33 = arg_235_1.actors_["10022"].transform
			local var_238_34 = 3.8

			if var_238_34 < arg_235_1.time_ and arg_235_1.time_ <= var_238_34 + arg_238_0 then
				arg_235_1.var_.moveOldPos10022 = var_238_33.localPosition
				var_238_33.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10022", 3)

				local var_238_35 = var_238_33.childCount

				for iter_238_4 = 0, var_238_35 - 1 do
					local var_238_36 = var_238_33:GetChild(iter_238_4)

					if var_238_36.name == "split_8" or not string.find(var_238_36.name, "split") then
						var_238_36.gameObject:SetActive(true)
					else
						var_238_36.gameObject:SetActive(false)
					end
				end
			end

			local var_238_37 = 0.001

			if var_238_34 <= arg_235_1.time_ and arg_235_1.time_ < var_238_34 + var_238_37 then
				local var_238_38 = (arg_235_1.time_ - var_238_34) / var_238_37
				local var_238_39 = Vector3.New(0, -315, -320)

				var_238_33.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10022, var_238_39, var_238_38)
			end

			if arg_235_1.time_ >= var_238_34 + var_238_37 and arg_235_1.time_ < var_238_34 + var_238_37 + arg_238_0 then
				var_238_33.localPosition = Vector3.New(0, -315, -320)
			end

			local var_238_40 = arg_235_1.actors_["10022"]
			local var_238_41 = 3.8

			if var_238_41 < arg_235_1.time_ and arg_235_1.time_ <= var_238_41 + arg_238_0 and not isNil(var_238_40) and arg_235_1.var_.actorSpriteComps10022 == nil then
				arg_235_1.var_.actorSpriteComps10022 = var_238_40:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_42 = 0.2

			if var_238_41 <= arg_235_1.time_ and arg_235_1.time_ < var_238_41 + var_238_42 and not isNil(var_238_40) then
				local var_238_43 = (arg_235_1.time_ - var_238_41) / var_238_42

				if arg_235_1.var_.actorSpriteComps10022 then
					for iter_238_5, iter_238_6 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_238_6 then
							if arg_235_1.isInRecall_ then
								local var_238_44 = Mathf.Lerp(iter_238_6.color.r, arg_235_1.hightColor1.r, var_238_43)
								local var_238_45 = Mathf.Lerp(iter_238_6.color.g, arg_235_1.hightColor1.g, var_238_43)
								local var_238_46 = Mathf.Lerp(iter_238_6.color.b, arg_235_1.hightColor1.b, var_238_43)

								iter_238_6.color = Color.New(var_238_44, var_238_45, var_238_46)
							else
								local var_238_47 = Mathf.Lerp(iter_238_6.color.r, 1, var_238_43)

								iter_238_6.color = Color.New(var_238_47, var_238_47, var_238_47)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_41 + var_238_42 and arg_235_1.time_ < var_238_41 + var_238_42 + arg_238_0 and not isNil(var_238_40) and arg_235_1.var_.actorSpriteComps10022 then
				for iter_238_7, iter_238_8 in pairs(arg_235_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_238_8 then
						if arg_235_1.isInRecall_ then
							iter_238_8.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10022 = nil
			end

			local var_238_48 = manager.ui.mainCamera.transform
			local var_238_49 = 1.76666666666667

			if var_238_49 < arg_235_1.time_ and arg_235_1.time_ <= var_238_49 + arg_238_0 then
				local var_238_50 = arg_235_1.var_.effect逃离1

				if var_238_50 then
					Object.Destroy(var_238_50)

					arg_235_1.var_.effect逃离1 = nil
				end
			end

			local var_238_51 = arg_235_1.actors_["10022"]
			local var_238_52 = 3.8

			if var_238_52 < arg_235_1.time_ and arg_235_1.time_ <= var_238_52 + arg_238_0 then
				local var_238_53 = var_238_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_238_53 then
					arg_235_1.var_.alphaOldValue10022 = var_238_53.alpha
					arg_235_1.var_.characterEffect10022 = var_238_53
				end

				arg_235_1.var_.alphaOldValue10022 = 0
			end

			local var_238_54 = 0.2

			if var_238_52 <= arg_235_1.time_ and arg_235_1.time_ < var_238_52 + var_238_54 then
				local var_238_55 = (arg_235_1.time_ - var_238_52) / var_238_54
				local var_238_56 = Mathf.Lerp(arg_235_1.var_.alphaOldValue10022, 1, var_238_55)

				if arg_235_1.var_.characterEffect10022 then
					arg_235_1.var_.characterEffect10022.alpha = var_238_56
				end
			end

			if arg_235_1.time_ >= var_238_52 + var_238_54 and arg_235_1.time_ < var_238_52 + var_238_54 + arg_238_0 and arg_235_1.var_.characterEffect10022 then
				arg_235_1.var_.characterEffect10022.alpha = 1
			end

			if arg_235_1.frameCnt_ <= 1 then
				arg_235_1.dialog_:SetActive(false)
			end

			local var_238_57 = 4
			local var_238_58 = 0.55

			if var_238_57 < arg_235_1.time_ and arg_235_1.time_ <= var_238_57 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_59 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_59:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_60 = arg_235_1:FormatText(StoryNameCfg[614].name)

				arg_235_1.leftNameTxt_.text = var_238_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_61 = arg_235_1:GetWordFromCfg(413071054)
				local var_238_62 = arg_235_1:FormatText(var_238_61.content)

				arg_235_1.text_.text = var_238_62

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_63 = 22
				local var_238_64 = utf8.len(var_238_62)
				local var_238_65 = var_238_63 <= 0 and var_238_58 or var_238_58 * (var_238_64 / var_238_63)

				if var_238_65 > 0 and var_238_58 < var_238_65 then
					arg_235_1.talkMaxDuration = var_238_65
					var_238_57 = var_238_57 + 0.3

					if var_238_65 + var_238_57 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_65 + var_238_57
					end
				end

				arg_235_1.text_.text = var_238_62
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071054", "story_v_out_413071.awb") ~= 0 then
					local var_238_66 = manager.audio:GetVoiceLength("story_v_out_413071", "413071054", "story_v_out_413071.awb") / 1000

					if var_238_66 + var_238_57 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_66 + var_238_57
					end

					if var_238_61.prefab_name ~= "" and arg_235_1.actors_[var_238_61.prefab_name] ~= nil then
						local var_238_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_61.prefab_name].transform, "story_v_out_413071", "413071054", "story_v_out_413071.awb")

						arg_235_1:RecordAudio("413071054", var_238_67)
						arg_235_1:RecordAudio("413071054", var_238_67)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413071", "413071054", "story_v_out_413071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413071", "413071054", "story_v_out_413071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_68 = var_238_57 + 0.3
			local var_238_69 = math.max(var_238_58, arg_235_1.talkMaxDuration)

			if var_238_68 <= arg_235_1.time_ and arg_235_1.time_ < var_238_68 + var_238_69 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_68) / var_238_69

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_68 + var_238_69 and arg_235_1.time_ < var_238_68 + var_238_69 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play413071055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413071055
		arg_241_1.duration_ = 4.3

		local var_241_0 = {
			zh = 2.833,
			ja = 4.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413071056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.425

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[614].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(413071055)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 17
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071055", "story_v_out_413071.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071055", "story_v_out_413071.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_413071", "413071055", "story_v_out_413071.awb")

						arg_241_1:RecordAudio("413071055", var_244_9)
						arg_241_1:RecordAudio("413071055", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413071", "413071055", "story_v_out_413071.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413071", "413071055", "story_v_out_413071.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play413071056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413071056
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play413071057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10022"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10022 == nil then
				arg_245_1.var_.actorSpriteComps10022 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps10022 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 0.5, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10022 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10022 = nil
			end

			local var_248_8 = arg_245_1.actors_["10022"].transform
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.var_.moveOldPos10022 = var_248_8.localPosition
				var_248_8.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10022", 0)

				local var_248_10 = var_248_8.childCount

				for iter_248_4 = 0, var_248_10 - 1 do
					local var_248_11 = var_248_8:GetChild(iter_248_4)

					if var_248_11.name == "" or not string.find(var_248_11.name, "split") then
						var_248_11.gameObject:SetActive(true)
					else
						var_248_11.gameObject:SetActive(false)
					end
				end
			end

			local var_248_12 = 0.001

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_12 then
				local var_248_13 = (arg_245_1.time_ - var_248_9) / var_248_12
				local var_248_14 = Vector3.New(-5000, -315, -320)

				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10022, var_248_14, var_248_13)
			end

			if arg_245_1.time_ >= var_248_9 + var_248_12 and arg_245_1.time_ < var_248_9 + var_248_12 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_248_15 = 0
			local var_248_16 = 1.475

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_17 = arg_245_1:GetWordFromCfg(413071056)
				local var_248_18 = arg_245_1:FormatText(var_248_17.content)

				arg_245_1.text_.text = var_248_18

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_19 = 59
				local var_248_20 = utf8.len(var_248_18)
				local var_248_21 = var_248_19 <= 0 and var_248_16 or var_248_16 * (var_248_20 / var_248_19)

				if var_248_21 > 0 and var_248_16 < var_248_21 then
					arg_245_1.talkMaxDuration = var_248_21

					if var_248_21 + var_248_15 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_21 + var_248_15
					end
				end

				arg_245_1.text_.text = var_248_18
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_22 = math.max(var_248_16, arg_245_1.talkMaxDuration)

			if var_248_15 <= arg_245_1.time_ and arg_245_1.time_ < var_248_15 + var_248_22 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_15) / var_248_22

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_15 + var_248_22 and arg_245_1.time_ < var_248_15 + var_248_22 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play413071057 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413071057
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413071058(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				local var_252_2 = "play"
				local var_252_3 = "effect"

				arg_249_1:AudioAction(var_252_2, var_252_3, "se_story", "se_story_communication", "")
			end

			local var_252_4 = 0
			local var_252_5 = 1.525

			if var_252_4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(413071057)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_8 = 61
				local var_252_9 = utf8.len(var_252_7)
				local var_252_10 = var_252_8 <= 0 and var_252_5 or var_252_5 * (var_252_9 / var_252_8)

				if var_252_10 > 0 and var_252_5 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_11 and arg_249_1.time_ < var_252_4 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play413071058 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413071058
		arg_253_1.duration_ = 3.93

		local var_253_0 = {
			zh = 2.133,
			ja = 3.933
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
				arg_253_0:Play413071059(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = manager.ui.mainCamera.transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.shakeOldPos = var_256_0.localPosition
			end

			local var_256_2 = 0.6

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / 0.066
				local var_256_4, var_256_5 = math.modf(var_256_3)

				var_256_0.localPosition = Vector3.New(var_256_5 * 0.13, var_256_5 * 0.13, var_256_5 * 0.13) + arg_253_1.var_.shakeOldPos
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = arg_253_1.var_.shakeOldPos
			end

			local var_256_6 = 0

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.allBtn_.enabled = false
			end

			local var_256_7 = 0.6

			if arg_253_1.time_ >= var_256_6 + var_256_7 and arg_253_1.time_ < var_256_6 + var_256_7 + arg_256_0 then
				arg_253_1.allBtn_.enabled = true
			end

			local var_256_8 = 0
			local var_256_9 = 0.275

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_10 = arg_253_1:FormatText(StoryNameCfg[992].name)

				arg_253_1.leftNameTxt_.text = var_256_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_253_1.callingController_:SetSelectedState("calling")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_11 = arg_253_1:GetWordFromCfg(413071058)
				local var_256_12 = arg_253_1:FormatText(var_256_11.content)

				arg_253_1.text_.text = var_256_12

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 11
				local var_256_14 = utf8.len(var_256_12)
				local var_256_15 = var_256_13 <= 0 and var_256_9 or var_256_9 * (var_256_14 / var_256_13)

				if var_256_15 > 0 and var_256_9 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_12
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071058", "story_v_out_413071.awb") ~= 0 then
					local var_256_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071058", "story_v_out_413071.awb") / 1000

					if var_256_16 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_16 + var_256_8
					end

					if var_256_11.prefab_name ~= "" and arg_253_1.actors_[var_256_11.prefab_name] ~= nil then
						local var_256_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_11.prefab_name].transform, "story_v_out_413071", "413071058", "story_v_out_413071.awb")

						arg_253_1:RecordAudio("413071058", var_256_17)
						arg_253_1:RecordAudio("413071058", var_256_17)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413071", "413071058", "story_v_out_413071.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413071", "413071058", "story_v_out_413071.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_18 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_18

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_18 and arg_253_1.time_ < var_256_8 + var_256_18 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play413071059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413071059
		arg_257_1.duration_ = 6.7

		local var_257_0 = {
			zh = 4.566,
			ja = 6.7
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
				arg_257_0:Play413071060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.7

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[992].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_257_1.callingController_:SetSelectedState("calling")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(413071059)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 28
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071059", "story_v_out_413071.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071059", "story_v_out_413071.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_413071", "413071059", "story_v_out_413071.awb")

						arg_257_1:RecordAudio("413071059", var_260_9)
						arg_257_1:RecordAudio("413071059", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413071", "413071059", "story_v_out_413071.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413071", "413071059", "story_v_out_413071.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413071060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413071060
		arg_261_1.duration_ = 4.97

		local var_261_0 = {
			zh = 3.6,
			ja = 4.966
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
				arg_261_0:Play413071061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = manager.ui.mainCamera.transform
			local var_264_1 = 1

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				local var_264_2 = arg_261_1.var_.effecttongxunzhongduan1
				local var_264_3
				local var_264_4 = var_264_0

				if not var_264_2 then
					var_264_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_264_4)
					var_264_2.name = "tongxunzhongduan1"
					arg_261_1.var_.effecttongxunzhongduan1 = var_264_2
				else
					var_264_2.transform:SetParent(var_264_4)
				end

				var_264_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_264_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_264_5 = manager.ui.mainCamera.transform
			local var_264_6 = 2.2

			if var_264_6 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				local var_264_7 = arg_261_1.var_.effecttongxunzhongduan1

				if var_264_7 then
					Object.Destroy(var_264_7)

					arg_261_1.var_.effecttongxunzhongduan1 = nil
				end
			end

			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			local var_264_9 = 1

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_10 = 0
			local var_264_11 = 0.325

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_12 = arg_261_1:FormatText(StoryNameCfg[992].name)

				arg_261_1.leftNameTxt_.text = var_264_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_261_1.callingController_:SetSelectedState("calling")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_13 = arg_261_1:GetWordFromCfg(413071060)
				local var_264_14 = arg_261_1:FormatText(var_264_13.content)

				arg_261_1.text_.text = var_264_14

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 13
				local var_264_16 = utf8.len(var_264_14)
				local var_264_17 = var_264_15 <= 0 and var_264_11 or var_264_11 * (var_264_16 / var_264_15)

				if var_264_17 > 0 and var_264_11 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_14
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071060", "story_v_out_413071.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_413071", "413071060", "story_v_out_413071.awb") / 1000

					if var_264_18 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_10
					end

					if var_264_13.prefab_name ~= "" and arg_261_1.actors_[var_264_13.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_13.prefab_name].transform, "story_v_out_413071", "413071060", "story_v_out_413071.awb")

						arg_261_1:RecordAudio("413071060", var_264_19)
						arg_261_1:RecordAudio("413071060", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413071", "413071060", "story_v_out_413071.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413071", "413071060", "story_v_out_413071.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_20 and arg_261_1.time_ < var_264_10 + var_264_20 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413071061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413071061
		arg_265_1.duration_ = 2.9

		local var_265_0 = {
			zh = 1.999999999999,
			ja = 2.9
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413071062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10022"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10022 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10022", 3)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "split_2" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(0, -315, -320)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10022, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_268_7 = arg_265_1.actors_["10022"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps10022 == nil then
				arg_265_1.var_.actorSpriteComps10022 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 2

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps10022 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor1.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor1.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor1.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 1, var_268_10)

								iter_268_2.color = Color.New(var_268_14, var_268_14, var_268_14)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps10022 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10022 = nil
			end

			local var_268_15 = 0.8
			local var_268_16 = 1

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				local var_268_17 = "play"
				local var_268_18 = "effect"

				arg_265_1:AudioAction(var_268_17, var_268_18, "se_story_130", "se_story_130_noise", "")
			end

			local var_268_19 = 0
			local var_268_20 = 0.175

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_21 = arg_265_1:FormatText(StoryNameCfg[614].name)

				arg_265_1.leftNameTxt_.text = var_268_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_22 = arg_265_1:GetWordFromCfg(413071061)
				local var_268_23 = arg_265_1:FormatText(var_268_22.content)

				arg_265_1.text_.text = var_268_23

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_24 = 7
				local var_268_25 = utf8.len(var_268_23)
				local var_268_26 = var_268_24 <= 0 and var_268_20 or var_268_20 * (var_268_25 / var_268_24)

				if var_268_26 > 0 and var_268_20 < var_268_26 then
					arg_265_1.talkMaxDuration = var_268_26

					if var_268_26 + var_268_19 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_26 + var_268_19
					end
				end

				arg_265_1.text_.text = var_268_23
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071061", "story_v_out_413071.awb") ~= 0 then
					local var_268_27 = manager.audio:GetVoiceLength("story_v_out_413071", "413071061", "story_v_out_413071.awb") / 1000

					if var_268_27 + var_268_19 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_27 + var_268_19
					end

					if var_268_22.prefab_name ~= "" and arg_265_1.actors_[var_268_22.prefab_name] ~= nil then
						local var_268_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_22.prefab_name].transform, "story_v_out_413071", "413071061", "story_v_out_413071.awb")

						arg_265_1:RecordAudio("413071061", var_268_28)
						arg_265_1:RecordAudio("413071061", var_268_28)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_413071", "413071061", "story_v_out_413071.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_413071", "413071061", "story_v_out_413071.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_29 = math.max(var_268_20, arg_265_1.talkMaxDuration)

			if var_268_19 <= arg_265_1.time_ and arg_265_1.time_ < var_268_19 + var_268_29 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_19) / var_268_29

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_19 + var_268_29 and arg_265_1.time_ < var_268_19 + var_268_29 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play413071062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413071062
		arg_269_1.duration_ = 4.2

		local var_269_0 = {
			zh = 4.066,
			ja = 4.2
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
				arg_269_0:Play413071063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.325

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[614].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(413071062)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 13
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071062", "story_v_out_413071.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071062", "story_v_out_413071.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_413071", "413071062", "story_v_out_413071.awb")

						arg_269_1:RecordAudio("413071062", var_272_9)
						arg_269_1:RecordAudio("413071062", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413071", "413071062", "story_v_out_413071.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413071", "413071062", "story_v_out_413071.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play413071063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413071063
		arg_273_1.duration_ = 6.9

		local var_273_0 = {
			zh = 5.566,
			ja = 6.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play413071064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.725

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[614].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(413071063)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 29
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071063", "story_v_out_413071.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071063", "story_v_out_413071.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_413071", "413071063", "story_v_out_413071.awb")

						arg_273_1:RecordAudio("413071063", var_276_9)
						arg_273_1:RecordAudio("413071063", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413071", "413071063", "story_v_out_413071.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413071", "413071063", "story_v_out_413071.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play413071064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413071064
		arg_277_1.duration_ = 9

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play413071065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 2

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				local var_280_1 = manager.ui.mainCamera.transform.localPosition
				local var_280_2 = Vector3.New(0, 0, 10) + Vector3.New(var_280_1.x, var_280_1.y, 0)
				local var_280_3 = arg_277_1.bgs_.F08g

				var_280_3.transform.localPosition = var_280_2
				var_280_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_280_4 = var_280_3:GetComponent("SpriteRenderer")

				if var_280_4 and var_280_4.sprite then
					local var_280_5 = (var_280_3.transform.localPosition - var_280_1).z
					local var_280_6 = manager.ui.mainCameraCom_
					local var_280_7 = 2 * var_280_5 * Mathf.Tan(var_280_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_280_8 = var_280_7 * var_280_6.aspect
					local var_280_9 = var_280_4.sprite.bounds.size.x
					local var_280_10 = var_280_4.sprite.bounds.size.y
					local var_280_11 = var_280_8 / var_280_9
					local var_280_12 = var_280_7 / var_280_10
					local var_280_13 = var_280_12 < var_280_11 and var_280_11 or var_280_12

					var_280_3.transform.localScale = Vector3.New(var_280_13, var_280_13, 0)
				end

				for iter_280_0, iter_280_1 in pairs(arg_277_1.bgs_) do
					if iter_280_0 ~= "F08g" then
						iter_280_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_280_14 = 4

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			local var_280_15 = 0.3

			if arg_277_1.time_ >= var_280_14 + var_280_15 and arg_277_1.time_ < var_280_14 + var_280_15 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_17 = 2

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_17 then
				local var_280_18 = (arg_277_1.time_ - var_280_16) / var_280_17
				local var_280_19 = Color.New(0, 0, 0)

				var_280_19.a = Mathf.Lerp(0, 1, var_280_18)
				arg_277_1.mask_.color = var_280_19
			end

			if arg_277_1.time_ >= var_280_16 + var_280_17 and arg_277_1.time_ < var_280_16 + var_280_17 + arg_280_0 then
				local var_280_20 = Color.New(0, 0, 0)

				var_280_20.a = 1
				arg_277_1.mask_.color = var_280_20
			end

			local var_280_21 = 2

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_22 = 2

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_22 then
				local var_280_23 = (arg_277_1.time_ - var_280_21) / var_280_22
				local var_280_24 = Color.New(0, 0, 0)

				var_280_24.a = Mathf.Lerp(1, 0, var_280_23)
				arg_277_1.mask_.color = var_280_24
			end

			if arg_277_1.time_ >= var_280_21 + var_280_22 and arg_277_1.time_ < var_280_21 + var_280_22 + arg_280_0 then
				local var_280_25 = Color.New(0, 0, 0)
				local var_280_26 = 0

				arg_277_1.mask_.enabled = false
				var_280_25.a = var_280_26
				arg_277_1.mask_.color = var_280_25
			end

			local var_280_27 = arg_277_1.actors_["10022"].transform
			local var_280_28 = 1.966

			if var_280_28 < arg_277_1.time_ and arg_277_1.time_ <= var_280_28 + arg_280_0 then
				arg_277_1.var_.moveOldPos10022 = var_280_27.localPosition
				var_280_27.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10022", 0)

				local var_280_29 = var_280_27.childCount

				for iter_280_2 = 0, var_280_29 - 1 do
					local var_280_30 = var_280_27:GetChild(iter_280_2)

					if var_280_30.name == "" or not string.find(var_280_30.name, "split") then
						var_280_30.gameObject:SetActive(true)
					else
						var_280_30.gameObject:SetActive(false)
					end
				end
			end

			local var_280_31 = 0.001

			if var_280_28 <= arg_277_1.time_ and arg_277_1.time_ < var_280_28 + var_280_31 then
				local var_280_32 = (arg_277_1.time_ - var_280_28) / var_280_31
				local var_280_33 = Vector3.New(-5000, -315, -320)

				var_280_27.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10022, var_280_33, var_280_32)
			end

			if arg_277_1.time_ >= var_280_28 + var_280_31 and arg_277_1.time_ < var_280_28 + var_280_31 + arg_280_0 then
				var_280_27.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_280_34 = arg_277_1.actors_["10022"]
			local var_280_35 = 1.966

			if var_280_35 < arg_277_1.time_ and arg_277_1.time_ <= var_280_35 + arg_280_0 and not isNil(var_280_34) and arg_277_1.var_.actorSpriteComps10022 == nil then
				arg_277_1.var_.actorSpriteComps10022 = var_280_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_36 = 0.034

			if var_280_35 <= arg_277_1.time_ and arg_277_1.time_ < var_280_35 + var_280_36 and not isNil(var_280_34) then
				local var_280_37 = (arg_277_1.time_ - var_280_35) / var_280_36

				if arg_277_1.var_.actorSpriteComps10022 then
					for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_280_4 then
							if arg_277_1.isInRecall_ then
								local var_280_38 = Mathf.Lerp(iter_280_4.color.r, arg_277_1.hightColor2.r, var_280_37)
								local var_280_39 = Mathf.Lerp(iter_280_4.color.g, arg_277_1.hightColor2.g, var_280_37)
								local var_280_40 = Mathf.Lerp(iter_280_4.color.b, arg_277_1.hightColor2.b, var_280_37)

								iter_280_4.color = Color.New(var_280_38, var_280_39, var_280_40)
							else
								local var_280_41 = Mathf.Lerp(iter_280_4.color.r, 0.5, var_280_37)

								iter_280_4.color = Color.New(var_280_41, var_280_41, var_280_41)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_35 + var_280_36 and arg_277_1.time_ < var_280_35 + var_280_36 + arg_280_0 and not isNil(var_280_34) and arg_277_1.var_.actorSpriteComps10022 then
				for iter_280_5, iter_280_6 in pairs(arg_277_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_280_6 then
						if arg_277_1.isInRecall_ then
							iter_280_6.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10022 = nil
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_42 = 4
			local var_280_43 = 1.4

			if var_280_42 < arg_277_1.time_ and arg_277_1.time_ <= var_280_42 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_44 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_44:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_45 = arg_277_1:GetWordFromCfg(413071064)
				local var_280_46 = arg_277_1:FormatText(var_280_45.content)

				arg_277_1.text_.text = var_280_46

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_47 = 56
				local var_280_48 = utf8.len(var_280_46)
				local var_280_49 = var_280_47 <= 0 and var_280_43 or var_280_43 * (var_280_48 / var_280_47)

				if var_280_49 > 0 and var_280_43 < var_280_49 then
					arg_277_1.talkMaxDuration = var_280_49
					var_280_42 = var_280_42 + 0.3

					if var_280_49 + var_280_42 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_49 + var_280_42
					end
				end

				arg_277_1.text_.text = var_280_46
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_50 = var_280_42 + 0.3
			local var_280_51 = math.max(var_280_43, arg_277_1.talkMaxDuration)

			if var_280_50 <= arg_277_1.time_ and arg_277_1.time_ < var_280_50 + var_280_51 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_50) / var_280_51

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_50 + var_280_51 and arg_277_1.time_ < var_280_50 + var_280_51 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play413071065 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 413071065
		arg_283_1.duration_ = 4.87

		local var_283_0 = {
			zh = 4.866,
			ja = 3.566
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
				arg_283_0:Play413071066(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.2

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[992].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(413071065)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 8
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071065", "story_v_out_413071.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071065", "story_v_out_413071.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_413071", "413071065", "story_v_out_413071.awb")

						arg_283_1:RecordAudio("413071065", var_286_9)
						arg_283_1:RecordAudio("413071065", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_413071", "413071065", "story_v_out_413071.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_413071", "413071065", "story_v_out_413071.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play413071066 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413071066
		arg_287_1.duration_ = 3.7

		local var_287_0 = {
			zh = 1.999999999999,
			ja = 3.7
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
				arg_287_0:Play413071067(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10022"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10022 = var_290_0.localPosition
				var_290_0.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10022", 3)

				local var_290_2 = var_290_0.childCount

				for iter_290_0 = 0, var_290_2 - 1 do
					local var_290_3 = var_290_0:GetChild(iter_290_0)

					if var_290_3.name == "split_8" or not string.find(var_290_3.name, "split") then
						var_290_3.gameObject:SetActive(true)
					else
						var_290_3.gameObject:SetActive(false)
					end
				end
			end

			local var_290_4 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_4 then
				local var_290_5 = (arg_287_1.time_ - var_290_1) / var_290_4
				local var_290_6 = Vector3.New(0, -315, -320)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10022, var_290_6, var_290_5)
			end

			if arg_287_1.time_ >= var_290_1 + var_290_4 and arg_287_1.time_ < var_290_1 + var_290_4 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_290_7 = arg_287_1.actors_["10022"]
			local var_290_8 = 0

			if var_290_8 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 and not isNil(var_290_7) and arg_287_1.var_.actorSpriteComps10022 == nil then
				arg_287_1.var_.actorSpriteComps10022 = var_290_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_9 = 2

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_9 and not isNil(var_290_7) then
				local var_290_10 = (arg_287_1.time_ - var_290_8) / var_290_9

				if arg_287_1.var_.actorSpriteComps10022 then
					for iter_290_1, iter_290_2 in pairs(arg_287_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_290_2 then
							if arg_287_1.isInRecall_ then
								local var_290_11 = Mathf.Lerp(iter_290_2.color.r, arg_287_1.hightColor1.r, var_290_10)
								local var_290_12 = Mathf.Lerp(iter_290_2.color.g, arg_287_1.hightColor1.g, var_290_10)
								local var_290_13 = Mathf.Lerp(iter_290_2.color.b, arg_287_1.hightColor1.b, var_290_10)

								iter_290_2.color = Color.New(var_290_11, var_290_12, var_290_13)
							else
								local var_290_14 = Mathf.Lerp(iter_290_2.color.r, 1, var_290_10)

								iter_290_2.color = Color.New(var_290_14, var_290_14, var_290_14)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_8 + var_290_9 and arg_287_1.time_ < var_290_8 + var_290_9 + arg_290_0 and not isNil(var_290_7) and arg_287_1.var_.actorSpriteComps10022 then
				for iter_290_3, iter_290_4 in pairs(arg_287_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_290_4 then
						if arg_287_1.isInRecall_ then
							iter_290_4.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10022 = nil
			end

			local var_290_15 = 0
			local var_290_16 = 0.225

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[614].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(413071066)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 9
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071066", "story_v_out_413071.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071066", "story_v_out_413071.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_413071", "413071066", "story_v_out_413071.awb")

						arg_287_1:RecordAudio("413071066", var_290_24)
						arg_287_1:RecordAudio("413071066", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_413071", "413071066", "story_v_out_413071.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_413071", "413071066", "story_v_out_413071.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play413071067 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413071067
		arg_291_1.duration_ = 7.27

		local var_291_0 = {
			zh = 3.533,
			ja = 7.266
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play413071068(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10022"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10022 == nil then
				arg_291_1.var_.actorSpriteComps10022 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps10022 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 0.5, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10022 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10022 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.3

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_10 = arg_291_1:FormatText(StoryNameCfg[992].name)

				arg_291_1.leftNameTxt_.text = var_294_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_11 = arg_291_1:GetWordFromCfg(413071067)
				local var_294_12 = arg_291_1:FormatText(var_294_11.content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 12
				local var_294_14 = utf8.len(var_294_12)
				local var_294_15 = var_294_13 <= 0 and var_294_9 or var_294_9 * (var_294_14 / var_294_13)

				if var_294_15 > 0 and var_294_9 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071067", "story_v_out_413071.awb") ~= 0 then
					local var_294_16 = manager.audio:GetVoiceLength("story_v_out_413071", "413071067", "story_v_out_413071.awb") / 1000

					if var_294_16 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_16 + var_294_8
					end

					if var_294_11.prefab_name ~= "" and arg_291_1.actors_[var_294_11.prefab_name] ~= nil then
						local var_294_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_11.prefab_name].transform, "story_v_out_413071", "413071067", "story_v_out_413071.awb")

						arg_291_1:RecordAudio("413071067", var_294_17)
						arg_291_1:RecordAudio("413071067", var_294_17)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413071", "413071067", "story_v_out_413071.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413071", "413071067", "story_v_out_413071.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_18 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_18 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_18

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_18 and arg_291_1.time_ < var_294_8 + var_294_18 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play413071068 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413071068
		arg_295_1.duration_ = 5

		local var_295_0 = {
			zh = 5,
			ja = 3.066
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play413071069(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				local var_298_2 = "play"
				local var_298_3 = "effect"

				arg_295_1:AudioAction(var_298_2, var_298_3, "se_story_129", "se_story_129_break", "")
			end

			local var_298_4 = 0
			local var_298_5 = 0.15

			if var_298_4 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_6 = arg_295_1:FormatText(StoryNameCfg[36].name)

				arg_295_1.leftNameTxt_.text = var_298_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_7 = arg_295_1:GetWordFromCfg(413071068)
				local var_298_8 = arg_295_1:FormatText(var_298_7.content)

				arg_295_1.text_.text = var_298_8

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 6
				local var_298_10 = utf8.len(var_298_8)
				local var_298_11 = var_298_9 <= 0 and var_298_5 or var_298_5 * (var_298_10 / var_298_9)

				if var_298_11 > 0 and var_298_5 < var_298_11 then
					arg_295_1.talkMaxDuration = var_298_11

					if var_298_11 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_8
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071068", "story_v_out_413071.awb") ~= 0 then
					local var_298_12 = manager.audio:GetVoiceLength("story_v_out_413071", "413071068", "story_v_out_413071.awb") / 1000

					if var_298_12 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_4
					end

					if var_298_7.prefab_name ~= "" and arg_295_1.actors_[var_298_7.prefab_name] ~= nil then
						local var_298_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_7.prefab_name].transform, "story_v_out_413071", "413071068", "story_v_out_413071.awb")

						arg_295_1:RecordAudio("413071068", var_298_13)
						arg_295_1:RecordAudio("413071068", var_298_13)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413071", "413071068", "story_v_out_413071.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413071", "413071068", "story_v_out_413071.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_14 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_14 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_14

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_14 and arg_295_1.time_ < var_298_4 + var_298_14 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play413071069 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413071069
		arg_299_1.duration_ = 3.57

		local var_299_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_299_0:Play413071070(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10022"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos10022 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10022", 3)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "split_6" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(0, -315, -320)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10022, var_302_6, var_302_5)
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_302_7 = arg_299_1.actors_["10022"]
			local var_302_8 = 0

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps10022 == nil then
				arg_299_1.var_.actorSpriteComps10022 = var_302_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_9 = 2

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 and not isNil(var_302_7) then
				local var_302_10 = (arg_299_1.time_ - var_302_8) / var_302_9

				if arg_299_1.var_.actorSpriteComps10022 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								local var_302_11 = Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, var_302_10)
								local var_302_12 = Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, var_302_10)
								local var_302_13 = Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, var_302_10)

								iter_302_2.color = Color.New(var_302_11, var_302_12, var_302_13)
							else
								local var_302_14 = Mathf.Lerp(iter_302_2.color.r, 1, var_302_10)

								iter_302_2.color = Color.New(var_302_14, var_302_14, var_302_14)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps10022 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_302_4 then
						if arg_299_1.isInRecall_ then
							iter_302_4.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10022 = nil
			end

			local var_302_15 = 0
			local var_302_16 = 0.2

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[614].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(413071069)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 8
				local var_302_21 = utf8.len(var_302_19)
				local var_302_22 = var_302_20 <= 0 and var_302_16 or var_302_16 * (var_302_21 / var_302_20)

				if var_302_22 > 0 and var_302_16 < var_302_22 then
					arg_299_1.talkMaxDuration = var_302_22

					if var_302_22 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_22 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_19
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071069", "story_v_out_413071.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_413071", "413071069", "story_v_out_413071.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_413071", "413071069", "story_v_out_413071.awb")

						arg_299_1:RecordAudio("413071069", var_302_24)
						arg_299_1:RecordAudio("413071069", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413071", "413071069", "story_v_out_413071.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413071", "413071069", "story_v_out_413071.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_25 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_25 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_25

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_25 and arg_299_1.time_ < var_302_15 + var_302_25 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play413071070 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413071070
		arg_303_1.duration_ = 3.7

		local var_303_0 = {
			zh = 3.7,
			ja = 2.366
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play413071071(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.4

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[614].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(413071070)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 16
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071070", "story_v_out_413071.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071070", "story_v_out_413071.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_413071", "413071070", "story_v_out_413071.awb")

						arg_303_1:RecordAudio("413071070", var_306_9)
						arg_303_1:RecordAudio("413071070", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413071", "413071070", "story_v_out_413071.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413071", "413071070", "story_v_out_413071.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play413071071 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413071071
		arg_307_1.duration_ = 6.57

		local var_307_0 = {
			zh = 4.366,
			ja = 6.566
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
			arg_307_1.auto_ = false
		end

		function arg_307_1.playNext_(arg_309_0)
			arg_307_1.onStoryFinished_()
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.45

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[614].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:GetWordFromCfg(413071071)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 18
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413071", "413071071", "story_v_out_413071.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_413071", "413071071", "story_v_out_413071.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_413071", "413071071", "story_v_out_413071.awb")

						arg_307_1:RecordAudio("413071071", var_310_9)
						arg_307_1:RecordAudio("413071071", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413071", "413071071", "story_v_out_413071.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413071", "413071071", "story_v_out_413071.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/SS1305",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F08g"
	},
	voices = {
		"story_v_out_413071.awb"
	}
}
