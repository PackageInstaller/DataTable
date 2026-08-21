return {
	Play925071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 925071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play925071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I06b"

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
				local var_4_5 = arg_1_1.bgs_.I06b

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
					if iter_4_0 ~= "I06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "1075"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1075")

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

			local var_4_28 = arg_1_1.actors_["1075"]
			local var_4_29 = 1.73333333333333

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1075 == nil then
				arg_1_1.var_.actorSpriteComps1075 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.166

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1075 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1075 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1075 = nil
			end

			local var_4_36 = arg_1_1.actors_["1075"].transform
			local var_4_37 = 1.73333333333333

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1075 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1075", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-43, -310.5, -413.5)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1075, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-43, -310.5, -413.5)
			end

			local var_4_43 = arg_1_1.actors_["1075"]
			local var_4_44 = 1.73333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1075 = var_4_45.alpha
					arg_1_1.var_.characterEffect1075 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1075 = 0
			end

			local var_4_46 = 0.166

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1075, 1, var_4_47)

				if arg_1_1.var_.characterEffect1075 then
					arg_1_1.var_.characterEffect1075.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1075 then
				arg_1_1.var_.characterEffect1075.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.2

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 0.233333333333333
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if var_4_60 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_60 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_60

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_60
						arg_1_1.bgmTxt2_.text = var_4_60
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

			local var_4_61 = 1.999999999999
			local var_4_62 = 0.65

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[381].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(925071001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 26
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_61 + 0.3
			local var_4_71 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play925071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 925071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play925071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1075"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1075 == nil then
				arg_9_1.var_.actorSpriteComps1075 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps1075 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps1075 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps1075 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 1.15

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(925071002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 46
				local var_12_14 = utf8.len(var_12_12)
				local var_12_15 = var_12_13 <= 0 and var_12_9 or var_12_9 * (var_12_14 / var_12_13)

				if var_12_15 > 0 and var_12_9 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play925071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 925071003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play925071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1075"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1075 == nil then
				arg_13_1.var_.actorSpriteComps1075 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps1075 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 1, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps1075 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1075 = nil
			end

			local var_16_8 = arg_13_1.actors_["1075"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos1075 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1075", 3)

				local var_16_10 = var_16_8.childCount

				for iter_16_4 = 0, var_16_10 - 1 do
					local var_16_11 = var_16_8:GetChild(iter_16_4)

					if var_16_11.name == "split_1" or not string.find(var_16_11.name, "split") then
						var_16_11.gameObject:SetActive(true)
					else
						var_16_11.gameObject:SetActive(false)
					end
				end
			end

			local var_16_12 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_12 then
				local var_16_13 = (arg_13_1.time_ - var_16_9) / var_16_12
				local var_16_14 = Vector3.New(-43, -310.5, -413.5)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1075, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-43, -310.5, -413.5)
			end

			local var_16_15 = 0
			local var_16_16 = 0.525

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[381].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(925071003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 21
				local var_16_21 = utf8.len(var_16_19)
				local var_16_22 = var_16_20 <= 0 and var_16_16 or var_16_16 * (var_16_21 / var_16_20)

				if var_16_22 > 0 and var_16_16 < var_16_22 then
					arg_13_1.talkMaxDuration = var_16_22

					if var_16_22 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_19
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_23 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_23 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_23

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_23 and arg_13_1.time_ < var_16_15 + var_16_23 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
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
	Play925071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 925071004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play925071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1075"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1075 == nil then
				arg_17_1.var_.actorSpriteComps1075 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps1075 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1075:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps1075 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1075 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.8

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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(925071004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 32
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
	Play925071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 925071005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play925071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1075"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1075 == nil then
				arg_21_1.var_.actorSpriteComps1075 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps1075 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps1075 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1075 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.925

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[381].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(925071005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 37
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play925071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 925071006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play925071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1075"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1075 == nil then
				arg_25_1.var_.actorSpriteComps1075 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps1075 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps1075 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1075 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.225

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(925071006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 9
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play925071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 925071007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play925071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.05

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_2 = arg_29_1:GetWordFromCfg(925071007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 2
				local var_32_5 = utf8.len(var_32_3)
				local var_32_6 = var_32_4 <= 0 and var_32_1 or var_32_1 * (var_32_5 / var_32_4)

				if var_32_6 > 0 and var_32_1 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_7 and arg_29_1.time_ < var_32_0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play925071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 925071008
		arg_33_1.duration_ = 8.4

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play925071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "I05"

			if arg_33_1.bgs_[var_36_0] == nil then
				local var_36_1 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_0)
				var_36_1.name = var_36_0
				var_36_1.transform.parent = arg_33_1.stage_.transform
				var_36_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_0] = var_36_1
			end

			local var_36_2 = 1.36666666666667

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				local var_36_3 = manager.ui.mainCamera.transform.localPosition
				local var_36_4 = Vector3.New(0, 0, 10) + Vector3.New(var_36_3.x, var_36_3.y, 0)
				local var_36_5 = arg_33_1.bgs_.I05

				var_36_5.transform.localPosition = var_36_4
				var_36_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_6 = var_36_5:GetComponent("SpriteRenderer")

				if var_36_6 and var_36_6.sprite then
					local var_36_7 = (var_36_5.transform.localPosition - var_36_3).z
					local var_36_8 = manager.ui.mainCameraCom_
					local var_36_9 = 2 * var_36_7 * Mathf.Tan(var_36_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_10 = var_36_9 * var_36_8.aspect
					local var_36_11 = var_36_6.sprite.bounds.size.x
					local var_36_12 = var_36_6.sprite.bounds.size.y
					local var_36_13 = var_36_10 / var_36_11
					local var_36_14 = var_36_9 / var_36_12
					local var_36_15 = var_36_14 < var_36_13 and var_36_13 or var_36_14

					var_36_5.transform.localScale = Vector3.New(var_36_15, var_36_15, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "I05" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_16 = 1.36666666666667

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			local var_36_17 = 0.3

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end

			local var_36_18 = 0

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_19 = 1.36666666666667

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_19 then
				local var_36_20 = (arg_33_1.time_ - var_36_18) / var_36_19
				local var_36_21 = Color.New(0, 0, 0)

				var_36_21.a = Mathf.Lerp(0, 1, var_36_20)
				arg_33_1.mask_.color = var_36_21
			end

			if arg_33_1.time_ >= var_36_18 + var_36_19 and arg_33_1.time_ < var_36_18 + var_36_19 + arg_36_0 then
				local var_36_22 = Color.New(0, 0, 0)

				var_36_22.a = 1
				arg_33_1.mask_.color = var_36_22
			end

			local var_36_23 = 1.36666666666667

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_24 = 2.034

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 then
				local var_36_25 = (arg_33_1.time_ - var_36_23) / var_36_24
				local var_36_26 = Color.New(0, 0, 0)

				var_36_26.a = Mathf.Lerp(1, 0, var_36_25)
				arg_33_1.mask_.color = var_36_26
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 then
				local var_36_27 = Color.New(0, 0, 0)
				local var_36_28 = 0

				arg_33_1.mask_.enabled = false
				var_36_27.a = var_36_28
				arg_33_1.mask_.color = var_36_27
			end

			local var_36_29 = arg_33_1.actors_["1075"]
			local var_36_30 = 3.20066666666667

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 and not isNil(var_36_29) and arg_33_1.var_.actorSpriteComps1075 == nil then
				arg_33_1.var_.actorSpriteComps1075 = var_36_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_31 = 0.2

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_31 and not isNil(var_36_29) then
				local var_36_32 = (arg_33_1.time_ - var_36_30) / var_36_31

				if arg_33_1.var_.actorSpriteComps1075 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								local var_36_33 = Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor1.r, var_36_32)
								local var_36_34 = Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor1.g, var_36_32)
								local var_36_35 = Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor1.b, var_36_32)

								iter_36_3.color = Color.New(var_36_33, var_36_34, var_36_35)
							else
								local var_36_36 = Mathf.Lerp(iter_36_3.color.r, 1, var_36_32)

								iter_36_3.color = Color.New(var_36_36, var_36_36, var_36_36)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_30 + var_36_31 and arg_33_1.time_ < var_36_30 + var_36_31 + arg_36_0 and not isNil(var_36_29) and arg_33_1.var_.actorSpriteComps1075 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_36_5 then
						if arg_33_1.isInRecall_ then
							iter_36_5.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1075 = nil
			end

			local var_36_37 = arg_33_1.actors_["1075"].transform
			local var_36_38 = 1.36666666666667

			if var_36_38 < arg_33_1.time_ and arg_33_1.time_ <= var_36_38 + arg_36_0 then
				arg_33_1.var_.moveOldPos1075 = var_36_37.localPosition
				var_36_37.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1075", 7)

				local var_36_39 = var_36_37.childCount

				for iter_36_6 = 0, var_36_39 - 1 do
					local var_36_40 = var_36_37:GetChild(iter_36_6)

					if var_36_40.name == "" or not string.find(var_36_40.name, "split") then
						var_36_40.gameObject:SetActive(true)
					else
						var_36_40.gameObject:SetActive(false)
					end
				end
			end

			local var_36_41 = 0.001

			if var_36_38 <= arg_33_1.time_ and arg_33_1.time_ < var_36_38 + var_36_41 then
				local var_36_42 = (arg_33_1.time_ - var_36_38) / var_36_41
				local var_36_43 = Vector3.New(0, -2000, 0)

				var_36_37.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1075, var_36_43, var_36_42)
			end

			if arg_33_1.time_ >= var_36_38 + var_36_41 and arg_33_1.time_ < var_36_38 + var_36_41 + arg_36_0 then
				var_36_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_44 = arg_33_1.actors_["1075"].transform
			local var_36_45 = 3.23333333333333

			if var_36_45 < arg_33_1.time_ and arg_33_1.time_ <= var_36_45 + arg_36_0 then
				arg_33_1.var_.moveOldPos1075 = var_36_44.localPosition
				var_36_44.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1075", 3)

				local var_36_46 = var_36_44.childCount

				for iter_36_7 = 0, var_36_46 - 1 do
					local var_36_47 = var_36_44:GetChild(iter_36_7)

					if var_36_47.name == "split_3" or not string.find(var_36_47.name, "split") then
						var_36_47.gameObject:SetActive(true)
					else
						var_36_47.gameObject:SetActive(false)
					end
				end
			end

			local var_36_48 = 0.001

			if var_36_45 <= arg_33_1.time_ and arg_33_1.time_ < var_36_45 + var_36_48 then
				local var_36_49 = (arg_33_1.time_ - var_36_45) / var_36_48
				local var_36_50 = Vector3.New(-43, -310.5, -413.5)

				var_36_44.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1075, var_36_50, var_36_49)
			end

			if arg_33_1.time_ >= var_36_45 + var_36_48 and arg_33_1.time_ < var_36_45 + var_36_48 + arg_36_0 then
				var_36_44.localPosition = Vector3.New(-43, -310.5, -413.5)
			end

			local var_36_51 = arg_33_1.actors_["1075"]
			local var_36_52 = 3.20066666666667

			if var_36_52 < arg_33_1.time_ and arg_33_1.time_ <= var_36_52 + arg_36_0 then
				local var_36_53 = var_36_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_53 then
					arg_33_1.var_.alphaOldValue1075 = var_36_53.alpha
					arg_33_1.var_.characterEffect1075 = var_36_53
				end

				arg_33_1.var_.alphaOldValue1075 = 0
			end

			local var_36_54 = 0.166

			if var_36_52 <= arg_33_1.time_ and arg_33_1.time_ < var_36_52 + var_36_54 then
				local var_36_55 = (arg_33_1.time_ - var_36_52) / var_36_54
				local var_36_56 = Mathf.Lerp(arg_33_1.var_.alphaOldValue1075, 1, var_36_55)

				if arg_33_1.var_.characterEffect1075 then
					arg_33_1.var_.characterEffect1075.alpha = var_36_56
				end
			end

			if arg_33_1.time_ >= var_36_52 + var_36_54 and arg_33_1.time_ < var_36_52 + var_36_54 + arg_36_0 and arg_33_1.var_.characterEffect1075 then
				arg_33_1.var_.characterEffect1075.alpha = 1
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_57 = 3.40066666666667
			local var_36_58 = 0.25

			if var_36_57 < arg_33_1.time_ and arg_33_1.time_ <= var_36_57 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_59 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_59:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_60 = arg_33_1:FormatText(StoryNameCfg[381].name)

				arg_33_1.leftNameTxt_.text = var_36_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_61 = arg_33_1:GetWordFromCfg(925071008)
				local var_36_62 = arg_33_1:FormatText(var_36_61.content)

				arg_33_1.text_.text = var_36_62

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_63 = 10
				local var_36_64 = utf8.len(var_36_62)
				local var_36_65 = var_36_63 <= 0 and var_36_58 or var_36_58 * (var_36_64 / var_36_63)

				if var_36_65 > 0 and var_36_58 < var_36_65 then
					arg_33_1.talkMaxDuration = var_36_65
					var_36_57 = var_36_57 + 0.3

					if var_36_65 + var_36_57 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_65 + var_36_57
					end
				end

				arg_33_1.text_.text = var_36_62
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_66 = var_36_57 + 0.3
			local var_36_67 = math.max(var_36_58, arg_33_1.talkMaxDuration)

			if var_36_66 <= arg_33_1.time_ and arg_33_1.time_ < var_36_66 + var_36_67 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_66) / var_36_67

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_66 + var_36_67 and arg_33_1.time_ < var_36_66 + var_36_67 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1075",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play925071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 925071009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play925071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1075"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1075 == nil then
				arg_39_1.var_.actorSpriteComps1075 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps1075 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 0.5, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps1075 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps1075 = nil
			end

			local var_42_8 = 0
			local var_42_9 = 0.25

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_10 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_11 = arg_39_1:GetWordFromCfg(925071009)
				local var_42_12 = arg_39_1:FormatText(var_42_11.content)

				arg_39_1.text_.text = var_42_12

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 10
				local var_42_14 = utf8.len(var_42_12)
				local var_42_15 = var_42_13 <= 0 and var_42_9 or var_42_9 * (var_42_14 / var_42_13)

				if var_42_15 > 0 and var_42_9 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_12
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play925071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 925071010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play925071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1075"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1075 == nil then
				arg_43_1.var_.actorSpriteComps1075 = var_46_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.actorSpriteComps1075 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_4 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor1.r, var_46_3)
								local var_46_5 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor1.g, var_46_3)
								local var_46_6 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor1.b, var_46_3)

								iter_46_1.color = Color.New(var_46_4, var_46_5, var_46_6)
							else
								local var_46_7 = Mathf.Lerp(iter_46_1.color.r, 1, var_46_3)

								iter_46_1.color = Color.New(var_46_7, var_46_7, var_46_7)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.actorSpriteComps1075 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps1075 = nil
			end

			local var_46_8 = arg_43_1.actors_["1075"].transform
			local var_46_9 = 0

			if var_46_9 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.var_.moveOldPos1075 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1075", 3)

				local var_46_10 = var_46_8.childCount

				for iter_46_4 = 0, var_46_10 - 1 do
					local var_46_11 = var_46_8:GetChild(iter_46_4)

					if var_46_11.name == "split_4" or not string.find(var_46_11.name, "split") then
						var_46_11.gameObject:SetActive(true)
					else
						var_46_11.gameObject:SetActive(false)
					end
				end
			end

			local var_46_12 = 0.001

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_9) / var_46_12
				local var_46_14 = Vector3.New(-43, -310.5, -413.5)

				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1075, var_46_14, var_46_13)
			end

			if arg_43_1.time_ >= var_46_9 + var_46_12 and arg_43_1.time_ < var_46_9 + var_46_12 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(-43, -310.5, -413.5)
			end

			local var_46_15 = 0
			local var_46_16 = 0.325

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[381].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(925071010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 13
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_23 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_23 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_23

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_23 and arg_43_1.time_ < var_46_15 + var_46_23 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
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
	Play925071011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 925071011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play925071012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1075"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1075 == nil then
				arg_47_1.var_.actorSpriteComps1075 = var_50_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.actorSpriteComps1075 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								local var_50_4 = Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, var_50_3)
								local var_50_5 = Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, var_50_3)
								local var_50_6 = Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, var_50_3)

								iter_50_1.color = Color.New(var_50_4, var_50_5, var_50_6)
							else
								local var_50_7 = Mathf.Lerp(iter_50_1.color.r, 0.5, var_50_3)

								iter_50_1.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.actorSpriteComps1075 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_50_3 then
						if arg_47_1.isInRecall_ then
							iter_50_3.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps1075 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 0.95

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_10 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_11 = arg_47_1:GetWordFromCfg(925071011)
				local var_50_12 = arg_47_1:FormatText(var_50_11.content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 38
				local var_50_14 = utf8.len(var_50_12)
				local var_50_15 = var_50_13 <= 0 and var_50_9 or var_50_9 * (var_50_14 / var_50_13)

				if var_50_15 > 0 and var_50_9 < var_50_15 then
					arg_47_1.talkMaxDuration = var_50_15

					if var_50_15 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_15 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play925071012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 925071012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play925071013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1075"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1075 == nil then
				arg_51_1.var_.actorSpriteComps1075 = var_54_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.actorSpriteComps1075 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								local var_54_4 = Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, var_54_3)
								local var_54_5 = Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, var_54_3)
								local var_54_6 = Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, var_54_3)

								iter_54_1.color = Color.New(var_54_4, var_54_5, var_54_6)
							else
								local var_54_7 = Mathf.Lerp(iter_54_1.color.r, 1, var_54_3)

								iter_54_1.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.actorSpriteComps1075 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_54_3 then
						if arg_51_1.isInRecall_ then
							iter_54_3.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps1075 = nil
			end

			local var_54_8 = arg_51_1.actors_["1075"].transform
			local var_54_9 = 0

			if var_54_9 < arg_51_1.time_ and arg_51_1.time_ <= var_54_9 + arg_54_0 then
				arg_51_1.var_.moveOldPos1075 = var_54_8.localPosition
				var_54_8.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1075", 3)

				local var_54_10 = var_54_8.childCount

				for iter_54_4 = 0, var_54_10 - 1 do
					local var_54_11 = var_54_8:GetChild(iter_54_4)

					if var_54_11.name == "split_2" or not string.find(var_54_11.name, "split") then
						var_54_11.gameObject:SetActive(true)
					else
						var_54_11.gameObject:SetActive(false)
					end
				end
			end

			local var_54_12 = 0.001

			if var_54_9 <= arg_51_1.time_ and arg_51_1.time_ < var_54_9 + var_54_12 then
				local var_54_13 = (arg_51_1.time_ - var_54_9) / var_54_12
				local var_54_14 = Vector3.New(-43, -310.5, -413.5)

				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1075, var_54_14, var_54_13)
			end

			if arg_51_1.time_ >= var_54_9 + var_54_12 and arg_51_1.time_ < var_54_9 + var_54_12 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(-43, -310.5, -413.5)
			end

			local var_54_15 = 0
			local var_54_16 = 0.575

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[381].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(925071012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 23
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_23 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_23 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_23

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_23 and arg_51_1.time_ < var_54_15 + var_54_23 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
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
	Play925071013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 925071013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
			arg_55_1.auto_ = false
		end

		function arg_55_1.playNext_(arg_57_0)
			arg_55_1.onStoryFinished_()
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1075"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1075 == nil then
				arg_55_1.var_.actorSpriteComps1075 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps1075 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1075:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								local var_58_4 = Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, var_58_3)
								local var_58_5 = Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, var_58_3)
								local var_58_6 = Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, var_58_3)

								iter_58_1.color = Color.New(var_58_4, var_58_5, var_58_6)
							else
								local var_58_7 = Mathf.Lerp(iter_58_1.color.r, 0.5, var_58_3)

								iter_58_1.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps1075 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1075:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps1075 = nil
			end

			local var_58_8 = arg_55_1.actors_["1075"].transform
			local var_58_9 = 0

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.var_.moveOldPos1075 = var_58_8.localPosition
				var_58_8.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1075", 7)

				local var_58_10 = var_58_8.childCount

				for iter_58_4 = 0, var_58_10 - 1 do
					local var_58_11 = var_58_8:GetChild(iter_58_4)

					if var_58_11.name == "" or not string.find(var_58_11.name, "split") then
						var_58_11.gameObject:SetActive(true)
					else
						var_58_11.gameObject:SetActive(false)
					end
				end
			end

			local var_58_12 = 0.001

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_12 then
				local var_58_13 = (arg_55_1.time_ - var_58_9) / var_58_12
				local var_58_14 = Vector3.New(0, -2000, 0)

				var_58_8.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1075, var_58_14, var_58_13)
			end

			if arg_55_1.time_ >= var_58_9 + var_58_12 and arg_55_1.time_ < var_58_9 + var_58_12 + arg_58_0 then
				var_58_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_15 = 0
			local var_58_16 = 0.675

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_17 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_18 = arg_55_1:GetWordFromCfg(925071013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_20 = 27
				local var_58_21 = utf8.len(var_58_19)
				local var_58_22 = var_58_20 <= 0 and var_58_16 or var_58_16 * (var_58_21 / var_58_20)

				if var_58_22 > 0 and var_58_16 < var_58_22 then
					arg_55_1.talkMaxDuration = var_58_22

					if var_58_22 + var_58_15 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_15
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_23 = math.max(var_58_16, arg_55_1.talkMaxDuration)

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_23 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_15) / var_58_23

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_15 + var_58_23 and arg_55_1.time_ < var_58_15 + var_58_23 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06b",
		"TextureConfig/Background/I05"
	},
	voices = {}
}
