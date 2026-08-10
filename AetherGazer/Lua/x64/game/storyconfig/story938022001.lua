return {
	Play938022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938022002(arg_1_1)
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

			local var_4_24 = "108301"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

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

			local var_4_28 = arg_1_1.actors_["108301"]
			local var_4_29 = 2

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps108301 == nil then
				arg_1_1.var_.actorSpriteComps108301 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps108301 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps108301 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps108301 = nil
			end

			local var_4_36 = arg_1_1.actors_["108301"].transform
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos108301 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("108301", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_2" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -360, -195)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos108301, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -360, -195)
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

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

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

			local var_4_53 = arg_1_1.actors_["108301"]
			local var_4_54 = 2

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_55 = var_4_53:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_55 then
					arg_1_1.var_.alphaOldValue108301 = var_4_55.alpha
					arg_1_1.var_.characterEffect108301 = var_4_55
				end

				arg_1_1.var_.alphaOldValue108301 = 0
			end

			local var_4_56 = 0.5

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_56 then
				local var_4_57 = (arg_1_1.time_ - var_4_54) / var_4_56
				local var_4_58 = Mathf.Lerp(arg_1_1.var_.alphaOldValue108301, 1, var_4_57)

				if arg_1_1.var_.characterEffect108301 then
					arg_1_1.var_.characterEffect108301.alpha = var_4_58
				end
			end

			if arg_1_1.time_ >= var_4_54 + var_4_56 and arg_1_1.time_ < var_4_54 + var_4_56 + arg_4_0 and arg_1_1.var_.characterEffect108301 then
				arg_1_1.var_.characterEffect108301.alpha = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 2
			local var_4_60 = 0.65

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1332].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(938022001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 26
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
				actorName = "108301",
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
	Play938022002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 938022002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play938022003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["108301"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps108301 == nil then
				arg_8_1.var_.actorSpriteComps108301 = var_11_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.actorSpriteComps108301 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.actorSpriteComps108301 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_11_3 then
						if arg_8_1.isInRecall_ then
							iter_11_3.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps108301 = nil
			end

			local var_11_8 = 0
			local var_11_9 = 0.35

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

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_11 = arg_8_1:GetWordFromCfg(938022002)
				local var_11_12 = arg_8_1:FormatText(var_11_11.content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 14
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
	Play938022003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 938022003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play938022004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["108301"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos108301 = var_15_0.localPosition
				var_15_0.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("108301", 7)

				local var_15_2 = var_15_0.childCount

				for iter_15_0 = 0, var_15_2 - 1 do
					local var_15_3 = var_15_0:GetChild(iter_15_0)

					if var_15_3.name == "" or not string.find(var_15_3.name, "split") then
						var_15_3.gameObject:SetActive(true)
					else
						var_15_3.gameObject:SetActive(false)
					end
				end
			end

			local var_15_4 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_4 then
				local var_15_5 = (arg_12_1.time_ - var_15_1) / var_15_4
				local var_15_6 = Vector3.New(0, -2000, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos108301, var_15_6, var_15_5)
			end

			if arg_12_1.time_ >= var_15_1 + var_15_4 and arg_12_1.time_ < var_15_1 + var_15_4 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_15_7 = 0
			local var_15_8 = 1.325

			if var_15_7 < arg_12_1.time_ and arg_12_1.time_ <= var_15_7 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(938022003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 53
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_8 or var_15_8 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_8 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_7 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_7
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_8, arg_12_1.talkMaxDuration)

			if var_15_7 <= arg_12_1.time_ and arg_12_1.time_ < var_15_7 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_7) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_7 + var_15_14 and arg_12_1.time_ < var_15_7 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play938022004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 938022004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play938022005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1.675

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(938022004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 67
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play938022005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 938022005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play938022006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["108301"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps108301 == nil then
				arg_20_1.var_.actorSpriteComps108301 = var_23_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_2 = 0.2

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.actorSpriteComps108301 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.actorSpriteComps108301 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_23_3 then
						if arg_20_1.isInRecall_ then
							iter_23_3.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_23_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_20_1.var_.actorSpriteComps108301 = nil
			end

			local var_23_8 = arg_20_1.actors_["108301"].transform
			local var_23_9 = 0

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.var_.moveOldPos108301 = var_23_8.localPosition
				var_23_8.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("108301", 3)

				local var_23_10 = var_23_8.childCount

				for iter_23_4 = 0, var_23_10 - 1 do
					local var_23_11 = var_23_8:GetChild(iter_23_4)

					if var_23_11.name == "" or not string.find(var_23_11.name, "split") then
						var_23_11.gameObject:SetActive(true)
					else
						var_23_11.gameObject:SetActive(false)
					end
				end
			end

			local var_23_12 = 0.001

			if var_23_9 <= arg_20_1.time_ and arg_20_1.time_ < var_23_9 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_9) / var_23_12
				local var_23_14 = Vector3.New(0, -360, -195)

				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos108301, var_23_14, var_23_13)
			end

			if arg_20_1.time_ >= var_23_9 + var_23_12 and arg_20_1.time_ < var_23_9 + var_23_12 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_23_15 = 0
			local var_23_16 = 0.75

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[1332].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(938022005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 30
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
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play938022006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 938022006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play938022007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["108301"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps108301 == nil then
				arg_24_1.var_.actorSpriteComps108301 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps108301 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps108301 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps108301 = nil
			end

			local var_27_8 = 0
			local var_27_9 = 1.15

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

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_11 = arg_24_1:GetWordFromCfg(938022006)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 46
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
	Play938022007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 938022007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play938022008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["108301"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps108301 == nil then
				arg_28_1.var_.actorSpriteComps108301 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps108301 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								local var_31_4 = Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor1.r, var_31_3)
								local var_31_5 = Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor1.g, var_31_3)
								local var_31_6 = Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor1.b, var_31_3)

								iter_31_1.color = Color.New(var_31_4, var_31_5, var_31_6)
							else
								local var_31_7 = Mathf.Lerp(iter_31_1.color.r, 1, var_31_3)

								iter_31_1.color = Color.New(var_31_7, var_31_7, var_31_7)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps108301 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps108301 = nil
			end

			local var_31_8 = arg_28_1.actors_["108301"].transform
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.var_.moveOldPos108301 = var_31_8.localPosition
				var_31_8.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("108301", 3)

				local var_31_10 = var_31_8.childCount

				for iter_31_4 = 0, var_31_10 - 1 do
					local var_31_11 = var_31_8:GetChild(iter_31_4)

					if var_31_11.name == "split_5" then
						var_31_11:SetAsLastSibling()
						var_31_11.gameObject:SetActive(true)

						arg_28_1.var_.actorSpriteSplit108301 = var_31_11.gameObject:GetComponent(typeof(Image))

						arg_28_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_31_12 = 0.5

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_12 then
				local var_31_13 = (arg_28_1.time_ - var_31_9) / var_31_12
				local var_31_14 = Vector3.New(0, -360, -195)

				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos108301, var_31_14, var_31_13)

				if arg_28_1.var_.actorSpriteSplit108301 ~= nil then
					arg_28_1.var_.actorSpriteSplit108301:SetAlpha(var_31_13)
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_12 and arg_28_1.time_ < var_31_9 + var_31_12 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, -360, -195)

				if arg_28_1.var_.actorSpriteSplit108301 ~= nil then
					arg_28_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_31_15 = 0
			local var_31_16 = 1.375

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[1332].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(938022007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 55
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_23 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_23 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_23

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_23 and arg_28_1.time_ < var_31_15 + var_31_23 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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

		arg_28_1:InitPlayNodeList()
	end,
	Play938022008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 938022008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play938022009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["108301"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps108301 == nil then
				arg_32_1.var_.actorSpriteComps108301 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps108301 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								local var_35_4 = Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor2.r, var_35_3)
								local var_35_5 = Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor2.g, var_35_3)
								local var_35_6 = Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor2.b, var_35_3)

								iter_35_1.color = Color.New(var_35_4, var_35_5, var_35_6)
							else
								local var_35_7 = Mathf.Lerp(iter_35_1.color.r, 0.5, var_35_3)

								iter_35_1.color = Color.New(var_35_7, var_35_7, var_35_7)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps108301 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps108301 = nil
			end

			local var_35_8 = 0
			local var_35_9 = 1.075

			if var_35_8 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_10 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_10

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

				local var_35_11 = arg_32_1:GetWordFromCfg(938022008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 43
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_9 or var_35_9 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_9 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play938022009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 938022009
		arg_36_1.duration_ = 7

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play938022010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.3

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_1 = manager.ui.mainCamera.transform.localPosition
				local var_39_2 = Vector3.New(0, 0, 10) + Vector3.New(var_39_1.x, var_39_1.y, 0)
				local var_39_3 = arg_36_1.bgs_.ST0119

				var_39_3.transform.localPosition = var_39_2
				var_39_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_4 = var_39_3:GetComponent("SpriteRenderer")

				if var_39_4 and var_39_4.sprite then
					local var_39_5 = (var_39_3.transform.localPosition - var_39_1).z
					local var_39_6 = manager.ui.mainCameraCom_
					local var_39_7 = 2 * var_39_5 * Mathf.Tan(var_39_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_8 = var_39_7 * var_39_6.aspect
					local var_39_9 = var_39_4.sprite.bounds.size.x
					local var_39_10 = var_39_4.sprite.bounds.size.y
					local var_39_11 = var_39_8 / var_39_9
					local var_39_12 = var_39_7 / var_39_10
					local var_39_13 = var_39_12 < var_39_11 and var_39_11 or var_39_12

					var_39_3.transform.localScale = Vector3.New(var_39_13, var_39_13, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "ST0119" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_14 = 1.3

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_15 = 0.3

			if arg_36_1.time_ >= var_39_14 + var_39_15 and arg_36_1.time_ < var_39_14 + var_39_15 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_16 = manager.ui.mainCamera.transform
			local var_39_17 = 0

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				local var_39_18 = arg_36_1.var_.effectzhuanchang1
				local var_39_19
				local var_39_20 = var_39_16

				if not var_39_18 then
					var_39_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_39_20)
					var_39_18.name = "zhuanchang1"
					arg_36_1.var_.effectzhuanchang1 = var_39_18
				else
					var_39_18.transform:SetParent(var_39_20)
				end

				var_39_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_39_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_39_21 = "106603"

			if arg_36_1.actors_[var_39_21] == nil then
				local var_39_22 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_39_22) then
					local var_39_23 = Object.Instantiate(var_39_22, arg_36_1.canvasGo_.transform)

					var_39_23.transform:SetSiblingIndex(1)

					var_39_23.name = var_39_21
					var_39_23.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_36_1.actors_[var_39_21] = var_39_23

					local var_39_24 = var_39_23:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_36_1.isInRecall_ then
						for iter_39_2, iter_39_3 in ipairs(var_39_24) do
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_39_25 = arg_36_1.actors_["106603"]
			local var_39_26 = 2

			if var_39_26 < arg_36_1.time_ and arg_36_1.time_ <= var_39_26 + arg_39_0 and not isNil(var_39_25) and arg_36_1.var_.actorSpriteComps106603 == nil then
				arg_36_1.var_.actorSpriteComps106603 = var_39_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_27 = 0.2

			if var_39_26 <= arg_36_1.time_ and arg_36_1.time_ < var_39_26 + var_39_27 and not isNil(var_39_25) then
				local var_39_28 = (arg_36_1.time_ - var_39_26) / var_39_27

				if arg_36_1.var_.actorSpriteComps106603 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_39_5 then
							if arg_36_1.isInRecall_ then
								local var_39_29 = Mathf.Lerp(iter_39_5.color.r, arg_36_1.hightColor1.r, var_39_28)
								local var_39_30 = Mathf.Lerp(iter_39_5.color.g, arg_36_1.hightColor1.g, var_39_28)
								local var_39_31 = Mathf.Lerp(iter_39_5.color.b, arg_36_1.hightColor1.b, var_39_28)

								iter_39_5.color = Color.New(var_39_29, var_39_30, var_39_31)
							else
								local var_39_32 = Mathf.Lerp(iter_39_5.color.r, 1, var_39_28)

								iter_39_5.color = Color.New(var_39_32, var_39_32, var_39_32)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= var_39_26 + var_39_27 and arg_36_1.time_ < var_39_26 + var_39_27 + arg_39_0 and not isNil(var_39_25) and arg_36_1.var_.actorSpriteComps106603 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps106603 = nil
			end

			local var_39_33 = arg_36_1.actors_["108301"].transform
			local var_39_34 = 0

			if var_39_34 < arg_36_1.time_ and arg_36_1.time_ <= var_39_34 + arg_39_0 then
				arg_36_1.var_.moveOldPos108301 = var_39_33.localPosition
				var_39_33.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("108301", 7)

				local var_39_35 = var_39_33.childCount

				for iter_39_8 = 0, var_39_35 - 1 do
					local var_39_36 = var_39_33:GetChild(iter_39_8)

					if var_39_36.name == "" or not string.find(var_39_36.name, "split") then
						var_39_36.gameObject:SetActive(true)
					else
						var_39_36.gameObject:SetActive(false)
					end
				end
			end

			local var_39_37 = 0.001

			if var_39_34 <= arg_36_1.time_ and arg_36_1.time_ < var_39_34 + var_39_37 then
				local var_39_38 = (arg_36_1.time_ - var_39_34) / var_39_37
				local var_39_39 = Vector3.New(0, -2000, 0)

				var_39_33.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos108301, var_39_39, var_39_38)
			end

			if arg_36_1.time_ >= var_39_34 + var_39_37 and arg_36_1.time_ < var_39_34 + var_39_37 + arg_39_0 then
				var_39_33.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_40 = arg_36_1.actors_["106603"].transform
			local var_39_41 = 2

			if var_39_41 < arg_36_1.time_ and arg_36_1.time_ <= var_39_41 + arg_39_0 then
				arg_36_1.var_.moveOldPos106603 = var_39_40.localPosition
				var_39_40.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("106603", 2)

				local var_39_42 = var_39_40.childCount

				for iter_39_9 = 0, var_39_42 - 1 do
					local var_39_43 = var_39_40:GetChild(iter_39_9)

					if var_39_43.name == "" or not string.find(var_39_43.name, "split") then
						var_39_43.gameObject:SetActive(true)
					else
						var_39_43.gameObject:SetActive(false)
					end
				end
			end

			local var_39_44 = 0.001

			if var_39_41 <= arg_36_1.time_ and arg_36_1.time_ < var_39_41 + var_39_44 then
				local var_39_45 = (arg_36_1.time_ - var_39_41) / var_39_44
				local var_39_46 = Vector3.New(-510.9, -399.1, -303.3)

				var_39_40.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos106603, var_39_46, var_39_45)
			end

			if arg_36_1.time_ >= var_39_41 + var_39_44 and arg_36_1.time_ < var_39_41 + var_39_44 + arg_39_0 then
				var_39_40.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_39_47 = arg_36_1.actors_["106603"]
			local var_39_48 = 2

			if var_39_48 < arg_36_1.time_ and arg_36_1.time_ <= var_39_48 + arg_39_0 then
				local var_39_49 = var_39_47:GetComponentInChildren(typeof(CanvasGroup))

				if var_39_49 then
					arg_36_1.var_.alphaOldValue106603 = var_39_49.alpha
					arg_36_1.var_.characterEffect106603 = var_39_49
				end

				arg_36_1.var_.alphaOldValue106603 = 0
			end

			local var_39_50 = 0.5

			if var_39_48 <= arg_36_1.time_ and arg_36_1.time_ < var_39_48 + var_39_50 then
				local var_39_51 = (arg_36_1.time_ - var_39_48) / var_39_50
				local var_39_52 = Mathf.Lerp(arg_36_1.var_.alphaOldValue106603, 1, var_39_51)

				if arg_36_1.var_.characterEffect106603 then
					arg_36_1.var_.characterEffect106603.alpha = var_39_52
				end
			end

			if arg_36_1.time_ >= var_39_48 + var_39_50 and arg_36_1.time_ < var_39_48 + var_39_50 + arg_39_0 and arg_36_1.var_.characterEffect106603 then
				arg_36_1.var_.characterEffect106603.alpha = 1
			end

			local var_39_53 = 0

			if var_39_53 < arg_36_1.time_ and arg_36_1.time_ <= var_39_53 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_54 = 2.5

			if arg_36_1.time_ >= var_39_53 + var_39_54 and arg_36_1.time_ < var_39_53 + var_39_54 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_55 = 2
			local var_39_56 = 0.75

			if var_39_55 < arg_36_1.time_ and arg_36_1.time_ <= var_39_55 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_57 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_57:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_58 = arg_36_1:FormatText(StoryNameCfg[32].name)

				arg_36_1.leftNameTxt_.text = var_39_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_59 = arg_36_1:GetWordFromCfg(938022009)
				local var_39_60 = arg_36_1:FormatText(var_39_59.content)

				arg_36_1.text_.text = var_39_60

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_61 = 30
				local var_39_62 = utf8.len(var_39_60)
				local var_39_63 = var_39_61 <= 0 and var_39_56 or var_39_56 * (var_39_62 / var_39_61)

				if var_39_63 > 0 and var_39_56 < var_39_63 then
					arg_36_1.talkMaxDuration = var_39_63
					var_39_55 = var_39_55 + 0.3

					if var_39_63 + var_39_55 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_63 + var_39_55
					end
				end

				arg_36_1.text_.text = var_39_60
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_64 = var_39_55 + 0.3
			local var_39_65 = math.max(var_39_56, arg_36_1.talkMaxDuration)

			if var_39_64 <= arg_36_1.time_ and arg_36_1.time_ < var_39_64 + var_39_65 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_64) / var_39_65

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_64 + var_39_65 and arg_36_1.time_ < var_39_64 + var_39_65 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play938022010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 938022010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play938022011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "128404"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(var_45_1, arg_42_1.canvasGo_.transform)

					var_45_2.transform:SetSiblingIndex(1)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs(var_45_3) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_4 = arg_42_1.actors_["128404"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps128404 == nil then
				arg_42_1.var_.actorSpriteComps128404 = var_45_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.actorSpriteComps128404 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								local var_45_8 = Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, var_45_7)
								local var_45_9 = Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, var_45_7)
								local var_45_10 = Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, var_45_7)

								iter_45_3.color = Color.New(var_45_8, var_45_9, var_45_10)
							else
								local var_45_11 = Mathf.Lerp(iter_45_3.color.r, 1, var_45_7)

								iter_45_3.color = Color.New(var_45_11, var_45_11, var_45_11)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps128404 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_45_5 then
						if arg_42_1.isInRecall_ then
							iter_45_5.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps128404 = nil
			end

			local var_45_12 = arg_42_1.actors_["106603"]
			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps106603 == nil then
				arg_42_1.var_.actorSpriteComps106603 = var_45_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_14 = 0.2

			if var_45_13 <= arg_42_1.time_ and arg_42_1.time_ < var_45_13 + var_45_14 and not isNil(var_45_12) then
				local var_45_15 = (arg_42_1.time_ - var_45_13) / var_45_14

				if arg_42_1.var_.actorSpriteComps106603 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								local var_45_16 = Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, var_45_15)
								local var_45_17 = Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, var_45_15)
								local var_45_18 = Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, var_45_15)

								iter_45_7.color = Color.New(var_45_16, var_45_17, var_45_18)
							else
								local var_45_19 = Mathf.Lerp(iter_45_7.color.r, 0.5, var_45_15)

								iter_45_7.color = Color.New(var_45_19, var_45_19, var_45_19)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_13 + var_45_14 and arg_42_1.time_ < var_45_13 + var_45_14 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps106603 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_45_9 then
						if arg_42_1.isInRecall_ then
							iter_45_9.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps106603 = nil
			end

			local var_45_20 = arg_42_1.actors_["128404"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos128404 = var_45_20.localPosition
				var_45_20.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("128404", 4)

				local var_45_22 = var_45_20.childCount

				for iter_45_10 = 0, var_45_22 - 1 do
					local var_45_23 = var_45_20:GetChild(iter_45_10)

					if var_45_23.name == "split_3" or not string.find(var_45_23.name, "split") then
						var_45_23.gameObject:SetActive(true)
					else
						var_45_23.gameObject:SetActive(false)
					end
				end
			end

			local var_45_24 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_21) / var_45_24
				local var_45_26 = Vector3.New(390.2, -356, -362.3)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos128404, var_45_26, var_45_25)
			end

			if arg_42_1.time_ >= var_45_21 + var_45_24 and arg_42_1.time_ < var_45_21 + var_45_24 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_45_27 = arg_42_1.actors_["128404"]
			local var_45_28 = 0

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 then
				local var_45_29 = var_45_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_45_29 then
					arg_42_1.var_.alphaOldValue128404 = var_45_29.alpha
					arg_42_1.var_.characterEffect128404 = var_45_29
				end

				arg_42_1.var_.alphaOldValue128404 = 0
			end

			local var_45_30 = 0.5

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_30 then
				local var_45_31 = (arg_42_1.time_ - var_45_28) / var_45_30
				local var_45_32 = Mathf.Lerp(arg_42_1.var_.alphaOldValue128404, 1, var_45_31)

				if arg_42_1.var_.characterEffect128404 then
					arg_42_1.var_.characterEffect128404.alpha = var_45_32
				end
			end

			if arg_42_1.time_ >= var_45_28 + var_45_30 and arg_42_1.time_ < var_45_28 + var_45_30 + arg_45_0 and arg_42_1.var_.characterEffect128404 then
				arg_42_1.var_.characterEffect128404.alpha = 1
			end

			local var_45_33 = 0
			local var_45_34 = 1.15

			if var_45_33 < arg_42_1.time_ and arg_42_1.time_ <= var_45_33 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_35 = arg_42_1:FormatText(StoryNameCfg[6].name)

				arg_42_1.leftNameTxt_.text = var_45_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_36 = arg_42_1:GetWordFromCfg(938022010)
				local var_45_37 = arg_42_1:FormatText(var_45_36.content)

				arg_42_1.text_.text = var_45_37

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_38 = 46
				local var_45_39 = utf8.len(var_45_37)
				local var_45_40 = var_45_38 <= 0 and var_45_34 or var_45_34 * (var_45_39 / var_45_38)

				if var_45_40 > 0 and var_45_34 < var_45_40 then
					arg_42_1.talkMaxDuration = var_45_40

					if var_45_40 + var_45_33 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_40 + var_45_33
					end
				end

				arg_42_1.text_.text = var_45_37
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_41 = math.max(var_45_34, arg_42_1.talkMaxDuration)

			if var_45_33 <= arg_42_1.time_ and arg_42_1.time_ < var_45_33 + var_45_41 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_33) / var_45_41

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_33 + var_45_41 and arg_42_1.time_ < var_45_33 + var_45_41 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play938022011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 938022011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play938022012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "104902"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(var_49_1, arg_46_1.canvasGo_.transform)

					var_49_2.transform:SetSiblingIndex(1)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs(var_49_3) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_4 = arg_46_1.actors_["104902"]
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps104902 == nil then
				arg_46_1.var_.actorSpriteComps104902 = var_49_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_6 = 0.2

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 and not isNil(var_49_4) then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6

				if arg_46_1.var_.actorSpriteComps104902 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								local var_49_8 = Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, var_49_7)
								local var_49_9 = Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, var_49_7)
								local var_49_10 = Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, var_49_7)

								iter_49_3.color = Color.New(var_49_8, var_49_9, var_49_10)
							else
								local var_49_11 = Mathf.Lerp(iter_49_3.color.r, 1, var_49_7)

								iter_49_3.color = Color.New(var_49_11, var_49_11, var_49_11)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps104902 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_49_5 then
						if arg_46_1.isInRecall_ then
							iter_49_5.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps104902 = nil
			end

			local var_49_12 = arg_46_1.actors_["128404"]
			local var_49_13 = 0

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 and not isNil(var_49_12) and arg_46_1.var_.actorSpriteComps128404 == nil then
				arg_46_1.var_.actorSpriteComps128404 = var_49_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_14 = 0.2

			if var_49_13 <= arg_46_1.time_ and arg_46_1.time_ < var_49_13 + var_49_14 and not isNil(var_49_12) then
				local var_49_15 = (arg_46_1.time_ - var_49_13) / var_49_14

				if arg_46_1.var_.actorSpriteComps128404 then
					for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_49_7 then
							if arg_46_1.isInRecall_ then
								local var_49_16 = Mathf.Lerp(iter_49_7.color.r, arg_46_1.hightColor2.r, var_49_15)
								local var_49_17 = Mathf.Lerp(iter_49_7.color.g, arg_46_1.hightColor2.g, var_49_15)
								local var_49_18 = Mathf.Lerp(iter_49_7.color.b, arg_46_1.hightColor2.b, var_49_15)

								iter_49_7.color = Color.New(var_49_16, var_49_17, var_49_18)
							else
								local var_49_19 = Mathf.Lerp(iter_49_7.color.r, 0.5, var_49_15)

								iter_49_7.color = Color.New(var_49_19, var_49_19, var_49_19)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_13 + var_49_14 and arg_46_1.time_ < var_49_13 + var_49_14 + arg_49_0 and not isNil(var_49_12) and arg_46_1.var_.actorSpriteComps128404 then
				for iter_49_8, iter_49_9 in pairs(arg_46_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_49_9 then
						if arg_46_1.isInRecall_ then
							iter_49_9.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps128404 = nil
			end

			local var_49_20 = arg_46_1.actors_["104902"].transform
			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1.var_.moveOldPos104902 = var_49_20.localPosition
				var_49_20.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("104902", 2)

				local var_49_22 = var_49_20.childCount

				for iter_49_10 = 0, var_49_22 - 1 do
					local var_49_23 = var_49_20:GetChild(iter_49_10)

					if var_49_23.name == "split_3" or not string.find(var_49_23.name, "split") then
						var_49_23.gameObject:SetActive(true)
					else
						var_49_23.gameObject:SetActive(false)
					end
				end
			end

			local var_49_24 = 0.001

			if var_49_21 <= arg_46_1.time_ and arg_46_1.time_ < var_49_21 + var_49_24 then
				local var_49_25 = (arg_46_1.time_ - var_49_21) / var_49_24
				local var_49_26 = Vector3.New(-390, -335, -360)

				var_49_20.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos104902, var_49_26, var_49_25)
			end

			if arg_46_1.time_ >= var_49_21 + var_49_24 and arg_46_1.time_ < var_49_21 + var_49_24 + arg_49_0 then
				var_49_20.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_49_27 = arg_46_1.actors_["106603"].transform
			local var_49_28 = 0

			if var_49_28 < arg_46_1.time_ and arg_46_1.time_ <= var_49_28 + arg_49_0 then
				arg_46_1.var_.moveOldPos106603 = var_49_27.localPosition
				var_49_27.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("106603", 7)

				local var_49_29 = var_49_27.childCount

				for iter_49_11 = 0, var_49_29 - 1 do
					local var_49_30 = var_49_27:GetChild(iter_49_11)

					if var_49_30.name == "split_1" or not string.find(var_49_30.name, "split") then
						var_49_30.gameObject:SetActive(true)
					else
						var_49_30.gameObject:SetActive(false)
					end
				end
			end

			local var_49_31 = 0.001

			if var_49_28 <= arg_46_1.time_ and arg_46_1.time_ < var_49_28 + var_49_31 then
				local var_49_32 = (arg_46_1.time_ - var_49_28) / var_49_31
				local var_49_33 = Vector3.New(0, -2000, 0)

				var_49_27.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos106603, var_49_33, var_49_32)
			end

			if arg_46_1.time_ >= var_49_28 + var_49_31 and arg_46_1.time_ < var_49_28 + var_49_31 + arg_49_0 then
				var_49_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_34 = 0
			local var_49_35 = 1

			if var_49_34 < arg_46_1.time_ and arg_46_1.time_ <= var_49_34 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_36 = arg_46_1:FormatText(StoryNameCfg[562].name)

				arg_46_1.leftNameTxt_.text = var_49_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_37 = arg_46_1:GetWordFromCfg(938022011)
				local var_49_38 = arg_46_1:FormatText(var_49_37.content)

				arg_46_1.text_.text = var_49_38

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_39 = 40
				local var_49_40 = utf8.len(var_49_38)
				local var_49_41 = var_49_39 <= 0 and var_49_35 or var_49_35 * (var_49_40 / var_49_39)

				if var_49_41 > 0 and var_49_35 < var_49_41 then
					arg_46_1.talkMaxDuration = var_49_41

					if var_49_41 + var_49_34 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_41 + var_49_34
					end
				end

				arg_46_1.text_.text = var_49_38
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_42 = math.max(var_49_35, arg_46_1.talkMaxDuration)

			if var_49_34 <= arg_46_1.time_ and arg_46_1.time_ < var_49_34 + var_49_42 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_34) / var_49_42

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_34 + var_49_42 and arg_46_1.time_ < var_49_34 + var_49_42 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play938022012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938022012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938022013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = "10144"

			if arg_50_1.actors_[var_53_0] == nil then
				local var_53_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_53_1) then
					local var_53_2 = Object.Instantiate(var_53_1, arg_50_1.canvasGo_.transform)

					var_53_2.transform:SetSiblingIndex(1)

					var_53_2.name = var_53_0
					var_53_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_50_1.actors_[var_53_0] = var_53_2

					local var_53_3 = var_53_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_50_1.isInRecall_ then
						for iter_53_0, iter_53_1 in ipairs(var_53_3) do
							iter_53_1.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_53_4 = arg_50_1.actors_["10144"]
			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.actorSpriteComps10144 == nil then
				arg_50_1.var_.actorSpriteComps10144 = var_53_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_6 = 0.2

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 and not isNil(var_53_4) then
				local var_53_7 = (arg_50_1.time_ - var_53_5) / var_53_6

				if arg_50_1.var_.actorSpriteComps10144 then
					for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_53_3 then
							if arg_50_1.isInRecall_ then
								local var_53_8 = Mathf.Lerp(iter_53_3.color.r, arg_50_1.hightColor1.r, var_53_7)
								local var_53_9 = Mathf.Lerp(iter_53_3.color.g, arg_50_1.hightColor1.g, var_53_7)
								local var_53_10 = Mathf.Lerp(iter_53_3.color.b, arg_50_1.hightColor1.b, var_53_7)

								iter_53_3.color = Color.New(var_53_8, var_53_9, var_53_10)
							else
								local var_53_11 = Mathf.Lerp(iter_53_3.color.r, 1, var_53_7)

								iter_53_3.color = Color.New(var_53_11, var_53_11, var_53_11)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.actorSpriteComps10144 then
				for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_53_5 then
						if arg_50_1.isInRecall_ then
							iter_53_5.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10144 = nil
			end

			local var_53_12 = arg_50_1.actors_["104902"]
			local var_53_13 = 0

			if var_53_13 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 and not isNil(var_53_12) and arg_50_1.var_.actorSpriteComps104902 == nil then
				arg_50_1.var_.actorSpriteComps104902 = var_53_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_14 = 0.2

			if var_53_13 <= arg_50_1.time_ and arg_50_1.time_ < var_53_13 + var_53_14 and not isNil(var_53_12) then
				local var_53_15 = (arg_50_1.time_ - var_53_13) / var_53_14

				if arg_50_1.var_.actorSpriteComps104902 then
					for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_53_7 then
							if arg_50_1.isInRecall_ then
								local var_53_16 = Mathf.Lerp(iter_53_7.color.r, arg_50_1.hightColor2.r, var_53_15)
								local var_53_17 = Mathf.Lerp(iter_53_7.color.g, arg_50_1.hightColor2.g, var_53_15)
								local var_53_18 = Mathf.Lerp(iter_53_7.color.b, arg_50_1.hightColor2.b, var_53_15)

								iter_53_7.color = Color.New(var_53_16, var_53_17, var_53_18)
							else
								local var_53_19 = Mathf.Lerp(iter_53_7.color.r, 0.5, var_53_15)

								iter_53_7.color = Color.New(var_53_19, var_53_19, var_53_19)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_13 + var_53_14 and arg_50_1.time_ < var_53_13 + var_53_14 + arg_53_0 and not isNil(var_53_12) and arg_50_1.var_.actorSpriteComps104902 then
				for iter_53_8, iter_53_9 in pairs(arg_50_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_53_9 then
						if arg_50_1.isInRecall_ then
							iter_53_9.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps104902 = nil
			end

			local var_53_20 = arg_50_1.actors_["10144"].transform
			local var_53_21 = 0

			if var_53_21 < arg_50_1.time_ and arg_50_1.time_ <= var_53_21 + arg_53_0 then
				arg_50_1.var_.moveOldPos10144 = var_53_20.localPosition
				var_53_20.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10144", 4)

				local var_53_22 = var_53_20.childCount

				for iter_53_10 = 0, var_53_22 - 1 do
					local var_53_23 = var_53_20:GetChild(iter_53_10)

					if var_53_23.name == "split_5" or not string.find(var_53_23.name, "split") then
						var_53_23.gameObject:SetActive(true)
					else
						var_53_23.gameObject:SetActive(false)
					end
				end
			end

			local var_53_24 = 0.001

			if var_53_21 <= arg_50_1.time_ and arg_50_1.time_ < var_53_21 + var_53_24 then
				local var_53_25 = (arg_50_1.time_ - var_53_21) / var_53_24
				local var_53_26 = Vector3.New(435.8, -381.1, -285.9)

				var_53_20.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10144, var_53_26, var_53_25)
			end

			if arg_50_1.time_ >= var_53_21 + var_53_24 and arg_50_1.time_ < var_53_21 + var_53_24 + arg_53_0 then
				var_53_20.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_53_27 = arg_50_1.actors_["128404"].transform
			local var_53_28 = 0

			if var_53_28 < arg_50_1.time_ and arg_50_1.time_ <= var_53_28 + arg_53_0 then
				arg_50_1.var_.moveOldPos128404 = var_53_27.localPosition
				var_53_27.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("128404", 7)

				local var_53_29 = var_53_27.childCount

				for iter_53_11 = 0, var_53_29 - 1 do
					local var_53_30 = var_53_27:GetChild(iter_53_11)

					if var_53_30.name == "" or not string.find(var_53_30.name, "split") then
						var_53_30.gameObject:SetActive(true)
					else
						var_53_30.gameObject:SetActive(false)
					end
				end
			end

			local var_53_31 = 0.001

			if var_53_28 <= arg_50_1.time_ and arg_50_1.time_ < var_53_28 + var_53_31 then
				local var_53_32 = (arg_50_1.time_ - var_53_28) / var_53_31
				local var_53_33 = Vector3.New(0, -2000, 0)

				var_53_27.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos128404, var_53_33, var_53_32)
			end

			if arg_50_1.time_ >= var_53_28 + var_53_31 and arg_50_1.time_ < var_53_28 + var_53_31 + arg_53_0 then
				var_53_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_34 = 0
			local var_53_35 = 1.45

			if var_53_34 < arg_50_1.time_ and arg_50_1.time_ <= var_53_34 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_36 = arg_50_1:FormatText(StoryNameCfg[1297].name)

				arg_50_1.leftNameTxt_.text = var_53_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_37 = arg_50_1:GetWordFromCfg(938022012)
				local var_53_38 = arg_50_1:FormatText(var_53_37.content)

				arg_50_1.text_.text = var_53_38

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_39 = 58
				local var_53_40 = utf8.len(var_53_38)
				local var_53_41 = var_53_39 <= 0 and var_53_35 or var_53_35 * (var_53_40 / var_53_39)

				if var_53_41 > 0 and var_53_35 < var_53_41 then
					arg_50_1.talkMaxDuration = var_53_41

					if var_53_41 + var_53_34 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_41 + var_53_34
					end
				end

				arg_50_1.text_.text = var_53_38
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_42 = math.max(var_53_35, arg_50_1.talkMaxDuration)

			if var_53_34 <= arg_50_1.time_ and arg_50_1.time_ < var_53_34 + var_53_42 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_34) / var_53_42

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_34 + var_53_42 and arg_50_1.time_ < var_53_34 + var_53_42 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play938022013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938022013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938022014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10144"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10144 == nil then
				arg_54_1.var_.actorSpriteComps10144 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps10144 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								local var_57_4 = Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor2.r, var_57_3)
								local var_57_5 = Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor2.g, var_57_3)
								local var_57_6 = Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor2.b, var_57_3)

								iter_57_1.color = Color.New(var_57_4, var_57_5, var_57_6)
							else
								local var_57_7 = Mathf.Lerp(iter_57_1.color.r, 0.5, var_57_3)

								iter_57_1.color = Color.New(var_57_7, var_57_7, var_57_7)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10144 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10144 = nil
			end

			local var_57_8 = arg_54_1.actors_["10144"].transform
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.var_.moveOldPos10144 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10144", 7)

				local var_57_10 = var_57_8.childCount

				for iter_57_4 = 0, var_57_10 - 1 do
					local var_57_11 = var_57_8:GetChild(iter_57_4)

					if var_57_11.name == "" or not string.find(var_57_11.name, "split") then
						var_57_11.gameObject:SetActive(true)
					else
						var_57_11.gameObject:SetActive(false)
					end
				end
			end

			local var_57_12 = 0.001

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_12 then
				local var_57_13 = (arg_54_1.time_ - var_57_9) / var_57_12
				local var_57_14 = Vector3.New(0, -2000, 0)

				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10144, var_57_14, var_57_13)
			end

			if arg_54_1.time_ >= var_57_9 + var_57_12 and arg_54_1.time_ < var_57_9 + var_57_12 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_57_15 = arg_54_1.actors_["104902"].transform
			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.var_.moveOldPos104902 = var_57_15.localPosition
				var_57_15.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("104902", 7)

				local var_57_17 = var_57_15.childCount

				for iter_57_5 = 0, var_57_17 - 1 do
					local var_57_18 = var_57_15:GetChild(iter_57_5)

					if var_57_18.name == "" or not string.find(var_57_18.name, "split") then
						var_57_18.gameObject:SetActive(true)
					else
						var_57_18.gameObject:SetActive(false)
					end
				end
			end

			local var_57_19 = 0.001

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_19 then
				local var_57_20 = (arg_54_1.time_ - var_57_16) / var_57_19
				local var_57_21 = Vector3.New(0, -2000, -360)

				var_57_15.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos104902, var_57_21, var_57_20)
			end

			if arg_54_1.time_ >= var_57_16 + var_57_19 and arg_54_1.time_ < var_57_16 + var_57_19 + arg_57_0 then
				var_57_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_57_22 = 0
			local var_57_23 = 1.35

			if var_57_22 < arg_54_1.time_ and arg_54_1.time_ <= var_57_22 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_24 = arg_54_1:GetWordFromCfg(938022013)
				local var_57_25 = arg_54_1:FormatText(var_57_24.content)

				arg_54_1.text_.text = var_57_25

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_26 = 54
				local var_57_27 = utf8.len(var_57_25)
				local var_57_28 = var_57_26 <= 0 and var_57_23 or var_57_23 * (var_57_27 / var_57_26)

				if var_57_28 > 0 and var_57_23 < var_57_28 then
					arg_54_1.talkMaxDuration = var_57_28

					if var_57_28 + var_57_22 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_28 + var_57_22
					end
				end

				arg_54_1.text_.text = var_57_25
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_29 = math.max(var_57_23, arg_54_1.talkMaxDuration)

			if var_57_22 <= arg_54_1.time_ and arg_54_1.time_ < var_57_22 + var_57_29 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_22) / var_57_29

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_22 + var_57_29 and arg_54_1.time_ < var_57_22 + var_57_29 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play938022014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938022014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938022015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.175

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(938022014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 7
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_8 and arg_58_1.time_ < var_61_0 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play938022015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938022015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938022016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["128404"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps128404 == nil then
				arg_62_1.var_.actorSpriteComps128404 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps128404 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								local var_65_4 = Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, var_65_3)
								local var_65_5 = Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, var_65_3)
								local var_65_6 = Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, var_65_3)

								iter_65_1.color = Color.New(var_65_4, var_65_5, var_65_6)
							else
								local var_65_7 = Mathf.Lerp(iter_65_1.color.r, 1, var_65_3)

								iter_65_1.color = Color.New(var_65_7, var_65_7, var_65_7)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps128404 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps128404 = nil
			end

			local var_65_8 = arg_62_1.actors_["128404"].transform
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.var_.moveOldPos128404 = var_65_8.localPosition
				var_65_8.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("128404", 2)

				local var_65_10 = var_65_8.childCount

				for iter_65_4 = 0, var_65_10 - 1 do
					local var_65_11 = var_65_8:GetChild(iter_65_4)

					if var_65_11.name == "split_3" or not string.find(var_65_11.name, "split") then
						var_65_11.gameObject:SetActive(true)
					else
						var_65_11.gameObject:SetActive(false)
					end
				end
			end

			local var_65_12 = 0.001

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_9) / var_65_12
				local var_65_14 = Vector3.New(-428.5, -356, -362.3)

				var_65_8.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos128404, var_65_14, var_65_13)
			end

			if arg_62_1.time_ >= var_65_9 + var_65_12 and arg_62_1.time_ < var_65_9 + var_65_12 + arg_65_0 then
				var_65_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_65_15 = 0
			local var_65_16 = 1.25

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[6].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(938022015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 50
				local var_65_21 = utf8.len(var_65_19)
				local var_65_22 = var_65_20 <= 0 and var_65_16 or var_65_16 * (var_65_21 / var_65_20)

				if var_65_22 > 0 and var_65_16 < var_65_22 then
					arg_62_1.talkMaxDuration = var_65_22

					if var_65_22 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_15
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_23 = math.max(var_65_16, arg_62_1.talkMaxDuration)

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_23 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_15) / var_65_23

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_15 + var_65_23 and arg_62_1.time_ < var_65_15 + var_65_23 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play938022016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938022016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938022017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["108301"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps108301 == nil then
				arg_66_1.var_.actorSpriteComps108301 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps108301 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 1, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps108301 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps108301 = nil
			end

			local var_69_8 = arg_66_1.actors_["128404"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps128404 == nil then
				arg_66_1.var_.actorSpriteComps128404 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps128404 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								local var_69_12 = Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, var_69_11)
								local var_69_13 = Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, var_69_11)
								local var_69_14 = Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, var_69_11)

								iter_69_5.color = Color.New(var_69_12, var_69_13, var_69_14)
							else
								local var_69_15 = Mathf.Lerp(iter_69_5.color.r, 0.5, var_69_11)

								iter_69_5.color = Color.New(var_69_15, var_69_15, var_69_15)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps128404 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps128404 = nil
			end

			local var_69_16 = arg_66_1.actors_["108301"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos108301 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("108301", 4)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "split_1" or not string.find(var_69_19.name, "split") then
						var_69_19.gameObject:SetActive(true)
					else
						var_69_19.gameObject:SetActive(false)
					end
				end
			end

			local var_69_20 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(460, -360, -195)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos108301, var_69_22, var_69_21)
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_69_23 = 0
			local var_69_24 = 1.175

			if var_69_23 < arg_66_1.time_ and arg_66_1.time_ <= var_69_23 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_25 = arg_66_1:FormatText(StoryNameCfg[1332].name)

				arg_66_1.leftNameTxt_.text = var_69_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_26 = arg_66_1:GetWordFromCfg(938022016)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.text_.text = var_69_27

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_28 = 47
				local var_69_29 = utf8.len(var_69_27)
				local var_69_30 = var_69_28 <= 0 and var_69_24 or var_69_24 * (var_69_29 / var_69_28)

				if var_69_30 > 0 and var_69_24 < var_69_30 then
					arg_66_1.talkMaxDuration = var_69_30

					if var_69_30 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_30 + var_69_23
					end
				end

				arg_66_1.text_.text = var_69_27
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_31 = math.max(var_69_24, arg_66_1.talkMaxDuration)

			if var_69_23 <= arg_66_1.time_ and arg_66_1.time_ < var_69_23 + var_69_31 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_23) / var_69_31

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_23 + var_69_31 and arg_66_1.time_ < var_69_23 + var_69_31 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play938022017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 938022017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play938022018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["128404"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps128404 == nil then
				arg_70_1.var_.actorSpriteComps128404 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps128404 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps128404 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps128404 = nil
			end

			local var_73_8 = arg_70_1.actors_["108301"]
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps108301 == nil then
				arg_70_1.var_.actorSpriteComps108301 = var_73_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_10 = 0.2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 and not isNil(var_73_8) then
				local var_73_11 = (arg_70_1.time_ - var_73_9) / var_73_10

				if arg_70_1.var_.actorSpriteComps108301 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_12 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, var_73_11)
								local var_73_13 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, var_73_11)
								local var_73_14 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, var_73_11)

								iter_73_5.color = Color.New(var_73_12, var_73_13, var_73_14)
							else
								local var_73_15 = Mathf.Lerp(iter_73_5.color.r, 0.5, var_73_11)

								iter_73_5.color = Color.New(var_73_15, var_73_15, var_73_15)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps108301 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps108301 = nil
			end

			local var_73_16 = arg_70_1.actors_["128404"].transform
			local var_73_17 = 0

			if var_73_17 < arg_70_1.time_ and arg_70_1.time_ <= var_73_17 + arg_73_0 then
				arg_70_1.var_.moveOldPos128404 = var_73_16.localPosition
				var_73_16.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("128404", 2)

				local var_73_18 = var_73_16.childCount

				for iter_73_8 = 0, var_73_18 - 1 do
					local var_73_19 = var_73_16:GetChild(iter_73_8)

					if var_73_19.name == "split_4" then
						var_73_19:SetAsLastSibling()
						var_73_19.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit128404 = var_73_19.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit128404:SetAlpha(0)
					end
				end
			end

			local var_73_20 = 0.5

			if var_73_17 <= arg_70_1.time_ and arg_70_1.time_ < var_73_17 + var_73_20 then
				local var_73_21 = (arg_70_1.time_ - var_73_17) / var_73_20
				local var_73_22 = Vector3.New(-428.5, -356, -362.3)

				var_73_16.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos128404, var_73_22, var_73_21)

				if arg_70_1.var_.actorSpriteSplit128404 ~= nil then
					arg_70_1.var_.actorSpriteSplit128404:SetAlpha(var_73_21)
				end
			end

			if arg_70_1.time_ >= var_73_17 + var_73_20 and arg_70_1.time_ < var_73_17 + var_73_20 + arg_73_0 then
				var_73_16.localPosition = Vector3.New(-428.5, -356, -362.3)

				if arg_70_1.var_.actorSpriteSplit128404 ~= nil then
					arg_70_1.var_.actorSpriteSplit128404:SetAlpha(1)
				end
			end

			local var_73_23 = 0
			local var_73_24 = 0.75

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_25 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_26 = arg_70_1:GetWordFromCfg(938022017)
				local var_73_27 = arg_70_1:FormatText(var_73_26.content)

				arg_70_1.text_.text = var_73_27

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_28 = 30
				local var_73_29 = utf8.len(var_73_27)
				local var_73_30 = var_73_28 <= 0 and var_73_24 or var_73_24 * (var_73_29 / var_73_28)

				if var_73_30 > 0 and var_73_24 < var_73_30 then
					arg_70_1.talkMaxDuration = var_73_30

					if var_73_30 + var_73_23 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_30 + var_73_23
					end
				end

				arg_70_1.text_.text = var_73_27
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_31 = math.max(var_73_24, arg_70_1.talkMaxDuration)

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_31 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_23) / var_73_31

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_23 + var_73_31 and arg_70_1.time_ < var_73_23 + var_73_31 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play938022018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 938022018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play938022019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["128404"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps128404 == nil then
				arg_74_1.var_.actorSpriteComps128404 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps128404 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 0.5, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps128404 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps128404 = nil
			end

			local var_77_8 = 0
			local var_77_9 = 1.125

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_10 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_11 = arg_74_1:GetWordFromCfg(938022018)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 45
				local var_77_14 = utf8.len(var_77_12)
				local var_77_15 = var_77_13 <= 0 and var_77_9 or var_77_9 * (var_77_14 / var_77_13)

				if var_77_15 > 0 and var_77_9 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_12
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play938022019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938022019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938022020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["106603"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps106603 == nil then
				arg_78_1.var_.actorSpriteComps106603 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps106603 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps106603 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps106603 = nil
			end

			local var_81_8 = arg_78_1.actors_["106603"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos106603 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("106603", 3)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "" or not string.find(var_81_11.name, "split") then
						var_81_11.gameObject:SetActive(true)
					else
						var_81_11.gameObject:SetActive(false)
					end
				end
			end

			local var_81_12 = 0.001

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos106603, var_81_14, var_81_13)
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_81_15 = arg_78_1.actors_["128404"].transform
			local var_81_16 = 0

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.var_.moveOldPos128404 = var_81_15.localPosition
				var_81_15.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("128404", 7)

				local var_81_17 = var_81_15.childCount

				for iter_81_5 = 0, var_81_17 - 1 do
					local var_81_18 = var_81_15:GetChild(iter_81_5)

					if var_81_18.name == "" or not string.find(var_81_18.name, "split") then
						var_81_18.gameObject:SetActive(true)
					else
						var_81_18.gameObject:SetActive(false)
					end
				end
			end

			local var_81_19 = 0.001

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_19 then
				local var_81_20 = (arg_78_1.time_ - var_81_16) / var_81_19
				local var_81_21 = Vector3.New(0, -2000, 0)

				var_81_15.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos128404, var_81_21, var_81_20)
			end

			if arg_78_1.time_ >= var_81_16 + var_81_19 and arg_78_1.time_ < var_81_16 + var_81_19 + arg_81_0 then
				var_81_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_22 = arg_78_1.actors_["108301"].transform
			local var_81_23 = 0

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.var_.moveOldPos108301 = var_81_22.localPosition
				var_81_22.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("108301", 7)

				local var_81_24 = var_81_22.childCount

				for iter_81_6 = 0, var_81_24 - 1 do
					local var_81_25 = var_81_22:GetChild(iter_81_6)

					if var_81_25.name == "" or not string.find(var_81_25.name, "split") then
						var_81_25.gameObject:SetActive(true)
					else
						var_81_25.gameObject:SetActive(false)
					end
				end
			end

			local var_81_26 = 0.001

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_26 then
				local var_81_27 = (arg_78_1.time_ - var_81_23) / var_81_26
				local var_81_28 = Vector3.New(0, -2000, 0)

				var_81_22.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos108301, var_81_28, var_81_27)
			end

			if arg_78_1.time_ >= var_81_23 + var_81_26 and arg_78_1.time_ < var_81_23 + var_81_26 + arg_81_0 then
				var_81_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_29 = 0
			local var_81_30 = 0.525

			if var_81_29 < arg_78_1.time_ and arg_78_1.time_ <= var_81_29 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_31 = arg_78_1:FormatText(StoryNameCfg[32].name)

				arg_78_1.leftNameTxt_.text = var_81_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_32 = arg_78_1:GetWordFromCfg(938022019)
				local var_81_33 = arg_78_1:FormatText(var_81_32.content)

				arg_78_1.text_.text = var_81_33

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_34 = 21
				local var_81_35 = utf8.len(var_81_33)
				local var_81_36 = var_81_34 <= 0 and var_81_30 or var_81_30 * (var_81_35 / var_81_34)

				if var_81_36 > 0 and var_81_30 < var_81_36 then
					arg_78_1.talkMaxDuration = var_81_36

					if var_81_36 + var_81_29 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_36 + var_81_29
					end
				end

				arg_78_1.text_.text = var_81_33
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_37 = math.max(var_81_30, arg_78_1.talkMaxDuration)

			if var_81_29 <= arg_78_1.time_ and arg_78_1.time_ < var_81_29 + var_81_37 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_29) / var_81_37

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_29 + var_81_37 and arg_78_1.time_ < var_81_29 + var_81_37 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play938022020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938022020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938022021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["106603"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps106603 == nil then
				arg_82_1.var_.actorSpriteComps106603 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps106603 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 0.5, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps106603 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps106603 = nil
			end

			local var_85_8 = 0
			local var_85_9 = 1.325

			if var_85_8 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(938022020)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_12 = 53
				local var_85_13 = utf8.len(var_85_11)
				local var_85_14 = var_85_12 <= 0 and var_85_9 or var_85_9 * (var_85_13 / var_85_12)

				if var_85_14 > 0 and var_85_9 < var_85_14 then
					arg_82_1.talkMaxDuration = var_85_14

					if var_85_14 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_15 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_15 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_15

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_15 and arg_82_1.time_ < var_85_8 + var_85_15 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play938022021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938022021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938022022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10144"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10144 == nil then
				arg_86_1.var_.actorSpriteComps10144 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10144 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 1, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10144 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10144 = nil
			end

			local var_89_8 = arg_86_1.actors_["10144"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos10144 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10144", 3)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "split_2" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10144, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_89_15 = 0
			local var_89_16 = 1.225

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[1297].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(938022021)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 49
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_23 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_23 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_23

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_23 and arg_86_1.time_ < var_89_15 + var_89_23 + arg_89_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play938022022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938022022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938022023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10144"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos10144 = var_93_0.localPosition
				var_93_0.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("10144", 3)

				local var_93_2 = var_93_0.childCount

				for iter_93_0 = 0, var_93_2 - 1 do
					local var_93_3 = var_93_0:GetChild(iter_93_0)

					if var_93_3.name == "" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_4 then
				local var_93_5 = (arg_90_1.time_ - var_93_1) / var_93_4
				local var_93_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10144, var_93_6, var_93_5)
			end

			if arg_90_1.time_ >= var_93_1 + var_93_4 and arg_90_1.time_ < var_93_1 + var_93_4 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_93_7 = 0
			local var_93_8 = 1.025

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_9 = arg_90_1:FormatText(StoryNameCfg[1297].name)

				arg_90_1.leftNameTxt_.text = var_93_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(938022022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_12 = 41
				local var_93_13 = utf8.len(var_93_11)
				local var_93_14 = var_93_12 <= 0 and var_93_8 or var_93_8 * (var_93_13 / var_93_12)

				if var_93_14 > 0 and var_93_8 < var_93_14 then
					arg_90_1.talkMaxDuration = var_93_14

					if var_93_14 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_7
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_15 = math.max(var_93_8, arg_90_1.talkMaxDuration)

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_15 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_7) / var_93_15

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_7 + var_93_15 and arg_90_1.time_ < var_93_7 + var_93_15 + arg_93_0 then
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
	Play938022023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938022023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938022024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10144"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps10144 == nil then
				arg_94_1.var_.actorSpriteComps10144 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps10144 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 0.5, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps10144 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps10144 = nil
			end

			local var_97_8 = 0
			local var_97_9 = 0.125

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_10 = arg_94_1:FormatText(StoryNameCfg[330].name)

				arg_94_1.leftNameTxt_.text = var_97_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_11 = arg_94_1:GetWordFromCfg(938022023)
				local var_97_12 = arg_94_1:FormatText(var_97_11.content)

				arg_94_1.text_.text = var_97_12

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 5
				local var_97_14 = utf8.len(var_97_12)
				local var_97_15 = var_97_13 <= 0 and var_97_9 or var_97_9 * (var_97_14 / var_97_13)

				if var_97_15 > 0 and var_97_9 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_12
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play938022024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938022024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938022025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["108301"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps108301 == nil then
				arg_98_1.var_.actorSpriteComps108301 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps108301 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 1, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps108301 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps108301 = nil
			end

			local var_101_8 = arg_98_1.actors_["108301"].transform
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.var_.moveOldPos108301 = var_101_8.localPosition
				var_101_8.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("108301", 2)

				local var_101_10 = var_101_8.childCount

				for iter_101_4 = 0, var_101_10 - 1 do
					local var_101_11 = var_101_8:GetChild(iter_101_4)

					if var_101_11.name == "split_2" or not string.find(var_101_11.name, "split") then
						var_101_11.gameObject:SetActive(true)
					else
						var_101_11.gameObject:SetActive(false)
					end
				end
			end

			local var_101_12 = 0.001

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_9) / var_101_12
				local var_101_14 = Vector3.New(-420, -360, -195)

				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos108301, var_101_14, var_101_13)
			end

			if arg_98_1.time_ >= var_101_9 + var_101_12 and arg_98_1.time_ < var_101_9 + var_101_12 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(-420, -360, -195)
			end

			local var_101_15 = arg_98_1.actors_["10144"].transform
			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.var_.moveOldPos10144 = var_101_15.localPosition
				var_101_15.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("10144", 7)

				local var_101_17 = var_101_15.childCount

				for iter_101_5 = 0, var_101_17 - 1 do
					local var_101_18 = var_101_15:GetChild(iter_101_5)

					if var_101_18.name == "" or not string.find(var_101_18.name, "split") then
						var_101_18.gameObject:SetActive(true)
					else
						var_101_18.gameObject:SetActive(false)
					end
				end
			end

			local var_101_19 = 0.001

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_19 then
				local var_101_20 = (arg_98_1.time_ - var_101_16) / var_101_19
				local var_101_21 = Vector3.New(0, -2000, 0)

				var_101_15.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10144, var_101_21, var_101_20)
			end

			if arg_98_1.time_ >= var_101_16 + var_101_19 and arg_98_1.time_ < var_101_16 + var_101_19 + arg_101_0 then
				var_101_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_101_22 = 0
			local var_101_23 = 0.2

			if var_101_22 < arg_98_1.time_ and arg_98_1.time_ <= var_101_22 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_24 = arg_98_1:FormatText(StoryNameCfg[1332].name)

				arg_98_1.leftNameTxt_.text = var_101_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_25 = arg_98_1:GetWordFromCfg(938022024)
				local var_101_26 = arg_98_1:FormatText(var_101_25.content)

				arg_98_1.text_.text = var_101_26

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_27 = 8
				local var_101_28 = utf8.len(var_101_26)
				local var_101_29 = var_101_27 <= 0 and var_101_23 or var_101_23 * (var_101_28 / var_101_27)

				if var_101_29 > 0 and var_101_23 < var_101_29 then
					arg_98_1.talkMaxDuration = var_101_29

					if var_101_29 + var_101_22 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_29 + var_101_22
					end
				end

				arg_98_1.text_.text = var_101_26
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_30 = math.max(var_101_23, arg_98_1.talkMaxDuration)

			if var_101_22 <= arg_98_1.time_ and arg_98_1.time_ < var_101_22 + var_101_30 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_22) / var_101_30

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_22 + var_101_30 and arg_98_1.time_ < var_101_22 + var_101_30 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play938022025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938022025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938022026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10144"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10144 == nil then
				arg_102_1.var_.actorSpriteComps10144 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps10144 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 1, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10144 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps10144 = nil
			end

			local var_105_8 = arg_102_1.actors_["108301"]
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps108301 == nil then
				arg_102_1.var_.actorSpriteComps108301 = var_105_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_10 = 0.2

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 and not isNil(var_105_8) then
				local var_105_11 = (arg_102_1.time_ - var_105_9) / var_105_10

				if arg_102_1.var_.actorSpriteComps108301 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								local var_105_12 = Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, var_105_11)
								local var_105_13 = Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, var_105_11)
								local var_105_14 = Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, var_105_11)

								iter_105_5.color = Color.New(var_105_12, var_105_13, var_105_14)
							else
								local var_105_15 = Mathf.Lerp(iter_105_5.color.r, 0.5, var_105_11)

								iter_105_5.color = Color.New(var_105_15, var_105_15, var_105_15)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps108301 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_105_7 then
						if arg_102_1.isInRecall_ then
							iter_105_7.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps108301 = nil
			end

			local var_105_16 = arg_102_1.actors_["10144"].transform
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.var_.moveOldPos10144 = var_105_16.localPosition
				var_105_16.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("10144", 4)

				local var_105_18 = var_105_16.childCount

				for iter_105_8 = 0, var_105_18 - 1 do
					local var_105_19 = var_105_16:GetChild(iter_105_8)

					if var_105_19.name == "" or not string.find(var_105_19.name, "split") then
						var_105_19.gameObject:SetActive(true)
					else
						var_105_19.gameObject:SetActive(false)
					end
				end
			end

			local var_105_20 = 0.001

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_20 then
				local var_105_21 = (arg_102_1.time_ - var_105_17) / var_105_20
				local var_105_22 = Vector3.New(435.8, -381.1, -285.9)

				var_105_16.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10144, var_105_22, var_105_21)
			end

			if arg_102_1.time_ >= var_105_17 + var_105_20 and arg_102_1.time_ < var_105_17 + var_105_20 + arg_105_0 then
				var_105_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_105_23 = 0
			local var_105_24 = 1.125

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_25 = arg_102_1:FormatText(StoryNameCfg[1297].name)

				arg_102_1.leftNameTxt_.text = var_105_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_26 = arg_102_1:GetWordFromCfg(938022025)
				local var_105_27 = arg_102_1:FormatText(var_105_26.content)

				arg_102_1.text_.text = var_105_27

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_28 = 45
				local var_105_29 = utf8.len(var_105_27)
				local var_105_30 = var_105_28 <= 0 and var_105_24 or var_105_24 * (var_105_29 / var_105_28)

				if var_105_30 > 0 and var_105_24 < var_105_30 then
					arg_102_1.talkMaxDuration = var_105_30

					if var_105_30 + var_105_23 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_30 + var_105_23
					end
				end

				arg_102_1.text_.text = var_105_27
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_24, arg_102_1.talkMaxDuration)

			if var_105_23 <= arg_102_1.time_ and arg_102_1.time_ < var_105_23 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_23) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_23 + var_105_31 and arg_102_1.time_ < var_105_23 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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

		arg_102_1:InitPlayNodeList()
	end,
	Play938022026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938022026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938022027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10144"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10144 == nil then
				arg_106_1.var_.actorSpriteComps10144 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps10144 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor2.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor2.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor2.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 0.5, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10144 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10144 = nil
			end

			local var_109_8 = arg_106_1.actors_["10144"].transform
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 then
				arg_106_1.var_.moveOldPos10144 = var_109_8.localPosition
				var_109_8.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("10144", 7)

				local var_109_10 = var_109_8.childCount

				for iter_109_4 = 0, var_109_10 - 1 do
					local var_109_11 = var_109_8:GetChild(iter_109_4)

					if var_109_11.name == "" or not string.find(var_109_11.name, "split") then
						var_109_11.gameObject:SetActive(true)
					else
						var_109_11.gameObject:SetActive(false)
					end
				end
			end

			local var_109_12 = 0.001

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_12 then
				local var_109_13 = (arg_106_1.time_ - var_109_9) / var_109_12
				local var_109_14 = Vector3.New(0, -2000, 0)

				var_109_8.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10144, var_109_14, var_109_13)
			end

			if arg_106_1.time_ >= var_109_9 + var_109_12 and arg_106_1.time_ < var_109_9 + var_109_12 + arg_109_0 then
				var_109_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_109_15 = arg_106_1.actors_["108301"].transform
			local var_109_16 = 0

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_15.localPosition
				var_109_15.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 7)

				local var_109_17 = var_109_15.childCount

				for iter_109_5 = 0, var_109_17 - 1 do
					local var_109_18 = var_109_15:GetChild(iter_109_5)

					if var_109_18.name == "" or not string.find(var_109_18.name, "split") then
						var_109_18.gameObject:SetActive(true)
					else
						var_109_18.gameObject:SetActive(false)
					end
				end
			end

			local var_109_19 = 0.001

			if var_109_16 <= arg_106_1.time_ and arg_106_1.time_ < var_109_16 + var_109_19 then
				local var_109_20 = (arg_106_1.time_ - var_109_16) / var_109_19
				local var_109_21 = Vector3.New(0, -2000, 0)

				var_109_15.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, var_109_21, var_109_20)
			end

			if arg_106_1.time_ >= var_109_16 + var_109_19 and arg_106_1.time_ < var_109_16 + var_109_19 + arg_109_0 then
				var_109_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_109_22 = 0
			local var_109_23 = 1.575

			if var_109_22 < arg_106_1.time_ and arg_106_1.time_ <= var_109_22 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_24 = arg_106_1:GetWordFromCfg(938022026)
				local var_109_25 = arg_106_1:FormatText(var_109_24.content)

				arg_106_1.text_.text = var_109_25

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_26 = 63
				local var_109_27 = utf8.len(var_109_25)
				local var_109_28 = var_109_26 <= 0 and var_109_23 or var_109_23 * (var_109_27 / var_109_26)

				if var_109_28 > 0 and var_109_23 < var_109_28 then
					arg_106_1.talkMaxDuration = var_109_28

					if var_109_28 + var_109_22 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_28 + var_109_22
					end
				end

				arg_106_1.text_.text = var_109_25
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_29 = math.max(var_109_23, arg_106_1.talkMaxDuration)

			if var_109_22 <= arg_106_1.time_ and arg_106_1.time_ < var_109_22 + var_109_29 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_22) / var_109_29

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_22 + var_109_29 and arg_106_1.time_ < var_109_22 + var_109_29 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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
				actorName = "108301",
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
	Play938022027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938022027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938022028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["108301"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 1, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_8 = arg_110_1.actors_["108301"].transform
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.var_.moveOldPos108301 = var_113_8.localPosition
				var_113_8.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("108301", 3)

				local var_113_10 = var_113_8.childCount

				for iter_113_4 = 0, var_113_10 - 1 do
					local var_113_11 = var_113_8:GetChild(iter_113_4)

					if var_113_11.name == "split_3" or not string.find(var_113_11.name, "split") then
						var_113_11.gameObject:SetActive(true)
					else
						var_113_11.gameObject:SetActive(false)
					end
				end
			end

			local var_113_12 = 0.001

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_12 then
				local var_113_13 = (arg_110_1.time_ - var_113_9) / var_113_12
				local var_113_14 = Vector3.New(0, -360, -195)

				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos108301, var_113_14, var_113_13)
			end

			if arg_110_1.time_ >= var_113_9 + var_113_12 and arg_110_1.time_ < var_113_9 + var_113_12 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_113_15 = 0
			local var_113_16 = 0.55

			if var_113_15 < arg_110_1.time_ and arg_110_1.time_ <= var_113_15 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_17 = arg_110_1:FormatText(StoryNameCfg[1332].name)

				arg_110_1.leftNameTxt_.text = var_113_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_18 = arg_110_1:GetWordFromCfg(938022027)
				local var_113_19 = arg_110_1:FormatText(var_113_18.content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_20 = 22
				local var_113_21 = utf8.len(var_113_19)
				local var_113_22 = var_113_20 <= 0 and var_113_16 or var_113_16 * (var_113_21 / var_113_20)

				if var_113_22 > 0 and var_113_16 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22

					if var_113_22 + var_113_15 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_15
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_23 = math.max(var_113_16, arg_110_1.talkMaxDuration)

			if var_113_15 <= arg_110_1.time_ and arg_110_1.time_ < var_113_15 + var_113_23 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_15) / var_113_23

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_15 + var_113_23 and arg_110_1.time_ < var_113_15 + var_113_23 + arg_113_0 then
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
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play938022028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938022028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938022029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["108301"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_0.localPosition
				var_117_0.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 3)

				local var_117_2 = var_117_0.childCount

				for iter_117_0 = 0, var_117_2 - 1 do
					local var_117_3 = var_117_0:GetChild(iter_117_0)

					if var_117_3.name == "split_2" then
						var_117_3:SetAsLastSibling()
						var_117_3.gameObject:SetActive(true)

						arg_114_1.var_.actorSpriteSplit108301 = var_117_3.gameObject:GetComponent(typeof(Image))

						arg_114_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_117_4 = 0.5

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_4 then
				local var_117_5 = (arg_114_1.time_ - var_117_1) / var_117_4
				local var_117_6 = Vector3.New(0, -360, -195)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, var_117_6, var_117_5)

				if arg_114_1.var_.actorSpriteSplit108301 ~= nil then
					arg_114_1.var_.actorSpriteSplit108301:SetAlpha(var_117_5)
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_4 and arg_114_1.time_ < var_117_1 + var_117_4 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, -360, -195)

				if arg_114_1.var_.actorSpriteSplit108301 ~= nil then
					arg_114_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_117_7 = 0
			local var_117_8 = 1.025

			if var_117_7 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_9 = arg_114_1:FormatText(StoryNameCfg[1332].name)

				arg_114_1.leftNameTxt_.text = var_117_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_10 = arg_114_1:GetWordFromCfg(938022028)
				local var_117_11 = arg_114_1:FormatText(var_117_10.content)

				arg_114_1.text_.text = var_117_11

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_12 = 41
				local var_117_13 = utf8.len(var_117_11)
				local var_117_14 = var_117_12 <= 0 and var_117_8 or var_117_8 * (var_117_13 / var_117_12)

				if var_117_14 > 0 and var_117_8 < var_117_14 then
					arg_114_1.talkMaxDuration = var_117_14

					if var_117_14 + var_117_7 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_14 + var_117_7
					end
				end

				arg_114_1.text_.text = var_117_11
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_15 = math.max(var_117_8, arg_114_1.talkMaxDuration)

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_15 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_7) / var_117_15

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_7 + var_117_15 and arg_114_1.time_ < var_117_7 + var_117_15 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play938022029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938022029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938022030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["108301"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps108301 == nil then
				arg_118_1.var_.actorSpriteComps108301 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps108301 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps108301 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps108301 = nil
			end

			local var_121_8 = 0
			local var_121_9 = 1.375

			if var_121_8 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_11 = arg_118_1:GetWordFromCfg(938022029)
				local var_121_12 = arg_118_1:FormatText(var_121_11.content)

				arg_118_1.text_.text = var_121_12

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 55
				local var_121_14 = utf8.len(var_121_12)
				local var_121_15 = var_121_13 <= 0 and var_121_9 or var_121_9 * (var_121_14 / var_121_13)

				if var_121_15 > 0 and var_121_9 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_12
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play938022030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938022030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938022031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["108301"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps108301 == nil then
				arg_122_1.var_.actorSpriteComps108301 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps108301 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 1, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps108301 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps108301 = nil
			end

			local var_125_8 = arg_122_1.actors_["108301"].transform
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.var_.moveOldPos108301 = var_125_8.localPosition
				var_125_8.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("108301", 3)

				local var_125_10 = var_125_8.childCount

				for iter_125_4 = 0, var_125_10 - 1 do
					local var_125_11 = var_125_8:GetChild(iter_125_4)

					if var_125_11.name == "split_5" then
						var_125_11:SetAsLastSibling()
						var_125_11.gameObject:SetActive(true)

						arg_122_1.var_.actorSpriteSplit108301 = var_125_11.gameObject:GetComponent(typeof(Image))

						arg_122_1.var_.actorSpriteSplit108301:SetAlpha(0)
					end
				end
			end

			local var_125_12 = 0.5

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_12 then
				local var_125_13 = (arg_122_1.time_ - var_125_9) / var_125_12
				local var_125_14 = Vector3.New(0, -360, -195)

				var_125_8.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos108301, var_125_14, var_125_13)

				if arg_122_1.var_.actorSpriteSplit108301 ~= nil then
					arg_122_1.var_.actorSpriteSplit108301:SetAlpha(var_125_13)
				end
			end

			if arg_122_1.time_ >= var_125_9 + var_125_12 and arg_122_1.time_ < var_125_9 + var_125_12 + arg_125_0 then
				var_125_8.localPosition = Vector3.New(0, -360, -195)

				if arg_122_1.var_.actorSpriteSplit108301 ~= nil then
					arg_122_1.var_.actorSpriteSplit108301:SetAlpha(1)
				end
			end

			local var_125_15 = 0
			local var_125_16 = 1.1

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[1332].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:GetWordFromCfg(938022030)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 44
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_23 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_23 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_23

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_23 and arg_122_1.time_ < var_125_15 + var_125_23 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play938022031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938022031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938022032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["108301"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps108301 == nil then
				arg_126_1.var_.actorSpriteComps108301 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps108301 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								local var_129_4 = Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, var_129_3)
								local var_129_5 = Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, var_129_3)
								local var_129_6 = Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, var_129_3)

								iter_129_1.color = Color.New(var_129_4, var_129_5, var_129_6)
							else
								local var_129_7 = Mathf.Lerp(iter_129_1.color.r, 0.5, var_129_3)

								iter_129_1.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps108301 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps108301 = nil
			end

			local var_129_8 = 0
			local var_129_9 = 1.6

			if var_129_8 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_10 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_11 = arg_126_1:GetWordFromCfg(938022031)
				local var_129_12 = arg_126_1:FormatText(var_129_11.content)

				arg_126_1.text_.text = var_129_12

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 64
				local var_129_14 = utf8.len(var_129_12)
				local var_129_15 = var_129_13 <= 0 and var_129_9 or var_129_9 * (var_129_14 / var_129_13)

				if var_129_15 > 0 and var_129_9 < var_129_15 then
					arg_126_1.talkMaxDuration = var_129_15

					if var_129_15 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_15 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_12
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play938022032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938022032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938022033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["108301"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps108301 == nil then
				arg_130_1.var_.actorSpriteComps108301 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps108301 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 1, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps108301 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_133_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps108301 = nil
			end

			local var_133_8 = arg_130_1.actors_["108301"].transform
			local var_133_9 = 0

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.var_.moveOldPos108301 = var_133_8.localPosition
				var_133_8.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("108301", 3)

				local var_133_10 = var_133_8.childCount

				for iter_133_4 = 0, var_133_10 - 1 do
					local var_133_11 = var_133_8:GetChild(iter_133_4)

					if var_133_11.name == "split_5" or not string.find(var_133_11.name, "split") then
						var_133_11.gameObject:SetActive(true)
					else
						var_133_11.gameObject:SetActive(false)
					end
				end
			end

			local var_133_12 = 0.001

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_12 then
				local var_133_13 = (arg_130_1.time_ - var_133_9) / var_133_12
				local var_133_14 = Vector3.New(0, -360, -195)

				var_133_8.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos108301, var_133_14, var_133_13)
			end

			if arg_130_1.time_ >= var_133_9 + var_133_12 and arg_130_1.time_ < var_133_9 + var_133_12 + arg_133_0 then
				var_133_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_133_15 = 0
			local var_133_16 = 0.75

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_17 = arg_130_1:FormatText(StoryNameCfg[1332].name)

				arg_130_1.leftNameTxt_.text = var_133_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_18 = arg_130_1:GetWordFromCfg(938022032)
				local var_133_19 = arg_130_1:FormatText(var_133_18.content)

				arg_130_1.text_.text = var_133_19

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_20 = 30
				local var_133_21 = utf8.len(var_133_19)
				local var_133_22 = var_133_20 <= 0 and var_133_16 or var_133_16 * (var_133_21 / var_133_20)

				if var_133_22 > 0 and var_133_16 < var_133_22 then
					arg_130_1.talkMaxDuration = var_133_22

					if var_133_22 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_22 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_19
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_23 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_23 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_15) / var_133_23

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_15 + var_133_23 and arg_130_1.time_ < var_133_15 + var_133_23 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play938022033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 938022033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play938022034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["108301"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps108301 == nil then
				arg_134_1.var_.actorSpriteComps108301 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps108301 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor2.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor2.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor2.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 0.5, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps108301 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps108301 = nil
			end

			local var_137_8 = 0
			local var_137_9 = 1

			if var_137_8 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_10 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_11 = arg_134_1:GetWordFromCfg(938022033)
				local var_137_12 = arg_134_1:FormatText(var_137_11.content)

				arg_134_1.text_.text = var_137_12

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 40
				local var_137_14 = utf8.len(var_137_12)
				local var_137_15 = var_137_13 <= 0 and var_137_9 or var_137_9 * (var_137_14 / var_137_13)

				if var_137_15 > 0 and var_137_9 < var_137_15 then
					arg_134_1.talkMaxDuration = var_137_15

					if var_137_15 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_8
					end
				end

				arg_134_1.text_.text = var_137_12
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_9, arg_134_1.talkMaxDuration)

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_8) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_8 + var_137_16 and arg_134_1.time_ < var_137_8 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play938022034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 938022034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play938022035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10144"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10144 == nil then
				arg_138_1.var_.actorSpriteComps10144 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps10144 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 1, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10144 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10144 = nil
			end

			local var_141_8 = arg_138_1.actors_["108301"].transform
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.var_.moveOldPos108301 = var_141_8.localPosition
				var_141_8.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("108301", 7)

				local var_141_10 = var_141_8.childCount

				for iter_141_4 = 0, var_141_10 - 1 do
					local var_141_11 = var_141_8:GetChild(iter_141_4)

					if var_141_11.name == "" or not string.find(var_141_11.name, "split") then
						var_141_11.gameObject:SetActive(true)
					else
						var_141_11.gameObject:SetActive(false)
					end
				end
			end

			local var_141_12 = 0.001

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_9) / var_141_12
				local var_141_14 = Vector3.New(0, -2000, 0)

				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos108301, var_141_14, var_141_13)
			end

			if arg_138_1.time_ >= var_141_9 + var_141_12 and arg_138_1.time_ < var_141_9 + var_141_12 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_141_15 = arg_138_1.actors_["10144"].transform
			local var_141_16 = 0

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.var_.moveOldPos10144 = var_141_15.localPosition
				var_141_15.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10144", 3)

				local var_141_17 = var_141_15.childCount

				for iter_141_5 = 0, var_141_17 - 1 do
					local var_141_18 = var_141_15:GetChild(iter_141_5)

					if var_141_18.name == "split_2" or not string.find(var_141_18.name, "split") then
						var_141_18.gameObject:SetActive(true)
					else
						var_141_18.gameObject:SetActive(false)
					end
				end
			end

			local var_141_19 = 0.001

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_19 then
				local var_141_20 = (arg_138_1.time_ - var_141_16) / var_141_19
				local var_141_21 = Vector3.New(-31.5, -381.1, -285.9)

				var_141_15.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10144, var_141_21, var_141_20)
			end

			if arg_138_1.time_ >= var_141_16 + var_141_19 and arg_138_1.time_ < var_141_16 + var_141_19 + arg_141_0 then
				var_141_15.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_141_22 = 0
			local var_141_23 = 0.875

			if var_141_22 < arg_138_1.time_ and arg_138_1.time_ <= var_141_22 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_24 = arg_138_1:FormatText(StoryNameCfg[1297].name)

				arg_138_1.leftNameTxt_.text = var_141_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_25 = arg_138_1:GetWordFromCfg(938022034)
				local var_141_26 = arg_138_1:FormatText(var_141_25.content)

				arg_138_1.text_.text = var_141_26

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_27 = 35
				local var_141_28 = utf8.len(var_141_26)
				local var_141_29 = var_141_27 <= 0 and var_141_23 or var_141_23 * (var_141_28 / var_141_27)

				if var_141_29 > 0 and var_141_23 < var_141_29 then
					arg_138_1.talkMaxDuration = var_141_29

					if var_141_29 + var_141_22 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_29 + var_141_22
					end
				end

				arg_138_1.text_.text = var_141_26
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_30 = math.max(var_141_23, arg_138_1.talkMaxDuration)

			if var_141_22 <= arg_138_1.time_ and arg_138_1.time_ < var_141_22 + var_141_30 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_22) / var_141_30

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_22 + var_141_30 and arg_138_1.time_ < var_141_22 + var_141_30 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play938022035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 938022035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play938022036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10144"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos10144 = var_145_0.localPosition
				var_145_0.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10144", 3)

				local var_145_2 = var_145_0.childCount

				for iter_145_0 = 0, var_145_2 - 1 do
					local var_145_3 = var_145_0:GetChild(iter_145_0)

					if var_145_3.name == "split_5" then
						var_145_3:SetAsLastSibling()
						var_145_3.gameObject:SetActive(true)

						arg_142_1.var_.actorSpriteSplit10144 = var_145_3.gameObject:GetComponent(typeof(Image))

						arg_142_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_145_4 = 0.5

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_4 then
				local var_145_5 = (arg_142_1.time_ - var_145_1) / var_145_4
				local var_145_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10144, var_145_6, var_145_5)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(var_145_5)
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_4 and arg_142_1.time_ < var_145_1 + var_145_4 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_142_1.var_.actorSpriteSplit10144 ~= nil then
					arg_142_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_145_7 = 0
			local var_145_8 = 0.475

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_9 = arg_142_1:FormatText(StoryNameCfg[1297].name)

				arg_142_1.leftNameTxt_.text = var_145_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_10 = arg_142_1:GetWordFromCfg(938022035)
				local var_145_11 = arg_142_1:FormatText(var_145_10.content)

				arg_142_1.text_.text = var_145_11

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_12 = 19
				local var_145_13 = utf8.len(var_145_11)
				local var_145_14 = var_145_12 <= 0 and var_145_8 or var_145_8 * (var_145_13 / var_145_12)

				if var_145_14 > 0 and var_145_8 < var_145_14 then
					arg_142_1.talkMaxDuration = var_145_14

					if var_145_14 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_7
					end
				end

				arg_142_1.text_.text = var_145_11
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_15 = math.max(var_145_8, arg_142_1.talkMaxDuration)

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_15 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_7) / var_145_15

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_7 + var_145_15 and arg_142_1.time_ < var_145_7 + var_145_15 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play938022036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 938022036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play938022037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10144"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10144 == nil then
				arg_146_1.var_.actorSpriteComps10144 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10144 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 0.5, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10144 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10144 = nil
			end

			local var_149_8 = 0
			local var_149_9 = 0.125

			if var_149_8 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_10 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_11 = arg_146_1:GetWordFromCfg(938022036)
				local var_149_12 = arg_146_1:FormatText(var_149_11.content)

				arg_146_1.text_.text = var_149_12

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_13 = 5
				local var_149_14 = utf8.len(var_149_12)
				local var_149_15 = var_149_13 <= 0 and var_149_9 or var_149_9 * (var_149_14 / var_149_13)

				if var_149_15 > 0 and var_149_9 < var_149_15 then
					arg_146_1.talkMaxDuration = var_149_15

					if var_149_15 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_15 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_12
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_16 and arg_146_1.time_ < var_149_8 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play938022037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 938022037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play938022038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10144"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10144 == nil then
				arg_150_1.var_.actorSpriteComps10144 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10144 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 1, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10144 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10144 = nil
			end

			local var_153_8 = arg_150_1.actors_["10144"].transform
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.var_.moveOldPos10144 = var_153_8.localPosition
				var_153_8.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("10144", 3)

				local var_153_10 = var_153_8.childCount

				for iter_153_4 = 0, var_153_10 - 1 do
					local var_153_11 = var_153_8:GetChild(iter_153_4)

					if var_153_11.name == "split_1" then
						var_153_11:SetAsLastSibling()
						var_153_11.gameObject:SetActive(true)

						arg_150_1.var_.actorSpriteSplit10144 = var_153_11.gameObject:GetComponent(typeof(Image))

						arg_150_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_153_12 = 0.5

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_12 then
				local var_153_13 = (arg_150_1.time_ - var_153_9) / var_153_12
				local var_153_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10144, var_153_14, var_153_13)

				if arg_150_1.var_.actorSpriteSplit10144 ~= nil then
					arg_150_1.var_.actorSpriteSplit10144:SetAlpha(var_153_13)
				end
			end

			if arg_150_1.time_ >= var_153_9 + var_153_12 and arg_150_1.time_ < var_153_9 + var_153_12 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_150_1.var_.actorSpriteSplit10144 ~= nil then
					arg_150_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_153_15 = 0
			local var_153_16 = 1.775

			if var_153_15 < arg_150_1.time_ and arg_150_1.time_ <= var_153_15 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_17 = arg_150_1:FormatText(StoryNameCfg[1297].name)

				arg_150_1.leftNameTxt_.text = var_153_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_18 = arg_150_1:GetWordFromCfg(938022037)
				local var_153_19 = arg_150_1:FormatText(var_153_18.content)

				arg_150_1.text_.text = var_153_19

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_20 = 71
				local var_153_21 = utf8.len(var_153_19)
				local var_153_22 = var_153_20 <= 0 and var_153_16 or var_153_16 * (var_153_21 / var_153_20)

				if var_153_22 > 0 and var_153_16 < var_153_22 then
					arg_150_1.talkMaxDuration = var_153_22

					if var_153_22 + var_153_15 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_22 + var_153_15
					end
				end

				arg_150_1.text_.text = var_153_19
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_23 = math.max(var_153_16, arg_150_1.talkMaxDuration)

			if var_153_15 <= arg_150_1.time_ and arg_150_1.time_ < var_153_15 + var_153_23 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_15) / var_153_23

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_15 + var_153_23 and arg_150_1.time_ < var_153_15 + var_153_23 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play938022038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938022038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938022039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10144"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10144 == nil then
				arg_154_1.var_.actorSpriteComps10144 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps10144 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 0.5, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10144 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_157_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10144 = nil
			end

			local var_157_8 = 0
			local var_157_9 = 1.5

			if var_157_8 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_10 = arg_154_1:FormatText(StoryNameCfg[7].name)

				arg_154_1.leftNameTxt_.text = var_157_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_11 = arg_154_1:GetWordFromCfg(938022038)
				local var_157_12 = arg_154_1:FormatText(var_157_11.content)

				arg_154_1.text_.text = var_157_12

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_13 = 60
				local var_157_14 = utf8.len(var_157_12)
				local var_157_15 = var_157_13 <= 0 and var_157_9 or var_157_9 * (var_157_14 / var_157_13)

				if var_157_15 > 0 and var_157_9 < var_157_15 then
					arg_154_1.talkMaxDuration = var_157_15

					if var_157_15 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_8
					end
				end

				arg_154_1.text_.text = var_157_12
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_9, arg_154_1.talkMaxDuration)

			if var_157_8 <= arg_154_1.time_ and arg_154_1.time_ < var_157_8 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_8) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_8 + var_157_16 and arg_154_1.time_ < var_157_8 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play938022039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938022039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938022040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10144"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10144 == nil then
				arg_158_1.var_.actorSpriteComps10144 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps10144 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor1.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor1.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor1.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 1, var_161_3)

								iter_161_1.color = Color.New(var_161_7, var_161_7, var_161_7)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10144 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_161_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps10144 = nil
			end

			local var_161_8 = arg_158_1.actors_["10144"].transform
			local var_161_9 = 0

			if var_161_9 < arg_158_1.time_ and arg_158_1.time_ <= var_161_9 + arg_161_0 then
				arg_158_1.var_.moveOldPos10144 = var_161_8.localPosition
				var_161_8.localScale = Vector3.New(1, 1, 1)

				arg_158_1:CheckSpriteTmpPos("10144", 3)

				local var_161_10 = var_161_8.childCount

				for iter_161_4 = 0, var_161_10 - 1 do
					local var_161_11 = var_161_8:GetChild(iter_161_4)

					if var_161_11.name == "split_3" then
						var_161_11:SetAsLastSibling()
						var_161_11.gameObject:SetActive(true)

						arg_158_1.var_.actorSpriteSplit10144 = var_161_11.gameObject:GetComponent(typeof(Image))

						arg_158_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_161_12 = 0.5

			if var_161_9 <= arg_158_1.time_ and arg_158_1.time_ < var_161_9 + var_161_12 then
				local var_161_13 = (arg_158_1.time_ - var_161_9) / var_161_12
				local var_161_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_161_8.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10144, var_161_14, var_161_13)

				if arg_158_1.var_.actorSpriteSplit10144 ~= nil then
					arg_158_1.var_.actorSpriteSplit10144:SetAlpha(var_161_13)
				end
			end

			if arg_158_1.time_ >= var_161_9 + var_161_12 and arg_158_1.time_ < var_161_9 + var_161_12 + arg_161_0 then
				var_161_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_158_1.var_.actorSpriteSplit10144 ~= nil then
					arg_158_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_161_15 = 0
			local var_161_16 = 1.625

			if var_161_15 < arg_158_1.time_ and arg_158_1.time_ <= var_161_15 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_17 = arg_158_1:FormatText(StoryNameCfg[1297].name)

				arg_158_1.leftNameTxt_.text = var_161_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_18 = arg_158_1:GetWordFromCfg(938022039)
				local var_161_19 = arg_158_1:FormatText(var_161_18.content)

				arg_158_1.text_.text = var_161_19

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_20 = 65
				local var_161_21 = utf8.len(var_161_19)
				local var_161_22 = var_161_20 <= 0 and var_161_16 or var_161_16 * (var_161_21 / var_161_20)

				if var_161_22 > 0 and var_161_16 < var_161_22 then
					arg_158_1.talkMaxDuration = var_161_22

					if var_161_22 + var_161_15 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_22 + var_161_15
					end
				end

				arg_158_1.text_.text = var_161_19
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_23 = math.max(var_161_16, arg_158_1.talkMaxDuration)

			if var_161_15 <= arg_158_1.time_ and arg_158_1.time_ < var_161_15 + var_161_23 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_15) / var_161_23

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_15 + var_161_23 and arg_158_1.time_ < var_161_15 + var_161_23 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
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

		arg_158_1:InitPlayNodeList()
	end,
	Play938022040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938022040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938022041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10144"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos10144 = var_165_0.localPosition
				var_165_0.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10144", 3)

				local var_165_2 = var_165_0.childCount

				for iter_165_0 = 0, var_165_2 - 1 do
					local var_165_3 = var_165_0:GetChild(iter_165_0)

					if var_165_3.name == "" then
						var_165_3:SetAsLastSibling()
						var_165_3.gameObject:SetActive(true)

						arg_162_1.var_.actorSpriteSplit10144 = var_165_3.gameObject:GetComponent(typeof(Image))

						arg_162_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_165_4 = 0.5

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_4 then
				local var_165_5 = (arg_162_1.time_ - var_165_1) / var_165_4
				local var_165_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10144, var_165_6, var_165_5)

				if arg_162_1.var_.actorSpriteSplit10144 ~= nil then
					arg_162_1.var_.actorSpriteSplit10144:SetAlpha(var_165_5)
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_4 and arg_162_1.time_ < var_165_1 + var_165_4 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_162_1.var_.actorSpriteSplit10144 ~= nil then
					arg_162_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_165_7 = 0
			local var_165_8 = 0.9

			if var_165_7 < arg_162_1.time_ and arg_162_1.time_ <= var_165_7 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_9 = arg_162_1:FormatText(StoryNameCfg[1297].name)

				arg_162_1.leftNameTxt_.text = var_165_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_10 = arg_162_1:GetWordFromCfg(938022040)
				local var_165_11 = arg_162_1:FormatText(var_165_10.content)

				arg_162_1.text_.text = var_165_11

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_12 = 36
				local var_165_13 = utf8.len(var_165_11)
				local var_165_14 = var_165_12 <= 0 and var_165_8 or var_165_8 * (var_165_13 / var_165_12)

				if var_165_14 > 0 and var_165_8 < var_165_14 then
					arg_162_1.talkMaxDuration = var_165_14

					if var_165_14 + var_165_7 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_7
					end
				end

				arg_162_1.text_.text = var_165_11
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_15 = math.max(var_165_8, arg_162_1.talkMaxDuration)

			if var_165_7 <= arg_162_1.time_ and arg_162_1.time_ < var_165_7 + var_165_15 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_7) / var_165_15

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_7 + var_165_15 and arg_162_1.time_ < var_165_7 + var_165_15 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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

		arg_162_1:InitPlayNodeList()
	end,
	Play938022041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938022041
		arg_166_1.duration_ = 5.9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938022042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10144"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10144 == nil then
				arg_166_1.var_.actorSpriteComps10144 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10144 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 0.5, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10144 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10144 = nil
			end

			local var_169_8 = arg_166_1.actors_["10144"].transform
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.var_.moveOldPos10144 = var_169_8.localPosition
				var_169_8.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10144", 7)

				local var_169_10 = var_169_8.childCount

				for iter_169_4 = 0, var_169_10 - 1 do
					local var_169_11 = var_169_8:GetChild(iter_169_4)

					if var_169_11.name == "" or not string.find(var_169_11.name, "split") then
						var_169_11.gameObject:SetActive(true)
					else
						var_169_11.gameObject:SetActive(false)
					end
				end
			end

			local var_169_12 = 0.001

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_9) / var_169_12
				local var_169_14 = Vector3.New(0, -2000, 0)

				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10144, var_169_14, var_169_13)
			end

			if arg_166_1.time_ >= var_169_9 + var_169_12 and arg_166_1.time_ < var_169_9 + var_169_12 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_15 = manager.ui.mainCamera.transform
			local var_169_16 = 0

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.var_.shakeOldPos = var_169_15.localPosition
			end

			local var_169_17 = 2

			if var_169_16 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_17 then
				local var_169_18 = (arg_166_1.time_ - var_169_16) / 0.066
				local var_169_19, var_169_20 = math.modf(var_169_18)

				var_169_15.localPosition = Vector3.New(var_169_20 * 0.13, var_169_20 * 0.13, var_169_20 * 0.13) + arg_166_1.var_.shakeOldPos
			end

			if arg_166_1.time_ >= var_169_16 + var_169_17 and arg_166_1.time_ < var_169_16 + var_169_17 + arg_169_0 then
				var_169_15.localPosition = arg_166_1.var_.shakeOldPos
			end

			local var_169_21 = manager.ui.mainCamera.transform
			local var_169_22 = 0

			if var_169_22 < arg_166_1.time_ and arg_166_1.time_ <= var_169_22 + arg_169_0 then
				local var_169_23 = arg_166_1.var_.effecttaizixiajiang1
				local var_169_24
				local var_169_25 = var_169_21

				if not var_169_23 then
					var_169_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_169_25)
					var_169_23.name = "taizixiajiang1"
					arg_166_1.var_.effecttaizixiajiang1 = var_169_23
				else
					var_169_23.transform:SetParent(var_169_25)
				end

				var_169_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_169_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_169_26 = 1.7777777777777777
				local var_169_27 = Screen.width / Screen.height
				local var_169_28 = var_169_27 / var_169_26
				local var_169_29 = Mathf.Max(var_169_26 / var_169_27, 1)

				var_169_23.transform.localScale = Vector3.New(var_169_23.transform.localScale.x * var_169_28, var_169_23.transform.localScale.y * var_169_29, var_169_23.transform.localScale.z)
			end

			local var_169_30 = 0

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			local var_169_31 = 2

			if arg_166_1.time_ >= var_169_30 + var_169_31 and arg_166_1.time_ < var_169_30 + var_169_31 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_32 = 0.9
			local var_169_33 = 1.1

			if var_169_32 < arg_166_1.time_ and arg_166_1.time_ <= var_169_32 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_34 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_34:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_35 = arg_166_1:GetWordFromCfg(938022041)
				local var_169_36 = arg_166_1:FormatText(var_169_35.content)

				arg_166_1.text_.text = var_169_36

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_37 = 44
				local var_169_38 = utf8.len(var_169_36)
				local var_169_39 = var_169_37 <= 0 and var_169_33 or var_169_33 * (var_169_38 / var_169_37)

				if var_169_39 > 0 and var_169_33 < var_169_39 then
					arg_166_1.talkMaxDuration = var_169_39
					var_169_32 = var_169_32 + 0.3

					if var_169_39 + var_169_32 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_39 + var_169_32
					end
				end

				arg_166_1.text_.text = var_169_36
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_40 = var_169_32 + 0.3
			local var_169_41 = math.max(var_169_33, arg_166_1.talkMaxDuration)

			if var_169_40 <= arg_166_1.time_ and arg_166_1.time_ < var_169_40 + var_169_41 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_40) / var_169_41

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_40 + var_169_41 and arg_166_1.time_ < var_169_40 + var_169_41 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play938022042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 938022042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play938022043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1.675

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(938022042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 67
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_8 and arg_172_1.time_ < var_175_0 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play938022043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 938022043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play938022044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10144"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10144 == nil then
				arg_176_1.var_.actorSpriteComps10144 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps10144 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 1, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10144 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10144 = nil
			end

			local var_179_8 = arg_176_1.actors_["10144"].transform
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1.var_.moveOldPos10144 = var_179_8.localPosition
				var_179_8.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10144", 3)

				local var_179_10 = var_179_8.childCount

				for iter_179_4 = 0, var_179_10 - 1 do
					local var_179_11 = var_179_8:GetChild(iter_179_4)

					if var_179_11.name == "split_2" or not string.find(var_179_11.name, "split") then
						var_179_11.gameObject:SetActive(true)
					else
						var_179_11.gameObject:SetActive(false)
					end
				end
			end

			local var_179_12 = 0.001

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_9) / var_179_12
				local var_179_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_179_8.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10144, var_179_14, var_179_13)
			end

			if arg_176_1.time_ >= var_179_9 + var_179_12 and arg_176_1.time_ < var_179_9 + var_179_12 + arg_179_0 then
				var_179_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_179_15 = 0
			local var_179_16 = 0.775

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[1297].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(938022043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 31
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_23 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_23 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_23

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_23 and arg_176_1.time_ < var_179_15 + var_179_23 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play938022044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 938022044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play938022045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10144"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10144 == nil then
				arg_180_1.var_.actorSpriteComps10144 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10144 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 0.5, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10144 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10144 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 1.075

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_10 = arg_180_1:GetWordFromCfg(938022044)
				local var_183_11 = arg_180_1:FormatText(var_183_10.content)

				arg_180_1.text_.text = var_183_11

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_12 = 43
				local var_183_13 = utf8.len(var_183_11)
				local var_183_14 = var_183_12 <= 0 and var_183_9 or var_183_9 * (var_183_13 / var_183_12)

				if var_183_14 > 0 and var_183_9 < var_183_14 then
					arg_180_1.talkMaxDuration = var_183_14

					if var_183_14 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_11
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_15 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_15 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_15

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_15 and arg_180_1.time_ < var_183_8 + var_183_15 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play938022045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 938022045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play938022046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10144"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10144 == nil then
				arg_184_1.var_.actorSpriteComps10144 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps10144 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 1, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10144 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10144 = nil
			end

			local var_187_8 = arg_184_1.actors_["10144"].transform
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 then
				arg_184_1.var_.moveOldPos10144 = var_187_8.localPosition
				var_187_8.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10144", 3)

				local var_187_10 = var_187_8.childCount

				for iter_187_4 = 0, var_187_10 - 1 do
					local var_187_11 = var_187_8:GetChild(iter_187_4)

					if var_187_11.name == "split_1" then
						var_187_11:SetAsLastSibling()
						var_187_11.gameObject:SetActive(true)

						arg_184_1.var_.actorSpriteSplit10144 = var_187_11.gameObject:GetComponent(typeof(Image))

						arg_184_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_187_12 = 0.5

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_12 then
				local var_187_13 = (arg_184_1.time_ - var_187_9) / var_187_12
				local var_187_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_187_8.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10144, var_187_14, var_187_13)

				if arg_184_1.var_.actorSpriteSplit10144 ~= nil then
					arg_184_1.var_.actorSpriteSplit10144:SetAlpha(var_187_13)
				end
			end

			if arg_184_1.time_ >= var_187_9 + var_187_12 and arg_184_1.time_ < var_187_9 + var_187_12 + arg_187_0 then
				var_187_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_184_1.var_.actorSpriteSplit10144 ~= nil then
					arg_184_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_187_15 = 0
			local var_187_16 = 1.025

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_17 = arg_184_1:FormatText(StoryNameCfg[1297].name)

				arg_184_1.leftNameTxt_.text = var_187_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_18 = arg_184_1:GetWordFromCfg(938022045)
				local var_187_19 = arg_184_1:FormatText(var_187_18.content)

				arg_184_1.text_.text = var_187_19

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_20 = 41
				local var_187_21 = utf8.len(var_187_19)
				local var_187_22 = var_187_20 <= 0 and var_187_16 or var_187_16 * (var_187_21 / var_187_20)

				if var_187_22 > 0 and var_187_16 < var_187_22 then
					arg_184_1.talkMaxDuration = var_187_22

					if var_187_22 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_22 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_19
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_23 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_23 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_23

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_23 and arg_184_1.time_ < var_187_15 + var_187_23 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play938022046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 938022046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play938022047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10144"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10144 = var_191_0.localPosition
				var_191_0.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10144", 3)

				local var_191_2 = var_191_0.childCount

				for iter_191_0 = 0, var_191_2 - 1 do
					local var_191_3 = var_191_0:GetChild(iter_191_0)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_4 then
				local var_191_5 = (arg_188_1.time_ - var_191_1) / var_191_4
				local var_191_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10144, var_191_6, var_191_5)
			end

			if arg_188_1.time_ >= var_191_1 + var_191_4 and arg_188_1.time_ < var_191_1 + var_191_4 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_191_7 = 0
			local var_191_8 = 1.55

			if var_191_7 < arg_188_1.time_ and arg_188_1.time_ <= var_191_7 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_9 = arg_188_1:FormatText(StoryNameCfg[1297].name)

				arg_188_1.leftNameTxt_.text = var_191_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(938022046)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_12 = 62
				local var_191_13 = utf8.len(var_191_11)
				local var_191_14 = var_191_12 <= 0 and var_191_8 or var_191_8 * (var_191_13 / var_191_12)

				if var_191_14 > 0 and var_191_8 < var_191_14 then
					arg_188_1.talkMaxDuration = var_191_14

					if var_191_14 + var_191_7 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_7
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_15 = math.max(var_191_8, arg_188_1.talkMaxDuration)

			if var_191_7 <= arg_188_1.time_ and arg_188_1.time_ < var_191_7 + var_191_15 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_7) / var_191_15

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_7 + var_191_15 and arg_188_1.time_ < var_191_7 + var_191_15 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play938022047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 938022047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play938022048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10144"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10144 == nil then
				arg_192_1.var_.actorSpriteComps10144 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps10144 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor2.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor2.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor2.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 0.5, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10144 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10144 = nil
			end

			local var_195_8 = 0
			local var_195_9 = 0.25

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_10 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_11 = arg_192_1:GetWordFromCfg(938022047)
				local var_195_12 = arg_192_1:FormatText(var_195_11.content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 10
				local var_195_14 = utf8.len(var_195_12)
				local var_195_15 = var_195_13 <= 0 and var_195_9 or var_195_9 * (var_195_14 / var_195_13)

				if var_195_15 > 0 and var_195_9 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15

					if var_195_15 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_8
					end
				end

				arg_192_1.text_.text = var_195_12
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_16 and arg_192_1.time_ < var_195_8 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play938022048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 938022048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play938022049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10144"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 == nil then
				arg_196_1.var_.actorSpriteComps10144 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps10144 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps10144 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10144 = nil
			end

			local var_199_8 = arg_196_1.actors_["10144"].transform
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 then
				arg_196_1.var_.moveOldPos10144 = var_199_8.localPosition
				var_199_8.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10144", 3)

				local var_199_10 = var_199_8.childCount

				for iter_199_4 = 0, var_199_10 - 1 do
					local var_199_11 = var_199_8:GetChild(iter_199_4)

					if var_199_11.name == "split_7" then
						var_199_11:SetAsLastSibling()
						var_199_11.gameObject:SetActive(true)

						arg_196_1.var_.actorSpriteSplit10144 = var_199_11.gameObject:GetComponent(typeof(Image))

						arg_196_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_199_12 = 0.5

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_12 then
				local var_199_13 = (arg_196_1.time_ - var_199_9) / var_199_12
				local var_199_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_199_8.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10144, var_199_14, var_199_13)

				if arg_196_1.var_.actorSpriteSplit10144 ~= nil then
					arg_196_1.var_.actorSpriteSplit10144:SetAlpha(var_199_13)
				end
			end

			if arg_196_1.time_ >= var_199_9 + var_199_12 and arg_196_1.time_ < var_199_9 + var_199_12 + arg_199_0 then
				var_199_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_196_1.var_.actorSpriteSplit10144 ~= nil then
					arg_196_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_199_15 = 0
			local var_199_16 = 1.5

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[1297].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(938022048)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 60
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_23 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_23 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_23

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_23 and arg_196_1.time_ < var_199_15 + var_199_23 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play938022049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 938022049
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play938022050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 2

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				local var_203_1 = manager.ui.mainCamera.transform.localPosition
				local var_203_2 = Vector3.New(0, 0, 10) + Vector3.New(var_203_1.x, var_203_1.y, 0)
				local var_203_3 = arg_200_1.bgs_.ST0119

				var_203_3.transform.localPosition = var_203_2
				var_203_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_4 = var_203_3:GetComponent("SpriteRenderer")

				if var_203_4 and var_203_4.sprite then
					local var_203_5 = (var_203_3.transform.localPosition - var_203_1).z
					local var_203_6 = manager.ui.mainCameraCom_
					local var_203_7 = 2 * var_203_5 * Mathf.Tan(var_203_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_203_8 = var_203_7 * var_203_6.aspect
					local var_203_9 = var_203_4.sprite.bounds.size.x
					local var_203_10 = var_203_4.sprite.bounds.size.y
					local var_203_11 = var_203_8 / var_203_9
					local var_203_12 = var_203_7 / var_203_10
					local var_203_13 = var_203_12 < var_203_11 and var_203_11 or var_203_12

					var_203_3.transform.localScale = Vector3.New(var_203_13, var_203_13, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST0119" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_14 = 4

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			local var_203_15 = 0.3

			if arg_200_1.time_ >= var_203_14 + var_203_15 and arg_200_1.time_ < var_203_14 + var_203_15 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_17 = 2

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 then
				local var_203_18 = (arg_200_1.time_ - var_203_16) / var_203_17
				local var_203_19 = Color.New(0, 0, 0)

				var_203_19.a = Mathf.Lerp(0, 1, var_203_18)
				arg_200_1.mask_.color = var_203_19
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 then
				local var_203_20 = Color.New(0, 0, 0)

				var_203_20.a = 1
				arg_200_1.mask_.color = var_203_20
			end

			local var_203_21 = 2

			if var_203_21 < arg_200_1.time_ and arg_200_1.time_ <= var_203_21 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_22 = 2

			if var_203_21 <= arg_200_1.time_ and arg_200_1.time_ < var_203_21 + var_203_22 then
				local var_203_23 = (arg_200_1.time_ - var_203_21) / var_203_22
				local var_203_24 = Color.New(0, 0, 0)

				var_203_24.a = Mathf.Lerp(1, 0, var_203_23)
				arg_200_1.mask_.color = var_203_24
			end

			if arg_200_1.time_ >= var_203_21 + var_203_22 and arg_200_1.time_ < var_203_21 + var_203_22 + arg_203_0 then
				local var_203_25 = Color.New(0, 0, 0)
				local var_203_26 = 0

				arg_200_1.mask_.enabled = false
				var_203_25.a = var_203_26
				arg_200_1.mask_.color = var_203_25
			end

			local var_203_27 = arg_200_1.actors_["10144"]
			local var_203_28 = 1.966

			if var_203_28 < arg_200_1.time_ and arg_200_1.time_ <= var_203_28 + arg_203_0 and not isNil(var_203_27) and arg_200_1.var_.actorSpriteComps10144 == nil then
				arg_200_1.var_.actorSpriteComps10144 = var_203_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_29 = 0.034

			if var_203_28 <= arg_200_1.time_ and arg_200_1.time_ < var_203_28 + var_203_29 and not isNil(var_203_27) then
				local var_203_30 = (arg_200_1.time_ - var_203_28) / var_203_29

				if arg_200_1.var_.actorSpriteComps10144 then
					for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_203_3 then
							if arg_200_1.isInRecall_ then
								local var_203_31 = Mathf.Lerp(iter_203_3.color.r, arg_200_1.hightColor2.r, var_203_30)
								local var_203_32 = Mathf.Lerp(iter_203_3.color.g, arg_200_1.hightColor2.g, var_203_30)
								local var_203_33 = Mathf.Lerp(iter_203_3.color.b, arg_200_1.hightColor2.b, var_203_30)

								iter_203_3.color = Color.New(var_203_31, var_203_32, var_203_33)
							else
								local var_203_34 = Mathf.Lerp(iter_203_3.color.r, 0.5, var_203_30)

								iter_203_3.color = Color.New(var_203_34, var_203_34, var_203_34)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_28 + var_203_29 and arg_200_1.time_ < var_203_28 + var_203_29 + arg_203_0 and not isNil(var_203_27) and arg_200_1.var_.actorSpriteComps10144 then
				for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_203_5 then
						if arg_200_1.isInRecall_ then
							iter_203_5.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10144 = nil
			end

			local var_203_35 = arg_200_1.actors_["10144"].transform
			local var_203_36 = 1.966

			if var_203_36 < arg_200_1.time_ and arg_200_1.time_ <= var_203_36 + arg_203_0 then
				arg_200_1.var_.moveOldPos10144 = var_203_35.localPosition
				var_203_35.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10144", 7)

				local var_203_37 = var_203_35.childCount

				for iter_203_6 = 0, var_203_37 - 1 do
					local var_203_38 = var_203_35:GetChild(iter_203_6)

					if var_203_38.name == "" or not string.find(var_203_38.name, "split") then
						var_203_38.gameObject:SetActive(true)
					else
						var_203_38.gameObject:SetActive(false)
					end
				end
			end

			local var_203_39 = 0.001

			if var_203_36 <= arg_200_1.time_ and arg_200_1.time_ < var_203_36 + var_203_39 then
				local var_203_40 = (arg_200_1.time_ - var_203_36) / var_203_39
				local var_203_41 = Vector3.New(0, -2000, 0)

				var_203_35.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10144, var_203_41, var_203_40)
			end

			if arg_200_1.time_ >= var_203_36 + var_203_39 and arg_200_1.time_ < var_203_36 + var_203_39 + arg_203_0 then
				var_203_35.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_42 = 4
			local var_203_43 = 1.7

			if var_203_42 < arg_200_1.time_ and arg_200_1.time_ <= var_203_42 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_44 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_44:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_45 = arg_200_1:GetWordFromCfg(938022049)
				local var_203_46 = arg_200_1:FormatText(var_203_45.content)

				arg_200_1.text_.text = var_203_46

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_47 = 68
				local var_203_48 = utf8.len(var_203_46)
				local var_203_49 = var_203_47 <= 0 and var_203_43 or var_203_43 * (var_203_48 / var_203_47)

				if var_203_49 > 0 and var_203_43 < var_203_49 then
					arg_200_1.talkMaxDuration = var_203_49
					var_203_42 = var_203_42 + 0.3

					if var_203_49 + var_203_42 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_49 + var_203_42
					end
				end

				arg_200_1.text_.text = var_203_46
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_50 = var_203_42 + 0.3
			local var_203_51 = math.max(var_203_43, arg_200_1.talkMaxDuration)

			if var_203_50 <= arg_200_1.time_ and arg_200_1.time_ < var_203_50 + var_203_51 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_50) / var_203_51

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_50 + var_203_51 and arg_200_1.time_ < var_203_50 + var_203_51 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play938022050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938022050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938022051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10144"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10144 == nil then
				arg_206_1.var_.actorSpriteComps10144 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps10144 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10144 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10144 = nil
			end

			local var_209_8 = arg_206_1.actors_["10144"].transform
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.var_.moveOldPos10144 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10144", 3)

				local var_209_10 = var_209_8.childCount

				for iter_209_4 = 0, var_209_10 - 1 do
					local var_209_11 = var_209_8:GetChild(iter_209_4)

					if var_209_11.name == "" or not string.find(var_209_11.name, "split") then
						var_209_11.gameObject:SetActive(true)
					else
						var_209_11.gameObject:SetActive(false)
					end
				end
			end

			local var_209_12 = 0.001

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_12 then
				local var_209_13 = (arg_206_1.time_ - var_209_9) / var_209_12
				local var_209_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10144, var_209_14, var_209_13)
			end

			if arg_206_1.time_ >= var_209_9 + var_209_12 and arg_206_1.time_ < var_209_9 + var_209_12 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_209_15 = 0
			local var_209_16 = 0.95

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[1297].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(938022050)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 38
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_23 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_23 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_23

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_23 and arg_206_1.time_ < var_209_15 + var_209_23 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play938022051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938022051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938022052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10144"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10144 == nil then
				arg_210_1.var_.actorSpriteComps10144 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10144 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10144 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10144 = nil
			end

			local var_213_8 = 0
			local var_213_9 = 0.175

			if var_213_8 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_10 = arg_210_1:FormatText(StoryNameCfg[7].name)

				arg_210_1.leftNameTxt_.text = var_213_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_11 = arg_210_1:GetWordFromCfg(938022051)
				local var_213_12 = arg_210_1:FormatText(var_213_11.content)

				arg_210_1.text_.text = var_213_12

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 7
				local var_213_14 = utf8.len(var_213_12)
				local var_213_15 = var_213_13 <= 0 and var_213_9 or var_213_9 * (var_213_14 / var_213_13)

				if var_213_15 > 0 and var_213_9 < var_213_15 then
					arg_210_1.talkMaxDuration = var_213_15

					if var_213_15 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_15 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_12
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_16 and arg_210_1.time_ < var_213_8 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play938022052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938022052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938022053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10144"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos10144 = var_217_0.localPosition
				var_217_0.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10144", 7)

				local var_217_2 = var_217_0.childCount

				for iter_217_0 = 0, var_217_2 - 1 do
					local var_217_3 = var_217_0:GetChild(iter_217_0)

					if var_217_3.name == "" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_4 then
				local var_217_5 = (arg_214_1.time_ - var_217_1) / var_217_4
				local var_217_6 = Vector3.New(0, -2000, 0)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10144, var_217_6, var_217_5)
			end

			if arg_214_1.time_ >= var_217_1 + var_217_4 and arg_214_1.time_ < var_217_1 + var_217_4 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_7 = 0
			local var_217_8 = 1.025

			if var_217_7 < arg_214_1.time_ and arg_214_1.time_ <= var_217_7 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_9 = arg_214_1:GetWordFromCfg(938022052)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 41
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_8 or var_217_8 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_8 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_7 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_7
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_8, arg_214_1.talkMaxDuration)

			if var_217_7 <= arg_214_1.time_ and arg_214_1.time_ < var_217_7 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_7) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_7 + var_217_14 and arg_214_1.time_ < var_217_7 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play938022053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938022053
		arg_218_1.duration_ = 7

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938022054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = "SP93801"

			if arg_218_1.bgs_[var_221_0] == nil then
				local var_221_1 = Object.Instantiate(arg_218_1.paintGo_)

				var_221_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_221_0)
				var_221_1.name = var_221_0
				var_221_1.transform.parent = arg_218_1.stage_.transform
				var_221_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.bgs_[var_221_0] = var_221_1
			end

			local var_221_2 = 1.15

			if var_221_2 < arg_218_1.time_ and arg_218_1.time_ <= var_221_2 + arg_221_0 then
				local var_221_3 = manager.ui.mainCamera.transform.localPosition
				local var_221_4 = Vector3.New(0, 0, 10) + Vector3.New(var_221_3.x, var_221_3.y, 0)
				local var_221_5 = arg_218_1.bgs_.SP93801

				var_221_5.transform.localPosition = var_221_4
				var_221_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_221_6 = var_221_5:GetComponent("SpriteRenderer")

				if var_221_6 and var_221_6.sprite then
					local var_221_7 = (var_221_5.transform.localPosition - var_221_3).z
					local var_221_8 = manager.ui.mainCameraCom_
					local var_221_9 = 2 * var_221_7 * Mathf.Tan(var_221_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_221_10 = var_221_9 * var_221_8.aspect
					local var_221_11 = var_221_6.sprite.bounds.size.x
					local var_221_12 = var_221_6.sprite.bounds.size.y
					local var_221_13 = var_221_10 / var_221_11
					local var_221_14 = var_221_9 / var_221_12
					local var_221_15 = var_221_14 < var_221_13 and var_221_13 or var_221_14

					var_221_5.transform.localScale = Vector3.New(var_221_15, var_221_15, 0)
				end

				for iter_221_0, iter_221_1 in pairs(arg_218_1.bgs_) do
					if iter_221_0 ~= "SP93801" then
						iter_221_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_221_16 = manager.ui.mainCamera.transform
			local var_221_17 = 0

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				local var_221_18 = arg_218_1.var_.effectxuanguangzhuanchang1
				local var_221_19
				local var_221_20 = var_221_16

				if not var_221_18 then
					var_221_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_221_20)
					var_221_18.name = "xuanguangzhuanchang1"
					arg_218_1.var_.effectxuanguangzhuanchang1 = var_221_18
				else
					var_221_18.transform:SetParent(var_221_20)
				end

				var_221_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_21 = 1.7777777777777777
				local var_221_22 = Screen.width / Screen.height
				local var_221_23 = var_221_22 / var_221_21
				local var_221_24 = Mathf.Max(var_221_21 / var_221_22, 1)
				local var_221_25 = Mathf.Max(var_221_23, var_221_24)

				var_221_18.transform.localScale = Vector3.New(var_221_18.transform.localScale.x * var_221_25, var_221_18.transform.localScale.y * var_221_25, var_221_18.transform.localScale.z * var_221_25)
			end

			local var_221_26 = manager.ui.mainCamera.transform
			local var_221_27 = 1.2

			if var_221_27 < arg_218_1.time_ and arg_218_1.time_ <= var_221_27 + arg_221_0 then
				local var_221_28 = arg_218_1.var_.effectxuanguangzhuanchang1

				if var_221_28 then
					Object.Destroy(var_221_28)

					arg_218_1.var_.effectxuanguangzhuanchang1 = nil
				end
			end

			local var_221_29 = 1
			local var_221_30 = 1

			if var_221_29 < arg_218_1.time_ and arg_218_1.time_ <= var_221_29 + arg_221_0 then
				local var_221_31 = "play"
				local var_221_32 = "effect"

				arg_218_1:AudioAction(var_221_31, var_221_32, "se_story_140", "se_story_140_amb_boxing02", "")
			end

			local var_221_33 = 0.3
			local var_221_34 = 1

			if var_221_33 < arg_218_1.time_ and arg_218_1.time_ <= var_221_33 + arg_221_0 then
				local var_221_35 = "stop"
				local var_221_36 = "effect"

				arg_218_1:AudioAction(var_221_35, var_221_36, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_221_37 = manager.ui.mainCamera.transform
			local var_221_38 = 1.3

			if var_221_38 < arg_218_1.time_ and arg_218_1.time_ <= var_221_38 + arg_221_0 then
				local var_221_39 = arg_218_1.var_.effectxuanguangzhuanchang2
				local var_221_40
				local var_221_41 = var_221_37

				if not var_221_39 then
					var_221_39 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_221_41)
					var_221_39.name = "xuanguangzhuanchang2"
					arg_218_1.var_.effectxuanguangzhuanchang2 = var_221_39
				else
					var_221_39.transform:SetParent(var_221_41)
				end

				var_221_39.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_39.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_221_42 = 1.7777777777777777
				local var_221_43 = Screen.width / Screen.height
				local var_221_44 = var_221_43 / var_221_42
				local var_221_45 = Mathf.Max(var_221_42 / var_221_43, 1)
				local var_221_46 = Mathf.Max(var_221_44, var_221_45)

				var_221_39.transform.localScale = Vector3.New(var_221_39.transform.localScale.x * var_221_46, var_221_39.transform.localScale.y * var_221_46, var_221_39.transform.localScale.z * var_221_46)
			end

			local var_221_47 = manager.ui.mainCamera.transform
			local var_221_48 = 2.53333333333333

			if var_221_48 < arg_218_1.time_ and arg_218_1.time_ <= var_221_48 + arg_221_0 then
				local var_221_49 = arg_218_1.var_.effectxuanguangzhuanchang2

				if var_221_49 then
					Object.Destroy(var_221_49)

					arg_218_1.var_.effectxuanguangzhuanchang2 = nil
				end
			end

			local var_221_50 = arg_218_1.bgs_.SP93801.transform
			local var_221_51 = 1.16666666666667

			if var_221_51 < arg_218_1.time_ and arg_218_1.time_ <= var_221_51 + arg_221_0 then
				arg_218_1.var_.moveOldPosSP93801 = var_221_50.localPosition
			end

			local var_221_52 = 2.8

			if var_221_51 <= arg_218_1.time_ and arg_218_1.time_ < var_221_51 + var_221_52 then
				local var_221_53 = (arg_218_1.time_ - var_221_51) / var_221_52
				local var_221_54 = Vector3.New(-2.62, 0, 4)

				var_221_50.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPosSP93801, var_221_54, var_221_53)
			end

			if arg_218_1.time_ >= var_221_51 + var_221_52 and arg_218_1.time_ < var_221_51 + var_221_52 + arg_221_0 then
				var_221_50.localPosition = Vector3.New(-2.62, 0, 4)
			end

			local var_221_55 = 0

			if var_221_55 < arg_218_1.time_ and arg_218_1.time_ <= var_221_55 + arg_221_0 then
				arg_218_1.allBtn_.enabled = false
			end

			local var_221_56 = 3.966666666666

			if arg_218_1.time_ >= var_221_55 + var_221_56 and arg_218_1.time_ < var_221_55 + var_221_56 + arg_221_0 then
				arg_218_1.allBtn_.enabled = true
			end

			if arg_218_1.frameCnt_ <= 1 then
				arg_218_1.dialog_:SetActive(false)
			end

			local var_221_57 = 2
			local var_221_58 = 1.475

			if var_221_57 < arg_218_1.time_ and arg_218_1.time_ <= var_221_57 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0

				arg_218_1.dialog_:SetActive(true)

				arg_218_1.dialogCg_.alpha = 0

				local var_221_59 = LeanTween.value(arg_218_1.dialog_, 0, 1, 0.3)

				var_221_59:setOnUpdate(LuaHelper.FloatAction(function(arg_222_0)
					arg_218_1.dialogCg_.alpha = arg_222_0
				end))
				var_221_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_218_1.dialog_)
					var_221_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_218_1.duration_ = arg_218_1.duration_ + 0.3

				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_60 = arg_218_1:GetWordFromCfg(938022053)
				local var_221_61 = arg_218_1:FormatText(var_221_60.content)

				arg_218_1.text_.text = var_221_61

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_62 = 59
				local var_221_63 = utf8.len(var_221_61)
				local var_221_64 = var_221_62 <= 0 and var_221_58 or var_221_58 * (var_221_63 / var_221_62)

				if var_221_64 > 0 and var_221_58 < var_221_64 then
					arg_218_1.talkMaxDuration = var_221_64
					var_221_57 = var_221_57 + 0.3

					if var_221_64 + var_221_57 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_64 + var_221_57
					end
				end

				arg_218_1.text_.text = var_221_61
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_65 = var_221_57 + 0.3
			local var_221_66 = math.max(var_221_58, arg_218_1.talkMaxDuration)

			if var_221_65 <= arg_218_1.time_ and arg_218_1.time_ < var_221_65 + var_221_66 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_65) / var_221_66

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_65 + var_221_66 and arg_218_1.time_ < var_221_65 + var_221_66 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.72, 0.5, 4),
					endPos = Vector3.New(-2.62, 0, 4),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play938022054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 938022054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play938022055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.475

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[562].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:GetWordFromCfg(938022054)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 19
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_8 and arg_224_1.time_ < var_227_0 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play938022055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 938022055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play938022056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 0.45

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(938022055)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 18
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play938022056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 938022056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play938022057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 1.1

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[562].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_3 = arg_232_1:GetWordFromCfg(938022056)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 44
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_8 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_8 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_8

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_8 and arg_232_1.time_ < var_235_0 + var_235_8 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play938022057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 938022057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play938022058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.625

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(938022057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 25
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_8 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_8 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_8

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_8 and arg_236_1.time_ < var_239_0 + var_239_8 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play938022058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 938022058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play938022059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.475

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(938022058)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 59
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play938022059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 938022059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play938022060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.4

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[562].name)

				arg_244_1.leftNameTxt_.text = var_247_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(938022059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 16
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_8 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_8 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_8

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_8 and arg_244_1.time_ < var_247_0 + var_247_8 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play938022060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 938022060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play938022061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.675

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[562].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(938022060)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 27
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play938022061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 938022061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play938022062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.85

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:GetWordFromCfg(938022061)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 34
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_8 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_8 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_8

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_8 and arg_252_1.time_ < var_255_0 + var_255_8 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play938022062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 938022062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play938022063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.325

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_2 = arg_256_1:FormatText(StoryNameCfg[562].name)

				arg_256_1.leftNameTxt_.text = var_259_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:GetWordFromCfg(938022062)
				local var_259_4 = arg_256_1:FormatText(var_259_3.content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 13
				local var_259_6 = utf8.len(var_259_4)
				local var_259_7 = var_259_5 <= 0 and var_259_1 or var_259_1 * (var_259_6 / var_259_5)

				if var_259_7 > 0 and var_259_1 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_0
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_1, arg_256_1.talkMaxDuration)

			if var_259_0 <= arg_256_1.time_ and arg_256_1.time_ < var_259_0 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_0) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_0 + var_259_8 and arg_256_1.time_ < var_259_0 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play938022063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 938022063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play938022064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.525

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1297].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(938022063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 21
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_8 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_8 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_8

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_8 and arg_260_1.time_ < var_263_0 + var_263_8 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play938022064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 938022064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play938022065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.5

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_2 = arg_264_1:FormatText(StoryNameCfg[7].name)

				arg_264_1.leftNameTxt_.text = var_267_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_3 = arg_264_1:GetWordFromCfg(938022064)
				local var_267_4 = arg_264_1:FormatText(var_267_3.content)

				arg_264_1.text_.text = var_267_4

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 20
				local var_267_6 = utf8.len(var_267_4)
				local var_267_7 = var_267_5 <= 0 and var_267_1 or var_267_1 * (var_267_6 / var_267_5)

				if var_267_7 > 0 and var_267_1 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_4
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_8 and arg_264_1.time_ < var_267_0 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play938022065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 938022065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play938022066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.75

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_2 = arg_268_1:FormatText(StoryNameCfg[1297].name)

				arg_268_1.leftNameTxt_.text = var_271_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_3 = arg_268_1:GetWordFromCfg(938022065)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 30
				local var_271_6 = utf8.len(var_271_4)
				local var_271_7 = var_271_5 <= 0 and var_271_1 or var_271_1 * (var_271_6 / var_271_5)

				if var_271_7 > 0 and var_271_1 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_0
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_8 = math.max(var_271_1, arg_268_1.talkMaxDuration)

			if var_271_0 <= arg_268_1.time_ and arg_268_1.time_ < var_271_0 + var_271_8 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_0) / var_271_8

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_0 + var_271_8 and arg_268_1.time_ < var_271_0 + var_271_8 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play938022066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 938022066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play938022067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.65

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1297].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(938022066)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 26
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_8 and arg_272_1.time_ < var_275_0 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play938022067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 938022067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play938022068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0
			local var_279_1 = 0.325

			if var_279_0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_2 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:GetWordFromCfg(938022067)
				local var_279_4 = arg_276_1:FormatText(var_279_3.content)

				arg_276_1.text_.text = var_279_4

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 13
				local var_279_6 = utf8.len(var_279_4)
				local var_279_7 = var_279_5 <= 0 and var_279_1 or var_279_1 * (var_279_6 / var_279_5)

				if var_279_7 > 0 and var_279_1 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_4
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play938022068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 938022068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play938022069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.6

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[562].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(938022068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 24
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play938022069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 938022069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play938022070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.bgs_.SP93801.transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPosSP93801 = var_287_0.localPosition
			end

			local var_287_2 = 2.8

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(0, 1, 10)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPosSP93801, var_287_4, var_287_3)
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			local var_287_6 = 2.8

			if arg_284_1.time_ >= var_287_5 + var_287_6 and arg_284_1.time_ < var_287_5 + var_287_6 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_7 = 0
			local var_287_8 = 0.825

			if var_287_7 < arg_284_1.time_ and arg_284_1.time_ <= var_287_7 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_9 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_9:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_10 = arg_284_1:GetWordFromCfg(938022069)
				local var_287_11 = arg_284_1:FormatText(var_287_10.content)

				arg_284_1.text_.text = var_287_11

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_12 = 33
				local var_287_13 = utf8.len(var_287_11)
				local var_287_14 = var_287_12 <= 0 and var_287_8 or var_287_8 * (var_287_13 / var_287_12)

				if var_287_14 > 0 and var_287_8 < var_287_14 then
					arg_284_1.talkMaxDuration = var_287_14
					var_287_7 = var_287_7 + 0.3

					if var_287_14 + var_287_7 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_14 + var_287_7
					end
				end

				arg_284_1.text_.text = var_287_11
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_15 = var_287_7 + 0.3
			local var_287_16 = math.max(var_287_8, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_16 and arg_284_1.time_ < var_287_15 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-2.62, 0, 4),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play938022070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938022070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938022071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.325

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[32].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_3 = arg_290_1:GetWordFromCfg(938022070)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 13
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play938022071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938022071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938022072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.3

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(938022071)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 12
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_8 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_8 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_8

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_8 and arg_294_1.time_ < var_297_0 + var_297_8 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play938022072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 938022072
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play938022073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.475

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[32].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:GetWordFromCfg(938022072)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 19
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_8 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_8 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_8

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_8 and arg_298_1.time_ < var_301_0 + var_301_8 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play938022073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 938022073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play938022074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0
			local var_305_1 = 0.5

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_2 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_3 = arg_302_1:GetWordFromCfg(938022073)
				local var_305_4 = arg_302_1:FormatText(var_305_3.content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_5 = 20
				local var_305_6 = utf8.len(var_305_4)
				local var_305_7 = var_305_5 <= 0 and var_305_1 or var_305_1 * (var_305_6 / var_305_5)

				if var_305_7 > 0 and var_305_1 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_0
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_8 = math.max(var_305_1, arg_302_1.talkMaxDuration)

			if var_305_0 <= arg_302_1.time_ and arg_302_1.time_ < var_305_0 + var_305_8 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_0) / var_305_8

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_0 + var_305_8 and arg_302_1.time_ < var_305_0 + var_305_8 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play938022074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938022074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938022075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.85

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[32].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_3 = arg_306_1:GetWordFromCfg(938022074)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 34
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_8 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_8 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_8

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_8 and arg_306_1.time_ < var_309_0 + var_309_8 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play938022075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938022075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938022076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.65

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[32].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_3 = arg_310_1:GetWordFromCfg(938022075)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 26
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938022076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938022076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938022077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.15

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(938022076)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 46
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play938022077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938022077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
			arg_318_1.auto_ = false
		end

		function arg_318_1.playNext_(arg_320_0)
			arg_318_1.onStoryFinished_()
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.allBtn_.enabled = false
			end

			local var_321_1 = 2.8

			if arg_318_1.time_ >= var_321_0 + var_321_1 and arg_318_1.time_ < var_321_0 + var_321_1 + arg_321_0 then
				arg_318_1.allBtn_.enabled = true
			end

			local var_321_2 = arg_318_1.bgs_.SP93801.transform
			local var_321_3 = 0

			if var_321_3 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.var_.moveOldPosSP93801 = var_321_2.localPosition
			end

			local var_321_4 = 2.8

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_4 then
				local var_321_5 = (arg_318_1.time_ - var_321_3) / var_321_4
				local var_321_6 = Vector3.New(0, 0, 6)

				var_321_2.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPosSP93801, var_321_6, var_321_5)
			end

			if arg_318_1.time_ >= var_321_3 + var_321_4 and arg_318_1.time_ < var_321_3 + var_321_4 + arg_321_0 then
				var_321_2.localPosition = Vector3.New(0, 0, 6)
			end

			local var_321_7 = 0
			local var_321_8 = 0.625

			if var_321_7 < arg_318_1.time_ and arg_318_1.time_ <= var_321_7 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_9 = arg_318_1:FormatText(StoryNameCfg[1297].name)

				arg_318_1.leftNameTxt_.text = var_321_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_10 = arg_318_1:GetWordFromCfg(938022077)
				local var_321_11 = arg_318_1:FormatText(var_321_10.content)

				arg_318_1.text_.text = var_321_11

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_12 = 25
				local var_321_13 = utf8.len(var_321_11)
				local var_321_14 = var_321_12 <= 0 and var_321_8 or var_321_8 * (var_321_13 / var_321_12)

				if var_321_14 > 0 and var_321_8 < var_321_14 then
					arg_318_1.talkMaxDuration = var_321_14

					if var_321_14 + var_321_7 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_7
					end
				end

				arg_318_1.text_.text = var_321_11
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_15 = math.max(var_321_8, arg_318_1.talkMaxDuration)

			if var_321_7 <= arg_318_1.time_ and arg_318_1.time_ < var_321_7 + var_321_15 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_7) / var_321_15

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_7 + var_321_15 and arg_318_1.time_ < var_321_7 + var_321_15 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SP93801",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0, 6),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0119",
		"TextureConfig/Background/SP93801"
	},
	voices = {}
}
