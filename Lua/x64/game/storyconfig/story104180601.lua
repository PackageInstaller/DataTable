return {
	Play418061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418061001
		arg_1_1.duration_ = 10.23

		local var_1_0 = {
			ja = 10.232999999999,
			CriLanguages = 7.499999999999,
			zh = 7.499999999999
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play418061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J03f"

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
				local var_4_5 = arg_1_1.bgs_.J03f

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
					if iter_4_0 ~= "J03f" then
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

			local var_4_24 = "1073"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1073")

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

			local var_4_28 = arg_1_1.actors_["1073"]
			local var_4_29 = 1.799999999999

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1073 == nil then
				arg_1_1.var_.actorSpriteComps1073 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps1073 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps1073 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1073 = nil
			end

			local var_4_36 = arg_1_1.actors_["1073"].transform
			local var_4_37 = 1.799999999999

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos1073 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1073", 3)

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
				local var_4_42 = Vector3.New(38.6, -414.5, -207.2)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1073, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(38.6, -414.5, -207.2)
			end

			local var_4_43 = arg_1_1.actors_["1073"]
			local var_4_44 = 1.799999999999

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue1073 = var_4_45.alpha
					arg_1_1.var_.characterEffect1073 = var_4_45
				end

				arg_1_1.var_.alphaOldValue1073 = 0
			end

			local var_4_46 = 0.200000000001

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1073, 1, var_4_47)

				if arg_1_1.var_.characterEffect1073 then
					arg_1_1.var_.characterEffect1073.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect1073 then
				arg_1_1.var_.characterEffect1073.alpha = 1
			end

			local var_4_49 = 0.05
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_140", "se_story_140_amb_valley", "")
			end

			local var_4_53 = 0.4
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 1.999999999999
			local var_4_60 = 0.725

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

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[380].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(418061001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061001", "story_v_side_old_418061.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061001", "story_v_side_old_418061.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_side_old_418061", "418061001", "story_v_side_old_418061.awb")

						arg_1_1:RecordAudio("418061001", var_4_69)
						arg_1_1:RecordAudio("418061001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061001", "story_v_side_old_418061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061001", "story_v_side_old_418061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

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
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.799999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play418061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418061002
		arg_8_1.duration_ = 10.23

		local var_8_0 = {
			ja = 10.233,
			CriLanguages = 8.733,
			zh = 8.733
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play418061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1072"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1072")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(var_11_1, arg_8_1.canvasGo_.transform)

					var_11_2.transform:SetSiblingIndex(1)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs(var_11_3) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_4 = arg_8_1.actors_["1072"]
			local var_11_5 = 0

			if var_11_5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1072 == nil then
				arg_8_1.var_.actorSpriteComps1072 = var_11_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_6 and not isNil(var_11_4) then
				local var_11_7 = (arg_8_1.time_ - var_11_5) / var_11_6

				if arg_8_1.var_.actorSpriteComps1072 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_11_3 then
							if arg_8_1.isInRecall_ then
								local var_11_8 = Mathf.Lerp(iter_11_3.color.r, arg_8_1.hightColor1.r, var_11_7)
								local var_11_9 = Mathf.Lerp(iter_11_3.color.g, arg_8_1.hightColor1.g, var_11_7)
								local var_11_10 = Mathf.Lerp(iter_11_3.color.b, arg_8_1.hightColor1.b, var_11_7)

								iter_11_3.color = Color.New(var_11_8, var_11_9, var_11_10)
							else
								local var_11_11 = Mathf.Lerp(iter_11_3.color.r, 1, var_11_7)

								iter_11_3.color = Color.New(var_11_11, var_11_11, var_11_11)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_5 + var_11_6 and arg_8_1.time_ < var_11_5 + var_11_6 + arg_11_0 and not isNil(var_11_4) and arg_8_1.var_.actorSpriteComps1072 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_11_5 then
						if arg_8_1.isInRecall_ then
							iter_11_5.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_11_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1072 = nil
			end

			local var_11_12 = arg_8_1.actors_["1073"]
			local var_11_13 = 0

			if var_11_13 < arg_8_1.time_ and arg_8_1.time_ <= var_11_13 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps1073 == nil then
				arg_8_1.var_.actorSpriteComps1073 = var_11_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_14 = 0.2

			if var_11_13 <= arg_8_1.time_ and arg_8_1.time_ < var_11_13 + var_11_14 and not isNil(var_11_12) then
				local var_11_15 = (arg_8_1.time_ - var_11_13) / var_11_14

				if arg_8_1.var_.actorSpriteComps1073 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_11_7 then
							if arg_8_1.isInRecall_ then
								local var_11_16 = Mathf.Lerp(iter_11_7.color.r, arg_8_1.hightColor2.r, var_11_15)
								local var_11_17 = Mathf.Lerp(iter_11_7.color.g, arg_8_1.hightColor2.g, var_11_15)
								local var_11_18 = Mathf.Lerp(iter_11_7.color.b, arg_8_1.hightColor2.b, var_11_15)

								iter_11_7.color = Color.New(var_11_16, var_11_17, var_11_18)
							else
								local var_11_19 = Mathf.Lerp(iter_11_7.color.r, 0.5, var_11_15)

								iter_11_7.color = Color.New(var_11_19, var_11_19, var_11_19)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= var_11_13 + var_11_14 and arg_8_1.time_ < var_11_13 + var_11_14 + arg_11_0 and not isNil(var_11_12) and arg_8_1.var_.actorSpriteComps1073 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_11_9 then
						if arg_8_1.isInRecall_ then
							iter_11_9.color = arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_11_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_8_1.var_.actorSpriteComps1073 = nil
			end

			local var_11_20 = arg_8_1.actors_["1072"].transform
			local var_11_21 = 0

			if var_11_21 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				arg_8_1.var_.moveOldPos1072 = var_11_20.localPosition
				var_11_20.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1072", 3)

				local var_11_22 = var_11_20.childCount

				for iter_11_10 = 0, var_11_22 - 1 do
					local var_11_23 = var_11_20:GetChild(iter_11_10)

					if var_11_23.name == "" or not string.find(var_11_23.name, "split") then
						var_11_23.gameObject:SetActive(true)
					else
						var_11_23.gameObject:SetActive(false)
					end
				end
			end

			local var_11_24 = 0.001

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_24 then
				local var_11_25 = (arg_8_1.time_ - var_11_21) / var_11_24
				local var_11_26 = Vector3.New(30.1, -428.9, -184.1)

				var_11_20.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1072, var_11_26, var_11_25)
			end

			if arg_8_1.time_ >= var_11_21 + var_11_24 and arg_8_1.time_ < var_11_21 + var_11_24 + arg_11_0 then
				var_11_20.localPosition = Vector3.New(30.1, -428.9, -184.1)
			end

			local var_11_27 = arg_8_1.actors_["1073"].transform
			local var_11_28 = 0

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1.var_.moveOldPos1073 = var_11_27.localPosition
				var_11_27.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1073", 7)

				local var_11_29 = var_11_27.childCount

				for iter_11_11 = 0, var_11_29 - 1 do
					local var_11_30 = var_11_27:GetChild(iter_11_11)

					if var_11_30.name == "" or not string.find(var_11_30.name, "split") then
						var_11_30.gameObject:SetActive(true)
					else
						var_11_30.gameObject:SetActive(false)
					end
				end
			end

			local var_11_31 = 0.001

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_31 then
				local var_11_32 = (arg_8_1.time_ - var_11_28) / var_11_31
				local var_11_33 = Vector3.New(0, -2000, 0)

				var_11_27.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1073, var_11_33, var_11_32)
			end

			if arg_8_1.time_ >= var_11_28 + var_11_31 and arg_8_1.time_ < var_11_28 + var_11_31 + arg_11_0 then
				var_11_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_11_34 = 0
			local var_11_35 = 0.925

			if var_11_34 < arg_8_1.time_ and arg_8_1.time_ <= var_11_34 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_36 = arg_8_1:FormatText(StoryNameCfg[379].name)

				arg_8_1.leftNameTxt_.text = var_11_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_37 = arg_8_1:GetWordFromCfg(418061002)
				local var_11_38 = arg_8_1:FormatText(var_11_37.content)

				arg_8_1.text_.text = var_11_38

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_39 = 37
				local var_11_40 = utf8.len(var_11_38)
				local var_11_41 = var_11_39 <= 0 and var_11_35 or var_11_35 * (var_11_40 / var_11_39)

				if var_11_41 > 0 and var_11_35 < var_11_41 then
					arg_8_1.talkMaxDuration = var_11_41

					if var_11_41 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_41 + var_11_34
					end
				end

				arg_8_1.text_.text = var_11_38
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061002", "story_v_side_old_418061.awb") ~= 0 then
					local var_11_42 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061002", "story_v_side_old_418061.awb") / 1000

					if var_11_42 + var_11_34 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_42 + var_11_34
					end

					if var_11_37.prefab_name ~= "" and arg_8_1.actors_[var_11_37.prefab_name] ~= nil then
						local var_11_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_37.prefab_name].transform, "story_v_side_old_418061", "418061002", "story_v_side_old_418061.awb")

						arg_8_1:RecordAudio("418061002", var_11_43)
						arg_8_1:RecordAudio("418061002", var_11_43)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061002", "story_v_side_old_418061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061002", "story_v_side_old_418061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_44 = math.max(var_11_35, arg_8_1.talkMaxDuration)

			if var_11_34 <= arg_8_1.time_ and arg_8_1.time_ < var_11_34 + var_11_44 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_34) / var_11_44

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_34 + var_11_44 and arg_8_1.time_ < var_11_34 + var_11_44 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play418061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418061003
		arg_12_1.duration_ = 15.5

		local var_12_0 = {
			ja = 15.5,
			CriLanguages = 10.266,
			zh = 10.266
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
				arg_12_0:Play418061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1073"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps1073 == nil then
				arg_12_1.var_.actorSpriteComps1073 = var_15_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.actorSpriteComps1073 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								local var_15_4 = Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, var_15_3)
								local var_15_5 = Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, var_15_3)
								local var_15_6 = Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, var_15_3)

								iter_15_1.color = Color.New(var_15_4, var_15_5, var_15_6)
							else
								local var_15_7 = Mathf.Lerp(iter_15_1.color.r, 1, var_15_3)

								iter_15_1.color = Color.New(var_15_7, var_15_7, var_15_7)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.actorSpriteComps1073 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_15_3 then
						if arg_12_1.isInRecall_ then
							iter_15_3.color = arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_15_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1073 = nil
			end

			local var_15_8 = arg_12_1.actors_["1072"]
			local var_15_9 = 0

			if var_15_9 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps1072 == nil then
				arg_12_1.var_.actorSpriteComps1072 = var_15_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_10 = 0.2

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 and not isNil(var_15_8) then
				local var_15_11 = (arg_12_1.time_ - var_15_9) / var_15_10

				if arg_12_1.var_.actorSpriteComps1072 then
					for iter_15_4, iter_15_5 in pairs(arg_12_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_15_5 then
							if arg_12_1.isInRecall_ then
								local var_15_12 = Mathf.Lerp(iter_15_5.color.r, arg_12_1.hightColor2.r, var_15_11)
								local var_15_13 = Mathf.Lerp(iter_15_5.color.g, arg_12_1.hightColor2.g, var_15_11)
								local var_15_14 = Mathf.Lerp(iter_15_5.color.b, arg_12_1.hightColor2.b, var_15_11)

								iter_15_5.color = Color.New(var_15_12, var_15_13, var_15_14)
							else
								local var_15_15 = Mathf.Lerp(iter_15_5.color.r, 0.5, var_15_11)

								iter_15_5.color = Color.New(var_15_15, var_15_15, var_15_15)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 and not isNil(var_15_8) and arg_12_1.var_.actorSpriteComps1072 then
				for iter_15_6, iter_15_7 in pairs(arg_12_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_15_7 then
						if arg_12_1.isInRecall_ then
							iter_15_7.color = arg_12_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_15_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_12_1.var_.actorSpriteComps1072 = nil
			end

			local var_15_16 = arg_12_1.actors_["1072"].transform
			local var_15_17 = 0

			if var_15_17 < arg_12_1.time_ and arg_12_1.time_ <= var_15_17 + arg_15_0 then
				arg_12_1.var_.moveOldPos1072 = var_15_16.localPosition
				var_15_16.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1072", 4)

				local var_15_18 = var_15_16.childCount

				for iter_15_8 = 0, var_15_18 - 1 do
					local var_15_19 = var_15_16:GetChild(iter_15_8)

					if var_15_19.name == "" or not string.find(var_15_19.name, "split") then
						var_15_19.gameObject:SetActive(true)
					else
						var_15_19.gameObject:SetActive(false)
					end
				end
			end

			local var_15_20 = 0.001

			if var_15_17 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_17) / var_15_20
				local var_15_22 = Vector3.New(509.5, -428.9, -184.1)

				var_15_16.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1072, var_15_22, var_15_21)
			end

			if arg_12_1.time_ >= var_15_17 + var_15_20 and arg_12_1.time_ < var_15_17 + var_15_20 + arg_15_0 then
				var_15_16.localPosition = Vector3.New(509.5, -428.9, -184.1)
			end

			local var_15_23 = arg_12_1.actors_["1073"].transform
			local var_15_24 = 0

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1.var_.moveOldPos1073 = var_15_23.localPosition
				var_15_23.localScale = Vector3.New(1, 1, 1)

				arg_12_1:CheckSpriteTmpPos("1073", 2)

				local var_15_25 = var_15_23.childCount

				for iter_15_9 = 0, var_15_25 - 1 do
					local var_15_26 = var_15_23:GetChild(iter_15_9)

					if var_15_26.name == "" or not string.find(var_15_26.name, "split") then
						var_15_26.gameObject:SetActive(true)
					else
						var_15_26.gameObject:SetActive(false)
					end
				end
			end

			local var_15_27 = 0.001

			if var_15_24 <= arg_12_1.time_ and arg_12_1.time_ < var_15_24 + var_15_27 then
				local var_15_28 = (arg_12_1.time_ - var_15_24) / var_15_27
				local var_15_29 = Vector3.New(-405.76, -414.5, -207.2)

				var_15_23.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1073, var_15_29, var_15_28)
			end

			if arg_12_1.time_ >= var_15_24 + var_15_27 and arg_12_1.time_ < var_15_24 + var_15_27 + arg_15_0 then
				var_15_23.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_15_30 = 0
			local var_15_31 = 1.425

			if var_15_30 < arg_12_1.time_ and arg_12_1.time_ <= var_15_30 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_32 = arg_12_1:FormatText(StoryNameCfg[380].name)

				arg_12_1.leftNameTxt_.text = var_15_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_33 = arg_12_1:GetWordFromCfg(418061003)
				local var_15_34 = arg_12_1:FormatText(var_15_33.content)

				arg_12_1.text_.text = var_15_34

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_35 = 57
				local var_15_36 = utf8.len(var_15_34)
				local var_15_37 = var_15_35 <= 0 and var_15_31 or var_15_31 * (var_15_36 / var_15_35)

				if var_15_37 > 0 and var_15_31 < var_15_37 then
					arg_12_1.talkMaxDuration = var_15_37

					if var_15_37 + var_15_30 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_37 + var_15_30
					end
				end

				arg_12_1.text_.text = var_15_34
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061003", "story_v_side_old_418061.awb") ~= 0 then
					local var_15_38 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061003", "story_v_side_old_418061.awb") / 1000

					if var_15_38 + var_15_30 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_38 + var_15_30
					end

					if var_15_33.prefab_name ~= "" and arg_12_1.actors_[var_15_33.prefab_name] ~= nil then
						local var_15_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_33.prefab_name].transform, "story_v_side_old_418061", "418061003", "story_v_side_old_418061.awb")

						arg_12_1:RecordAudio("418061003", var_15_39)
						arg_12_1:RecordAudio("418061003", var_15_39)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061003", "story_v_side_old_418061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061003", "story_v_side_old_418061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_40 = math.max(var_15_31, arg_12_1.talkMaxDuration)

			if var_15_30 <= arg_12_1.time_ and arg_12_1.time_ < var_15_30 + var_15_40 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_30) / var_15_40

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_30 + var_15_40 and arg_12_1.time_ < var_15_30 + var_15_40 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1073",
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
	Play418061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418061004
		arg_16_1.duration_ = 8.77

		local var_16_0 = {
			ja = 8.766,
			CriLanguages = 6.7,
			zh = 6.7
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1072"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1072 == nil then
				arg_16_1.var_.actorSpriteComps1072 = var_19_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.actorSpriteComps1072 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								local var_19_4 = Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor1.r, var_19_3)
								local var_19_5 = Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor1.g, var_19_3)
								local var_19_6 = Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor1.b, var_19_3)

								iter_19_1.color = Color.New(var_19_4, var_19_5, var_19_6)
							else
								local var_19_7 = Mathf.Lerp(iter_19_1.color.r, 1, var_19_3)

								iter_19_1.color = Color.New(var_19_7, var_19_7, var_19_7)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.actorSpriteComps1072 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_19_3 then
						if arg_16_1.isInRecall_ then
							iter_19_3.color = arg_16_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_19_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps1072 = nil
			end

			local var_19_8 = arg_16_1.actors_["1073"]
			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps1073 == nil then
				arg_16_1.var_.actorSpriteComps1073 = var_19_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_10 = 0.2

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 and not isNil(var_19_8) then
				local var_19_11 = (arg_16_1.time_ - var_19_9) / var_19_10

				if arg_16_1.var_.actorSpriteComps1073 then
					for iter_19_4, iter_19_5 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_19_5 then
							if arg_16_1.isInRecall_ then
								local var_19_12 = Mathf.Lerp(iter_19_5.color.r, arg_16_1.hightColor2.r, var_19_11)
								local var_19_13 = Mathf.Lerp(iter_19_5.color.g, arg_16_1.hightColor2.g, var_19_11)
								local var_19_14 = Mathf.Lerp(iter_19_5.color.b, arg_16_1.hightColor2.b, var_19_11)

								iter_19_5.color = Color.New(var_19_12, var_19_13, var_19_14)
							else
								local var_19_15 = Mathf.Lerp(iter_19_5.color.r, 0.5, var_19_11)

								iter_19_5.color = Color.New(var_19_15, var_19_15, var_19_15)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 and not isNil(var_19_8) and arg_16_1.var_.actorSpriteComps1073 then
				for iter_19_6, iter_19_7 in pairs(arg_16_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_19_7 then
						if arg_16_1.isInRecall_ then
							iter_19_7.color = arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_19_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_16_1.var_.actorSpriteComps1073 = nil
			end

			local var_19_16 = arg_16_1.actors_["1072"].transform
			local var_19_17 = 0

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.var_.moveOldPos1072 = var_19_16.localPosition
				var_19_16.localScale = Vector3.New(1, 1, 1)

				arg_16_1:CheckSpriteTmpPos("1072", 4)

				local var_19_18 = var_19_16.childCount

				for iter_19_8 = 0, var_19_18 - 1 do
					local var_19_19 = var_19_16:GetChild(iter_19_8)

					if var_19_19.name == "split_2" or not string.find(var_19_19.name, "split") then
						var_19_19.gameObject:SetActive(true)
					else
						var_19_19.gameObject:SetActive(false)
					end
				end
			end

			local var_19_20 = 0.001

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_17) / var_19_20
				local var_19_22 = Vector3.New(509.5, -428.9, -184.1)

				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1072, var_19_22, var_19_21)
			end

			if arg_16_1.time_ >= var_19_17 + var_19_20 and arg_16_1.time_ < var_19_17 + var_19_20 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(509.5, -428.9, -184.1)
			end

			local var_19_23 = 0
			local var_19_24 = 0.7

			if var_19_23 < arg_16_1.time_ and arg_16_1.time_ <= var_19_23 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_25 = arg_16_1:FormatText(StoryNameCfg[379].name)

				arg_16_1.leftNameTxt_.text = var_19_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_26 = arg_16_1:GetWordFromCfg(418061004)
				local var_19_27 = arg_16_1:FormatText(var_19_26.content)

				arg_16_1.text_.text = var_19_27

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_28 = 28
				local var_19_29 = utf8.len(var_19_27)
				local var_19_30 = var_19_28 <= 0 and var_19_24 or var_19_24 * (var_19_29 / var_19_28)

				if var_19_30 > 0 and var_19_24 < var_19_30 then
					arg_16_1.talkMaxDuration = var_19_30

					if var_19_30 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_30 + var_19_23
					end
				end

				arg_16_1.text_.text = var_19_27
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061004", "story_v_side_old_418061.awb") ~= 0 then
					local var_19_31 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061004", "story_v_side_old_418061.awb") / 1000

					if var_19_31 + var_19_23 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_31 + var_19_23
					end

					if var_19_26.prefab_name ~= "" and arg_16_1.actors_[var_19_26.prefab_name] ~= nil then
						local var_19_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_26.prefab_name].transform, "story_v_side_old_418061", "418061004", "story_v_side_old_418061.awb")

						arg_16_1:RecordAudio("418061004", var_19_32)
						arg_16_1:RecordAudio("418061004", var_19_32)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061004", "story_v_side_old_418061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061004", "story_v_side_old_418061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_33 = math.max(var_19_24, arg_16_1.talkMaxDuration)

			if var_19_23 <= arg_16_1.time_ and arg_16_1.time_ < var_19_23 + var_19_33 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_23) / var_19_33

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_23 + var_19_33 and arg_16_1.time_ < var_19_23 + var_19_33 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play418061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418061005
		arg_20_1.duration_ = 2.1

		local var_20_0 = {
			ja = 2.1,
			CriLanguages = 1.666,
			zh = 1.666
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play418061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.2

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[379].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(418061005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 8
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061005", "story_v_side_old_418061.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061005", "story_v_side_old_418061.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_side_old_418061", "418061005", "story_v_side_old_418061.awb")

						arg_20_1:RecordAudio("418061005", var_23_9)
						arg_20_1:RecordAudio("418061005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061005", "story_v_side_old_418061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061005", "story_v_side_old_418061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play418061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418061006
		arg_24_1.duration_ = 6.97

		local var_24_0 = {
			ja = 6.966,
			CriLanguages = 4,
			zh = 4
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play418061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1073"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps1073 == nil then
				arg_24_1.var_.actorSpriteComps1073 = var_27_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.actorSpriteComps1073 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								local var_27_4 = Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor1.r, var_27_3)
								local var_27_5 = Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor1.g, var_27_3)
								local var_27_6 = Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor1.b, var_27_3)

								iter_27_1.color = Color.New(var_27_4, var_27_5, var_27_6)
							else
								local var_27_7 = Mathf.Lerp(iter_27_1.color.r, 1, var_27_3)

								iter_27_1.color = Color.New(var_27_7, var_27_7, var_27_7)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.actorSpriteComps1073 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_27_3 then
						if arg_24_1.isInRecall_ then
							iter_27_3.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1073 = nil
			end

			local var_27_8 = arg_24_1.actors_["1072"]
			local var_27_9 = 0

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps1072 == nil then
				arg_24_1.var_.actorSpriteComps1072 = var_27_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_10 = 0.2

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 and not isNil(var_27_8) then
				local var_27_11 = (arg_24_1.time_ - var_27_9) / var_27_10

				if arg_24_1.var_.actorSpriteComps1072 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_27_5 then
							if arg_24_1.isInRecall_ then
								local var_27_12 = Mathf.Lerp(iter_27_5.color.r, arg_24_1.hightColor2.r, var_27_11)
								local var_27_13 = Mathf.Lerp(iter_27_5.color.g, arg_24_1.hightColor2.g, var_27_11)
								local var_27_14 = Mathf.Lerp(iter_27_5.color.b, arg_24_1.hightColor2.b, var_27_11)

								iter_27_5.color = Color.New(var_27_12, var_27_13, var_27_14)
							else
								local var_27_15 = Mathf.Lerp(iter_27_5.color.r, 0.5, var_27_11)

								iter_27_5.color = Color.New(var_27_15, var_27_15, var_27_15)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.actorSpriteComps1072 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_27_7 then
						if arg_24_1.isInRecall_ then
							iter_27_7.color = arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_27_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps1072 = nil
			end

			local var_27_16 = arg_24_1.actors_["1073"].transform
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 then
				arg_24_1.var_.moveOldPos1073 = var_27_16.localPosition
				var_27_16.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("1073", 2)

				local var_27_18 = var_27_16.childCount

				for iter_27_8 = 0, var_27_18 - 1 do
					local var_27_19 = var_27_16:GetChild(iter_27_8)

					if var_27_19.name == "split_3" or not string.find(var_27_19.name, "split") then
						var_27_19.gameObject:SetActive(true)
					else
						var_27_19.gameObject:SetActive(false)
					end
				end
			end

			local var_27_20 = 0.001

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_20 then
				local var_27_21 = (arg_24_1.time_ - var_27_17) / var_27_20
				local var_27_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_27_16.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1073, var_27_22, var_27_21)
			end

			if arg_24_1.time_ >= var_27_17 + var_27_20 and arg_24_1.time_ < var_27_17 + var_27_20 + arg_27_0 then
				var_27_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_27_23 = 0
			local var_27_24 = 0.475

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_25 = arg_24_1:FormatText(StoryNameCfg[380].name)

				arg_24_1.leftNameTxt_.text = var_27_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_26 = arg_24_1:GetWordFromCfg(418061006)
				local var_27_27 = arg_24_1:FormatText(var_27_26.content)

				arg_24_1.text_.text = var_27_27

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_28 = 19
				local var_27_29 = utf8.len(var_27_27)
				local var_27_30 = var_27_28 <= 0 and var_27_24 or var_27_24 * (var_27_29 / var_27_28)

				if var_27_30 > 0 and var_27_24 < var_27_30 then
					arg_24_1.talkMaxDuration = var_27_30

					if var_27_30 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_23
					end
				end

				arg_24_1.text_.text = var_27_27
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061006", "story_v_side_old_418061.awb") ~= 0 then
					local var_27_31 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061006", "story_v_side_old_418061.awb") / 1000

					if var_27_31 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_23
					end

					if var_27_26.prefab_name ~= "" and arg_24_1.actors_[var_27_26.prefab_name] ~= nil then
						local var_27_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_26.prefab_name].transform, "story_v_side_old_418061", "418061006", "story_v_side_old_418061.awb")

						arg_24_1:RecordAudio("418061006", var_27_32)
						arg_24_1:RecordAudio("418061006", var_27_32)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061006", "story_v_side_old_418061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061006", "story_v_side_old_418061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_33 = math.max(var_27_24, arg_24_1.talkMaxDuration)

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_33 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_23) / var_27_33

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_23 + var_27_33 and arg_24_1.time_ < var_27_23 + var_27_33 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play418061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418061007
		arg_28_1.duration_ = 5.17

		local var_28_0 = {
			ja = 3.933,
			CriLanguages = 5.166,
			zh = 5.166
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play418061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1072"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1072 == nil then
				arg_28_1.var_.actorSpriteComps1072 = var_31_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.actorSpriteComps1072 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps1072:ToTable()) do
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

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.actorSpriteComps1072 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_31_3 then
						if arg_28_1.isInRecall_ then
							iter_31_3.color = arg_28_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_31_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1072 = nil
			end

			local var_31_8 = arg_28_1.actors_["1073"]
			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1073 == nil then
				arg_28_1.var_.actorSpriteComps1073 = var_31_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_10 = 0.2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 and not isNil(var_31_8) then
				local var_31_11 = (arg_28_1.time_ - var_31_9) / var_31_10

				if arg_28_1.var_.actorSpriteComps1073 then
					for iter_31_4, iter_31_5 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_31_5 then
							if arg_28_1.isInRecall_ then
								local var_31_12 = Mathf.Lerp(iter_31_5.color.r, arg_28_1.hightColor2.r, var_31_11)
								local var_31_13 = Mathf.Lerp(iter_31_5.color.g, arg_28_1.hightColor2.g, var_31_11)
								local var_31_14 = Mathf.Lerp(iter_31_5.color.b, arg_28_1.hightColor2.b, var_31_11)

								iter_31_5.color = Color.New(var_31_12, var_31_13, var_31_14)
							else
								local var_31_15 = Mathf.Lerp(iter_31_5.color.r, 0.5, var_31_11)

								iter_31_5.color = Color.New(var_31_15, var_31_15, var_31_15)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 and not isNil(var_31_8) and arg_28_1.var_.actorSpriteComps1073 then
				for iter_31_6, iter_31_7 in pairs(arg_28_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_31_7 then
						if arg_28_1.isInRecall_ then
							iter_31_7.color = arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_31_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_28_1.var_.actorSpriteComps1073 = nil
			end

			local var_31_16 = arg_28_1.actors_["1072"].transform
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 then
				arg_28_1.var_.moveOldPos1072 = var_31_16.localPosition
				var_31_16.localScale = Vector3.New(1, 1, 1)

				arg_28_1:CheckSpriteTmpPos("1072", 4)

				local var_31_18 = var_31_16.childCount

				for iter_31_8 = 0, var_31_18 - 1 do
					local var_31_19 = var_31_16:GetChild(iter_31_8)

					if var_31_19.name == "split_3" or not string.find(var_31_19.name, "split") then
						var_31_19.gameObject:SetActive(true)
					else
						var_31_19.gameObject:SetActive(false)
					end
				end
			end

			local var_31_20 = 0.001

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_17) / var_31_20
				local var_31_22 = Vector3.New(509.5, -428.9, -184.1)

				var_31_16.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1072, var_31_22, var_31_21)
			end

			if arg_28_1.time_ >= var_31_17 + var_31_20 and arg_28_1.time_ < var_31_17 + var_31_20 + arg_31_0 then
				var_31_16.localPosition = Vector3.New(509.5, -428.9, -184.1)
			end

			local var_31_23 = 0
			local var_31_24 = 0.4

			if var_31_23 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_25 = arg_28_1:FormatText(StoryNameCfg[379].name)

				arg_28_1.leftNameTxt_.text = var_31_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:GetWordFromCfg(418061007)
				local var_31_27 = arg_28_1:FormatText(var_31_26.content)

				arg_28_1.text_.text = var_31_27

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 16
				local var_31_29 = utf8.len(var_31_27)
				local var_31_30 = var_31_28 <= 0 and var_31_24 or var_31_24 * (var_31_29 / var_31_28)

				if var_31_30 > 0 and var_31_24 < var_31_30 then
					arg_28_1.talkMaxDuration = var_31_30

					if var_31_30 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_23
					end
				end

				arg_28_1.text_.text = var_31_27
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061007", "story_v_side_old_418061.awb") ~= 0 then
					local var_31_31 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061007", "story_v_side_old_418061.awb") / 1000

					if var_31_31 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_31 + var_31_23
					end

					if var_31_26.prefab_name ~= "" and arg_28_1.actors_[var_31_26.prefab_name] ~= nil then
						local var_31_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_26.prefab_name].transform, "story_v_side_old_418061", "418061007", "story_v_side_old_418061.awb")

						arg_28_1:RecordAudio("418061007", var_31_32)
						arg_28_1:RecordAudio("418061007", var_31_32)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061007", "story_v_side_old_418061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061007", "story_v_side_old_418061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_33 = math.max(var_31_24, arg_28_1.talkMaxDuration)

			if var_31_23 <= arg_28_1.time_ and arg_28_1.time_ < var_31_23 + var_31_33 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_23) / var_31_33

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_23 + var_31_33 and arg_28_1.time_ < var_31_23 + var_31_33 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
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
	Play418061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418061008
		arg_32_1.duration_ = 5.63

		local var_32_0 = {
			ja = 5.633,
			CriLanguages = 3.533,
			zh = 3.533
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play418061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1073"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1073 == nil then
				arg_32_1.var_.actorSpriteComps1073 = var_35_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_2 = 0.2

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.actorSpriteComps1073 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.actorSpriteComps1073 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_35_3 then
						if arg_32_1.isInRecall_ then
							iter_35_3.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_35_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1073 = nil
			end

			local var_35_8 = arg_32_1.actors_["1072"]
			local var_35_9 = 0

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1072 == nil then
				arg_32_1.var_.actorSpriteComps1072 = var_35_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_10 = 0.2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 and not isNil(var_35_8) then
				local var_35_11 = (arg_32_1.time_ - var_35_9) / var_35_10

				if arg_32_1.var_.actorSpriteComps1072 then
					for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_35_5 then
							if arg_32_1.isInRecall_ then
								local var_35_12 = Mathf.Lerp(iter_35_5.color.r, arg_32_1.hightColor2.r, var_35_11)
								local var_35_13 = Mathf.Lerp(iter_35_5.color.g, arg_32_1.hightColor2.g, var_35_11)
								local var_35_14 = Mathf.Lerp(iter_35_5.color.b, arg_32_1.hightColor2.b, var_35_11)

								iter_35_5.color = Color.New(var_35_12, var_35_13, var_35_14)
							else
								local var_35_15 = Mathf.Lerp(iter_35_5.color.r, 0.5, var_35_11)

								iter_35_5.color = Color.New(var_35_15, var_35_15, var_35_15)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.actorSpriteComps1072 then
				for iter_35_6, iter_35_7 in pairs(arg_32_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_35_7 then
						if arg_32_1.isInRecall_ then
							iter_35_7.color = arg_32_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_35_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_32_1.var_.actorSpriteComps1072 = nil
			end

			local var_35_16 = 0
			local var_35_17 = 0.35

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[380].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(418061008)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 14
				local var_35_22 = utf8.len(var_35_20)
				local var_35_23 = var_35_21 <= 0 and var_35_17 or var_35_17 * (var_35_22 / var_35_21)

				if var_35_23 > 0 and var_35_17 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23

					if var_35_23 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061008", "story_v_side_old_418061.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061008", "story_v_side_old_418061.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_side_old_418061", "418061008", "story_v_side_old_418061.awb")

						arg_32_1:RecordAudio("418061008", var_35_25)
						arg_32_1:RecordAudio("418061008", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061008", "story_v_side_old_418061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061008", "story_v_side_old_418061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_26 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_26 and arg_32_1.time_ < var_35_16 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play418061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418061009
		arg_36_1.duration_ = 7.6

		local var_36_0 = {
			ja = 6.8,
			CriLanguages = 7.6,
			zh = 7.6
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play418061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1072"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1072 == nil then
				arg_36_1.var_.actorSpriteComps1072 = var_39_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.actorSpriteComps1072 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1072:ToTable()) do
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

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.actorSpriteComps1072 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_39_3 then
						if arg_36_1.isInRecall_ then
							iter_39_3.color = arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_39_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1072 = nil
			end

			local var_39_8 = arg_36_1.actors_["1073"]
			local var_39_9 = 0

			if var_39_9 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1073 == nil then
				arg_36_1.var_.actorSpriteComps1073 = var_39_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_10 = 0.2

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_10 and not isNil(var_39_8) then
				local var_39_11 = (arg_36_1.time_ - var_39_9) / var_39_10

				if arg_36_1.var_.actorSpriteComps1073 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_36_1.time_ >= var_39_9 + var_39_10 and arg_36_1.time_ < var_39_9 + var_39_10 + arg_39_0 and not isNil(var_39_8) and arg_36_1.var_.actorSpriteComps1073 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_39_7 then
						if arg_36_1.isInRecall_ then
							iter_39_7.color = arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_39_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_36_1.var_.actorSpriteComps1073 = nil
			end

			local var_39_16 = 0
			local var_39_17 = 0.725

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_18 = arg_36_1:FormatText(StoryNameCfg[379].name)

				arg_36_1.leftNameTxt_.text = var_39_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(418061009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 29
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_17 or var_39_17 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_17 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061009", "story_v_side_old_418061.awb") ~= 0 then
					local var_39_24 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061009", "story_v_side_old_418061.awb") / 1000

					if var_39_24 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_16
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_side_old_418061", "418061009", "story_v_side_old_418061.awb")

						arg_36_1:RecordAudio("418061009", var_39_25)
						arg_36_1:RecordAudio("418061009", var_39_25)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061009", "story_v_side_old_418061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061009", "story_v_side_old_418061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_26 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_26 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_26

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_26 and arg_36_1.time_ < var_39_16 + var_39_26 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play418061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418061010
		arg_40_1.duration_ = 2.7

		local var_40_0 = {
			ja = 2.7,
			CriLanguages = 2.633,
			zh = 2.633
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play418061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1073"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1073 == nil then
				arg_40_1.var_.actorSpriteComps1073 = var_43_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.actorSpriteComps1073 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.actorSpriteComps1073 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_43_3 then
						if arg_40_1.isInRecall_ then
							iter_43_3.color = arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_43_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1073 = nil
			end

			local var_43_8 = arg_40_1.actors_["1072"]
			local var_43_9 = 0

			if var_43_9 < arg_40_1.time_ and arg_40_1.time_ <= var_43_9 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1072 == nil then
				arg_40_1.var_.actorSpriteComps1072 = var_43_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_10 = 0.2

			if var_43_9 <= arg_40_1.time_ and arg_40_1.time_ < var_43_9 + var_43_10 and not isNil(var_43_8) then
				local var_43_11 = (arg_40_1.time_ - var_43_9) / var_43_10

				if arg_40_1.var_.actorSpriteComps1072 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1072:ToTable()) do
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

			if arg_40_1.time_ >= var_43_9 + var_43_10 and arg_40_1.time_ < var_43_9 + var_43_10 + arg_43_0 and not isNil(var_43_8) and arg_40_1.var_.actorSpriteComps1072 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_43_7 then
						if arg_40_1.isInRecall_ then
							iter_43_7.color = arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_43_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_40_1.var_.actorSpriteComps1072 = nil
			end

			local var_43_16 = arg_40_1.actors_["1073"].transform
			local var_43_17 = 0

			if var_43_17 < arg_40_1.time_ and arg_40_1.time_ <= var_43_17 + arg_43_0 then
				arg_40_1.var_.moveOldPos1073 = var_43_16.localPosition
				var_43_16.localScale = Vector3.New(1, 1, 1)

				arg_40_1:CheckSpriteTmpPos("1073", 2)

				local var_43_18 = var_43_16.childCount

				for iter_43_8 = 0, var_43_18 - 1 do
					local var_43_19 = var_43_16:GetChild(iter_43_8)

					if var_43_19.name == "split_6" or not string.find(var_43_19.name, "split") then
						var_43_19.gameObject:SetActive(true)
					else
						var_43_19.gameObject:SetActive(false)
					end
				end
			end

			local var_43_20 = 0.001

			if var_43_17 <= arg_40_1.time_ and arg_40_1.time_ < var_43_17 + var_43_20 then
				local var_43_21 = (arg_40_1.time_ - var_43_17) / var_43_20
				local var_43_22 = Vector3.New(-405.76, -414.5, -207.2)

				var_43_16.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1073, var_43_22, var_43_21)
			end

			if arg_40_1.time_ >= var_43_17 + var_43_20 and arg_40_1.time_ < var_43_17 + var_43_20 + arg_43_0 then
				var_43_16.localPosition = Vector3.New(-405.76, -414.5, -207.2)
			end

			local var_43_23 = 0
			local var_43_24 = 0.35

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_25 = arg_40_1:FormatText(StoryNameCfg[380].name)

				arg_40_1.leftNameTxt_.text = var_43_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_26 = arg_40_1:GetWordFromCfg(418061010)
				local var_43_27 = arg_40_1:FormatText(var_43_26.content)

				arg_40_1.text_.text = var_43_27

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_28 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061010", "story_v_side_old_418061.awb") ~= 0 then
					local var_43_31 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061010", "story_v_side_old_418061.awb") / 1000

					if var_43_31 + var_43_23 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_31 + var_43_23
					end

					if var_43_26.prefab_name ~= "" and arg_40_1.actors_[var_43_26.prefab_name] ~= nil then
						local var_43_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_26.prefab_name].transform, "story_v_side_old_418061", "418061010", "story_v_side_old_418061.awb")

						arg_40_1:RecordAudio("418061010", var_43_32)
						arg_40_1:RecordAudio("418061010", var_43_32)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061010", "story_v_side_old_418061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061010", "story_v_side_old_418061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_33 = math.max(var_43_24, arg_40_1.talkMaxDuration)

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_33 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_23) / var_43_33

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_23 + var_43_33 and arg_40_1.time_ < var_43_23 + var_43_33 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073",
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
	Play418061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418061011
		arg_44_1.duration_ = 8.2

		local var_44_0 = {
			ja = 7.4,
			CriLanguages = 8.2,
			zh = 8.2
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play418061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1072"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1072 == nil then
				arg_44_1.var_.actorSpriteComps1072 = var_47_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.actorSpriteComps1072 then
					for iter_47_0, iter_47_1 in pairs(arg_44_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_47_1 then
							if arg_44_1.isInRecall_ then
								local var_47_4 = Mathf.Lerp(iter_47_1.color.r, arg_44_1.hightColor1.r, var_47_3)
								local var_47_5 = Mathf.Lerp(iter_47_1.color.g, arg_44_1.hightColor1.g, var_47_3)
								local var_47_6 = Mathf.Lerp(iter_47_1.color.b, arg_44_1.hightColor1.b, var_47_3)

								iter_47_1.color = Color.New(var_47_4, var_47_5, var_47_6)
							else
								local var_47_7 = Mathf.Lerp(iter_47_1.color.r, 1, var_47_3)

								iter_47_1.color = Color.New(var_47_7, var_47_7, var_47_7)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.actorSpriteComps1072 then
				for iter_47_2, iter_47_3 in pairs(arg_44_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_47_3 then
						if arg_44_1.isInRecall_ then
							iter_47_3.color = arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_47_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1072 = nil
			end

			local var_47_8 = arg_44_1.actors_["1073"]
			local var_47_9 = 0

			if var_47_9 < arg_44_1.time_ and arg_44_1.time_ <= var_47_9 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1073 == nil then
				arg_44_1.var_.actorSpriteComps1073 = var_47_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_10 = 0.2

			if var_47_9 <= arg_44_1.time_ and arg_44_1.time_ < var_47_9 + var_47_10 and not isNil(var_47_8) then
				local var_47_11 = (arg_44_1.time_ - var_47_9) / var_47_10

				if arg_44_1.var_.actorSpriteComps1073 then
					for iter_47_4, iter_47_5 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
						if iter_47_5 then
							if arg_44_1.isInRecall_ then
								local var_47_12 = Mathf.Lerp(iter_47_5.color.r, arg_44_1.hightColor2.r, var_47_11)
								local var_47_13 = Mathf.Lerp(iter_47_5.color.g, arg_44_1.hightColor2.g, var_47_11)
								local var_47_14 = Mathf.Lerp(iter_47_5.color.b, arg_44_1.hightColor2.b, var_47_11)

								iter_47_5.color = Color.New(var_47_12, var_47_13, var_47_14)
							else
								local var_47_15 = Mathf.Lerp(iter_47_5.color.r, 0.5, var_47_11)

								iter_47_5.color = Color.New(var_47_15, var_47_15, var_47_15)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= var_47_9 + var_47_10 and arg_44_1.time_ < var_47_9 + var_47_10 + arg_47_0 and not isNil(var_47_8) and arg_44_1.var_.actorSpriteComps1073 then
				for iter_47_6, iter_47_7 in pairs(arg_44_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_47_7 then
						if arg_44_1.isInRecall_ then
							iter_47_7.color = arg_44_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_47_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_44_1.var_.actorSpriteComps1073 = nil
			end

			local var_47_16 = arg_44_1.actors_["1072"].transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.moveOldPos1072 = var_47_16.localPosition
				var_47_16.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1072", 4)

				local var_47_18 = var_47_16.childCount

				for iter_47_8 = 0, var_47_18 - 1 do
					local var_47_19 = var_47_16:GetChild(iter_47_8)

					if var_47_19.name == "" or not string.find(var_47_19.name, "split") then
						var_47_19.gameObject:SetActive(true)
					else
						var_47_19.gameObject:SetActive(false)
					end
				end
			end

			local var_47_20 = 0.001

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_20 then
				local var_47_21 = (arg_44_1.time_ - var_47_17) / var_47_20
				local var_47_22 = Vector3.New(509.5, -428.9, -184.1)

				var_47_16.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1072, var_47_22, var_47_21)
			end

			if arg_44_1.time_ >= var_47_17 + var_47_20 and arg_44_1.time_ < var_47_17 + var_47_20 + arg_47_0 then
				var_47_16.localPosition = Vector3.New(509.5, -428.9, -184.1)
			end

			local var_47_23 = 0
			local var_47_24 = 1.025

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_25 = arg_44_1:FormatText(StoryNameCfg[379].name)

				arg_44_1.leftNameTxt_.text = var_47_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_26 = arg_44_1:GetWordFromCfg(418061011)
				local var_47_27 = arg_44_1:FormatText(var_47_26.content)

				arg_44_1.text_.text = var_47_27

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_28 = 41
				local var_47_29 = utf8.len(var_47_27)
				local var_47_30 = var_47_28 <= 0 and var_47_24 or var_47_24 * (var_47_29 / var_47_28)

				if var_47_30 > 0 and var_47_24 < var_47_30 then
					arg_44_1.talkMaxDuration = var_47_30

					if var_47_30 + var_47_23 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_30 + var_47_23
					end
				end

				arg_44_1.text_.text = var_47_27
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061011", "story_v_side_old_418061.awb") ~= 0 then
					local var_47_31 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061011", "story_v_side_old_418061.awb") / 1000

					if var_47_31 + var_47_23 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_31 + var_47_23
					end

					if var_47_26.prefab_name ~= "" and arg_44_1.actors_[var_47_26.prefab_name] ~= nil then
						local var_47_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_26.prefab_name].transform, "story_v_side_old_418061", "418061011", "story_v_side_old_418061.awb")

						arg_44_1:RecordAudio("418061011", var_47_32)
						arg_44_1:RecordAudio("418061011", var_47_32)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061011", "story_v_side_old_418061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061011", "story_v_side_old_418061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_33 = math.max(var_47_24, arg_44_1.talkMaxDuration)

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_33 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_23) / var_47_33

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_23 + var_47_33 and arg_44_1.time_ < var_47_23 + var_47_33 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play418061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418061012
		arg_48_1.duration_ = 1.93

		local var_48_0 = {
			ja = 1.933,
			CriLanguages = 0.999999999999,
			zh = 0.999999999999
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
			arg_48_1.auto_ = false
		end

		function arg_48_1.playNext_(arg_50_0)
			arg_48_1.onStoryFinished_()
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1073"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1073 == nil then
				arg_48_1.var_.actorSpriteComps1073 = var_51_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.actorSpriteComps1073 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
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

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.actorSpriteComps1073 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1073:ToTable()) do
					if iter_51_3 then
						if arg_48_1.isInRecall_ then
							iter_51_3.color = arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_51_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1073 = nil
			end

			local var_51_8 = arg_48_1.actors_["1072"]
			local var_51_9 = 0

			if var_51_9 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1072 == nil then
				arg_48_1.var_.actorSpriteComps1072 = var_51_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_10 = 0.2

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_10 and not isNil(var_51_8) then
				local var_51_11 = (arg_48_1.time_ - var_51_9) / var_51_10

				if arg_48_1.var_.actorSpriteComps1072 then
					for iter_51_4, iter_51_5 in pairs(arg_48_1.var_.actorSpriteComps1072:ToTable()) do
						if iter_51_5 then
							if arg_48_1.isInRecall_ then
								local var_51_12 = Mathf.Lerp(iter_51_5.color.r, arg_48_1.hightColor2.r, var_51_11)
								local var_51_13 = Mathf.Lerp(iter_51_5.color.g, arg_48_1.hightColor2.g, var_51_11)
								local var_51_14 = Mathf.Lerp(iter_51_5.color.b, arg_48_1.hightColor2.b, var_51_11)

								iter_51_5.color = Color.New(var_51_12, var_51_13, var_51_14)
							else
								local var_51_15 = Mathf.Lerp(iter_51_5.color.r, 0.5, var_51_11)

								iter_51_5.color = Color.New(var_51_15, var_51_15, var_51_15)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= var_51_9 + var_51_10 and arg_48_1.time_ < var_51_9 + var_51_10 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.actorSpriteComps1072 then
				for iter_51_6, iter_51_7 in pairs(arg_48_1.var_.actorSpriteComps1072:ToTable()) do
					if iter_51_7 then
						if arg_48_1.isInRecall_ then
							iter_51_7.color = arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_51_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_48_1.var_.actorSpriteComps1072 = nil
			end

			local var_51_16 = 0
			local var_51_17 = 0.05

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_18 = arg_48_1:FormatText(StoryNameCfg[380].name)

				arg_48_1.leftNameTxt_.text = var_51_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(418061012)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 2
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_17 or var_51_17 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_17 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_16
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418061", "418061012", "story_v_side_old_418061.awb") ~= 0 then
					local var_51_24 = manager.audio:GetVoiceLength("story_v_side_old_418061", "418061012", "story_v_side_old_418061.awb") / 1000

					if var_51_24 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_16
					end

					if var_51_19.prefab_name ~= "" and arg_48_1.actors_[var_51_19.prefab_name] ~= nil then
						local var_51_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_19.prefab_name].transform, "story_v_side_old_418061", "418061012", "story_v_side_old_418061.awb")

						arg_48_1:RecordAudio("418061012", var_51_25)
						arg_48_1:RecordAudio("418061012", var_51_25)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418061", "418061012", "story_v_side_old_418061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418061", "418061012", "story_v_side_old_418061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_26 = math.max(var_51_17, arg_48_1.talkMaxDuration)

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_26 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_16) / var_51_26

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_16 + var_51_26 and arg_48_1.time_ < var_51_16 + var_51_26 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03f"
	},
	voices = {
		"story_v_side_old_418061.awb"
	}
}
