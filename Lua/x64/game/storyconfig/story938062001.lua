return {
	Play938062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0119"

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
				local var_4_5 = arg_1_1.bgs_.ST0119

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
					if iter_4_0 ~= "ST0119" then
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

			local var_4_24 = "10183"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_["10183"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10183 == nil then
				arg_1_1.var_.actorSpriteComps10183 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10183 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10183 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10183 = nil
			end

			local var_4_36 = arg_1_1.actors_["10183"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10183 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10183", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_9" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -475, -325)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10183, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -475, -325)
			end

			local var_4_43 = 0.3
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_4_47 = 1
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_5_2_story_daily", "bgm_activity_5_2_story_daily")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = arg_1_1.actors_["10183"]
			local var_4_54 = 2

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_55 = var_4_53:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_55 then
					arg_1_1.var_.alphaOldValue10183 = var_4_55.alpha
					arg_1_1.var_.characterEffect10183 = var_4_55
				end

				arg_1_1.var_.alphaOldValue10183 = 0
			end

			local var_4_56 = 0.5

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_56 then
				local var_4_57 = (arg_1_1.time_ - var_4_54) / var_4_56
				local var_4_58 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10183, 1, var_4_57)

				if arg_1_1.var_.characterEffect10183 then
					arg_1_1.var_.characterEffect10183.alpha = var_4_58
				end
			end

			if arg_1_1.time_ >= var_4_54 + var_4_56 and arg_1_1.time_ < var_4_54 + var_4_56 + arg_4_0 and arg_1_1.var_.characterEffect10183 then
				arg_1_1.var_.characterEffect10183.alpha = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.125

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1562].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(938062001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 52
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_59 + 0.3
			local var_4_69 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play938062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938062002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10183"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10183 == nil then
				arg_8_1.var_.actorSpriteComps10183 = var_11_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.actorSpriteComps10183 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_11_1 then
							if arg_8_1.isInRecall_ then
								local var_11_4 = Mathf.Lerp(iter_11_1.color.r, arg_8_1.hightColor2.r, var_11_3)
								local var_11_5 = Mathf.Lerp(iter_11_1.color.g, arg_8_1.hightColor2.g, var_11_3)
								local var_11_6 = Mathf.Lerp(iter_11_1.color.b, arg_8_1.hightColor2.b, var_11_3)

								iter_11_1.color = Color.New(var_11_4, var_11_5, var_11_6)
							else
								local var_11_7 = Mathf.Lerp(iter_11_1.color.r, 0.5, var_11_3)

								iter_11_1.color = Color.New(var_11_7, var_11_7, var_11_7)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps10183 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_11_3 then
						if arg_8_1.isInRecall_ then
							iter_11_3.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps10183 = nil
			end

			local var_11_8 = 0
			local var_11_9 = 0.525

			if var_11_8 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_10 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_11 = arg_8_1:GetWordFromCfg(938062002)
				local var_11_12 = arg_8_1:FormatText(var_11_11.content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 21
				local var_11_14 = utf8.len(var_11_12)
				local var_11_15 = var_11_13 <= 0 and var_11_9 or var_11_9 * (var_11_14 / var_11_13)

				if var_11_15 > 0 and var_11_9 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play938062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938062003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938062004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "10144"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_15_4 = arg_12_1.actors_["10144"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.actorSpriteComps10144 == nil then
				arg_12_1.var_.actorSpriteComps10144 = var_15_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_6 = 0.2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.actorSpriteComps10144 then
					for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_15_3 then
							if arg_12_1.isInRecall_ then
								local var_15_8 = Mathf.Lerp(iter_15_3.color.r, arg_12_1.hightColor1.r, var_15_7)
								local var_15_9 = Mathf.Lerp(iter_15_3.color.g, arg_12_1.hightColor1.g, var_15_7)
								local var_15_10 = Mathf.Lerp(iter_15_3.color.b, arg_12_1.hightColor1.b, var_15_7)

								iter_15_3.color = Color.New(var_15_8, var_15_9, var_15_10)
							else
								local var_15_11 = Mathf.Lerp(iter_15_3.color.r, 1, var_15_7)

								iter_15_3.color = Color.New(var_15_11, var_15_11, var_15_11)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.actorSpriteComps10144 then
				for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_15_5 then
						if arg_12_1.isInRecall_ then
							iter_15_5.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps10144 = nil
			end

			local var_15_12 = arg_12_1.actors_["10144"].transform
			local var_15_13 = 0

			if var_15_13 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1.var_.moveOldPos10144 = var_15_12.localPosition
				var_15_12.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10144", 4)

				local var_15_14 = var_15_12.childCount

				for iter_15_6 = 0, var_15_14 - 1 do
					local var_15_15 = var_15_12:GetChild(iter_15_6)

					if var_15_15.name == "split_11" or not string.find(var_15_15.name, "split") then
						var_15_15.gameObject:SetActive(true)
					else
						var_15_15.gameObject:SetActive(false)
					end
				end
			end

			local var_15_16 = 0.001

			if var_15_13 <= arg_12_1.time_ and arg_12_1.time_ < var_15_13 + var_15_16 then
				local var_15_17 = (arg_12_1.time_ - var_15_13) / var_15_16
				local var_15_18 = Vector3.New(435.8, -381.1, -285.9)

				var_15_12.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10144, var_15_18, var_15_17)
			end

			if arg_12_1.time_ >= var_15_13 + var_15_16 and arg_12_1.time_ < var_15_13 + var_15_16 + arg_15_0 then
				var_15_12.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_15_19 = arg_12_1.actors_["10183"].transform
			local var_15_20 = 0

			if var_15_20 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.var_.moveOldPos10183 = var_15_19.localPosition
				var_15_19.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("10183", 2)

				local var_15_21 = var_15_19.childCount

				for iter_15_7 = 0, var_15_21 - 1 do
					local var_15_22 = var_15_19:GetChild(iter_15_7)

					if var_15_22.name == "split_9" or not string.find(var_15_22.name, "split") then
						var_15_22.gameObject:SetActive(true)
					else
						var_15_22.gameObject:SetActive(false)
					end
				end
			end

			local var_15_23 = 0.001

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_23 then
				local var_15_24 = (arg_12_1.time_ - var_15_20) / var_15_23
				local var_15_25 = Vector3.New(-300, -475, -325)

				var_15_19.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10183, var_15_25, var_15_24)
			end

			if arg_12_1.time_ >= var_15_20 + var_15_23 and arg_12_1.time_ < var_15_20 + var_15_23 + arg_15_0 then
				var_15_19.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_15_26 = 0
			local var_15_27 = 0.125

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_28 = arg_12_1:FormatText(StoryNameCfg[1297].name)

				arg_12_1.leftNameTxt_.text = var_15_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_29 = arg_12_1:GetWordFromCfg(938062003)
				local var_15_30 = arg_12_1:FormatText(var_15_29.content)

				arg_12_1.text_.text = var_15_30

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_31 = 41
				local var_15_32 = utf8.len(var_15_30)
				local var_15_33 = var_15_31 <= 0 and var_15_27 or var_15_27 * (var_15_32 / var_15_31)

				if var_15_33 > 0 and var_15_27 < var_15_33 then
					arg_12_1.talkMaxDuration = var_15_33

					if var_15_33 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_33 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_30
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_34 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_34 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_34

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_34 and arg_12_1.time_ < var_15_26 + var_15_34 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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
				actorName = "10183",
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
	Play938062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938062004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10144"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 == nil then
				arg_16_1.var_.actorSpriteComps10144 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps10144 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_8 = 0
			local var_19_9 = 0.5

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

				local var_19_11 = arg_16_1:GetWordFromCfg(938062004)
				local var_19_12 = arg_16_1:FormatText(var_19_11.content)

				arg_16_1.text_.text = var_19_12

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 20
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
	Play938062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938062005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10144"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10144 == nil then
				arg_20_1.var_.actorSpriteComps10144 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps10144 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								local var_23_4 = Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, var_23_3)
								local var_23_5 = Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, var_23_3)
								local var_23_6 = Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, var_23_3)

								iter_23_1.color = Color.New(var_23_4, var_23_5, var_23_6)
							else
								local var_23_7 = Mathf.Lerp(iter_23_1.color.r, 1, var_23_3)

								iter_23_1.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps10144 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps10144 = nil
			end

			local var_23_8 = arg_20_1.actors_["10144"].transform
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.var_.moveOldPos10144 = var_23_8.localPosition
				var_23_8.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("10144", 4)

				local var_23_10 = var_23_8.childCount

				for iter_23_4 = 0, var_23_10 - 1 do
					local var_23_11 = var_23_8:GetChild(iter_23_4)

					if var_23_11.name == "split_12" then
						var_23_11:SetAsLastSibling()
						var_23_11.gameObject:SetActive(true)

						arg_20_1.var_.actorSpriteSplit10144 = var_23_11.gameObject:GetComponent(typeof(Image))

						arg_20_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_23_12 = 0.5

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_9) / var_23_12
				local var_23_14 = Vector3.New(435.8, -381.1, -285.9)

				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10144, var_23_14, var_23_13)

				if arg_20_1.var_.actorSpriteSplit10144 ~= nil then
					arg_20_1.var_.actorSpriteSplit10144:SetAlpha(var_23_13)
				end
			end

			if arg_20_1.time_ >= var_23_9 + var_23_12 and arg_20_1.time_ < var_23_9 + var_23_12 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(435.8, -381.1, -285.9)

				if arg_20_1.var_.actorSpriteSplit10144 ~= nil then
					arg_20_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_23_15 = 0
			local var_23_16 = 1.175

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[1297].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(938062005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 47
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_23 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_23 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_23

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_23 and arg_20_1.time_ < var_23_15 + var_23_23 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play938062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938062006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10144"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10144 == nil then
				arg_24_1.var_.actorSpriteComps10144 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps10144 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps10144 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10144 = nil
			end

			local var_27_8 = 0
			local var_27_9 = 0.225

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

				local var_27_11 = arg_24_1:GetWordFromCfg(938062006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 9
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
	Play938062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938062007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10144"].transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.moveOldPos10144 = var_31_0.localPosition
				var_31_0.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10144", 7)

				local var_31_2 = var_31_0.childCount

				for iter_31_0 = 0, var_31_2 - 1 do
					local var_31_3 = var_31_0:GetChild(iter_31_0)

					if var_31_3.name == "" or not string.find(var_31_3.name, "split") then
						var_31_3.gameObject:SetActive(true)
					else
						var_31_3.gameObject:SetActive(false)
					end
				end
			end

			local var_31_4 = 0.001

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_4 then
				local var_31_5 = (arg_28_1.time_ - var_31_1) / var_31_4
				local var_31_6 = Vector3.New(0, -2000, 0)

				var_31_0.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10144, var_31_6, var_31_5)
			end

			if arg_28_1.time_ >= var_31_1 + var_31_4 and arg_28_1.time_ < var_31_1 + var_31_4 + arg_31_0 then
				var_31_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_7 = arg_28_1.actors_["10183"].transform
			local var_31_8 = 0

			if var_31_8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.var_.moveOldPos10183 = var_31_7.localPosition
				var_31_7.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("10183", 7)

				local var_31_9 = var_31_7.childCount

				for iter_31_1 = 0, var_31_9 - 1 do
					local var_31_10 = var_31_7:GetChild(iter_31_1)

					if var_31_10.name == "" or not string.find(var_31_10.name, "split") then
						var_31_10.gameObject:SetActive(true)
					else
						var_31_10.gameObject:SetActive(false)
					end
				end
			end

			local var_31_11 = 0.001

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_8) / var_31_11
				local var_31_13 = Vector3.New(0, -2000, 0)

				var_31_7.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10183, var_31_13, var_31_12)
			end

			if arg_28_1.time_ >= var_31_8 + var_31_11 and arg_28_1.time_ < var_31_8 + var_31_11 + arg_31_0 then
				var_31_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_31_14 = 0
			local var_31_15 = 0.75

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_16 = arg_28_1:GetWordFromCfg(938062007)
				local var_31_17 = arg_28_1:FormatText(var_31_16.content)

				arg_28_1.text_.text = var_31_17

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_18 = 30
				local var_31_19 = utf8.len(var_31_17)
				local var_31_20 = var_31_18 <= 0 and var_31_15 or var_31_15 * (var_31_19 / var_31_18)

				if var_31_20 > 0 and var_31_15 < var_31_20 then
					arg_28_1.talkMaxDuration = var_31_20

					if var_31_20 + var_31_14 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_14
					end
				end

				arg_28_1.text_.text = var_31_17
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_21 = math.max(var_31_15, arg_28_1.talkMaxDuration)

			if var_31_14 <= arg_28_1.time_ and arg_28_1.time_ < var_31_14 + var_31_21 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_14) / var_31_21

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_14 + var_31_21 and arg_28_1.time_ < var_31_14 + var_31_21 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play938062008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938062008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938062009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10183"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10183 == nil then
				arg_32_1.var_.actorSpriteComps10183 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps10183 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 1, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps10183 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps10183 = nil
			end

			local var_35_8 = arg_32_1.actors_["10183"].transform
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.var_.moveOldPos10183 = var_35_8.localPosition
				var_35_8.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10183", 2)

				local var_35_10 = var_35_8.childCount

				for iter_35_4 = 0, var_35_10 - 1 do
					local var_35_11 = var_35_8:GetChild(iter_35_4)

					if var_35_11.name == "split_9" or not string.find(var_35_11.name, "split") then
						var_35_11.gameObject:SetActive(true)
					else
						var_35_11.gameObject:SetActive(false)
					end
				end
			end

			local var_35_12 = 0.001

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_12 then
				local var_35_13 = (arg_32_1.time_ - var_35_9) / var_35_12
				local var_35_14 = Vector3.New(-300, -475, -325)

				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10183, var_35_14, var_35_13)
			end

			if arg_32_1.time_ >= var_35_9 + var_35_12 and arg_32_1.time_ < var_35_9 + var_35_12 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_35_15 = 0
			local var_35_16 = 1.175

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[1562].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(938062008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 47
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_23 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_23 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_23

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_23 and arg_32_1.time_ < var_35_15 + var_35_23 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play938062009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938062009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938062010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10144"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps10144 == nil then
				arg_36_1.var_.actorSpriteComps10144 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps10144 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								local var_39_4 = Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor1.r, var_39_3)
								local var_39_5 = Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor1.g, var_39_3)
								local var_39_6 = Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor1.b, var_39_3)

								iter_39_1.color = Color.New(var_39_4, var_39_5, var_39_6)
							else
								local var_39_7 = Mathf.Lerp(iter_39_1.color.r, 1, var_39_3)

								iter_39_1.color = Color.New(var_39_7, var_39_7, var_39_7)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps10144 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10144 = nil
			end

			local var_39_8 = arg_36_1.actors_["10183"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10183 == nil then
				arg_36_1.var_.actorSpriteComps10183 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps10183 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_12 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor2.r, var_39_11)
								local var_39_13 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor2.g, var_39_11)
								local var_39_14 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor2.b, var_39_11)

								iter_39_5.color = Color.New(var_39_12, var_39_13, var_39_14)
							else
								local var_39_15 = Mathf.Lerp(iter_39_5.color.r, 0.5, var_39_11)

								iter_39_5.color = Color.New(var_39_15, var_39_15, var_39_15)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps10183 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps10183 = nil
			end

			local var_39_16 = arg_36_1.actors_["10144"].transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.var_.moveOldPos10144 = var_39_16.localPosition
				var_39_16.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10144", 4)

				local var_39_18 = var_39_16.childCount

				for iter_39_8 = 0, var_39_18 - 1 do
					local var_39_19 = var_39_16:GetChild(iter_39_8)

					if var_39_19.name == "split_11" or not string.find(var_39_19.name, "split") then
						var_39_19.gameObject:SetActive(true)
					else
						var_39_19.gameObject:SetActive(false)
					end
				end
			end

			local var_39_20 = 0.001

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_20 then
				local var_39_21 = (arg_36_1.time_ - var_39_17) / var_39_20
				local var_39_22 = Vector3.New(435.8, -381.1, -285.9)

				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10144, var_39_22, var_39_21)
			end

			if arg_36_1.time_ >= var_39_17 + var_39_20 and arg_36_1.time_ < var_39_17 + var_39_20 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_39_23 = 0
			local var_39_24 = 0.6

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_25 = arg_36_1:FormatText(StoryNameCfg[1297].name)

				arg_36_1.leftNameTxt_.text = var_39_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(938062009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_28 = 24
				local var_39_29 = utf8.len(var_39_27)
				local var_39_30 = var_39_28 <= 0 and var_39_24 or var_39_24 * (var_39_29 / var_39_28)

				if var_39_30 > 0 and var_39_24 < var_39_30 then
					arg_36_1.talkMaxDuration = var_39_30

					if var_39_30 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_23
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_31 = math.max(var_39_24, arg_36_1.talkMaxDuration)

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_31 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_23) / var_39_31

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_23 + var_39_31 and arg_36_1.time_ < var_39_23 + var_39_31 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play938062010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 938062010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play938062011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10183"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10183 == nil then
				arg_40_1.var_.actorSpriteComps10183 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps10183 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_43_1 then
							if arg_40_1.isInRecall_ then
								local var_43_4 = Mathf.Lerp(iter_43_1.color.r, arg_40_1.hightColor1.r, var_43_3)
								local var_43_5 = Mathf.Lerp(iter_43_1.color.g, arg_40_1.hightColor1.g, var_43_3)
								local var_43_6 = Mathf.Lerp(iter_43_1.color.b, arg_40_1.hightColor1.b, var_43_3)

								iter_43_1.color = Color.New(var_43_4, var_43_5, var_43_6)
							else
								local var_43_7 = Mathf.Lerp(iter_43_1.color.r, 1, var_43_3)

								iter_43_1.color = Color.New(var_43_7, var_43_7, var_43_7)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps10183 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10183 = nil
			end

			local var_43_8 = arg_40_1.actors_["10144"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps10144 == nil then
				arg_40_1.var_.actorSpriteComps10144 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps10144 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_43_5 then
							if arg_40_1.isInRecall_ then
								local var_43_12 = Mathf.Lerp(iter_43_5.color.r, arg_40_1.hightColor2.r, var_43_11)
								local var_43_13 = Mathf.Lerp(iter_43_5.color.g, arg_40_1.hightColor2.g, var_43_11)
								local var_43_14 = Mathf.Lerp(iter_43_5.color.b, arg_40_1.hightColor2.b, var_43_11)

								iter_43_5.color = Color.New(var_43_12, var_43_13, var_43_14)
							else
								local var_43_15 = Mathf.Lerp(iter_43_5.color.r, 0.5, var_43_11)

								iter_43_5.color = Color.New(var_43_15, var_43_15, var_43_15)
							end
						end
					end
				end
			end

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps10144 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps10144 = nil
			end

			local var_43_16 = arg_40_1.actors_["10183"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos10183 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("10183", 2)

				local var_43_18 = var_43_16.childCount

				for iter_43_8 = 0, var_43_18 - 1 do
					local var_43_19 = var_43_16:GetChild(iter_43_8)

					if var_43_19.name == "split_9" or not string.find(var_43_19.name, "split") then
						var_43_19.gameObject:SetActive(true)
					else
						var_43_19.gameObject:SetActive(false)
					end
				end
			end

			local var_43_20 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_20 then
				local var_43_21 = (arg_40_1.time_ - var_43_17) / var_43_20
				local var_43_22 = Vector3.New(-300, -475, -325)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10183, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(-300, -475, -325)
			end

			local var_43_23 = 0
			local var_43_24 = 1.35

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_25 = arg_40_1:FormatText(StoryNameCfg[1562].name)

				arg_40_1.leftNameTxt_.text = var_43_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:GetWordFromCfg(938062010)
				local var_43_27 = arg_40_1:FormatText(var_43_26.content)

				arg_40_1.text_.text = var_43_27

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 54
				local var_43_29 = utf8.len(var_43_27)
				local var_43_30 = var_43_28 <= 0 and var_43_24 or var_43_24 * (var_43_29 / var_43_28)

				if var_43_30 > 0 and var_43_24 < var_43_30 then
					arg_40_1.talkMaxDuration = var_43_30

					if var_43_30 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_30 + var_43_23
					end
				end

				arg_40_1.text_.text = var_43_27
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_31 = math.max(var_43_24, arg_40_1.talkMaxDuration)

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_31 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_23) / var_43_31

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_23 + var_43_31 and arg_40_1.time_ < var_43_23 + var_43_31 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play938062011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 938062011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play938062012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10183"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10183 == nil then
				arg_44_1.var_.actorSpriteComps10183 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps10183 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor2.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor2.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor2.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 0.5, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps10183 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps10183 = nil
			end

			local var_47_8 = 0
			local var_47_9 = 0.75

			if var_47_8 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(938062011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_12 = 30
				local var_47_13 = utf8.len(var_47_11)
				local var_47_14 = var_47_12 <= 0 and var_47_9 or var_47_9 * (var_47_13 / var_47_12)

				if var_47_14 > 0 and var_47_9 < var_47_14 then
					arg_44_1.talkMaxDuration = var_47_14

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_15 and arg_44_1.time_ < var_47_8 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play938062012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 938062012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play938062013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10144"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 == nil then
				arg_48_1.var_.actorSpriteComps10144 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps10144 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								local var_51_4 = Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor1.r, var_51_3)
								local var_51_5 = Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor1.g, var_51_3)
								local var_51_6 = Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor1.b, var_51_3)

								iter_51_1.color = Color.New(var_51_4, var_51_5, var_51_6)
							else
								local var_51_7 = Mathf.Lerp(iter_51_1.color.r, 1, var_51_3)

								iter_51_1.color = Color.New(var_51_7, var_51_7, var_51_7)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps10144 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps10144 = nil
			end

			local var_51_8 = arg_48_1.actors_["10144"].transform
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.var_.moveOldPos10144 = var_51_8.localPosition
				var_51_8.localScale = Vector3.New(1, 1, 1)

				arg_48_1:CheckSpriteTmpPos("10144", 4)

				local var_51_10 = var_51_8.childCount

				for iter_51_4 = 0, var_51_10 - 1 do
					local var_51_11 = var_51_8:GetChild(iter_51_4)

					if var_51_11.name == "split_11" or not string.find(var_51_11.name, "split") then
						var_51_11.gameObject:SetActive(true)
					else
						var_51_11.gameObject:SetActive(false)
					end
				end
			end

			local var_51_12 = 0.001

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_9) / var_51_12
				local var_51_14 = Vector3.New(435.8, -381.1, -285.9)

				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10144, var_51_14, var_51_13)
			end

			if arg_48_1.time_ >= var_51_9 + var_51_12 and arg_48_1.time_ < var_51_9 + var_51_12 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_51_15 = 0
			local var_51_16 = 1.025

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[1297].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(938062012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 41
				local var_51_21 = utf8.len(var_51_19)
				local var_51_22 = var_51_20 <= 0 and var_51_16 or var_51_16 * (var_51_21 / var_51_20)

				if var_51_22 > 0 and var_51_16 < var_51_22 then
					arg_48_1.talkMaxDuration = var_51_22

					if var_51_22 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_22 + var_51_15
					end
				end

				arg_48_1.text_.text = var_51_19
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_23 = math.max(var_51_16, arg_48_1.talkMaxDuration)

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_23 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_15) / var_51_23

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_15 + var_51_23 and arg_48_1.time_ < var_51_15 + var_51_23 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play938062013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 938062013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play938062014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10183"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10183 == nil then
				arg_52_1.var_.actorSpriteComps10183 = var_55_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.actorSpriteComps10183 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								local var_55_4 = Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, var_55_3)
								local var_55_5 = Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, var_55_3)
								local var_55_6 = Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, var_55_3)

								iter_55_1.color = Color.New(var_55_4, var_55_5, var_55_6)
							else
								local var_55_7 = Mathf.Lerp(iter_55_1.color.r, 1, var_55_3)

								iter_55_1.color = Color.New(var_55_7, var_55_7, var_55_7)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.actorSpriteComps10183 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_55_3 then
						if arg_52_1.isInRecall_ then
							iter_55_3.color = arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_55_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10183 = nil
			end

			local var_55_8 = arg_52_1.actors_["10144"]
			local var_55_9 = 0

			if var_55_9 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10144 == nil then
				arg_52_1.var_.actorSpriteComps10144 = var_55_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_10 = 0.2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 and not isNil(var_55_8) then
				local var_55_11 = (arg_52_1.time_ - var_55_9) / var_55_10

				if arg_52_1.var_.actorSpriteComps10144 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_55_5 then
							if arg_52_1.isInRecall_ then
								local var_55_12 = Mathf.Lerp(iter_55_5.color.r, arg_52_1.hightColor2.r, var_55_11)
								local var_55_13 = Mathf.Lerp(iter_55_5.color.g, arg_52_1.hightColor2.g, var_55_11)
								local var_55_14 = Mathf.Lerp(iter_55_5.color.b, arg_52_1.hightColor2.b, var_55_11)

								iter_55_5.color = Color.New(var_55_12, var_55_13, var_55_14)
							else
								local var_55_15 = Mathf.Lerp(iter_55_5.color.r, 0.5, var_55_11)

								iter_55_5.color = Color.New(var_55_15, var_55_15, var_55_15)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 and not isNil(var_55_8) and arg_52_1.var_.actorSpriteComps10144 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_55_7 then
						if arg_52_1.isInRecall_ then
							iter_55_7.color = arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_55_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_52_1.var_.actorSpriteComps10144 = nil
			end

			local var_55_16 = arg_52_1.actors_["10183"].transform
			local var_55_17 = 0

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.var_.moveOldPos10183 = var_55_16.localPosition
				var_55_16.localScale = Vector3.New(1, 1, 1)

				arg_52_1:CheckSpriteTmpPos("10183", 2)

				local var_55_18 = var_55_16.childCount

				for iter_55_8 = 0, var_55_18 - 1 do
					local var_55_19 = var_55_16:GetChild(iter_55_8)

					if var_55_19.name == "split_10" then
						var_55_19:SetAsLastSibling()
						var_55_19.gameObject:SetActive(true)

						arg_52_1.var_.actorSpriteSplit10183 = var_55_19.gameObject:GetComponent(typeof(Image))

						arg_52_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_55_20 = 0.5

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_20 then
				local var_55_21 = (arg_52_1.time_ - var_55_17) / var_55_20
				local var_55_22 = Vector3.New(-300, -475, -325)

				var_55_16.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10183, var_55_22, var_55_21)

				if arg_52_1.var_.actorSpriteSplit10183 ~= nil then
					arg_52_1.var_.actorSpriteSplit10183:SetAlpha(var_55_21)
				end
			end

			if arg_52_1.time_ >= var_55_17 + var_55_20 and arg_52_1.time_ < var_55_17 + var_55_20 + arg_55_0 then
				var_55_16.localPosition = Vector3.New(-300, -475, -325)

				if arg_52_1.var_.actorSpriteSplit10183 ~= nil then
					arg_52_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_55_23 = 0
			local var_55_24 = 1.2

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_25 = arg_52_1:FormatText(StoryNameCfg[1562].name)

				arg_52_1.leftNameTxt_.text = var_55_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_26 = arg_52_1:GetWordFromCfg(938062013)
				local var_55_27 = arg_52_1:FormatText(var_55_26.content)

				arg_52_1.text_.text = var_55_27

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_28 = 48
				local var_55_29 = utf8.len(var_55_27)
				local var_55_30 = var_55_28 <= 0 and var_55_24 or var_55_24 * (var_55_29 / var_55_28)

				if var_55_30 > 0 and var_55_24 < var_55_30 then
					arg_52_1.talkMaxDuration = var_55_30

					if var_55_30 + var_55_23 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_30 + var_55_23
					end
				end

				arg_52_1.text_.text = var_55_27
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_31 = math.max(var_55_24, arg_52_1.talkMaxDuration)

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_31 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_23) / var_55_31

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_23 + var_55_31 and arg_52_1.time_ < var_55_23 + var_55_31 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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

		arg_52_1:InitPlayNodeList()
	end,
	Play938062014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 938062014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play938062015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10183"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10183 == nil then
				arg_56_1.var_.actorSpriteComps10183 = var_59_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.actorSpriteComps10183 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								local var_59_4 = Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, var_59_3)
								local var_59_5 = Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, var_59_3)
								local var_59_6 = Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, var_59_3)

								iter_59_1.color = Color.New(var_59_4, var_59_5, var_59_6)
							else
								local var_59_7 = Mathf.Lerp(iter_59_1.color.r, 0.5, var_59_3)

								iter_59_1.color = Color.New(var_59_7, var_59_7, var_59_7)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.actorSpriteComps10183 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_59_3 then
						if arg_56_1.isInRecall_ then
							iter_59_3.color = arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_59_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_56_1.var_.actorSpriteComps10183 = nil
			end

			local var_59_8 = 0
			local var_59_9 = 0.825

			if var_59_8 < arg_56_1.time_ and arg_56_1.time_ <= var_59_8 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_10 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_11 = arg_56_1:GetWordFromCfg(938062014)
				local var_59_12 = arg_56_1:FormatText(var_59_11.content)

				arg_56_1.text_.text = var_59_12

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 33
				local var_59_14 = utf8.len(var_59_12)
				local var_59_15 = var_59_13 <= 0 and var_59_9 or var_59_9 * (var_59_14 / var_59_13)

				if var_59_15 > 0 and var_59_9 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_8 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_8
					end
				end

				arg_56_1.text_.text = var_59_12
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_9, arg_56_1.talkMaxDuration)

			if var_59_8 <= arg_56_1.time_ and arg_56_1.time_ < var_59_8 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_8) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_8 + var_59_16 and arg_56_1.time_ < var_59_8 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play938062015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 938062015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play938062016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.4

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(938062015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 16
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play938062016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 938062016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play938062017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.775

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(938062016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 31
				local var_67_5 = utf8.len(var_67_3)
				local var_67_6 = var_67_4 <= 0 and var_67_1 or var_67_1 * (var_67_5 / var_67_4)

				if var_67_6 > 0 and var_67_1 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_7 and arg_64_1.time_ < var_67_0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play938062017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 938062017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play938062018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10144"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10144 == nil then
				arg_68_1.var_.actorSpriteComps10144 = var_71_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.actorSpriteComps10144 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								local var_71_4 = Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, var_71_3)
								local var_71_5 = Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, var_71_3)
								local var_71_6 = Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, var_71_3)

								iter_71_1.color = Color.New(var_71_4, var_71_5, var_71_6)
							else
								local var_71_7 = Mathf.Lerp(iter_71_1.color.r, 1, var_71_3)

								iter_71_1.color = Color.New(var_71_7, var_71_7, var_71_7)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.actorSpriteComps10144 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_71_3 then
						if arg_68_1.isInRecall_ then
							iter_71_3.color = arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_71_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_68_1.var_.actorSpriteComps10144 = nil
			end

			local var_71_8 = arg_68_1.actors_["10144"].transform
			local var_71_9 = 0

			if var_71_9 < arg_68_1.time_ and arg_68_1.time_ <= var_71_9 + arg_71_0 then
				arg_68_1.var_.moveOldPos10144 = var_71_8.localPosition
				var_71_8.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10144", 4)

				local var_71_10 = var_71_8.childCount

				for iter_71_4 = 0, var_71_10 - 1 do
					local var_71_11 = var_71_8:GetChild(iter_71_4)

					if var_71_11.name == "split_13" or not string.find(var_71_11.name, "split") then
						var_71_11.gameObject:SetActive(true)
					else
						var_71_11.gameObject:SetActive(false)
					end
				end
			end

			local var_71_12 = 0.001

			if var_71_9 <= arg_68_1.time_ and arg_68_1.time_ < var_71_9 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_9) / var_71_12
				local var_71_14 = Vector3.New(435.8, -381.1, -285.9)

				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10144, var_71_14, var_71_13)
			end

			if arg_68_1.time_ >= var_71_9 + var_71_12 and arg_68_1.time_ < var_71_9 + var_71_12 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_71_15 = 0
			local var_71_16 = 1.3

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[1297].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(938062017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 52
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_23 and arg_68_1.time_ < var_71_15 + var_71_23 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play938062018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 938062018
		arg_72_1.duration_ = 6

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play938062019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10144"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10144 == nil then
				arg_72_1.var_.actorSpriteComps10144 = var_75_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.actorSpriteComps10144 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								local var_75_4 = Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor2.r, var_75_3)
								local var_75_5 = Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor2.g, var_75_3)
								local var_75_6 = Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor2.b, var_75_3)

								iter_75_1.color = Color.New(var_75_4, var_75_5, var_75_6)
							else
								local var_75_7 = Mathf.Lerp(iter_75_1.color.r, 0.5, var_75_3)

								iter_75_1.color = Color.New(var_75_7, var_75_7, var_75_7)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.actorSpriteComps10144 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_75_3 then
						if arg_72_1.isInRecall_ then
							iter_75_3.color = arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_75_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_72_1.var_.actorSpriteComps10144 = nil
			end

			local var_75_8 = arg_72_1.actors_["10144"].transform
			local var_75_9 = 0

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.var_.moveOldPos10144 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10144", 7)

				local var_75_10 = var_75_8.childCount

				for iter_75_4 = 0, var_75_10 - 1 do
					local var_75_11 = var_75_8:GetChild(iter_75_4)

					if var_75_11.name == "" or not string.find(var_75_11.name, "split") then
						var_75_11.gameObject:SetActive(true)
					else
						var_75_11.gameObject:SetActive(false)
					end
				end
			end

			local var_75_12 = 0.001

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_9) / var_75_12
				local var_75_14 = Vector3.New(0, -2000, 0)

				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10144, var_75_14, var_75_13)
			end

			if arg_72_1.time_ >= var_75_9 + var_75_12 and arg_72_1.time_ < var_75_9 + var_75_12 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_75_15 = arg_72_1.actors_["10183"].transform
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.var_.moveOldPos10183 = var_75_15.localPosition
				var_75_15.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10183", 7)

				local var_75_17 = var_75_15.childCount

				for iter_75_5 = 0, var_75_17 - 1 do
					local var_75_18 = var_75_15:GetChild(iter_75_5)

					if var_75_18.name == "" or not string.find(var_75_18.name, "split") then
						var_75_18.gameObject:SetActive(true)
					else
						var_75_18.gameObject:SetActive(false)
					end
				end
			end

			local var_75_19 = 0.001

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_19 then
				local var_75_20 = (arg_72_1.time_ - var_75_16) / var_75_19
				local var_75_21 = Vector3.New(0, -2000, 0)

				var_75_15.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10183, var_75_21, var_75_20)
			end

			if arg_72_1.time_ >= var_75_16 + var_75_19 and arg_72_1.time_ < var_75_16 + var_75_19 + arg_75_0 then
				var_75_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_75_22 = manager.ui.mainCamera.transform
			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_22.localPosition
			end

			local var_75_24 = 0.6

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_24 then
				local var_75_25 = (arg_72_1.time_ - var_75_23) / 0.066
				local var_75_26, var_75_27 = math.modf(var_75_25)

				var_75_22.localPosition = Vector3.New(var_75_27 * 0.06, var_75_27 * 0.06, var_75_27 * 0.06) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= var_75_23 + var_75_24 and arg_72_1.time_ < var_75_23 + var_75_24 + arg_75_0 then
				var_75_22.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_28 = manager.ui.mainCamera.transform
			local var_75_29 = 0

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				local var_75_30 = arg_72_1.var_.effectzhanchifeixiang1
				local var_75_31
				local var_75_32 = var_75_28

				if not var_75_30 then
					var_75_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_75_32)
					var_75_30.name = "zhanchifeixiang1"
					arg_72_1.var_.effectzhanchifeixiang1 = var_75_30
				else
					var_75_30.transform:SetParent(var_75_32)
				end

				var_75_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_75_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_75_33 = 0

			if var_75_33 < arg_72_1.time_ and arg_72_1.time_ <= var_75_33 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_34 = 2

			if arg_72_1.time_ >= var_75_33 + var_75_34 and arg_72_1.time_ < var_75_33 + var_75_34 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_35 = 1
			local var_75_36 = 0.575

			if var_75_35 < arg_72_1.time_ and arg_72_1.time_ <= var_75_35 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_37 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_37:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_38 = arg_72_1:GetWordFromCfg(938062018)
				local var_75_39 = arg_72_1:FormatText(var_75_38.content)

				arg_72_1.text_.text = var_75_39

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_40 = 23
				local var_75_41 = utf8.len(var_75_39)
				local var_75_42 = var_75_40 <= 0 and var_75_36 or var_75_36 * (var_75_41 / var_75_40)

				if var_75_42 > 0 and var_75_36 < var_75_42 then
					arg_72_1.talkMaxDuration = var_75_42
					var_75_35 = var_75_35 + 0.3

					if var_75_42 + var_75_35 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_42 + var_75_35
					end
				end

				arg_72_1.text_.text = var_75_39
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_43 = var_75_35 + 0.3
			local var_75_44 = math.max(var_75_36, arg_72_1.talkMaxDuration)

			if var_75_43 <= arg_72_1.time_ and arg_72_1.time_ < var_75_43 + var_75_44 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_43) / var_75_44

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_43 + var_75_44 and arg_72_1.time_ < var_75_43 + var_75_44 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play938062019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938062019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938062020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10144"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10144 == nil then
				arg_78_1.var_.actorSpriteComps10144 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10144 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_81_1 then
							if arg_78_1.isInRecall_ then
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor1.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor1.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor1.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 1, var_81_3)

								iter_81_1.color = Color.New(var_81_7, var_81_7, var_81_7)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10144 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10144 = nil
			end

			local var_81_8 = arg_78_1.actors_["10144"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos10144 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10144", 3)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "split_11" or not string.find(var_81_11.name, "split") then
						var_81_11.gameObject:SetActive(true)
					else
						var_81_11.gameObject:SetActive(false)
					end
				end
			end

			local var_81_12 = 0.001

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10144, var_81_14, var_81_13)
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_81_15 = 0
			local var_81_16 = 1.35

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[1297].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(938062019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 54
				local var_81_21 = utf8.len(var_81_19)
				local var_81_22 = var_81_20 <= 0 and var_81_16 or var_81_16 * (var_81_21 / var_81_20)

				if var_81_22 > 0 and var_81_16 < var_81_22 then
					arg_78_1.talkMaxDuration = var_81_22

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_23 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_23 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_23

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_23 and arg_78_1.time_ < var_81_15 + var_81_23 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play938062020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938062020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938062021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.175

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[1297].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(938062020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 47
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play938062021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938062021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938062022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10144"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos10144 = var_89_0.localPosition
				var_89_0.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10144", 3)

				local var_89_2 = var_89_0.childCount

				for iter_89_0 = 0, var_89_2 - 1 do
					local var_89_3 = var_89_0:GetChild(iter_89_0)

					if var_89_3.name == "split_12" then
						var_89_3:SetAsLastSibling()
						var_89_3.gameObject:SetActive(true)

						arg_86_1.var_.actorSpriteSplit10144 = var_89_3.gameObject:GetComponent(typeof(Image))

						arg_86_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_89_4 = 0.5

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_4 then
				local var_89_5 = (arg_86_1.time_ - var_89_1) / var_89_4
				local var_89_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10144, var_89_6, var_89_5)

				if arg_86_1.var_.actorSpriteSplit10144 ~= nil then
					arg_86_1.var_.actorSpriteSplit10144:SetAlpha(var_89_5)
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_4 and arg_86_1.time_ < var_89_1 + var_89_4 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_86_1.var_.actorSpriteSplit10144 ~= nil then
					arg_86_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_89_7 = 0
			local var_89_8 = 0.225

			if var_89_7 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_9 = arg_86_1:FormatText(StoryNameCfg[1297].name)

				arg_86_1.leftNameTxt_.text = var_89_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(938062021)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_12 = 9
				local var_89_13 = utf8.len(var_89_11)
				local var_89_14 = var_89_12 <= 0 and var_89_8 or var_89_8 * (var_89_13 / var_89_12)

				if var_89_14 > 0 and var_89_8 < var_89_14 then
					arg_86_1.talkMaxDuration = var_89_14

					if var_89_14 + var_89_7 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_7
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_15 = math.max(var_89_8, arg_86_1.talkMaxDuration)

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_15 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_7) / var_89_15

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_7 + var_89_15 and arg_86_1.time_ < var_89_7 + var_89_15 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play938062022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938062022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938062023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10144"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10144 == nil then
				arg_90_1.var_.actorSpriteComps10144 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps10144 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 0.5, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10144 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10144 = nil
			end

			local var_93_8 = arg_90_1.actors_["10144"].transform
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.var_.moveOldPos10144 = var_93_8.localPosition
				var_93_8.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10144", 7)

				local var_93_10 = var_93_8.childCount

				for iter_93_4 = 0, var_93_10 - 1 do
					local var_93_11 = var_93_8:GetChild(iter_93_4)

					if var_93_11.name == "" or not string.find(var_93_11.name, "split") then
						var_93_11.gameObject:SetActive(true)
					else
						var_93_11.gameObject:SetActive(false)
					end
				end
			end

			local var_93_12 = 0.001

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_9) / var_93_12
				local var_93_14 = Vector3.New(0, -2000, 0)

				var_93_8.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10144, var_93_14, var_93_13)
			end

			if arg_90_1.time_ >= var_93_9 + var_93_12 and arg_90_1.time_ < var_93_9 + var_93_12 + arg_93_0 then
				var_93_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_93_15 = 0
			local var_93_16 = 0.95

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_17 = arg_90_1:GetWordFromCfg(938062022)
				local var_93_18 = arg_90_1:FormatText(var_93_17.content)

				arg_90_1.text_.text = var_93_18

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_19 = 38
				local var_93_20 = utf8.len(var_93_18)
				local var_93_21 = var_93_19 <= 0 and var_93_16 or var_93_16 * (var_93_20 / var_93_19)

				if var_93_21 > 0 and var_93_16 < var_93_21 then
					arg_90_1.talkMaxDuration = var_93_21

					if var_93_21 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_21 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_18
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_22 and arg_90_1.time_ < var_93_15 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938062023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938062023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938062024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.75

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(938062023)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 30
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play938062024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938062024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938062025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = "106603"

			if arg_98_1.actors_[var_101_0] == nil then
				local var_101_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_101_1) then
					local var_101_2 = Object.Instantiate(var_101_1, arg_98_1.canvasGo_.transform)

					var_101_2.transform:SetSiblingIndex(1)

					var_101_2.name = var_101_0
					var_101_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_98_1.actors_[var_101_0] = var_101_2

					local var_101_3 = var_101_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_98_1.isInRecall_ then
						for iter_101_0, iter_101_1 in ipairs(var_101_3) do
							iter_101_1.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_101_4 = arg_98_1.actors_["106603"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.actorSpriteComps106603 == nil then
				arg_98_1.var_.actorSpriteComps106603 = var_101_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_6 = 0.2

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.actorSpriteComps106603 then
					for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_101_3 then
							if arg_98_1.isInRecall_ then
								local var_101_8 = Mathf.Lerp(iter_101_3.color.r, arg_98_1.hightColor1.r, var_101_7)
								local var_101_9 = Mathf.Lerp(iter_101_3.color.g, arg_98_1.hightColor1.g, var_101_7)
								local var_101_10 = Mathf.Lerp(iter_101_3.color.b, arg_98_1.hightColor1.b, var_101_7)

								iter_101_3.color = Color.New(var_101_8, var_101_9, var_101_10)
							else
								local var_101_11 = Mathf.Lerp(iter_101_3.color.r, 1, var_101_7)

								iter_101_3.color = Color.New(var_101_11, var_101_11, var_101_11)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.actorSpriteComps106603 then
				for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_101_5 then
						if arg_98_1.isInRecall_ then
							iter_101_5.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps106603 = nil
			end

			local var_101_12 = arg_98_1.actors_["106603"].transform
			local var_101_13 = 0

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				arg_98_1.var_.moveOldPos106603 = var_101_12.localPosition
				var_101_12.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("106603", 2)

				local var_101_14 = var_101_12.childCount

				for iter_101_6 = 0, var_101_14 - 1 do
					local var_101_15 = var_101_12:GetChild(iter_101_6)

					if var_101_15.name == "split_12" or not string.find(var_101_15.name, "split") then
						var_101_15.gameObject:SetActive(true)
					else
						var_101_15.gameObject:SetActive(false)
					end
				end
			end

			local var_101_16 = 0.001

			if var_101_13 <= arg_98_1.time_ and arg_98_1.time_ < var_101_13 + var_101_16 then
				local var_101_17 = (arg_98_1.time_ - var_101_13) / var_101_16
				local var_101_18 = Vector3.New(-510.9, -399.1, -303.3)

				var_101_12.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos106603, var_101_18, var_101_17)
			end

			if arg_98_1.time_ >= var_101_13 + var_101_16 and arg_98_1.time_ < var_101_13 + var_101_16 + arg_101_0 then
				var_101_12.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_101_19 = 0
			local var_101_20 = 0.525

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_21 = arg_98_1:FormatText(StoryNameCfg[32].name)

				arg_98_1.leftNameTxt_.text = var_101_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_22 = arg_98_1:GetWordFromCfg(938062024)
				local var_101_23 = arg_98_1:FormatText(var_101_22.content)

				arg_98_1.text_.text = var_101_23

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_24 = 21
				local var_101_25 = utf8.len(var_101_23)
				local var_101_26 = var_101_24 <= 0 and var_101_20 or var_101_20 * (var_101_25 / var_101_24)

				if var_101_26 > 0 and var_101_20 < var_101_26 then
					arg_98_1.talkMaxDuration = var_101_26

					if var_101_26 + var_101_19 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_26 + var_101_19
					end
				end

				arg_98_1.text_.text = var_101_23
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_27 = math.max(var_101_20, arg_98_1.talkMaxDuration)

			if var_101_19 <= arg_98_1.time_ and arg_98_1.time_ < var_101_19 + var_101_27 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_19) / var_101_27

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_19 + var_101_27 and arg_98_1.time_ < var_101_19 + var_101_27 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play938062025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938062025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938062026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = "128404"

			if arg_102_1.actors_[var_105_0] == nil then
				local var_105_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_105_1) then
					local var_105_2 = Object.Instantiate(var_105_1, arg_102_1.canvasGo_.transform)

					var_105_2.transform:SetSiblingIndex(1)

					var_105_2.name = var_105_0
					var_105_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_102_1.actors_[var_105_0] = var_105_2

					local var_105_3 = var_105_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_102_1.isInRecall_ then
						for iter_105_0, iter_105_1 in ipairs(var_105_3) do
							iter_105_1.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_105_4 = arg_102_1.actors_["128404"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.actorSpriteComps128404 == nil then
				arg_102_1.var_.actorSpriteComps128404 = var_105_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_6 = 0.2

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.actorSpriteComps128404 then
					for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_105_3 then
							if arg_102_1.isInRecall_ then
								local var_105_8 = Mathf.Lerp(iter_105_3.color.r, arg_102_1.hightColor1.r, var_105_7)
								local var_105_9 = Mathf.Lerp(iter_105_3.color.g, arg_102_1.hightColor1.g, var_105_7)
								local var_105_10 = Mathf.Lerp(iter_105_3.color.b, arg_102_1.hightColor1.b, var_105_7)

								iter_105_3.color = Color.New(var_105_8, var_105_9, var_105_10)
							else
								local var_105_11 = Mathf.Lerp(iter_105_3.color.r, 1, var_105_7)

								iter_105_3.color = Color.New(var_105_11, var_105_11, var_105_11)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.actorSpriteComps128404 then
				for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_105_5 then
						if arg_102_1.isInRecall_ then
							iter_105_5.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps128404 = nil
			end

			local var_105_12 = arg_102_1.actors_["106603"]
			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 and not isNil(var_105_12) and arg_102_1.var_.actorSpriteComps106603 == nil then
				arg_102_1.var_.actorSpriteComps106603 = var_105_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_14 = 0.2

			if var_105_13 <= arg_102_1.time_ and arg_102_1.time_ < var_105_13 + var_105_14 and not isNil(var_105_12) then
				local var_105_15 = (arg_102_1.time_ - var_105_13) / var_105_14

				if arg_102_1.var_.actorSpriteComps106603 then
					for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_105_7 then
							if arg_102_1.isInRecall_ then
								local var_105_16 = Mathf.Lerp(iter_105_7.color.r, arg_102_1.hightColor2.r, var_105_15)
								local var_105_17 = Mathf.Lerp(iter_105_7.color.g, arg_102_1.hightColor2.g, var_105_15)
								local var_105_18 = Mathf.Lerp(iter_105_7.color.b, arg_102_1.hightColor2.b, var_105_15)

								iter_105_7.color = Color.New(var_105_16, var_105_17, var_105_18)
							else
								local var_105_19 = Mathf.Lerp(iter_105_7.color.r, 0.5, var_105_15)

								iter_105_7.color = Color.New(var_105_19, var_105_19, var_105_19)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_13 + var_105_14 and arg_102_1.time_ < var_105_13 + var_105_14 + arg_105_0 and not isNil(var_105_12) and arg_102_1.var_.actorSpriteComps106603 then
				for iter_105_8, iter_105_9 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_105_9 then
						if arg_102_1.isInRecall_ then
							iter_105_9.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps106603 = nil
			end

			local var_105_20 = arg_102_1.actors_["128404"].transform
			local var_105_21 = 0

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1.var_.moveOldPos128404 = var_105_20.localPosition
				var_105_20.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("128404", 4)

				local var_105_22 = var_105_20.childCount

				for iter_105_10 = 0, var_105_22 - 1 do
					local var_105_23 = var_105_20:GetChild(iter_105_10)

					if var_105_23.name == "split_10" or not string.find(var_105_23.name, "split") then
						var_105_23.gameObject:SetActive(true)
					else
						var_105_23.gameObject:SetActive(false)
					end
				end
			end

			local var_105_24 = 0.001

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_24 then
				local var_105_25 = (arg_102_1.time_ - var_105_21) / var_105_24
				local var_105_26 = Vector3.New(390.2, -356, -362.3)

				var_105_20.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos128404, var_105_26, var_105_25)
			end

			if arg_102_1.time_ >= var_105_21 + var_105_24 and arg_102_1.time_ < var_105_21 + var_105_24 + arg_105_0 then
				var_105_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_105_27 = 0
			local var_105_28 = 0.525

			if var_105_27 < arg_102_1.time_ and arg_102_1.time_ <= var_105_27 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_29 = arg_102_1:FormatText(StoryNameCfg[6].name)

				arg_102_1.leftNameTxt_.text = var_105_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_30 = arg_102_1:GetWordFromCfg(938062025)
				local var_105_31 = arg_102_1:FormatText(var_105_30.content)

				arg_102_1.text_.text = var_105_31

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_32 = 21
				local var_105_33 = utf8.len(var_105_31)
				local var_105_34 = var_105_32 <= 0 and var_105_28 or var_105_28 * (var_105_33 / var_105_32)

				if var_105_34 > 0 and var_105_28 < var_105_34 then
					arg_102_1.talkMaxDuration = var_105_34

					if var_105_34 + var_105_27 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_34 + var_105_27
					end
				end

				arg_102_1.text_.text = var_105_31
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_35 = math.max(var_105_28, arg_102_1.talkMaxDuration)

			if var_105_27 <= arg_102_1.time_ and arg_102_1.time_ < var_105_27 + var_105_35 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_27) / var_105_35

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_27 + var_105_35 and arg_102_1.time_ < var_105_27 + var_105_35 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938062026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938062026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938062027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = "104902"

			if arg_106_1.actors_[var_109_0] == nil then
				local var_109_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_109_1) then
					local var_109_2 = Object.Instantiate(var_109_1, arg_106_1.canvasGo_.transform)

					var_109_2.transform:SetSiblingIndex(1)

					var_109_2.name = var_109_0
					var_109_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_106_1.actors_[var_109_0] = var_109_2

					local var_109_3 = var_109_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_106_1.isInRecall_ then
						for iter_109_0, iter_109_1 in ipairs(var_109_3) do
							iter_109_1.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_109_4 = arg_106_1.actors_["104902"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.actorSpriteComps104902 == nil then
				arg_106_1.var_.actorSpriteComps104902 = var_109_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_6 = 0.2

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.actorSpriteComps104902 then
					for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_109_3 then
							if arg_106_1.isInRecall_ then
								local var_109_8 = Mathf.Lerp(iter_109_3.color.r, arg_106_1.hightColor1.r, var_109_7)
								local var_109_9 = Mathf.Lerp(iter_109_3.color.g, arg_106_1.hightColor1.g, var_109_7)
								local var_109_10 = Mathf.Lerp(iter_109_3.color.b, arg_106_1.hightColor1.b, var_109_7)

								iter_109_3.color = Color.New(var_109_8, var_109_9, var_109_10)
							else
								local var_109_11 = Mathf.Lerp(iter_109_3.color.r, 1, var_109_7)

								iter_109_3.color = Color.New(var_109_11, var_109_11, var_109_11)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.actorSpriteComps104902 then
				for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_109_5 then
						if arg_106_1.isInRecall_ then
							iter_109_5.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps104902 = nil
			end

			local var_109_12 = arg_106_1.actors_["128404"]
			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 and not isNil(var_109_12) and arg_106_1.var_.actorSpriteComps128404 == nil then
				arg_106_1.var_.actorSpriteComps128404 = var_109_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_14 = 0.2

			if var_109_13 <= arg_106_1.time_ and arg_106_1.time_ < var_109_13 + var_109_14 and not isNil(var_109_12) then
				local var_109_15 = (arg_106_1.time_ - var_109_13) / var_109_14

				if arg_106_1.var_.actorSpriteComps128404 then
					for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_109_7 then
							if arg_106_1.isInRecall_ then
								local var_109_16 = Mathf.Lerp(iter_109_7.color.r, arg_106_1.hightColor2.r, var_109_15)
								local var_109_17 = Mathf.Lerp(iter_109_7.color.g, arg_106_1.hightColor2.g, var_109_15)
								local var_109_18 = Mathf.Lerp(iter_109_7.color.b, arg_106_1.hightColor2.b, var_109_15)

								iter_109_7.color = Color.New(var_109_16, var_109_17, var_109_18)
							else
								local var_109_19 = Mathf.Lerp(iter_109_7.color.r, 0.5, var_109_15)

								iter_109_7.color = Color.New(var_109_19, var_109_19, var_109_19)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_13 + var_109_14 and arg_106_1.time_ < var_109_13 + var_109_14 + arg_109_0 and not isNil(var_109_12) and arg_106_1.var_.actorSpriteComps128404 then
				for iter_109_8, iter_109_9 in pairs(arg_106_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_109_9 then
						if arg_106_1.isInRecall_ then
							iter_109_9.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps128404 = nil
			end

			local var_109_20 = arg_106_1.actors_["104902"].transform
			local var_109_21 = 0

			if var_109_21 < arg_106_1.time_ and arg_106_1.time_ <= var_109_21 + arg_109_0 then
				arg_106_1.var_.moveOldPos104902 = var_109_20.localPosition
				var_109_20.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("104902", 2)

				local var_109_22 = var_109_20.childCount

				for iter_109_10 = 0, var_109_22 - 1 do
					local var_109_23 = var_109_20:GetChild(iter_109_10)

					if var_109_23.name == "split_6" or not string.find(var_109_23.name, "split") then
						var_109_23.gameObject:SetActive(true)
					else
						var_109_23.gameObject:SetActive(false)
					end
				end
			end

			local var_109_24 = 0.001

			if var_109_21 <= arg_106_1.time_ and arg_106_1.time_ < var_109_21 + var_109_24 then
				local var_109_25 = (arg_106_1.time_ - var_109_21) / var_109_24
				local var_109_26 = Vector3.New(-390, -335, -360)

				var_109_20.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos104902, var_109_26, var_109_25)
			end

			if arg_106_1.time_ >= var_109_21 + var_109_24 and arg_106_1.time_ < var_109_21 + var_109_24 + arg_109_0 then
				var_109_20.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_109_27 = arg_106_1.actors_["106603"].transform
			local var_109_28 = 0

			if var_109_28 < arg_106_1.time_ and arg_106_1.time_ <= var_109_28 + arg_109_0 then
				arg_106_1.var_.moveOldPos106603 = var_109_27.localPosition
				var_109_27.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("106603", 7)

				local var_109_29 = var_109_27.childCount

				for iter_109_11 = 0, var_109_29 - 1 do
					local var_109_30 = var_109_27:GetChild(iter_109_11)

					if var_109_30.name == "" or not string.find(var_109_30.name, "split") then
						var_109_30.gameObject:SetActive(true)
					else
						var_109_30.gameObject:SetActive(false)
					end
				end
			end

			local var_109_31 = 0.001

			if var_109_28 <= arg_106_1.time_ and arg_106_1.time_ < var_109_28 + var_109_31 then
				local var_109_32 = (arg_106_1.time_ - var_109_28) / var_109_31
				local var_109_33 = Vector3.New(0, -2000, 0)

				var_109_27.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos106603, var_109_33, var_109_32)
			end

			if arg_106_1.time_ >= var_109_28 + var_109_31 and arg_106_1.time_ < var_109_28 + var_109_31 + arg_109_0 then
				var_109_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_109_34 = 0
			local var_109_35 = 0.45

			if var_109_34 < arg_106_1.time_ and arg_106_1.time_ <= var_109_34 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_36 = arg_106_1:FormatText(StoryNameCfg[562].name)

				arg_106_1.leftNameTxt_.text = var_109_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_37 = arg_106_1:GetWordFromCfg(938062026)
				local var_109_38 = arg_106_1:FormatText(var_109_37.content)

				arg_106_1.text_.text = var_109_38

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_39 = 18
				local var_109_40 = utf8.len(var_109_38)
				local var_109_41 = var_109_39 <= 0 and var_109_35 or var_109_35 * (var_109_40 / var_109_39)

				if var_109_41 > 0 and var_109_35 < var_109_41 then
					arg_106_1.talkMaxDuration = var_109_41

					if var_109_41 + var_109_34 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_41 + var_109_34
					end
				end

				arg_106_1.text_.text = var_109_38
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_42 = math.max(var_109_35, arg_106_1.talkMaxDuration)

			if var_109_34 <= arg_106_1.time_ and arg_106_1.time_ < var_109_34 + var_109_42 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_34) / var_109_42

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_34 + var_109_42 and arg_106_1.time_ < var_109_34 + var_109_42 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play938062027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938062027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938062028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "108301"

			if arg_110_1.actors_[var_113_0] == nil then
				local var_113_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_113_1) then
					local var_113_2 = Object.Instantiate(var_113_1, arg_110_1.canvasGo_.transform)

					var_113_2.transform:SetSiblingIndex(1)

					var_113_2.name = var_113_0
					var_113_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_110_1.actors_[var_113_0] = var_113_2

					local var_113_3 = var_113_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_110_1.isInRecall_ then
						for iter_113_0, iter_113_1 in ipairs(var_113_3) do
							iter_113_1.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_113_4 = arg_110_1.actors_["108301"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = var_113_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_6 = 0.2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_3 then
							if arg_110_1.isInRecall_ then
								local var_113_8 = Mathf.Lerp(iter_113_3.color.r, arg_110_1.hightColor1.r, var_113_7)
								local var_113_9 = Mathf.Lerp(iter_113_3.color.g, arg_110_1.hightColor1.g, var_113_7)
								local var_113_10 = Mathf.Lerp(iter_113_3.color.b, arg_110_1.hightColor1.b, var_113_7)

								iter_113_3.color = Color.New(var_113_8, var_113_9, var_113_10)
							else
								local var_113_11 = Mathf.Lerp(iter_113_3.color.r, 1, var_113_7)

								iter_113_3.color = Color.New(var_113_11, var_113_11, var_113_11)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_5 then
						if arg_110_1.isInRecall_ then
							iter_113_5.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_12 = arg_110_1.actors_["104902"]
			local var_113_13 = 0

			if var_113_13 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 and not isNil(var_113_12) and arg_110_1.var_.actorSpriteComps104902 == nil then
				arg_110_1.var_.actorSpriteComps104902 = var_113_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_14 = 0.2

			if var_113_13 <= arg_110_1.time_ and arg_110_1.time_ < var_113_13 + var_113_14 and not isNil(var_113_12) then
				local var_113_15 = (arg_110_1.time_ - var_113_13) / var_113_14

				if arg_110_1.var_.actorSpriteComps104902 then
					for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_113_7 then
							if arg_110_1.isInRecall_ then
								local var_113_16 = Mathf.Lerp(iter_113_7.color.r, arg_110_1.hightColor2.r, var_113_15)
								local var_113_17 = Mathf.Lerp(iter_113_7.color.g, arg_110_1.hightColor2.g, var_113_15)
								local var_113_18 = Mathf.Lerp(iter_113_7.color.b, arg_110_1.hightColor2.b, var_113_15)

								iter_113_7.color = Color.New(var_113_16, var_113_17, var_113_18)
							else
								local var_113_19 = Mathf.Lerp(iter_113_7.color.r, 0.5, var_113_15)

								iter_113_7.color = Color.New(var_113_19, var_113_19, var_113_19)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_13 + var_113_14 and arg_110_1.time_ < var_113_13 + var_113_14 + arg_113_0 and not isNil(var_113_12) and arg_110_1.var_.actorSpriteComps104902 then
				for iter_113_8, iter_113_9 in pairs(arg_110_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_113_9 then
						if arg_110_1.isInRecall_ then
							iter_113_9.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps104902 = nil
			end

			local var_113_20 = arg_110_1.actors_["108301"].transform
			local var_113_21 = 0

			if var_113_21 < arg_110_1.time_ and arg_110_1.time_ <= var_113_21 + arg_113_0 then
				arg_110_1.var_.moveOldPos108301 = var_113_20.localPosition
				var_113_20.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("108301", 4)

				local var_113_22 = var_113_20.childCount

				for iter_113_10 = 0, var_113_22 - 1 do
					local var_113_23 = var_113_20:GetChild(iter_113_10)

					if var_113_23.name == "split_6" or not string.find(var_113_23.name, "split") then
						var_113_23.gameObject:SetActive(true)
					else
						var_113_23.gameObject:SetActive(false)
					end
				end
			end

			local var_113_24 = 0.001

			if var_113_21 <= arg_110_1.time_ and arg_110_1.time_ < var_113_21 + var_113_24 then
				local var_113_25 = (arg_110_1.time_ - var_113_21) / var_113_24
				local var_113_26 = Vector3.New(460, -360, -195)

				var_113_20.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos108301, var_113_26, var_113_25)
			end

			if arg_110_1.time_ >= var_113_21 + var_113_24 and arg_110_1.time_ < var_113_21 + var_113_24 + arg_113_0 then
				var_113_20.localPosition = Vector3.New(460, -360, -195)
			end

			local var_113_27 = arg_110_1.actors_["128404"].transform
			local var_113_28 = 0

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1.var_.moveOldPos128404 = var_113_27.localPosition
				var_113_27.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("128404", 7)

				local var_113_29 = var_113_27.childCount

				for iter_113_11 = 0, var_113_29 - 1 do
					local var_113_30 = var_113_27:GetChild(iter_113_11)

					if var_113_30.name == "" or not string.find(var_113_30.name, "split") then
						var_113_30.gameObject:SetActive(true)
					else
						var_113_30.gameObject:SetActive(false)
					end
				end
			end

			local var_113_31 = 0.001

			if var_113_28 <= arg_110_1.time_ and arg_110_1.time_ < var_113_28 + var_113_31 then
				local var_113_32 = (arg_110_1.time_ - var_113_28) / var_113_31
				local var_113_33 = Vector3.New(0, -2000, 0)

				var_113_27.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos128404, var_113_33, var_113_32)
			end

			if arg_110_1.time_ >= var_113_28 + var_113_31 and arg_110_1.time_ < var_113_28 + var_113_31 + arg_113_0 then
				var_113_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_34 = 0
			local var_113_35 = 0.425

			if var_113_34 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_36 = arg_110_1:FormatText(StoryNameCfg[1332].name)

				arg_110_1.leftNameTxt_.text = var_113_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_37 = arg_110_1:GetWordFromCfg(938062027)
				local var_113_38 = arg_110_1:FormatText(var_113_37.content)

				arg_110_1.text_.text = var_113_38

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_39 = 17
				local var_113_40 = utf8.len(var_113_38)
				local var_113_41 = var_113_39 <= 0 and var_113_35 or var_113_35 * (var_113_40 / var_113_39)

				if var_113_41 > 0 and var_113_35 < var_113_41 then
					arg_110_1.talkMaxDuration = var_113_41

					if var_113_41 + var_113_34 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_41 + var_113_34
					end
				end

				arg_110_1.text_.text = var_113_38
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_42 = math.max(var_113_35, arg_110_1.talkMaxDuration)

			if var_113_34 <= arg_110_1.time_ and arg_110_1.time_ < var_113_34 + var_113_42 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_34) / var_113_42

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_34 + var_113_42 and arg_110_1.time_ < var_113_34 + var_113_42 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play938062028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938062028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938062029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10183"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps10183 == nil then
				arg_114_1.var_.actorSpriteComps10183 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps10183 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor1.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor1.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor1.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 1, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps10183 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_117_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps10183 = nil
			end

			local var_117_8 = arg_114_1.actors_["108301"]
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 and not isNil(var_117_8) and arg_114_1.var_.actorSpriteComps108301 == nil then
				arg_114_1.var_.actorSpriteComps108301 = var_117_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_10 = 0.2

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_10 and not isNil(var_117_8) then
				local var_117_11 = (arg_114_1.time_ - var_117_9) / var_117_10

				if arg_114_1.var_.actorSpriteComps108301 then
					for iter_117_4, iter_117_5 in pairs(arg_114_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_117_5 then
							if arg_114_1.isInRecall_ then
								local var_117_12 = Mathf.Lerp(iter_117_5.color.r, arg_114_1.hightColor2.r, var_117_11)
								local var_117_13 = Mathf.Lerp(iter_117_5.color.g, arg_114_1.hightColor2.g, var_117_11)
								local var_117_14 = Mathf.Lerp(iter_117_5.color.b, arg_114_1.hightColor2.b, var_117_11)

								iter_117_5.color = Color.New(var_117_12, var_117_13, var_117_14)
							else
								local var_117_15 = Mathf.Lerp(iter_117_5.color.r, 0.5, var_117_11)

								iter_117_5.color = Color.New(var_117_15, var_117_15, var_117_15)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_9 + var_117_10 and arg_114_1.time_ < var_117_9 + var_117_10 + arg_117_0 and not isNil(var_117_8) and arg_114_1.var_.actorSpriteComps108301 then
				for iter_117_6, iter_117_7 in pairs(arg_114_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_117_7 then
						if arg_114_1.isInRecall_ then
							iter_117_7.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps108301 = nil
			end

			local var_117_16 = arg_114_1.actors_["10183"].transform
			local var_117_17 = 0

			if var_117_17 < arg_114_1.time_ and arg_114_1.time_ <= var_117_17 + arg_117_0 then
				arg_114_1.var_.moveOldPos10183 = var_117_16.localPosition
				var_117_16.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10183", 3)

				local var_117_18 = var_117_16.childCount

				for iter_117_8 = 0, var_117_18 - 1 do
					local var_117_19 = var_117_16:GetChild(iter_117_8)

					if var_117_19.name == "split_9" or not string.find(var_117_19.name, "split") then
						var_117_19.gameObject:SetActive(true)
					else
						var_117_19.gameObject:SetActive(false)
					end
				end
			end

			local var_117_20 = 0.001

			if var_117_17 <= arg_114_1.time_ and arg_114_1.time_ < var_117_17 + var_117_20 then
				local var_117_21 = (arg_114_1.time_ - var_117_17) / var_117_20
				local var_117_22 = Vector3.New(0, -475, -325)

				var_117_16.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10183, var_117_22, var_117_21)
			end

			if arg_114_1.time_ >= var_117_17 + var_117_20 and arg_114_1.time_ < var_117_17 + var_117_20 + arg_117_0 then
				var_117_16.localPosition = Vector3.New(0, -475, -325)
			end

			local var_117_23 = arg_114_1.actors_["108301"].transform
			local var_117_24 = 0

			if var_117_24 < arg_114_1.time_ and arg_114_1.time_ <= var_117_24 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_23.localPosition
				var_117_23.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 7)

				local var_117_25 = var_117_23.childCount

				for iter_117_9 = 0, var_117_25 - 1 do
					local var_117_26 = var_117_23:GetChild(iter_117_9)

					if var_117_26.name == "split_6" or not string.find(var_117_26.name, "split") then
						var_117_26.gameObject:SetActive(true)
					else
						var_117_26.gameObject:SetActive(false)
					end
				end
			end

			local var_117_27 = 0.001

			if var_117_24 <= arg_114_1.time_ and arg_114_1.time_ < var_117_24 + var_117_27 then
				local var_117_28 = (arg_114_1.time_ - var_117_24) / var_117_27
				local var_117_29 = Vector3.New(0, -2000, 0)

				var_117_23.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, var_117_29, var_117_28)
			end

			if arg_114_1.time_ >= var_117_24 + var_117_27 and arg_114_1.time_ < var_117_24 + var_117_27 + arg_117_0 then
				var_117_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_30 = arg_114_1.actors_["104902"].transform
			local var_117_31 = 0

			if var_117_31 < arg_114_1.time_ and arg_114_1.time_ <= var_117_31 + arg_117_0 then
				arg_114_1.var_.moveOldPos104902 = var_117_30.localPosition
				var_117_30.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("104902", 7)

				local var_117_32 = var_117_30.childCount

				for iter_117_10 = 0, var_117_32 - 1 do
					local var_117_33 = var_117_30:GetChild(iter_117_10)

					if var_117_33.name == "" or not string.find(var_117_33.name, "split") then
						var_117_33.gameObject:SetActive(true)
					else
						var_117_33.gameObject:SetActive(false)
					end
				end
			end

			local var_117_34 = 0.001

			if var_117_31 <= arg_114_1.time_ and arg_114_1.time_ < var_117_31 + var_117_34 then
				local var_117_35 = (arg_114_1.time_ - var_117_31) / var_117_34
				local var_117_36 = Vector3.New(0, -2000, -360)

				var_117_30.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos104902, var_117_36, var_117_35)
			end

			if arg_114_1.time_ >= var_117_31 + var_117_34 and arg_114_1.time_ < var_117_31 + var_117_34 + arg_117_0 then
				var_117_30.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_117_37 = 0
			local var_117_38 = 1.325

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_39 = arg_114_1:FormatText(StoryNameCfg[1562].name)

				arg_114_1.leftNameTxt_.text = var_117_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_40 = arg_114_1:GetWordFromCfg(938062028)
				local var_117_41 = arg_114_1:FormatText(var_117_40.content)

				arg_114_1.text_.text = var_117_41

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_42 = 53
				local var_117_43 = utf8.len(var_117_41)
				local var_117_44 = var_117_42 <= 0 and var_117_38 or var_117_38 * (var_117_43 / var_117_42)

				if var_117_44 > 0 and var_117_38 < var_117_44 then
					arg_114_1.talkMaxDuration = var_117_44

					if var_117_44 + var_117_37 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_44 + var_117_37
					end
				end

				arg_114_1.text_.text = var_117_41
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_45 = math.max(var_117_38, arg_114_1.talkMaxDuration)

			if var_117_37 <= arg_114_1.time_ and arg_114_1.time_ < var_117_37 + var_117_45 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_37) / var_117_45

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_37 + var_117_45 and arg_114_1.time_ < var_117_37 + var_117_45 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938062029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938062029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938062030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["10183"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10183 == nil then
				arg_118_1.var_.actorSpriteComps10183 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps10183 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 0.5, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps10183 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps10183 = nil
			end

			local var_121_8 = arg_118_1.actors_["10183"].transform
			local var_121_9 = 0

			if var_121_9 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.var_.moveOldPos10183 = var_121_8.localPosition
				var_121_8.localScale = Vector3.New(1, 1, 1)

				arg_118_1:CheckSpriteTmpPos("10183", 7)

				local var_121_10 = var_121_8.childCount

				for iter_121_4 = 0, var_121_10 - 1 do
					local var_121_11 = var_121_8:GetChild(iter_121_4)

					if var_121_11.name == "" or not string.find(var_121_11.name, "split") then
						var_121_11.gameObject:SetActive(true)
					else
						var_121_11.gameObject:SetActive(false)
					end
				end
			end

			local var_121_12 = 0.001

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_9) / var_121_12
				local var_121_14 = Vector3.New(0, -2000, 0)

				var_121_8.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10183, var_121_14, var_121_13)
			end

			if arg_118_1.time_ >= var_121_9 + var_121_12 and arg_118_1.time_ < var_121_9 + var_121_12 + arg_121_0 then
				var_121_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_121_15 = 0.3
			local var_121_16 = 1

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				local var_121_17 = "play"
				local var_121_18 = "effect"

				arg_118_1:AudioAction(var_121_17, var_121_18, "se_story_1310", "se_story_1310_car01", "")
			end

			local var_121_19 = 0
			local var_121_20 = 0.9

			if var_121_19 < arg_118_1.time_ and arg_118_1.time_ <= var_121_19 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_21 = arg_118_1:GetWordFromCfg(938062029)
				local var_121_22 = arg_118_1:FormatText(var_121_21.content)

				arg_118_1.text_.text = var_121_22

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_23 = 36
				local var_121_24 = utf8.len(var_121_22)
				local var_121_25 = var_121_23 <= 0 and var_121_20 or var_121_20 * (var_121_24 / var_121_23)

				if var_121_25 > 0 and var_121_20 < var_121_25 then
					arg_118_1.talkMaxDuration = var_121_25

					if var_121_25 + var_121_19 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_25 + var_121_19
					end
				end

				arg_118_1.text_.text = var_121_22
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_26 = math.max(var_121_20, arg_118_1.talkMaxDuration)

			if var_121_19 <= arg_118_1.time_ and arg_118_1.time_ < var_121_19 + var_121_26 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_19) / var_121_26

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_19 + var_121_26 and arg_118_1.time_ < var_121_19 + var_121_26 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play938062030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938062030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
			arg_122_1.auto_ = false
		end

		function arg_122_1.playNext_(arg_124_0)
			arg_122_1.onStoryFinished_()
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.2

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(938062030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 8
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
