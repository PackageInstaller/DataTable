return {
	Play424101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11o"

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
				local var_4_5 = arg_1_1.bgs_.I11o

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
					if iter_4_0 ~= "I11o" then
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
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_30 = 0.433333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.3
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 1.25

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(424101001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 50
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.2

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(424101002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 8
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play424101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424101003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 3.3,
			ja = 4.3
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10153"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

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

			local var_16_4 = arg_13_1.actors_["10153"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10153 == nil then
				arg_13_1.var_.actorSpriteComps10153 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps10153 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10153 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10153 = nil
			end

			local var_16_12 = arg_13_1.actors_["10153"].transform
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.var_.moveOldPos10153 = var_16_12.localPosition
				var_16_12.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10153", 3)

				local var_16_14 = var_16_12.childCount

				for iter_16_6 = 0, var_16_14 - 1 do
					local var_16_15 = var_16_12:GetChild(iter_16_6)

					if var_16_15.name == "" or not string.find(var_16_15.name, "split") then
						var_16_15.gameObject:SetActive(true)
					else
						var_16_15.gameObject:SetActive(false)
					end
				end
			end

			local var_16_16 = 0.001

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_16 then
				local var_16_17 = (arg_13_1.time_ - var_16_13) / var_16_16
				local var_16_18 = Vector3.New(-60, -395, -330)

				var_16_12.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10153, var_16_18, var_16_17)
			end

			if arg_13_1.time_ >= var_16_13 + var_16_16 and arg_13_1.time_ < var_16_13 + var_16_16 + arg_16_0 then
				var_16_12.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_16_19 = arg_13_1.actors_["10153"]
			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				local var_16_21 = var_16_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_21 then
					arg_13_1.var_.alphaOldValue10153 = var_16_21.alpha
					arg_13_1.var_.characterEffect10153 = var_16_21
				end

				arg_13_1.var_.alphaOldValue10153 = 0
			end

			local var_16_22 = 0.5

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_20) / var_16_22
				local var_16_24 = Mathf.Lerp(arg_13_1.var_.alphaOldValue10153, 1, var_16_23)

				if arg_13_1.var_.characterEffect10153 then
					arg_13_1.var_.characterEffect10153.alpha = var_16_24
				end
			end

			if arg_13_1.time_ >= var_16_20 + var_16_22 and arg_13_1.time_ < var_16_20 + var_16_22 + arg_16_0 and arg_13_1.var_.characterEffect10153 then
				arg_13_1.var_.characterEffect10153.alpha = 1
			end

			local var_16_25 = 0
			local var_16_26 = 0.35

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_27 = arg_13_1:FormatText(StoryNameCfg[1387].name)

				arg_13_1.leftNameTxt_.text = var_16_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_28 = arg_13_1:GetWordFromCfg(424101003)
				local var_16_29 = arg_13_1:FormatText(var_16_28.content)

				arg_13_1.text_.text = var_16_29

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_30 = 14
				local var_16_31 = utf8.len(var_16_29)
				local var_16_32 = var_16_30 <= 0 and var_16_26 or var_16_26 * (var_16_31 / var_16_30)

				if var_16_32 > 0 and var_16_26 < var_16_32 then
					arg_13_1.talkMaxDuration = var_16_32

					if var_16_32 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_29
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101003", "story_v_out_424101.awb") ~= 0 then
					local var_16_33 = manager.audio:GetVoiceLength("story_v_out_424101", "424101003", "story_v_out_424101.awb") / 1000

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end

					if var_16_28.prefab_name ~= "" and arg_13_1.actors_[var_16_28.prefab_name] ~= nil then
						local var_16_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_28.prefab_name].transform, "story_v_out_424101", "424101003", "story_v_out_424101.awb")

						arg_13_1:RecordAudio("424101003", var_16_34)
						arg_13_1:RecordAudio("424101003", var_16_34)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_424101", "424101003", "story_v_out_424101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_424101", "424101003", "story_v_out_424101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_25 <= arg_13_1.time_ and arg_13_1.time_ < var_16_25 + var_16_35 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_25) / var_16_35

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_25 + var_16_35 and arg_13_1.time_ < var_16_25 + var_16_35 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10153"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10153 == nil then
				arg_17_1.var_.actorSpriteComps10153 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10153 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10153 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10153 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 1.525

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_10

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

				local var_20_11 = arg_17_1:GetWordFromCfg(424101004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 61
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_9 or var_20_9 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_9 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424101005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play424101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.2

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(424101005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 8
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play424101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play424101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10153"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10153 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10153", 7)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(0, -2000, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10153, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_7 = 0
			local var_28_8 = 1.225

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(424101006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 49
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_8 or var_28_8 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_8 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_14 and arg_25_1.time_ < var_28_7 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play424101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play424101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.35

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(424101007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 14
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play424101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424101008
		arg_33_1.duration_ = 1.87

		local var_33_0 = {
			zh = 1.266,
			ja = 1.866
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
				arg_33_0:Play424101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.125

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1394].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(424101008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 5
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101008", "story_v_out_424101.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101008", "story_v_out_424101.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_424101", "424101008", "story_v_out_424101.awb")

						arg_33_1:RecordAudio("424101008", var_36_9)
						arg_33_1:RecordAudio("424101008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_424101", "424101008", "story_v_out_424101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_424101", "424101008", "story_v_out_424101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play424101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424101009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play424101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.25

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(424101009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 50
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play424101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424101010
		arg_41_1.duration_ = 4.67

		local var_41_0 = {
			zh = 4.666,
			ja = 2.766
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
				arg_41_0:Play424101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.25

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1394].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(424101010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 10
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101010", "story_v_out_424101.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101010", "story_v_out_424101.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_424101", "424101010", "story_v_out_424101.awb")

						arg_41_1:RecordAudio("424101010", var_44_9)
						arg_41_1:RecordAudio("424101010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_424101", "424101010", "story_v_out_424101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_424101", "424101010", "story_v_out_424101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play424101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424101011
		arg_45_1.duration_ = 12.97

		local var_45_0 = {
			zh = 7.4,
			ja = 12.966
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
				arg_45_0:Play424101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.9

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1393].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(424101011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 36
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101011", "story_v_out_424101.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101011", "story_v_out_424101.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_424101", "424101011", "story_v_out_424101.awb")

						arg_45_1:RecordAudio("424101011", var_48_9)
						arg_45_1:RecordAudio("424101011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424101", "424101011", "story_v_out_424101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424101", "424101011", "story_v_out_424101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play424101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424101012
		arg_49_1.duration_ = 5.6

		local var_49_0 = {
			zh = 4.8,
			ja = 5.6
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
				arg_49_0:Play424101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "1094"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(var_52_1, arg_49_1.canvasGo_.transform)

					var_52_2.transform:SetSiblingIndex(1)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_49_1.isInRecall_ then
						for iter_52_0, iter_52_1 in ipairs(var_52_3) do
							iter_52_1.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_4 = arg_49_1.actors_["1094"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps1094 == nil then
				arg_49_1.var_.actorSpriteComps1094 = var_52_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.actorSpriteComps1094 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_8 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor1.r, var_52_7)
								local var_52_9 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor1.g, var_52_7)
								local var_52_10 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor1.b, var_52_7)

								iter_52_3.color = Color.New(var_52_8, var_52_9, var_52_10)
							else
								local var_52_11 = Mathf.Lerp(iter_52_3.color.r, 1, var_52_7)

								iter_52_3.color = Color.New(var_52_11, var_52_11, var_52_11)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps1094 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1094 = nil
			end

			local var_52_12 = arg_49_1.actors_["1094"].transform
			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1.var_.moveOldPos1094 = var_52_12.localPosition
				var_52_12.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1094", 3)

				local var_52_14 = var_52_12.childCount

				for iter_52_6 = 0, var_52_14 - 1 do
					local var_52_15 = var_52_12:GetChild(iter_52_6)

					if var_52_15.name == "split_4" or not string.find(var_52_15.name, "split") then
						var_52_15.gameObject:SetActive(true)
					else
						var_52_15.gameObject:SetActive(false)
					end
				end
			end

			local var_52_16 = 0.001

			if var_52_13 <= arg_49_1.time_ and arg_49_1.time_ < var_52_13 + var_52_16 then
				local var_52_17 = (arg_49_1.time_ - var_52_13) / var_52_16
				local var_52_18 = Vector3.New(0, -335, -230)

				var_52_12.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1094, var_52_18, var_52_17)
			end

			if arg_49_1.time_ >= var_52_13 + var_52_16 and arg_49_1.time_ < var_52_13 + var_52_16 + arg_52_0 then
				var_52_12.localPosition = Vector3.New(0, -335, -230)
			end

			local var_52_19 = 0
			local var_52_20 = 0.325

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_21 = arg_49_1:FormatText(StoryNameCfg[181].name)

				arg_49_1.leftNameTxt_.text = var_52_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_22 = arg_49_1:GetWordFromCfg(424101012)
				local var_52_23 = arg_49_1:FormatText(var_52_22.content)

				arg_49_1.text_.text = var_52_23

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_24 = 13
				local var_52_25 = utf8.len(var_52_23)
				local var_52_26 = var_52_24 <= 0 and var_52_20 or var_52_20 * (var_52_25 / var_52_24)

				if var_52_26 > 0 and var_52_20 < var_52_26 then
					arg_49_1.talkMaxDuration = var_52_26

					if var_52_26 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_26 + var_52_19
					end
				end

				arg_49_1.text_.text = var_52_23
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101012", "story_v_out_424101.awb") ~= 0 then
					local var_52_27 = manager.audio:GetVoiceLength("story_v_out_424101", "424101012", "story_v_out_424101.awb") / 1000

					if var_52_27 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_27 + var_52_19
					end

					if var_52_22.prefab_name ~= "" and arg_49_1.actors_[var_52_22.prefab_name] ~= nil then
						local var_52_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_22.prefab_name].transform, "story_v_out_424101", "424101012", "story_v_out_424101.awb")

						arg_49_1:RecordAudio("424101012", var_52_28)
						arg_49_1:RecordAudio("424101012", var_52_28)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_424101", "424101012", "story_v_out_424101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_424101", "424101012", "story_v_out_424101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_29 = math.max(var_52_20, arg_49_1.talkMaxDuration)

			if var_52_19 <= arg_49_1.time_ and arg_49_1.time_ < var_52_19 + var_52_29 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_19) / var_52_29

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_19 + var_52_29 and arg_49_1.time_ < var_52_19 + var_52_29 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play424101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424101013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play424101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1094"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1094 == nil then
				arg_53_1.var_.actorSpriteComps1094 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1094 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1094 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1094 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.6

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_10 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_10

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

				local var_56_11 = arg_53_1:GetWordFromCfg(424101013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 24
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_9 or var_56_9 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_9 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play424101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424101014
		arg_57_1.duration_ = 10.87

		local var_57_0 = {
			zh = 9.666,
			ja = 10.866
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
				arg_57_0:Play424101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.05

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1394].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(424101014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 42
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101014", "story_v_out_424101.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101014", "story_v_out_424101.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_424101", "424101014", "story_v_out_424101.awb")

						arg_57_1:RecordAudio("424101014", var_60_9)
						arg_57_1:RecordAudio("424101014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_424101", "424101014", "story_v_out_424101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_424101", "424101014", "story_v_out_424101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play424101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424101015
		arg_61_1.duration_ = 5.53

		local var_61_0 = {
			zh = 5.533,
			ja = 4.633
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
				arg_61_0:Play424101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1094"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1094 == nil then
				arg_61_1.var_.actorSpriteComps1094 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps1094 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps1094 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1094 = nil
			end

			local var_64_8 = arg_61_1.actors_["1094"].transform
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.var_.moveOldPos1094 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1094", 3)

				local var_64_10 = var_64_8.childCount

				for iter_64_4 = 0, var_64_10 - 1 do
					local var_64_11 = var_64_8:GetChild(iter_64_4)

					if var_64_11.name == "split_4" then
						var_64_11:SetAsLastSibling()
						var_64_11.gameObject:SetActive(true)

						arg_61_1.var_.actorSpriteSplit1094 = var_64_11.gameObject:GetComponent(typeof(Image))

						arg_61_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_64_12 = 0.5

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_12 then
				local var_64_13 = (arg_61_1.time_ - var_64_9) / var_64_12
				local var_64_14 = Vector3.New(0, -335, -230)

				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1094, var_64_14, var_64_13)

				if arg_61_1.var_.actorSpriteSplit1094 ~= nil then
					arg_61_1.var_.actorSpriteSplit1094:SetAlpha(var_64_13)
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_12 and arg_61_1.time_ < var_64_9 + var_64_12 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(0, -335, -230)

				if arg_61_1.var_.actorSpriteSplit1094 ~= nil then
					arg_61_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_64_15 = 0
			local var_64_16 = 0.4

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[181].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(424101015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 16
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101015", "story_v_out_424101.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101015", "story_v_out_424101.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_424101", "424101015", "story_v_out_424101.awb")

						arg_61_1:RecordAudio("424101015", var_64_24)
						arg_61_1:RecordAudio("424101015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424101", "424101015", "story_v_out_424101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424101", "424101015", "story_v_out_424101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play424101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424101016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play424101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1094"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1094 == nil then
				arg_65_1.var_.actorSpriteComps1094 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1094 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1094 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1094 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.8

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_10

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

				local var_68_11 = arg_65_1:GetWordFromCfg(424101016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 32
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_9 or var_68_9 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_9 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play424101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424101017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play424101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.1
			local var_72_1 = 1

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				local var_72_2 = "play"
				local var_72_3 = "effect"

				arg_69_1:AudioAction(var_72_2, var_72_3, "se_story_134_01", "se_story_134_01_paper", "")
			end

			local var_72_4 = 0
			local var_72_5 = 0.9

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(424101017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 36
				local var_72_9 = utf8.len(var_72_7)
				local var_72_10 = var_72_8 <= 0 and var_72_5 or var_72_5 * (var_72_9 / var_72_8)

				if var_72_10 > 0 and var_72_5 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_11 and arg_69_1.time_ < var_72_4 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play424101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424101018
		arg_73_1.duration_ = 4.97

		local var_73_0 = {
			zh = 4.7,
			ja = 4.966
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
				arg_73_0:Play424101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1094"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1094 == nil then
				arg_73_1.var_.actorSpriteComps1094 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps1094 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps1094 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1094 = nil
			end

			local var_76_8 = arg_73_1.actors_["1094"].transform
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.var_.moveOldPos1094 = var_76_8.localPosition
				var_76_8.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1094", 3)

				local var_76_10 = var_76_8.childCount

				for iter_76_4 = 0, var_76_10 - 1 do
					local var_76_11 = var_76_8:GetChild(iter_76_4)

					if var_76_11.name == "split_2" then
						var_76_11:SetAsLastSibling()
						var_76_11.gameObject:SetActive(true)

						arg_73_1.var_.actorSpriteSplit1094 = var_76_11.gameObject:GetComponent(typeof(Image))

						arg_73_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_76_12 = 0.5

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_9) / var_76_12
				local var_76_14 = Vector3.New(0, -335, -230)

				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1094, var_76_14, var_76_13)

				if arg_73_1.var_.actorSpriteSplit1094 ~= nil then
					arg_73_1.var_.actorSpriteSplit1094:SetAlpha(var_76_13)
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_12 and arg_73_1.time_ < var_76_9 + var_76_12 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, -335, -230)

				if arg_73_1.var_.actorSpriteSplit1094 ~= nil then
					arg_73_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_76_15 = 0
			local var_76_16 = 0.475

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[181].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(424101018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 19
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101018", "story_v_out_424101.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101018", "story_v_out_424101.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_424101", "424101018", "story_v_out_424101.awb")

						arg_73_1:RecordAudio("424101018", var_76_24)
						arg_73_1:RecordAudio("424101018", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_424101", "424101018", "story_v_out_424101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_424101", "424101018", "story_v_out_424101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_25 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_25 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_25

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_25 and arg_73_1.time_ < var_76_15 + var_76_25 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play424101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424101019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play424101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1094"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1094 == nil then
				arg_77_1.var_.actorSpriteComps1094 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1094 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1094 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1094 = nil
			end

			local var_80_8 = arg_77_1.actors_["1094"].transform
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 then
				arg_77_1.var_.moveOldPos1094 = var_80_8.localPosition
				var_80_8.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1094", 7)

				local var_80_10 = var_80_8.childCount

				for iter_80_4 = 0, var_80_10 - 1 do
					local var_80_11 = var_80_8:GetChild(iter_80_4)

					if var_80_11.name == "" or not string.find(var_80_11.name, "split") then
						var_80_11.gameObject:SetActive(true)
					else
						var_80_11.gameObject:SetActive(false)
					end
				end
			end

			local var_80_12 = 0.001

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_12 then
				local var_80_13 = (arg_77_1.time_ - var_80_9) / var_80_12
				local var_80_14 = Vector3.New(0, -2000, 0)

				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1094, var_80_14, var_80_13)
			end

			if arg_77_1.time_ >= var_80_9 + var_80_12 and arg_77_1.time_ < var_80_9 + var_80_12 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_15 = 0
			local var_80_16 = 0.975

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_17 = arg_77_1:GetWordFromCfg(424101019)
				local var_80_18 = arg_77_1:FormatText(var_80_17.content)

				arg_77_1.text_.text = var_80_18

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_19 = 39
				local var_80_20 = utf8.len(var_80_18)
				local var_80_21 = var_80_19 <= 0 and var_80_16 or var_80_16 * (var_80_20 / var_80_19)

				if var_80_21 > 0 and var_80_16 < var_80_21 then
					arg_77_1.talkMaxDuration = var_80_21

					if var_80_21 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_21 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_18
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_22 and arg_77_1.time_ < var_80_15 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424101020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play424101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.55

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(424101020)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 62
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play424101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424101021
		arg_85_1.duration_ = 1.1

		local var_85_0 = {
			zh = 1.1,
			ja = 1.066
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
				arg_85_0:Play424101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1094"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1094 == nil then
				arg_85_1.var_.actorSpriteComps1094 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1094 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1094 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1094 = nil
			end

			local var_88_8 = arg_85_1.actors_["1094"].transform
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.var_.moveOldPos1094 = var_88_8.localPosition
				var_88_8.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1094", 3)

				local var_88_10 = var_88_8.childCount

				for iter_88_4 = 0, var_88_10 - 1 do
					local var_88_11 = var_88_8:GetChild(iter_88_4)

					if var_88_11.name == "split_1" then
						var_88_11:SetAsLastSibling()
						var_88_11.gameObject:SetActive(true)

						arg_85_1.var_.actorSpriteSplit1094 = var_88_11.gameObject:GetComponent(typeof(Image))

						arg_85_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_88_12 = 0.001

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_9) / var_88_12
				local var_88_14 = Vector3.New(0, -335, -230)

				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1094, var_88_14, var_88_13)

				if arg_85_1.var_.actorSpriteSplit1094 ~= nil then
					arg_85_1.var_.actorSpriteSplit1094:SetAlpha(var_88_13)
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_12 and arg_85_1.time_ < var_88_9 + var_88_12 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(0, -335, -230)

				if arg_85_1.var_.actorSpriteSplit1094 ~= nil then
					arg_85_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_88_15 = 0
			local var_88_16 = 0.125

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[181].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(424101021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 5
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101021", "story_v_out_424101.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101021", "story_v_out_424101.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_424101", "424101021", "story_v_out_424101.awb")

						arg_85_1:RecordAudio("424101021", var_88_24)
						arg_85_1:RecordAudio("424101021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_424101", "424101021", "story_v_out_424101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_424101", "424101021", "story_v_out_424101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play424101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424101022
		arg_89_1.duration_ = 6.1

		local var_89_0 = {
			zh = 5.1,
			ja = 6.1
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
				arg_89_0:Play424101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1094"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1094 == nil then
				arg_89_1.var_.actorSpriteComps1094 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps1094 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor2.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor2.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor2.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 0.5, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps1094 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps1094 = nil
			end

			local var_92_8 = 0
			local var_92_9 = 0.5

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_10 = arg_89_1:FormatText(StoryNameCfg[1394].name)

				arg_89_1.leftNameTxt_.text = var_92_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_11 = arg_89_1:GetWordFromCfg(424101022)
				local var_92_12 = arg_89_1:FormatText(var_92_11.content)

				arg_89_1.text_.text = var_92_12

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 20
				local var_92_14 = utf8.len(var_92_12)
				local var_92_15 = var_92_13 <= 0 and var_92_9 or var_92_9 * (var_92_14 / var_92_13)

				if var_92_15 > 0 and var_92_9 < var_92_15 then
					arg_89_1.talkMaxDuration = var_92_15

					if var_92_15 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_15 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_12
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101022", "story_v_out_424101.awb") ~= 0 then
					local var_92_16 = manager.audio:GetVoiceLength("story_v_out_424101", "424101022", "story_v_out_424101.awb") / 1000

					if var_92_16 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_8
					end

					if var_92_11.prefab_name ~= "" and arg_89_1.actors_[var_92_11.prefab_name] ~= nil then
						local var_92_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_11.prefab_name].transform, "story_v_out_424101", "424101022", "story_v_out_424101.awb")

						arg_89_1:RecordAudio("424101022", var_92_17)
						arg_89_1:RecordAudio("424101022", var_92_17)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424101", "424101022", "story_v_out_424101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424101", "424101022", "story_v_out_424101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_18 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_18 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_18

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_18 and arg_89_1.time_ < var_92_8 + var_92_18 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play424101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424101023
		arg_93_1.duration_ = 7.3

		local var_93_0 = {
			zh = 5.766,
			ja = 7.3
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
				arg_93_0:Play424101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.7

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1393].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(424101023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101023", "story_v_out_424101.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101023", "story_v_out_424101.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_424101", "424101023", "story_v_out_424101.awb")

						arg_93_1:RecordAudio("424101023", var_96_9)
						arg_93_1:RecordAudio("424101023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_424101", "424101023", "story_v_out_424101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_424101", "424101023", "story_v_out_424101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play424101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424101024
		arg_97_1.duration_ = 2.93

		local var_97_0 = {
			zh = 2.933,
			ja = 2.6
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
				arg_97_0:Play424101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1094"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 3)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_2" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -335, -230)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -335, -230)
			end

			local var_100_7 = arg_97_1.actors_["1094"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1094 == nil then
				arg_97_1.var_.actorSpriteComps1094 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps1094 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								local var_100_11 = Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, var_100_10)
								local var_100_12 = Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, var_100_10)
								local var_100_13 = Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, var_100_10)

								iter_100_2.color = Color.New(var_100_11, var_100_12, var_100_13)
							else
								local var_100_14 = Mathf.Lerp(iter_100_2.color.r, 1, var_100_10)

								iter_100_2.color = Color.New(var_100_14, var_100_14, var_100_14)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1094 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1094 = nil
			end

			local var_100_15 = 0
			local var_100_16 = 0.175

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[1408].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_18 = arg_97_1:GetWordFromCfg(424101024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 7
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101024", "story_v_out_424101.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101024", "story_v_out_424101.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_424101", "424101024", "story_v_out_424101.awb")

						arg_97_1:RecordAudio("424101024", var_100_24)
						arg_97_1:RecordAudio("424101024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_424101", "424101024", "story_v_out_424101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_424101", "424101024", "story_v_out_424101.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play424101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424101025
		arg_101_1.duration_ = 9

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play424101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "I18d"

			if arg_101_1.bgs_[var_104_0] == nil then
				local var_104_1 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_104_0)
				var_104_1.name = var_104_0
				var_104_1.transform.parent = arg_101_1.stage_.transform
				var_104_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_[var_104_0] = var_104_1
			end

			local var_104_2 = 2

			if var_104_2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				local var_104_3 = manager.ui.mainCamera.transform.localPosition
				local var_104_4 = Vector3.New(0, 0, 10) + Vector3.New(var_104_3.x, var_104_3.y, 0)
				local var_104_5 = arg_101_1.bgs_.I18d

				var_104_5.transform.localPosition = var_104_4
				var_104_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_6 = var_104_5:GetComponent("SpriteRenderer")

				if var_104_6 and var_104_6.sprite then
					local var_104_7 = (var_104_5.transform.localPosition - var_104_3).z
					local var_104_8 = manager.ui.mainCameraCom_
					local var_104_9 = 2 * var_104_7 * Mathf.Tan(var_104_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_10 = var_104_9 * var_104_8.aspect
					local var_104_11 = var_104_6.sprite.bounds.size.x
					local var_104_12 = var_104_6.sprite.bounds.size.y
					local var_104_13 = var_104_10 / var_104_11
					local var_104_14 = var_104_9 / var_104_12
					local var_104_15 = var_104_14 < var_104_13 and var_104_13 or var_104_14

					var_104_5.transform.localScale = Vector3.New(var_104_15, var_104_15, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "I18d" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_16 = 4

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_17 = 0.3

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_18 = 0

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_19 = 2

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_18) / var_104_19
				local var_104_21 = Color.New(0, 0, 0)

				var_104_21.a = Mathf.Lerp(0, 1, var_104_20)
				arg_101_1.mask_.color = var_104_21
			end

			if arg_101_1.time_ >= var_104_18 + var_104_19 and arg_101_1.time_ < var_104_18 + var_104_19 + arg_104_0 then
				local var_104_22 = Color.New(0, 0, 0)

				var_104_22.a = 1
				arg_101_1.mask_.color = var_104_22
			end

			local var_104_23 = 2

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_24 = 2

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24
				local var_104_26 = Color.New(0, 0, 0)

				var_104_26.a = Mathf.Lerp(1, 0, var_104_25)
				arg_101_1.mask_.color = var_104_26
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 then
				local var_104_27 = Color.New(0, 0, 0)
				local var_104_28 = 0

				arg_101_1.mask_.enabled = false
				var_104_27.a = var_104_28
				arg_101_1.mask_.color = var_104_27
			end

			local var_104_29 = arg_101_1.actors_["1094"].transform
			local var_104_30 = 1.966

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.var_.moveOldPos1094 = var_104_29.localPosition
				var_104_29.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1094", 7)

				local var_104_31 = var_104_29.childCount

				for iter_104_2 = 0, var_104_31 - 1 do
					local var_104_32 = var_104_29:GetChild(iter_104_2)

					if var_104_32.name == "" or not string.find(var_104_32.name, "split") then
						var_104_32.gameObject:SetActive(true)
					else
						var_104_32.gameObject:SetActive(false)
					end
				end
			end

			local var_104_33 = 0.001

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_33 then
				local var_104_34 = (arg_101_1.time_ - var_104_30) / var_104_33
				local var_104_35 = Vector3.New(0, -2000, 0)

				var_104_29.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1094, var_104_35, var_104_34)
			end

			if arg_101_1.time_ >= var_104_30 + var_104_33 and arg_101_1.time_ < var_104_30 + var_104_33 + arg_104_0 then
				var_104_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_104_36 = 0.2
			local var_104_37 = 1

			if var_104_36 < arg_101_1.time_ and arg_101_1.time_ <= var_104_36 + arg_104_0 then
				local var_104_38 = "stop"
				local var_104_39 = "effect"

				arg_101_1:AudioAction(var_104_38, var_104_39, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_104_40 = 1.73333333333333
			local var_104_41 = 1

			if var_104_40 < arg_101_1.time_ and arg_101_1.time_ <= var_104_40 + arg_104_0 then
				local var_104_42 = "play"
				local var_104_43 = "effect"

				arg_101_1:AudioAction(var_104_42, var_104_43, "se_story_140", "se_story_140_amb_street", "")
			end

			local var_104_44 = 4.1
			local var_104_45 = 1

			if var_104_44 < arg_101_1.time_ and arg_101_1.time_ <= var_104_44 + arg_104_0 then
				local var_104_46 = "play"
				local var_104_47 = "effect"

				arg_101_1:AudioAction(var_104_46, var_104_47, "minigame_activity_4_0", "minigame_activity_4_0_pintu_walk04", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_48 = 4
			local var_104_49 = 1.225

			if var_104_48 < arg_101_1.time_ and arg_101_1.time_ <= var_104_48 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_50 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_50:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_51 = arg_101_1:GetWordFromCfg(424101025)
				local var_104_52 = arg_101_1:FormatText(var_104_51.content)

				arg_101_1.text_.text = var_104_52

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_53 = 49
				local var_104_54 = utf8.len(var_104_52)
				local var_104_55 = var_104_53 <= 0 and var_104_49 or var_104_49 * (var_104_54 / var_104_53)

				if var_104_55 > 0 and var_104_49 < var_104_55 then
					arg_101_1.talkMaxDuration = var_104_55
					var_104_48 = var_104_48 + 0.3

					if var_104_55 + var_104_48 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_55 + var_104_48
					end
				end

				arg_101_1.text_.text = var_104_52
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_56 = var_104_48 + 0.3
			local var_104_57 = math.max(var_104_49, arg_101_1.talkMaxDuration)

			if var_104_56 <= arg_101_1.time_ and arg_101_1.time_ < var_104_56 + var_104_57 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_56) / var_104_57

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_56 + var_104_57 and arg_101_1.time_ < var_104_56 + var_104_57 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play424101026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424101026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play424101027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.775

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(424101026)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 31
				local var_110_5 = utf8.len(var_110_3)
				local var_110_6 = var_110_4 <= 0 and var_110_1 or var_110_1 * (var_110_5 / var_110_4)

				if var_110_6 > 0 and var_110_1 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_7 and arg_107_1.time_ < var_110_0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play424101027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424101027
		arg_111_1.duration_ = 3.37

		local var_111_0 = {
			zh = 3.366,
			ja = 2.133
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play424101028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10153"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10153 == nil then
				arg_111_1.var_.actorSpriteComps10153 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps10153 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 1, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps10153 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10153 = nil
			end

			local var_114_8 = arg_111_1.actors_["10153"].transform
			local var_114_9 = 0

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.var_.moveOldPos10153 = var_114_8.localPosition
				var_114_8.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10153", 2)

				local var_114_10 = var_114_8.childCount

				for iter_114_4 = 0, var_114_10 - 1 do
					local var_114_11 = var_114_8:GetChild(iter_114_4)

					if var_114_11.name == "split_5" then
						var_114_11:SetAsLastSibling()
						var_114_11.gameObject:SetActive(true)

						arg_111_1.var_.actorSpriteSplit10153 = var_114_11.gameObject:GetComponent(typeof(Image))

						arg_111_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_114_12 = 0.001

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_12 then
				local var_114_13 = (arg_111_1.time_ - var_114_9) / var_114_12
				local var_114_14 = Vector3.New(-400, -395, -330)

				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10153, var_114_14, var_114_13)

				if arg_111_1.var_.actorSpriteSplit10153 ~= nil then
					arg_111_1.var_.actorSpriteSplit10153:SetAlpha(var_114_13)
				end
			end

			if arg_111_1.time_ >= var_114_9 + var_114_12 and arg_111_1.time_ < var_114_9 + var_114_12 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_111_1.var_.actorSpriteSplit10153 ~= nil then
					arg_111_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_114_15 = 0
			local var_114_16 = 0.225

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[1387].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(424101027)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 9
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_16 or var_114_16 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_16 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_15
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101027", "story_v_out_424101.awb") ~= 0 then
					local var_114_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101027", "story_v_out_424101.awb") / 1000

					if var_114_23 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_15
					end

					if var_114_18.prefab_name ~= "" and arg_111_1.actors_[var_114_18.prefab_name] ~= nil then
						local var_114_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_18.prefab_name].transform, "story_v_out_424101", "424101027", "story_v_out_424101.awb")

						arg_111_1:RecordAudio("424101027", var_114_24)
						arg_111_1:RecordAudio("424101027", var_114_24)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_424101", "424101027", "story_v_out_424101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_424101", "424101027", "story_v_out_424101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_25 and arg_111_1.time_ < var_114_15 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play424101028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424101028
		arg_115_1.duration_ = 4.3

		local var_115_0 = {
			zh = 3.533,
			ja = 4.3
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play424101029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1094"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1094 == nil then
				arg_115_1.var_.actorSpriteComps1094 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps1094 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 1, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1094 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1094 = nil
			end

			local var_118_8 = arg_115_1.actors_["10153"]
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10153 == nil then
				arg_115_1.var_.actorSpriteComps10153 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_10 = 0.2

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 and not isNil(var_118_8) then
				local var_118_11 = (arg_115_1.time_ - var_118_9) / var_118_10

				if arg_115_1.var_.actorSpriteComps10153 then
					for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_118_5 then
							if arg_115_1.isInRecall_ then
								local var_118_12 = Mathf.Lerp(iter_118_5.color.r, arg_115_1.hightColor2.r, var_118_11)
								local var_118_13 = Mathf.Lerp(iter_118_5.color.g, arg_115_1.hightColor2.g, var_118_11)
								local var_118_14 = Mathf.Lerp(iter_118_5.color.b, arg_115_1.hightColor2.b, var_118_11)

								iter_118_5.color = Color.New(var_118_12, var_118_13, var_118_14)
							else
								local var_118_15 = Mathf.Lerp(iter_118_5.color.r, 0.5, var_118_11)

								iter_118_5.color = Color.New(var_118_15, var_118_15, var_118_15)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10153 then
				for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_118_7 then
						if arg_115_1.isInRecall_ then
							iter_118_7.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10153 = nil
			end

			local var_118_16 = arg_115_1.actors_["1094"].transform
			local var_118_17 = 0

			if var_118_17 < arg_115_1.time_ and arg_115_1.time_ <= var_118_17 + arg_118_0 then
				arg_115_1.var_.moveOldPos1094 = var_118_16.localPosition
				var_118_16.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1094", 4)

				local var_118_18 = var_118_16.childCount

				for iter_118_8 = 0, var_118_18 - 1 do
					local var_118_19 = var_118_16:GetChild(iter_118_8)

					if var_118_19.name == "split_1" or not string.find(var_118_19.name, "split") then
						var_118_19.gameObject:SetActive(true)
					else
						var_118_19.gameObject:SetActive(false)
					end
				end
			end

			local var_118_20 = 0.001

			if var_118_17 <= arg_115_1.time_ and arg_115_1.time_ < var_118_17 + var_118_20 then
				local var_118_21 = (arg_115_1.time_ - var_118_17) / var_118_20
				local var_118_22 = Vector3.New(470, -335, -230)

				var_118_16.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1094, var_118_22, var_118_21)
			end

			if arg_115_1.time_ >= var_118_17 + var_118_20 and arg_115_1.time_ < var_118_17 + var_118_20 + arg_118_0 then
				var_118_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_118_23 = 0
			local var_118_24 = 0.375

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_25 = arg_115_1:FormatText(StoryNameCfg[181].name)

				arg_115_1.leftNameTxt_.text = var_118_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_26 = arg_115_1:GetWordFromCfg(424101028)
				local var_118_27 = arg_115_1:FormatText(var_118_26.content)

				arg_115_1.text_.text = var_118_27

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_28 = 15
				local var_118_29 = utf8.len(var_118_27)
				local var_118_30 = var_118_28 <= 0 and var_118_24 or var_118_24 * (var_118_29 / var_118_28)

				if var_118_30 > 0 and var_118_24 < var_118_30 then
					arg_115_1.talkMaxDuration = var_118_30

					if var_118_30 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_30 + var_118_23
					end
				end

				arg_115_1.text_.text = var_118_27
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101028", "story_v_out_424101.awb") ~= 0 then
					local var_118_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101028", "story_v_out_424101.awb") / 1000

					if var_118_31 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_23
					end

					if var_118_26.prefab_name ~= "" and arg_115_1.actors_[var_118_26.prefab_name] ~= nil then
						local var_118_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_26.prefab_name].transform, "story_v_out_424101", "424101028", "story_v_out_424101.awb")

						arg_115_1:RecordAudio("424101028", var_118_32)
						arg_115_1:RecordAudio("424101028", var_118_32)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424101", "424101028", "story_v_out_424101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424101", "424101028", "story_v_out_424101.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_33 = math.max(var_118_24, arg_115_1.talkMaxDuration)

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_33 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_23) / var_118_33

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_23 + var_118_33 and arg_115_1.time_ < var_118_23 + var_118_33 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play424101029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424101029
		arg_119_1.duration_ = 1.93

		local var_119_0 = {
			zh = 1.5,
			ja = 1.933
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
				arg_119_0:Play424101030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10153"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10153 == nil then
				arg_119_1.var_.actorSpriteComps10153 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps10153 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps10153 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10153 = nil
			end

			local var_122_8 = arg_119_1.actors_["1094"]
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps1094 == nil then
				arg_119_1.var_.actorSpriteComps1094 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_10 = 0.2

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 and not isNil(var_122_8) then
				local var_122_11 = (arg_119_1.time_ - var_122_9) / var_122_10

				if arg_119_1.var_.actorSpriteComps1094 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								local var_122_12 = Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, var_122_11)
								local var_122_13 = Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, var_122_11)
								local var_122_14 = Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, var_122_11)

								iter_122_5.color = Color.New(var_122_12, var_122_13, var_122_14)
							else
								local var_122_15 = Mathf.Lerp(iter_122_5.color.r, 0.5, var_122_11)

								iter_122_5.color = Color.New(var_122_15, var_122_15, var_122_15)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps1094 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1094 = nil
			end

			local var_122_16 = arg_119_1.actors_["10153"].transform
			local var_122_17 = 0

			if var_122_17 < arg_119_1.time_ and arg_119_1.time_ <= var_122_17 + arg_122_0 then
				arg_119_1.var_.moveOldPos10153 = var_122_16.localPosition
				var_122_16.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10153", 2)

				local var_122_18 = var_122_16.childCount

				for iter_122_8 = 0, var_122_18 - 1 do
					local var_122_19 = var_122_16:GetChild(iter_122_8)

					if var_122_19.name == "split_4" then
						var_122_19:SetAsLastSibling()
						var_122_19.gameObject:SetActive(true)

						arg_119_1.var_.actorSpriteSplit10153 = var_122_19.gameObject:GetComponent(typeof(Image))

						arg_119_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_122_20 = 0.5

			if var_122_17 <= arg_119_1.time_ and arg_119_1.time_ < var_122_17 + var_122_20 then
				local var_122_21 = (arg_119_1.time_ - var_122_17) / var_122_20
				local var_122_22 = Vector3.New(-400, -395, -330)

				var_122_16.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10153, var_122_22, var_122_21)

				if arg_119_1.var_.actorSpriteSplit10153 ~= nil then
					arg_119_1.var_.actorSpriteSplit10153:SetAlpha(var_122_21)
				end
			end

			if arg_119_1.time_ >= var_122_17 + var_122_20 and arg_119_1.time_ < var_122_17 + var_122_20 + arg_122_0 then
				var_122_16.localPosition = Vector3.New(-400, -395, -330)

				if arg_119_1.var_.actorSpriteSplit10153 ~= nil then
					arg_119_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_122_23 = 0
			local var_122_24 = 0.125

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_25 = arg_119_1:FormatText(StoryNameCfg[1387].name)

				arg_119_1.leftNameTxt_.text = var_122_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_26 = arg_119_1:GetWordFromCfg(424101029)
				local var_122_27 = arg_119_1:FormatText(var_122_26.content)

				arg_119_1.text_.text = var_122_27

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 5
				local var_122_29 = utf8.len(var_122_27)
				local var_122_30 = var_122_28 <= 0 and var_122_24 or var_122_24 * (var_122_29 / var_122_28)

				if var_122_30 > 0 and var_122_24 < var_122_30 then
					arg_119_1.talkMaxDuration = var_122_30

					if var_122_30 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_30 + var_122_23
					end
				end

				arg_119_1.text_.text = var_122_27
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101029", "story_v_out_424101.awb") ~= 0 then
					local var_122_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101029", "story_v_out_424101.awb") / 1000

					if var_122_31 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_31 + var_122_23
					end

					if var_122_26.prefab_name ~= "" and arg_119_1.actors_[var_122_26.prefab_name] ~= nil then
						local var_122_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_26.prefab_name].transform, "story_v_out_424101", "424101029", "story_v_out_424101.awb")

						arg_119_1:RecordAudio("424101029", var_122_32)
						arg_119_1:RecordAudio("424101029", var_122_32)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_424101", "424101029", "story_v_out_424101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_424101", "424101029", "story_v_out_424101.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_33 = math.max(var_122_24, arg_119_1.talkMaxDuration)

			if var_122_23 <= arg_119_1.time_ and arg_119_1.time_ < var_122_23 + var_122_33 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_23) / var_122_33

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_23 + var_122_33 and arg_119_1.time_ < var_122_23 + var_122_33 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play424101030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424101030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424101031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10153"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10153 == nil then
				arg_123_1.var_.actorSpriteComps10153 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 0.2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10153 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								local var_126_4 = Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, var_126_3)
								local var_126_5 = Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, var_126_3)
								local var_126_6 = Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, var_126_3)

								iter_126_1.color = Color.New(var_126_4, var_126_5, var_126_6)
							else
								local var_126_7 = Mathf.Lerp(iter_126_1.color.r, 0.5, var_126_3)

								iter_126_1.color = Color.New(var_126_7, var_126_7, var_126_7)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10153 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10153 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.65

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_10 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_11 = arg_123_1:GetWordFromCfg(424101030)
				local var_126_12 = arg_123_1:FormatText(var_126_11.content)

				arg_123_1.text_.text = var_126_12

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 26
				local var_126_14 = utf8.len(var_126_12)
				local var_126_15 = var_126_13 <= 0 and var_126_9 or var_126_9 * (var_126_14 / var_126_13)

				if var_126_15 > 0 and var_126_9 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_12
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424101031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424101031
		arg_127_1.duration_ = 18.33

		local var_127_0 = {
			zh = 12.8,
			ja = 18.333
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424101032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10153"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10153 == nil then
				arg_127_1.var_.actorSpriteComps10153 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10153 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10153 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10153 = nil
			end

			local var_130_8 = arg_127_1.actors_["10153"].transform
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.var_.moveOldPos10153 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10153", 2)

				local var_130_10 = var_130_8.childCount

				for iter_130_4 = 0, var_130_10 - 1 do
					local var_130_11 = var_130_8:GetChild(iter_130_4)

					if var_130_11.name == "split_1" then
						var_130_11:SetAsLastSibling()
						var_130_11.gameObject:SetActive(true)

						arg_127_1.var_.actorSpriteSplit10153 = var_130_11.gameObject:GetComponent(typeof(Image))

						arg_127_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_130_12 = 0.5

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_12 then
				local var_130_13 = (arg_127_1.time_ - var_130_9) / var_130_12
				local var_130_14 = Vector3.New(-400, -395, -330)

				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10153, var_130_14, var_130_13)

				if arg_127_1.var_.actorSpriteSplit10153 ~= nil then
					arg_127_1.var_.actorSpriteSplit10153:SetAlpha(var_130_13)
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_12 and arg_127_1.time_ < var_130_9 + var_130_12 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_127_1.var_.actorSpriteSplit10153 ~= nil then
					arg_127_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_130_15 = 0
			local var_130_16 = 1.425

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[1387].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(424101031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 57
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101031", "story_v_out_424101.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101031", "story_v_out_424101.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_424101", "424101031", "story_v_out_424101.awb")

						arg_127_1:RecordAudio("424101031", var_130_24)
						arg_127_1:RecordAudio("424101031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424101", "424101031", "story_v_out_424101.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424101", "424101031", "story_v_out_424101.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play424101032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424101032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play424101033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10153"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10153 == nil then
				arg_131_1.var_.actorSpriteComps10153 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10153 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 0.5, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10153 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10153 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 1.4

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_10 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_11 = arg_131_1:GetWordFromCfg(424101032)
				local var_134_12 = arg_131_1:FormatText(var_134_11.content)

				arg_131_1.text_.text = var_134_12

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 56
				local var_134_14 = utf8.len(var_134_12)
				local var_134_15 = var_134_13 <= 0 and var_134_9 or var_134_9 * (var_134_14 / var_134_13)

				if var_134_15 > 0 and var_134_9 < var_134_15 then
					arg_131_1.talkMaxDuration = var_134_15

					if var_134_15 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_15 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_12
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play424101033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424101033
		arg_135_1.duration_ = 12.3

		local var_135_0 = {
			zh = 12.3,
			ja = 9.8
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play424101034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10153"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10153 == nil then
				arg_135_1.var_.actorSpriteComps10153 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10153 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 1, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10153 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10153 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 1.3

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[1387].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:GetWordFromCfg(424101033)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 52
				local var_138_14 = utf8.len(var_138_12)
				local var_138_15 = var_138_13 <= 0 and var_138_9 or var_138_9 * (var_138_14 / var_138_13)

				if var_138_15 > 0 and var_138_9 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101033", "story_v_out_424101.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_424101", "424101033", "story_v_out_424101.awb") / 1000

					if var_138_16 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_8
					end

					if var_138_11.prefab_name ~= "" and arg_135_1.actors_[var_138_11.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_11.prefab_name].transform, "story_v_out_424101", "424101033", "story_v_out_424101.awb")

						arg_135_1:RecordAudio("424101033", var_138_17)
						arg_135_1:RecordAudio("424101033", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424101", "424101033", "story_v_out_424101.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424101", "424101033", "story_v_out_424101.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_18 and arg_135_1.time_ < var_138_8 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424101034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424101034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play424101035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10153"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10153 == nil then
				arg_139_1.var_.actorSpriteComps10153 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10153 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 0.5, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10153 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10153 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.9

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(424101034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 36
				local var_142_13 = utf8.len(var_142_11)
				local var_142_14 = var_142_12 <= 0 and var_142_9 or var_142_9 * (var_142_13 / var_142_12)

				if var_142_14 > 0 and var_142_9 < var_142_14 then
					arg_139_1.talkMaxDuration = var_142_14

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_15 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_15 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_15

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_15 and arg_139_1.time_ < var_142_8 + var_142_15 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play424101035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424101035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play424101036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.25

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(424101035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 50
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
	Play424101036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424101036
		arg_147_1.duration_ = 7.2

		local var_147_0 = {
			zh = 4.566,
			ja = 7.2
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play424101037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1094"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1094 == nil then
				arg_147_1.var_.actorSpriteComps1094 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps1094 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 1, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps1094 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1094 = nil
			end

			local var_150_8 = arg_147_1.actors_["1094"].transform
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 then
				arg_147_1.var_.moveOldPos1094 = var_150_8.localPosition
				var_150_8.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1094", 4)

				local var_150_10 = var_150_8.childCount

				for iter_150_4 = 0, var_150_10 - 1 do
					local var_150_11 = var_150_8:GetChild(iter_150_4)

					if var_150_11.name == "split_1" or not string.find(var_150_11.name, "split") then
						var_150_11.gameObject:SetActive(true)
					else
						var_150_11.gameObject:SetActive(false)
					end
				end
			end

			local var_150_12 = 0.001

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_12 then
				local var_150_13 = (arg_147_1.time_ - var_150_9) / var_150_12
				local var_150_14 = Vector3.New(470, -335, -230)

				var_150_8.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1094, var_150_14, var_150_13)
			end

			if arg_147_1.time_ >= var_150_9 + var_150_12 and arg_147_1.time_ < var_150_9 + var_150_12 + arg_150_0 then
				var_150_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_150_15 = 0
			local var_150_16 = 0.45

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[181].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(424101036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 18
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101036", "story_v_out_424101.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101036", "story_v_out_424101.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_424101", "424101036", "story_v_out_424101.awb")

						arg_147_1:RecordAudio("424101036", var_150_24)
						arg_147_1:RecordAudio("424101036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_424101", "424101036", "story_v_out_424101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_424101", "424101036", "story_v_out_424101.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play424101037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424101037
		arg_151_1.duration_ = 8.9

		local var_151_0 = {
			zh = 6.933,
			ja = 8.9
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play424101038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1094"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1094 == nil then
				arg_151_1.var_.actorSpriteComps1094 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps1094 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps1094 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1094 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.825

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[177].name)

				arg_151_1.leftNameTxt_.text = var_154_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_11 = arg_151_1:GetWordFromCfg(424101037)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 33
				local var_154_14 = utf8.len(var_154_12)
				local var_154_15 = var_154_13 <= 0 and var_154_9 or var_154_9 * (var_154_14 / var_154_13)

				if var_154_15 > 0 and var_154_9 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_12
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101037", "story_v_out_424101.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_424101", "424101037", "story_v_out_424101.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_424101", "424101037", "story_v_out_424101.awb")

						arg_151_1:RecordAudio("424101037", var_154_17)
						arg_151_1:RecordAudio("424101037", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424101", "424101037", "story_v_out_424101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424101", "424101037", "story_v_out_424101.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_18 and arg_151_1.time_ < var_154_8 + var_154_18 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play424101038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 424101038
		arg_155_1.duration_ = 5.17

		local var_155_0 = {
			zh = 4.9,
			ja = 5.166
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play424101039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10153"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10153 == nil then
				arg_155_1.var_.actorSpriteComps10153 = var_158_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_2 = 0.2

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.actorSpriteComps10153 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								local var_158_4 = Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, var_158_3)
								local var_158_5 = Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, var_158_3)
								local var_158_6 = Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, var_158_3)

								iter_158_1.color = Color.New(var_158_4, var_158_5, var_158_6)
							else
								local var_158_7 = Mathf.Lerp(iter_158_1.color.r, 1, var_158_3)

								iter_158_1.color = Color.New(var_158_7, var_158_7, var_158_7)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.actorSpriteComps10153 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_158_3 then
						if arg_155_1.isInRecall_ then
							iter_158_3.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10153 = nil
			end

			local var_158_8 = arg_155_1.actors_["10153"].transform
			local var_158_9 = 0

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.var_.moveOldPos10153 = var_158_8.localPosition
				var_158_8.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10153", 2)

				local var_158_10 = var_158_8.childCount

				for iter_158_4 = 0, var_158_10 - 1 do
					local var_158_11 = var_158_8:GetChild(iter_158_4)

					if var_158_11.name == "split_3" then
						var_158_11:SetAsLastSibling()
						var_158_11.gameObject:SetActive(true)

						arg_155_1.var_.actorSpriteSplit10153 = var_158_11.gameObject:GetComponent(typeof(Image))

						arg_155_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_158_12 = 0.5

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_12 then
				local var_158_13 = (arg_155_1.time_ - var_158_9) / var_158_12
				local var_158_14 = Vector3.New(-400, -395, -330)

				var_158_8.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10153, var_158_14, var_158_13)

				if arg_155_1.var_.actorSpriteSplit10153 ~= nil then
					arg_155_1.var_.actorSpriteSplit10153:SetAlpha(var_158_13)
				end
			end

			if arg_155_1.time_ >= var_158_9 + var_158_12 and arg_155_1.time_ < var_158_9 + var_158_12 + arg_158_0 then
				var_158_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_155_1.var_.actorSpriteSplit10153 ~= nil then
					arg_155_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_158_15 = 0
			local var_158_16 = 0.525

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[1387].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(424101038)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 21
				local var_158_21 = utf8.len(var_158_19)
				local var_158_22 = var_158_20 <= 0 and var_158_16 or var_158_16 * (var_158_21 / var_158_20)

				if var_158_22 > 0 and var_158_16 < var_158_22 then
					arg_155_1.talkMaxDuration = var_158_22

					if var_158_22 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_22 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_19
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101038", "story_v_out_424101.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101038", "story_v_out_424101.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_424101", "424101038", "story_v_out_424101.awb")

						arg_155_1:RecordAudio("424101038", var_158_24)
						arg_155_1:RecordAudio("424101038", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_424101", "424101038", "story_v_out_424101.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_424101", "424101038", "story_v_out_424101.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_25 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_15) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_15 + var_158_25 and arg_155_1.time_ < var_158_15 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play424101039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 424101039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play424101040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10153"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10153 == nil then
				arg_159_1.var_.actorSpriteComps10153 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 0.2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10153 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								local var_162_4 = Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, var_162_3)
								local var_162_5 = Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, var_162_3)
								local var_162_6 = Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, var_162_3)

								iter_162_1.color = Color.New(var_162_4, var_162_5, var_162_6)
							else
								local var_162_7 = Mathf.Lerp(iter_162_1.color.r, 0.5, var_162_3)

								iter_162_1.color = Color.New(var_162_7, var_162_7, var_162_7)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10153 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10153 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.125

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_10 = arg_159_1:FormatText(StoryNameCfg[7].name)

				arg_159_1.leftNameTxt_.text = var_162_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_11 = arg_159_1:GetWordFromCfg(424101039)
				local var_162_12 = arg_159_1:FormatText(var_162_11.content)

				arg_159_1.text_.text = var_162_12

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 5
				local var_162_14 = utf8.len(var_162_12)
				local var_162_15 = var_162_13 <= 0 and var_162_9 or var_162_9 * (var_162_14 / var_162_13)

				if var_162_15 > 0 and var_162_9 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_12
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play424101040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 424101040
		arg_163_1.duration_ = 17.27

		local var_163_0 = {
			zh = 10.033,
			ja = 17.266
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play424101041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10153"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10153 == nil then
				arg_163_1.var_.actorSpriteComps10153 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps10153 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 1, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps10153 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10153 = nil
			end

			local var_166_8 = arg_163_1.actors_["10153"].transform
			local var_166_9 = 0

			if var_166_9 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.var_.moveOldPos10153 = var_166_8.localPosition
				var_166_8.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10153", 2)

				local var_166_10 = var_166_8.childCount

				for iter_166_4 = 0, var_166_10 - 1 do
					local var_166_11 = var_166_8:GetChild(iter_166_4)

					if var_166_11.name == "" then
						var_166_11:SetAsLastSibling()
						var_166_11.gameObject:SetActive(true)

						arg_163_1.var_.actorSpriteSplit10153 = var_166_11.gameObject:GetComponent(typeof(Image))

						arg_163_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_166_12 = 0.5

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_12 then
				local var_166_13 = (arg_163_1.time_ - var_166_9) / var_166_12
				local var_166_14 = Vector3.New(-400, -395, -330)

				var_166_8.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10153, var_166_14, var_166_13)

				if arg_163_1.var_.actorSpriteSplit10153 ~= nil then
					arg_163_1.var_.actorSpriteSplit10153:SetAlpha(var_166_13)
				end
			end

			if arg_163_1.time_ >= var_166_9 + var_166_12 and arg_163_1.time_ < var_166_9 + var_166_12 + arg_166_0 then
				var_166_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_163_1.var_.actorSpriteSplit10153 ~= nil then
					arg_163_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_166_15 = 0
			local var_166_16 = 1.175

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[1387].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(424101040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 47
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101040", "story_v_out_424101.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101040", "story_v_out_424101.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_424101", "424101040", "story_v_out_424101.awb")

						arg_163_1:RecordAudio("424101040", var_166_24)
						arg_163_1:RecordAudio("424101040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_424101", "424101040", "story_v_out_424101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_424101", "424101040", "story_v_out_424101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play424101041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424101041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play424101042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10153"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10153 == nil then
				arg_167_1.var_.actorSpriteComps10153 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10153 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 0.5, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10153 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10153 = nil
			end

			local var_170_8 = arg_167_1.actors_["10153"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos10153 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10153", 7)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "" or not string.find(var_170_11.name, "split") then
						var_170_11.gameObject:SetActive(true)
					else
						var_170_11.gameObject:SetActive(false)
					end
				end
			end

			local var_170_12 = 0.001

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(0, -2000, 0)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10153, var_170_14, var_170_13)
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_15 = arg_167_1.actors_["1094"].transform
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.var_.moveOldPos1094 = var_170_15.localPosition
				var_170_15.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1094", 7)

				local var_170_17 = var_170_15.childCount

				for iter_170_5 = 0, var_170_17 - 1 do
					local var_170_18 = var_170_15:GetChild(iter_170_5)

					if var_170_18.name == "" or not string.find(var_170_18.name, "split") then
						var_170_18.gameObject:SetActive(true)
					else
						var_170_18.gameObject:SetActive(false)
					end
				end
			end

			local var_170_19 = 0.001

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_19 then
				local var_170_20 = (arg_167_1.time_ - var_170_16) / var_170_19
				local var_170_21 = Vector3.New(0, -2000, 0)

				var_170_15.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1094, var_170_21, var_170_20)
			end

			if arg_167_1.time_ >= var_170_16 + var_170_19 and arg_167_1.time_ < var_170_16 + var_170_19 + arg_170_0 then
				var_170_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_22 = 0
			local var_170_23 = 1.3

			if var_170_22 < arg_167_1.time_ and arg_167_1.time_ <= var_170_22 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_24 = arg_167_1:GetWordFromCfg(424101041)
				local var_170_25 = arg_167_1:FormatText(var_170_24.content)

				arg_167_1.text_.text = var_170_25

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_26 = 52
				local var_170_27 = utf8.len(var_170_25)
				local var_170_28 = var_170_26 <= 0 and var_170_23 or var_170_23 * (var_170_27 / var_170_26)

				if var_170_28 > 0 and var_170_23 < var_170_28 then
					arg_167_1.talkMaxDuration = var_170_28

					if var_170_28 + var_170_22 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_28 + var_170_22
					end
				end

				arg_167_1.text_.text = var_170_25
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_29 = math.max(var_170_23, arg_167_1.talkMaxDuration)

			if var_170_22 <= arg_167_1.time_ and arg_167_1.time_ < var_170_22 + var_170_29 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_22) / var_170_29

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_22 + var_170_29 and arg_167_1.time_ < var_170_22 + var_170_29 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play424101042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424101042
		arg_171_1.duration_ = 6.1

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424101043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = "I18h"

			if arg_171_1.bgs_[var_174_0] == nil then
				local var_174_1 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_0)
				var_174_1.name = var_174_0
				var_174_1.transform.parent = arg_171_1.stage_.transform
				var_174_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_0] = var_174_1
			end

			local var_174_2 = 0.4

			if var_174_2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				local var_174_3 = manager.ui.mainCamera.transform.localPosition
				local var_174_4 = Vector3.New(0, 0, 10) + Vector3.New(var_174_3.x, var_174_3.y, 0)
				local var_174_5 = arg_171_1.bgs_.I18h

				var_174_5.transform.localPosition = var_174_4
				var_174_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_6 = var_174_5:GetComponent("SpriteRenderer")

				if var_174_6 and var_174_6.sprite then
					local var_174_7 = (var_174_5.transform.localPosition - var_174_3).z
					local var_174_8 = manager.ui.mainCameraCom_
					local var_174_9 = 2 * var_174_7 * Mathf.Tan(var_174_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_174_10 = var_174_9 * var_174_8.aspect
					local var_174_11 = var_174_6.sprite.bounds.size.x
					local var_174_12 = var_174_6.sprite.bounds.size.y
					local var_174_13 = var_174_10 / var_174_11
					local var_174_14 = var_174_9 / var_174_12
					local var_174_15 = var_174_14 < var_174_13 and var_174_13 or var_174_14

					var_174_5.transform.localScale = Vector3.New(var_174_15, var_174_15, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "I18h" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_16 = 1.1

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_17 = 0.3

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_18 = 0

			if var_174_18 < arg_171_1.time_ and arg_171_1.time_ <= var_174_18 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_19 = 0.4

			if var_174_18 <= arg_171_1.time_ and arg_171_1.time_ < var_174_18 + var_174_19 then
				local var_174_20 = (arg_171_1.time_ - var_174_18) / var_174_19
				local var_174_21 = Color.New(0, 0, 0)

				var_174_21.a = Mathf.Lerp(0, 1, var_174_20)
				arg_171_1.mask_.color = var_174_21
			end

			if arg_171_1.time_ >= var_174_18 + var_174_19 and arg_171_1.time_ < var_174_18 + var_174_19 + arg_174_0 then
				local var_174_22 = Color.New(0, 0, 0)

				var_174_22.a = 1
				arg_171_1.mask_.color = var_174_22
			end

			local var_174_23 = 0.4

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_24 = 0.7

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_24 then
				local var_174_25 = (arg_171_1.time_ - var_174_23) / var_174_24
				local var_174_26 = Color.New(0, 0, 0)

				var_174_26.a = Mathf.Lerp(1, 0, var_174_25)
				arg_171_1.mask_.color = var_174_26
			end

			if arg_171_1.time_ >= var_174_23 + var_174_24 and arg_171_1.time_ < var_174_23 + var_174_24 + arg_174_0 then
				local var_174_27 = Color.New(0, 0, 0)
				local var_174_28 = 0

				arg_171_1.mask_.enabled = false
				var_174_27.a = var_174_28
				arg_171_1.mask_.color = var_174_27
			end

			local var_174_29 = manager.ui.mainCamera.transform
			local var_174_30 = 0

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				local var_174_31 = arg_171_1.var_.effecthuiyishalaonainai1
				local var_174_32
				local var_174_33 = var_174_29

				if not var_174_31 then
					var_174_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_174_33)
					var_174_31.name = "huiyishalaonainai1"
					arg_171_1.var_.effecthuiyishalaonainai1 = var_174_31
				else
					var_174_31.transform:SetParent(var_174_33)
				end

				var_174_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_31.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_174_34 = manager.ui.mainCamera.transform
			local var_174_35 = 1

			if var_174_35 < arg_171_1.time_ and arg_171_1.time_ <= var_174_35 + arg_174_0 then
				local var_174_36 = arg_171_1.var_.effecthuiyishalaonainai1

				if var_174_36 then
					Object.Destroy(var_174_36)

					arg_171_1.var_.effecthuiyishalaonainai1 = nil
				end
			end

			local var_174_37 = 0.4

			arg_171_1.isInRecall_ = true

			if var_174_37 < arg_171_1.time_ and arg_171_1.time_ <= var_174_37 + arg_174_0 then
				arg_171_1.screenFilterGo_:SetActive(true)

				arg_171_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_171_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_171_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_174_2, iter_174_3 in pairs(arg_171_1.actors_) do
					local var_174_38 = iter_174_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_174_4, iter_174_5 in ipairs(var_174_38) do
						if iter_174_5.color.r > 0.51 then
							iter_174_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_174_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_174_39 = 0.0166666666666667

			if var_174_37 <= arg_171_1.time_ and arg_171_1.time_ < var_174_37 + var_174_39 then
				local var_174_40 = (arg_171_1.time_ - var_174_37) / var_174_39

				arg_171_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_174_40)
			end

			if arg_171_1.time_ >= var_174_37 + var_174_39 and arg_171_1.time_ < var_174_37 + var_174_39 + arg_174_0 then
				arg_171_1.screenFilterEffect_.weight = 1
			end

			local var_174_41 = 0.1
			local var_174_42 = 1

			if var_174_41 < arg_171_1.time_ and arg_171_1.time_ <= var_174_41 + arg_174_0 then
				local var_174_43 = "play"
				local var_174_44 = "effect"

				arg_171_1:AudioAction(var_174_43, var_174_44, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_174_45 = 0
			local var_174_46 = 1

			if var_174_45 < arg_171_1.time_ and arg_171_1.time_ <= var_174_45 + arg_174_0 then
				local var_174_47 = "stop"
				local var_174_48 = "effect"

				arg_171_1:AudioAction(var_174_47, var_174_48, "se_story_140", "se_story_140_amb_street", "")
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_49 = 1.100000000001
			local var_174_50 = 0.525

			if var_174_49 < arg_171_1.time_ and arg_171_1.time_ <= var_174_49 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_51 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_51:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_52 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_171_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_174_53 = arg_171_1:GetWordFromCfg(424101042)
				local var_174_54 = arg_171_1:FormatText(var_174_53.content)

				arg_171_1.text_.text = var_174_54

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_55 = 21
				local var_174_56 = utf8.len(var_174_54)
				local var_174_57 = var_174_55 <= 0 and var_174_50 or var_174_50 * (var_174_56 / var_174_55)

				if var_174_57 > 0 and var_174_50 < var_174_57 then
					arg_171_1.talkMaxDuration = var_174_57
					var_174_49 = var_174_49 + 0.3

					if var_174_57 + var_174_49 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_57 + var_174_49
					end
				end

				arg_171_1.text_.text = var_174_54
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_58 = var_174_49 + 0.3
			local var_174_59 = math.max(var_174_50, arg_171_1.talkMaxDuration)

			if var_174_58 <= arg_171_1.time_ and arg_171_1.time_ < var_174_58 + var_174_59 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_58) / var_174_59

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_58 + var_174_59 and arg_171_1.time_ < var_174_58 + var_174_59 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424101043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 424101043
		arg_177_1.duration_ = 3.87

		local var_177_0 = {
			zh = 2.666,
			ja = 3.866
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
				arg_177_0:Play424101044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.225

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[462].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(424101043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 9
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101043", "story_v_out_424101.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101043", "story_v_out_424101.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_424101", "424101043", "story_v_out_424101.awb")

						arg_177_1:RecordAudio("424101043", var_180_9)
						arg_177_1:RecordAudio("424101043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_424101", "424101043", "story_v_out_424101.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_424101", "424101043", "story_v_out_424101.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play424101044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 424101044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play424101045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.15

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_181_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_184_3 = arg_181_1:GetWordFromCfg(424101044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 6
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play424101045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 424101045
		arg_185_1.duration_ = 2.8

		local var_185_0 = {
			zh = 1.5,
			ja = 2.8
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
				arg_185_0:Play424101046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.175

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[462].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(424101045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101045", "story_v_out_424101.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101045", "story_v_out_424101.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_424101", "424101045", "story_v_out_424101.awb")

						arg_185_1:RecordAudio("424101045", var_188_9)
						arg_185_1:RecordAudio("424101045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_424101", "424101045", "story_v_out_424101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_424101", "424101045", "story_v_out_424101.awb")
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
	Play424101046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 424101046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play424101047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_189_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_192_3 = arg_189_1:GetWordFromCfg(424101046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 4
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
	Play424101047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 424101047
		arg_193_1.duration_ = 15.07

		local var_193_0 = {
			zh = 15.066,
			ja = 14.166
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
				arg_193_0:Play424101048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.375

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[462].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(424101047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 55
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101047", "story_v_out_424101.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101047", "story_v_out_424101.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_424101", "424101047", "story_v_out_424101.awb")

						arg_193_1:RecordAudio("424101047", var_196_9)
						arg_193_1:RecordAudio("424101047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_424101", "424101047", "story_v_out_424101.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_424101", "424101047", "story_v_out_424101.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play424101048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 424101048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play424101049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.475

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(424101048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 59
				local var_200_5 = utf8.len(var_200_3)
				local var_200_6 = var_200_4 <= 0 and var_200_1 or var_200_1 * (var_200_5 / var_200_4)

				if var_200_6 > 0 and var_200_1 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_7 and arg_197_1.time_ < var_200_0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play424101049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 424101049
		arg_201_1.duration_ = 9

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play424101050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 2

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_1 = manager.ui.mainCamera.transform.localPosition
				local var_204_2 = Vector3.New(0, 0, 10) + Vector3.New(var_204_1.x, var_204_1.y, 0)
				local var_204_3 = arg_201_1.bgs_.I18d

				var_204_3.transform.localPosition = var_204_2
				var_204_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_204_4 = var_204_3:GetComponent("SpriteRenderer")

				if var_204_4 and var_204_4.sprite then
					local var_204_5 = (var_204_3.transform.localPosition - var_204_1).z
					local var_204_6 = manager.ui.mainCameraCom_
					local var_204_7 = 2 * var_204_5 * Mathf.Tan(var_204_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_204_8 = var_204_7 * var_204_6.aspect
					local var_204_9 = var_204_4.sprite.bounds.size.x
					local var_204_10 = var_204_4.sprite.bounds.size.y
					local var_204_11 = var_204_8 / var_204_9
					local var_204_12 = var_204_7 / var_204_10
					local var_204_13 = var_204_12 < var_204_11 and var_204_11 or var_204_12

					var_204_3.transform.localScale = Vector3.New(var_204_13, var_204_13, 0)
				end

				for iter_204_0, iter_204_1 in pairs(arg_201_1.bgs_) do
					if iter_204_0 ~= "I18d" then
						iter_204_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_204_14 = 3.999999999999

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_15 = 0.3

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_16 = 0

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_17 = 2

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Color.New(0, 0, 0)

				var_204_19.a = Mathf.Lerp(0, 1, var_204_18)
				arg_201_1.mask_.color = var_204_19
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				local var_204_20 = Color.New(0, 0, 0)

				var_204_20.a = 1
				arg_201_1.mask_.color = var_204_20
			end

			local var_204_21 = 2

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_22 = 2

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_22 then
				local var_204_23 = (arg_201_1.time_ - var_204_21) / var_204_22
				local var_204_24 = Color.New(0, 0, 0)

				var_204_24.a = Mathf.Lerp(1, 0, var_204_23)
				arg_201_1.mask_.color = var_204_24
			end

			if arg_201_1.time_ >= var_204_21 + var_204_22 and arg_201_1.time_ < var_204_21 + var_204_22 + arg_204_0 then
				local var_204_25 = Color.New(0, 0, 0)
				local var_204_26 = 0

				arg_201_1.mask_.enabled = false
				var_204_25.a = var_204_26
				arg_201_1.mask_.color = var_204_25
			end

			local var_204_27 = 2

			arg_201_1.isInRecall_ = false

			if var_204_27 < arg_201_1.time_ and arg_201_1.time_ <= var_204_27 + arg_204_0 then
				arg_201_1.screenFilterGo_:SetActive(false)

				for iter_204_2, iter_204_3 in pairs(arg_201_1.actors_) do
					local var_204_28 = iter_204_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_204_4, iter_204_5 in ipairs(var_204_28) do
						if iter_204_5.color.r > 0.51 then
							iter_204_5.color = Color.New(1, 1, 1)
						else
							iter_204_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_204_29 = 0.1

			if var_204_27 <= arg_201_1.time_ and arg_201_1.time_ < var_204_27 + var_204_29 then
				local var_204_30 = (arg_201_1.time_ - var_204_27) / var_204_29

				arg_201_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_204_30)
			end

			if arg_201_1.time_ >= var_204_27 + var_204_29 and arg_201_1.time_ < var_204_27 + var_204_29 + arg_204_0 then
				arg_201_1.screenFilterEffect_.weight = 0
			end

			local var_204_31 = 0.266666666666667
			local var_204_32 = 1

			if var_204_31 < arg_201_1.time_ and arg_201_1.time_ <= var_204_31 + arg_204_0 then
				local var_204_33 = "stop"
				local var_204_34 = "effect"

				arg_201_1:AudioAction(var_204_33, var_204_34, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_204_35 = 1.7
			local var_204_36 = 1

			if var_204_35 < arg_201_1.time_ and arg_201_1.time_ <= var_204_35 + arg_204_0 then
				local var_204_37 = "play"
				local var_204_38 = "effect"

				arg_201_1:AudioAction(var_204_37, var_204_38, "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_39 = 4
			local var_204_40 = 0.3

			if var_204_39 < arg_201_1.time_ and arg_201_1.time_ <= var_204_39 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_41 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_41:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_42 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_42

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

				local var_204_43 = arg_201_1:GetWordFromCfg(424101049)
				local var_204_44 = arg_201_1:FormatText(var_204_43.content)

				arg_201_1.text_.text = var_204_44

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_45 = 12
				local var_204_46 = utf8.len(var_204_44)
				local var_204_47 = var_204_45 <= 0 and var_204_40 or var_204_40 * (var_204_46 / var_204_45)

				if var_204_47 > 0 and var_204_40 < var_204_47 then
					arg_201_1.talkMaxDuration = var_204_47
					var_204_39 = var_204_39 + 0.3

					if var_204_47 + var_204_39 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_47 + var_204_39
					end
				end

				arg_201_1.text_.text = var_204_44
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_48 = var_204_39 + 0.3
			local var_204_49 = math.max(var_204_40, arg_201_1.talkMaxDuration)

			if var_204_48 <= arg_201_1.time_ and arg_201_1.time_ < var_204_48 + var_204_49 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_48) / var_204_49

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_48 + var_204_49 and arg_201_1.time_ < var_204_48 + var_204_49 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play424101050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 424101050
		arg_207_1.duration_ = 9.37

		local var_207_0 = {
			zh = 8.766,
			ja = 9.366
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play424101051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10153"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10153 == nil then
				arg_207_1.var_.actorSpriteComps10153 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps10153 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps10153 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps10153 = nil
			end

			local var_210_8 = arg_207_1.actors_["10153"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos10153 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10153", 3)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(-60, -395, -330)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10153, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_210_15 = 0
			local var_210_16 = 0.975

			if var_210_15 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_17 = arg_207_1:FormatText(StoryNameCfg[1387].name)

				arg_207_1.leftNameTxt_.text = var_210_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_18 = arg_207_1:GetWordFromCfg(424101050)
				local var_210_19 = arg_207_1:FormatText(var_210_18.content)

				arg_207_1.text_.text = var_210_19

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_20 = 39
				local var_210_21 = utf8.len(var_210_19)
				local var_210_22 = var_210_20 <= 0 and var_210_16 or var_210_16 * (var_210_21 / var_210_20)

				if var_210_22 > 0 and var_210_16 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22

					if var_210_22 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_19
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101050", "story_v_out_424101.awb") ~= 0 then
					local var_210_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101050", "story_v_out_424101.awb") / 1000

					if var_210_23 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_23 + var_210_15
					end

					if var_210_18.prefab_name ~= "" and arg_207_1.actors_[var_210_18.prefab_name] ~= nil then
						local var_210_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_18.prefab_name].transform, "story_v_out_424101", "424101050", "story_v_out_424101.awb")

						arg_207_1:RecordAudio("424101050", var_210_24)
						arg_207_1:RecordAudio("424101050", var_210_24)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_424101", "424101050", "story_v_out_424101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_424101", "424101050", "story_v_out_424101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_25 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_25 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_25

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_25 and arg_207_1.time_ < var_210_15 + var_210_25 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424101051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424101051
		arg_211_1.duration_ = 20.37

		local var_211_0 = {
			zh = 12.433,
			ja = 20.366
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
				arg_211_0:Play424101052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 1.35

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[1387].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(424101051)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101051", "story_v_out_424101.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101051", "story_v_out_424101.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_424101", "424101051", "story_v_out_424101.awb")

						arg_211_1:RecordAudio("424101051", var_214_9)
						arg_211_1:RecordAudio("424101051", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_424101", "424101051", "story_v_out_424101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_424101", "424101051", "story_v_out_424101.awb")
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
	Play424101052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424101052
		arg_215_1.duration_ = 12.3

		local var_215_0 = {
			zh = 11.966,
			ja = 12.3
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
				arg_215_0:Play424101053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10153"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10153 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10153", 3)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "split_3" then
						var_218_3:SetAsLastSibling()
						var_218_3.gameObject:SetActive(true)

						arg_215_1.var_.actorSpriteSplit10153 = var_218_3.gameObject:GetComponent(typeof(Image))

						arg_215_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_218_4 = 0.5

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(-60, -395, -330)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10153, var_218_6, var_218_5)

				if arg_215_1.var_.actorSpriteSplit10153 ~= nil then
					arg_215_1.var_.actorSpriteSplit10153:SetAlpha(var_218_5)
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(-60, -395, -330)

				if arg_215_1.var_.actorSpriteSplit10153 ~= nil then
					arg_215_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_218_7 = 0
			local var_218_8 = 1.075

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_9 = arg_215_1:FormatText(StoryNameCfg[1387].name)

				arg_215_1.leftNameTxt_.text = var_218_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(424101052)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_12 = 43
				local var_218_13 = utf8.len(var_218_11)
				local var_218_14 = var_218_12 <= 0 and var_218_8 or var_218_8 * (var_218_13 / var_218_12)

				if var_218_14 > 0 and var_218_8 < var_218_14 then
					arg_215_1.talkMaxDuration = var_218_14

					if var_218_14 + var_218_7 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_7
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101052", "story_v_out_424101.awb") ~= 0 then
					local var_218_15 = manager.audio:GetVoiceLength("story_v_out_424101", "424101052", "story_v_out_424101.awb") / 1000

					if var_218_15 + var_218_7 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_15 + var_218_7
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_424101", "424101052", "story_v_out_424101.awb")

						arg_215_1:RecordAudio("424101052", var_218_16)
						arg_215_1:RecordAudio("424101052", var_218_16)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_424101", "424101052", "story_v_out_424101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_424101", "424101052", "story_v_out_424101.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_17 = math.max(var_218_8, arg_215_1.talkMaxDuration)

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_17 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_7) / var_218_17

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_7 + var_218_17 and arg_215_1.time_ < var_218_7 + var_218_17 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play424101053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424101053
		arg_219_1.duration_ = 17.13

		local var_219_0 = {
			zh = 11.3,
			ja = 17.133
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
				arg_219_0:Play424101054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1094"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1094 == nil then
				arg_219_1.var_.actorSpriteComps1094 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps1094 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps1094 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps1094 = nil
			end

			local var_222_8 = arg_219_1.actors_["10153"]
			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps10153 == nil then
				arg_219_1.var_.actorSpriteComps10153 = var_222_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_10 = 0.2

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 and not isNil(var_222_8) then
				local var_222_11 = (arg_219_1.time_ - var_222_9) / var_222_10

				if arg_219_1.var_.actorSpriteComps10153 then
					for iter_222_4, iter_222_5 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 and not isNil(var_222_8) and arg_219_1.var_.actorSpriteComps10153 then
				for iter_222_6, iter_222_7 in pairs(arg_219_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_222_7 then
						if arg_219_1.isInRecall_ then
							iter_222_7.color = arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_222_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10153 = nil
			end

			local var_222_16 = arg_219_1.actors_["1094"].transform
			local var_222_17 = 0

			if var_222_17 < arg_219_1.time_ and arg_219_1.time_ <= var_222_17 + arg_222_0 then
				arg_219_1.var_.moveOldPos1094 = var_222_16.localPosition
				var_222_16.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1094", 4)

				local var_222_18 = var_222_16.childCount

				for iter_222_8 = 0, var_222_18 - 1 do
					local var_222_19 = var_222_16:GetChild(iter_222_8)

					if var_222_19.name == "split_4" or not string.find(var_222_19.name, "split") then
						var_222_19.gameObject:SetActive(true)
					else
						var_222_19.gameObject:SetActive(false)
					end
				end
			end

			local var_222_20 = 0.001

			if var_222_17 <= arg_219_1.time_ and arg_219_1.time_ < var_222_17 + var_222_20 then
				local var_222_21 = (arg_219_1.time_ - var_222_17) / var_222_20
				local var_222_22 = Vector3.New(470, -335, -230)

				var_222_16.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1094, var_222_22, var_222_21)
			end

			if arg_219_1.time_ >= var_222_17 + var_222_20 and arg_219_1.time_ < var_222_17 + var_222_20 + arg_222_0 then
				var_222_16.localPosition = Vector3.New(470, -335, -230)
			end

			local var_222_23 = arg_219_1.actors_["10153"].transform
			local var_222_24 = 0

			if var_222_24 < arg_219_1.time_ and arg_219_1.time_ <= var_222_24 + arg_222_0 then
				arg_219_1.var_.moveOldPos10153 = var_222_23.localPosition
				var_222_23.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10153", 2)

				local var_222_25 = var_222_23.childCount

				for iter_222_9 = 0, var_222_25 - 1 do
					local var_222_26 = var_222_23:GetChild(iter_222_9)

					if var_222_26.name == "" or not string.find(var_222_26.name, "split") then
						var_222_26.gameObject:SetActive(true)
					else
						var_222_26.gameObject:SetActive(false)
					end
				end
			end

			local var_222_27 = 0.001

			if var_222_24 <= arg_219_1.time_ and arg_219_1.time_ < var_222_24 + var_222_27 then
				local var_222_28 = (arg_219_1.time_ - var_222_24) / var_222_27
				local var_222_29 = Vector3.New(-400, -395, -330)

				var_222_23.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10153, var_222_29, var_222_28)
			end

			if arg_219_1.time_ >= var_222_24 + var_222_27 and arg_219_1.time_ < var_222_24 + var_222_27 + arg_222_0 then
				var_222_23.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_222_30 = 0
			local var_222_31 = 1.175

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_32 = arg_219_1:FormatText(StoryNameCfg[181].name)

				arg_219_1.leftNameTxt_.text = var_222_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_33 = arg_219_1:GetWordFromCfg(424101053)
				local var_222_34 = arg_219_1:FormatText(var_222_33.content)

				arg_219_1.text_.text = var_222_34

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_35 = 47
				local var_222_36 = utf8.len(var_222_34)
				local var_222_37 = var_222_35 <= 0 and var_222_31 or var_222_31 * (var_222_36 / var_222_35)

				if var_222_37 > 0 and var_222_31 < var_222_37 then
					arg_219_1.talkMaxDuration = var_222_37

					if var_222_37 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_37 + var_222_30
					end
				end

				arg_219_1.text_.text = var_222_34
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101053", "story_v_out_424101.awb") ~= 0 then
					local var_222_38 = manager.audio:GetVoiceLength("story_v_out_424101", "424101053", "story_v_out_424101.awb") / 1000

					if var_222_38 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_38 + var_222_30
					end

					if var_222_33.prefab_name ~= "" and arg_219_1.actors_[var_222_33.prefab_name] ~= nil then
						local var_222_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_33.prefab_name].transform, "story_v_out_424101", "424101053", "story_v_out_424101.awb")

						arg_219_1:RecordAudio("424101053", var_222_39)
						arg_219_1:RecordAudio("424101053", var_222_39)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_424101", "424101053", "story_v_out_424101.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_424101", "424101053", "story_v_out_424101.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_40 = math.max(var_222_31, arg_219_1.talkMaxDuration)

			if var_222_30 <= arg_219_1.time_ and arg_219_1.time_ < var_222_30 + var_222_40 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_30) / var_222_40

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_30 + var_222_40 and arg_219_1.time_ < var_222_30 + var_222_40 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10153",
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
	Play424101054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424101054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play424101055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1094"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1094 == nil then
				arg_223_1.var_.actorSpriteComps1094 = var_226_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.actorSpriteComps1094 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								local var_226_4 = Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor2.r, var_226_3)
								local var_226_5 = Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor2.g, var_226_3)
								local var_226_6 = Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor2.b, var_226_3)

								iter_226_1.color = Color.New(var_226_4, var_226_5, var_226_6)
							else
								local var_226_7 = Mathf.Lerp(iter_226_1.color.r, 0.5, var_226_3)

								iter_226_1.color = Color.New(var_226_7, var_226_7, var_226_7)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.actorSpriteComps1094 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_226_3 then
						if arg_223_1.isInRecall_ then
							iter_226_3.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1094 = nil
			end

			local var_226_8 = 0
			local var_226_9 = 0.475

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(424101054)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_12 = 19
				local var_226_13 = utf8.len(var_226_11)
				local var_226_14 = var_226_12 <= 0 and var_226_9 or var_226_9 * (var_226_13 / var_226_12)

				if var_226_14 > 0 and var_226_9 < var_226_14 then
					arg_223_1.talkMaxDuration = var_226_14

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_15 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_15 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_15

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_15 and arg_223_1.time_ < var_226_8 + var_226_15 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play424101055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424101055
		arg_227_1.duration_ = 14.5

		local var_227_0 = {
			zh = 8.5,
			ja = 14.5
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
				arg_227_0:Play424101056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1094"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1094 == nil then
				arg_227_1.var_.actorSpriteComps1094 = var_230_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.actorSpriteComps1094 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								local var_230_4 = Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, var_230_3)
								local var_230_5 = Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, var_230_3)
								local var_230_6 = Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, var_230_3)

								iter_230_1.color = Color.New(var_230_4, var_230_5, var_230_6)
							else
								local var_230_7 = Mathf.Lerp(iter_230_1.color.r, 1, var_230_3)

								iter_230_1.color = Color.New(var_230_7, var_230_7, var_230_7)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.actorSpriteComps1094 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_230_3 then
						if arg_227_1.isInRecall_ then
							iter_230_3.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1094 = nil
			end

			local var_230_8 = arg_227_1.actors_["1094"].transform
			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.var_.moveOldPos1094 = var_230_8.localPosition
				var_230_8.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1094", 4)

				local var_230_10 = var_230_8.childCount

				for iter_230_4 = 0, var_230_10 - 1 do
					local var_230_11 = var_230_8:GetChild(iter_230_4)

					if var_230_11.name == "split_1" then
						var_230_11:SetAsLastSibling()
						var_230_11.gameObject:SetActive(true)

						arg_227_1.var_.actorSpriteSplit1094 = var_230_11.gameObject:GetComponent(typeof(Image))

						arg_227_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_230_12 = 0.5

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_12 then
				local var_230_13 = (arg_227_1.time_ - var_230_9) / var_230_12
				local var_230_14 = Vector3.New(470, -335, -230)

				var_230_8.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1094, var_230_14, var_230_13)

				if arg_227_1.var_.actorSpriteSplit1094 ~= nil then
					arg_227_1.var_.actorSpriteSplit1094:SetAlpha(var_230_13)
				end
			end

			if arg_227_1.time_ >= var_230_9 + var_230_12 and arg_227_1.time_ < var_230_9 + var_230_12 + arg_230_0 then
				var_230_8.localPosition = Vector3.New(470, -335, -230)

				if arg_227_1.var_.actorSpriteSplit1094 ~= nil then
					arg_227_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_230_15 = 0
			local var_230_16 = 0.875

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[181].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(424101055)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 35
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101055", "story_v_out_424101.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101055", "story_v_out_424101.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_424101", "424101055", "story_v_out_424101.awb")

						arg_227_1:RecordAudio("424101055", var_230_24)
						arg_227_1:RecordAudio("424101055", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424101", "424101055", "story_v_out_424101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424101", "424101055", "story_v_out_424101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play424101056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 424101056
		arg_231_1.duration_ = 18.07

		local var_231_0 = {
			zh = 13.333,
			ja = 18.066
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play424101057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10153"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10153 == nil then
				arg_231_1.var_.actorSpriteComps10153 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10153 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10153 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_234_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10153 = nil
			end

			local var_234_8 = arg_231_1.actors_["1094"]
			local var_234_9 = 0

			if var_234_9 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1094 == nil then
				arg_231_1.var_.actorSpriteComps1094 = var_234_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_10 = 0.2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 and not isNil(var_234_8) then
				local var_234_11 = (arg_231_1.time_ - var_234_9) / var_234_10

				if arg_231_1.var_.actorSpriteComps1094 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								local var_234_12 = Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, var_234_11)
								local var_234_13 = Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, var_234_11)
								local var_234_14 = Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, var_234_11)

								iter_234_5.color = Color.New(var_234_12, var_234_13, var_234_14)
							else
								local var_234_15 = Mathf.Lerp(iter_234_5.color.r, 0.5, var_234_11)

								iter_234_5.color = Color.New(var_234_15, var_234_15, var_234_15)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.actorSpriteComps1094 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_234_7 then
						if arg_231_1.isInRecall_ then
							iter_234_7.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1094 = nil
			end

			local var_234_16 = arg_231_1.actors_["10153"].transform
			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.var_.moveOldPos10153 = var_234_16.localPosition
				var_234_16.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10153", 2)

				local var_234_18 = var_234_16.childCount

				for iter_234_8 = 0, var_234_18 - 1 do
					local var_234_19 = var_234_16:GetChild(iter_234_8)

					if var_234_19.name == "split_5" then
						var_234_19:SetAsLastSibling()
						var_234_19.gameObject:SetActive(true)

						arg_231_1.var_.actorSpriteSplit10153 = var_234_19.gameObject:GetComponent(typeof(Image))

						arg_231_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_234_20 = 0.5

			if var_234_17 <= arg_231_1.time_ and arg_231_1.time_ < var_234_17 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_17) / var_234_20
				local var_234_22 = Vector3.New(-400, -395, -330)

				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10153, var_234_22, var_234_21)

				if arg_231_1.var_.actorSpriteSplit10153 ~= nil then
					arg_231_1.var_.actorSpriteSplit10153:SetAlpha(var_234_21)
				end
			end

			if arg_231_1.time_ >= var_234_17 + var_234_20 and arg_231_1.time_ < var_234_17 + var_234_20 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(-400, -395, -330)

				if arg_231_1.var_.actorSpriteSplit10153 ~= nil then
					arg_231_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_234_23 = 0
			local var_234_24 = 1.2

			if var_234_23 < arg_231_1.time_ and arg_231_1.time_ <= var_234_23 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_25 = arg_231_1:FormatText(StoryNameCfg[1387].name)

				arg_231_1.leftNameTxt_.text = var_234_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(424101056)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 48
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_24 or var_234_24 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_24 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_23
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101056", "story_v_out_424101.awb") ~= 0 then
					local var_234_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101056", "story_v_out_424101.awb") / 1000

					if var_234_31 + var_234_23 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_31 + var_234_23
					end

					if var_234_26.prefab_name ~= "" and arg_231_1.actors_[var_234_26.prefab_name] ~= nil then
						local var_234_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_26.prefab_name].transform, "story_v_out_424101", "424101056", "story_v_out_424101.awb")

						arg_231_1:RecordAudio("424101056", var_234_32)
						arg_231_1:RecordAudio("424101056", var_234_32)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_424101", "424101056", "story_v_out_424101.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_424101", "424101056", "story_v_out_424101.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_33 = math.max(var_234_24, arg_231_1.talkMaxDuration)

			if var_234_23 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_33 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_33

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_33 and arg_231_1.time_ < var_234_23 + var_234_33 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play424101057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 424101057
		arg_235_1.duration_ = 4.57

		local var_235_0 = {
			zh = 4.233,
			ja = 4.566
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
				arg_235_0:Play424101058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1094"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1094 == nil then
				arg_235_1.var_.actorSpriteComps1094 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1094 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1094 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1094 = nil
			end

			local var_238_8 = arg_235_1.actors_["10153"]
			local var_238_9 = 0

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10153 == nil then
				arg_235_1.var_.actorSpriteComps10153 = var_238_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_10 = 0.2

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_10 and not isNil(var_238_8) then
				local var_238_11 = (arg_235_1.time_ - var_238_9) / var_238_10

				if arg_235_1.var_.actorSpriteComps10153 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_235_1.time_ >= var_238_9 + var_238_10 and arg_235_1.time_ < var_238_9 + var_238_10 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.actorSpriteComps10153 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_238_7 then
						if arg_235_1.isInRecall_ then
							iter_238_7.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps10153 = nil
			end

			local var_238_16 = arg_235_1.actors_["1094"].transform
			local var_238_17 = 0

			if var_238_17 < arg_235_1.time_ and arg_235_1.time_ <= var_238_17 + arg_238_0 then
				arg_235_1.var_.moveOldPos1094 = var_238_16.localPosition
				var_238_16.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1094", 4)

				local var_238_18 = var_238_16.childCount

				for iter_238_8 = 0, var_238_18 - 1 do
					local var_238_19 = var_238_16:GetChild(iter_238_8)

					if var_238_19.name == "split_3" then
						var_238_19:SetAsLastSibling()
						var_238_19.gameObject:SetActive(true)

						arg_235_1.var_.actorSpriteSplit1094 = var_238_19.gameObject:GetComponent(typeof(Image))

						arg_235_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_238_20 = 0.5

			if var_238_17 <= arg_235_1.time_ and arg_235_1.time_ < var_238_17 + var_238_20 then
				local var_238_21 = (arg_235_1.time_ - var_238_17) / var_238_20
				local var_238_22 = Vector3.New(470, -335, -230)

				var_238_16.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1094, var_238_22, var_238_21)

				if arg_235_1.var_.actorSpriteSplit1094 ~= nil then
					arg_235_1.var_.actorSpriteSplit1094:SetAlpha(var_238_21)
				end
			end

			if arg_235_1.time_ >= var_238_17 + var_238_20 and arg_235_1.time_ < var_238_17 + var_238_20 + arg_238_0 then
				var_238_16.localPosition = Vector3.New(470, -335, -230)

				if arg_235_1.var_.actorSpriteSplit1094 ~= nil then
					arg_235_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_238_23 = 0
			local var_238_24 = 0.4

			if var_238_23 < arg_235_1.time_ and arg_235_1.time_ <= var_238_23 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_25 = arg_235_1:FormatText(StoryNameCfg[181].name)

				arg_235_1.leftNameTxt_.text = var_238_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_26 = arg_235_1:GetWordFromCfg(424101057)
				local var_238_27 = arg_235_1:FormatText(var_238_26.content)

				arg_235_1.text_.text = var_238_27

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_28 = 16
				local var_238_29 = utf8.len(var_238_27)
				local var_238_30 = var_238_28 <= 0 and var_238_24 or var_238_24 * (var_238_29 / var_238_28)

				if var_238_30 > 0 and var_238_24 < var_238_30 then
					arg_235_1.talkMaxDuration = var_238_30

					if var_238_30 + var_238_23 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_30 + var_238_23
					end
				end

				arg_235_1.text_.text = var_238_27
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101057", "story_v_out_424101.awb") ~= 0 then
					local var_238_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101057", "story_v_out_424101.awb") / 1000

					if var_238_31 + var_238_23 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_31 + var_238_23
					end

					if var_238_26.prefab_name ~= "" and arg_235_1.actors_[var_238_26.prefab_name] ~= nil then
						local var_238_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_26.prefab_name].transform, "story_v_out_424101", "424101057", "story_v_out_424101.awb")

						arg_235_1:RecordAudio("424101057", var_238_32)
						arg_235_1:RecordAudio("424101057", var_238_32)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_424101", "424101057", "story_v_out_424101.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_424101", "424101057", "story_v_out_424101.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_33 = math.max(var_238_24, arg_235_1.talkMaxDuration)

			if var_238_23 <= arg_235_1.time_ and arg_235_1.time_ < var_238_23 + var_238_33 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_23) / var_238_33

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_23 + var_238_33 and arg_235_1.time_ < var_238_23 + var_238_33 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play424101058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424101058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play424101059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1094"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 == nil then
				arg_239_1.var_.actorSpriteComps1094 = var_242_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_2 = 0.2

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.actorSpriteComps1094 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.actorSpriteComps1094 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_242_3 then
						if arg_239_1.isInRecall_ then
							iter_242_3.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1094 = nil
			end

			local var_242_8 = 0
			local var_242_9 = 0.45

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_10 = arg_239_1:GetWordFromCfg(424101058)
				local var_242_11 = arg_239_1:FormatText(var_242_10.content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_12 = 18
				local var_242_13 = utf8.len(var_242_11)
				local var_242_14 = var_242_12 <= 0 and var_242_9 or var_242_9 * (var_242_13 / var_242_12)

				if var_242_14 > 0 and var_242_9 < var_242_14 then
					arg_239_1.talkMaxDuration = var_242_14

					if var_242_14 + var_242_8 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_8
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_15 = math.max(var_242_9, arg_239_1.talkMaxDuration)

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_15 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_8) / var_242_15

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_8 + var_242_15 and arg_239_1.time_ < var_242_8 + var_242_15 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play424101059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424101059
		arg_243_1.duration_ = 5.5

		local var_243_0 = {
			zh = 4.033,
			ja = 5.5
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play424101060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10153"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10153 == nil then
				arg_243_1.var_.actorSpriteComps10153 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10153 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 1, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10153 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10153 = nil
			end

			local var_246_8 = arg_243_1.actors_["10153"].transform
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.var_.moveOldPos10153 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10153", 2)

				local var_246_10 = var_246_8.childCount

				for iter_246_4 = 0, var_246_10 - 1 do
					local var_246_11 = var_246_8:GetChild(iter_246_4)

					if var_246_11.name == "split_1" then
						var_246_11:SetAsLastSibling()
						var_246_11.gameObject:SetActive(true)

						arg_243_1.var_.actorSpriteSplit10153 = var_246_11.gameObject:GetComponent(typeof(Image))

						arg_243_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_246_12 = 0.5

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_9) / var_246_12
				local var_246_14 = Vector3.New(-400, -395, -330)

				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10153, var_246_14, var_246_13)

				if arg_243_1.var_.actorSpriteSplit10153 ~= nil then
					arg_243_1.var_.actorSpriteSplit10153:SetAlpha(var_246_13)
				end
			end

			if arg_243_1.time_ >= var_246_9 + var_246_12 and arg_243_1.time_ < var_246_9 + var_246_12 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_243_1.var_.actorSpriteSplit10153 ~= nil then
					arg_243_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_246_15 = 0
			local var_246_16 = 0.475

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[1387].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(424101059)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 19
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101059", "story_v_out_424101.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101059", "story_v_out_424101.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_424101", "424101059", "story_v_out_424101.awb")

						arg_243_1:RecordAudio("424101059", var_246_24)
						arg_243_1:RecordAudio("424101059", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_424101", "424101059", "story_v_out_424101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_424101", "424101059", "story_v_out_424101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play424101060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424101060
		arg_247_1.duration_ = 3.1

		local var_247_0 = {
			zh = 3.1,
			ja = 2.433
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play424101061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1094"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1094 == nil then
				arg_247_1.var_.actorSpriteComps1094 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps1094 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 1, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps1094 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1094 = nil
			end

			local var_250_8 = arg_247_1.actors_["10153"]
			local var_250_9 = 0

			if var_250_9 < arg_247_1.time_ and arg_247_1.time_ <= var_250_9 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10153 == nil then
				arg_247_1.var_.actorSpriteComps10153 = var_250_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_10 = 0.2

			if var_250_9 <= arg_247_1.time_ and arg_247_1.time_ < var_250_9 + var_250_10 and not isNil(var_250_8) then
				local var_250_11 = (arg_247_1.time_ - var_250_9) / var_250_10

				if arg_247_1.var_.actorSpriteComps10153 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								local var_250_12 = Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, var_250_11)
								local var_250_13 = Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, var_250_11)
								local var_250_14 = Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, var_250_11)

								iter_250_5.color = Color.New(var_250_12, var_250_13, var_250_14)
							else
								local var_250_15 = Mathf.Lerp(iter_250_5.color.r, 0.5, var_250_11)

								iter_250_5.color = Color.New(var_250_15, var_250_15, var_250_15)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_9 + var_250_10 and arg_247_1.time_ < var_250_9 + var_250_10 + arg_250_0 and not isNil(var_250_8) and arg_247_1.var_.actorSpriteComps10153 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_250_7 then
						if arg_247_1.isInRecall_ then
							iter_250_7.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10153 = nil
			end

			local var_250_16 = arg_247_1.actors_["1094"].transform
			local var_250_17 = 0

			if var_250_17 < arg_247_1.time_ and arg_247_1.time_ <= var_250_17 + arg_250_0 then
				arg_247_1.var_.moveOldPos1094 = var_250_16.localPosition
				var_250_16.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1094", 4)

				local var_250_18 = var_250_16.childCount

				for iter_250_8 = 0, var_250_18 - 1 do
					local var_250_19 = var_250_16:GetChild(iter_250_8)

					if var_250_19.name == "split_4" then
						var_250_19:SetAsLastSibling()
						var_250_19.gameObject:SetActive(true)

						arg_247_1.var_.actorSpriteSplit1094 = var_250_19.gameObject:GetComponent(typeof(Image))

						arg_247_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_250_20 = 0.5

			if var_250_17 <= arg_247_1.time_ and arg_247_1.time_ < var_250_17 + var_250_20 then
				local var_250_21 = (arg_247_1.time_ - var_250_17) / var_250_20
				local var_250_22 = Vector3.New(470, -335, -230)

				var_250_16.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1094, var_250_22, var_250_21)

				if arg_247_1.var_.actorSpriteSplit1094 ~= nil then
					arg_247_1.var_.actorSpriteSplit1094:SetAlpha(var_250_21)
				end
			end

			if arg_247_1.time_ >= var_250_17 + var_250_20 and arg_247_1.time_ < var_250_17 + var_250_20 + arg_250_0 then
				var_250_16.localPosition = Vector3.New(470, -335, -230)

				if arg_247_1.var_.actorSpriteSplit1094 ~= nil then
					arg_247_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_250_23 = 0
			local var_250_24 = 0.225

			if var_250_23 < arg_247_1.time_ and arg_247_1.time_ <= var_250_23 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_25 = arg_247_1:FormatText(StoryNameCfg[181].name)

				arg_247_1.leftNameTxt_.text = var_250_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_26 = arg_247_1:GetWordFromCfg(424101060)
				local var_250_27 = arg_247_1:FormatText(var_250_26.content)

				arg_247_1.text_.text = var_250_27

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_28 = 9
				local var_250_29 = utf8.len(var_250_27)
				local var_250_30 = var_250_28 <= 0 and var_250_24 or var_250_24 * (var_250_29 / var_250_28)

				if var_250_30 > 0 and var_250_24 < var_250_30 then
					arg_247_1.talkMaxDuration = var_250_30

					if var_250_30 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_30 + var_250_23
					end
				end

				arg_247_1.text_.text = var_250_27
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101060", "story_v_out_424101.awb") ~= 0 then
					local var_250_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101060", "story_v_out_424101.awb") / 1000

					if var_250_31 + var_250_23 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_31 + var_250_23
					end

					if var_250_26.prefab_name ~= "" and arg_247_1.actors_[var_250_26.prefab_name] ~= nil then
						local var_250_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_26.prefab_name].transform, "story_v_out_424101", "424101060", "story_v_out_424101.awb")

						arg_247_1:RecordAudio("424101060", var_250_32)
						arg_247_1:RecordAudio("424101060", var_250_32)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_424101", "424101060", "story_v_out_424101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_424101", "424101060", "story_v_out_424101.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_33 = math.max(var_250_24, arg_247_1.talkMaxDuration)

			if var_250_23 <= arg_247_1.time_ and arg_247_1.time_ < var_250_23 + var_250_33 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_23) / var_250_33

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_23 + var_250_33 and arg_247_1.time_ < var_250_23 + var_250_33 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play424101061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424101061
		arg_251_1.duration_ = 7

		local var_251_0 = {
			zh = 7,
			ja = 5.833
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play424101062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10153"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 == nil then
				arg_251_1.var_.actorSpriteComps10153 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10153 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 1, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10153 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10153 = nil
			end

			local var_254_8 = arg_251_1.actors_["1094"]
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1094 == nil then
				arg_251_1.var_.actorSpriteComps1094 = var_254_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_10 = 0.2

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_10 and not isNil(var_254_8) then
				local var_254_11 = (arg_251_1.time_ - var_254_9) / var_254_10

				if arg_251_1.var_.actorSpriteComps1094 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								local var_254_12 = Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor2.r, var_254_11)
								local var_254_13 = Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor2.g, var_254_11)
								local var_254_14 = Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor2.b, var_254_11)

								iter_254_5.color = Color.New(var_254_12, var_254_13, var_254_14)
							else
								local var_254_15 = Mathf.Lerp(iter_254_5.color.r, 0.5, var_254_11)

								iter_254_5.color = Color.New(var_254_15, var_254_15, var_254_15)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_10 and arg_251_1.time_ < var_254_9 + var_254_10 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps1094 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_254_7 then
						if arg_251_1.isInRecall_ then
							iter_254_7.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1094 = nil
			end

			local var_254_16 = arg_251_1.actors_["10153"].transform
			local var_254_17 = 0

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.var_.moveOldPos10153 = var_254_16.localPosition
				var_254_16.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10153", 2)

				local var_254_18 = var_254_16.childCount

				for iter_254_8 = 0, var_254_18 - 1 do
					local var_254_19 = var_254_16:GetChild(iter_254_8)

					if var_254_19.name == "" or not string.find(var_254_19.name, "split") then
						var_254_19.gameObject:SetActive(true)
					else
						var_254_19.gameObject:SetActive(false)
					end
				end
			end

			local var_254_20 = 0.001

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_20 then
				local var_254_21 = (arg_251_1.time_ - var_254_17) / var_254_20
				local var_254_22 = Vector3.New(-400, -395, -330)

				var_254_16.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10153, var_254_22, var_254_21)
			end

			if arg_251_1.time_ >= var_254_17 + var_254_20 and arg_251_1.time_ < var_254_17 + var_254_20 + arg_254_0 then
				var_254_16.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_254_23 = 0
			local var_254_24 = 0.6

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[1387].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_26 = arg_251_1:GetWordFromCfg(424101061)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 25
				local var_254_29 = utf8.len(var_254_27)
				local var_254_30 = var_254_28 <= 0 and var_254_24 or var_254_24 * (var_254_29 / var_254_28)

				if var_254_30 > 0 and var_254_24 < var_254_30 then
					arg_251_1.talkMaxDuration = var_254_30

					if var_254_30 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_30 + var_254_23
					end
				end

				arg_251_1.text_.text = var_254_27
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101061", "story_v_out_424101.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101061", "story_v_out_424101.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_424101", "424101061", "story_v_out_424101.awb")

						arg_251_1:RecordAudio("424101061", var_254_32)
						arg_251_1:RecordAudio("424101061", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424101", "424101061", "story_v_out_424101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424101", "424101061", "story_v_out_424101.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_33 = math.max(var_254_24, arg_251_1.talkMaxDuration)

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_33 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_23) / var_254_33

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_23 + var_254_33 and arg_251_1.time_ < var_254_23 + var_254_33 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play424101062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424101062
		arg_255_1.duration_ = 5.73

		local var_255_0 = {
			zh = 3.033,
			ja = 5.733
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play424101063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1094"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1094 == nil then
				arg_255_1.var_.actorSpriteComps1094 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps1094 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1094 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1094 = nil
			end

			local var_258_8 = arg_255_1.actors_["10153"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps10153 == nil then
				arg_255_1.var_.actorSpriteComps10153 = var_258_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_10 = 0.2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.actorSpriteComps10153 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								local var_258_12 = Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, var_258_11)
								local var_258_13 = Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, var_258_11)
								local var_258_14 = Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, var_258_11)

								iter_258_5.color = Color.New(var_258_12, var_258_13, var_258_14)
							else
								local var_258_15 = Mathf.Lerp(iter_258_5.color.r, 0.5, var_258_11)

								iter_258_5.color = Color.New(var_258_15, var_258_15, var_258_15)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps10153 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10153 = nil
			end

			local var_258_16 = arg_255_1.actors_["1094"].transform
			local var_258_17 = 0

			if var_258_17 < arg_255_1.time_ and arg_255_1.time_ <= var_258_17 + arg_258_0 then
				arg_255_1.var_.moveOldPos1094 = var_258_16.localPosition
				var_258_16.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1094", 4)

				local var_258_18 = var_258_16.childCount

				for iter_258_8 = 0, var_258_18 - 1 do
					local var_258_19 = var_258_16:GetChild(iter_258_8)

					if var_258_19.name == "split_1" then
						var_258_19:SetAsLastSibling()
						var_258_19.gameObject:SetActive(true)

						arg_255_1.var_.actorSpriteSplit1094 = var_258_19.gameObject:GetComponent(typeof(Image))

						arg_255_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_258_20 = 0.5

			if var_258_17 <= arg_255_1.time_ and arg_255_1.time_ < var_258_17 + var_258_20 then
				local var_258_21 = (arg_255_1.time_ - var_258_17) / var_258_20
				local var_258_22 = Vector3.New(470, -335, -230)

				var_258_16.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1094, var_258_22, var_258_21)

				if arg_255_1.var_.actorSpriteSplit1094 ~= nil then
					arg_255_1.var_.actorSpriteSplit1094:SetAlpha(var_258_21)
				end
			end

			if arg_255_1.time_ >= var_258_17 + var_258_20 and arg_255_1.time_ < var_258_17 + var_258_20 + arg_258_0 then
				var_258_16.localPosition = Vector3.New(470, -335, -230)

				if arg_255_1.var_.actorSpriteSplit1094 ~= nil then
					arg_255_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_258_23 = 0
			local var_258_24 = 0.375

			if var_258_23 < arg_255_1.time_ and arg_255_1.time_ <= var_258_23 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_25 = arg_255_1:FormatText(StoryNameCfg[181].name)

				arg_255_1.leftNameTxt_.text = var_258_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_26 = arg_255_1:GetWordFromCfg(424101062)
				local var_258_27 = arg_255_1:FormatText(var_258_26.content)

				arg_255_1.text_.text = var_258_27

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_28 = 15
				local var_258_29 = utf8.len(var_258_27)
				local var_258_30 = var_258_28 <= 0 and var_258_24 or var_258_24 * (var_258_29 / var_258_28)

				if var_258_30 > 0 and var_258_24 < var_258_30 then
					arg_255_1.talkMaxDuration = var_258_30

					if var_258_30 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_30 + var_258_23
					end
				end

				arg_255_1.text_.text = var_258_27
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101062", "story_v_out_424101.awb") ~= 0 then
					local var_258_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101062", "story_v_out_424101.awb") / 1000

					if var_258_31 + var_258_23 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_31 + var_258_23
					end

					if var_258_26.prefab_name ~= "" and arg_255_1.actors_[var_258_26.prefab_name] ~= nil then
						local var_258_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_26.prefab_name].transform, "story_v_out_424101", "424101062", "story_v_out_424101.awb")

						arg_255_1:RecordAudio("424101062", var_258_32)
						arg_255_1:RecordAudio("424101062", var_258_32)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424101", "424101062", "story_v_out_424101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424101", "424101062", "story_v_out_424101.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_33 = math.max(var_258_24, arg_255_1.talkMaxDuration)

			if var_258_23 <= arg_255_1.time_ and arg_255_1.time_ < var_258_23 + var_258_33 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_23) / var_258_33

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_23 + var_258_33 and arg_255_1.time_ < var_258_23 + var_258_33 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play424101063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424101063
		arg_259_1.duration_ = 5.47

		local var_259_0 = {
			zh = 3.2,
			ja = 5.466
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play424101064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1094"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 == nil then
				arg_259_1.var_.actorSpriteComps1094 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps1094 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps1094 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps1094 = nil
			end

			local var_262_8 = 0

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			local var_262_9 = 0.3

			if arg_259_1.time_ >= var_262_8 + var_262_9 and arg_259_1.time_ < var_262_8 + var_262_9 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_10 = 0
			local var_262_11 = 0.375

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_12 = arg_259_1:FormatText(StoryNameCfg[177].name)

				arg_259_1.leftNameTxt_.text = var_262_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_13 = arg_259_1:GetWordFromCfg(424101063)
				local var_262_14 = arg_259_1:FormatText(var_262_13.content)

				arg_259_1.text_.text = var_262_14

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 15
				local var_262_16 = utf8.len(var_262_14)
				local var_262_17 = var_262_15 <= 0 and var_262_11 or var_262_11 * (var_262_16 / var_262_15)

				if var_262_17 > 0 and var_262_11 < var_262_17 then
					arg_259_1.talkMaxDuration = var_262_17

					if var_262_17 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_17 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_14
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101063", "story_v_out_424101.awb") ~= 0 then
					local var_262_18 = manager.audio:GetVoiceLength("story_v_out_424101", "424101063", "story_v_out_424101.awb") / 1000

					if var_262_18 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_10
					end

					if var_262_13.prefab_name ~= "" and arg_259_1.actors_[var_262_13.prefab_name] ~= nil then
						local var_262_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_13.prefab_name].transform, "story_v_out_424101", "424101063", "story_v_out_424101.awb")

						arg_259_1:RecordAudio("424101063", var_262_19)
						arg_259_1:RecordAudio("424101063", var_262_19)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_424101", "424101063", "story_v_out_424101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_424101", "424101063", "story_v_out_424101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_20 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_20 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_20

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_20 and arg_259_1.time_ < var_262_10 + var_262_20 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 25,
				className = "StoryShakeNode",
				duration = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(3, 3, 3)
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play424101064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424101064
		arg_263_1.duration_ = 8

		local var_263_0 = {
			zh = 8,
			ja = 7.833
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424101065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1094"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1094 == nil then
				arg_263_1.var_.actorSpriteComps1094 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps1094 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1094 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1094 = nil
			end

			local var_266_8 = arg_263_1.actors_["1094"].transform
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.var_.moveOldPos1094 = var_266_8.localPosition
				var_266_8.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1094", 4)

				local var_266_10 = var_266_8.childCount

				for iter_266_4 = 0, var_266_10 - 1 do
					local var_266_11 = var_266_8:GetChild(iter_266_4)

					if var_266_11.name == "" or not string.find(var_266_11.name, "split") then
						var_266_11.gameObject:SetActive(true)
					else
						var_266_11.gameObject:SetActive(false)
					end
				end
			end

			local var_266_12 = 0.001

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_12 then
				local var_266_13 = (arg_263_1.time_ - var_266_9) / var_266_12
				local var_266_14 = Vector3.New(470, -335, -230)

				var_266_8.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1094, var_266_14, var_266_13)
			end

			if arg_263_1.time_ >= var_266_9 + var_266_12 and arg_263_1.time_ < var_266_9 + var_266_12 + arg_266_0 then
				var_266_8.localPosition = Vector3.New(470, -335, -230)
			end

			local var_266_15 = 0
			local var_266_16 = 0.725

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[181].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(424101064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 29
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101064", "story_v_out_424101.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101064", "story_v_out_424101.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_424101", "424101064", "story_v_out_424101.awb")

						arg_263_1:RecordAudio("424101064", var_266_24)
						arg_263_1:RecordAudio("424101064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_424101", "424101064", "story_v_out_424101.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_424101", "424101064", "story_v_out_424101.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play424101065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424101065
		arg_267_1.duration_ = 12.9

		local var_267_0 = {
			zh = 10.033,
			ja = 12.9
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play424101066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10153"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 == nil then
				arg_267_1.var_.actorSpriteComps10153 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10153 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10153 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10153 = nil
			end

			local var_270_8 = arg_267_1.actors_["1094"]
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1094 == nil then
				arg_267_1.var_.actorSpriteComps1094 = var_270_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_10 = 0.2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 and not isNil(var_270_8) then
				local var_270_11 = (arg_267_1.time_ - var_270_9) / var_270_10

				if arg_267_1.var_.actorSpriteComps1094 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								local var_270_12 = Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, var_270_11)
								local var_270_13 = Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, var_270_11)
								local var_270_14 = Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, var_270_11)

								iter_270_5.color = Color.New(var_270_12, var_270_13, var_270_14)
							else
								local var_270_15 = Mathf.Lerp(iter_270_5.color.r, 0.5, var_270_11)

								iter_270_5.color = Color.New(var_270_15, var_270_15, var_270_15)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1094 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_270_7 then
						if arg_267_1.isInRecall_ then
							iter_270_7.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1094 = nil
			end

			local var_270_16 = arg_267_1.actors_["10153"].transform
			local var_270_17 = 0

			if var_270_17 < arg_267_1.time_ and arg_267_1.time_ <= var_270_17 + arg_270_0 then
				arg_267_1.var_.moveOldPos10153 = var_270_16.localPosition
				var_270_16.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10153", 2)

				local var_270_18 = var_270_16.childCount

				for iter_270_8 = 0, var_270_18 - 1 do
					local var_270_19 = var_270_16:GetChild(iter_270_8)

					if var_270_19.name == "" or not string.find(var_270_19.name, "split") then
						var_270_19.gameObject:SetActive(true)
					else
						var_270_19.gameObject:SetActive(false)
					end
				end
			end

			local var_270_20 = 0.001

			if var_270_17 <= arg_267_1.time_ and arg_267_1.time_ < var_270_17 + var_270_20 then
				local var_270_21 = (arg_267_1.time_ - var_270_17) / var_270_20
				local var_270_22 = Vector3.New(-400, -395, -330)

				var_270_16.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10153, var_270_22, var_270_21)
			end

			if arg_267_1.time_ >= var_270_17 + var_270_20 and arg_267_1.time_ < var_270_17 + var_270_20 + arg_270_0 then
				var_270_16.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_270_23 = 0
			local var_270_24 = 1.175

			if var_270_23 < arg_267_1.time_ and arg_267_1.time_ <= var_270_23 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_25 = arg_267_1:FormatText(StoryNameCfg[1387].name)

				arg_267_1.leftNameTxt_.text = var_270_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_26 = arg_267_1:GetWordFromCfg(424101065)
				local var_270_27 = arg_267_1:FormatText(var_270_26.content)

				arg_267_1.text_.text = var_270_27

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_28 = 47
				local var_270_29 = utf8.len(var_270_27)
				local var_270_30 = var_270_28 <= 0 and var_270_24 or var_270_24 * (var_270_29 / var_270_28)

				if var_270_30 > 0 and var_270_24 < var_270_30 then
					arg_267_1.talkMaxDuration = var_270_30

					if var_270_30 + var_270_23 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_30 + var_270_23
					end
				end

				arg_267_1.text_.text = var_270_27
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101065", "story_v_out_424101.awb") ~= 0 then
					local var_270_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101065", "story_v_out_424101.awb") / 1000

					if var_270_31 + var_270_23 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_31 + var_270_23
					end

					if var_270_26.prefab_name ~= "" and arg_267_1.actors_[var_270_26.prefab_name] ~= nil then
						local var_270_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_26.prefab_name].transform, "story_v_out_424101", "424101065", "story_v_out_424101.awb")

						arg_267_1:RecordAudio("424101065", var_270_32)
						arg_267_1:RecordAudio("424101065", var_270_32)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424101", "424101065", "story_v_out_424101.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424101", "424101065", "story_v_out_424101.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_33 = math.max(var_270_24, arg_267_1.talkMaxDuration)

			if var_270_23 <= arg_267_1.time_ and arg_267_1.time_ < var_270_23 + var_270_33 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_23) / var_270_33

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_23 + var_270_33 and arg_267_1.time_ < var_270_23 + var_270_33 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play424101066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424101066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424101067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10153"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 == nil then
				arg_271_1.var_.actorSpriteComps10153 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10153 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 0.5, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10153 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10153 = nil
			end

			local var_274_8 = 0
			local var_274_9 = 1.4

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(424101066)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_12 = 56
				local var_274_13 = utf8.len(var_274_11)
				local var_274_14 = var_274_12 <= 0 and var_274_9 or var_274_9 * (var_274_13 / var_274_12)

				if var_274_14 > 0 and var_274_9 < var_274_14 then
					arg_271_1.talkMaxDuration = var_274_14

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_15 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_15 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_15

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_15 and arg_271_1.time_ < var_274_8 + var_274_15 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play424101067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424101067
		arg_275_1.duration_ = 3.37

		local var_275_0 = {
			zh = 3.366,
			ja = 3.3
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play424101068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1094"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1094 == nil then
				arg_275_1.var_.actorSpriteComps1094 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1094 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1094 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1094 = nil
			end

			local var_278_8 = arg_275_1.actors_["1094"].transform
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 then
				arg_275_1.var_.moveOldPos1094 = var_278_8.localPosition
				var_278_8.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("1094", 4)

				local var_278_10 = var_278_8.childCount

				for iter_278_4 = 0, var_278_10 - 1 do
					local var_278_11 = var_278_8:GetChild(iter_278_4)

					if var_278_11.name == "split_4" then
						var_278_11:SetAsLastSibling()
						var_278_11.gameObject:SetActive(true)

						arg_275_1.var_.actorSpriteSplit1094 = var_278_11.gameObject:GetComponent(typeof(Image))

						arg_275_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_278_12 = 0.5

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_12 then
				local var_278_13 = (arg_275_1.time_ - var_278_9) / var_278_12
				local var_278_14 = Vector3.New(470, -335, -230)

				var_278_8.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1094, var_278_14, var_278_13)

				if arg_275_1.var_.actorSpriteSplit1094 ~= nil then
					arg_275_1.var_.actorSpriteSplit1094:SetAlpha(var_278_13)
				end
			end

			if arg_275_1.time_ >= var_278_9 + var_278_12 and arg_275_1.time_ < var_278_9 + var_278_12 + arg_278_0 then
				var_278_8.localPosition = Vector3.New(470, -335, -230)

				if arg_275_1.var_.actorSpriteSplit1094 ~= nil then
					arg_275_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_278_15 = 0
			local var_278_16 = 0.325

			if var_278_15 < arg_275_1.time_ and arg_275_1.time_ <= var_278_15 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_17 = arg_275_1:FormatText(StoryNameCfg[181].name)

				arg_275_1.leftNameTxt_.text = var_278_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_18 = arg_275_1:GetWordFromCfg(424101067)
				local var_278_19 = arg_275_1:FormatText(var_278_18.content)

				arg_275_1.text_.text = var_278_19

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_20 = 13
				local var_278_21 = utf8.len(var_278_19)
				local var_278_22 = var_278_20 <= 0 and var_278_16 or var_278_16 * (var_278_21 / var_278_20)

				if var_278_22 > 0 and var_278_16 < var_278_22 then
					arg_275_1.talkMaxDuration = var_278_22

					if var_278_22 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_22 + var_278_15
					end
				end

				arg_275_1.text_.text = var_278_19
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101067", "story_v_out_424101.awb") ~= 0 then
					local var_278_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101067", "story_v_out_424101.awb") / 1000

					if var_278_23 + var_278_15 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_15
					end

					if var_278_18.prefab_name ~= "" and arg_275_1.actors_[var_278_18.prefab_name] ~= nil then
						local var_278_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_18.prefab_name].transform, "story_v_out_424101", "424101067", "story_v_out_424101.awb")

						arg_275_1:RecordAudio("424101067", var_278_24)
						arg_275_1:RecordAudio("424101067", var_278_24)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_424101", "424101067", "story_v_out_424101.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_424101", "424101067", "story_v_out_424101.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_25 = math.max(var_278_16, arg_275_1.talkMaxDuration)

			if var_278_15 <= arg_275_1.time_ and arg_275_1.time_ < var_278_15 + var_278_25 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_15) / var_278_25

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_15 + var_278_25 and arg_275_1.time_ < var_278_15 + var_278_25 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play424101068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424101068
		arg_279_1.duration_ = 5.4

		local var_279_0 = {
			zh = 4.1,
			ja = 5.4
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play424101069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10153"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10153 == nil then
				arg_279_1.var_.actorSpriteComps10153 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10153 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10153 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10153 = nil
			end

			local var_282_8 = arg_279_1.actors_["1094"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1094 == nil then
				arg_279_1.var_.actorSpriteComps1094 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 0.2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps1094 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								local var_282_12 = Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, var_282_11)
								local var_282_13 = Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, var_282_11)
								local var_282_14 = Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, var_282_11)

								iter_282_5.color = Color.New(var_282_12, var_282_13, var_282_14)
							else
								local var_282_15 = Mathf.Lerp(iter_282_5.color.r, 0.5, var_282_11)

								iter_282_5.color = Color.New(var_282_15, var_282_15, var_282_15)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps1094 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1094 = nil
			end

			local var_282_16 = arg_279_1.actors_["10153"].transform
			local var_282_17 = 0

			if var_282_17 < arg_279_1.time_ and arg_279_1.time_ <= var_282_17 + arg_282_0 then
				arg_279_1.var_.moveOldPos10153 = var_282_16.localPosition
				var_282_16.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("10153", 2)

				local var_282_18 = var_282_16.childCount

				for iter_282_8 = 0, var_282_18 - 1 do
					local var_282_19 = var_282_16:GetChild(iter_282_8)

					if var_282_19.name == "split_3" then
						var_282_19:SetAsLastSibling()
						var_282_19.gameObject:SetActive(true)

						arg_279_1.var_.actorSpriteSplit10153 = var_282_19.gameObject:GetComponent(typeof(Image))

						arg_279_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_282_20 = 0.5

			if var_282_17 <= arg_279_1.time_ and arg_279_1.time_ < var_282_17 + var_282_20 then
				local var_282_21 = (arg_279_1.time_ - var_282_17) / var_282_20
				local var_282_22 = Vector3.New(-400, -395, -330)

				var_282_16.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10153, var_282_22, var_282_21)

				if arg_279_1.var_.actorSpriteSplit10153 ~= nil then
					arg_279_1.var_.actorSpriteSplit10153:SetAlpha(var_282_21)
				end
			end

			if arg_279_1.time_ >= var_282_17 + var_282_20 and arg_279_1.time_ < var_282_17 + var_282_20 + arg_282_0 then
				var_282_16.localPosition = Vector3.New(-400, -395, -330)

				if arg_279_1.var_.actorSpriteSplit10153 ~= nil then
					arg_279_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_282_23 = 0
			local var_282_24 = 0.375

			if var_282_23 < arg_279_1.time_ and arg_279_1.time_ <= var_282_23 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_25 = arg_279_1:FormatText(StoryNameCfg[1387].name)

				arg_279_1.leftNameTxt_.text = var_282_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_26 = arg_279_1:GetWordFromCfg(424101068)
				local var_282_27 = arg_279_1:FormatText(var_282_26.content)

				arg_279_1.text_.text = var_282_27

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_28 = 15
				local var_282_29 = utf8.len(var_282_27)
				local var_282_30 = var_282_28 <= 0 and var_282_24 or var_282_24 * (var_282_29 / var_282_28)

				if var_282_30 > 0 and var_282_24 < var_282_30 then
					arg_279_1.talkMaxDuration = var_282_30

					if var_282_30 + var_282_23 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_30 + var_282_23
					end
				end

				arg_279_1.text_.text = var_282_27
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101068", "story_v_out_424101.awb") ~= 0 then
					local var_282_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101068", "story_v_out_424101.awb") / 1000

					if var_282_31 + var_282_23 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_31 + var_282_23
					end

					if var_282_26.prefab_name ~= "" and arg_279_1.actors_[var_282_26.prefab_name] ~= nil then
						local var_282_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_26.prefab_name].transform, "story_v_out_424101", "424101068", "story_v_out_424101.awb")

						arg_279_1:RecordAudio("424101068", var_282_32)
						arg_279_1:RecordAudio("424101068", var_282_32)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_424101", "424101068", "story_v_out_424101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_424101", "424101068", "story_v_out_424101.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_33 = math.max(var_282_24, arg_279_1.talkMaxDuration)

			if var_282_23 <= arg_279_1.time_ and arg_279_1.time_ < var_282_23 + var_282_33 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_23) / var_282_33

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_23 + var_282_33 and arg_279_1.time_ < var_282_23 + var_282_33 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play424101069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 424101069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play424101070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10153"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10153 == nil then
				arg_283_1.var_.actorSpriteComps10153 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10153 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10153 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10153 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 1.175

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_11 = arg_283_1:GetWordFromCfg(424101069)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 47
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play424101070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 424101070
		arg_287_1.duration_ = 9.3

		local var_287_0 = {
			zh = 6.666,
			ja = 9.3
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
				arg_287_0:Play424101071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10153"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10153 == nil then
				arg_287_1.var_.actorSpriteComps10153 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10153 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor1.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor1.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor1.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 1, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10153 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10153 = nil
			end

			local var_290_8 = arg_287_1.actors_["10153"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos10153 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10153", 2)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(-400, -395, -330)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10153, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_290_15 = 0
			local var_290_16 = 0.625

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[1387].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(424101070)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101070", "story_v_out_424101.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101070", "story_v_out_424101.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_424101", "424101070", "story_v_out_424101.awb")

						arg_287_1:RecordAudio("424101070", var_290_24)
						arg_287_1:RecordAudio("424101070", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_424101", "424101070", "story_v_out_424101.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_424101", "424101070", "story_v_out_424101.awb")
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
				actorName = "10153",
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
	Play424101071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 424101071
		arg_291_1.duration_ = 4.33

		local var_291_0 = {
			zh = 3.233,
			ja = 4.333
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
				arg_291_0:Play424101072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1094"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1094 == nil then
				arg_291_1.var_.actorSpriteComps1094 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1094 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor1.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor1.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor1.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 1, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1094 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1094 = nil
			end

			local var_294_8 = arg_291_1.actors_["10153"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10153 == nil then
				arg_291_1.var_.actorSpriteComps10153 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 0.2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps10153 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_294_5 then
							if arg_291_1.isInRecall_ then
								local var_294_12 = Mathf.Lerp(iter_294_5.color.r, arg_291_1.hightColor2.r, var_294_11)
								local var_294_13 = Mathf.Lerp(iter_294_5.color.g, arg_291_1.hightColor2.g, var_294_11)
								local var_294_14 = Mathf.Lerp(iter_294_5.color.b, arg_291_1.hightColor2.b, var_294_11)

								iter_294_5.color = Color.New(var_294_12, var_294_13, var_294_14)
							else
								local var_294_15 = Mathf.Lerp(iter_294_5.color.r, 0.5, var_294_11)

								iter_294_5.color = Color.New(var_294_15, var_294_15, var_294_15)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10153 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10153 = nil
			end

			local var_294_16 = arg_291_1.actors_["1094"].transform
			local var_294_17 = 0

			if var_294_17 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.var_.moveOldPos1094 = var_294_16.localPosition
				var_294_16.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1094", 4)

				local var_294_18 = var_294_16.childCount

				for iter_294_8 = 0, var_294_18 - 1 do
					local var_294_19 = var_294_16:GetChild(iter_294_8)

					if var_294_19.name == "split_3" then
						var_294_19:SetAsLastSibling()
						var_294_19.gameObject:SetActive(true)

						arg_291_1.var_.actorSpriteSplit1094 = var_294_19.gameObject:GetComponent(typeof(Image))

						arg_291_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_294_20 = 0.5

			if var_294_17 <= arg_291_1.time_ and arg_291_1.time_ < var_294_17 + var_294_20 then
				local var_294_21 = (arg_291_1.time_ - var_294_17) / var_294_20
				local var_294_22 = Vector3.New(470, -335, -230)

				var_294_16.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1094, var_294_22, var_294_21)

				if arg_291_1.var_.actorSpriteSplit1094 ~= nil then
					arg_291_1.var_.actorSpriteSplit1094:SetAlpha(var_294_21)
				end
			end

			if arg_291_1.time_ >= var_294_17 + var_294_20 and arg_291_1.time_ < var_294_17 + var_294_20 + arg_294_0 then
				var_294_16.localPosition = Vector3.New(470, -335, -230)

				if arg_291_1.var_.actorSpriteSplit1094 ~= nil then
					arg_291_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_294_23 = 0
			local var_294_24 = 0.3

			if var_294_23 < arg_291_1.time_ and arg_291_1.time_ <= var_294_23 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_25 = arg_291_1:FormatText(StoryNameCfg[181].name)

				arg_291_1.leftNameTxt_.text = var_294_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_26 = arg_291_1:GetWordFromCfg(424101071)
				local var_294_27 = arg_291_1:FormatText(var_294_26.content)

				arg_291_1.text_.text = var_294_27

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_28 = 12
				local var_294_29 = utf8.len(var_294_27)
				local var_294_30 = var_294_28 <= 0 and var_294_24 or var_294_24 * (var_294_29 / var_294_28)

				if var_294_30 > 0 and var_294_24 < var_294_30 then
					arg_291_1.talkMaxDuration = var_294_30

					if var_294_30 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_30 + var_294_23
					end
				end

				arg_291_1.text_.text = var_294_27
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101071", "story_v_out_424101.awb") ~= 0 then
					local var_294_31 = manager.audio:GetVoiceLength("story_v_out_424101", "424101071", "story_v_out_424101.awb") / 1000

					if var_294_31 + var_294_23 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_31 + var_294_23
					end

					if var_294_26.prefab_name ~= "" and arg_291_1.actors_[var_294_26.prefab_name] ~= nil then
						local var_294_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_26.prefab_name].transform, "story_v_out_424101", "424101071", "story_v_out_424101.awb")

						arg_291_1:RecordAudio("424101071", var_294_32)
						arg_291_1:RecordAudio("424101071", var_294_32)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_424101", "424101071", "story_v_out_424101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_424101", "424101071", "story_v_out_424101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_33 = math.max(var_294_24, arg_291_1.talkMaxDuration)

			if var_294_23 <= arg_291_1.time_ and arg_291_1.time_ < var_294_23 + var_294_33 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_23) / var_294_33

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_23 + var_294_33 and arg_291_1.time_ < var_294_23 + var_294_33 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play424101072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 424101072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play424101073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1094"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1094 == nil then
				arg_295_1.var_.actorSpriteComps1094 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps1094 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor2.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor2.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor2.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 0.5, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps1094 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1094 = nil
			end

			local var_298_8 = 0
			local var_298_9 = 0.7

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:GetWordFromCfg(424101072)
				local var_298_11 = arg_295_1:FormatText(var_298_10.content)

				arg_295_1.text_.text = var_298_11

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_12 = 28
				local var_298_13 = utf8.len(var_298_11)
				local var_298_14 = var_298_12 <= 0 and var_298_9 or var_298_9 * (var_298_13 / var_298_12)

				if var_298_14 > 0 and var_298_9 < var_298_14 then
					arg_295_1.talkMaxDuration = var_298_14

					if var_298_14 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_14 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_11
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_15 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_15 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_15

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_15 and arg_295_1.time_ < var_298_8 + var_298_15 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play424101073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 424101073
		arg_299_1.duration_ = 9.47

		local var_299_0 = {
			zh = 8.033,
			ja = 9.466
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
				arg_299_0:Play424101074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10153"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10153 == nil then
				arg_299_1.var_.actorSpriteComps10153 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 0.2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps10153 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								local var_302_4 = Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, var_302_3)
								local var_302_5 = Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, var_302_3)
								local var_302_6 = Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, var_302_3)

								iter_302_1.color = Color.New(var_302_4, var_302_5, var_302_6)
							else
								local var_302_7 = Mathf.Lerp(iter_302_1.color.r, 1, var_302_3)

								iter_302_1.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10153 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10153 = nil
			end

			local var_302_8 = arg_299_1.actors_["10153"].transform
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 then
				arg_299_1.var_.moveOldPos10153 = var_302_8.localPosition
				var_302_8.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10153", 2)

				local var_302_10 = var_302_8.childCount

				for iter_302_4 = 0, var_302_10 - 1 do
					local var_302_11 = var_302_8:GetChild(iter_302_4)

					if var_302_11.name == "split_4" then
						var_302_11:SetAsLastSibling()
						var_302_11.gameObject:SetActive(true)

						arg_299_1.var_.actorSpriteSplit10153 = var_302_11.gameObject:GetComponent(typeof(Image))

						arg_299_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_302_12 = 0.5

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_12 then
				local var_302_13 = (arg_299_1.time_ - var_302_9) / var_302_12
				local var_302_14 = Vector3.New(-400, -395, -330)

				var_302_8.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10153, var_302_14, var_302_13)

				if arg_299_1.var_.actorSpriteSplit10153 ~= nil then
					arg_299_1.var_.actorSpriteSplit10153:SetAlpha(var_302_13)
				end
			end

			if arg_299_1.time_ >= var_302_9 + var_302_12 and arg_299_1.time_ < var_302_9 + var_302_12 + arg_302_0 then
				var_302_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_299_1.var_.actorSpriteSplit10153 ~= nil then
					arg_299_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_302_15 = 0
			local var_302_16 = 0.8

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[1387].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(424101073)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101073", "story_v_out_424101.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101073", "story_v_out_424101.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_424101", "424101073", "story_v_out_424101.awb")

						arg_299_1:RecordAudio("424101073", var_302_24)
						arg_299_1:RecordAudio("424101073", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_424101", "424101073", "story_v_out_424101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_424101", "424101073", "story_v_out_424101.awb")
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play424101074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 424101074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play424101075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10153"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10153 == nil then
				arg_303_1.var_.actorSpriteComps10153 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps10153 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor2.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor2.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor2.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 0.5, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10153 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10153 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 1.35

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(424101074)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_12 = 54
				local var_306_13 = utf8.len(var_306_11)
				local var_306_14 = var_306_12 <= 0 and var_306_9 or var_306_9 * (var_306_13 / var_306_12)

				if var_306_14 > 0 and var_306_9 < var_306_14 then
					arg_303_1.talkMaxDuration = var_306_14

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_15 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_15 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_15

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_15 and arg_303_1.time_ < var_306_8 + var_306_15 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play424101075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 424101075
		arg_307_1.duration_ = 16.8

		local var_307_0 = {
			zh = 14.8,
			ja = 16.8
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
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play424101076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10153"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10153 == nil then
				arg_307_1.var_.actorSpriteComps10153 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10153 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								local var_310_4 = Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor1.r, var_310_3)
								local var_310_5 = Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor1.g, var_310_3)
								local var_310_6 = Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor1.b, var_310_3)

								iter_310_1.color = Color.New(var_310_4, var_310_5, var_310_6)
							else
								local var_310_7 = Mathf.Lerp(iter_310_1.color.r, 1, var_310_3)

								iter_310_1.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10153 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10153 = nil
			end

			local var_310_8 = arg_307_1.actors_["10153"].transform
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 then
				arg_307_1.var_.moveOldPos10153 = var_310_8.localPosition
				var_310_8.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10153", 2)

				local var_310_10 = var_310_8.childCount

				for iter_310_4 = 0, var_310_10 - 1 do
					local var_310_11 = var_310_8:GetChild(iter_310_4)

					if var_310_11.name == "split_1" then
						var_310_11:SetAsLastSibling()
						var_310_11.gameObject:SetActive(true)

						arg_307_1.var_.actorSpriteSplit10153 = var_310_11.gameObject:GetComponent(typeof(Image))

						arg_307_1.var_.actorSpriteSplit10153:SetAlpha(0)
					end
				end
			end

			local var_310_12 = 0.5

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_12 then
				local var_310_13 = (arg_307_1.time_ - var_310_9) / var_310_12
				local var_310_14 = Vector3.New(-400, -395, -330)

				var_310_8.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10153, var_310_14, var_310_13)

				if arg_307_1.var_.actorSpriteSplit10153 ~= nil then
					arg_307_1.var_.actorSpriteSplit10153:SetAlpha(var_310_13)
				end
			end

			if arg_307_1.time_ >= var_310_9 + var_310_12 and arg_307_1.time_ < var_310_9 + var_310_12 + arg_310_0 then
				var_310_8.localPosition = Vector3.New(-400, -395, -330)

				if arg_307_1.var_.actorSpriteSplit10153 ~= nil then
					arg_307_1.var_.actorSpriteSplit10153:SetAlpha(1)
				end
			end

			local var_310_15 = 0
			local var_310_16 = 1.35

			if var_310_15 < arg_307_1.time_ and arg_307_1.time_ <= var_310_15 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_17 = arg_307_1:FormatText(StoryNameCfg[1387].name)

				arg_307_1.leftNameTxt_.text = var_310_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_18 = arg_307_1:GetWordFromCfg(424101075)
				local var_310_19 = arg_307_1:FormatText(var_310_18.content)

				arg_307_1.text_.text = var_310_19

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_20 = 55
				local var_310_21 = utf8.len(var_310_19)
				local var_310_22 = var_310_20 <= 0 and var_310_16 or var_310_16 * (var_310_21 / var_310_20)

				if var_310_22 > 0 and var_310_16 < var_310_22 then
					arg_307_1.talkMaxDuration = var_310_22

					if var_310_22 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_22 + var_310_15
					end
				end

				arg_307_1.text_.text = var_310_19
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101075", "story_v_out_424101.awb") ~= 0 then
					local var_310_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101075", "story_v_out_424101.awb") / 1000

					if var_310_23 + var_310_15 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_15
					end

					if var_310_18.prefab_name ~= "" and arg_307_1.actors_[var_310_18.prefab_name] ~= nil then
						local var_310_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_18.prefab_name].transform, "story_v_out_424101", "424101075", "story_v_out_424101.awb")

						arg_307_1:RecordAudio("424101075", var_310_24)
						arg_307_1:RecordAudio("424101075", var_310_24)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_424101", "424101075", "story_v_out_424101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_424101", "424101075", "story_v_out_424101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_25 = math.max(var_310_16, arg_307_1.talkMaxDuration)

			if var_310_15 <= arg_307_1.time_ and arg_307_1.time_ < var_310_15 + var_310_25 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_15) / var_310_25

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_15 + var_310_25 and arg_307_1.time_ < var_310_15 + var_310_25 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play424101076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 424101076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play424101077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10153"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10153 == nil then
				arg_311_1.var_.actorSpriteComps10153 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps10153 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 0.5, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10153 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10153 = nil
			end

			local var_314_8 = arg_311_1.actors_["10153"].transform
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.var_.moveOldPos10153 = var_314_8.localPosition
				var_314_8.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10153", 7)

				local var_314_10 = var_314_8.childCount

				for iter_314_4 = 0, var_314_10 - 1 do
					local var_314_11 = var_314_8:GetChild(iter_314_4)

					if var_314_11.name == "" or not string.find(var_314_11.name, "split") then
						var_314_11.gameObject:SetActive(true)
					else
						var_314_11.gameObject:SetActive(false)
					end
				end
			end

			local var_314_12 = 0.001

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_12 then
				local var_314_13 = (arg_311_1.time_ - var_314_9) / var_314_12
				local var_314_14 = Vector3.New(0, -2000, 0)

				var_314_8.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10153, var_314_14, var_314_13)
			end

			if arg_311_1.time_ >= var_314_9 + var_314_12 and arg_311_1.time_ < var_314_9 + var_314_12 + arg_314_0 then
				var_314_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_314_15 = arg_311_1.actors_["1094"].transform
			local var_314_16 = 0

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.var_.moveOldPos1094 = var_314_15.localPosition
				var_314_15.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1094", 7)

				local var_314_17 = var_314_15.childCount

				for iter_314_5 = 0, var_314_17 - 1 do
					local var_314_18 = var_314_15:GetChild(iter_314_5)

					if var_314_18.name == "" or not string.find(var_314_18.name, "split") then
						var_314_18.gameObject:SetActive(true)
					else
						var_314_18.gameObject:SetActive(false)
					end
				end
			end

			local var_314_19 = 0.001

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_19 then
				local var_314_20 = (arg_311_1.time_ - var_314_16) / var_314_19
				local var_314_21 = Vector3.New(0, -2000, 0)

				var_314_15.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1094, var_314_21, var_314_20)
			end

			if arg_311_1.time_ >= var_314_16 + var_314_19 and arg_311_1.time_ < var_314_16 + var_314_19 + arg_314_0 then
				var_314_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_314_22 = 0.1
			local var_314_23 = 1

			if var_314_22 < arg_311_1.time_ and arg_311_1.time_ <= var_314_22 + arg_314_0 then
				local var_314_24 = "play"
				local var_314_25 = "effect"

				arg_311_1:AudioAction(var_314_24, var_314_25, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_314_26 = 0
			local var_314_27 = 1.275

			if var_314_26 < arg_311_1.time_ and arg_311_1.time_ <= var_314_26 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_28 = arg_311_1:GetWordFromCfg(424101076)
				local var_314_29 = arg_311_1:FormatText(var_314_28.content)

				arg_311_1.text_.text = var_314_29

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_30 = 51
				local var_314_31 = utf8.len(var_314_29)
				local var_314_32 = var_314_30 <= 0 and var_314_27 or var_314_27 * (var_314_31 / var_314_30)

				if var_314_32 > 0 and var_314_27 < var_314_32 then
					arg_311_1.talkMaxDuration = var_314_32

					if var_314_32 + var_314_26 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_32 + var_314_26
					end
				end

				arg_311_1.text_.text = var_314_29
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_33 = math.max(var_314_27, arg_311_1.talkMaxDuration)

			if var_314_26 <= arg_311_1.time_ and arg_311_1.time_ < var_314_26 + var_314_33 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_26) / var_314_33

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_26 + var_314_33 and arg_311_1.time_ < var_314_26 + var_314_33 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play424101077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 424101077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play424101078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 1.525

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_2 = arg_315_1:GetWordFromCfg(424101077)
				local var_318_3 = arg_315_1:FormatText(var_318_2.content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 61
				local var_318_5 = utf8.len(var_318_3)
				local var_318_6 = var_318_4 <= 0 and var_318_1 or var_318_1 * (var_318_5 / var_318_4)

				if var_318_6 > 0 and var_318_1 < var_318_6 then
					arg_315_1.talkMaxDuration = var_318_6

					if var_318_6 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_6 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_7 and arg_315_1.time_ < var_318_0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play424101078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 424101078
		arg_319_1.duration_ = 7

		local var_319_0 = {
			zh = 4.733,
			ja = 7
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play424101079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10153"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10153 == nil then
				arg_319_1.var_.actorSpriteComps10153 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10153 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10153 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10153 = nil
			end

			local var_322_8 = arg_319_1.actors_["10153"].transform
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 then
				arg_319_1.var_.moveOldPos10153 = var_322_8.localPosition
				var_322_8.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10153", 3)

				local var_322_10 = var_322_8.childCount

				for iter_322_4 = 0, var_322_10 - 1 do
					local var_322_11 = var_322_8:GetChild(iter_322_4)

					if var_322_11.name == "split_1" or not string.find(var_322_11.name, "split") then
						var_322_11.gameObject:SetActive(true)
					else
						var_322_11.gameObject:SetActive(false)
					end
				end
			end

			local var_322_12 = 0.001

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_12 then
				local var_322_13 = (arg_319_1.time_ - var_322_9) / var_322_12
				local var_322_14 = Vector3.New(-60, -395, -330)

				var_322_8.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10153, var_322_14, var_322_13)
			end

			if arg_319_1.time_ >= var_322_9 + var_322_12 and arg_319_1.time_ < var_322_9 + var_322_12 + arg_322_0 then
				var_322_8.localPosition = Vector3.New(-60, -395, -330)
			end

			local var_322_15 = 0
			local var_322_16 = 0.575

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_17 = arg_319_1:FormatText(StoryNameCfg[1387].name)

				arg_319_1.leftNameTxt_.text = var_322_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_18 = arg_319_1:GetWordFromCfg(424101078)
				local var_322_19 = arg_319_1:FormatText(var_322_18.content)

				arg_319_1.text_.text = var_322_19

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_20 = 23
				local var_322_21 = utf8.len(var_322_19)
				local var_322_22 = var_322_20 <= 0 and var_322_16 or var_322_16 * (var_322_21 / var_322_20)

				if var_322_22 > 0 and var_322_16 < var_322_22 then
					arg_319_1.talkMaxDuration = var_322_22

					if var_322_22 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_22 + var_322_15
					end
				end

				arg_319_1.text_.text = var_322_19
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101078", "story_v_out_424101.awb") ~= 0 then
					local var_322_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101078", "story_v_out_424101.awb") / 1000

					if var_322_23 + var_322_15 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_15
					end

					if var_322_18.prefab_name ~= "" and arg_319_1.actors_[var_322_18.prefab_name] ~= nil then
						local var_322_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_18.prefab_name].transform, "story_v_out_424101", "424101078", "story_v_out_424101.awb")

						arg_319_1:RecordAudio("424101078", var_322_24)
						arg_319_1:RecordAudio("424101078", var_322_24)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_424101", "424101078", "story_v_out_424101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_424101", "424101078", "story_v_out_424101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_25 = math.max(var_322_16, arg_319_1.talkMaxDuration)

			if var_322_15 <= arg_319_1.time_ and arg_319_1.time_ < var_322_15 + var_322_25 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_15) / var_322_25

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_15 + var_322_25 and arg_319_1.time_ < var_322_15 + var_322_25 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play424101079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 424101079
		arg_323_1.duration_ = 6.1

		local var_323_0 = {
			zh = 3.4,
			ja = 6.1
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play424101080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10153"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10153 == nil then
				arg_323_1.var_.actorSpriteComps10153 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10153 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 0.5, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10153 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10153 = nil
			end

			local var_326_8 = arg_323_1.actors_["10153"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos10153 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10153", 7)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -2000, 0)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10153, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_326_15 = 0
			local var_326_16 = 0.425

			if var_326_15 < arg_323_1.time_ and arg_323_1.time_ <= var_326_15 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_17 = arg_323_1:FormatText(StoryNameCfg[177].name)

				arg_323_1.leftNameTxt_.text = var_326_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_18 = arg_323_1:GetWordFromCfg(424101079)
				local var_326_19 = arg_323_1:FormatText(var_326_18.content)

				arg_323_1.text_.text = var_326_19

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_20 = 17
				local var_326_21 = utf8.len(var_326_19)
				local var_326_22 = var_326_20 <= 0 and var_326_16 or var_326_16 * (var_326_21 / var_326_20)

				if var_326_22 > 0 and var_326_16 < var_326_22 then
					arg_323_1.talkMaxDuration = var_326_22

					if var_326_22 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_22 + var_326_15
					end
				end

				arg_323_1.text_.text = var_326_19
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101079", "story_v_out_424101.awb") ~= 0 then
					local var_326_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101079", "story_v_out_424101.awb") / 1000

					if var_326_23 + var_326_15 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_23 + var_326_15
					end

					if var_326_18.prefab_name ~= "" and arg_323_1.actors_[var_326_18.prefab_name] ~= nil then
						local var_326_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_18.prefab_name].transform, "story_v_out_424101", "424101079", "story_v_out_424101.awb")

						arg_323_1:RecordAudio("424101079", var_326_24)
						arg_323_1:RecordAudio("424101079", var_326_24)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_424101", "424101079", "story_v_out_424101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_424101", "424101079", "story_v_out_424101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_25 = math.max(var_326_16, arg_323_1.talkMaxDuration)

			if var_326_15 <= arg_323_1.time_ and arg_323_1.time_ < var_326_15 + var_326_25 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_15) / var_326_25

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_15 + var_326_25 and arg_323_1.time_ < var_326_15 + var_326_25 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play424101080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424101080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424101081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.375

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:GetWordFromCfg(424101080)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 15
				local var_330_6 = utf8.len(var_330_4)
				local var_330_7 = var_330_5 <= 0 and var_330_1 or var_330_1 * (var_330_6 / var_330_5)

				if var_330_7 > 0 and var_330_1 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_0
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_8 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_8 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_8

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_8 and arg_327_1.time_ < var_330_0 + var_330_8 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play424101081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 424101081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play424101082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 1.05

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:GetWordFromCfg(424101081)
				local var_334_3 = arg_331_1:FormatText(var_334_2.content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 42
				local var_334_5 = utf8.len(var_334_3)
				local var_334_6 = var_334_4 <= 0 and var_334_1 or var_334_1 * (var_334_5 / var_334_4)

				if var_334_6 > 0 and var_334_1 < var_334_6 then
					arg_331_1.talkMaxDuration = var_334_6

					if var_334_6 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_6 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_7 and arg_331_1.time_ < var_334_0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play424101082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 424101082
		arg_335_1.duration_ = 18.57

		local var_335_0 = {
			zh = 14.966,
			ja = 18.566
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play424101083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1094"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1094 == nil then
				arg_335_1.var_.actorSpriteComps1094 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps1094 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 1, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps1094 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps1094 = nil
			end

			local var_338_8 = arg_335_1.actors_["1094"].transform
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 then
				arg_335_1.var_.moveOldPos1094 = var_338_8.localPosition
				var_338_8.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1094", 3)

				local var_338_10 = var_338_8.childCount

				for iter_338_4 = 0, var_338_10 - 1 do
					local var_338_11 = var_338_8:GetChild(iter_338_4)

					if var_338_11.name == "split_4" or not string.find(var_338_11.name, "split") then
						var_338_11.gameObject:SetActive(true)
					else
						var_338_11.gameObject:SetActive(false)
					end
				end
			end

			local var_338_12 = 0.001

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_12 then
				local var_338_13 = (arg_335_1.time_ - var_338_9) / var_338_12
				local var_338_14 = Vector3.New(0, -335, -230)

				var_338_8.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1094, var_338_14, var_338_13)
			end

			if arg_335_1.time_ >= var_338_9 + var_338_12 and arg_335_1.time_ < var_338_9 + var_338_12 + arg_338_0 then
				var_338_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_338_15 = 0
			local var_338_16 = 1.225

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[181].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_18 = arg_335_1:GetWordFromCfg(424101082)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 49
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101082", "story_v_out_424101.awb") ~= 0 then
					local var_338_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101082", "story_v_out_424101.awb") / 1000

					if var_338_23 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_15
					end

					if var_338_18.prefab_name ~= "" and arg_335_1.actors_[var_338_18.prefab_name] ~= nil then
						local var_338_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_18.prefab_name].transform, "story_v_out_424101", "424101082", "story_v_out_424101.awb")

						arg_335_1:RecordAudio("424101082", var_338_24)
						arg_335_1:RecordAudio("424101082", var_338_24)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_424101", "424101082", "story_v_out_424101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_424101", "424101082", "story_v_out_424101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_25 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_25 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_25

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_25 and arg_335_1.time_ < var_338_15 + var_338_25 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play424101083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 424101083
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play424101084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1094"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps1094 == nil then
				arg_339_1.var_.actorSpriteComps1094 = var_342_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_2 = 0.2

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.actorSpriteComps1094 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								local var_342_4 = Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, var_342_3)
								local var_342_5 = Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, var_342_3)
								local var_342_6 = Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, var_342_3)

								iter_342_1.color = Color.New(var_342_4, var_342_5, var_342_6)
							else
								local var_342_7 = Mathf.Lerp(iter_342_1.color.r, 0.5, var_342_3)

								iter_342_1.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.actorSpriteComps1094 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_342_3 then
						if arg_339_1.isInRecall_ then
							iter_342_3.color = arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_342_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps1094 = nil
			end

			local var_342_8 = 0
			local var_342_9 = 0.925

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_10 = arg_339_1:GetWordFromCfg(424101083)
				local var_342_11 = arg_339_1:FormatText(var_342_10.content)

				arg_339_1.text_.text = var_342_11

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_12 = 37
				local var_342_13 = utf8.len(var_342_11)
				local var_342_14 = var_342_12 <= 0 and var_342_9 or var_342_9 * (var_342_13 / var_342_12)

				if var_342_14 > 0 and var_342_9 < var_342_14 then
					arg_339_1.talkMaxDuration = var_342_14

					if var_342_14 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_14 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_11
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_15 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_15 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_15

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_15 and arg_339_1.time_ < var_342_8 + var_342_15 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play424101084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 424101084
		arg_343_1.duration_ = 10.43

		local var_343_0 = {
			zh = 8.333,
			ja = 10.433
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play424101085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1094"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1094 == nil then
				arg_343_1.var_.actorSpriteComps1094 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps1094 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps1094 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1094 = nil
			end

			local var_346_8 = arg_343_1.actors_["1094"].transform
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.var_.moveOldPos1094 = var_346_8.localPosition
				var_346_8.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1094", 3)

				local var_346_10 = var_346_8.childCount

				for iter_346_4 = 0, var_346_10 - 1 do
					local var_346_11 = var_346_8:GetChild(iter_346_4)

					if var_346_11.name == "split_1" then
						var_346_11:SetAsLastSibling()
						var_346_11.gameObject:SetActive(true)

						arg_343_1.var_.actorSpriteSplit1094 = var_346_11.gameObject:GetComponent(typeof(Image))

						arg_343_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_346_12 = 0.5

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_12 then
				local var_346_13 = (arg_343_1.time_ - var_346_9) / var_346_12
				local var_346_14 = Vector3.New(0, -335, -230)

				var_346_8.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1094, var_346_14, var_346_13)

				if arg_343_1.var_.actorSpriteSplit1094 ~= nil then
					arg_343_1.var_.actorSpriteSplit1094:SetAlpha(var_346_13)
				end
			end

			if arg_343_1.time_ >= var_346_9 + var_346_12 and arg_343_1.time_ < var_346_9 + var_346_12 + arg_346_0 then
				var_346_8.localPosition = Vector3.New(0, -335, -230)

				if arg_343_1.var_.actorSpriteSplit1094 ~= nil then
					arg_343_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_346_15 = 0
			local var_346_16 = 0.725

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_17 = arg_343_1:FormatText(StoryNameCfg[181].name)

				arg_343_1.leftNameTxt_.text = var_346_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(424101084)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_20 = 29
				local var_346_21 = utf8.len(var_346_19)
				local var_346_22 = var_346_20 <= 0 and var_346_16 or var_346_16 * (var_346_21 / var_346_20)

				if var_346_22 > 0 and var_346_16 < var_346_22 then
					arg_343_1.talkMaxDuration = var_346_22

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101084", "story_v_out_424101.awb") ~= 0 then
					local var_346_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101084", "story_v_out_424101.awb") / 1000

					if var_346_23 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_15
					end

					if var_346_18.prefab_name ~= "" and arg_343_1.actors_[var_346_18.prefab_name] ~= nil then
						local var_346_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_18.prefab_name].transform, "story_v_out_424101", "424101084", "story_v_out_424101.awb")

						arg_343_1:RecordAudio("424101084", var_346_24)
						arg_343_1:RecordAudio("424101084", var_346_24)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_424101", "424101084", "story_v_out_424101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_424101", "424101084", "story_v_out_424101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_25 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_15) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_15 + var_346_25 and arg_343_1.time_ < var_346_15 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play424101085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 424101085
		arg_347_1.duration_ = 21.37

		local var_347_0 = {
			zh = 17.166,
			ja = 21.366
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play424101086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 1.45

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[181].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(424101085)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 58
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101085", "story_v_out_424101.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101085", "story_v_out_424101.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_424101", "424101085", "story_v_out_424101.awb")

						arg_347_1:RecordAudio("424101085", var_350_9)
						arg_347_1:RecordAudio("424101085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_424101", "424101085", "story_v_out_424101.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_424101", "424101085", "story_v_out_424101.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play424101086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 424101086
		arg_351_1.duration_ = 15.13

		local var_351_0 = {
			zh = 13.066,
			ja = 15.133
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play424101087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1094"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1094 = var_354_0.localPosition
				var_354_0.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1094", 3)

				local var_354_2 = var_354_0.childCount

				for iter_354_0 = 0, var_354_2 - 1 do
					local var_354_3 = var_354_0:GetChild(iter_354_0)

					if var_354_3.name == "split_4" then
						var_354_3:SetAsLastSibling()
						var_354_3.gameObject:SetActive(true)

						arg_351_1.var_.actorSpriteSplit1094 = var_354_3.gameObject:GetComponent(typeof(Image))

						arg_351_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_354_4 = 0.5

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_4 then
				local var_354_5 = (arg_351_1.time_ - var_354_1) / var_354_4
				local var_354_6 = Vector3.New(0, -335, -230)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1094, var_354_6, var_354_5)

				if arg_351_1.var_.actorSpriteSplit1094 ~= nil then
					arg_351_1.var_.actorSpriteSplit1094:SetAlpha(var_354_5)
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_4 and arg_351_1.time_ < var_354_1 + var_354_4 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, -335, -230)

				if arg_351_1.var_.actorSpriteSplit1094 ~= nil then
					arg_351_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_354_7 = 0
			local var_354_8 = 0.925

			if var_354_7 < arg_351_1.time_ and arg_351_1.time_ <= var_354_7 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_9 = arg_351_1:FormatText(StoryNameCfg[181].name)

				arg_351_1.leftNameTxt_.text = var_354_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(424101086)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_12 = 37
				local var_354_13 = utf8.len(var_354_11)
				local var_354_14 = var_354_12 <= 0 and var_354_8 or var_354_8 * (var_354_13 / var_354_12)

				if var_354_14 > 0 and var_354_8 < var_354_14 then
					arg_351_1.talkMaxDuration = var_354_14

					if var_354_14 + var_354_7 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_7
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101086", "story_v_out_424101.awb") ~= 0 then
					local var_354_15 = manager.audio:GetVoiceLength("story_v_out_424101", "424101086", "story_v_out_424101.awb") / 1000

					if var_354_15 + var_354_7 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_15 + var_354_7
					end

					if var_354_10.prefab_name ~= "" and arg_351_1.actors_[var_354_10.prefab_name] ~= nil then
						local var_354_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_10.prefab_name].transform, "story_v_out_424101", "424101086", "story_v_out_424101.awb")

						arg_351_1:RecordAudio("424101086", var_354_16)
						arg_351_1:RecordAudio("424101086", var_354_16)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_424101", "424101086", "story_v_out_424101.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_424101", "424101086", "story_v_out_424101.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_17 = math.max(var_354_8, arg_351_1.talkMaxDuration)

			if var_354_7 <= arg_351_1.time_ and arg_351_1.time_ < var_354_7 + var_354_17 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_7) / var_354_17

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_7 + var_354_17 and arg_351_1.time_ < var_354_7 + var_354_17 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play424101087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 424101087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play424101088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1094"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps1094 == nil then
				arg_355_1.var_.actorSpriteComps1094 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps1094 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								local var_358_4 = Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, var_358_3)
								local var_358_5 = Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, var_358_3)
								local var_358_6 = Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, var_358_3)

								iter_358_1.color = Color.New(var_358_4, var_358_5, var_358_6)
							else
								local var_358_7 = Mathf.Lerp(iter_358_1.color.r, 0.5, var_358_3)

								iter_358_1.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps1094 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps1094 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.825

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(424101087)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_12 = 33
				local var_358_13 = utf8.len(var_358_11)
				local var_358_14 = var_358_12 <= 0 and var_358_9 or var_358_9 * (var_358_13 / var_358_12)

				if var_358_14 > 0 and var_358_9 < var_358_14 then
					arg_355_1.talkMaxDuration = var_358_14

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_15 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_15 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_15

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_15 and arg_355_1.time_ < var_358_8 + var_358_15 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play424101088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 424101088
		arg_359_1.duration_ = 4.5

		local var_359_0 = {
			zh = 3.2,
			ja = 4.5
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play424101089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1094"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps1094 == nil then
				arg_359_1.var_.actorSpriteComps1094 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.2

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps1094 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 1, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps1094 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps1094 = nil
			end

			local var_362_8 = arg_359_1.actors_["1094"].transform
			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.var_.moveOldPos1094 = var_362_8.localPosition
				var_362_8.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1094", 3)

				local var_362_10 = var_362_8.childCount

				for iter_362_4 = 0, var_362_10 - 1 do
					local var_362_11 = var_362_8:GetChild(iter_362_4)

					if var_362_11.name == "split_1" then
						var_362_11:SetAsLastSibling()
						var_362_11.gameObject:SetActive(true)

						arg_359_1.var_.actorSpriteSplit1094 = var_362_11.gameObject:GetComponent(typeof(Image))

						arg_359_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_362_12 = 0.5

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_12 then
				local var_362_13 = (arg_359_1.time_ - var_362_9) / var_362_12
				local var_362_14 = Vector3.New(0, -335, -230)

				var_362_8.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1094, var_362_14, var_362_13)

				if arg_359_1.var_.actorSpriteSplit1094 ~= nil then
					arg_359_1.var_.actorSpriteSplit1094:SetAlpha(var_362_13)
				end
			end

			if arg_359_1.time_ >= var_362_9 + var_362_12 and arg_359_1.time_ < var_362_9 + var_362_12 + arg_362_0 then
				var_362_8.localPosition = Vector3.New(0, -335, -230)

				if arg_359_1.var_.actorSpriteSplit1094 ~= nil then
					arg_359_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_362_15 = 0
			local var_362_16 = 0.225

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[181].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(424101088)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 9
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101088", "story_v_out_424101.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101088", "story_v_out_424101.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_out_424101", "424101088", "story_v_out_424101.awb")

						arg_359_1:RecordAudio("424101088", var_362_24)
						arg_359_1:RecordAudio("424101088", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_424101", "424101088", "story_v_out_424101.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_424101", "424101088", "story_v_out_424101.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_25 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_25 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_25

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_25 and arg_359_1.time_ < var_362_15 + var_362_25 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play424101089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 424101089
		arg_363_1.duration_ = 1

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"

			SetActive(arg_363_1.choicesGo_, true)

			for iter_364_0, iter_364_1 in ipairs(arg_363_1.choices_) do
				local var_364_0 = iter_364_0 <= 2

				SetActive(iter_364_1.go, var_364_0)
			end

			arg_363_1.choices_[1].txt.text = arg_363_1:FormatText(StoryChoiceCfg[1487].name)
			arg_363_1.choices_[2].txt.text = arg_363_1:FormatText(StoryChoiceCfg[1488].name)
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play424101090(arg_363_1)
			end

			if arg_365_0 == 2 then
				arg_363_0:Play424101090(arg_363_1)
			end

			arg_363_1:RecordChoiceLog(424101089, 1487, 1488)
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1094"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1094 == nil then
				arg_363_1.var_.actorSpriteComps1094 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps1094 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor2.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor2.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor2.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 0.5, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps1094 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_366_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps1094 = nil
			end

			local var_366_8 = 0

			if var_366_8 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			local var_366_9 = 0.6

			if arg_363_1.time_ >= var_366_8 + var_366_9 and arg_363_1.time_ < var_366_8 + var_366_9 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play424101090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 424101090
		arg_367_1.duration_ = 1.3

		local var_367_0 = {
			zh = 1.266,
			ja = 1.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play424101091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1094"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps1094 == nil then
				arg_367_1.var_.actorSpriteComps1094 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps1094 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 1, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps1094 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps1094 = nil
			end

			local var_370_8 = arg_367_1.actors_["1094"].transform
			local var_370_9 = 0

			if var_370_9 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 then
				arg_367_1.var_.moveOldPos1094 = var_370_8.localPosition
				var_370_8.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("1094", 3)

				local var_370_10 = var_370_8.childCount

				for iter_370_4 = 0, var_370_10 - 1 do
					local var_370_11 = var_370_8:GetChild(iter_370_4)

					if var_370_11.name == "" or not string.find(var_370_11.name, "split") then
						var_370_11.gameObject:SetActive(true)
					else
						var_370_11.gameObject:SetActive(false)
					end
				end
			end

			local var_370_12 = 0.001

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_12 then
				local var_370_13 = (arg_367_1.time_ - var_370_9) / var_370_12
				local var_370_14 = Vector3.New(0, -335, -230)

				var_370_8.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1094, var_370_14, var_370_13)
			end

			if arg_367_1.time_ >= var_370_9 + var_370_12 and arg_367_1.time_ < var_370_9 + var_370_12 + arg_370_0 then
				var_370_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_370_15 = 0
			local var_370_16 = 0.075

			if var_370_15 < arg_367_1.time_ and arg_367_1.time_ <= var_370_15 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_17 = arg_367_1:FormatText(StoryNameCfg[181].name)

				arg_367_1.leftNameTxt_.text = var_370_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_18 = arg_367_1:GetWordFromCfg(424101090)
				local var_370_19 = arg_367_1:FormatText(var_370_18.content)

				arg_367_1.text_.text = var_370_19

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_20 = 3
				local var_370_21 = utf8.len(var_370_19)
				local var_370_22 = var_370_20 <= 0 and var_370_16 or var_370_16 * (var_370_21 / var_370_20)

				if var_370_22 > 0 and var_370_16 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22

					if var_370_22 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_15
					end
				end

				arg_367_1.text_.text = var_370_19
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101090", "story_v_out_424101.awb") ~= 0 then
					local var_370_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101090", "story_v_out_424101.awb") / 1000

					if var_370_23 + var_370_15 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_23 + var_370_15
					end

					if var_370_18.prefab_name ~= "" and arg_367_1.actors_[var_370_18.prefab_name] ~= nil then
						local var_370_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_18.prefab_name].transform, "story_v_out_424101", "424101090", "story_v_out_424101.awb")

						arg_367_1:RecordAudio("424101090", var_370_24)
						arg_367_1:RecordAudio("424101090", var_370_24)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_424101", "424101090", "story_v_out_424101.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_424101", "424101090", "story_v_out_424101.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_25 = math.max(var_370_16, arg_367_1.talkMaxDuration)

			if var_370_15 <= arg_367_1.time_ and arg_367_1.time_ < var_370_15 + var_370_25 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_15) / var_370_25

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_15 + var_370_25 and arg_367_1.time_ < var_370_15 + var_370_25 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play424101091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 424101091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play424101092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1094"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1094 == nil then
				arg_371_1.var_.actorSpriteComps1094 = var_374_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_2 = 0.2

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.actorSpriteComps1094 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								local var_374_4 = Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, var_374_3)
								local var_374_5 = Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, var_374_3)
								local var_374_6 = Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, var_374_3)

								iter_374_1.color = Color.New(var_374_4, var_374_5, var_374_6)
							else
								local var_374_7 = Mathf.Lerp(iter_374_1.color.r, 0.5, var_374_3)

								iter_374_1.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.actorSpriteComps1094 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_374_3 then
						if arg_371_1.isInRecall_ then
							iter_374_3.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps1094 = nil
			end

			local var_374_8 = 0
			local var_374_9 = 0.65

			if var_374_8 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_10 = arg_371_1:FormatText(StoryNameCfg[7].name)

				arg_371_1.leftNameTxt_.text = var_374_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_11 = arg_371_1:GetWordFromCfg(424101091)
				local var_374_12 = arg_371_1:FormatText(var_374_11.content)

				arg_371_1.text_.text = var_374_12

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 26
				local var_374_14 = utf8.len(var_374_12)
				local var_374_15 = var_374_13 <= 0 and var_374_9 or var_374_9 * (var_374_14 / var_374_13)

				if var_374_15 > 0 and var_374_9 < var_374_15 then
					arg_371_1.talkMaxDuration = var_374_15

					if var_374_15 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_15 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_12
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play424101092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 424101092
		arg_375_1.duration_ = 1.37

		local var_375_0 = {
			zh = 1.3,
			ja = 1.366
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play424101093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1094"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1094 == nil then
				arg_375_1.var_.actorSpriteComps1094 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps1094 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 1, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps1094 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps1094 = nil
			end

			local var_378_8 = arg_375_1.actors_["1094"].transform
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.var_.moveOldPos1094 = var_378_8.localPosition
				var_378_8.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1094", 3)

				local var_378_10 = var_378_8.childCount

				for iter_378_4 = 0, var_378_10 - 1 do
					local var_378_11 = var_378_8:GetChild(iter_378_4)

					if var_378_11.name == "split_2" then
						var_378_11:SetAsLastSibling()
						var_378_11.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit1094 = var_378_11.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_378_12 = 0.5

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_12 then
				local var_378_13 = (arg_375_1.time_ - var_378_9) / var_378_12
				local var_378_14 = Vector3.New(0, -335, -230)

				var_378_8.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1094, var_378_14, var_378_13)

				if arg_375_1.var_.actorSpriteSplit1094 ~= nil then
					arg_375_1.var_.actorSpriteSplit1094:SetAlpha(var_378_13)
				end
			end

			if arg_375_1.time_ >= var_378_9 + var_378_12 and arg_375_1.time_ < var_378_9 + var_378_12 + arg_378_0 then
				var_378_8.localPosition = Vector3.New(0, -335, -230)

				if arg_375_1.var_.actorSpriteSplit1094 ~= nil then
					arg_375_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_378_15 = 0
			local var_378_16 = 0.1

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[181].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(424101092)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 4
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101092", "story_v_out_424101.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101092", "story_v_out_424101.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_424101", "424101092", "story_v_out_424101.awb")

						arg_375_1:RecordAudio("424101092", var_378_24)
						arg_375_1:RecordAudio("424101092", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_424101", "424101092", "story_v_out_424101.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_424101", "424101092", "story_v_out_424101.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play424101093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 424101093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play424101094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1094"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps1094 == nil then
				arg_379_1.var_.actorSpriteComps1094 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps1094 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 0.5, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps1094 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps1094 = nil
			end

			local var_382_8 = 0
			local var_382_9 = 0.125

			if var_382_8 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_10 = arg_379_1:FormatText(StoryNameCfg[7].name)

				arg_379_1.leftNameTxt_.text = var_382_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_11 = arg_379_1:GetWordFromCfg(424101093)
				local var_382_12 = arg_379_1:FormatText(var_382_11.content)

				arg_379_1.text_.text = var_382_12

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 5
				local var_382_14 = utf8.len(var_382_12)
				local var_382_15 = var_382_13 <= 0 and var_382_9 or var_382_9 * (var_382_14 / var_382_13)

				if var_382_15 > 0 and var_382_9 < var_382_15 then
					arg_379_1.talkMaxDuration = var_382_15

					if var_382_15 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_15 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_12
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play424101094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 424101094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play424101095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 0.925

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_2 = arg_383_1:FormatText(StoryNameCfg[7].name)

				arg_383_1.leftNameTxt_.text = var_386_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:GetWordFromCfg(424101094)
				local var_386_4 = arg_383_1:FormatText(var_386_3.content)

				arg_383_1.text_.text = var_386_4

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 37
				local var_386_6 = utf8.len(var_386_4)
				local var_386_7 = var_386_5 <= 0 and var_386_1 or var_386_1 * (var_386_6 / var_386_5)

				if var_386_7 > 0 and var_386_1 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_4
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_8 and arg_383_1.time_ < var_386_0 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play424101095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 424101095
		arg_387_1.duration_ = 4.67

		local var_387_0 = {
			zh = 2.833,
			ja = 4.666
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play424101096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1094"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps1094 == nil then
				arg_387_1.var_.actorSpriteComps1094 = var_390_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_2 = 0.2

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.actorSpriteComps1094 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								local var_390_4 = Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor1.r, var_390_3)
								local var_390_5 = Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor1.g, var_390_3)
								local var_390_6 = Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor1.b, var_390_3)

								iter_390_1.color = Color.New(var_390_4, var_390_5, var_390_6)
							else
								local var_390_7 = Mathf.Lerp(iter_390_1.color.r, 1, var_390_3)

								iter_390_1.color = Color.New(var_390_7, var_390_7, var_390_7)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps1094 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_390_3 then
						if arg_387_1.isInRecall_ then
							iter_390_3.color = arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_390_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps1094 = nil
			end

			local var_390_8 = arg_387_1.actors_["1094"].transform
			local var_390_9 = 0

			if var_390_9 < arg_387_1.time_ and arg_387_1.time_ <= var_390_9 + arg_390_0 then
				arg_387_1.var_.moveOldPos1094 = var_390_8.localPosition
				var_390_8.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("1094", 3)

				local var_390_10 = var_390_8.childCount

				for iter_390_4 = 0, var_390_10 - 1 do
					local var_390_11 = var_390_8:GetChild(iter_390_4)

					if var_390_11.name == "split_1" then
						var_390_11:SetAsLastSibling()
						var_390_11.gameObject:SetActive(true)

						arg_387_1.var_.actorSpriteSplit1094 = var_390_11.gameObject:GetComponent(typeof(Image))

						arg_387_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_390_12 = 0.5

			if var_390_9 <= arg_387_1.time_ and arg_387_1.time_ < var_390_9 + var_390_12 then
				local var_390_13 = (arg_387_1.time_ - var_390_9) / var_390_12
				local var_390_14 = Vector3.New(0, -335, -230)

				var_390_8.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1094, var_390_14, var_390_13)

				if arg_387_1.var_.actorSpriteSplit1094 ~= nil then
					arg_387_1.var_.actorSpriteSplit1094:SetAlpha(var_390_13)
				end
			end

			if arg_387_1.time_ >= var_390_9 + var_390_12 and arg_387_1.time_ < var_390_9 + var_390_12 + arg_390_0 then
				var_390_8.localPosition = Vector3.New(0, -335, -230)

				if arg_387_1.var_.actorSpriteSplit1094 ~= nil then
					arg_387_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_390_15 = 0
			local var_390_16 = 0.3

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[181].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(424101095)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 12
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_16 or var_390_16 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_16 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22

					if var_390_22 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_15
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101095", "story_v_out_424101.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101095", "story_v_out_424101.awb") / 1000

					if var_390_23 + var_390_15 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_15
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_424101", "424101095", "story_v_out_424101.awb")

						arg_387_1:RecordAudio("424101095", var_390_24)
						arg_387_1:RecordAudio("424101095", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_424101", "424101095", "story_v_out_424101.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_424101", "424101095", "story_v_out_424101.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = math.max(var_390_16, arg_387_1.talkMaxDuration)

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_25 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_15) / var_390_25

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_15 + var_390_25 and arg_387_1.time_ < var_390_15 + var_390_25 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play424101096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 424101096
		arg_391_1.duration_ = 9

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play424101097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = "I11s"

			if arg_391_1.bgs_[var_394_0] == nil then
				local var_394_1 = Object.Instantiate(arg_391_1.paintGo_)

				var_394_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_394_0)
				var_394_1.name = var_394_0
				var_394_1.transform.parent = arg_391_1.stage_.transform
				var_394_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.bgs_[var_394_0] = var_394_1
			end

			local var_394_2 = 2

			if var_394_2 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				local var_394_3 = manager.ui.mainCamera.transform.localPosition
				local var_394_4 = Vector3.New(0, 0, 10) + Vector3.New(var_394_3.x, var_394_3.y, 0)
				local var_394_5 = arg_391_1.bgs_.I11s

				var_394_5.transform.localPosition = var_394_4
				var_394_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_6 = var_394_5:GetComponent("SpriteRenderer")

				if var_394_6 and var_394_6.sprite then
					local var_394_7 = (var_394_5.transform.localPosition - var_394_3).z
					local var_394_8 = manager.ui.mainCameraCom_
					local var_394_9 = 2 * var_394_7 * Mathf.Tan(var_394_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_394_10 = var_394_9 * var_394_8.aspect
					local var_394_11 = var_394_6.sprite.bounds.size.x
					local var_394_12 = var_394_6.sprite.bounds.size.y
					local var_394_13 = var_394_10 / var_394_11
					local var_394_14 = var_394_9 / var_394_12
					local var_394_15 = var_394_14 < var_394_13 and var_394_13 or var_394_14

					var_394_5.transform.localScale = Vector3.New(var_394_15, var_394_15, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "I11s" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_16 = 4

			if var_394_16 < arg_391_1.time_ and arg_391_1.time_ <= var_394_16 + arg_394_0 then
				arg_391_1.allBtn_.enabled = false
			end

			local var_394_17 = 0.3

			if arg_391_1.time_ >= var_394_16 + var_394_17 and arg_391_1.time_ < var_394_16 + var_394_17 + arg_394_0 then
				arg_391_1.allBtn_.enabled = true
			end

			local var_394_18 = 0

			if var_394_18 < arg_391_1.time_ and arg_391_1.time_ <= var_394_18 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_19 = 2

			if var_394_18 <= arg_391_1.time_ and arg_391_1.time_ < var_394_18 + var_394_19 then
				local var_394_20 = (arg_391_1.time_ - var_394_18) / var_394_19
				local var_394_21 = Color.New(0, 0, 0)

				var_394_21.a = Mathf.Lerp(0, 1, var_394_20)
				arg_391_1.mask_.color = var_394_21
			end

			if arg_391_1.time_ >= var_394_18 + var_394_19 and arg_391_1.time_ < var_394_18 + var_394_19 + arg_394_0 then
				local var_394_22 = Color.New(0, 0, 0)

				var_394_22.a = 1
				arg_391_1.mask_.color = var_394_22
			end

			local var_394_23 = 2

			if var_394_23 < arg_391_1.time_ and arg_391_1.time_ <= var_394_23 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_24 = 2

			if var_394_23 <= arg_391_1.time_ and arg_391_1.time_ < var_394_23 + var_394_24 then
				local var_394_25 = (arg_391_1.time_ - var_394_23) / var_394_24
				local var_394_26 = Color.New(0, 0, 0)

				var_394_26.a = Mathf.Lerp(1, 0, var_394_25)
				arg_391_1.mask_.color = var_394_26
			end

			if arg_391_1.time_ >= var_394_23 + var_394_24 and arg_391_1.time_ < var_394_23 + var_394_24 + arg_394_0 then
				local var_394_27 = Color.New(0, 0, 0)
				local var_394_28 = 0

				arg_391_1.mask_.enabled = false
				var_394_27.a = var_394_28
				arg_391_1.mask_.color = var_394_27
			end

			local var_394_29 = arg_391_1.actors_["1094"]
			local var_394_30 = 1.966

			if var_394_30 < arg_391_1.time_ and arg_391_1.time_ <= var_394_30 + arg_394_0 and not isNil(var_394_29) and arg_391_1.var_.actorSpriteComps1094 == nil then
				arg_391_1.var_.actorSpriteComps1094 = var_394_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_31 = 0.034

			if var_394_30 <= arg_391_1.time_ and arg_391_1.time_ < var_394_30 + var_394_31 and not isNil(var_394_29) then
				local var_394_32 = (arg_391_1.time_ - var_394_30) / var_394_31

				if arg_391_1.var_.actorSpriteComps1094 then
					for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_394_3 then
							if arg_391_1.isInRecall_ then
								local var_394_33 = Mathf.Lerp(iter_394_3.color.r, arg_391_1.hightColor2.r, var_394_32)
								local var_394_34 = Mathf.Lerp(iter_394_3.color.g, arg_391_1.hightColor2.g, var_394_32)
								local var_394_35 = Mathf.Lerp(iter_394_3.color.b, arg_391_1.hightColor2.b, var_394_32)

								iter_394_3.color = Color.New(var_394_33, var_394_34, var_394_35)
							else
								local var_394_36 = Mathf.Lerp(iter_394_3.color.r, 0.5, var_394_32)

								iter_394_3.color = Color.New(var_394_36, var_394_36, var_394_36)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= var_394_30 + var_394_31 and arg_391_1.time_ < var_394_30 + var_394_31 + arg_394_0 and not isNil(var_394_29) and arg_391_1.var_.actorSpriteComps1094 then
				for iter_394_4, iter_394_5 in pairs(arg_391_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_394_5 then
						if arg_391_1.isInRecall_ then
							iter_394_5.color = arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_394_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_391_1.var_.actorSpriteComps1094 = nil
			end

			local var_394_37 = arg_391_1.actors_["1094"].transform
			local var_394_38 = 1.966

			if var_394_38 < arg_391_1.time_ and arg_391_1.time_ <= var_394_38 + arg_394_0 then
				arg_391_1.var_.moveOldPos1094 = var_394_37.localPosition
				var_394_37.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("1094", 7)

				local var_394_39 = var_394_37.childCount

				for iter_394_6 = 0, var_394_39 - 1 do
					local var_394_40 = var_394_37:GetChild(iter_394_6)

					if var_394_40.name == "" or not string.find(var_394_40.name, "split") then
						var_394_40.gameObject:SetActive(true)
					else
						var_394_40.gameObject:SetActive(false)
					end
				end
			end

			local var_394_41 = 0.001

			if var_394_38 <= arg_391_1.time_ and arg_391_1.time_ < var_394_38 + var_394_41 then
				local var_394_42 = (arg_391_1.time_ - var_394_38) / var_394_41
				local var_394_43 = Vector3.New(0, -2000, 0)

				var_394_37.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1094, var_394_43, var_394_42)
			end

			if arg_391_1.time_ >= var_394_38 + var_394_41 and arg_391_1.time_ < var_394_38 + var_394_41 + arg_394_0 then
				var_394_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_394_44 = 0.2
			local var_394_45 = 1

			if var_394_44 < arg_391_1.time_ and arg_391_1.time_ <= var_394_44 + arg_394_0 then
				local var_394_46 = "stop"
				local var_394_47 = "effect"

				arg_391_1:AudioAction(var_394_46, var_394_47, "se_story_140", "se_story_140_amb_valley", "")
			end

			local var_394_48 = 1.7
			local var_394_49 = 1

			if var_394_48 < arg_391_1.time_ and arg_391_1.time_ <= var_394_48 + arg_394_0 then
				local var_394_50 = "play"
				local var_394_51 = "effect"

				arg_391_1:AudioAction(var_394_50, var_394_51, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_394_52 = 1.7
			local var_394_53 = 1

			if var_394_52 < arg_391_1.time_ and arg_391_1.time_ <= var_394_52 + arg_394_0 then
				local var_394_54 = "play"
				local var_394_55 = "effect"

				arg_391_1:AudioAction(var_394_54, var_394_55, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_56 = 4
			local var_394_57 = 1.575

			if var_394_56 < arg_391_1.time_ and arg_391_1.time_ <= var_394_56 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_58 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_58:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_59 = arg_391_1:GetWordFromCfg(424101096)
				local var_394_60 = arg_391_1:FormatText(var_394_59.content)

				arg_391_1.text_.text = var_394_60

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_61 = 63
				local var_394_62 = utf8.len(var_394_60)
				local var_394_63 = var_394_61 <= 0 and var_394_57 or var_394_57 * (var_394_62 / var_394_61)

				if var_394_63 > 0 and var_394_57 < var_394_63 then
					arg_391_1.talkMaxDuration = var_394_63
					var_394_56 = var_394_56 + 0.3

					if var_394_63 + var_394_56 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_63 + var_394_56
					end
				end

				arg_391_1.text_.text = var_394_60
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_64 = var_394_56 + 0.3
			local var_394_65 = math.max(var_394_57, arg_391_1.talkMaxDuration)

			if var_394_64 <= arg_391_1.time_ and arg_391_1.time_ < var_394_64 + var_394_65 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_64) / var_394_65

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_64 + var_394_65 and arg_391_1.time_ < var_394_64 + var_394_65 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play424101097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424101097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play424101098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.475

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:GetWordFromCfg(424101097)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 19
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_8 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_8 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_8

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_8 and arg_397_1.time_ < var_400_0 + var_400_8 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424101098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424101098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424101099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.95

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(424101098)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 38
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play424101099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424101099
		arg_405_1.duration_ = 3.67

		local var_405_0 = {
			zh = 3.666,
			ja = 2.1
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424101100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = "10154"

			if arg_405_1.actors_[var_408_0] == nil then
				local var_408_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_408_1) then
					local var_408_2 = Object.Instantiate(var_408_1, arg_405_1.canvasGo_.transform)

					var_408_2.transform:SetSiblingIndex(1)

					var_408_2.name = var_408_0
					var_408_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_405_1.actors_[var_408_0] = var_408_2

					local var_408_3 = var_408_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_405_1.isInRecall_ then
						for iter_408_0, iter_408_1 in ipairs(var_408_3) do
							iter_408_1.color = arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_408_4 = arg_405_1.actors_["10154"]
			local var_408_5 = 0

			if var_408_5 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.actorSpriteComps10154 == nil then
				arg_405_1.var_.actorSpriteComps10154 = var_408_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_6 = 0.2

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_6 and not isNil(var_408_4) then
				local var_408_7 = (arg_405_1.time_ - var_408_5) / var_408_6

				if arg_405_1.var_.actorSpriteComps10154 then
					for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_408_3 then
							if arg_405_1.isInRecall_ then
								local var_408_8 = Mathf.Lerp(iter_408_3.color.r, arg_405_1.hightColor1.r, var_408_7)
								local var_408_9 = Mathf.Lerp(iter_408_3.color.g, arg_405_1.hightColor1.g, var_408_7)
								local var_408_10 = Mathf.Lerp(iter_408_3.color.b, arg_405_1.hightColor1.b, var_408_7)

								iter_408_3.color = Color.New(var_408_8, var_408_9, var_408_10)
							else
								local var_408_11 = Mathf.Lerp(iter_408_3.color.r, 1, var_408_7)

								iter_408_3.color = Color.New(var_408_11, var_408_11, var_408_11)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_5 + var_408_6 and arg_405_1.time_ < var_408_5 + var_408_6 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.actorSpriteComps10154 then
				for iter_408_4, iter_408_5 in pairs(arg_405_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_408_5 then
						if arg_405_1.isInRecall_ then
							iter_408_5.color = arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_408_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps10154 = nil
			end

			local var_408_12 = arg_405_1.actors_["10154"].transform
			local var_408_13 = 0

			if var_408_13 < arg_405_1.time_ and arg_405_1.time_ <= var_408_13 + arg_408_0 then
				arg_405_1.var_.moveOldPos10154 = var_408_12.localPosition
				var_408_12.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10154", 3)

				local var_408_14 = var_408_12.childCount

				for iter_408_6 = 0, var_408_14 - 1 do
					local var_408_15 = var_408_12:GetChild(iter_408_6)

					if var_408_15.name == "split_1" or not string.find(var_408_15.name, "split") then
						var_408_15.gameObject:SetActive(true)
					else
						var_408_15.gameObject:SetActive(false)
					end
				end
			end

			local var_408_16 = 0.001

			if var_408_13 <= arg_405_1.time_ and arg_405_1.time_ < var_408_13 + var_408_16 then
				local var_408_17 = (arg_405_1.time_ - var_408_13) / var_408_16
				local var_408_18 = Vector3.New(-20, -338, -538)

				var_408_12.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10154, var_408_18, var_408_17)
			end

			if arg_405_1.time_ >= var_408_13 + var_408_16 and arg_405_1.time_ < var_408_13 + var_408_16 + arg_408_0 then
				var_408_12.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_408_19 = 0
			local var_408_20 = 0.3

			if var_408_19 < arg_405_1.time_ and arg_405_1.time_ <= var_408_19 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_21 = arg_405_1:FormatText(StoryNameCfg[1392].name)

				arg_405_1.leftNameTxt_.text = var_408_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_22 = arg_405_1:GetWordFromCfg(424101099)
				local var_408_23 = arg_405_1:FormatText(var_408_22.content)

				arg_405_1.text_.text = var_408_23

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_24 = 12
				local var_408_25 = utf8.len(var_408_23)
				local var_408_26 = var_408_24 <= 0 and var_408_20 or var_408_20 * (var_408_25 / var_408_24)

				if var_408_26 > 0 and var_408_20 < var_408_26 then
					arg_405_1.talkMaxDuration = var_408_26

					if var_408_26 + var_408_19 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_26 + var_408_19
					end
				end

				arg_405_1.text_.text = var_408_23
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101099", "story_v_out_424101.awb") ~= 0 then
					local var_408_27 = manager.audio:GetVoiceLength("story_v_out_424101", "424101099", "story_v_out_424101.awb") / 1000

					if var_408_27 + var_408_19 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_27 + var_408_19
					end

					if var_408_22.prefab_name ~= "" and arg_405_1.actors_[var_408_22.prefab_name] ~= nil then
						local var_408_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_22.prefab_name].transform, "story_v_out_424101", "424101099", "story_v_out_424101.awb")

						arg_405_1:RecordAudio("424101099", var_408_28)
						arg_405_1:RecordAudio("424101099", var_408_28)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_424101", "424101099", "story_v_out_424101.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_424101", "424101099", "story_v_out_424101.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_29 = math.max(var_408_20, arg_405_1.talkMaxDuration)

			if var_408_19 <= arg_405_1.time_ and arg_405_1.time_ < var_408_19 + var_408_29 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_19) / var_408_29

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_19 + var_408_29 and arg_405_1.time_ < var_408_19 + var_408_29 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play424101100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424101100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play424101101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10154"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps10154 == nil then
				arg_409_1.var_.actorSpriteComps10154 = var_412_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.actorSpriteComps10154 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								local var_412_4 = Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor2.r, var_412_3)
								local var_412_5 = Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor2.g, var_412_3)
								local var_412_6 = Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor2.b, var_412_3)

								iter_412_1.color = Color.New(var_412_4, var_412_5, var_412_6)
							else
								local var_412_7 = Mathf.Lerp(iter_412_1.color.r, 0.5, var_412_3)

								iter_412_1.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps10154 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_412_3 then
						if arg_409_1.isInRecall_ then
							iter_412_3.color = arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_412_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps10154 = nil
			end

			local var_412_8 = arg_409_1.actors_["10154"].transform
			local var_412_9 = 0

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.var_.moveOldPos10154 = var_412_8.localPosition
				var_412_8.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10154", 7)

				local var_412_10 = var_412_8.childCount

				for iter_412_4 = 0, var_412_10 - 1 do
					local var_412_11 = var_412_8:GetChild(iter_412_4)

					if var_412_11.name == "" or not string.find(var_412_11.name, "split") then
						var_412_11.gameObject:SetActive(true)
					else
						var_412_11.gameObject:SetActive(false)
					end
				end
			end

			local var_412_12 = 0.001

			if var_412_9 <= arg_409_1.time_ and arg_409_1.time_ < var_412_9 + var_412_12 then
				local var_412_13 = (arg_409_1.time_ - var_412_9) / var_412_12
				local var_412_14 = Vector3.New(0, -2000, 0)

				var_412_8.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10154, var_412_14, var_412_13)
			end

			if arg_409_1.time_ >= var_412_9 + var_412_12 and arg_409_1.time_ < var_412_9 + var_412_12 + arg_412_0 then
				var_412_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_412_15 = 0.433333333333333
			local var_412_16 = 1

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				local var_412_17 = "play"
				local var_412_18 = "effect"

				arg_409_1:AudioAction(var_412_17, var_412_18, "se_story_143", "se_story_143_walk01", "")
			end

			local var_412_19 = 0
			local var_412_20 = 1.3

			if var_412_19 < arg_409_1.time_ and arg_409_1.time_ <= var_412_19 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_21 = arg_409_1:GetWordFromCfg(424101100)
				local var_412_22 = arg_409_1:FormatText(var_412_21.content)

				arg_409_1.text_.text = var_412_22

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_23 = 52
				local var_412_24 = utf8.len(var_412_22)
				local var_412_25 = var_412_23 <= 0 and var_412_20 or var_412_20 * (var_412_24 / var_412_23)

				if var_412_25 > 0 and var_412_20 < var_412_25 then
					arg_409_1.talkMaxDuration = var_412_25

					if var_412_25 + var_412_19 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_25 + var_412_19
					end
				end

				arg_409_1.text_.text = var_412_22
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_26 = math.max(var_412_20, arg_409_1.talkMaxDuration)

			if var_412_19 <= arg_409_1.time_ and arg_409_1.time_ < var_412_19 + var_412_26 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_19) / var_412_26

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_19 + var_412_26 and arg_409_1.time_ < var_412_19 + var_412_26 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play424101101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424101101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424101102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.225

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(424101101)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 9
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_8 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_8 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_8

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_8 and arg_413_1.time_ < var_416_0 + var_416_8 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play424101102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 424101102
		arg_417_1.duration_ = 5.87

		local var_417_0 = {
			zh = 5.866,
			ja = 2.266
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play424101103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10154"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10154 == nil then
				arg_417_1.var_.actorSpriteComps10154 = var_420_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.actorSpriteComps10154 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								local var_420_4 = Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor1.r, var_420_3)
								local var_420_5 = Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor1.g, var_420_3)
								local var_420_6 = Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor1.b, var_420_3)

								iter_420_1.color = Color.New(var_420_4, var_420_5, var_420_6)
							else
								local var_420_7 = Mathf.Lerp(iter_420_1.color.r, 1, var_420_3)

								iter_420_1.color = Color.New(var_420_7, var_420_7, var_420_7)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.actorSpriteComps10154 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_420_3 then
						if arg_417_1.isInRecall_ then
							iter_420_3.color = arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_420_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_417_1.var_.actorSpriteComps10154 = nil
			end

			local var_420_8 = arg_417_1.actors_["10154"].transform
			local var_420_9 = 0

			if var_420_9 < arg_417_1.time_ and arg_417_1.time_ <= var_420_9 + arg_420_0 then
				arg_417_1.var_.moveOldPos10154 = var_420_8.localPosition
				var_420_8.localScale = Vector3.New(1, 1, 1)

				arg_417_1:CheckSpriteTmpPos("10154", 3)

				local var_420_10 = var_420_8.childCount

				for iter_420_4 = 0, var_420_10 - 1 do
					local var_420_11 = var_420_8:GetChild(iter_420_4)

					if var_420_11.name == "split_1" then
						var_420_11:SetAsLastSibling()
						var_420_11.gameObject:SetActive(true)

						arg_417_1.var_.actorSpriteSplit10154 = var_420_11.gameObject:GetComponent(typeof(Image))

						arg_417_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_420_12 = 0.001

			if var_420_9 <= arg_417_1.time_ and arg_417_1.time_ < var_420_9 + var_420_12 then
				local var_420_13 = (arg_417_1.time_ - var_420_9) / var_420_12
				local var_420_14 = Vector3.New(-20, -338, -538)

				var_420_8.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10154, var_420_14, var_420_13)

				if arg_417_1.var_.actorSpriteSplit10154 ~= nil then
					arg_417_1.var_.actorSpriteSplit10154:SetAlpha(var_420_13)
				end
			end

			if arg_417_1.time_ >= var_420_9 + var_420_12 and arg_417_1.time_ < var_420_9 + var_420_12 + arg_420_0 then
				var_420_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_417_1.var_.actorSpriteSplit10154 ~= nil then
					arg_417_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_420_15 = 0
			local var_420_16 = 0.475

			if var_420_15 < arg_417_1.time_ and arg_417_1.time_ <= var_420_15 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_17 = arg_417_1:FormatText(StoryNameCfg[1392].name)

				arg_417_1.leftNameTxt_.text = var_420_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_18 = arg_417_1:GetWordFromCfg(424101102)
				local var_420_19 = arg_417_1:FormatText(var_420_18.content)

				arg_417_1.text_.text = var_420_19

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_20 = 19
				local var_420_21 = utf8.len(var_420_19)
				local var_420_22 = var_420_20 <= 0 and var_420_16 or var_420_16 * (var_420_21 / var_420_20)

				if var_420_22 > 0 and var_420_16 < var_420_22 then
					arg_417_1.talkMaxDuration = var_420_22

					if var_420_22 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_15
					end
				end

				arg_417_1.text_.text = var_420_19
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101102", "story_v_out_424101.awb") ~= 0 then
					local var_420_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101102", "story_v_out_424101.awb") / 1000

					if var_420_23 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_23 + var_420_15
					end

					if var_420_18.prefab_name ~= "" and arg_417_1.actors_[var_420_18.prefab_name] ~= nil then
						local var_420_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_18.prefab_name].transform, "story_v_out_424101", "424101102", "story_v_out_424101.awb")

						arg_417_1:RecordAudio("424101102", var_420_24)
						arg_417_1:RecordAudio("424101102", var_420_24)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_424101", "424101102", "story_v_out_424101.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_424101", "424101102", "story_v_out_424101.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_25 = math.max(var_420_16, arg_417_1.talkMaxDuration)

			if var_420_15 <= arg_417_1.time_ and arg_417_1.time_ < var_420_15 + var_420_25 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_15) / var_420_25

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_15 + var_420_25 and arg_417_1.time_ < var_420_15 + var_420_25 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play424101103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 424101103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play424101104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10154"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10154 == nil then
				arg_421_1.var_.actorSpriteComps10154 = var_424_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.actorSpriteComps10154 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								local var_424_4 = Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor2.r, var_424_3)
								local var_424_5 = Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor2.g, var_424_3)
								local var_424_6 = Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor2.b, var_424_3)

								iter_424_1.color = Color.New(var_424_4, var_424_5, var_424_6)
							else
								local var_424_7 = Mathf.Lerp(iter_424_1.color.r, 0.5, var_424_3)

								iter_424_1.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10154 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_424_3 then
						if arg_421_1.isInRecall_ then
							iter_424_3.color = arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_424_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps10154 = nil
			end

			local var_424_8 = 0
			local var_424_9 = 1.075

			if var_424_8 < arg_421_1.time_ and arg_421_1.time_ <= var_424_8 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_10 = arg_421_1:GetWordFromCfg(424101103)
				local var_424_11 = arg_421_1:FormatText(var_424_10.content)

				arg_421_1.text_.text = var_424_11

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_12 = 43
				local var_424_13 = utf8.len(var_424_11)
				local var_424_14 = var_424_12 <= 0 and var_424_9 or var_424_9 * (var_424_13 / var_424_12)

				if var_424_14 > 0 and var_424_9 < var_424_14 then
					arg_421_1.talkMaxDuration = var_424_14

					if var_424_14 + var_424_8 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_14 + var_424_8
					end
				end

				arg_421_1.text_.text = var_424_11
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_15 = math.max(var_424_9, arg_421_1.talkMaxDuration)

			if var_424_8 <= arg_421_1.time_ and arg_421_1.time_ < var_424_8 + var_424_15 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_8) / var_424_15

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_8 + var_424_15 and arg_421_1.time_ < var_424_8 + var_424_15 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play424101104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 424101104
		arg_425_1.duration_ = 3.33

		local var_425_0 = {
			zh = 3.333,
			ja = 2.866
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play424101105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10154"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10154 == nil then
				arg_425_1.var_.actorSpriteComps10154 = var_428_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.actorSpriteComps10154 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								local var_428_4 = Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, var_428_3)
								local var_428_5 = Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, var_428_3)
								local var_428_6 = Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, var_428_3)

								iter_428_1.color = Color.New(var_428_4, var_428_5, var_428_6)
							else
								local var_428_7 = Mathf.Lerp(iter_428_1.color.r, 1, var_428_3)

								iter_428_1.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10154 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_428_3 then
						if arg_425_1.isInRecall_ then
							iter_428_3.color = arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_428_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10154 = nil
			end

			local var_428_8 = arg_425_1.actors_["10154"].transform
			local var_428_9 = 0

			if var_428_9 < arg_425_1.time_ and arg_425_1.time_ <= var_428_9 + arg_428_0 then
				arg_425_1.var_.moveOldPos10154 = var_428_8.localPosition
				var_428_8.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10154", 3)

				local var_428_10 = var_428_8.childCount

				for iter_428_4 = 0, var_428_10 - 1 do
					local var_428_11 = var_428_8:GetChild(iter_428_4)

					if var_428_11.name == "split_1" or not string.find(var_428_11.name, "split") then
						var_428_11.gameObject:SetActive(true)
					else
						var_428_11.gameObject:SetActive(false)
					end
				end
			end

			local var_428_12 = 0.001

			if var_428_9 <= arg_425_1.time_ and arg_425_1.time_ < var_428_9 + var_428_12 then
				local var_428_13 = (arg_425_1.time_ - var_428_9) / var_428_12
				local var_428_14 = Vector3.New(-20, -338, -538)

				var_428_8.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10154, var_428_14, var_428_13)
			end

			if arg_425_1.time_ >= var_428_9 + var_428_12 and arg_425_1.time_ < var_428_9 + var_428_12 + arg_428_0 then
				var_428_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_428_15 = 0
			local var_428_16 = 0.3

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[1392].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(424101104)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 12
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101104", "story_v_out_424101.awb") ~= 0 then
					local var_428_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101104", "story_v_out_424101.awb") / 1000

					if var_428_23 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_15
					end

					if var_428_18.prefab_name ~= "" and arg_425_1.actors_[var_428_18.prefab_name] ~= nil then
						local var_428_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_18.prefab_name].transform, "story_v_out_424101", "424101104", "story_v_out_424101.awb")

						arg_425_1:RecordAudio("424101104", var_428_24)
						arg_425_1:RecordAudio("424101104", var_428_24)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_424101", "424101104", "story_v_out_424101.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_424101", "424101104", "story_v_out_424101.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_25 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_25 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_25

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_25 and arg_425_1.time_ < var_428_15 + var_428_25 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play424101105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 424101105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play424101106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10154"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10154 == nil then
				arg_429_1.var_.actorSpriteComps10154 = var_432_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_2 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.actorSpriteComps10154 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								local var_432_4 = Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor2.r, var_432_3)
								local var_432_5 = Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor2.g, var_432_3)
								local var_432_6 = Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor2.b, var_432_3)

								iter_432_1.color = Color.New(var_432_4, var_432_5, var_432_6)
							else
								local var_432_7 = Mathf.Lerp(iter_432_1.color.r, 0.5, var_432_3)

								iter_432_1.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10154 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_432_3 then
						if arg_429_1.isInRecall_ then
							iter_432_3.color = arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_432_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_429_1.var_.actorSpriteComps10154 = nil
			end

			local var_432_8 = arg_429_1.actors_["10154"].transform
			local var_432_9 = 0

			if var_432_9 < arg_429_1.time_ and arg_429_1.time_ <= var_432_9 + arg_432_0 then
				arg_429_1.var_.moveOldPos10154 = var_432_8.localPosition
				var_432_8.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("10154", 7)

				local var_432_10 = var_432_8.childCount

				for iter_432_4 = 0, var_432_10 - 1 do
					local var_432_11 = var_432_8:GetChild(iter_432_4)

					if var_432_11.name == "" or not string.find(var_432_11.name, "split") then
						var_432_11.gameObject:SetActive(true)
					else
						var_432_11.gameObject:SetActive(false)
					end
				end
			end

			local var_432_12 = 0.001

			if var_432_9 <= arg_429_1.time_ and arg_429_1.time_ < var_432_9 + var_432_12 then
				local var_432_13 = (arg_429_1.time_ - var_432_9) / var_432_12
				local var_432_14 = Vector3.New(0, -2000, 0)

				var_432_8.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10154, var_432_14, var_432_13)
			end

			if arg_429_1.time_ >= var_432_9 + var_432_12 and arg_429_1.time_ < var_432_9 + var_432_12 + arg_432_0 then
				var_432_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_432_15 = 0.075
			local var_432_16 = 1

			if var_432_15 < arg_429_1.time_ and arg_429_1.time_ <= var_432_15 + arg_432_0 then
				local var_432_17 = "play"
				local var_432_18 = "effect"

				arg_429_1:AudioAction(var_432_17, var_432_18, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_432_19 = 0.766666666666667
			local var_432_20 = 1

			if var_432_19 < arg_429_1.time_ and arg_429_1.time_ <= var_432_19 + arg_432_0 then
				local var_432_21 = "play"
				local var_432_22 = "effect"

				arg_429_1:AudioAction(var_432_21, var_432_22, "se_story_131", "se_story_131__opendoor", "")
			end

			local var_432_23 = 0
			local var_432_24 = 1.075

			if var_432_23 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_25 = arg_429_1:GetWordFromCfg(424101105)
				local var_432_26 = arg_429_1:FormatText(var_432_25.content)

				arg_429_1.text_.text = var_432_26

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_27 = 43
				local var_432_28 = utf8.len(var_432_26)
				local var_432_29 = var_432_27 <= 0 and var_432_24 or var_432_24 * (var_432_28 / var_432_27)

				if var_432_29 > 0 and var_432_24 < var_432_29 then
					arg_429_1.talkMaxDuration = var_432_29

					if var_432_29 + var_432_23 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_29 + var_432_23
					end
				end

				arg_429_1.text_.text = var_432_26
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_30 = math.max(var_432_24, arg_429_1.talkMaxDuration)

			if var_432_23 <= arg_429_1.time_ and arg_429_1.time_ < var_432_23 + var_432_30 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_23) / var_432_30

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_23 + var_432_30 and arg_429_1.time_ < var_432_23 + var_432_30 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play424101106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 424101106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play424101107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0
			local var_436_1 = 0.2

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_2 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:GetWordFromCfg(424101106)
				local var_436_4 = arg_433_1:FormatText(var_436_3.content)

				arg_433_1.text_.text = var_436_4

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 8
				local var_436_6 = utf8.len(var_436_4)
				local var_436_7 = var_436_5 <= 0 and var_436_1 or var_436_1 * (var_436_6 / var_436_5)

				if var_436_7 > 0 and var_436_1 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_0
					end
				end

				arg_433_1.text_.text = var_436_4
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_1, arg_433_1.talkMaxDuration)

			if var_436_0 <= arg_433_1.time_ and arg_433_1.time_ < var_436_0 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_0) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_0 + var_436_8 and arg_433_1.time_ < var_436_0 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play424101107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 424101107
		arg_437_1.duration_ = 16.2

		local var_437_0 = {
			zh = 16.2,
			ja = 15.433
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play424101108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["10154"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10154 == nil then
				arg_437_1.var_.actorSpriteComps10154 = var_440_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_2 = 0.2

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.actorSpriteComps10154 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								local var_440_4 = Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor1.r, var_440_3)
								local var_440_5 = Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor1.g, var_440_3)
								local var_440_6 = Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor1.b, var_440_3)

								iter_440_1.color = Color.New(var_440_4, var_440_5, var_440_6)
							else
								local var_440_7 = Mathf.Lerp(iter_440_1.color.r, 1, var_440_3)

								iter_440_1.color = Color.New(var_440_7, var_440_7, var_440_7)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10154 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_440_3 then
						if arg_437_1.isInRecall_ then
							iter_440_3.color = arg_437_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_440_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_437_1.var_.actorSpriteComps10154 = nil
			end

			local var_440_8 = arg_437_1.actors_["10154"].transform
			local var_440_9 = 0

			if var_440_9 < arg_437_1.time_ and arg_437_1.time_ <= var_440_9 + arg_440_0 then
				arg_437_1.var_.moveOldPos10154 = var_440_8.localPosition
				var_440_8.localScale = Vector3.New(1, 1, 1)

				arg_437_1:CheckSpriteTmpPos("10154", 3)

				local var_440_10 = var_440_8.childCount

				for iter_440_4 = 0, var_440_10 - 1 do
					local var_440_11 = var_440_8:GetChild(iter_440_4)

					if var_440_11.name == "split_1" or not string.find(var_440_11.name, "split") then
						var_440_11.gameObject:SetActive(true)
					else
						var_440_11.gameObject:SetActive(false)
					end
				end
			end

			local var_440_12 = 0.001

			if var_440_9 <= arg_437_1.time_ and arg_437_1.time_ < var_440_9 + var_440_12 then
				local var_440_13 = (arg_437_1.time_ - var_440_9) / var_440_12
				local var_440_14 = Vector3.New(-20, -338, -538)

				var_440_8.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10154, var_440_14, var_440_13)
			end

			if arg_437_1.time_ >= var_440_9 + var_440_12 and arg_437_1.time_ < var_440_9 + var_440_12 + arg_440_0 then
				var_440_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_440_15 = 0
			local var_440_16 = 1.275

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[1392].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(424101107)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 51
				local var_440_21 = utf8.len(var_440_19)
				local var_440_22 = var_440_20 <= 0 and var_440_16 or var_440_16 * (var_440_21 / var_440_20)

				if var_440_22 > 0 and var_440_16 < var_440_22 then
					arg_437_1.talkMaxDuration = var_440_22

					if var_440_22 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_22 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_19
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101107", "story_v_out_424101.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101107", "story_v_out_424101.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_out_424101", "424101107", "story_v_out_424101.awb")

						arg_437_1:RecordAudio("424101107", var_440_24)
						arg_437_1:RecordAudio("424101107", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_424101", "424101107", "story_v_out_424101.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_424101", "424101107", "story_v_out_424101.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_25 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_25 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_25

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_25 and arg_437_1.time_ < var_440_15 + var_440_25 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play424101108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424101108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play424101109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["10154"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.actorSpriteComps10154 == nil then
				arg_441_1.var_.actorSpriteComps10154 = var_444_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_2 = 0.2

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.actorSpriteComps10154 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								local var_444_4 = Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor2.r, var_444_3)
								local var_444_5 = Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor2.g, var_444_3)
								local var_444_6 = Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor2.b, var_444_3)

								iter_444_1.color = Color.New(var_444_4, var_444_5, var_444_6)
							else
								local var_444_7 = Mathf.Lerp(iter_444_1.color.r, 0.5, var_444_3)

								iter_444_1.color = Color.New(var_444_7, var_444_7, var_444_7)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.actorSpriteComps10154 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_444_3 then
						if arg_441_1.isInRecall_ then
							iter_444_3.color = arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_444_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_441_1.var_.actorSpriteComps10154 = nil
			end

			local var_444_8 = arg_441_1.actors_["10154"].transform
			local var_444_9 = 0

			if var_444_9 < arg_441_1.time_ and arg_441_1.time_ <= var_444_9 + arg_444_0 then
				arg_441_1.var_.moveOldPos10154 = var_444_8.localPosition
				var_444_8.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10154", 7)

				local var_444_10 = var_444_8.childCount

				for iter_444_4 = 0, var_444_10 - 1 do
					local var_444_11 = var_444_8:GetChild(iter_444_4)

					if var_444_11.name == "" or not string.find(var_444_11.name, "split") then
						var_444_11.gameObject:SetActive(true)
					else
						var_444_11.gameObject:SetActive(false)
					end
				end
			end

			local var_444_12 = 0.001

			if var_444_9 <= arg_441_1.time_ and arg_441_1.time_ < var_444_9 + var_444_12 then
				local var_444_13 = (arg_441_1.time_ - var_444_9) / var_444_12
				local var_444_14 = Vector3.New(0, -2000, 0)

				var_444_8.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10154, var_444_14, var_444_13)
			end

			if arg_441_1.time_ >= var_444_9 + var_444_12 and arg_441_1.time_ < var_444_9 + var_444_12 + arg_444_0 then
				var_444_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_444_15 = 0
			local var_444_16 = 1.475

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_17 = arg_441_1:GetWordFromCfg(424101108)
				local var_444_18 = arg_441_1:FormatText(var_444_17.content)

				arg_441_1.text_.text = var_444_18

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_19 = 59
				local var_444_20 = utf8.len(var_444_18)
				local var_444_21 = var_444_19 <= 0 and var_444_16 or var_444_16 * (var_444_20 / var_444_19)

				if var_444_21 > 0 and var_444_16 < var_444_21 then
					arg_441_1.talkMaxDuration = var_444_21

					if var_444_21 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_21 + var_444_15
					end
				end

				arg_441_1.text_.text = var_444_18
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_22 = math.max(var_444_16, arg_441_1.talkMaxDuration)

			if var_444_15 <= arg_441_1.time_ and arg_441_1.time_ < var_444_15 + var_444_22 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_15) / var_444_22

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_15 + var_444_22 and arg_441_1.time_ < var_444_15 + var_444_22 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play424101109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424101109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play424101110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 0.25

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[7].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(424101109)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 10
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play424101110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424101110
		arg_449_1.duration_ = 22.57

		local var_449_0 = {
			zh = 22.566,
			ja = 19.633
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play424101111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10154"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10154 == nil then
				arg_449_1.var_.actorSpriteComps10154 = var_452_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_2 = 0.2

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.actorSpriteComps10154 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								local var_452_4 = Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor1.r, var_452_3)
								local var_452_5 = Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor1.g, var_452_3)
								local var_452_6 = Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor1.b, var_452_3)

								iter_452_1.color = Color.New(var_452_4, var_452_5, var_452_6)
							else
								local var_452_7 = Mathf.Lerp(iter_452_1.color.r, 1, var_452_3)

								iter_452_1.color = Color.New(var_452_7, var_452_7, var_452_7)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.actorSpriteComps10154 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_452_3 then
						if arg_449_1.isInRecall_ then
							iter_452_3.color = arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_452_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_449_1.var_.actorSpriteComps10154 = nil
			end

			local var_452_8 = arg_449_1.actors_["10154"].transform
			local var_452_9 = 0

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1.var_.moveOldPos10154 = var_452_8.localPosition
				var_452_8.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10154", 3)

				local var_452_10 = var_452_8.childCount

				for iter_452_4 = 0, var_452_10 - 1 do
					local var_452_11 = var_452_8:GetChild(iter_452_4)

					if var_452_11.name == "split_4" or not string.find(var_452_11.name, "split") then
						var_452_11.gameObject:SetActive(true)
					else
						var_452_11.gameObject:SetActive(false)
					end
				end
			end

			local var_452_12 = 0.001

			if var_452_9 <= arg_449_1.time_ and arg_449_1.time_ < var_452_9 + var_452_12 then
				local var_452_13 = (arg_449_1.time_ - var_452_9) / var_452_12
				local var_452_14 = Vector3.New(-20, -338, -538)

				var_452_8.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10154, var_452_14, var_452_13)
			end

			if arg_449_1.time_ >= var_452_9 + var_452_12 and arg_449_1.time_ < var_452_9 + var_452_12 + arg_452_0 then
				var_452_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_452_15 = 0
			local var_452_16 = 1.625

			if var_452_15 < arg_449_1.time_ and arg_449_1.time_ <= var_452_15 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_17 = arg_449_1:FormatText(StoryNameCfg[1392].name)

				arg_449_1.leftNameTxt_.text = var_452_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_18 = arg_449_1:GetWordFromCfg(424101110)
				local var_452_19 = arg_449_1:FormatText(var_452_18.content)

				arg_449_1.text_.text = var_452_19

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_20 = 65
				local var_452_21 = utf8.len(var_452_19)
				local var_452_22 = var_452_20 <= 0 and var_452_16 or var_452_16 * (var_452_21 / var_452_20)

				if var_452_22 > 0 and var_452_16 < var_452_22 then
					arg_449_1.talkMaxDuration = var_452_22

					if var_452_22 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_22 + var_452_15
					end
				end

				arg_449_1.text_.text = var_452_19
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101110", "story_v_out_424101.awb") ~= 0 then
					local var_452_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101110", "story_v_out_424101.awb") / 1000

					if var_452_23 + var_452_15 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_23 + var_452_15
					end

					if var_452_18.prefab_name ~= "" and arg_449_1.actors_[var_452_18.prefab_name] ~= nil then
						local var_452_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_18.prefab_name].transform, "story_v_out_424101", "424101110", "story_v_out_424101.awb")

						arg_449_1:RecordAudio("424101110", var_452_24)
						arg_449_1:RecordAudio("424101110", var_452_24)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_424101", "424101110", "story_v_out_424101.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_424101", "424101110", "story_v_out_424101.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_25 = math.max(var_452_16, arg_449_1.talkMaxDuration)

			if var_452_15 <= arg_449_1.time_ and arg_449_1.time_ < var_452_15 + var_452_25 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_15) / var_452_25

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_15 + var_452_25 and arg_449_1.time_ < var_452_15 + var_452_25 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play424101111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424101111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play424101112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["10154"]
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10154 == nil then
				arg_453_1.var_.actorSpriteComps10154 = var_456_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_2 = 0.2

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 and not isNil(var_456_0) then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2

				if arg_453_1.var_.actorSpriteComps10154 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								local var_456_4 = Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor2.r, var_456_3)
								local var_456_5 = Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor2.g, var_456_3)
								local var_456_6 = Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor2.b, var_456_3)

								iter_456_1.color = Color.New(var_456_4, var_456_5, var_456_6)
							else
								local var_456_7 = Mathf.Lerp(iter_456_1.color.r, 0.5, var_456_3)

								iter_456_1.color = Color.New(var_456_7, var_456_7, var_456_7)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 and not isNil(var_456_0) and arg_453_1.var_.actorSpriteComps10154 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_456_3 then
						if arg_453_1.isInRecall_ then
							iter_456_3.color = arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_456_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_453_1.var_.actorSpriteComps10154 = nil
			end

			local var_456_8 = 0
			local var_456_9 = 0.15

			if var_456_8 < arg_453_1.time_ and arg_453_1.time_ <= var_456_8 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_10 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_11 = arg_453_1:GetWordFromCfg(424101111)
				local var_456_12 = arg_453_1:FormatText(var_456_11.content)

				arg_453_1.text_.text = var_456_12

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_13 = 6
				local var_456_14 = utf8.len(var_456_12)
				local var_456_15 = var_456_13 <= 0 and var_456_9 or var_456_9 * (var_456_14 / var_456_13)

				if var_456_15 > 0 and var_456_9 < var_456_15 then
					arg_453_1.talkMaxDuration = var_456_15

					if var_456_15 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_15 + var_456_8
					end
				end

				arg_453_1.text_.text = var_456_12
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_16 = math.max(var_456_9, arg_453_1.talkMaxDuration)

			if var_456_8 <= arg_453_1.time_ and arg_453_1.time_ < var_456_8 + var_456_16 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_8) / var_456_16

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_8 + var_456_16 and arg_453_1.time_ < var_456_8 + var_456_16 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play424101112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424101112
		arg_457_1.duration_ = 19.47

		local var_457_0 = {
			zh = 15.4,
			ja = 19.466
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play424101113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["10154"]
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10154 == nil then
				arg_457_1.var_.actorSpriteComps10154 = var_460_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_2 = 0.2

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 and not isNil(var_460_0) then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2

				if arg_457_1.var_.actorSpriteComps10154 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_460_1 then
							if arg_457_1.isInRecall_ then
								local var_460_4 = Mathf.Lerp(iter_460_1.color.r, arg_457_1.hightColor1.r, var_460_3)
								local var_460_5 = Mathf.Lerp(iter_460_1.color.g, arg_457_1.hightColor1.g, var_460_3)
								local var_460_6 = Mathf.Lerp(iter_460_1.color.b, arg_457_1.hightColor1.b, var_460_3)

								iter_460_1.color = Color.New(var_460_4, var_460_5, var_460_6)
							else
								local var_460_7 = Mathf.Lerp(iter_460_1.color.r, 1, var_460_3)

								iter_460_1.color = Color.New(var_460_7, var_460_7, var_460_7)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 and not isNil(var_460_0) and arg_457_1.var_.actorSpriteComps10154 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_460_3 then
						if arg_457_1.isInRecall_ then
							iter_460_3.color = arg_457_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_460_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_457_1.var_.actorSpriteComps10154 = nil
			end

			local var_460_8 = arg_457_1.actors_["10154"].transform
			local var_460_9 = 0

			if var_460_9 < arg_457_1.time_ and arg_457_1.time_ <= var_460_9 + arg_460_0 then
				arg_457_1.var_.moveOldPos10154 = var_460_8.localPosition
				var_460_8.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10154", 3)

				local var_460_10 = var_460_8.childCount

				for iter_460_4 = 0, var_460_10 - 1 do
					local var_460_11 = var_460_8:GetChild(iter_460_4)

					if var_460_11.name == "split_1" then
						var_460_11:SetAsLastSibling()
						var_460_11.gameObject:SetActive(true)

						arg_457_1.var_.actorSpriteSplit10154 = var_460_11.gameObject:GetComponent(typeof(Image))

						arg_457_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_460_12 = 0.5

			if var_460_9 <= arg_457_1.time_ and arg_457_1.time_ < var_460_9 + var_460_12 then
				local var_460_13 = (arg_457_1.time_ - var_460_9) / var_460_12
				local var_460_14 = Vector3.New(-20, -338, -538)

				var_460_8.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10154, var_460_14, var_460_13)

				if arg_457_1.var_.actorSpriteSplit10154 ~= nil then
					arg_457_1.var_.actorSpriteSplit10154:SetAlpha(var_460_13)
				end
			end

			if arg_457_1.time_ >= var_460_9 + var_460_12 and arg_457_1.time_ < var_460_9 + var_460_12 + arg_460_0 then
				var_460_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_457_1.var_.actorSpriteSplit10154 ~= nil then
					arg_457_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_460_15 = 0
			local var_460_16 = 1.575

			if var_460_15 < arg_457_1.time_ and arg_457_1.time_ <= var_460_15 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_17 = arg_457_1:FormatText(StoryNameCfg[1392].name)

				arg_457_1.leftNameTxt_.text = var_460_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_18 = arg_457_1:GetWordFromCfg(424101112)
				local var_460_19 = arg_457_1:FormatText(var_460_18.content)

				arg_457_1.text_.text = var_460_19

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_20 = 63
				local var_460_21 = utf8.len(var_460_19)
				local var_460_22 = var_460_20 <= 0 and var_460_16 or var_460_16 * (var_460_21 / var_460_20)

				if var_460_22 > 0 and var_460_16 < var_460_22 then
					arg_457_1.talkMaxDuration = var_460_22

					if var_460_22 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_22 + var_460_15
					end
				end

				arg_457_1.text_.text = var_460_19
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101112", "story_v_out_424101.awb") ~= 0 then
					local var_460_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101112", "story_v_out_424101.awb") / 1000

					if var_460_23 + var_460_15 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_23 + var_460_15
					end

					if var_460_18.prefab_name ~= "" and arg_457_1.actors_[var_460_18.prefab_name] ~= nil then
						local var_460_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_18.prefab_name].transform, "story_v_out_424101", "424101112", "story_v_out_424101.awb")

						arg_457_1:RecordAudio("424101112", var_460_24)
						arg_457_1:RecordAudio("424101112", var_460_24)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_424101", "424101112", "story_v_out_424101.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_424101", "424101112", "story_v_out_424101.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_25 = math.max(var_460_16, arg_457_1.talkMaxDuration)

			if var_460_15 <= arg_457_1.time_ and arg_457_1.time_ < var_460_15 + var_460_25 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_15) / var_460_25

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_15 + var_460_25 and arg_457_1.time_ < var_460_15 + var_460_25 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play424101113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424101113
		arg_461_1.duration_ = 16.23

		local var_461_0 = {
			zh = 14.733,
			ja = 16.233
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play424101114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["10154"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos10154 = var_464_0.localPosition
				var_464_0.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10154", 3)

				local var_464_2 = var_464_0.childCount

				for iter_464_0 = 0, var_464_2 - 1 do
					local var_464_3 = var_464_0:GetChild(iter_464_0)

					if var_464_3.name == "split_4" then
						var_464_3:SetAsLastSibling()
						var_464_3.gameObject:SetActive(true)

						arg_461_1.var_.actorSpriteSplit10154 = var_464_3.gameObject:GetComponent(typeof(Image))

						arg_461_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_464_4 = 0.5

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_4 then
				local var_464_5 = (arg_461_1.time_ - var_464_1) / var_464_4
				local var_464_6 = Vector3.New(-20, -338, -538)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10154, var_464_6, var_464_5)

				if arg_461_1.var_.actorSpriteSplit10154 ~= nil then
					arg_461_1.var_.actorSpriteSplit10154:SetAlpha(var_464_5)
				end
			end

			if arg_461_1.time_ >= var_464_1 + var_464_4 and arg_461_1.time_ < var_464_1 + var_464_4 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(-20, -338, -538)

				if arg_461_1.var_.actorSpriteSplit10154 ~= nil then
					arg_461_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_464_7 = 0
			local var_464_8 = 1.3

			if var_464_7 < arg_461_1.time_ and arg_461_1.time_ <= var_464_7 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_9 = arg_461_1:FormatText(StoryNameCfg[1392].name)

				arg_461_1.leftNameTxt_.text = var_464_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_10 = arg_461_1:GetWordFromCfg(424101113)
				local var_464_11 = arg_461_1:FormatText(var_464_10.content)

				arg_461_1.text_.text = var_464_11

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_12 = 52
				local var_464_13 = utf8.len(var_464_11)
				local var_464_14 = var_464_12 <= 0 and var_464_8 or var_464_8 * (var_464_13 / var_464_12)

				if var_464_14 > 0 and var_464_8 < var_464_14 then
					arg_461_1.talkMaxDuration = var_464_14

					if var_464_14 + var_464_7 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_7
					end
				end

				arg_461_1.text_.text = var_464_11
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101113", "story_v_out_424101.awb") ~= 0 then
					local var_464_15 = manager.audio:GetVoiceLength("story_v_out_424101", "424101113", "story_v_out_424101.awb") / 1000

					if var_464_15 + var_464_7 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_15 + var_464_7
					end

					if var_464_10.prefab_name ~= "" and arg_461_1.actors_[var_464_10.prefab_name] ~= nil then
						local var_464_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_10.prefab_name].transform, "story_v_out_424101", "424101113", "story_v_out_424101.awb")

						arg_461_1:RecordAudio("424101113", var_464_16)
						arg_461_1:RecordAudio("424101113", var_464_16)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_424101", "424101113", "story_v_out_424101.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_424101", "424101113", "story_v_out_424101.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_17 = math.max(var_464_8, arg_461_1.talkMaxDuration)

			if var_464_7 <= arg_461_1.time_ and arg_461_1.time_ < var_464_7 + var_464_17 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_7) / var_464_17

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_7 + var_464_17 and arg_461_1.time_ < var_464_7 + var_464_17 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play424101114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424101114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424101115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10154"]
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10154 == nil then
				arg_465_1.var_.actorSpriteComps10154 = var_468_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_2 = 0.2

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 and not isNil(var_468_0) then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2

				if arg_465_1.var_.actorSpriteComps10154 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								local var_468_4 = Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, var_468_3)
								local var_468_5 = Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, var_468_3)
								local var_468_6 = Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, var_468_3)

								iter_468_1.color = Color.New(var_468_4, var_468_5, var_468_6)
							else
								local var_468_7 = Mathf.Lerp(iter_468_1.color.r, 0.5, var_468_3)

								iter_468_1.color = Color.New(var_468_7, var_468_7, var_468_7)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.actorSpriteComps10154 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_468_3 then
						if arg_465_1.isInRecall_ then
							iter_468_3.color = arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_468_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_465_1.var_.actorSpriteComps10154 = nil
			end

			local var_468_8 = 0
			local var_468_9 = 0.7

			if var_468_8 < arg_465_1.time_ and arg_465_1.time_ <= var_468_8 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_10 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_11 = arg_465_1:GetWordFromCfg(424101114)
				local var_468_12 = arg_465_1:FormatText(var_468_11.content)

				arg_465_1.text_.text = var_468_12

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_13 = 28
				local var_468_14 = utf8.len(var_468_12)
				local var_468_15 = var_468_13 <= 0 and var_468_9 or var_468_9 * (var_468_14 / var_468_13)

				if var_468_15 > 0 and var_468_9 < var_468_15 then
					arg_465_1.talkMaxDuration = var_468_15

					if var_468_15 + var_468_8 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_15 + var_468_8
					end
				end

				arg_465_1.text_.text = var_468_12
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_16 = math.max(var_468_9, arg_465_1.talkMaxDuration)

			if var_468_8 <= arg_465_1.time_ and arg_465_1.time_ < var_468_8 + var_468_16 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_8) / var_468_16

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_8 + var_468_16 and arg_465_1.time_ < var_468_8 + var_468_16 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play424101115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 424101115
		arg_469_1.duration_ = 17.17

		local var_469_0 = {
			zh = 17.166,
			ja = 16.733
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play424101116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["10154"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.actorSpriteComps10154 == nil then
				arg_469_1.var_.actorSpriteComps10154 = var_472_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_2 = 0.2

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.actorSpriteComps10154 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_472_1 then
							if arg_469_1.isInRecall_ then
								local var_472_4 = Mathf.Lerp(iter_472_1.color.r, arg_469_1.hightColor1.r, var_472_3)
								local var_472_5 = Mathf.Lerp(iter_472_1.color.g, arg_469_1.hightColor1.g, var_472_3)
								local var_472_6 = Mathf.Lerp(iter_472_1.color.b, arg_469_1.hightColor1.b, var_472_3)

								iter_472_1.color = Color.New(var_472_4, var_472_5, var_472_6)
							else
								local var_472_7 = Mathf.Lerp(iter_472_1.color.r, 1, var_472_3)

								iter_472_1.color = Color.New(var_472_7, var_472_7, var_472_7)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.actorSpriteComps10154 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_472_3 then
						if arg_469_1.isInRecall_ then
							iter_472_3.color = arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_472_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_469_1.var_.actorSpriteComps10154 = nil
			end

			local var_472_8 = arg_469_1.actors_["10154"].transform
			local var_472_9 = 0

			if var_472_9 < arg_469_1.time_ and arg_469_1.time_ <= var_472_9 + arg_472_0 then
				arg_469_1.var_.moveOldPos10154 = var_472_8.localPosition
				var_472_8.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10154", 3)

				local var_472_10 = var_472_8.childCount

				for iter_472_4 = 0, var_472_10 - 1 do
					local var_472_11 = var_472_8:GetChild(iter_472_4)

					if var_472_11.name == "split_4" or not string.find(var_472_11.name, "split") then
						var_472_11.gameObject:SetActive(true)
					else
						var_472_11.gameObject:SetActive(false)
					end
				end
			end

			local var_472_12 = 0.001

			if var_472_9 <= arg_469_1.time_ and arg_469_1.time_ < var_472_9 + var_472_12 then
				local var_472_13 = (arg_469_1.time_ - var_472_9) / var_472_12
				local var_472_14 = Vector3.New(-20, -338, -538)

				var_472_8.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10154, var_472_14, var_472_13)
			end

			if arg_469_1.time_ >= var_472_9 + var_472_12 and arg_469_1.time_ < var_472_9 + var_472_12 + arg_472_0 then
				var_472_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_472_15 = 0
			local var_472_16 = 1.5

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[1392].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(424101115)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 60
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101115", "story_v_out_424101.awb") ~= 0 then
					local var_472_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101115", "story_v_out_424101.awb") / 1000

					if var_472_23 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_15
					end

					if var_472_18.prefab_name ~= "" and arg_469_1.actors_[var_472_18.prefab_name] ~= nil then
						local var_472_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_18.prefab_name].transform, "story_v_out_424101", "424101115", "story_v_out_424101.awb")

						arg_469_1:RecordAudio("424101115", var_472_24)
						arg_469_1:RecordAudio("424101115", var_472_24)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_424101", "424101115", "story_v_out_424101.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_424101", "424101115", "story_v_out_424101.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_25 and arg_469_1.time_ < var_472_15 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play424101116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 424101116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play424101117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["10154"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.actorSpriteComps10154 == nil then
				arg_473_1.var_.actorSpriteComps10154 = var_476_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_2 = 0.2

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.actorSpriteComps10154 then
					for iter_476_0, iter_476_1 in pairs(arg_473_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_476_1 then
							if arg_473_1.isInRecall_ then
								local var_476_4 = Mathf.Lerp(iter_476_1.color.r, arg_473_1.hightColor2.r, var_476_3)
								local var_476_5 = Mathf.Lerp(iter_476_1.color.g, arg_473_1.hightColor2.g, var_476_3)
								local var_476_6 = Mathf.Lerp(iter_476_1.color.b, arg_473_1.hightColor2.b, var_476_3)

								iter_476_1.color = Color.New(var_476_4, var_476_5, var_476_6)
							else
								local var_476_7 = Mathf.Lerp(iter_476_1.color.r, 0.5, var_476_3)

								iter_476_1.color = Color.New(var_476_7, var_476_7, var_476_7)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.actorSpriteComps10154 then
				for iter_476_2, iter_476_3 in pairs(arg_473_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_476_3 then
						if arg_473_1.isInRecall_ then
							iter_476_3.color = arg_473_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_476_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_473_1.var_.actorSpriteComps10154 = nil
			end

			local var_476_8 = 0
			local var_476_9 = 0.9

			if var_476_8 < arg_473_1.time_ and arg_473_1.time_ <= var_476_8 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_10 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_11 = arg_473_1:GetWordFromCfg(424101116)
				local var_476_12 = arg_473_1:FormatText(var_476_11.content)

				arg_473_1.text_.text = var_476_12

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_13 = 36
				local var_476_14 = utf8.len(var_476_12)
				local var_476_15 = var_476_13 <= 0 and var_476_9 or var_476_9 * (var_476_14 / var_476_13)

				if var_476_15 > 0 and var_476_9 < var_476_15 then
					arg_473_1.talkMaxDuration = var_476_15

					if var_476_15 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_15 + var_476_8
					end
				end

				arg_473_1.text_.text = var_476_12
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_16 = math.max(var_476_9, arg_473_1.talkMaxDuration)

			if var_476_8 <= arg_473_1.time_ and arg_473_1.time_ < var_476_8 + var_476_16 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_8) / var_476_16

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_8 + var_476_16 and arg_473_1.time_ < var_476_8 + var_476_16 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play424101117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 424101117
		arg_477_1.duration_ = 1.37

		local var_477_0 = {
			zh = 1.366,
			ja = 1.033
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play424101118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10154"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10154 == nil then
				arg_477_1.var_.actorSpriteComps10154 = var_480_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.actorSpriteComps10154 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_480_1 then
							if arg_477_1.isInRecall_ then
								local var_480_4 = Mathf.Lerp(iter_480_1.color.r, arg_477_1.hightColor1.r, var_480_3)
								local var_480_5 = Mathf.Lerp(iter_480_1.color.g, arg_477_1.hightColor1.g, var_480_3)
								local var_480_6 = Mathf.Lerp(iter_480_1.color.b, arg_477_1.hightColor1.b, var_480_3)

								iter_480_1.color = Color.New(var_480_4, var_480_5, var_480_6)
							else
								local var_480_7 = Mathf.Lerp(iter_480_1.color.r, 1, var_480_3)

								iter_480_1.color = Color.New(var_480_7, var_480_7, var_480_7)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10154 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_480_3 then
						if arg_477_1.isInRecall_ then
							iter_480_3.color = arg_477_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_480_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_477_1.var_.actorSpriteComps10154 = nil
			end

			local var_480_8 = arg_477_1.actors_["10154"].transform
			local var_480_9 = 0

			if var_480_9 < arg_477_1.time_ and arg_477_1.time_ <= var_480_9 + arg_480_0 then
				arg_477_1.var_.moveOldPos10154 = var_480_8.localPosition
				var_480_8.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10154", 3)

				local var_480_10 = var_480_8.childCount

				for iter_480_4 = 0, var_480_10 - 1 do
					local var_480_11 = var_480_8:GetChild(iter_480_4)

					if var_480_11.name == "split_5" then
						var_480_11:SetAsLastSibling()
						var_480_11.gameObject:SetActive(true)

						arg_477_1.var_.actorSpriteSplit10154 = var_480_11.gameObject:GetComponent(typeof(Image))

						arg_477_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_480_12 = 0.5

			if var_480_9 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_12 then
				local var_480_13 = (arg_477_1.time_ - var_480_9) / var_480_12
				local var_480_14 = Vector3.New(-20, -338, -538)

				var_480_8.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10154, var_480_14, var_480_13)

				if arg_477_1.var_.actorSpriteSplit10154 ~= nil then
					arg_477_1.var_.actorSpriteSplit10154:SetAlpha(var_480_13)
				end
			end

			if arg_477_1.time_ >= var_480_9 + var_480_12 and arg_477_1.time_ < var_480_9 + var_480_12 + arg_480_0 then
				var_480_8.localPosition = Vector3.New(-20, -338, -538)

				if arg_477_1.var_.actorSpriteSplit10154 ~= nil then
					arg_477_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_480_15 = 0
			local var_480_16 = 0.125

			if var_480_15 < arg_477_1.time_ and arg_477_1.time_ <= var_480_15 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_17 = arg_477_1:FormatText(StoryNameCfg[1392].name)

				arg_477_1.leftNameTxt_.text = var_480_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_18 = arg_477_1:GetWordFromCfg(424101117)
				local var_480_19 = arg_477_1:FormatText(var_480_18.content)

				arg_477_1.text_.text = var_480_19

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_20 = 5
				local var_480_21 = utf8.len(var_480_19)
				local var_480_22 = var_480_20 <= 0 and var_480_16 or var_480_16 * (var_480_21 / var_480_20)

				if var_480_22 > 0 and var_480_16 < var_480_22 then
					arg_477_1.talkMaxDuration = var_480_22

					if var_480_22 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_22 + var_480_15
					end
				end

				arg_477_1.text_.text = var_480_19
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101117", "story_v_out_424101.awb") ~= 0 then
					local var_480_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101117", "story_v_out_424101.awb") / 1000

					if var_480_23 + var_480_15 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_15
					end

					if var_480_18.prefab_name ~= "" and arg_477_1.actors_[var_480_18.prefab_name] ~= nil then
						local var_480_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_18.prefab_name].transform, "story_v_out_424101", "424101117", "story_v_out_424101.awb")

						arg_477_1:RecordAudio("424101117", var_480_24)
						arg_477_1:RecordAudio("424101117", var_480_24)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_424101", "424101117", "story_v_out_424101.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_424101", "424101117", "story_v_out_424101.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_25 = math.max(var_480_16, arg_477_1.talkMaxDuration)

			if var_480_15 <= arg_477_1.time_ and arg_477_1.time_ < var_480_15 + var_480_25 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_15) / var_480_25

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_15 + var_480_25 and arg_477_1.time_ < var_480_15 + var_480_25 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play424101118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 424101118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play424101119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["10154"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.actorSpriteComps10154 == nil then
				arg_481_1.var_.actorSpriteComps10154 = var_484_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_2 = 0.2

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.actorSpriteComps10154 then
					for iter_484_0, iter_484_1 in pairs(arg_481_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_484_1 then
							if arg_481_1.isInRecall_ then
								local var_484_4 = Mathf.Lerp(iter_484_1.color.r, arg_481_1.hightColor2.r, var_484_3)
								local var_484_5 = Mathf.Lerp(iter_484_1.color.g, arg_481_1.hightColor2.g, var_484_3)
								local var_484_6 = Mathf.Lerp(iter_484_1.color.b, arg_481_1.hightColor2.b, var_484_3)

								iter_484_1.color = Color.New(var_484_4, var_484_5, var_484_6)
							else
								local var_484_7 = Mathf.Lerp(iter_484_1.color.r, 0.5, var_484_3)

								iter_484_1.color = Color.New(var_484_7, var_484_7, var_484_7)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.actorSpriteComps10154 then
				for iter_484_2, iter_484_3 in pairs(arg_481_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_484_3 then
						if arg_481_1.isInRecall_ then
							iter_484_3.color = arg_481_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_484_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_481_1.var_.actorSpriteComps10154 = nil
			end

			local var_484_8 = 0
			local var_484_9 = 0.95

			if var_484_8 < arg_481_1.time_ and arg_481_1.time_ <= var_484_8 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_10 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_11 = arg_481_1:GetWordFromCfg(424101118)
				local var_484_12 = arg_481_1:FormatText(var_484_11.content)

				arg_481_1.text_.text = var_484_12

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_13 = 38
				local var_484_14 = utf8.len(var_484_12)
				local var_484_15 = var_484_13 <= 0 and var_484_9 or var_484_9 * (var_484_14 / var_484_13)

				if var_484_15 > 0 and var_484_9 < var_484_15 then
					arg_481_1.talkMaxDuration = var_484_15

					if var_484_15 + var_484_8 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_15 + var_484_8
					end
				end

				arg_481_1.text_.text = var_484_12
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_16 = math.max(var_484_9, arg_481_1.talkMaxDuration)

			if var_484_8 <= arg_481_1.time_ and arg_481_1.time_ < var_484_8 + var_484_16 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_8) / var_484_16

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_8 + var_484_16 and arg_481_1.time_ < var_484_8 + var_484_16 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play424101119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424101119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424101120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0
			local var_488_1 = 1.125

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_2 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_3 = arg_485_1:GetWordFromCfg(424101119)
				local var_488_4 = arg_485_1:FormatText(var_488_3.content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_5 = 45
				local var_488_6 = utf8.len(var_488_4)
				local var_488_7 = var_488_5 <= 0 and var_488_1 or var_488_1 * (var_488_6 / var_488_5)

				if var_488_7 > 0 and var_488_1 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_0
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_1, arg_485_1.talkMaxDuration)

			if var_488_0 <= arg_485_1.time_ and arg_485_1.time_ < var_488_0 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_0) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_0 + var_488_8 and arg_485_1.time_ < var_488_0 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424101120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 424101120
		arg_489_1.duration_ = 1

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"

			SetActive(arg_489_1.choicesGo_, true)

			for iter_490_0, iter_490_1 in ipairs(arg_489_1.choices_) do
				local var_490_0 = iter_490_0 <= 1

				SetActive(iter_490_1.go, var_490_0)
			end

			arg_489_1.choices_[1].txt.text = arg_489_1:FormatText(StoryChoiceCfg[1489].name)
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play424101121(arg_489_1)
			end

			arg_489_1:RecordChoiceLog(424101120, 1489)
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			local var_492_1 = 0.5

			if arg_489_1.time_ >= var_492_0 + var_492_1 and arg_489_1.time_ < var_492_0 + var_492_1 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play424101121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 424101121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play424101122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["10154"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos10154 = var_496_0.localPosition
				var_496_0.localScale = Vector3.New(1, 1, 1)

				arg_493_1:CheckSpriteTmpPos("10154", 7)

				local var_496_2 = var_496_0.childCount

				for iter_496_0 = 0, var_496_2 - 1 do
					local var_496_3 = var_496_0:GetChild(iter_496_0)

					if var_496_3.name == "" or not string.find(var_496_3.name, "split") then
						var_496_3.gameObject:SetActive(true)
					else
						var_496_3.gameObject:SetActive(false)
					end
				end
			end

			local var_496_4 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_4 then
				local var_496_5 = (arg_493_1.time_ - var_496_1) / var_496_4
				local var_496_6 = Vector3.New(0, -2000, 0)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10154, var_496_6, var_496_5)
			end

			if arg_493_1.time_ >= var_496_1 + var_496_4 and arg_493_1.time_ < var_496_1 + var_496_4 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_496_7 = 0.034
			local var_496_8 = 1

			if var_496_7 < arg_493_1.time_ and arg_493_1.time_ <= var_496_7 + arg_496_0 then
				local var_496_9 = "play"
				local var_496_10 = "effect"

				arg_493_1:AudioAction(var_496_9, var_496_10, "se_story_140", "se_story_140_foley_bag02", "")
			end

			local var_496_11 = 0
			local var_496_12 = 0.875

			if var_496_11 < arg_493_1.time_ and arg_493_1.time_ <= var_496_11 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_13 = arg_493_1:GetWordFromCfg(424101121)
				local var_496_14 = arg_493_1:FormatText(var_496_13.content)

				arg_493_1.text_.text = var_496_14

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_15 = 35
				local var_496_16 = utf8.len(var_496_14)
				local var_496_17 = var_496_15 <= 0 and var_496_12 or var_496_12 * (var_496_16 / var_496_15)

				if var_496_17 > 0 and var_496_12 < var_496_17 then
					arg_493_1.talkMaxDuration = var_496_17

					if var_496_17 + var_496_11 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_17 + var_496_11
					end
				end

				arg_493_1.text_.text = var_496_14
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_18 = math.max(var_496_12, arg_493_1.talkMaxDuration)

			if var_496_11 <= arg_493_1.time_ and arg_493_1.time_ < var_496_11 + var_496_18 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_11) / var_496_18

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_11 + var_496_18 and arg_493_1.time_ < var_496_11 + var_496_18 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play424101122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 424101122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play424101123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.975

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_2 = arg_497_1:GetWordFromCfg(424101122)
				local var_500_3 = arg_497_1:FormatText(var_500_2.content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_4 = 39
				local var_500_5 = utf8.len(var_500_3)
				local var_500_6 = var_500_4 <= 0 and var_500_1 or var_500_1 * (var_500_5 / var_500_4)

				if var_500_6 > 0 and var_500_1 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_7 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_7 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_7

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_7 and arg_497_1.time_ < var_500_0 + var_500_7 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play424101123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 424101123
		arg_501_1.duration_ = 10.2

		local var_501_0 = {
			zh = 7.866,
			ja = 10.2
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play424101124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["10154"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10154 == nil then
				arg_501_1.var_.actorSpriteComps10154 = var_504_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_2 = 0.2

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.actorSpriteComps10154 then
					for iter_504_0, iter_504_1 in pairs(arg_501_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_504_1 then
							if arg_501_1.isInRecall_ then
								local var_504_4 = Mathf.Lerp(iter_504_1.color.r, arg_501_1.hightColor1.r, var_504_3)
								local var_504_5 = Mathf.Lerp(iter_504_1.color.g, arg_501_1.hightColor1.g, var_504_3)
								local var_504_6 = Mathf.Lerp(iter_504_1.color.b, arg_501_1.hightColor1.b, var_504_3)

								iter_504_1.color = Color.New(var_504_4, var_504_5, var_504_6)
							else
								local var_504_7 = Mathf.Lerp(iter_504_1.color.r, 1, var_504_3)

								iter_504_1.color = Color.New(var_504_7, var_504_7, var_504_7)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10154 then
				for iter_504_2, iter_504_3 in pairs(arg_501_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_504_3 then
						if arg_501_1.isInRecall_ then
							iter_504_3.color = arg_501_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_504_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_501_1.var_.actorSpriteComps10154 = nil
			end

			local var_504_8 = arg_501_1.actors_["10154"].transform
			local var_504_9 = 0

			if var_504_9 < arg_501_1.time_ and arg_501_1.time_ <= var_504_9 + arg_504_0 then
				arg_501_1.var_.moveOldPos10154 = var_504_8.localPosition
				var_504_8.localScale = Vector3.New(1, 1, 1)

				arg_501_1:CheckSpriteTmpPos("10154", 3)

				local var_504_10 = var_504_8.childCount

				for iter_504_4 = 0, var_504_10 - 1 do
					local var_504_11 = var_504_8:GetChild(iter_504_4)

					if var_504_11.name == "split_4" or not string.find(var_504_11.name, "split") then
						var_504_11.gameObject:SetActive(true)
					else
						var_504_11.gameObject:SetActive(false)
					end
				end
			end

			local var_504_12 = 0.001

			if var_504_9 <= arg_501_1.time_ and arg_501_1.time_ < var_504_9 + var_504_12 then
				local var_504_13 = (arg_501_1.time_ - var_504_9) / var_504_12
				local var_504_14 = Vector3.New(-20, -338, -538)

				var_504_8.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos10154, var_504_14, var_504_13)
			end

			if arg_501_1.time_ >= var_504_9 + var_504_12 and arg_501_1.time_ < var_504_9 + var_504_12 + arg_504_0 then
				var_504_8.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_504_15 = arg_501_1.actors_["10154"]
			local var_504_16 = 0

			if var_504_16 < arg_501_1.time_ and arg_501_1.time_ <= var_504_16 + arg_504_0 then
				local var_504_17 = var_504_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_504_17 then
					arg_501_1.var_.alphaOldValue10154 = var_504_17.alpha
					arg_501_1.var_.characterEffect10154 = var_504_17
				end

				arg_501_1.var_.alphaOldValue10154 = 0
			end

			local var_504_18 = 0.5

			if var_504_16 <= arg_501_1.time_ and arg_501_1.time_ < var_504_16 + var_504_18 then
				local var_504_19 = (arg_501_1.time_ - var_504_16) / var_504_18
				local var_504_20 = Mathf.Lerp(arg_501_1.var_.alphaOldValue10154, 1, var_504_19)

				if arg_501_1.var_.characterEffect10154 then
					arg_501_1.var_.characterEffect10154.alpha = var_504_20
				end
			end

			if arg_501_1.time_ >= var_504_16 + var_504_18 and arg_501_1.time_ < var_504_16 + var_504_18 + arg_504_0 and arg_501_1.var_.characterEffect10154 then
				arg_501_1.var_.characterEffect10154.alpha = 1
			end

			local var_504_21 = 0
			local var_504_22 = 0.375

			if var_504_21 < arg_501_1.time_ and arg_501_1.time_ <= var_504_21 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0

				arg_501_1.dialog_:SetActive(true)

				arg_501_1.dialogCg_.alpha = 0

				local var_504_23 = LeanTween.value(arg_501_1.dialog_, 0, 1, 0.3)

				var_504_23:setOnUpdate(LuaHelper.FloatAction(function(arg_505_0)
					arg_501_1.dialogCg_.alpha = arg_505_0
				end))
				var_504_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_501_1.dialog_)
					var_504_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_501_1.duration_ = arg_501_1.duration_ + 0.3

				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_24 = arg_501_1:FormatText(StoryNameCfg[1392].name)

				arg_501_1.leftNameTxt_.text = var_504_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_25 = arg_501_1:GetWordFromCfg(424101123)
				local var_504_26 = arg_501_1:FormatText(var_504_25.content)

				arg_501_1.text_.text = var_504_26

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_27 = 15
				local var_504_28 = utf8.len(var_504_26)
				local var_504_29 = var_504_27 <= 0 and var_504_22 or var_504_22 * (var_504_28 / var_504_27)

				if var_504_29 > 0 and var_504_22 < var_504_29 then
					arg_501_1.talkMaxDuration = var_504_29
					var_504_21 = var_504_21 + 0.3

					if var_504_29 + var_504_21 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_29 + var_504_21
					end
				end

				arg_501_1.text_.text = var_504_26
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101123", "story_v_out_424101.awb") ~= 0 then
					local var_504_30 = manager.audio:GetVoiceLength("story_v_out_424101", "424101123", "story_v_out_424101.awb") / 1000

					if var_504_30 + var_504_21 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_30 + var_504_21
					end

					if var_504_25.prefab_name ~= "" and arg_501_1.actors_[var_504_25.prefab_name] ~= nil then
						local var_504_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_25.prefab_name].transform, "story_v_out_424101", "424101123", "story_v_out_424101.awb")

						arg_501_1:RecordAudio("424101123", var_504_31)
						arg_501_1:RecordAudio("424101123", var_504_31)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_424101", "424101123", "story_v_out_424101.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_424101", "424101123", "story_v_out_424101.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_32 = var_504_21 + 0.3
			local var_504_33 = math.max(var_504_22, arg_501_1.talkMaxDuration)

			if var_504_32 <= arg_501_1.time_ and arg_501_1.time_ < var_504_32 + var_504_33 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_32) / var_504_33

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_32 + var_504_33 and arg_501_1.time_ < var_504_32 + var_504_33 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play424101124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 424101124
		arg_507_1.duration_ = 13.77

		local var_507_0 = {
			zh = 8.2,
			ja = 13.766
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play424101125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = "ST0115a"

			if arg_507_1.bgs_[var_510_0] == nil then
				local var_510_1 = Object.Instantiate(arg_507_1.paintGo_)

				var_510_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_510_0)
				var_510_1.name = var_510_0
				var_510_1.transform.parent = arg_507_1.stage_.transform
				var_510_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_507_1.bgs_[var_510_0] = var_510_1
			end

			local var_510_2 = 2

			if var_510_2 < arg_507_1.time_ and arg_507_1.time_ <= var_510_2 + arg_510_0 then
				local var_510_3 = manager.ui.mainCamera.transform.localPosition
				local var_510_4 = Vector3.New(0, 0, 10) + Vector3.New(var_510_3.x, var_510_3.y, 0)
				local var_510_5 = arg_507_1.bgs_.ST0115a

				var_510_5.transform.localPosition = var_510_4
				var_510_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_510_6 = var_510_5:GetComponent("SpriteRenderer")

				if var_510_6 and var_510_6.sprite then
					local var_510_7 = (var_510_5.transform.localPosition - var_510_3).z
					local var_510_8 = manager.ui.mainCameraCom_
					local var_510_9 = 2 * var_510_7 * Mathf.Tan(var_510_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_510_10 = var_510_9 * var_510_8.aspect
					local var_510_11 = var_510_6.sprite.bounds.size.x
					local var_510_12 = var_510_6.sprite.bounds.size.y
					local var_510_13 = var_510_10 / var_510_11
					local var_510_14 = var_510_9 / var_510_12
					local var_510_15 = var_510_14 < var_510_13 and var_510_13 or var_510_14

					var_510_5.transform.localScale = Vector3.New(var_510_15, var_510_15, 0)
				end

				for iter_510_0, iter_510_1 in pairs(arg_507_1.bgs_) do
					if iter_510_0 ~= "ST0115a" then
						iter_510_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_510_16 = 4

			if var_510_16 < arg_507_1.time_ and arg_507_1.time_ <= var_510_16 + arg_510_0 then
				arg_507_1.allBtn_.enabled = false
			end

			local var_510_17 = 0.3

			if arg_507_1.time_ >= var_510_16 + var_510_17 and arg_507_1.time_ < var_510_16 + var_510_17 + arg_510_0 then
				arg_507_1.allBtn_.enabled = true
			end

			local var_510_18 = 0

			if var_510_18 < arg_507_1.time_ and arg_507_1.time_ <= var_510_18 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = true

				arg_507_1:SetGaussion(false)
			end

			local var_510_19 = 2

			if var_510_18 <= arg_507_1.time_ and arg_507_1.time_ < var_510_18 + var_510_19 then
				local var_510_20 = (arg_507_1.time_ - var_510_18) / var_510_19
				local var_510_21 = Color.New(0, 0, 0)

				var_510_21.a = Mathf.Lerp(0, 1, var_510_20)
				arg_507_1.mask_.color = var_510_21
			end

			if arg_507_1.time_ >= var_510_18 + var_510_19 and arg_507_1.time_ < var_510_18 + var_510_19 + arg_510_0 then
				local var_510_22 = Color.New(0, 0, 0)

				var_510_22.a = 1
				arg_507_1.mask_.color = var_510_22
			end

			local var_510_23 = 2

			if var_510_23 < arg_507_1.time_ and arg_507_1.time_ <= var_510_23 + arg_510_0 then
				arg_507_1.mask_.enabled = true
				arg_507_1.mask_.raycastTarget = true

				arg_507_1:SetGaussion(false)
			end

			local var_510_24 = 2

			if var_510_23 <= arg_507_1.time_ and arg_507_1.time_ < var_510_23 + var_510_24 then
				local var_510_25 = (arg_507_1.time_ - var_510_23) / var_510_24
				local var_510_26 = Color.New(0, 0, 0)

				var_510_26.a = Mathf.Lerp(1, 0, var_510_25)
				arg_507_1.mask_.color = var_510_26
			end

			if arg_507_1.time_ >= var_510_23 + var_510_24 and arg_507_1.time_ < var_510_23 + var_510_24 + arg_510_0 then
				local var_510_27 = Color.New(0, 0, 0)
				local var_510_28 = 0

				arg_507_1.mask_.enabled = false
				var_510_27.a = var_510_28
				arg_507_1.mask_.color = var_510_27
			end

			local var_510_29 = "10155"

			if arg_507_1.actors_[var_510_29] == nil then
				local var_510_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_510_30) then
					local var_510_31 = Object.Instantiate(var_510_30, arg_507_1.canvasGo_.transform)

					var_510_31.transform:SetSiblingIndex(1)

					var_510_31.name = var_510_29
					var_510_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_507_1.actors_[var_510_29] = var_510_31

					local var_510_32 = var_510_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_507_1.isInRecall_ then
						for iter_510_2, iter_510_3 in ipairs(var_510_32) do
							iter_510_3.color = arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_510_33 = arg_507_1.actors_["10155"]
			local var_510_34 = 3.8

			if var_510_34 < arg_507_1.time_ and arg_507_1.time_ <= var_510_34 + arg_510_0 and not isNil(var_510_33) and arg_507_1.var_.actorSpriteComps10155 == nil then
				arg_507_1.var_.actorSpriteComps10155 = var_510_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_35 = 0.2

			if var_510_34 <= arg_507_1.time_ and arg_507_1.time_ < var_510_34 + var_510_35 and not isNil(var_510_33) then
				local var_510_36 = (arg_507_1.time_ - var_510_34) / var_510_35

				if arg_507_1.var_.actorSpriteComps10155 then
					for iter_510_4, iter_510_5 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_510_5 then
							if arg_507_1.isInRecall_ then
								local var_510_37 = Mathf.Lerp(iter_510_5.color.r, arg_507_1.hightColor1.r, var_510_36)
								local var_510_38 = Mathf.Lerp(iter_510_5.color.g, arg_507_1.hightColor1.g, var_510_36)
								local var_510_39 = Mathf.Lerp(iter_510_5.color.b, arg_507_1.hightColor1.b, var_510_36)

								iter_510_5.color = Color.New(var_510_37, var_510_38, var_510_39)
							else
								local var_510_40 = Mathf.Lerp(iter_510_5.color.r, 1, var_510_36)

								iter_510_5.color = Color.New(var_510_40, var_510_40, var_510_40)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= var_510_34 + var_510_35 and arg_507_1.time_ < var_510_34 + var_510_35 + arg_510_0 and not isNil(var_510_33) and arg_507_1.var_.actorSpriteComps10155 then
				for iter_510_6, iter_510_7 in pairs(arg_507_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_510_7 then
						if arg_507_1.isInRecall_ then
							iter_510_7.color = arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_510_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_507_1.var_.actorSpriteComps10155 = nil
			end

			local var_510_41 = arg_507_1.actors_["10154"]
			local var_510_42 = 1.966

			if var_510_42 < arg_507_1.time_ and arg_507_1.time_ <= var_510_42 + arg_510_0 and not isNil(var_510_41) and arg_507_1.var_.actorSpriteComps10154 == nil then
				arg_507_1.var_.actorSpriteComps10154 = var_510_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_43 = 0.034

			if var_510_42 <= arg_507_1.time_ and arg_507_1.time_ < var_510_42 + var_510_43 and not isNil(var_510_41) then
				local var_510_44 = (arg_507_1.time_ - var_510_42) / var_510_43

				if arg_507_1.var_.actorSpriteComps10154 then
					for iter_510_8, iter_510_9 in pairs(arg_507_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_510_9 then
							if arg_507_1.isInRecall_ then
								local var_510_45 = Mathf.Lerp(iter_510_9.color.r, arg_507_1.hightColor2.r, var_510_44)
								local var_510_46 = Mathf.Lerp(iter_510_9.color.g, arg_507_1.hightColor2.g, var_510_44)
								local var_510_47 = Mathf.Lerp(iter_510_9.color.b, arg_507_1.hightColor2.b, var_510_44)

								iter_510_9.color = Color.New(var_510_45, var_510_46, var_510_47)
							else
								local var_510_48 = Mathf.Lerp(iter_510_9.color.r, 0.5, var_510_44)

								iter_510_9.color = Color.New(var_510_48, var_510_48, var_510_48)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= var_510_42 + var_510_43 and arg_507_1.time_ < var_510_42 + var_510_43 + arg_510_0 and not isNil(var_510_41) and arg_507_1.var_.actorSpriteComps10154 then
				for iter_510_10, iter_510_11 in pairs(arg_507_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_510_11 then
						if arg_507_1.isInRecall_ then
							iter_510_11.color = arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_510_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_507_1.var_.actorSpriteComps10154 = nil
			end

			local var_510_49 = arg_507_1.actors_["10154"].transform
			local var_510_50 = 1.966

			if var_510_50 < arg_507_1.time_ and arg_507_1.time_ <= var_510_50 + arg_510_0 then
				arg_507_1.var_.moveOldPos10154 = var_510_49.localPosition
				var_510_49.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10154", 7)

				local var_510_51 = var_510_49.childCount

				for iter_510_12 = 0, var_510_51 - 1 do
					local var_510_52 = var_510_49:GetChild(iter_510_12)

					if var_510_52.name == "" or not string.find(var_510_52.name, "split") then
						var_510_52.gameObject:SetActive(true)
					else
						var_510_52.gameObject:SetActive(false)
					end
				end
			end

			local var_510_53 = 0.001

			if var_510_50 <= arg_507_1.time_ and arg_507_1.time_ < var_510_50 + var_510_53 then
				local var_510_54 = (arg_507_1.time_ - var_510_50) / var_510_53
				local var_510_55 = Vector3.New(0, -2000, 0)

				var_510_49.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10154, var_510_55, var_510_54)
			end

			if arg_507_1.time_ >= var_510_50 + var_510_53 and arg_507_1.time_ < var_510_50 + var_510_53 + arg_510_0 then
				var_510_49.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_510_56 = arg_507_1.actors_["10155"].transform
			local var_510_57 = 3.8

			if var_510_57 < arg_507_1.time_ and arg_507_1.time_ <= var_510_57 + arg_510_0 then
				arg_507_1.var_.moveOldPos10155 = var_510_56.localPosition
				var_510_56.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10155", 3)

				local var_510_58 = var_510_56.childCount

				for iter_510_13 = 0, var_510_58 - 1 do
					local var_510_59 = var_510_56:GetChild(iter_510_13)

					if var_510_59.name == "split_6" or not string.find(var_510_59.name, "split") then
						var_510_59.gameObject:SetActive(true)
					else
						var_510_59.gameObject:SetActive(false)
					end
				end
			end

			local var_510_60 = 0.001

			if var_510_57 <= arg_507_1.time_ and arg_507_1.time_ < var_510_57 + var_510_60 then
				local var_510_61 = (arg_507_1.time_ - var_510_57) / var_510_60
				local var_510_62 = Vector3.New(-40, -390, -250)

				var_510_56.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10155, var_510_62, var_510_61)
			end

			if arg_507_1.time_ >= var_510_57 + var_510_60 and arg_507_1.time_ < var_510_57 + var_510_60 + arg_510_0 then
				var_510_56.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_510_63 = arg_507_1.actors_["10155"]
			local var_510_64 = 3.8

			if var_510_64 < arg_507_1.time_ and arg_507_1.time_ <= var_510_64 + arg_510_0 then
				local var_510_65 = var_510_63:GetComponentInChildren(typeof(CanvasGroup))

				if var_510_65 then
					arg_507_1.var_.alphaOldValue10155 = var_510_65.alpha
					arg_507_1.var_.characterEffect10155 = var_510_65
				end

				arg_507_1.var_.alphaOldValue10155 = 0
			end

			local var_510_66 = 0.6

			if var_510_64 <= arg_507_1.time_ and arg_507_1.time_ < var_510_64 + var_510_66 then
				local var_510_67 = (arg_507_1.time_ - var_510_64) / var_510_66
				local var_510_68 = Mathf.Lerp(arg_507_1.var_.alphaOldValue10155, 1, var_510_67)

				if arg_507_1.var_.characterEffect10155 then
					arg_507_1.var_.characterEffect10155.alpha = var_510_68
				end
			end

			if arg_507_1.time_ >= var_510_64 + var_510_66 and arg_507_1.time_ < var_510_64 + var_510_66 + arg_510_0 and arg_507_1.var_.characterEffect10155 then
				arg_507_1.var_.characterEffect10155.alpha = 1
			end

			local var_510_69 = 0.1
			local var_510_70 = 1

			if var_510_69 < arg_507_1.time_ and arg_507_1.time_ <= var_510_69 + arg_510_0 then
				local var_510_71 = "stop"
				local var_510_72 = "effect"

				arg_507_1:AudioAction(var_510_71, var_510_72, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_510_73 = 0.1
			local var_510_74 = 1

			if var_510_73 < arg_507_1.time_ and arg_507_1.time_ <= var_510_73 + arg_510_0 then
				local var_510_75 = "stop"
				local var_510_76 = "effect"

				arg_507_1:AudioAction(var_510_75, var_510_76, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_510_77 = 1.73333333333333
			local var_510_78 = 1

			if var_510_77 < arg_507_1.time_ and arg_507_1.time_ <= var_510_77 + arg_510_0 then
				local var_510_79 = "play"
				local var_510_80 = "effect"

				arg_507_1:AudioAction(var_510_79, var_510_80, "se_story_146", "se_story_146_wind02", "")
			end

			if arg_507_1.frameCnt_ <= 1 then
				arg_507_1.dialog_:SetActive(false)
			end

			local var_510_81 = 4
			local var_510_82 = 0.25

			if var_510_81 < arg_507_1.time_ and arg_507_1.time_ <= var_510_81 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0

				arg_507_1.dialog_:SetActive(true)

				arg_507_1.dialogCg_.alpha = 0

				local var_510_83 = LeanTween.value(arg_507_1.dialog_, 0, 1, 0.3)

				var_510_83:setOnUpdate(LuaHelper.FloatAction(function(arg_511_0)
					arg_507_1.dialogCg_.alpha = arg_511_0
				end))
				var_510_83:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_507_1.dialog_)
					var_510_83:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_507_1.duration_ = arg_507_1.duration_ + 0.3

				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_84 = arg_507_1:FormatText(StoryNameCfg[1391].name)

				arg_507_1.leftNameTxt_.text = var_510_84

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_85 = arg_507_1:GetWordFromCfg(424101124)
				local var_510_86 = arg_507_1:FormatText(var_510_85.content)

				arg_507_1.text_.text = var_510_86

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_87 = 10
				local var_510_88 = utf8.len(var_510_86)
				local var_510_89 = var_510_87 <= 0 and var_510_82 or var_510_82 * (var_510_88 / var_510_87)

				if var_510_89 > 0 and var_510_82 < var_510_89 then
					arg_507_1.talkMaxDuration = var_510_89
					var_510_81 = var_510_81 + 0.3

					if var_510_89 + var_510_81 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_89 + var_510_81
					end
				end

				arg_507_1.text_.text = var_510_86
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101124", "story_v_out_424101.awb") ~= 0 then
					local var_510_90 = manager.audio:GetVoiceLength("story_v_out_424101", "424101124", "story_v_out_424101.awb") / 1000

					if var_510_90 + var_510_81 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_90 + var_510_81
					end

					if var_510_85.prefab_name ~= "" and arg_507_1.actors_[var_510_85.prefab_name] ~= nil then
						local var_510_91 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_85.prefab_name].transform, "story_v_out_424101", "424101124", "story_v_out_424101.awb")

						arg_507_1:RecordAudio("424101124", var_510_91)
						arg_507_1:RecordAudio("424101124", var_510_91)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_424101", "424101124", "story_v_out_424101.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_424101", "424101124", "story_v_out_424101.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_92 = var_510_81 + 0.3
			local var_510_93 = math.max(var_510_82, arg_507_1.talkMaxDuration)

			if var_510_92 <= arg_507_1.time_ and arg_507_1.time_ < var_510_92 + var_510_93 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_92) / var_510_93

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_92 + var_510_93 and arg_507_1.time_ < var_510_92 + var_510_93 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play424101125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 424101125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play424101126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = arg_513_1.actors_["10155"]
			local var_516_1 = 0

			if var_516_1 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.actorSpriteComps10155 == nil then
				arg_513_1.var_.actorSpriteComps10155 = var_516_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_516_2 = 0.2

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_2 and not isNil(var_516_0) then
				local var_516_3 = (arg_513_1.time_ - var_516_1) / var_516_2

				if arg_513_1.var_.actorSpriteComps10155 then
					for iter_516_0, iter_516_1 in pairs(arg_513_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_516_1 then
							if arg_513_1.isInRecall_ then
								local var_516_4 = Mathf.Lerp(iter_516_1.color.r, arg_513_1.hightColor2.r, var_516_3)
								local var_516_5 = Mathf.Lerp(iter_516_1.color.g, arg_513_1.hightColor2.g, var_516_3)
								local var_516_6 = Mathf.Lerp(iter_516_1.color.b, arg_513_1.hightColor2.b, var_516_3)

								iter_516_1.color = Color.New(var_516_4, var_516_5, var_516_6)
							else
								local var_516_7 = Mathf.Lerp(iter_516_1.color.r, 0.5, var_516_3)

								iter_516_1.color = Color.New(var_516_7, var_516_7, var_516_7)
							end
						end
					end
				end
			end

			if arg_513_1.time_ >= var_516_1 + var_516_2 and arg_513_1.time_ < var_516_1 + var_516_2 + arg_516_0 and not isNil(var_516_0) and arg_513_1.var_.actorSpriteComps10155 then
				for iter_516_2, iter_516_3 in pairs(arg_513_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_516_3 then
						if arg_513_1.isInRecall_ then
							iter_516_3.color = arg_513_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_516_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_513_1.var_.actorSpriteComps10155 = nil
			end

			local var_516_8 = arg_513_1.actors_["10155"].transform
			local var_516_9 = 0

			if var_516_9 < arg_513_1.time_ and arg_513_1.time_ <= var_516_9 + arg_516_0 then
				arg_513_1.var_.moveOldPos10155 = var_516_8.localPosition
				var_516_8.localScale = Vector3.New(1, 1, 1)

				arg_513_1:CheckSpriteTmpPos("10155", 7)

				local var_516_10 = var_516_8.childCount

				for iter_516_4 = 0, var_516_10 - 1 do
					local var_516_11 = var_516_8:GetChild(iter_516_4)

					if var_516_11.name == "" or not string.find(var_516_11.name, "split") then
						var_516_11.gameObject:SetActive(true)
					else
						var_516_11.gameObject:SetActive(false)
					end
				end
			end

			local var_516_12 = 0.001

			if var_516_9 <= arg_513_1.time_ and arg_513_1.time_ < var_516_9 + var_516_12 then
				local var_516_13 = (arg_513_1.time_ - var_516_9) / var_516_12
				local var_516_14 = Vector3.New(0, -2000, 0)

				var_516_8.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPos10155, var_516_14, var_516_13)
			end

			if arg_513_1.time_ >= var_516_9 + var_516_12 and arg_513_1.time_ < var_516_9 + var_516_12 + arg_516_0 then
				var_516_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_516_15 = 0
			local var_516_16 = 1.2

			if var_516_15 < arg_513_1.time_ and arg_513_1.time_ <= var_516_15 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_17 = arg_513_1:GetWordFromCfg(424101125)
				local var_516_18 = arg_513_1:FormatText(var_516_17.content)

				arg_513_1.text_.text = var_516_18

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_19 = 48
				local var_516_20 = utf8.len(var_516_18)
				local var_516_21 = var_516_19 <= 0 and var_516_16 or var_516_16 * (var_516_20 / var_516_19)

				if var_516_21 > 0 and var_516_16 < var_516_21 then
					arg_513_1.talkMaxDuration = var_516_21

					if var_516_21 + var_516_15 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_21 + var_516_15
					end
				end

				arg_513_1.text_.text = var_516_18
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_22 = math.max(var_516_16, arg_513_1.talkMaxDuration)

			if var_516_15 <= arg_513_1.time_ and arg_513_1.time_ < var_516_15 + var_516_22 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_15) / var_516_22

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_15 + var_516_22 and arg_513_1.time_ < var_516_15 + var_516_22 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play424101126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 424101126
		arg_517_1.duration_ = 3.97

		local var_517_0 = {
			zh = 3.9,
			ja = 3.966
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play424101127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["1094"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps1094 == nil then
				arg_517_1.var_.actorSpriteComps1094 = var_520_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_2 = 0.2

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.actorSpriteComps1094 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								local var_520_4 = Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor1.r, var_520_3)
								local var_520_5 = Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor1.g, var_520_3)
								local var_520_6 = Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor1.b, var_520_3)

								iter_520_1.color = Color.New(var_520_4, var_520_5, var_520_6)
							else
								local var_520_7 = Mathf.Lerp(iter_520_1.color.r, 1, var_520_3)

								iter_520_1.color = Color.New(var_520_7, var_520_7, var_520_7)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps1094 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_520_3 then
						if arg_517_1.isInRecall_ then
							iter_520_3.color = arg_517_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_520_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_517_1.var_.actorSpriteComps1094 = nil
			end

			local var_520_8 = arg_517_1.actors_["1094"].transform
			local var_520_9 = 0

			if var_520_9 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1.var_.moveOldPos1094 = var_520_8.localPosition
				var_520_8.localScale = Vector3.New(1, 1, 1)

				arg_517_1:CheckSpriteTmpPos("1094", 3)

				local var_520_10 = var_520_8.childCount

				for iter_520_4 = 0, var_520_10 - 1 do
					local var_520_11 = var_520_8:GetChild(iter_520_4)

					if var_520_11.name == "split_1" or not string.find(var_520_11.name, "split") then
						var_520_11.gameObject:SetActive(true)
					else
						var_520_11.gameObject:SetActive(false)
					end
				end
			end

			local var_520_12 = 0.001

			if var_520_9 <= arg_517_1.time_ and arg_517_1.time_ < var_520_9 + var_520_12 then
				local var_520_13 = (arg_517_1.time_ - var_520_9) / var_520_12
				local var_520_14 = Vector3.New(0, -335, -230)

				var_520_8.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1094, var_520_14, var_520_13)
			end

			if arg_517_1.time_ >= var_520_9 + var_520_12 and arg_517_1.time_ < var_520_9 + var_520_12 + arg_520_0 then
				var_520_8.localPosition = Vector3.New(0, -335, -230)
			end

			local var_520_15 = 0
			local var_520_16 = 0.25

			if var_520_15 < arg_517_1.time_ and arg_517_1.time_ <= var_520_15 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_17 = arg_517_1:FormatText(StoryNameCfg[181].name)

				arg_517_1.leftNameTxt_.text = var_520_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_18 = arg_517_1:GetWordFromCfg(424101126)
				local var_520_19 = arg_517_1:FormatText(var_520_18.content)

				arg_517_1.text_.text = var_520_19

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_20 = 10
				local var_520_21 = utf8.len(var_520_19)
				local var_520_22 = var_520_20 <= 0 and var_520_16 or var_520_16 * (var_520_21 / var_520_20)

				if var_520_22 > 0 and var_520_16 < var_520_22 then
					arg_517_1.talkMaxDuration = var_520_22

					if var_520_22 + var_520_15 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_22 + var_520_15
					end
				end

				arg_517_1.text_.text = var_520_19
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101126", "story_v_out_424101.awb") ~= 0 then
					local var_520_23 = manager.audio:GetVoiceLength("story_v_out_424101", "424101126", "story_v_out_424101.awb") / 1000

					if var_520_23 + var_520_15 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_23 + var_520_15
					end

					if var_520_18.prefab_name ~= "" and arg_517_1.actors_[var_520_18.prefab_name] ~= nil then
						local var_520_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_18.prefab_name].transform, "story_v_out_424101", "424101126", "story_v_out_424101.awb")

						arg_517_1:RecordAudio("424101126", var_520_24)
						arg_517_1:RecordAudio("424101126", var_520_24)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_424101", "424101126", "story_v_out_424101.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_424101", "424101126", "story_v_out_424101.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_25 = math.max(var_520_16, arg_517_1.talkMaxDuration)

			if var_520_15 <= arg_517_1.time_ and arg_517_1.time_ < var_520_15 + var_520_25 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_15) / var_520_25

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_15 + var_520_25 and arg_517_1.time_ < var_520_15 + var_520_25 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play424101127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 424101127
		arg_521_1.duration_ = 26.03

		local var_521_0 = {
			zh = 14.3,
			ja = 26.033
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play424101128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["10155"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps10155 == nil then
				arg_521_1.var_.actorSpriteComps10155 = var_524_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.actorSpriteComps10155 then
					for iter_524_0, iter_524_1 in pairs(arg_521_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_524_1 then
							if arg_521_1.isInRecall_ then
								local var_524_4 = Mathf.Lerp(iter_524_1.color.r, arg_521_1.hightColor1.r, var_524_3)
								local var_524_5 = Mathf.Lerp(iter_524_1.color.g, arg_521_1.hightColor1.g, var_524_3)
								local var_524_6 = Mathf.Lerp(iter_524_1.color.b, arg_521_1.hightColor1.b, var_524_3)

								iter_524_1.color = Color.New(var_524_4, var_524_5, var_524_6)
							else
								local var_524_7 = Mathf.Lerp(iter_524_1.color.r, 1, var_524_3)

								iter_524_1.color = Color.New(var_524_7, var_524_7, var_524_7)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.actorSpriteComps10155 then
				for iter_524_2, iter_524_3 in pairs(arg_521_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_524_3 then
						if arg_521_1.isInRecall_ then
							iter_524_3.color = arg_521_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_524_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_521_1.var_.actorSpriteComps10155 = nil
			end

			local var_524_8 = arg_521_1.actors_["1094"]
			local var_524_9 = 0

			if var_524_9 < arg_521_1.time_ and arg_521_1.time_ <= var_524_9 + arg_524_0 and not isNil(var_524_8) and arg_521_1.var_.actorSpriteComps1094 == nil then
				arg_521_1.var_.actorSpriteComps1094 = var_524_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_524_10 = 0.2

			if var_524_9 <= arg_521_1.time_ and arg_521_1.time_ < var_524_9 + var_524_10 and not isNil(var_524_8) then
				local var_524_11 = (arg_521_1.time_ - var_524_9) / var_524_10

				if arg_521_1.var_.actorSpriteComps1094 then
					for iter_524_4, iter_524_5 in pairs(arg_521_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_524_5 then
							if arg_521_1.isInRecall_ then
								local var_524_12 = Mathf.Lerp(iter_524_5.color.r, arg_521_1.hightColor2.r, var_524_11)
								local var_524_13 = Mathf.Lerp(iter_524_5.color.g, arg_521_1.hightColor2.g, var_524_11)
								local var_524_14 = Mathf.Lerp(iter_524_5.color.b, arg_521_1.hightColor2.b, var_524_11)

								iter_524_5.color = Color.New(var_524_12, var_524_13, var_524_14)
							else
								local var_524_15 = Mathf.Lerp(iter_524_5.color.r, 0.5, var_524_11)

								iter_524_5.color = Color.New(var_524_15, var_524_15, var_524_15)
							end
						end
					end
				end
			end

			if arg_521_1.time_ >= var_524_9 + var_524_10 and arg_521_1.time_ < var_524_9 + var_524_10 + arg_524_0 and not isNil(var_524_8) and arg_521_1.var_.actorSpriteComps1094 then
				for iter_524_6, iter_524_7 in pairs(arg_521_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_524_7 then
						if arg_521_1.isInRecall_ then
							iter_524_7.color = arg_521_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_524_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_521_1.var_.actorSpriteComps1094 = nil
			end

			local var_524_16 = arg_521_1.actors_["10155"].transform
			local var_524_17 = 0

			if var_524_17 < arg_521_1.time_ and arg_521_1.time_ <= var_524_17 + arg_524_0 then
				arg_521_1.var_.moveOldPos10155 = var_524_16.localPosition
				var_524_16.localScale = Vector3.New(1, 1, 1)

				arg_521_1:CheckSpriteTmpPos("10155", 4)

				local var_524_18 = var_524_16.childCount

				for iter_524_8 = 0, var_524_18 - 1 do
					local var_524_19 = var_524_16:GetChild(iter_524_8)

					if var_524_19.name == "split_6" or not string.find(var_524_19.name, "split") then
						var_524_19.gameObject:SetActive(true)
					else
						var_524_19.gameObject:SetActive(false)
					end
				end
			end

			local var_524_20 = 0.001

			if var_524_17 <= arg_521_1.time_ and arg_521_1.time_ < var_524_17 + var_524_20 then
				local var_524_21 = (arg_521_1.time_ - var_524_17) / var_524_20
				local var_524_22 = Vector3.New(440, -390, -250)

				var_524_16.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos10155, var_524_22, var_524_21)
			end

			if arg_521_1.time_ >= var_524_17 + var_524_20 and arg_521_1.time_ < var_524_17 + var_524_20 + arg_524_0 then
				var_524_16.localPosition = Vector3.New(440, -390, -250)
			end

			local var_524_23 = arg_521_1.actors_["1094"].transform
			local var_524_24 = 0

			if var_524_24 < arg_521_1.time_ and arg_521_1.time_ <= var_524_24 + arg_524_0 then
				arg_521_1.var_.moveOldPos1094 = var_524_23.localPosition
				var_524_23.localScale = Vector3.New(1, 1, 1)

				arg_521_1:CheckSpriteTmpPos("1094", 2)

				local var_524_25 = var_524_23.childCount

				for iter_524_9 = 0, var_524_25 - 1 do
					local var_524_26 = var_524_23:GetChild(iter_524_9)

					if var_524_26.name == "split_1" or not string.find(var_524_26.name, "split") then
						var_524_26.gameObject:SetActive(true)
					else
						var_524_26.gameObject:SetActive(false)
					end
				end
			end

			local var_524_27 = 0.001

			if var_524_24 <= arg_521_1.time_ and arg_521_1.time_ < var_524_24 + var_524_27 then
				local var_524_28 = (arg_521_1.time_ - var_524_24) / var_524_27
				local var_524_29 = Vector3.New(-380, -335, -230)

				var_524_23.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1094, var_524_29, var_524_28)
			end

			if arg_521_1.time_ >= var_524_24 + var_524_27 and arg_521_1.time_ < var_524_24 + var_524_27 + arg_524_0 then
				var_524_23.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_524_30 = 0
			local var_524_31 = 0.9

			if var_524_30 < arg_521_1.time_ and arg_521_1.time_ <= var_524_30 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_32 = arg_521_1:FormatText(StoryNameCfg[1391].name)

				arg_521_1.leftNameTxt_.text = var_524_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_33 = arg_521_1:GetWordFromCfg(424101127)
				local var_524_34 = arg_521_1:FormatText(var_524_33.content)

				arg_521_1.text_.text = var_524_34

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_35 = 36
				local var_524_36 = utf8.len(var_524_34)
				local var_524_37 = var_524_35 <= 0 and var_524_31 or var_524_31 * (var_524_36 / var_524_35)

				if var_524_37 > 0 and var_524_31 < var_524_37 then
					arg_521_1.talkMaxDuration = var_524_37

					if var_524_37 + var_524_30 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_37 + var_524_30
					end
				end

				arg_521_1.text_.text = var_524_34
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101127", "story_v_out_424101.awb") ~= 0 then
					local var_524_38 = manager.audio:GetVoiceLength("story_v_out_424101", "424101127", "story_v_out_424101.awb") / 1000

					if var_524_38 + var_524_30 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_38 + var_524_30
					end

					if var_524_33.prefab_name ~= "" and arg_521_1.actors_[var_524_33.prefab_name] ~= nil then
						local var_524_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_33.prefab_name].transform, "story_v_out_424101", "424101127", "story_v_out_424101.awb")

						arg_521_1:RecordAudio("424101127", var_524_39)
						arg_521_1:RecordAudio("424101127", var_524_39)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_424101", "424101127", "story_v_out_424101.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_424101", "424101127", "story_v_out_424101.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_40 = math.max(var_524_31, arg_521_1.talkMaxDuration)

			if var_524_30 <= arg_521_1.time_ and arg_521_1.time_ < var_524_30 + var_524_40 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_30) / var_524_40

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_30 + var_524_40 and arg_521_1.time_ < var_524_30 + var_524_40 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play424101128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 424101128
		arg_525_1.duration_ = 3.9

		local var_525_0 = {
			zh = 3.233,
			ja = 3.9
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play424101129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1094"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps1094 == nil then
				arg_525_1.var_.actorSpriteComps1094 = var_528_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_2 = 0.2

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.actorSpriteComps1094 then
					for iter_528_0, iter_528_1 in pairs(arg_525_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_528_1 then
							if arg_525_1.isInRecall_ then
								local var_528_4 = Mathf.Lerp(iter_528_1.color.r, arg_525_1.hightColor1.r, var_528_3)
								local var_528_5 = Mathf.Lerp(iter_528_1.color.g, arg_525_1.hightColor1.g, var_528_3)
								local var_528_6 = Mathf.Lerp(iter_528_1.color.b, arg_525_1.hightColor1.b, var_528_3)

								iter_528_1.color = Color.New(var_528_4, var_528_5, var_528_6)
							else
								local var_528_7 = Mathf.Lerp(iter_528_1.color.r, 1, var_528_3)

								iter_528_1.color = Color.New(var_528_7, var_528_7, var_528_7)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps1094 then
				for iter_528_2, iter_528_3 in pairs(arg_525_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_528_3 then
						if arg_525_1.isInRecall_ then
							iter_528_3.color = arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_528_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps1094 = nil
			end

			local var_528_8 = arg_525_1.actors_["10155"]
			local var_528_9 = 0

			if var_528_9 < arg_525_1.time_ and arg_525_1.time_ <= var_528_9 + arg_528_0 and not isNil(var_528_8) and arg_525_1.var_.actorSpriteComps10155 == nil then
				arg_525_1.var_.actorSpriteComps10155 = var_528_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_10 = 0.2

			if var_528_9 <= arg_525_1.time_ and arg_525_1.time_ < var_528_9 + var_528_10 and not isNil(var_528_8) then
				local var_528_11 = (arg_525_1.time_ - var_528_9) / var_528_10

				if arg_525_1.var_.actorSpriteComps10155 then
					for iter_528_4, iter_528_5 in pairs(arg_525_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_528_5 then
							if arg_525_1.isInRecall_ then
								local var_528_12 = Mathf.Lerp(iter_528_5.color.r, arg_525_1.hightColor2.r, var_528_11)
								local var_528_13 = Mathf.Lerp(iter_528_5.color.g, arg_525_1.hightColor2.g, var_528_11)
								local var_528_14 = Mathf.Lerp(iter_528_5.color.b, arg_525_1.hightColor2.b, var_528_11)

								iter_528_5.color = Color.New(var_528_12, var_528_13, var_528_14)
							else
								local var_528_15 = Mathf.Lerp(iter_528_5.color.r, 0.5, var_528_11)

								iter_528_5.color = Color.New(var_528_15, var_528_15, var_528_15)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_9 + var_528_10 and arg_525_1.time_ < var_528_9 + var_528_10 + arg_528_0 and not isNil(var_528_8) and arg_525_1.var_.actorSpriteComps10155 then
				for iter_528_6, iter_528_7 in pairs(arg_525_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_528_7 then
						if arg_525_1.isInRecall_ then
							iter_528_7.color = arg_525_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_528_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps10155 = nil
			end

			local var_528_16 = 0
			local var_528_17 = 0.3

			if var_528_16 < arg_525_1.time_ and arg_525_1.time_ <= var_528_16 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_18 = arg_525_1:FormatText(StoryNameCfg[181].name)

				arg_525_1.leftNameTxt_.text = var_528_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_19 = arg_525_1:GetWordFromCfg(424101128)
				local var_528_20 = arg_525_1:FormatText(var_528_19.content)

				arg_525_1.text_.text = var_528_20

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_21 = 12
				local var_528_22 = utf8.len(var_528_20)
				local var_528_23 = var_528_21 <= 0 and var_528_17 or var_528_17 * (var_528_22 / var_528_21)

				if var_528_23 > 0 and var_528_17 < var_528_23 then
					arg_525_1.talkMaxDuration = var_528_23

					if var_528_23 + var_528_16 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_23 + var_528_16
					end
				end

				arg_525_1.text_.text = var_528_20
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101128", "story_v_out_424101.awb") ~= 0 then
					local var_528_24 = manager.audio:GetVoiceLength("story_v_out_424101", "424101128", "story_v_out_424101.awb") / 1000

					if var_528_24 + var_528_16 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_24 + var_528_16
					end

					if var_528_19.prefab_name ~= "" and arg_525_1.actors_[var_528_19.prefab_name] ~= nil then
						local var_528_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_19.prefab_name].transform, "story_v_out_424101", "424101128", "story_v_out_424101.awb")

						arg_525_1:RecordAudio("424101128", var_528_25)
						arg_525_1:RecordAudio("424101128", var_528_25)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_424101", "424101128", "story_v_out_424101.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_424101", "424101128", "story_v_out_424101.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_26 = math.max(var_528_17, arg_525_1.talkMaxDuration)

			if var_528_16 <= arg_525_1.time_ and arg_525_1.time_ < var_528_16 + var_528_26 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_16) / var_528_26

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_16 + var_528_26 and arg_525_1.time_ < var_528_16 + var_528_26 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play424101129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 424101129
		arg_529_1.duration_ = 19.8

		local var_529_0 = {
			zh = 15.266,
			ja = 19.8
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play424101130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["10155"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps10155 == nil then
				arg_529_1.var_.actorSpriteComps10155 = var_532_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.actorSpriteComps10155 then
					for iter_532_0, iter_532_1 in pairs(arg_529_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_532_1 then
							if arg_529_1.isInRecall_ then
								local var_532_4 = Mathf.Lerp(iter_532_1.color.r, arg_529_1.hightColor1.r, var_532_3)
								local var_532_5 = Mathf.Lerp(iter_532_1.color.g, arg_529_1.hightColor1.g, var_532_3)
								local var_532_6 = Mathf.Lerp(iter_532_1.color.b, arg_529_1.hightColor1.b, var_532_3)

								iter_532_1.color = Color.New(var_532_4, var_532_5, var_532_6)
							else
								local var_532_7 = Mathf.Lerp(iter_532_1.color.r, 1, var_532_3)

								iter_532_1.color = Color.New(var_532_7, var_532_7, var_532_7)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps10155 then
				for iter_532_2, iter_532_3 in pairs(arg_529_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_532_3 then
						if arg_529_1.isInRecall_ then
							iter_532_3.color = arg_529_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_532_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_529_1.var_.actorSpriteComps10155 = nil
			end

			local var_532_8 = arg_529_1.actors_["1094"]
			local var_532_9 = 0

			if var_532_9 < arg_529_1.time_ and arg_529_1.time_ <= var_532_9 + arg_532_0 and not isNil(var_532_8) and arg_529_1.var_.actorSpriteComps1094 == nil then
				arg_529_1.var_.actorSpriteComps1094 = var_532_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_10 = 0.2

			if var_532_9 <= arg_529_1.time_ and arg_529_1.time_ < var_532_9 + var_532_10 and not isNil(var_532_8) then
				local var_532_11 = (arg_529_1.time_ - var_532_9) / var_532_10

				if arg_529_1.var_.actorSpriteComps1094 then
					for iter_532_4, iter_532_5 in pairs(arg_529_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_532_5 then
							if arg_529_1.isInRecall_ then
								local var_532_12 = Mathf.Lerp(iter_532_5.color.r, arg_529_1.hightColor2.r, var_532_11)
								local var_532_13 = Mathf.Lerp(iter_532_5.color.g, arg_529_1.hightColor2.g, var_532_11)
								local var_532_14 = Mathf.Lerp(iter_532_5.color.b, arg_529_1.hightColor2.b, var_532_11)

								iter_532_5.color = Color.New(var_532_12, var_532_13, var_532_14)
							else
								local var_532_15 = Mathf.Lerp(iter_532_5.color.r, 0.5, var_532_11)

								iter_532_5.color = Color.New(var_532_15, var_532_15, var_532_15)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= var_532_9 + var_532_10 and arg_529_1.time_ < var_532_9 + var_532_10 + arg_532_0 and not isNil(var_532_8) and arg_529_1.var_.actorSpriteComps1094 then
				for iter_532_6, iter_532_7 in pairs(arg_529_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_532_7 then
						if arg_529_1.isInRecall_ then
							iter_532_7.color = arg_529_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_532_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_529_1.var_.actorSpriteComps1094 = nil
			end

			local var_532_16 = 0
			local var_532_17 = 0.975

			if var_532_16 < arg_529_1.time_ and arg_529_1.time_ <= var_532_16 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_18 = arg_529_1:FormatText(StoryNameCfg[1391].name)

				arg_529_1.leftNameTxt_.text = var_532_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_19 = arg_529_1:GetWordFromCfg(424101129)
				local var_532_20 = arg_529_1:FormatText(var_532_19.content)

				arg_529_1.text_.text = var_532_20

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_21 = 39
				local var_532_22 = utf8.len(var_532_20)
				local var_532_23 = var_532_21 <= 0 and var_532_17 or var_532_17 * (var_532_22 / var_532_21)

				if var_532_23 > 0 and var_532_17 < var_532_23 then
					arg_529_1.talkMaxDuration = var_532_23

					if var_532_23 + var_532_16 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_23 + var_532_16
					end
				end

				arg_529_1.text_.text = var_532_20
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101129", "story_v_out_424101.awb") ~= 0 then
					local var_532_24 = manager.audio:GetVoiceLength("story_v_out_424101", "424101129", "story_v_out_424101.awb") / 1000

					if var_532_24 + var_532_16 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_24 + var_532_16
					end

					if var_532_19.prefab_name ~= "" and arg_529_1.actors_[var_532_19.prefab_name] ~= nil then
						local var_532_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_19.prefab_name].transform, "story_v_out_424101", "424101129", "story_v_out_424101.awb")

						arg_529_1:RecordAudio("424101129", var_532_25)
						arg_529_1:RecordAudio("424101129", var_532_25)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_424101", "424101129", "story_v_out_424101.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_424101", "424101129", "story_v_out_424101.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_26 = math.max(var_532_17, arg_529_1.talkMaxDuration)

			if var_532_16 <= arg_529_1.time_ and arg_529_1.time_ < var_532_16 + var_532_26 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_16) / var_532_26

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_16 + var_532_26 and arg_529_1.time_ < var_532_16 + var_532_26 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play424101130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 424101130
		arg_533_1.duration_ = 8.5

		local var_533_0 = {
			zh = 7.833,
			ja = 8.5
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play424101131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0
			local var_536_1 = 0.525

			if var_536_0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_2 = arg_533_1:FormatText(StoryNameCfg[1391].name)

				arg_533_1.leftNameTxt_.text = var_536_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_3 = arg_533_1:GetWordFromCfg(424101130)
				local var_536_4 = arg_533_1:FormatText(var_536_3.content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 21
				local var_536_6 = utf8.len(var_536_4)
				local var_536_7 = var_536_5 <= 0 and var_536_1 or var_536_1 * (var_536_6 / var_536_5)

				if var_536_7 > 0 and var_536_1 < var_536_7 then
					arg_533_1.talkMaxDuration = var_536_7

					if var_536_7 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_7 + var_536_0
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101130", "story_v_out_424101.awb") ~= 0 then
					local var_536_8 = manager.audio:GetVoiceLength("story_v_out_424101", "424101130", "story_v_out_424101.awb") / 1000

					if var_536_8 + var_536_0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_8 + var_536_0
					end

					if var_536_3.prefab_name ~= "" and arg_533_1.actors_[var_536_3.prefab_name] ~= nil then
						local var_536_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_3.prefab_name].transform, "story_v_out_424101", "424101130", "story_v_out_424101.awb")

						arg_533_1:RecordAudio("424101130", var_536_9)
						arg_533_1:RecordAudio("424101130", var_536_9)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_424101", "424101130", "story_v_out_424101.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_424101", "424101130", "story_v_out_424101.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_10 = math.max(var_536_1, arg_533_1.talkMaxDuration)

			if var_536_0 <= arg_533_1.time_ and arg_533_1.time_ < var_536_0 + var_536_10 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_0) / var_536_10

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_0 + var_536_10 and arg_533_1.time_ < var_536_0 + var_536_10 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play424101131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 424101131
		arg_537_1.duration_ = 6

		local var_537_0 = {
			zh = 6,
			ja = 5.8
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play424101132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["1094"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps1094 == nil then
				arg_537_1.var_.actorSpriteComps1094 = var_540_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_2 = 0.2

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.actorSpriteComps1094 then
					for iter_540_0, iter_540_1 in pairs(arg_537_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_540_1 then
							if arg_537_1.isInRecall_ then
								local var_540_4 = Mathf.Lerp(iter_540_1.color.r, arg_537_1.hightColor1.r, var_540_3)
								local var_540_5 = Mathf.Lerp(iter_540_1.color.g, arg_537_1.hightColor1.g, var_540_3)
								local var_540_6 = Mathf.Lerp(iter_540_1.color.b, arg_537_1.hightColor1.b, var_540_3)

								iter_540_1.color = Color.New(var_540_4, var_540_5, var_540_6)
							else
								local var_540_7 = Mathf.Lerp(iter_540_1.color.r, 1, var_540_3)

								iter_540_1.color = Color.New(var_540_7, var_540_7, var_540_7)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps1094 then
				for iter_540_2, iter_540_3 in pairs(arg_537_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_540_3 then
						if arg_537_1.isInRecall_ then
							iter_540_3.color = arg_537_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_540_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_537_1.var_.actorSpriteComps1094 = nil
			end

			local var_540_8 = arg_537_1.actors_["10155"]
			local var_540_9 = 0

			if var_540_9 < arg_537_1.time_ and arg_537_1.time_ <= var_540_9 + arg_540_0 and not isNil(var_540_8) and arg_537_1.var_.actorSpriteComps10155 == nil then
				arg_537_1.var_.actorSpriteComps10155 = var_540_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_10 = 0.2

			if var_540_9 <= arg_537_1.time_ and arg_537_1.time_ < var_540_9 + var_540_10 and not isNil(var_540_8) then
				local var_540_11 = (arg_537_1.time_ - var_540_9) / var_540_10

				if arg_537_1.var_.actorSpriteComps10155 then
					for iter_540_4, iter_540_5 in pairs(arg_537_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_540_5 then
							if arg_537_1.isInRecall_ then
								local var_540_12 = Mathf.Lerp(iter_540_5.color.r, arg_537_1.hightColor2.r, var_540_11)
								local var_540_13 = Mathf.Lerp(iter_540_5.color.g, arg_537_1.hightColor2.g, var_540_11)
								local var_540_14 = Mathf.Lerp(iter_540_5.color.b, arg_537_1.hightColor2.b, var_540_11)

								iter_540_5.color = Color.New(var_540_12, var_540_13, var_540_14)
							else
								local var_540_15 = Mathf.Lerp(iter_540_5.color.r, 0.5, var_540_11)

								iter_540_5.color = Color.New(var_540_15, var_540_15, var_540_15)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= var_540_9 + var_540_10 and arg_537_1.time_ < var_540_9 + var_540_10 + arg_540_0 and not isNil(var_540_8) and arg_537_1.var_.actorSpriteComps10155 then
				for iter_540_6, iter_540_7 in pairs(arg_537_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_540_7 then
						if arg_537_1.isInRecall_ then
							iter_540_7.color = arg_537_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_540_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_537_1.var_.actorSpriteComps10155 = nil
			end

			local var_540_16 = 0
			local var_540_17 = 0.475

			if var_540_16 < arg_537_1.time_ and arg_537_1.time_ <= var_540_16 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_18 = arg_537_1:FormatText(StoryNameCfg[181].name)

				arg_537_1.leftNameTxt_.text = var_540_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_19 = arg_537_1:GetWordFromCfg(424101131)
				local var_540_20 = arg_537_1:FormatText(var_540_19.content)

				arg_537_1.text_.text = var_540_20

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_21 = 19
				local var_540_22 = utf8.len(var_540_20)
				local var_540_23 = var_540_21 <= 0 and var_540_17 or var_540_17 * (var_540_22 / var_540_21)

				if var_540_23 > 0 and var_540_17 < var_540_23 then
					arg_537_1.talkMaxDuration = var_540_23

					if var_540_23 + var_540_16 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_23 + var_540_16
					end
				end

				arg_537_1.text_.text = var_540_20
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101131", "story_v_out_424101.awb") ~= 0 then
					local var_540_24 = manager.audio:GetVoiceLength("story_v_out_424101", "424101131", "story_v_out_424101.awb") / 1000

					if var_540_24 + var_540_16 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_24 + var_540_16
					end

					if var_540_19.prefab_name ~= "" and arg_537_1.actors_[var_540_19.prefab_name] ~= nil then
						local var_540_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_19.prefab_name].transform, "story_v_out_424101", "424101131", "story_v_out_424101.awb")

						arg_537_1:RecordAudio("424101131", var_540_25)
						arg_537_1:RecordAudio("424101131", var_540_25)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_424101", "424101131", "story_v_out_424101.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_424101", "424101131", "story_v_out_424101.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_26 = math.max(var_540_17, arg_537_1.talkMaxDuration)

			if var_540_16 <= arg_537_1.time_ and arg_537_1.time_ < var_540_16 + var_540_26 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_16) / var_540_26

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_16 + var_540_26 and arg_537_1.time_ < var_540_16 + var_540_26 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play424101132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 424101132
		arg_541_1.duration_ = 15.5

		local var_541_0 = {
			zh = 8.6,
			ja = 15.5
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play424101133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["10155"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps10155 == nil then
				arg_541_1.var_.actorSpriteComps10155 = var_544_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.actorSpriteComps10155 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								local var_544_4 = Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor1.r, var_544_3)
								local var_544_5 = Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor1.g, var_544_3)
								local var_544_6 = Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor1.b, var_544_3)

								iter_544_1.color = Color.New(var_544_4, var_544_5, var_544_6)
							else
								local var_544_7 = Mathf.Lerp(iter_544_1.color.r, 1, var_544_3)

								iter_544_1.color = Color.New(var_544_7, var_544_7, var_544_7)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.actorSpriteComps10155 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_544_3 then
						if arg_541_1.isInRecall_ then
							iter_544_3.color = arg_541_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_544_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps10155 = nil
			end

			local var_544_8 = arg_541_1.actors_["1094"]
			local var_544_9 = 0

			if var_544_9 < arg_541_1.time_ and arg_541_1.time_ <= var_544_9 + arg_544_0 and not isNil(var_544_8) and arg_541_1.var_.actorSpriteComps1094 == nil then
				arg_541_1.var_.actorSpriteComps1094 = var_544_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_10 = 0.2

			if var_544_9 <= arg_541_1.time_ and arg_541_1.time_ < var_544_9 + var_544_10 and not isNil(var_544_8) then
				local var_544_11 = (arg_541_1.time_ - var_544_9) / var_544_10

				if arg_541_1.var_.actorSpriteComps1094 then
					for iter_544_4, iter_544_5 in pairs(arg_541_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_544_5 then
							if arg_541_1.isInRecall_ then
								local var_544_12 = Mathf.Lerp(iter_544_5.color.r, arg_541_1.hightColor2.r, var_544_11)
								local var_544_13 = Mathf.Lerp(iter_544_5.color.g, arg_541_1.hightColor2.g, var_544_11)
								local var_544_14 = Mathf.Lerp(iter_544_5.color.b, arg_541_1.hightColor2.b, var_544_11)

								iter_544_5.color = Color.New(var_544_12, var_544_13, var_544_14)
							else
								local var_544_15 = Mathf.Lerp(iter_544_5.color.r, 0.5, var_544_11)

								iter_544_5.color = Color.New(var_544_15, var_544_15, var_544_15)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= var_544_9 + var_544_10 and arg_541_1.time_ < var_544_9 + var_544_10 + arg_544_0 and not isNil(var_544_8) and arg_541_1.var_.actorSpriteComps1094 then
				for iter_544_6, iter_544_7 in pairs(arg_541_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_544_7 then
						if arg_541_1.isInRecall_ then
							iter_544_7.color = arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_544_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_541_1.var_.actorSpriteComps1094 = nil
			end

			local var_544_16 = 0
			local var_544_17 = 0.525

			if var_544_16 < arg_541_1.time_ and arg_541_1.time_ <= var_544_16 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_18 = arg_541_1:FormatText(StoryNameCfg[1391].name)

				arg_541_1.leftNameTxt_.text = var_544_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_19 = arg_541_1:GetWordFromCfg(424101132)
				local var_544_20 = arg_541_1:FormatText(var_544_19.content)

				arg_541_1.text_.text = var_544_20

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_21 = 21
				local var_544_22 = utf8.len(var_544_20)
				local var_544_23 = var_544_21 <= 0 and var_544_17 or var_544_17 * (var_544_22 / var_544_21)

				if var_544_23 > 0 and var_544_17 < var_544_23 then
					arg_541_1.talkMaxDuration = var_544_23

					if var_544_23 + var_544_16 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_23 + var_544_16
					end
				end

				arg_541_1.text_.text = var_544_20
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424101", "424101132", "story_v_out_424101.awb") ~= 0 then
					local var_544_24 = manager.audio:GetVoiceLength("story_v_out_424101", "424101132", "story_v_out_424101.awb") / 1000

					if var_544_24 + var_544_16 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_24 + var_544_16
					end

					if var_544_19.prefab_name ~= "" and arg_541_1.actors_[var_544_19.prefab_name] ~= nil then
						local var_544_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_19.prefab_name].transform, "story_v_out_424101", "424101132", "story_v_out_424101.awb")

						arg_541_1:RecordAudio("424101132", var_544_25)
						arg_541_1:RecordAudio("424101132", var_544_25)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_424101", "424101132", "story_v_out_424101.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_424101", "424101132", "story_v_out_424101.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_26 = math.max(var_544_17, arg_541_1.talkMaxDuration)

			if var_544_16 <= arg_541_1.time_ and arg_541_1.time_ < var_544_16 + var_544_26 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_16) / var_544_26

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_16 + var_544_26 and arg_541_1.time_ < var_544_16 + var_544_26 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play424101133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 424101133
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play424101134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = arg_545_1.actors_["10155"]
			local var_548_1 = 0

			if var_548_1 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps10155 == nil then
				arg_545_1.var_.actorSpriteComps10155 = var_548_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_2 = 0.2

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_2 and not isNil(var_548_0) then
				local var_548_3 = (arg_545_1.time_ - var_548_1) / var_548_2

				if arg_545_1.var_.actorSpriteComps10155 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								local var_548_4 = Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor2.r, var_548_3)
								local var_548_5 = Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor2.g, var_548_3)
								local var_548_6 = Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor2.b, var_548_3)

								iter_548_1.color = Color.New(var_548_4, var_548_5, var_548_6)
							else
								local var_548_7 = Mathf.Lerp(iter_548_1.color.r, 0.5, var_548_3)

								iter_548_1.color = Color.New(var_548_7, var_548_7, var_548_7)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= var_548_1 + var_548_2 and arg_545_1.time_ < var_548_1 + var_548_2 + arg_548_0 and not isNil(var_548_0) and arg_545_1.var_.actorSpriteComps10155 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_548_3 then
						if arg_545_1.isInRecall_ then
							iter_548_3.color = arg_545_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_548_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_545_1.var_.actorSpriteComps10155 = nil
			end

			local var_548_8 = arg_545_1.actors_["10155"].transform
			local var_548_9 = 0

			if var_548_9 < arg_545_1.time_ and arg_545_1.time_ <= var_548_9 + arg_548_0 then
				arg_545_1.var_.moveOldPos10155 = var_548_8.localPosition
				var_548_8.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("10155", 7)

				local var_548_10 = var_548_8.childCount

				for iter_548_4 = 0, var_548_10 - 1 do
					local var_548_11 = var_548_8:GetChild(iter_548_4)

					if var_548_11.name == "" or not string.find(var_548_11.name, "split") then
						var_548_11.gameObject:SetActive(true)
					else
						var_548_11.gameObject:SetActive(false)
					end
				end
			end

			local var_548_12 = 0.001

			if var_548_9 <= arg_545_1.time_ and arg_545_1.time_ < var_548_9 + var_548_12 then
				local var_548_13 = (arg_545_1.time_ - var_548_9) / var_548_12
				local var_548_14 = Vector3.New(0, -2000, 0)

				var_548_8.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos10155, var_548_14, var_548_13)
			end

			if arg_545_1.time_ >= var_548_9 + var_548_12 and arg_545_1.time_ < var_548_9 + var_548_12 + arg_548_0 then
				var_548_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_548_15 = arg_545_1.actors_["1094"].transform
			local var_548_16 = 0

			if var_548_16 < arg_545_1.time_ and arg_545_1.time_ <= var_548_16 + arg_548_0 then
				arg_545_1.var_.moveOldPos1094 = var_548_15.localPosition
				var_548_15.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("1094", 7)

				local var_548_17 = var_548_15.childCount

				for iter_548_5 = 0, var_548_17 - 1 do
					local var_548_18 = var_548_15:GetChild(iter_548_5)

					if var_548_18.name == "" or not string.find(var_548_18.name, "split") then
						var_548_18.gameObject:SetActive(true)
					else
						var_548_18.gameObject:SetActive(false)
					end
				end
			end

			local var_548_19 = 0.001

			if var_548_16 <= arg_545_1.time_ and arg_545_1.time_ < var_548_16 + var_548_19 then
				local var_548_20 = (arg_545_1.time_ - var_548_16) / var_548_19
				local var_548_21 = Vector3.New(0, -2000, 0)

				var_548_15.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1094, var_548_21, var_548_20)
			end

			if arg_545_1.time_ >= var_548_16 + var_548_19 and arg_545_1.time_ < var_548_16 + var_548_19 + arg_548_0 then
				var_548_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_548_22 = 0
			local var_548_23 = 1.025

			if var_548_22 < arg_545_1.time_ and arg_545_1.time_ <= var_548_22 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_24 = arg_545_1:GetWordFromCfg(424101133)
				local var_548_25 = arg_545_1:FormatText(var_548_24.content)

				arg_545_1.text_.text = var_548_25

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_26 = 41
				local var_548_27 = utf8.len(var_548_25)
				local var_548_28 = var_548_26 <= 0 and var_548_23 or var_548_23 * (var_548_27 / var_548_26)

				if var_548_28 > 0 and var_548_23 < var_548_28 then
					arg_545_1.talkMaxDuration = var_548_28

					if var_548_28 + var_548_22 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_28 + var_548_22
					end
				end

				arg_545_1.text_.text = var_548_25
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_29 = math.max(var_548_23, arg_545_1.talkMaxDuration)

			if var_548_22 <= arg_545_1.time_ and arg_545_1.time_ < var_548_22 + var_548_29 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_22) / var_548_29

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_22 + var_548_29 and arg_545_1.time_ < var_548_22 + var_548_29 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play424101134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 424101134
		arg_549_1.duration_ = 9

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play424101135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 2

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				local var_552_1 = manager.ui.mainCamera.transform.localPosition
				local var_552_2 = Vector3.New(0, 0, 10) + Vector3.New(var_552_1.x, var_552_1.y, 0)
				local var_552_3 = arg_549_1.bgs_.I11s

				var_552_3.transform.localPosition = var_552_2
				var_552_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_552_4 = var_552_3:GetComponent("SpriteRenderer")

				if var_552_4 and var_552_4.sprite then
					local var_552_5 = (var_552_3.transform.localPosition - var_552_1).z
					local var_552_6 = manager.ui.mainCameraCom_
					local var_552_7 = 2 * var_552_5 * Mathf.Tan(var_552_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_552_8 = var_552_7 * var_552_6.aspect
					local var_552_9 = var_552_4.sprite.bounds.size.x
					local var_552_10 = var_552_4.sprite.bounds.size.y
					local var_552_11 = var_552_8 / var_552_9
					local var_552_12 = var_552_7 / var_552_10
					local var_552_13 = var_552_12 < var_552_11 and var_552_11 or var_552_12

					var_552_3.transform.localScale = Vector3.New(var_552_13, var_552_13, 0)
				end

				for iter_552_0, iter_552_1 in pairs(arg_549_1.bgs_) do
					if iter_552_0 ~= "I11s" then
						iter_552_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_552_14 = 4

			if var_552_14 < arg_549_1.time_ and arg_549_1.time_ <= var_552_14 + arg_552_0 then
				arg_549_1.allBtn_.enabled = false
			end

			local var_552_15 = 0.3

			if arg_549_1.time_ >= var_552_14 + var_552_15 and arg_549_1.time_ < var_552_14 + var_552_15 + arg_552_0 then
				arg_549_1.allBtn_.enabled = true
			end

			local var_552_16 = 0

			if var_552_16 < arg_549_1.time_ and arg_549_1.time_ <= var_552_16 + arg_552_0 then
				arg_549_1.mask_.enabled = true
				arg_549_1.mask_.raycastTarget = true

				arg_549_1:SetGaussion(false)
			end

			local var_552_17 = 2

			if var_552_16 <= arg_549_1.time_ and arg_549_1.time_ < var_552_16 + var_552_17 then
				local var_552_18 = (arg_549_1.time_ - var_552_16) / var_552_17
				local var_552_19 = Color.New(0, 0, 0)

				var_552_19.a = Mathf.Lerp(0, 1, var_552_18)
				arg_549_1.mask_.color = var_552_19
			end

			if arg_549_1.time_ >= var_552_16 + var_552_17 and arg_549_1.time_ < var_552_16 + var_552_17 + arg_552_0 then
				local var_552_20 = Color.New(0, 0, 0)

				var_552_20.a = 1
				arg_549_1.mask_.color = var_552_20
			end

			local var_552_21 = 2

			if var_552_21 < arg_549_1.time_ and arg_549_1.time_ <= var_552_21 + arg_552_0 then
				arg_549_1.mask_.enabled = true
				arg_549_1.mask_.raycastTarget = true

				arg_549_1:SetGaussion(false)
			end

			local var_552_22 = 2

			if var_552_21 <= arg_549_1.time_ and arg_549_1.time_ < var_552_21 + var_552_22 then
				local var_552_23 = (arg_549_1.time_ - var_552_21) / var_552_22
				local var_552_24 = Color.New(0, 0, 0)

				var_552_24.a = Mathf.Lerp(1, 0, var_552_23)
				arg_549_1.mask_.color = var_552_24
			end

			if arg_549_1.time_ >= var_552_21 + var_552_22 and arg_549_1.time_ < var_552_21 + var_552_22 + arg_552_0 then
				local var_552_25 = Color.New(0, 0, 0)
				local var_552_26 = 0

				arg_549_1.mask_.enabled = false
				var_552_25.a = var_552_26
				arg_549_1.mask_.color = var_552_25
			end

			local var_552_27 = 0.2
			local var_552_28 = 1

			if var_552_27 < arg_549_1.time_ and arg_549_1.time_ <= var_552_27 + arg_552_0 then
				local var_552_29 = "stop"
				local var_552_30 = "effect"

				arg_549_1:AudioAction(var_552_29, var_552_30, "se_story_146", "se_story_146_wind02", "")
			end

			local var_552_31 = 1.63333333333333
			local var_552_32 = 1

			if var_552_31 < arg_549_1.time_ and arg_549_1.time_ <= var_552_31 + arg_552_0 then
				local var_552_33 = "play"
				local var_552_34 = "effect"

				arg_549_1:AudioAction(var_552_33, var_552_34, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_552_35 = 4
			local var_552_36 = 1

			if var_552_35 < arg_549_1.time_ and arg_549_1.time_ <= var_552_35 + arg_552_0 then
				local var_552_37 = "play"
				local var_552_38 = "effect"

				arg_549_1:AudioAction(var_552_37, var_552_38, "se_story_side_1037", "se_story_1037_fall", "")
			end

			if arg_549_1.frameCnt_ <= 1 then
				arg_549_1.dialog_:SetActive(false)
			end

			local var_552_39 = 4
			local var_552_40 = 1.15

			if var_552_39 < arg_549_1.time_ and arg_549_1.time_ <= var_552_39 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0

				arg_549_1.dialog_:SetActive(true)

				arg_549_1.dialogCg_.alpha = 0

				local var_552_41 = LeanTween.value(arg_549_1.dialog_, 0, 1, 0.3)

				var_552_41:setOnUpdate(LuaHelper.FloatAction(function(arg_553_0)
					arg_549_1.dialogCg_.alpha = arg_553_0
				end))
				var_552_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_549_1.dialog_)
					var_552_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_549_1.duration_ = arg_549_1.duration_ + 0.3

				SetActive(arg_549_1.leftNameGo_, false)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_42 = arg_549_1:GetWordFromCfg(424101134)
				local var_552_43 = arg_549_1:FormatText(var_552_42.content)

				arg_549_1.text_.text = var_552_43

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_44 = 46
				local var_552_45 = utf8.len(var_552_43)
				local var_552_46 = var_552_44 <= 0 and var_552_40 or var_552_40 * (var_552_45 / var_552_44)

				if var_552_46 > 0 and var_552_40 < var_552_46 then
					arg_549_1.talkMaxDuration = var_552_46
					var_552_39 = var_552_39 + 0.3

					if var_552_46 + var_552_39 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_46 + var_552_39
					end
				end

				arg_549_1.text_.text = var_552_43
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_47 = var_552_39 + 0.3
			local var_552_48 = math.max(var_552_40, arg_549_1.talkMaxDuration)

			if var_552_47 <= arg_549_1.time_ and arg_549_1.time_ < var_552_47 + var_552_48 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_47) / var_552_48

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_47 + var_552_48 and arg_549_1.time_ < var_552_47 + var_552_48 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play424101135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 424101135
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play424101136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 1.025

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_2 = arg_555_1:FormatText(StoryNameCfg[7].name)

				arg_555_1.leftNameTxt_.text = var_558_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:GetWordFromCfg(424101135)
				local var_558_4 = arg_555_1:FormatText(var_558_3.content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 41
				local var_558_6 = utf8.len(var_558_4)
				local var_558_7 = var_558_5 <= 0 and var_558_1 or var_558_1 * (var_558_6 / var_558_5)

				if var_558_7 > 0 and var_558_1 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_8 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_8 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_8

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_8 and arg_555_1.time_ < var_558_0 + var_558_8 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play424101136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 424101136
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play424101137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 1.75

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_2 = arg_559_1:GetWordFromCfg(424101136)
				local var_562_3 = arg_559_1:FormatText(var_562_2.content)

				arg_559_1.text_.text = var_562_3

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 70
				local var_562_5 = utf8.len(var_562_3)
				local var_562_6 = var_562_4 <= 0 and var_562_1 or var_562_1 * (var_562_5 / var_562_4)

				if var_562_6 > 0 and var_562_1 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_0
					end
				end

				arg_559_1.text_.text = var_562_3
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_7 and arg_559_1.time_ < var_562_0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play424101137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 424101137
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play424101138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0
			local var_566_1 = 1.175

			if var_566_0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_2 = arg_563_1:FormatText(StoryNameCfg[7].name)

				arg_563_1.leftNameTxt_.text = var_566_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_3 = arg_563_1:GetWordFromCfg(424101137)
				local var_566_4 = arg_563_1:FormatText(var_566_3.content)

				arg_563_1.text_.text = var_566_4

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 47
				local var_566_6 = utf8.len(var_566_4)
				local var_566_7 = var_566_5 <= 0 and var_566_1 or var_566_1 * (var_566_6 / var_566_5)

				if var_566_7 > 0 and var_566_1 < var_566_7 then
					arg_563_1.talkMaxDuration = var_566_7

					if var_566_7 + var_566_0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_0
					end
				end

				arg_563_1.text_.text = var_566_4
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_8 = math.max(var_566_1, arg_563_1.talkMaxDuration)

			if var_566_0 <= arg_563_1.time_ and arg_563_1.time_ < var_566_0 + var_566_8 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_0) / var_566_8

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_0 + var_566_8 and arg_563_1.time_ < var_566_0 + var_566_8 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play424101138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 424101138
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play424101139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.1
			local var_570_1 = 1

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				local var_570_2 = "play"
				local var_570_3 = "effect"

				arg_567_1:AudioAction(var_570_2, var_570_3, "se_story_17", "se_story_17_ui", "")
			end

			local var_570_4 = 0
			local var_570_5 = 1.55

			if var_570_4 < arg_567_1.time_ and arg_567_1.time_ <= var_570_4 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, false)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_6 = arg_567_1:GetWordFromCfg(424101138)
				local var_570_7 = arg_567_1:FormatText(var_570_6.content)

				arg_567_1.text_.text = var_570_7

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_8 = 62
				local var_570_9 = utf8.len(var_570_7)
				local var_570_10 = var_570_8 <= 0 and var_570_5 or var_570_5 * (var_570_9 / var_570_8)

				if var_570_10 > 0 and var_570_5 < var_570_10 then
					arg_567_1.talkMaxDuration = var_570_10

					if var_570_10 + var_570_4 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_10 + var_570_4
					end
				end

				arg_567_1.text_.text = var_570_7
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_11 = math.max(var_570_5, arg_567_1.talkMaxDuration)

			if var_570_4 <= arg_567_1.time_ and arg_567_1.time_ < var_570_4 + var_570_11 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_4) / var_570_11

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_4 + var_570_11 and arg_567_1.time_ < var_570_4 + var_570_11 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play424101139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 424101139
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play424101140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.1
			local var_574_1 = 1

			if var_574_0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_0 + arg_574_0 then
				local var_574_2 = "play"
				local var_574_3 = "effect"

				arg_571_1:AudioAction(var_574_2, var_574_3, "se_story_140", "se_story_140_data02", "")
			end

			local var_574_4 = 0
			local var_574_5 = 1.325

			if var_574_4 < arg_571_1.time_ and arg_571_1.time_ <= var_574_4 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, false)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_6 = arg_571_1:GetWordFromCfg(424101139)
				local var_574_7 = arg_571_1:FormatText(var_574_6.content)

				arg_571_1.text_.text = var_574_7

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_8 = 53
				local var_574_9 = utf8.len(var_574_7)
				local var_574_10 = var_574_8 <= 0 and var_574_5 or var_574_5 * (var_574_9 / var_574_8)

				if var_574_10 > 0 and var_574_5 < var_574_10 then
					arg_571_1.talkMaxDuration = var_574_10

					if var_574_10 + var_574_4 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_10 + var_574_4
					end
				end

				arg_571_1.text_.text = var_574_7
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_11 = math.max(var_574_5, arg_571_1.talkMaxDuration)

			if var_574_4 <= arg_571_1.time_ and arg_571_1.time_ < var_574_4 + var_574_11 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_4) / var_574_11

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_4 + var_574_11 and arg_571_1.time_ < var_574_4 + var_574_11 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play424101140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 424101140
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play424101141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0
			local var_578_1 = 0.3

			if var_578_0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_2 = arg_575_1:FormatText(StoryNameCfg[7].name)

				arg_575_1.leftNameTxt_.text = var_578_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_3 = arg_575_1:GetWordFromCfg(424101140)
				local var_578_4 = arg_575_1:FormatText(var_578_3.content)

				arg_575_1.text_.text = var_578_4

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_5 = 12
				local var_578_6 = utf8.len(var_578_4)
				local var_578_7 = var_578_5 <= 0 and var_578_1 or var_578_1 * (var_578_6 / var_578_5)

				if var_578_7 > 0 and var_578_1 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_0
					end
				end

				arg_575_1.text_.text = var_578_4
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_8 = math.max(var_578_1, arg_575_1.talkMaxDuration)

			if var_578_0 <= arg_575_1.time_ and arg_575_1.time_ < var_578_0 + var_578_8 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_0) / var_578_8

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_0 + var_578_8 and arg_575_1.time_ < var_578_0 + var_578_8 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play424101141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 424101141
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
			arg_579_1.auto_ = false
		end

		function arg_579_1.playNext_(arg_581_0)
			arg_579_1.onStoryFinished_()
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 1

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				local var_582_2 = "play"
				local var_582_3 = "effect"

				arg_579_1:AudioAction(var_582_2, var_582_3, "se_story_140", "se_story_140_ui", "")
			end

			local var_582_4 = 0
			local var_582_5 = 1.15

			if var_582_4 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_6 = arg_579_1:GetWordFromCfg(424101141)
				local var_582_7 = arg_579_1:FormatText(var_582_6.content)

				arg_579_1.text_.text = var_582_7

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_8 = 46
				local var_582_9 = utf8.len(var_582_7)
				local var_582_10 = var_582_8 <= 0 and var_582_5 or var_582_5 * (var_582_9 / var_582_8)

				if var_582_10 > 0 and var_582_5 < var_582_10 then
					arg_579_1.talkMaxDuration = var_582_10

					if var_582_10 + var_582_4 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_10 + var_582_4
					end
				end

				arg_579_1.text_.text = var_582_7
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_11 = math.max(var_582_5, arg_579_1.talkMaxDuration)

			if var_582_4 <= arg_579_1.time_ and arg_579_1.time_ < var_582_4 + var_582_11 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_4) / var_582_11

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_4 + var_582_11 and arg_579_1.time_ < var_582_4 + var_582_11 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/I18d",
		"TextureConfig/Background/I18h",
		"TextureConfig/Background/I11s",
		"TextureConfig/Background/ST0115a"
	},
	voices = {
		"story_v_out_424101.awb"
	}
}
