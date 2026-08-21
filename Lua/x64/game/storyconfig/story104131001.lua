return {
	Play413101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413101001
		arg_1_1.duration_ = 3.4

		local var_1_0 = {
			zh = 3.4,
			ja = 3.266
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
				arg_1_0:Play413101002(arg_1_1)
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

			local var_4_24 = "10093"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

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

			local var_4_28 = arg_1_1.actors_["10093"].transform
			local var_4_29 = 1.86666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_3" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -345, -245)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -345, -245)
			end

			local var_4_35 = arg_1_1.actors_["10093"]
			local var_4_36 = 1.86666666666667

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.833333333333333

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10093 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_39 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_38)
								local var_4_40 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_38)
								local var_4_41 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_38)

								iter_4_6.color = Color.New(var_4_39, var_4_40, var_4_41)
							else
								local var_4_42 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_38)

								iter_4_6.color = Color.New(var_4_42, var_4_42, var_4_42)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10093 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10093 = nil
			end

			local var_4_43 = arg_1_1.actors_["10093"]
			local var_4_44 = 1.86666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10093 = var_4_45.alpha
					arg_1_1.var_.characterEffect10093 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_46 = 0.233333333333333

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, var_4_47)

				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.433333333333333

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

			local var_4_55 = 1.26666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

			local var_4_61 = 2.1
			local var_4_62 = 0.1

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[28].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(413101001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101001", "story_v_out_413101.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413101", "413101001", "story_v_out_413101.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413101", "413101001", "story_v_out_413101.awb")

						arg_1_1:RecordAudio("413101001", var_4_71)
						arg_1_1:RecordAudio("413101001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413101", "413101001", "story_v_out_413101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413101", "413101001", "story_v_out_413101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10093"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = var_12_0.localPosition
				var_12_0.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 7)

				local var_12_2 = var_12_0.childCount

				for iter_12_0 = 0, var_12_2 - 1 do
					local var_12_3 = var_12_0:GetChild(iter_12_0)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_4 then
				local var_12_5 = (arg_9_1.time_ - var_12_1) / var_12_4
				local var_12_6 = Vector3.New(0, -2000, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, var_12_6, var_12_5)
			end

			if arg_9_1.time_ >= var_12_1 + var_12_4 and arg_9_1.time_ < var_12_1 + var_12_4 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_7 = arg_9_1.actors_["10093"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_9 = 2

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_1, iter_12_2 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_2 then
							if arg_9_1.isInRecall_ then
								local var_12_11 = Mathf.Lerp(iter_12_2.color.r, arg_9_1.hightColor2.r, var_12_10)
								local var_12_12 = Mathf.Lerp(iter_12_2.color.g, arg_9_1.hightColor2.g, var_12_10)
								local var_12_13 = Mathf.Lerp(iter_12_2.color.b, arg_9_1.hightColor2.b, var_12_10)

								iter_12_2.color = Color.New(var_12_11, var_12_12, var_12_13)
							else
								local var_12_14 = Mathf.Lerp(iter_12_2.color.r, 0.5, var_12_10)

								iter_12_2.color = Color.New(var_12_14, var_12_14, var_12_14)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_4 then
						if arg_9_1.isInRecall_ then
							iter_12_4.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_15 = 0
			local var_12_16 = 1.175

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_17 = arg_9_1:GetWordFromCfg(413101002)
				local var_12_18 = arg_9_1:FormatText(var_12_17.content)

				arg_9_1.text_.text = var_12_18

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 47
				local var_12_20 = utf8.len(var_12_18)
				local var_12_21 = var_12_19 <= 0 and var_12_16 or var_12_16 * (var_12_20 / var_12_19)

				if var_12_21 > 0 and var_12_16 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_18
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_22 and arg_9_1.time_ < var_12_15 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413101003
		arg_13_1.duration_ = 4.67

		local var_13_0 = {
			zh = 4.666,
			ja = 2.2
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
				arg_13_0:Play413101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10093"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10093 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10093", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_5" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -345, -245)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10093, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_16_7 = arg_13_1.actors_["10093"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 1, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.525

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[28].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(413101003)
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101003", "story_v_out_413101.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101003", "story_v_out_413101.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_413101", "413101003", "story_v_out_413101.awb")

						arg_13_1:RecordAudio("413101003", var_16_24)
						arg_13_1:RecordAudio("413101003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413101", "413101003", "story_v_out_413101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413101", "413101003", "story_v_out_413101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_25 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_25 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_25

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_25 and arg_13_1.time_ < var_16_15 + var_16_25 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413101004
		arg_17_1.duration_ = 4.43

		local var_17_0 = {
			zh = 4.433,
			ja = 3.5
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
				arg_17_0:Play413101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.525

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[28].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(413101004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 21
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101004", "story_v_out_413101.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101004", "story_v_out_413101.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_413101", "413101004", "story_v_out_413101.awb")

						arg_17_1:RecordAudio("413101004", var_20_9)
						arg_17_1:RecordAudio("413101004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413101", "413101004", "story_v_out_413101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413101", "413101004", "story_v_out_413101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413101005
		arg_21_1.duration_ = 5.43

		local var_21_0 = {
			zh = 5.433,
			ja = 4.633
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
				arg_21_0:Play413101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10093"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 3)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "split_7" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(0, -345, -245)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10093, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_24_7 = 0
			local var_24_8 = 0.65

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_9 = arg_21_1:FormatText(StoryNameCfg[28].name)

				arg_21_1.leftNameTxt_.text = var_24_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(413101005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 26
				local var_24_13 = utf8.len(var_24_11)
				local var_24_14 = var_24_12 <= 0 and var_24_8 or var_24_8 * (var_24_13 / var_24_12)

				if var_24_14 > 0 and var_24_8 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_7
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101005", "story_v_out_413101.awb") ~= 0 then
					local var_24_15 = manager.audio:GetVoiceLength("story_v_out_413101", "413101005", "story_v_out_413101.awb") / 1000

					if var_24_15 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_7
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_413101", "413101005", "story_v_out_413101.awb")

						arg_21_1:RecordAudio("413101005", var_24_16)
						arg_21_1:RecordAudio("413101005", var_24_16)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413101", "413101005", "story_v_out_413101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413101", "413101005", "story_v_out_413101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_8, arg_21_1.talkMaxDuration)

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_7) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_7 + var_24_17 and arg_21_1.time_ < var_24_7 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play413101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413101006
		arg_25_1.duration_ = 5.8

		local var_25_0 = {
			zh = 5.8,
			ja = 4.1
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play413101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10093"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10093 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10093", 3)

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
				local var_28_6 = Vector3.New(0, -345, -245)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10093, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_28_7 = arg_25_1.actors_["10093"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.7

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[28].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(413101006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 28
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101006", "story_v_out_413101.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101006", "story_v_out_413101.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_413101", "413101006", "story_v_out_413101.awb")

						arg_25_1:RecordAudio("413101006", var_28_24)
						arg_25_1:RecordAudio("413101006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413101", "413101006", "story_v_out_413101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413101", "413101006", "story_v_out_413101.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play413101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10093"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10093 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10093", 7)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(0, -2000, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10093, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_7 = arg_29_1.actors_["10093"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10093 == nil then
				arg_29_1.var_.actorSpriteComps10093 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 2

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps10093 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor2.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor2.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor2.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 0.5, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10093 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10093 = nil
			end

			local var_32_15 = 0
			local var_32_16 = 0.675

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_17 = arg_29_1:GetWordFromCfg(413101007)
				local var_32_18 = arg_29_1:FormatText(var_32_17.content)

				arg_29_1.text_.text = var_32_18

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 27
				local var_32_20 = utf8.len(var_32_18)
				local var_32_21 = var_32_19 <= 0 and var_32_16 or var_32_16 * (var_32_20 / var_32_19)

				if var_32_21 > 0 and var_32_16 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_18
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_22 and arg_29_1.time_ < var_32_15 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play413101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413101008
		arg_33_1.duration_ = 5.63

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_1 = 0.633333333333333

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_1 then
				local var_36_2 = (arg_33_1.time_ - var_36_0) / var_36_1
				local var_36_3 = Color.New(1, 1, 1)

				var_36_3.a = Mathf.Lerp(1, 0, var_36_2)
				arg_33_1.mask_.color = var_36_3
			end

			if arg_33_1.time_ >= var_36_0 + var_36_1 and arg_33_1.time_ < var_36_0 + var_36_1 + arg_36_0 then
				local var_36_4 = Color.New(1, 1, 1)
				local var_36_5 = 0

				arg_33_1.mask_.enabled = false
				var_36_4.a = var_36_5
				arg_33_1.mask_.color = var_36_4
			end

			local var_36_6 = manager.ui.mainCamera.transform
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_6.localPosition
			end

			local var_36_8 = 0.6

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / 0.066
				local var_36_10, var_36_11 = math.modf(var_36_9)

				var_36_6.localPosition = Vector3.New(var_36_11 * 0.13, var_36_11 * 0.13, var_36_11 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 then
				var_36_6.localPosition = arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_12 = 0.633333333333333
			local var_36_13 = 1.375

			if var_36_12 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_14 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_14:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:GetWordFromCfg(413101008)
				local var_36_16 = arg_33_1:FormatText(var_36_15.content)

				arg_33_1.text_.text = var_36_16

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 55
				local var_36_18 = utf8.len(var_36_16)
				local var_36_19 = var_36_17 <= 0 and var_36_13 or var_36_13 * (var_36_18 / var_36_17)

				if var_36_19 > 0 and var_36_13 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19
					var_36_12 = var_36_12 + 0.3

					if var_36_19 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_16
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = var_36_12 + 0.3
			local var_36_21 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_20 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_21 and arg_33_1.time_ < var_36_20 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413101009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413101009
		arg_39_1.duration_ = 4.53

		local var_39_0 = {
			zh = 3.233,
			ja = 4.533
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
				arg_39_0:Play413101010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10093"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos10093 = var_42_0.localPosition
				var_42_0.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10093", 3)

				local var_42_2 = var_42_0.childCount

				for iter_42_0 = 0, var_42_2 - 1 do
					local var_42_3 = var_42_0:GetChild(iter_42_0)

					if var_42_3.name == "split_3" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_4 then
				local var_42_5 = (arg_39_1.time_ - var_42_1) / var_42_4
				local var_42_6 = Vector3.New(0, -345, -245)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10093, var_42_6, var_42_5)
			end

			if arg_39_1.time_ >= var_42_1 + var_42_4 and arg_39_1.time_ < var_42_1 + var_42_4 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_42_7 = arg_39_1.actors_["10093"]
			local var_42_8 = 0

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 and not isNil(var_42_7) and arg_39_1.var_.actorSpriteComps10093 == nil then
				arg_39_1.var_.actorSpriteComps10093 = var_42_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_9 = 2

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_9 and not isNil(var_42_7) then
				local var_42_10 = (arg_39_1.time_ - var_42_8) / var_42_9

				if arg_39_1.var_.actorSpriteComps10093 then
					for iter_42_1, iter_42_2 in pairs(arg_39_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_42_2 then
							if arg_39_1.isInRecall_ then
								local var_42_11 = Mathf.Lerp(iter_42_2.color.r, arg_39_1.hightColor1.r, var_42_10)
								local var_42_12 = Mathf.Lerp(iter_42_2.color.g, arg_39_1.hightColor1.g, var_42_10)
								local var_42_13 = Mathf.Lerp(iter_42_2.color.b, arg_39_1.hightColor1.b, var_42_10)

								iter_42_2.color = Color.New(var_42_11, var_42_12, var_42_13)
							else
								local var_42_14 = Mathf.Lerp(iter_42_2.color.r, 1, var_42_10)

								iter_42_2.color = Color.New(var_42_14, var_42_14, var_42_14)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_8 + var_42_9 and arg_39_1.time_ < var_42_8 + var_42_9 + arg_42_0 and not isNil(var_42_7) and arg_39_1.var_.actorSpriteComps10093 then
				for iter_42_3, iter_42_4 in pairs(arg_39_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_42_4 then
						if arg_39_1.isInRecall_ then
							iter_42_4.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10093 = nil
			end

			local var_42_15 = 0
			local var_42_16 = 0.4

			if var_42_15 < arg_39_1.time_ and arg_39_1.time_ <= var_42_15 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_17 = arg_39_1:FormatText(StoryNameCfg[28].name)

				arg_39_1.leftNameTxt_.text = var_42_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_18 = arg_39_1:GetWordFromCfg(413101009)
				local var_42_19 = arg_39_1:FormatText(var_42_18.content)

				arg_39_1.text_.text = var_42_19

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_20 = 16
				local var_42_21 = utf8.len(var_42_19)
				local var_42_22 = var_42_20 <= 0 and var_42_16 or var_42_16 * (var_42_21 / var_42_20)

				if var_42_22 > 0 and var_42_16 < var_42_22 then
					arg_39_1.talkMaxDuration = var_42_22

					if var_42_22 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_22 + var_42_15
					end
				end

				arg_39_1.text_.text = var_42_19
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101009", "story_v_out_413101.awb") ~= 0 then
					local var_42_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101009", "story_v_out_413101.awb") / 1000

					if var_42_23 + var_42_15 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_23 + var_42_15
					end

					if var_42_18.prefab_name ~= "" and arg_39_1.actors_[var_42_18.prefab_name] ~= nil then
						local var_42_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_18.prefab_name].transform, "story_v_out_413101", "413101009", "story_v_out_413101.awb")

						arg_39_1:RecordAudio("413101009", var_42_24)
						arg_39_1:RecordAudio("413101009", var_42_24)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413101", "413101009", "story_v_out_413101.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413101", "413101009", "story_v_out_413101.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_16, arg_39_1.talkMaxDuration)

			if var_42_15 <= arg_39_1.time_ and arg_39_1.time_ < var_42_15 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_15) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_15 + var_42_25 and arg_39_1.time_ < var_42_15 + var_42_25 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play413101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413101010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10093"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10093 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10093", 7)

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
				local var_46_6 = Vector3.New(0, -2000, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10093, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_7 = arg_43_1.actors_["10093"]
			local var_46_8 = 0

			if var_46_8 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10093 == nil then
				arg_43_1.var_.actorSpriteComps10093 = var_46_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_9 = 0.034

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_9 and not isNil(var_46_7) then
				local var_46_10 = (arg_43_1.time_ - var_46_8) / var_46_9

				if arg_43_1.var_.actorSpriteComps10093 then
					for iter_46_1, iter_46_2 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_43_1.time_ >= var_46_8 + var_46_9 and arg_43_1.time_ < var_46_8 + var_46_9 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.actorSpriteComps10093 then
				for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_46_4 then
						if arg_43_1.isInRecall_ then
							iter_46_4.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10093 = nil
			end

			local var_46_15 = 0
			local var_46_16 = 0.433333333333333

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				local var_46_17 = "play"
				local var_46_18 = "effect"

				arg_43_1:AudioAction(var_46_17, var_46_18, "se_story_side_1037", "se_story_1037_hit", "")
			end

			local var_46_19 = manager.ui.mainCamera.transform
			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				arg_43_1.var_.shakeOldPos = var_46_19.localPosition
			end

			local var_46_21 = 0.6

			if var_46_20 <= arg_43_1.time_ and arg_43_1.time_ < var_46_20 + var_46_21 then
				local var_46_22 = (arg_43_1.time_ - var_46_20) / 0.066
				local var_46_23, var_46_24 = math.modf(var_46_22)

				var_46_19.localPosition = Vector3.New(var_46_24 * 0.13, var_46_24 * 0.13, var_46_24 * 0.13) + arg_43_1.var_.shakeOldPos
			end

			if arg_43_1.time_ >= var_46_20 + var_46_21 and arg_43_1.time_ < var_46_20 + var_46_21 + arg_46_0 then
				var_46_19.localPosition = arg_43_1.var_.shakeOldPos
			end

			local var_46_25 = 0

			if var_46_25 < arg_43_1.time_ and arg_43_1.time_ <= var_46_25 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_26 = 0.6

			if arg_43_1.time_ >= var_46_25 + var_46_26 and arg_43_1.time_ < var_46_25 + var_46_26 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_27 = 0
			local var_46_28 = 1.1

			if var_46_27 < arg_43_1.time_ and arg_43_1.time_ <= var_46_27 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_29 = arg_43_1:GetWordFromCfg(413101010)
				local var_46_30 = arg_43_1:FormatText(var_46_29.content)

				arg_43_1.text_.text = var_46_30

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_31 = 44
				local var_46_32 = utf8.len(var_46_30)
				local var_46_33 = var_46_31 <= 0 and var_46_28 or var_46_28 * (var_46_32 / var_46_31)

				if var_46_33 > 0 and var_46_28 < var_46_33 then
					arg_43_1.talkMaxDuration = var_46_33

					if var_46_33 + var_46_27 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_33 + var_46_27
					end
				end

				arg_43_1.text_.text = var_46_30
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_34 = math.max(var_46_28, arg_43_1.talkMaxDuration)

			if var_46_27 <= arg_43_1.time_ and arg_43_1.time_ < var_46_27 + var_46_34 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_27) / var_46_34

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_27 + var_46_34 and arg_43_1.time_ < var_46_27 + var_46_34 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play413101011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413101011
		arg_47_1.duration_ = 3.07

		local var_47_0 = {
			zh = 3.066,
			ja = 2.533
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413101012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10093"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10093 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10093", 3)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "split_7" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -345, -245)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10093, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_50_7 = arg_47_1.actors_["10093"]
			local var_50_8 = 0

			if var_50_8 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10093 == nil then
				arg_47_1.var_.actorSpriteComps10093 = var_50_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 and not isNil(var_50_7) then
				local var_50_10 = (arg_47_1.time_ - var_50_8) / var_50_9

				if arg_47_1.var_.actorSpriteComps10093 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								local var_50_11 = Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, var_50_10)
								local var_50_12 = Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, var_50_10)
								local var_50_13 = Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, var_50_10)

								iter_50_2.color = Color.New(var_50_11, var_50_12, var_50_13)
							else
								local var_50_14 = Mathf.Lerp(iter_50_2.color.r, 1, var_50_10)

								iter_50_2.color = Color.New(var_50_14, var_50_14, var_50_14)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.actorSpriteComps10093 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_50_4 then
						if arg_47_1.isInRecall_ then
							iter_50_4.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10093 = nil
			end

			local var_50_15 = 0
			local var_50_16 = 0.4

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_17 = arg_47_1:FormatText(StoryNameCfg[28].name)

				arg_47_1.leftNameTxt_.text = var_50_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_18 = arg_47_1:GetWordFromCfg(413101011)
				local var_50_19 = arg_47_1:FormatText(var_50_18.content)

				arg_47_1.text_.text = var_50_19

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_20 = 17
				local var_50_21 = utf8.len(var_50_19)
				local var_50_22 = var_50_20 <= 0 and var_50_16 or var_50_16 * (var_50_21 / var_50_20)

				if var_50_22 > 0 and var_50_16 < var_50_22 then
					arg_47_1.talkMaxDuration = var_50_22

					if var_50_22 + var_50_15 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_22 + var_50_15
					end
				end

				arg_47_1.text_.text = var_50_19
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101011", "story_v_out_413101.awb") ~= 0 then
					local var_50_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101011", "story_v_out_413101.awb") / 1000

					if var_50_23 + var_50_15 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_23 + var_50_15
					end

					if var_50_18.prefab_name ~= "" and arg_47_1.actors_[var_50_18.prefab_name] ~= nil then
						local var_50_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_18.prefab_name].transform, "story_v_out_413101", "413101011", "story_v_out_413101.awb")

						arg_47_1:RecordAudio("413101011", var_50_24)
						arg_47_1:RecordAudio("413101011", var_50_24)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413101", "413101011", "story_v_out_413101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413101", "413101011", "story_v_out_413101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_25 = math.max(var_50_16, arg_47_1.talkMaxDuration)

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_25 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_15) / var_50_25

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_15 + var_50_25 and arg_47_1.time_ < var_50_15 + var_50_25 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play413101012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413101012
		arg_51_1.duration_ = 6.37

		local var_51_0 = {
			zh = 3.933,
			ja = 6.366
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413101013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.5

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[28].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(413101012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 20
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101012", "story_v_out_413101.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101012", "story_v_out_413101.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_413101", "413101012", "story_v_out_413101.awb")

						arg_51_1:RecordAudio("413101012", var_54_9)
						arg_51_1:RecordAudio("413101012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413101", "413101012", "story_v_out_413101.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413101", "413101012", "story_v_out_413101.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413101013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413101013
		arg_55_1.duration_ = 5.8

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413101014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10093"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10093 == nil then
				arg_55_1.var_.actorSpriteComps10093 = var_58_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_2 = 2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.actorSpriteComps10093 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.actorSpriteComps10093 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_58_3 then
						if arg_55_1.isInRecall_ then
							iter_58_3.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10093 = nil
			end

			local var_58_8 = manager.ui.mainCamera.transform
			local var_58_9 = 0.366666666666667

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_8.localPosition
			end

			local var_58_10 = 0.433333333333333

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 then
				local var_58_11 = (arg_55_1.time_ - var_58_9) / 0.066
				local var_58_12, var_58_13 = math.modf(var_58_11)

				var_58_8.localPosition = Vector3.New(var_58_13 * 0.13, var_58_13 * 0.13, var_58_13 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 then
				var_58_8.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_15 = 0.633333333333333

			if var_58_14 <= arg_55_1.time_ and arg_55_1.time_ < var_58_14 + var_58_15 then
				local var_58_16 = (arg_55_1.time_ - var_58_14) / var_58_15
				local var_58_17 = Color.New(0, 0, 0)

				var_58_17.a = Mathf.Lerp(0, 1, var_58_16)
				arg_55_1.mask_.color = var_58_17
			end

			if arg_55_1.time_ >= var_58_14 + var_58_15 and arg_55_1.time_ < var_58_14 + var_58_15 + arg_58_0 then
				local var_58_18 = Color.New(0, 0, 0)

				var_58_18.a = 1
				arg_55_1.mask_.color = var_58_18
			end

			local var_58_19 = 0.633333333333333

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_20 = 0.633333333333333

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_20 then
				local var_58_21 = (arg_55_1.time_ - var_58_19) / var_58_20
				local var_58_22 = Color.New(0, 0, 0)

				var_58_22.a = Mathf.Lerp(1, 0, var_58_21)
				arg_55_1.mask_.color = var_58_22
			end

			if arg_55_1.time_ >= var_58_19 + var_58_20 and arg_55_1.time_ < var_58_19 + var_58_20 + arg_58_0 then
				local var_58_23 = Color.New(0, 0, 0)
				local var_58_24 = 0

				arg_55_1.mask_.enabled = false
				var_58_23.a = var_58_24
				arg_55_1.mask_.color = var_58_23
			end

			local var_58_25 = arg_55_1.actors_["10093"]
			local var_58_26 = 0

			if var_58_26 < arg_55_1.time_ and arg_55_1.time_ <= var_58_26 + arg_58_0 then
				local var_58_27 = var_58_25:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_27 then
					arg_55_1.var_.alphaOldValue10093 = var_58_27.alpha
					arg_55_1.var_.characterEffect10093 = var_58_27
				end

				arg_55_1.var_.alphaOldValue10093 = 1
			end

			local var_58_28 = 0.5

			if var_58_26 <= arg_55_1.time_ and arg_55_1.time_ < var_58_26 + var_58_28 then
				local var_58_29 = (arg_55_1.time_ - var_58_26) / var_58_28
				local var_58_30 = Mathf.Lerp(arg_55_1.var_.alphaOldValue10093, 0, var_58_29)

				if arg_55_1.var_.characterEffect10093 then
					arg_55_1.var_.characterEffect10093.alpha = var_58_30
				end
			end

			if arg_55_1.time_ >= var_58_26 + var_58_28 and arg_55_1.time_ < var_58_26 + var_58_28 + arg_58_0 and arg_55_1.var_.characterEffect10093 then
				arg_55_1.var_.characterEffect10093.alpha = 0
			end

			local var_58_31 = 0.8
			local var_58_32 = 1

			if var_58_31 < arg_55_1.time_ and arg_55_1.time_ <= var_58_31 + arg_58_0 then
				local var_58_33 = "play"
				local var_58_34 = "effect"

				arg_55_1:AudioAction(var_58_33, var_58_34, "se_story_135_01", "se_story_135_01_chushou01", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_35 = 0.8
			local var_58_36 = 1.3

			if var_58_35 < arg_55_1.time_ and arg_55_1.time_ <= var_58_35 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_37 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_37:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_38 = arg_55_1:GetWordFromCfg(413101013)
				local var_58_39 = arg_55_1:FormatText(var_58_38.content)

				arg_55_1.text_.text = var_58_39

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_40 = 52
				local var_58_41 = utf8.len(var_58_39)
				local var_58_42 = var_58_40 <= 0 and var_58_36 or var_58_36 * (var_58_41 / var_58_40)

				if var_58_42 > 0 and var_58_36 < var_58_42 then
					arg_55_1.talkMaxDuration = var_58_42
					var_58_35 = var_58_35 + 0.3

					if var_58_42 + var_58_35 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_42 + var_58_35
					end
				end

				arg_55_1.text_.text = var_58_39
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_43 = var_58_35 + 0.3
			local var_58_44 = math.max(var_58_36, arg_55_1.talkMaxDuration)

			if var_58_43 <= arg_55_1.time_ and arg_55_1.time_ < var_58_43 + var_58_44 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_43) / var_58_44

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_43 + var_58_44 and arg_55_1.time_ < var_58_43 + var_58_44 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play413101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413101014
		arg_61_1.duration_ = 1.17

		local var_61_0 = {
			zh = 0.999999999999,
			ja = 1.166
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
				arg_61_0:Play413101015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.15

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[28].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_5")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(413101014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 6
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101014", "story_v_out_413101.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101014", "story_v_out_413101.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_413101", "413101014", "story_v_out_413101.awb")

						arg_61_1:RecordAudio("413101014", var_64_9)
						arg_61_1:RecordAudio("413101014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413101", "413101014", "story_v_out_413101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413101", "413101014", "story_v_out_413101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413101015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413101015
		arg_65_1.duration_ = 3.63

		local var_65_0 = {
			zh = 2.6,
			ja = 3.633
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
				arg_65_0:Play413101016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.325

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[36].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(413101015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 13
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101015", "story_v_out_413101.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101015", "story_v_out_413101.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_413101", "413101015", "story_v_out_413101.awb")

						arg_65_1:RecordAudio("413101015", var_68_9)
						arg_65_1:RecordAudio("413101015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413101", "413101015", "story_v_out_413101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413101", "413101015", "story_v_out_413101.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_10 and arg_65_1.time_ < var_68_0 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413101016
		arg_69_1.duration_ = 5.9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play413101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = manager.ui.mainCamera.transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				local var_72_2 = arg_69_1.var_.effectjianguang1
				local var_72_3
				local var_72_4 = var_72_0

				if not var_72_2 then
					var_72_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_72_4)
					var_72_2.name = "jianguang1"
					arg_69_1.var_.effectjianguang1 = var_72_2
				else
					var_72_2.transform:SetParent(var_72_4)
				end

				var_72_2.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_72_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_5 = 0
			local var_72_6 = 0.433333333333333

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				local var_72_7 = "play"
				local var_72_8 = "effect"

				arg_69_1:AudioAction(var_72_7, var_72_8, "se_story_10", "se_story_10_sword02", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_9 = 0.9
			local var_72_10 = 1.075

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_11 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_11:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_12 = arg_69_1:GetWordFromCfg(413101016)
				local var_72_13 = arg_69_1:FormatText(var_72_12.content)

				arg_69_1.text_.text = var_72_13

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_14 = 43
				local var_72_15 = utf8.len(var_72_13)
				local var_72_16 = var_72_14 <= 0 and var_72_10 or var_72_10 * (var_72_15 / var_72_14)

				if var_72_16 > 0 and var_72_10 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16
					var_72_9 = var_72_9 + 0.3

					if var_72_16 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_13
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_17 = var_72_9 + 0.3
			local var_72_18 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_17) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_17 + var_72_18 and arg_69_1.time_ < var_72_17 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play413101017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413101017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play413101018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = manager.ui.mainCamera.transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				local var_78_2 = arg_75_1.var_.effectjianguang1

				if var_78_2 then
					Object.Destroy(var_78_2)

					arg_75_1.var_.effectjianguang1 = nil
				end
			end

			local var_78_3 = manager.ui.mainCamera.transform
			local var_78_4 = 0

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.var_.shakeOldPos = var_78_3.localPosition
			end

			local var_78_5 = 0.6

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_5 then
				local var_78_6 = (arg_75_1.time_ - var_78_4) / 0.066
				local var_78_7, var_78_8 = math.modf(var_78_6)

				var_78_3.localPosition = Vector3.New(var_78_8 * 0.13, var_78_8 * 0.13, var_78_8 * 0.13) + arg_75_1.var_.shakeOldPos
			end

			if arg_75_1.time_ >= var_78_4 + var_78_5 and arg_75_1.time_ < var_78_4 + var_78_5 + arg_78_0 then
				var_78_3.localPosition = arg_75_1.var_.shakeOldPos
			end

			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			local var_78_10 = 0.6

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_11 = 0
			local var_78_12 = 1.425

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_13 = arg_75_1:GetWordFromCfg(413101017)
				local var_78_14 = arg_75_1:FormatText(var_78_13.content)

				arg_75_1.text_.text = var_78_14

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_15 = 57
				local var_78_16 = utf8.len(var_78_14)
				local var_78_17 = var_78_15 <= 0 and var_78_12 or var_78_12 * (var_78_16 / var_78_15)

				if var_78_17 > 0 and var_78_12 < var_78_17 then
					arg_75_1.talkMaxDuration = var_78_17

					if var_78_17 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_17 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_14
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_18 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_18 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_18

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_18 and arg_75_1.time_ < var_78_11 + var_78_18 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play413101018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413101018
		arg_79_1.duration_ = 2.27

		local var_79_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play413101019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10093"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10093 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10093", 3)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "split_5" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(0, -345, -245)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10093, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_82_7 = arg_79_1.actors_["10093"]
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps10093 == nil then
				arg_79_1.var_.actorSpriteComps10093 = var_82_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_9 = 2

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 and not isNil(var_82_7) then
				local var_82_10 = (arg_79_1.time_ - var_82_8) / var_82_9

				if arg_79_1.var_.actorSpriteComps10093 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								local var_82_11 = Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor1.r, var_82_10)
								local var_82_12 = Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor1.g, var_82_10)
								local var_82_13 = Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor1.b, var_82_10)

								iter_82_2.color = Color.New(var_82_11, var_82_12, var_82_13)
							else
								local var_82_14 = Mathf.Lerp(iter_82_2.color.r, 1, var_82_10)

								iter_82_2.color = Color.New(var_82_14, var_82_14, var_82_14)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps10093 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_82_4 then
						if arg_79_1.isInRecall_ then
							iter_82_4.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10093 = nil
			end

			local var_82_15 = arg_79_1.actors_["10093"]
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				local var_82_17 = var_82_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_17 then
					arg_79_1.var_.alphaOldValue10093 = var_82_17.alpha
					arg_79_1.var_.characterEffect10093 = var_82_17
				end

				arg_79_1.var_.alphaOldValue10093 = 0
			end

			local var_82_18 = 0.0333333333333333

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_18 then
				local var_82_19 = (arg_79_1.time_ - var_82_16) / var_82_18
				local var_82_20 = Mathf.Lerp(arg_79_1.var_.alphaOldValue10093, 1, var_82_19)

				if arg_79_1.var_.characterEffect10093 then
					arg_79_1.var_.characterEffect10093.alpha = var_82_20
				end
			end

			if arg_79_1.time_ >= var_82_16 + var_82_18 and arg_79_1.time_ < var_82_16 + var_82_18 + arg_82_0 and arg_79_1.var_.characterEffect10093 then
				arg_79_1.var_.characterEffect10093.alpha = 1
			end

			local var_82_21 = 0
			local var_82_22 = 0.075

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[28].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(413101018)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 3
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101018", "story_v_out_413101.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_413101", "413101018", "story_v_out_413101.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_413101", "413101018", "story_v_out_413101.awb")

						arg_79_1:RecordAudio("413101018", var_82_30)
						arg_79_1:RecordAudio("413101018", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_413101", "413101018", "story_v_out_413101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_413101", "413101018", "story_v_out_413101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play413101019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 413101019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play413101020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10093"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10093 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10093", 7)

				local var_86_2 = var_86_0.childCount

				for iter_86_0 = 0, var_86_2 - 1 do
					local var_86_3 = var_86_0:GetChild(iter_86_0)

					if var_86_3.name == "" or not string.find(var_86_3.name, "split") then
						var_86_3.gameObject:SetActive(true)
					else
						var_86_3.gameObject:SetActive(false)
					end
				end
			end

			local var_86_4 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_1) / var_86_4
				local var_86_6 = Vector3.New(0, -2000, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10093, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_86_7 = arg_83_1.actors_["10093"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10093 == nil then
				arg_83_1.var_.actorSpriteComps10093 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 2

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps10093 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								local var_86_11 = Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor2.r, var_86_10)
								local var_86_12 = Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor2.g, var_86_10)
								local var_86_13 = Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor2.b, var_86_10)

								iter_86_2.color = Color.New(var_86_11, var_86_12, var_86_13)
							else
								local var_86_14 = Mathf.Lerp(iter_86_2.color.r, 0.5, var_86_10)

								iter_86_2.color = Color.New(var_86_14, var_86_14, var_86_14)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10093 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10093 = nil
			end

			local var_86_15 = 0
			local var_86_16 = 1.05

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_17 = arg_83_1:GetWordFromCfg(413101019)
				local var_86_18 = arg_83_1:FormatText(var_86_17.content)

				arg_83_1.text_.text = var_86_18

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_19 = 41
				local var_86_20 = utf8.len(var_86_18)
				local var_86_21 = var_86_19 <= 0 and var_86_16 or var_86_16 * (var_86_20 / var_86_19)

				if var_86_21 > 0 and var_86_16 < var_86_21 then
					arg_83_1.talkMaxDuration = var_86_21

					if var_86_21 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_21 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_18
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_22 and arg_83_1.time_ < var_86_15 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play413101020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413101020
		arg_87_1.duration_ = 2

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play413101021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10093"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10093 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10093", 3)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "split_4" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(0, -345, -245)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10093, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_90_7 = arg_87_1.actors_["10093"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10093 == nil then
				arg_87_1.var_.actorSpriteComps10093 = var_90_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 2

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 and not isNil(var_90_7) then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / var_90_9

				if arg_87_1.var_.actorSpriteComps10093 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								local var_90_11 = Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor1.r, var_90_10)
								local var_90_12 = Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor1.g, var_90_10)
								local var_90_13 = Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor1.b, var_90_10)

								iter_90_2.color = Color.New(var_90_11, var_90_12, var_90_13)
							else
								local var_90_14 = Mathf.Lerp(iter_90_2.color.r, 1, var_90_10)

								iter_90_2.color = Color.New(var_90_14, var_90_14, var_90_14)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10093 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_90_4 then
						if arg_87_1.isInRecall_ then
							iter_90_4.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10093 = nil
			end

			local var_90_15 = 0
			local var_90_16 = 0.15

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[28].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_18 = arg_87_1:GetWordFromCfg(413101020)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 6
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101020", "story_v_out_413101.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101020", "story_v_out_413101.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_out_413101", "413101020", "story_v_out_413101.awb")

						arg_87_1:RecordAudio("413101020", var_90_24)
						arg_87_1:RecordAudio("413101020", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413101", "413101020", "story_v_out_413101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413101", "413101020", "story_v_out_413101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play413101021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413101021
		arg_91_1.duration_ = 4.17

		local var_91_0 = {
			zh = 2.433,
			ja = 4.166
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play413101022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = "10092"

			if arg_91_1.actors_[var_94_0] == nil then
				local var_94_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_94_1) then
					local var_94_2 = Object.Instantiate(var_94_1, arg_91_1.canvasGo_.transform)

					var_94_2.transform:SetSiblingIndex(1)

					var_94_2.name = var_94_0
					var_94_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_91_1.actors_[var_94_0] = var_94_2

					local var_94_3 = var_94_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_91_1.isInRecall_ then
						for iter_94_0, iter_94_1 in ipairs(var_94_3) do
							iter_94_1.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_94_4 = arg_91_1.actors_["10092"].transform
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.var_.moveOldPos10092 = var_94_4.localPosition
				var_94_4.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10092", 3)

				local var_94_6 = var_94_4.childCount

				for iter_94_2 = 0, var_94_6 - 1 do
					local var_94_7 = var_94_4:GetChild(iter_94_2)

					if var_94_7.name == "" or not string.find(var_94_7.name, "split") then
						var_94_7.gameObject:SetActive(true)
					else
						var_94_7.gameObject:SetActive(false)
					end
				end
			end

			local var_94_8 = 0.001

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_8 then
				local var_94_9 = (arg_91_1.time_ - var_94_5) / var_94_8
				local var_94_10 = Vector3.New(0, -300, -295)

				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10092, var_94_10, var_94_9)
			end

			if arg_91_1.time_ >= var_94_5 + var_94_8 and arg_91_1.time_ < var_94_5 + var_94_8 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, -300, -295)
			end

			local var_94_11 = arg_91_1.actors_["10093"].transform
			local var_94_12 = 0

			if var_94_12 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.var_.moveOldPos10093 = var_94_11.localPosition
				var_94_11.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10093", 7)

				local var_94_13 = var_94_11.childCount

				for iter_94_3 = 0, var_94_13 - 1 do
					local var_94_14 = var_94_11:GetChild(iter_94_3)

					if var_94_14.name == "" or not string.find(var_94_14.name, "split") then
						var_94_14.gameObject:SetActive(true)
					else
						var_94_14.gameObject:SetActive(false)
					end
				end
			end

			local var_94_15 = 0.001

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_15 then
				local var_94_16 = (arg_91_1.time_ - var_94_12) / var_94_15
				local var_94_17 = Vector3.New(0, -2000, 0)

				var_94_11.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10093, var_94_17, var_94_16)
			end

			if arg_91_1.time_ >= var_94_12 + var_94_15 and arg_91_1.time_ < var_94_12 + var_94_15 + arg_94_0 then
				var_94_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_94_18 = arg_91_1.actors_["10092"]
			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.actorSpriteComps10092 == nil then
				arg_91_1.var_.actorSpriteComps10092 = var_94_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_20 = 2

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 and not isNil(var_94_18) then
				local var_94_21 = (arg_91_1.time_ - var_94_19) / var_94_20

				if arg_91_1.var_.actorSpriteComps10092 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								local var_94_22 = Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor1.r, var_94_21)
								local var_94_23 = Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor1.g, var_94_21)
								local var_94_24 = Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor1.b, var_94_21)

								iter_94_5.color = Color.New(var_94_22, var_94_23, var_94_24)
							else
								local var_94_25 = Mathf.Lerp(iter_94_5.color.r, 1, var_94_21)

								iter_94_5.color = Color.New(var_94_25, var_94_25, var_94_25)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.actorSpriteComps10092 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_94_7 then
						if arg_91_1.isInRecall_ then
							iter_94_7.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10092 = nil
			end

			local var_94_26 = arg_91_1.actors_["10093"]
			local var_94_27 = 0

			if var_94_27 < arg_91_1.time_ and arg_91_1.time_ <= var_94_27 + arg_94_0 and not isNil(var_94_26) and arg_91_1.var_.actorSpriteComps10093 == nil then
				arg_91_1.var_.actorSpriteComps10093 = var_94_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_28 = 2

			if var_94_27 <= arg_91_1.time_ and arg_91_1.time_ < var_94_27 + var_94_28 and not isNil(var_94_26) then
				local var_94_29 = (arg_91_1.time_ - var_94_27) / var_94_28

				if arg_91_1.var_.actorSpriteComps10093 then
					for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_94_9 then
							if arg_91_1.isInRecall_ then
								local var_94_30 = Mathf.Lerp(iter_94_9.color.r, arg_91_1.hightColor2.r, var_94_29)
								local var_94_31 = Mathf.Lerp(iter_94_9.color.g, arg_91_1.hightColor2.g, var_94_29)
								local var_94_32 = Mathf.Lerp(iter_94_9.color.b, arg_91_1.hightColor2.b, var_94_29)

								iter_94_9.color = Color.New(var_94_30, var_94_31, var_94_32)
							else
								local var_94_33 = Mathf.Lerp(iter_94_9.color.r, 0.5, var_94_29)

								iter_94_9.color = Color.New(var_94_33, var_94_33, var_94_33)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_27 + var_94_28 and arg_91_1.time_ < var_94_27 + var_94_28 + arg_94_0 and not isNil(var_94_26) and arg_91_1.var_.actorSpriteComps10093 then
				for iter_94_10, iter_94_11 in pairs(arg_91_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_94_11 then
						if arg_91_1.isInRecall_ then
							iter_94_11.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10093 = nil
			end

			local var_94_34 = 0
			local var_94_35 = 0.325

			if var_94_34 < arg_91_1.time_ and arg_91_1.time_ <= var_94_34 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_36 = arg_91_1:FormatText(StoryNameCfg[996].name)

				arg_91_1.leftNameTxt_.text = var_94_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_37 = arg_91_1:GetWordFromCfg(413101021)
				local var_94_38 = arg_91_1:FormatText(var_94_37.content)

				arg_91_1.text_.text = var_94_38

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_39 = 13
				local var_94_40 = utf8.len(var_94_38)
				local var_94_41 = var_94_39 <= 0 and var_94_35 or var_94_35 * (var_94_40 / var_94_39)

				if var_94_41 > 0 and var_94_35 < var_94_41 then
					arg_91_1.talkMaxDuration = var_94_41

					if var_94_41 + var_94_34 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_41 + var_94_34
					end
				end

				arg_91_1.text_.text = var_94_38
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101021", "story_v_out_413101.awb") ~= 0 then
					local var_94_42 = manager.audio:GetVoiceLength("story_v_out_413101", "413101021", "story_v_out_413101.awb") / 1000

					if var_94_42 + var_94_34 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_42 + var_94_34
					end

					if var_94_37.prefab_name ~= "" and arg_91_1.actors_[var_94_37.prefab_name] ~= nil then
						local var_94_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_37.prefab_name].transform, "story_v_out_413101", "413101021", "story_v_out_413101.awb")

						arg_91_1:RecordAudio("413101021", var_94_43)
						arg_91_1:RecordAudio("413101021", var_94_43)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413101", "413101021", "story_v_out_413101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413101", "413101021", "story_v_out_413101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_44 = math.max(var_94_35, arg_91_1.talkMaxDuration)

			if var_94_34 <= arg_91_1.time_ and arg_91_1.time_ < var_94_34 + var_94_44 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_34) / var_94_44

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_34 + var_94_44 and arg_91_1.time_ < var_94_34 + var_94_44 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play413101022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413101022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play413101023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10092"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10092 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10092", 6)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(1500, -300, -295)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10092, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_98_7 = arg_95_1.actors_["10093"].transform
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.var_.moveOldPos10093 = var_98_7.localPosition
				var_98_7.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10093", 6)

				local var_98_9 = var_98_7.childCount

				for iter_98_1 = 0, var_98_9 - 1 do
					local var_98_10 = var_98_7:GetChild(iter_98_1)

					if var_98_10.name == "" or not string.find(var_98_10.name, "split") then
						var_98_10.gameObject:SetActive(true)
					else
						var_98_10.gameObject:SetActive(false)
					end
				end
			end

			local var_98_11 = 0.001

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_11 then
				local var_98_12 = (arg_95_1.time_ - var_98_8) / var_98_11
				local var_98_13 = Vector3.New(1500, -345, -245)

				var_98_7.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10093, var_98_13, var_98_12)
			end

			if arg_95_1.time_ >= var_98_8 + var_98_11 and arg_95_1.time_ < var_98_8 + var_98_11 + arg_98_0 then
				var_98_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_98_14 = arg_95_1.actors_["10092"]
			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10092 == nil then
				arg_95_1.var_.actorSpriteComps10092 = var_98_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_16 = 2

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_16 and not isNil(var_98_14) then
				local var_98_17 = (arg_95_1.time_ - var_98_15) / var_98_16

				if arg_95_1.var_.actorSpriteComps10092 then
					for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_98_3 then
							if arg_95_1.isInRecall_ then
								local var_98_18 = Mathf.Lerp(iter_98_3.color.r, arg_95_1.hightColor2.r, var_98_17)
								local var_98_19 = Mathf.Lerp(iter_98_3.color.g, arg_95_1.hightColor2.g, var_98_17)
								local var_98_20 = Mathf.Lerp(iter_98_3.color.b, arg_95_1.hightColor2.b, var_98_17)

								iter_98_3.color = Color.New(var_98_18, var_98_19, var_98_20)
							else
								local var_98_21 = Mathf.Lerp(iter_98_3.color.r, 0.5, var_98_17)

								iter_98_3.color = Color.New(var_98_21, var_98_21, var_98_21)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_15 + var_98_16 and arg_95_1.time_ < var_98_15 + var_98_16 + arg_98_0 and not isNil(var_98_14) and arg_95_1.var_.actorSpriteComps10092 then
				for iter_98_4, iter_98_5 in pairs(arg_95_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_98_5 then
						if arg_95_1.isInRecall_ then
							iter_98_5.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10092 = nil
			end

			local var_98_22 = arg_95_1.actors_["10093"]
			local var_98_23 = 0

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.actorSpriteComps10093 == nil then
				arg_95_1.var_.actorSpriteComps10093 = var_98_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_24 = 2

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_24 and not isNil(var_98_22) then
				local var_98_25 = (arg_95_1.time_ - var_98_23) / var_98_24

				if arg_95_1.var_.actorSpriteComps10093 then
					for iter_98_6, iter_98_7 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_98_7 then
							if arg_95_1.isInRecall_ then
								local var_98_26 = Mathf.Lerp(iter_98_7.color.r, arg_95_1.hightColor2.r, var_98_25)
								local var_98_27 = Mathf.Lerp(iter_98_7.color.g, arg_95_1.hightColor2.g, var_98_25)
								local var_98_28 = Mathf.Lerp(iter_98_7.color.b, arg_95_1.hightColor2.b, var_98_25)

								iter_98_7.color = Color.New(var_98_26, var_98_27, var_98_28)
							else
								local var_98_29 = Mathf.Lerp(iter_98_7.color.r, 0.5, var_98_25)

								iter_98_7.color = Color.New(var_98_29, var_98_29, var_98_29)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_23 + var_98_24 and arg_95_1.time_ < var_98_23 + var_98_24 + arg_98_0 and not isNil(var_98_22) and arg_95_1.var_.actorSpriteComps10093 then
				for iter_98_8, iter_98_9 in pairs(arg_95_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_98_9 then
						if arg_95_1.isInRecall_ then
							iter_98_9.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10093 = nil
			end

			local var_98_30 = 0
			local var_98_31 = 0.75

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_32 = arg_95_1:GetWordFromCfg(413101022)
				local var_98_33 = arg_95_1:FormatText(var_98_32.content)

				arg_95_1.text_.text = var_98_33

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_34 = 30
				local var_98_35 = utf8.len(var_98_33)
				local var_98_36 = var_98_34 <= 0 and var_98_31 or var_98_31 * (var_98_35 / var_98_34)

				if var_98_36 > 0 and var_98_31 < var_98_36 then
					arg_95_1.talkMaxDuration = var_98_36

					if var_98_36 + var_98_30 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_36 + var_98_30
					end
				end

				arg_95_1.text_.text = var_98_33
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_37 = math.max(var_98_31, arg_95_1.talkMaxDuration)

			if var_98_30 <= arg_95_1.time_ and arg_95_1.time_ < var_98_30 + var_98_37 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_30) / var_98_37

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_30 + var_98_37 and arg_95_1.time_ < var_98_30 + var_98_37 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play413101023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 413101023
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play413101024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.55

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(413101023)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 62
				local var_102_5 = utf8.len(var_102_3)
				local var_102_6 = var_102_4 <= 0 and var_102_1 or var_102_1 * (var_102_5 / var_102_4)

				if var_102_6 > 0 and var_102_1 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_7 and arg_99_1.time_ < var_102_0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play413101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413101024
		arg_103_1.duration_ = 5.73

		local var_103_0 = {
			zh = 2.966,
			ja = 5.733
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play413101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = "10094"

			if arg_103_1.actors_[var_106_0] == nil then
				local var_106_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_106_1) then
					local var_106_2 = Object.Instantiate(var_106_1, arg_103_1.canvasGo_.transform)

					var_106_2.transform:SetSiblingIndex(1)

					var_106_2.name = var_106_0
					var_106_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_103_1.actors_[var_106_0] = var_106_2

					local var_106_3 = var_106_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_103_1.isInRecall_ then
						for iter_106_0, iter_106_1 in ipairs(var_106_3) do
							iter_106_1.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_106_4 = arg_103_1.actors_["10094"].transform
			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.var_.moveOldPos10094 = var_106_4.localPosition
				var_106_4.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10094", 3)

				local var_106_6 = var_106_4.childCount

				for iter_106_2 = 0, var_106_6 - 1 do
					local var_106_7 = var_106_4:GetChild(iter_106_2)

					if var_106_7.name == "split_1" or not string.find(var_106_7.name, "split") then
						var_106_7.gameObject:SetActive(true)
					else
						var_106_7.gameObject:SetActive(false)
					end
				end
			end

			local var_106_8 = 0.001

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_8 then
				local var_106_9 = (arg_103_1.time_ - var_106_5) / var_106_8
				local var_106_10 = Vector3.New(0, -340, -414)

				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10094, var_106_10, var_106_9)
			end

			if arg_103_1.time_ >= var_106_5 + var_106_8 and arg_103_1.time_ < var_106_5 + var_106_8 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(0, -340, -414)
			end

			local var_106_11 = arg_103_1.actors_["10094"]
			local var_106_12 = 0

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.actorSpriteComps10094 == nil then
				arg_103_1.var_.actorSpriteComps10094 = var_106_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_13 = 2

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_13 and not isNil(var_106_11) then
				local var_106_14 = (arg_103_1.time_ - var_106_12) / var_106_13

				if arg_103_1.var_.actorSpriteComps10094 then
					for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_106_4 then
							if arg_103_1.isInRecall_ then
								local var_106_15 = Mathf.Lerp(iter_106_4.color.r, arg_103_1.hightColor1.r, var_106_14)
								local var_106_16 = Mathf.Lerp(iter_106_4.color.g, arg_103_1.hightColor1.g, var_106_14)
								local var_106_17 = Mathf.Lerp(iter_106_4.color.b, arg_103_1.hightColor1.b, var_106_14)

								iter_106_4.color = Color.New(var_106_15, var_106_16, var_106_17)
							else
								local var_106_18 = Mathf.Lerp(iter_106_4.color.r, 1, var_106_14)

								iter_106_4.color = Color.New(var_106_18, var_106_18, var_106_18)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_12 + var_106_13 and arg_103_1.time_ < var_106_12 + var_106_13 + arg_106_0 and not isNil(var_106_11) and arg_103_1.var_.actorSpriteComps10094 then
				for iter_106_5, iter_106_6 in pairs(arg_103_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_106_6 then
						if arg_103_1.isInRecall_ then
							iter_106_6.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps10094 = nil
			end

			local var_106_19 = 0
			local var_106_20 = 0.325

			if var_106_19 < arg_103_1.time_ and arg_103_1.time_ <= var_106_19 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_21 = arg_103_1:FormatText(StoryNameCfg[259].name)

				arg_103_1.leftNameTxt_.text = var_106_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_22 = arg_103_1:GetWordFromCfg(413101024)
				local var_106_23 = arg_103_1:FormatText(var_106_22.content)

				arg_103_1.text_.text = var_106_23

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_24 = 13
				local var_106_25 = utf8.len(var_106_23)
				local var_106_26 = var_106_24 <= 0 and var_106_20 or var_106_20 * (var_106_25 / var_106_24)

				if var_106_26 > 0 and var_106_20 < var_106_26 then
					arg_103_1.talkMaxDuration = var_106_26

					if var_106_26 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_26 + var_106_19
					end
				end

				arg_103_1.text_.text = var_106_23
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101024", "story_v_out_413101.awb") ~= 0 then
					local var_106_27 = manager.audio:GetVoiceLength("story_v_out_413101", "413101024", "story_v_out_413101.awb") / 1000

					if var_106_27 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_27 + var_106_19
					end

					if var_106_22.prefab_name ~= "" and arg_103_1.actors_[var_106_22.prefab_name] ~= nil then
						local var_106_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_22.prefab_name].transform, "story_v_out_413101", "413101024", "story_v_out_413101.awb")

						arg_103_1:RecordAudio("413101024", var_106_28)
						arg_103_1:RecordAudio("413101024", var_106_28)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413101", "413101024", "story_v_out_413101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413101", "413101024", "story_v_out_413101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_29 = math.max(var_106_20, arg_103_1.talkMaxDuration)

			if var_106_19 <= arg_103_1.time_ and arg_103_1.time_ < var_106_19 + var_106_29 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_19) / var_106_29

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_19 + var_106_29 and arg_103_1.time_ < var_106_19 + var_106_29 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play413101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413101025
		arg_107_1.duration_ = 8.47

		local var_107_0 = {
			zh = 5.966,
			ja = 8.466
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play413101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10092"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10092 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10092", 4)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(390, -300, -295)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10092, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_110_7 = arg_107_1.actors_["10092"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10092 == nil then
				arg_107_1.var_.actorSpriteComps10092 = var_110_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 2

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_9 and not isNil(var_110_7) then
				local var_110_10 = (arg_107_1.time_ - var_110_8) / var_110_9

				if arg_107_1.var_.actorSpriteComps10092 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								local var_110_11 = Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, var_110_10)
								local var_110_12 = Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, var_110_10)
								local var_110_13 = Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, var_110_10)

								iter_110_2.color = Color.New(var_110_11, var_110_12, var_110_13)
							else
								local var_110_14 = Mathf.Lerp(iter_110_2.color.r, 1, var_110_10)

								iter_110_2.color = Color.New(var_110_14, var_110_14, var_110_14)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_8 + var_110_9 and arg_107_1.time_ < var_110_8 + var_110_9 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10092 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_110_4 then
						if arg_107_1.isInRecall_ then
							iter_110_4.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10092 = nil
			end

			local var_110_15 = arg_107_1.actors_["10094"].transform
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.var_.moveOldPos10094 = var_110_15.localPosition
				var_110_15.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10094", 2)

				local var_110_17 = var_110_15.childCount

				for iter_110_5 = 0, var_110_17 - 1 do
					local var_110_18 = var_110_15:GetChild(iter_110_5)

					if var_110_18.name == "" or not string.find(var_110_18.name, "split") then
						var_110_18.gameObject:SetActive(true)
					else
						var_110_18.gameObject:SetActive(false)
					end
				end
			end

			local var_110_19 = 0.001

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_19 then
				local var_110_20 = (arg_107_1.time_ - var_110_16) / var_110_19
				local var_110_21 = Vector3.New(-390, -340, -414)

				var_110_15.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10094, var_110_21, var_110_20)
			end

			if arg_107_1.time_ >= var_110_16 + var_110_19 and arg_107_1.time_ < var_110_16 + var_110_19 + arg_110_0 then
				var_110_15.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_110_22 = arg_107_1.actors_["10094"]
			local var_110_23 = 0

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps10094 == nil then
				arg_107_1.var_.actorSpriteComps10094 = var_110_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_24 = 2

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_24 and not isNil(var_110_22) then
				local var_110_25 = (arg_107_1.time_ - var_110_23) / var_110_24

				if arg_107_1.var_.actorSpriteComps10094 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								local var_110_26 = Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor2.r, var_110_25)
								local var_110_27 = Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor2.g, var_110_25)
								local var_110_28 = Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor2.b, var_110_25)

								iter_110_7.color = Color.New(var_110_26, var_110_27, var_110_28)
							else
								local var_110_29 = Mathf.Lerp(iter_110_7.color.r, 0.5, var_110_25)

								iter_110_7.color = Color.New(var_110_29, var_110_29, var_110_29)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_23 + var_110_24 and arg_107_1.time_ < var_110_23 + var_110_24 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps10094 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_110_9 then
						if arg_107_1.isInRecall_ then
							iter_110_9.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10094 = nil
			end

			local var_110_30 = 0
			local var_110_31 = 0.825

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[996].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(413101025)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 33
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101025", "story_v_out_413101.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101025", "story_v_out_413101.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_413101", "413101025", "story_v_out_413101.awb")

						arg_107_1:RecordAudio("413101025", var_110_39)
						arg_107_1:RecordAudio("413101025", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413101", "413101025", "story_v_out_413101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413101", "413101025", "story_v_out_413101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play413101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413101026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play413101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10092"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10092 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10092", 7)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(0, -2000, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10092, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_114_7 = arg_111_1.actors_["10092"]
			local var_114_8 = 0

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps10092 == nil then
				arg_111_1.var_.actorSpriteComps10092 = var_114_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 2

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 and not isNil(var_114_7) then
				local var_114_10 = (arg_111_1.time_ - var_114_8) / var_114_9

				if arg_111_1.var_.actorSpriteComps10092 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								local var_114_11 = Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor2.r, var_114_10)
								local var_114_12 = Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor2.g, var_114_10)
								local var_114_13 = Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor2.b, var_114_10)

								iter_114_2.color = Color.New(var_114_11, var_114_12, var_114_13)
							else
								local var_114_14 = Mathf.Lerp(iter_114_2.color.r, 0.5, var_114_10)

								iter_114_2.color = Color.New(var_114_14, var_114_14, var_114_14)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps10092 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_114_4 then
						if arg_111_1.isInRecall_ then
							iter_114_4.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10092 = nil
			end

			local var_114_15 = arg_111_1.actors_["10092"]
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps10092 == nil then
				arg_111_1.var_.actorSpriteComps10092 = var_114_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_17 = 2

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 and not isNil(var_114_15) then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17

				if arg_111_1.var_.actorSpriteComps10092 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_114_6 then
							if arg_111_1.isInRecall_ then
								local var_114_19 = Mathf.Lerp(iter_114_6.color.r, arg_111_1.hightColor2.r, var_114_18)
								local var_114_20 = Mathf.Lerp(iter_114_6.color.g, arg_111_1.hightColor2.g, var_114_18)
								local var_114_21 = Mathf.Lerp(iter_114_6.color.b, arg_111_1.hightColor2.b, var_114_18)

								iter_114_6.color = Color.New(var_114_19, var_114_20, var_114_21)
							else
								local var_114_22 = Mathf.Lerp(iter_114_6.color.r, 0.5, var_114_18)

								iter_114_6.color = Color.New(var_114_22, var_114_22, var_114_22)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps10092 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_114_8 then
						if arg_111_1.isInRecall_ then
							iter_114_8.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10092 = nil
			end

			local var_114_23 = arg_111_1.actors_["10094"].transform
			local var_114_24 = 0

			if var_114_24 < arg_111_1.time_ and arg_111_1.time_ <= var_114_24 + arg_114_0 then
				arg_111_1.var_.moveOldPos10094 = var_114_23.localPosition
				var_114_23.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10094", 7)

				local var_114_25 = var_114_23.childCount

				for iter_114_9 = 0, var_114_25 - 1 do
					local var_114_26 = var_114_23:GetChild(iter_114_9)

					if var_114_26.name == "" or not string.find(var_114_26.name, "split") then
						var_114_26.gameObject:SetActive(true)
					else
						var_114_26.gameObject:SetActive(false)
					end
				end
			end

			local var_114_27 = 0.001

			if var_114_24 <= arg_111_1.time_ and arg_111_1.time_ < var_114_24 + var_114_27 then
				local var_114_28 = (arg_111_1.time_ - var_114_24) / var_114_27
				local var_114_29 = Vector3.New(0, -2000, 0)

				var_114_23.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10094, var_114_29, var_114_28)
			end

			if arg_111_1.time_ >= var_114_24 + var_114_27 and arg_111_1.time_ < var_114_24 + var_114_27 + arg_114_0 then
				var_114_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_114_30 = 0
			local var_114_31 = 1.1

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_32 = arg_111_1:GetWordFromCfg(413101026)
				local var_114_33 = arg_111_1:FormatText(var_114_32.content)

				arg_111_1.text_.text = var_114_33

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_34 = 44
				local var_114_35 = utf8.len(var_114_33)
				local var_114_36 = var_114_34 <= 0 and var_114_31 or var_114_31 * (var_114_35 / var_114_34)

				if var_114_36 > 0 and var_114_31 < var_114_36 then
					arg_111_1.talkMaxDuration = var_114_36

					if var_114_36 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_36 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_33
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_37 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_37 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_37

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_37 and arg_111_1.time_ < var_114_30 + var_114_37 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play413101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413101027
		arg_115_1.duration_ = 9.53

		local var_115_0 = {
			zh = 4.9,
			ja = 9.533
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
				arg_115_0:Play413101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "10022"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(var_118_1, arg_115_1.canvasGo_.transform)

					var_118_2.transform:SetSiblingIndex(1)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs(var_118_3) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_4 = arg_115_1.actors_["10022"].transform
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.var_.moveOldPos10022 = var_118_4.localPosition
				var_118_4.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10022", 2)

				local var_118_6 = var_118_4.childCount

				for iter_118_2 = 0, var_118_6 - 1 do
					local var_118_7 = var_118_4:GetChild(iter_118_2)

					if var_118_7.name == "split_2" or not string.find(var_118_7.name, "split") then
						var_118_7.gameObject:SetActive(true)
					else
						var_118_7.gameObject:SetActive(false)
					end
				end
			end

			local var_118_8 = 0.001

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_5) / var_118_8
				local var_118_10 = Vector3.New(-390, -315, -320)

				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10022, var_118_10, var_118_9)
			end

			if arg_115_1.time_ >= var_118_5 + var_118_8 and arg_115_1.time_ < var_118_5 + var_118_8 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_118_11 = arg_115_1.actors_["10022"]
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10022 == nil then
				arg_115_1.var_.actorSpriteComps10022 = var_118_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_13 = 2

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 and not isNil(var_118_11) then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13

				if arg_115_1.var_.actorSpriteComps10022 then
					for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_118_4 then
							if arg_115_1.isInRecall_ then
								local var_118_15 = Mathf.Lerp(iter_118_4.color.r, arg_115_1.hightColor1.r, var_118_14)
								local var_118_16 = Mathf.Lerp(iter_118_4.color.g, arg_115_1.hightColor1.g, var_118_14)
								local var_118_17 = Mathf.Lerp(iter_118_4.color.b, arg_115_1.hightColor1.b, var_118_14)

								iter_118_4.color = Color.New(var_118_15, var_118_16, var_118_17)
							else
								local var_118_18 = Mathf.Lerp(iter_118_4.color.r, 1, var_118_14)

								iter_118_4.color = Color.New(var_118_18, var_118_18, var_118_18)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10022 then
				for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_118_6 then
						if arg_115_1.isInRecall_ then
							iter_118_6.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10022 = nil
			end

			local var_118_19 = 0
			local var_118_20 = 0.775

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_21 = arg_115_1:FormatText(StoryNameCfg[614].name)

				arg_115_1.leftNameTxt_.text = var_118_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_22 = arg_115_1:GetWordFromCfg(413101027)
				local var_118_23 = arg_115_1:FormatText(var_118_22.content)

				arg_115_1.text_.text = var_118_23

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_24 = 31
				local var_118_25 = utf8.len(var_118_23)
				local var_118_26 = var_118_24 <= 0 and var_118_20 or var_118_20 * (var_118_25 / var_118_24)

				if var_118_26 > 0 and var_118_20 < var_118_26 then
					arg_115_1.talkMaxDuration = var_118_26

					if var_118_26 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_26 + var_118_19
					end
				end

				arg_115_1.text_.text = var_118_23
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101027", "story_v_out_413101.awb") ~= 0 then
					local var_118_27 = manager.audio:GetVoiceLength("story_v_out_413101", "413101027", "story_v_out_413101.awb") / 1000

					if var_118_27 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_19
					end

					if var_118_22.prefab_name ~= "" and arg_115_1.actors_[var_118_22.prefab_name] ~= nil then
						local var_118_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_22.prefab_name].transform, "story_v_out_413101", "413101027", "story_v_out_413101.awb")

						arg_115_1:RecordAudio("413101027", var_118_28)
						arg_115_1:RecordAudio("413101027", var_118_28)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413101", "413101027", "story_v_out_413101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413101", "413101027", "story_v_out_413101.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_29 = math.max(var_118_20, arg_115_1.talkMaxDuration)

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_29 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_19) / var_118_29

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_19 + var_118_29 and arg_115_1.time_ < var_118_19 + var_118_29 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play413101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413101028
		arg_119_1.duration_ = 6.93

		local var_119_0 = {
			zh = 3.766,
			ja = 6.933
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
				arg_119_0:Play413101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10093"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10093 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10093", 4)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_4" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(390, -345, -245)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10093, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(390, -345, -245)
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

			local var_122_15 = arg_119_1.actors_["10022"]
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_17 = 2

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 and not isNil(var_122_15) then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17

				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_122_6 then
							if arg_119_1.isInRecall_ then
								local var_122_19 = Mathf.Lerp(iter_122_6.color.r, arg_119_1.hightColor2.r, var_122_18)
								local var_122_20 = Mathf.Lerp(iter_122_6.color.g, arg_119_1.hightColor2.g, var_122_18)
								local var_122_21 = Mathf.Lerp(iter_122_6.color.b, arg_119_1.hightColor2.b, var_122_18)

								iter_122_6.color = Color.New(var_122_19, var_122_20, var_122_21)
							else
								local var_122_22 = Mathf.Lerp(iter_122_6.color.r, 0.5, var_122_18)

								iter_122_6.color = Color.New(var_122_22, var_122_22, var_122_22)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_8 then
						if arg_119_1.isInRecall_ then
							iter_122_8.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_23 = 0
			local var_122_24 = 0.425

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_25 = arg_119_1:FormatText(StoryNameCfg[28].name)

				arg_119_1.leftNameTxt_.text = var_122_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_26 = arg_119_1:GetWordFromCfg(413101028)
				local var_122_27 = arg_119_1:FormatText(var_122_26.content)

				arg_119_1.text_.text = var_122_27

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101028", "story_v_out_413101.awb") ~= 0 then
					local var_122_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101028", "story_v_out_413101.awb") / 1000

					if var_122_31 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_31 + var_122_23
					end

					if var_122_26.prefab_name ~= "" and arg_119_1.actors_[var_122_26.prefab_name] ~= nil then
						local var_122_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_26.prefab_name].transform, "story_v_out_413101", "413101028", "story_v_out_413101.awb")

						arg_119_1:RecordAudio("413101028", var_122_32)
						arg_119_1:RecordAudio("413101028", var_122_32)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413101", "413101028", "story_v_out_413101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413101", "413101028", "story_v_out_413101.awb")
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
	Play413101029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413101029
		arg_123_1.duration_ = 2.2

		local var_123_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413101030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10022"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10022 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10022", 2)

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
				local var_126_6 = Vector3.New(-390, -315, -320)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10022, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_126_7 = arg_123_1.actors_["10093"].transform
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.var_.moveOldPos10093 = var_126_7.localPosition
				var_126_7.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10093", 4)

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
				local var_126_13 = Vector3.New(390, -345, -245)

				var_126_7.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10093, var_126_13, var_126_12)
			end

			if arg_123_1.time_ >= var_126_8 + var_126_11 and arg_123_1.time_ < var_126_8 + var_126_11 + arg_126_0 then
				var_126_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_126_14 = arg_123_1.actors_["10022"]
			local var_126_15 = 0

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 and not isNil(var_126_14) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_16 = 2

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_16 and not isNil(var_126_14) then
				local var_126_17 = (arg_123_1.time_ - var_126_15) / var_126_16

				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								local var_126_18 = Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, var_126_17)
								local var_126_19 = Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, var_126_17)
								local var_126_20 = Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, var_126_17)

								iter_126_3.color = Color.New(var_126_18, var_126_19, var_126_20)
							else
								local var_126_21 = Mathf.Lerp(iter_126_3.color.r, 1, var_126_17)

								iter_126_3.color = Color.New(var_126_21, var_126_21, var_126_21)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_15 + var_126_16 and arg_123_1.time_ < var_126_15 + var_126_16 + arg_126_0 and not isNil(var_126_14) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_5 then
						if arg_123_1.isInRecall_ then
							iter_126_5.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_22 = arg_123_1.actors_["10093"]
			local var_126_23 = 0

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 and not isNil(var_126_22) and arg_123_1.var_.actorSpriteComps10093 == nil then
				arg_123_1.var_.actorSpriteComps10093 = var_126_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_24 = 2

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_24 and not isNil(var_126_22) then
				local var_126_25 = (arg_123_1.time_ - var_126_23) / var_126_24

				if arg_123_1.var_.actorSpriteComps10093 then
					for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_126_7 then
							if arg_123_1.isInRecall_ then
								local var_126_26 = Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor2.r, var_126_25)
								local var_126_27 = Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor2.g, var_126_25)
								local var_126_28 = Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor2.b, var_126_25)

								iter_126_7.color = Color.New(var_126_26, var_126_27, var_126_28)
							else
								local var_126_29 = Mathf.Lerp(iter_126_7.color.r, 0.5, var_126_25)

								iter_126_7.color = Color.New(var_126_29, var_126_29, var_126_29)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_23 + var_126_24 and arg_123_1.time_ < var_126_23 + var_126_24 + arg_126_0 and not isNil(var_126_22) and arg_123_1.var_.actorSpriteComps10093 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_126_9 then
						if arg_123_1.isInRecall_ then
							iter_126_9.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10093 = nil
			end

			local var_126_30 = 0
			local var_126_31 = 0.125

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_32 = arg_123_1:FormatText(StoryNameCfg[614].name)

				arg_123_1.leftNameTxt_.text = var_126_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_33 = arg_123_1:GetWordFromCfg(413101029)
				local var_126_34 = arg_123_1:FormatText(var_126_33.content)

				arg_123_1.text_.text = var_126_34

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_35 = 5
				local var_126_36 = utf8.len(var_126_34)
				local var_126_37 = var_126_35 <= 0 and var_126_31 or var_126_31 * (var_126_36 / var_126_35)

				if var_126_37 > 0 and var_126_31 < var_126_37 then
					arg_123_1.talkMaxDuration = var_126_37

					if var_126_37 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_37 + var_126_30
					end
				end

				arg_123_1.text_.text = var_126_34
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101029", "story_v_out_413101.awb") ~= 0 then
					local var_126_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101029", "story_v_out_413101.awb") / 1000

					if var_126_38 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_38 + var_126_30
					end

					if var_126_33.prefab_name ~= "" and arg_123_1.actors_[var_126_33.prefab_name] ~= nil then
						local var_126_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_33.prefab_name].transform, "story_v_out_413101", "413101029", "story_v_out_413101.awb")

						arg_123_1:RecordAudio("413101029", var_126_39)
						arg_123_1:RecordAudio("413101029", var_126_39)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413101", "413101029", "story_v_out_413101.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413101", "413101029", "story_v_out_413101.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_40 = math.max(var_126_31, arg_123_1.talkMaxDuration)

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_40 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_30) / var_126_40

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_30 + var_126_40 and arg_123_1.time_ < var_126_30 + var_126_40 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_123_1:InitPlayNodeList()
	end,
	Play413101030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413101030
		arg_127_1.duration_ = 3.63

		local var_127_0 = {
			zh = 3.633,
			ja = 3.1
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
				arg_127_0:Play413101031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.475

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[614].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(413101030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 19
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101030", "story_v_out_413101.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101030", "story_v_out_413101.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_413101", "413101030", "story_v_out_413101.awb")

						arg_127_1:RecordAudio("413101030", var_130_9)
						arg_127_1:RecordAudio("413101030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413101", "413101030", "story_v_out_413101.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413101", "413101030", "story_v_out_413101.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413101031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413101031
		arg_131_1.duration_ = 11.47

		local var_131_0 = {
			zh = 6.4,
			ja = 11.466
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play413101032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10093"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10093 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10093", 4)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "split_4" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(390, -345, -245)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10093, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_134_7 = arg_131_1.actors_["10093"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps10093 == nil then
				arg_131_1.var_.actorSpriteComps10093 = var_134_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 2

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.actorSpriteComps10093 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								local var_134_11 = Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor1.r, var_134_10)
								local var_134_12 = Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor1.g, var_134_10)
								local var_134_13 = Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor1.b, var_134_10)

								iter_134_2.color = Color.New(var_134_11, var_134_12, var_134_13)
							else
								local var_134_14 = Mathf.Lerp(iter_134_2.color.r, 1, var_134_10)

								iter_134_2.color = Color.New(var_134_14, var_134_14, var_134_14)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps10093 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_134_4 then
						if arg_131_1.isInRecall_ then
							iter_134_4.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10093 = nil
			end

			local var_134_15 = arg_131_1.actors_["10022"]
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = var_134_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_17 = 2

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 and not isNil(var_134_15) then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17

				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_5, iter_134_6 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_134_6 then
							if arg_131_1.isInRecall_ then
								local var_134_19 = Mathf.Lerp(iter_134_6.color.r, arg_131_1.hightColor2.r, var_134_18)
								local var_134_20 = Mathf.Lerp(iter_134_6.color.g, arg_131_1.hightColor2.g, var_134_18)
								local var_134_21 = Mathf.Lerp(iter_134_6.color.b, arg_131_1.hightColor2.b, var_134_18)

								iter_134_6.color = Color.New(var_134_19, var_134_20, var_134_21)
							else
								local var_134_22 = Mathf.Lerp(iter_134_6.color.r, 0.5, var_134_18)

								iter_134_6.color = Color.New(var_134_22, var_134_22, var_134_22)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_7, iter_134_8 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_8 then
						if arg_131_1.isInRecall_ then
							iter_134_8.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_23 = 0
			local var_134_24 = 0.675

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_25 = arg_131_1:FormatText(StoryNameCfg[28].name)

				arg_131_1.leftNameTxt_.text = var_134_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_26 = arg_131_1:GetWordFromCfg(413101031)
				local var_134_27 = arg_131_1:FormatText(var_134_26.content)

				arg_131_1.text_.text = var_134_27

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_28 = 27
				local var_134_29 = utf8.len(var_134_27)
				local var_134_30 = var_134_28 <= 0 and var_134_24 or var_134_24 * (var_134_29 / var_134_28)

				if var_134_30 > 0 and var_134_24 < var_134_30 then
					arg_131_1.talkMaxDuration = var_134_30

					if var_134_30 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_30 + var_134_23
					end
				end

				arg_131_1.text_.text = var_134_27
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101031", "story_v_out_413101.awb") ~= 0 then
					local var_134_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101031", "story_v_out_413101.awb") / 1000

					if var_134_31 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_31 + var_134_23
					end

					if var_134_26.prefab_name ~= "" and arg_131_1.actors_[var_134_26.prefab_name] ~= nil then
						local var_134_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_26.prefab_name].transform, "story_v_out_413101", "413101031", "story_v_out_413101.awb")

						arg_131_1:RecordAudio("413101031", var_134_32)
						arg_131_1:RecordAudio("413101031", var_134_32)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413101", "413101031", "story_v_out_413101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413101", "413101031", "story_v_out_413101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_33 = math.max(var_134_24, arg_131_1.talkMaxDuration)

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_33 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_23) / var_134_33

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_23 + var_134_33 and arg_131_1.time_ < var_134_23 + var_134_33 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play413101032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413101032
		arg_135_1.duration_ = 9.03

		local var_135_0 = {
			zh = 9.033,
			ja = 7.433
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
				arg_135_0:Play413101033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10022"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10022 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10022", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_2" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -315, -320)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10022, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_138_7 = arg_135_1.actors_["10022"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 2

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_11 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, var_138_10)
								local var_138_12 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, var_138_10)
								local var_138_13 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, var_138_10)

								iter_138_2.color = Color.New(var_138_11, var_138_12, var_138_13)
							else
								local var_138_14 = Mathf.Lerp(iter_138_2.color.r, 1, var_138_10)

								iter_138_2.color = Color.New(var_138_14, var_138_14, var_138_14)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_15 = arg_135_1.actors_["10093"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10093 == nil then
				arg_135_1.var_.actorSpriteComps10093 = var_138_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_17 = 2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.actorSpriteComps10093 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								local var_138_19 = Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor2.r, var_138_18)
								local var_138_20 = Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor2.g, var_138_18)
								local var_138_21 = Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor2.b, var_138_18)

								iter_138_6.color = Color.New(var_138_19, var_138_20, var_138_21)
							else
								local var_138_22 = Mathf.Lerp(iter_138_6.color.r, 0.5, var_138_18)

								iter_138_6.color = Color.New(var_138_22, var_138_22, var_138_22)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10093 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_138_8 then
						if arg_135_1.isInRecall_ then
							iter_138_8.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10093 = nil
			end

			local var_138_23 = 0
			local var_138_24 = 0.8

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_25 = arg_135_1:FormatText(StoryNameCfg[614].name)

				arg_135_1.leftNameTxt_.text = var_138_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_26 = arg_135_1:GetWordFromCfg(413101032)
				local var_138_27 = arg_135_1:FormatText(var_138_26.content)

				arg_135_1.text_.text = var_138_27

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_28 = 31
				local var_138_29 = utf8.len(var_138_27)
				local var_138_30 = var_138_28 <= 0 and var_138_24 or var_138_24 * (var_138_29 / var_138_28)

				if var_138_30 > 0 and var_138_24 < var_138_30 then
					arg_135_1.talkMaxDuration = var_138_30

					if var_138_30 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_30 + var_138_23
					end
				end

				arg_135_1.text_.text = var_138_27
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101032", "story_v_out_413101.awb") ~= 0 then
					local var_138_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101032", "story_v_out_413101.awb") / 1000

					if var_138_31 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_23
					end

					if var_138_26.prefab_name ~= "" and arg_135_1.actors_[var_138_26.prefab_name] ~= nil then
						local var_138_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_26.prefab_name].transform, "story_v_out_413101", "413101032", "story_v_out_413101.awb")

						arg_135_1:RecordAudio("413101032", var_138_32)
						arg_135_1:RecordAudio("413101032", var_138_32)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413101", "413101032", "story_v_out_413101.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413101", "413101032", "story_v_out_413101.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_33 = math.max(var_138_24, arg_135_1.talkMaxDuration)

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_33 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_23) / var_138_33

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_23 + var_138_33 and arg_135_1.time_ < var_138_23 + var_138_33 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play413101033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413101033
		arg_139_1.duration_ = 3.43

		local var_139_0 = {
			zh = 2.666,
			ja = 3.433
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play413101034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10093"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10093 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10093", 4)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "split_6" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(390, -345, -245)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10093, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_142_7 = arg_139_1.actors_["10093"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10093 == nil then
				arg_139_1.var_.actorSpriteComps10093 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 2

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps10093 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor1.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor1.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor1.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 1, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10093 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10093 = nil
			end

			local var_142_15 = arg_139_1.actors_["10022"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = var_142_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_17 = 2

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 and not isNil(var_142_15) then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17

				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								local var_142_19 = Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor2.r, var_142_18)
								local var_142_20 = Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor2.g, var_142_18)
								local var_142_21 = Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor2.b, var_142_18)

								iter_142_6.color = Color.New(var_142_19, var_142_20, var_142_21)
							else
								local var_142_22 = Mathf.Lerp(iter_142_6.color.r, 0.5, var_142_18)

								iter_142_6.color = Color.New(var_142_22, var_142_22, var_142_22)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_8 then
						if arg_139_1.isInRecall_ then
							iter_142_8.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			local var_142_23 = 0
			local var_142_24 = 0.275

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_25 = arg_139_1:FormatText(StoryNameCfg[28].name)

				arg_139_1.leftNameTxt_.text = var_142_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_26 = arg_139_1:GetWordFromCfg(413101033)
				local var_142_27 = arg_139_1:FormatText(var_142_26.content)

				arg_139_1.text_.text = var_142_27

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_28 = 11
				local var_142_29 = utf8.len(var_142_27)
				local var_142_30 = var_142_28 <= 0 and var_142_24 or var_142_24 * (var_142_29 / var_142_28)

				if var_142_30 > 0 and var_142_24 < var_142_30 then
					arg_139_1.talkMaxDuration = var_142_30

					if var_142_30 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_30 + var_142_23
					end
				end

				arg_139_1.text_.text = var_142_27
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101033", "story_v_out_413101.awb") ~= 0 then
					local var_142_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101033", "story_v_out_413101.awb") / 1000

					if var_142_31 + var_142_23 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_31 + var_142_23
					end

					if var_142_26.prefab_name ~= "" and arg_139_1.actors_[var_142_26.prefab_name] ~= nil then
						local var_142_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_26.prefab_name].transform, "story_v_out_413101", "413101033", "story_v_out_413101.awb")

						arg_139_1:RecordAudio("413101033", var_142_32)
						arg_139_1:RecordAudio("413101033", var_142_32)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413101", "413101033", "story_v_out_413101.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413101", "413101033", "story_v_out_413101.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_33 = math.max(var_142_24, arg_139_1.talkMaxDuration)

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_33 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_23) / var_142_33

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_23 + var_142_33 and arg_139_1.time_ < var_142_23 + var_142_33 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play413101034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413101034
		arg_143_1.duration_ = 8.07

		local var_143_0 = {
			zh = 2.733,
			ja = 8.066
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play413101035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10022"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10022 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10022", 2)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_6" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(-390, -315, -320)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10022, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_146_7 = arg_143_1.actors_["10093"].transform
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.var_.moveOldPos10093 = var_146_7.localPosition
				var_146_7.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10093", 4)

				local var_146_9 = var_146_7.childCount

				for iter_146_1 = 0, var_146_9 - 1 do
					local var_146_10 = var_146_7:GetChild(iter_146_1)

					if var_146_10.name == "" or not string.find(var_146_10.name, "split") then
						var_146_10.gameObject:SetActive(true)
					else
						var_146_10.gameObject:SetActive(false)
					end
				end
			end

			local var_146_11 = 0.001

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_11 then
				local var_146_12 = (arg_143_1.time_ - var_146_8) / var_146_11
				local var_146_13 = Vector3.New(390, -345, -245)

				var_146_7.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10093, var_146_13, var_146_12)
			end

			if arg_143_1.time_ >= var_146_8 + var_146_11 and arg_143_1.time_ < var_146_8 + var_146_11 + arg_146_0 then
				var_146_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_146_14 = arg_143_1.actors_["10022"]
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.actorSpriteComps10022 == nil then
				arg_143_1.var_.actorSpriteComps10022 = var_146_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_16 = 2

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 and not isNil(var_146_14) then
				local var_146_17 = (arg_143_1.time_ - var_146_15) / var_146_16

				if arg_143_1.var_.actorSpriteComps10022 then
					for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_146_3 then
							if arg_143_1.isInRecall_ then
								local var_146_18 = Mathf.Lerp(iter_146_3.color.r, arg_143_1.hightColor1.r, var_146_17)
								local var_146_19 = Mathf.Lerp(iter_146_3.color.g, arg_143_1.hightColor1.g, var_146_17)
								local var_146_20 = Mathf.Lerp(iter_146_3.color.b, arg_143_1.hightColor1.b, var_146_17)

								iter_146_3.color = Color.New(var_146_18, var_146_19, var_146_20)
							else
								local var_146_21 = Mathf.Lerp(iter_146_3.color.r, 1, var_146_17)

								iter_146_3.color = Color.New(var_146_21, var_146_21, var_146_21)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.actorSpriteComps10022 then
				for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_146_5 then
						if arg_143_1.isInRecall_ then
							iter_146_5.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10022 = nil
			end

			local var_146_22 = arg_143_1.actors_["10093"]
			local var_146_23 = 0

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10093 == nil then
				arg_143_1.var_.actorSpriteComps10093 = var_146_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_24 = 2

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 and not isNil(var_146_22) then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24

				if arg_143_1.var_.actorSpriteComps10093 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_146_7 then
							if arg_143_1.isInRecall_ then
								local var_146_26 = Mathf.Lerp(iter_146_7.color.r, arg_143_1.hightColor2.r, var_146_25)
								local var_146_27 = Mathf.Lerp(iter_146_7.color.g, arg_143_1.hightColor2.g, var_146_25)
								local var_146_28 = Mathf.Lerp(iter_146_7.color.b, arg_143_1.hightColor2.b, var_146_25)

								iter_146_7.color = Color.New(var_146_26, var_146_27, var_146_28)
							else
								local var_146_29 = Mathf.Lerp(iter_146_7.color.r, 0.5, var_146_25)

								iter_146_7.color = Color.New(var_146_29, var_146_29, var_146_29)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10093 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_146_9 then
						if arg_143_1.isInRecall_ then
							iter_146_9.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10093 = nil
			end

			local var_146_30 = 0
			local var_146_31 = 0.45

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[614].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(413101034)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 16
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101034", "story_v_out_413101.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101034", "story_v_out_413101.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_413101", "413101034", "story_v_out_413101.awb")

						arg_143_1:RecordAudio("413101034", var_146_39)
						arg_143_1:RecordAudio("413101034", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413101", "413101034", "story_v_out_413101.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413101", "413101034", "story_v_out_413101.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_40 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_40 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_30) / var_146_40

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_30 + var_146_40 and arg_143_1.time_ < var_146_30 + var_146_40 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_143_1:InitPlayNodeList()
	end,
	Play413101035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413101035
		arg_147_1.duration_ = 5.4

		local var_147_0 = {
			zh = 2.466,
			ja = 5.4
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
				arg_147_0:Play413101036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10093"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10093 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10093", 4)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "split_4" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(390, -345, -245)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10093, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_150_7 = arg_147_1.actors_["10093"]
			local var_150_8 = 0

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps10093 == nil then
				arg_147_1.var_.actorSpriteComps10093 = var_150_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_9 = 2

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 and not isNil(var_150_7) then
				local var_150_10 = (arg_147_1.time_ - var_150_8) / var_150_9

				if arg_147_1.var_.actorSpriteComps10093 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								local var_150_11 = Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor1.r, var_150_10)
								local var_150_12 = Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor1.g, var_150_10)
								local var_150_13 = Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor1.b, var_150_10)

								iter_150_2.color = Color.New(var_150_11, var_150_12, var_150_13)
							else
								local var_150_14 = Mathf.Lerp(iter_150_2.color.r, 1, var_150_10)

								iter_150_2.color = Color.New(var_150_14, var_150_14, var_150_14)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps10093 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_150_4 then
						if arg_147_1.isInRecall_ then
							iter_150_4.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10093 = nil
			end

			local var_150_15 = arg_147_1.actors_["10022"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_17 = 2

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 and not isNil(var_150_15) then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_5, iter_150_6 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_150_6 then
							if arg_147_1.isInRecall_ then
								local var_150_19 = Mathf.Lerp(iter_150_6.color.r, arg_147_1.hightColor2.r, var_150_18)
								local var_150_20 = Mathf.Lerp(iter_150_6.color.g, arg_147_1.hightColor2.g, var_150_18)
								local var_150_21 = Mathf.Lerp(iter_150_6.color.b, arg_147_1.hightColor2.b, var_150_18)

								iter_150_6.color = Color.New(var_150_19, var_150_20, var_150_21)
							else
								local var_150_22 = Mathf.Lerp(iter_150_6.color.r, 0.5, var_150_18)

								iter_150_6.color = Color.New(var_150_22, var_150_22, var_150_22)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and not isNil(var_150_15) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_7, iter_150_8 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_8 then
						if arg_147_1.isInRecall_ then
							iter_150_8.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_23 = 0
			local var_150_24 = 0.375

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_25 = arg_147_1:FormatText(StoryNameCfg[28].name)

				arg_147_1.leftNameTxt_.text = var_150_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_26 = arg_147_1:GetWordFromCfg(413101035)
				local var_150_27 = arg_147_1:FormatText(var_150_26.content)

				arg_147_1.text_.text = var_150_27

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_28 = 15
				local var_150_29 = utf8.len(var_150_27)
				local var_150_30 = var_150_28 <= 0 and var_150_24 or var_150_24 * (var_150_29 / var_150_28)

				if var_150_30 > 0 and var_150_24 < var_150_30 then
					arg_147_1.talkMaxDuration = var_150_30

					if var_150_30 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_23
					end
				end

				arg_147_1.text_.text = var_150_27
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101035", "story_v_out_413101.awb") ~= 0 then
					local var_150_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101035", "story_v_out_413101.awb") / 1000

					if var_150_31 + var_150_23 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_31 + var_150_23
					end

					if var_150_26.prefab_name ~= "" and arg_147_1.actors_[var_150_26.prefab_name] ~= nil then
						local var_150_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_26.prefab_name].transform, "story_v_out_413101", "413101035", "story_v_out_413101.awb")

						arg_147_1:RecordAudio("413101035", var_150_32)
						arg_147_1:RecordAudio("413101035", var_150_32)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413101", "413101035", "story_v_out_413101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413101", "413101035", "story_v_out_413101.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_33 = math.max(var_150_24, arg_147_1.talkMaxDuration)

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_33 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_23) / var_150_33

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_23 + var_150_33 and arg_147_1.time_ < var_150_23 + var_150_33 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play413101036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413101036
		arg_151_1.duration_ = 9.83

		local var_151_0 = {
			zh = 9.833,
			ja = 7.966
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
				arg_151_0:Play413101037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10022"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10022 = var_154_0.localPosition
				var_154_0.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10022", 2)

				local var_154_2 = var_154_0.childCount

				for iter_154_0 = 0, var_154_2 - 1 do
					local var_154_3 = var_154_0:GetChild(iter_154_0)

					if var_154_3.name == "split_3" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_4 then
				local var_154_5 = (arg_151_1.time_ - var_154_1) / var_154_4
				local var_154_6 = Vector3.New(-390, -315, -320)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10022, var_154_6, var_154_5)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_4 and arg_151_1.time_ < var_154_1 + var_154_4 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_154_7 = arg_151_1.actors_["10022"]
			local var_154_8 = 0

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = var_154_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_9 = 2

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_9 and not isNil(var_154_7) then
				local var_154_10 = (arg_151_1.time_ - var_154_8) / var_154_9

				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_154_2 then
							if arg_151_1.isInRecall_ then
								local var_154_11 = Mathf.Lerp(iter_154_2.color.r, arg_151_1.hightColor1.r, var_154_10)
								local var_154_12 = Mathf.Lerp(iter_154_2.color.g, arg_151_1.hightColor1.g, var_154_10)
								local var_154_13 = Mathf.Lerp(iter_154_2.color.b, arg_151_1.hightColor1.b, var_154_10)

								iter_154_2.color = Color.New(var_154_11, var_154_12, var_154_13)
							else
								local var_154_14 = Mathf.Lerp(iter_154_2.color.r, 1, var_154_10)

								iter_154_2.color = Color.New(var_154_14, var_154_14, var_154_14)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_8 + var_154_9 and arg_151_1.time_ < var_154_8 + var_154_9 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_4 then
						if arg_151_1.isInRecall_ then
							iter_154_4.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_15 = arg_151_1.actors_["10093"]
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.actorSpriteComps10093 == nil then
				arg_151_1.var_.actorSpriteComps10093 = var_154_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_17 = 2

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 and not isNil(var_154_15) then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17

				if arg_151_1.var_.actorSpriteComps10093 then
					for iter_154_5, iter_154_6 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_154_6 then
							if arg_151_1.isInRecall_ then
								local var_154_19 = Mathf.Lerp(iter_154_6.color.r, arg_151_1.hightColor2.r, var_154_18)
								local var_154_20 = Mathf.Lerp(iter_154_6.color.g, arg_151_1.hightColor2.g, var_154_18)
								local var_154_21 = Mathf.Lerp(iter_154_6.color.b, arg_151_1.hightColor2.b, var_154_18)

								iter_154_6.color = Color.New(var_154_19, var_154_20, var_154_21)
							else
								local var_154_22 = Mathf.Lerp(iter_154_6.color.r, 0.5, var_154_18)

								iter_154_6.color = Color.New(var_154_22, var_154_22, var_154_22)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.actorSpriteComps10093 then
				for iter_154_7, iter_154_8 in pairs(arg_151_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_154_8 then
						if arg_151_1.isInRecall_ then
							iter_154_8.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10093 = nil
			end

			local var_154_23 = 0
			local var_154_24 = 0.85

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_25 = arg_151_1:FormatText(StoryNameCfg[614].name)

				arg_151_1.leftNameTxt_.text = var_154_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_26 = arg_151_1:GetWordFromCfg(413101036)
				local var_154_27 = arg_151_1:FormatText(var_154_26.content)

				arg_151_1.text_.text = var_154_27

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_28 = 34
				local var_154_29 = utf8.len(var_154_27)
				local var_154_30 = var_154_28 <= 0 and var_154_24 or var_154_24 * (var_154_29 / var_154_28)

				if var_154_30 > 0 and var_154_24 < var_154_30 then
					arg_151_1.talkMaxDuration = var_154_30

					if var_154_30 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_30 + var_154_23
					end
				end

				arg_151_1.text_.text = var_154_27
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101036", "story_v_out_413101.awb") ~= 0 then
					local var_154_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101036", "story_v_out_413101.awb") / 1000

					if var_154_31 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_23
					end

					if var_154_26.prefab_name ~= "" and arg_151_1.actors_[var_154_26.prefab_name] ~= nil then
						local var_154_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_26.prefab_name].transform, "story_v_out_413101", "413101036", "story_v_out_413101.awb")

						arg_151_1:RecordAudio("413101036", var_154_32)
						arg_151_1:RecordAudio("413101036", var_154_32)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413101", "413101036", "story_v_out_413101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413101", "413101036", "story_v_out_413101.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_33 = math.max(var_154_24, arg_151_1.talkMaxDuration)

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_33 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_23) / var_154_33

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_23 + var_154_33 and arg_151_1.time_ < var_154_23 + var_154_33 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play413101037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413101037
		arg_155_1.duration_ = 4.53

		local var_155_0 = {
			zh = 4.533,
			ja = 3.933
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
				arg_155_0:Play413101038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10093"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10093 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10093", 4)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_2" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(390, -345, -245)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10093, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_158_7 = arg_155_1.actors_["10093"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10093 == nil then
				arg_155_1.var_.actorSpriteComps10093 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10093 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10093 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10093 = nil
			end

			local var_158_15 = arg_155_1.actors_["10022"]
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_17 = 2

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_17 and not isNil(var_158_15) then
				local var_158_18 = (arg_155_1.time_ - var_158_16) / var_158_17

				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_5, iter_158_6 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_6 then
							if arg_155_1.isInRecall_ then
								local var_158_19 = Mathf.Lerp(iter_158_6.color.r, arg_155_1.hightColor2.r, var_158_18)
								local var_158_20 = Mathf.Lerp(iter_158_6.color.g, arg_155_1.hightColor2.g, var_158_18)
								local var_158_21 = Mathf.Lerp(iter_158_6.color.b, arg_155_1.hightColor2.b, var_158_18)

								iter_158_6.color = Color.New(var_158_19, var_158_20, var_158_21)
							else
								local var_158_22 = Mathf.Lerp(iter_158_6.color.r, 0.5, var_158_18)

								iter_158_6.color = Color.New(var_158_22, var_158_22, var_158_22)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_16 + var_158_17 and arg_155_1.time_ < var_158_16 + var_158_17 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_7, iter_158_8 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_8 then
						if arg_155_1.isInRecall_ then
							iter_158_8.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_23 = 0
			local var_158_24 = 0.55

			if var_158_23 < arg_155_1.time_ and arg_155_1.time_ <= var_158_23 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_25 = arg_155_1:FormatText(StoryNameCfg[28].name)

				arg_155_1.leftNameTxt_.text = var_158_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_26 = arg_155_1:GetWordFromCfg(413101037)
				local var_158_27 = arg_155_1:FormatText(var_158_26.content)

				arg_155_1.text_.text = var_158_27

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_28 = 22
				local var_158_29 = utf8.len(var_158_27)
				local var_158_30 = var_158_28 <= 0 and var_158_24 or var_158_24 * (var_158_29 / var_158_28)

				if var_158_30 > 0 and var_158_24 < var_158_30 then
					arg_155_1.talkMaxDuration = var_158_30

					if var_158_30 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_30 + var_158_23
					end
				end

				arg_155_1.text_.text = var_158_27
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101037", "story_v_out_413101.awb") ~= 0 then
					local var_158_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101037", "story_v_out_413101.awb") / 1000

					if var_158_31 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_31 + var_158_23
					end

					if var_158_26.prefab_name ~= "" and arg_155_1.actors_[var_158_26.prefab_name] ~= nil then
						local var_158_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_26.prefab_name].transform, "story_v_out_413101", "413101037", "story_v_out_413101.awb")

						arg_155_1:RecordAudio("413101037", var_158_32)
						arg_155_1:RecordAudio("413101037", var_158_32)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413101", "413101037", "story_v_out_413101.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413101", "413101037", "story_v_out_413101.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_33 = math.max(var_158_24, arg_155_1.talkMaxDuration)

			if var_158_23 <= arg_155_1.time_ and arg_155_1.time_ < var_158_23 + var_158_33 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_23) / var_158_33

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_23 + var_158_33 and arg_155_1.time_ < var_158_23 + var_158_33 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play413101038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413101038
		arg_159_1.duration_ = 5.3

		local var_159_0 = {
			zh = 3.4,
			ja = 5.3
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play413101039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10022"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 2)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "split_6" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(-390, -315, -320)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_162_7 = arg_159_1.actors_["10022"]
			local var_162_8 = 0

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_9 = 2

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_9 and not isNil(var_162_7) then
				local var_162_10 = (arg_159_1.time_ - var_162_8) / var_162_9

				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								local var_162_11 = Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor1.r, var_162_10)
								local var_162_12 = Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor1.g, var_162_10)
								local var_162_13 = Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor1.b, var_162_10)

								iter_162_2.color = Color.New(var_162_11, var_162_12, var_162_13)
							else
								local var_162_14 = Mathf.Lerp(iter_162_2.color.r, 1, var_162_10)

								iter_162_2.color = Color.New(var_162_14, var_162_14, var_162_14)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_8 + var_162_9 and arg_159_1.time_ < var_162_8 + var_162_9 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_4 then
						if arg_159_1.isInRecall_ then
							iter_162_4.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_15 = arg_159_1.actors_["10093"]
			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps10093 == nil then
				arg_159_1.var_.actorSpriteComps10093 = var_162_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_17 = 2

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 and not isNil(var_162_15) then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17

				if arg_159_1.var_.actorSpriteComps10093 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_162_6 then
							if arg_159_1.isInRecall_ then
								local var_162_19 = Mathf.Lerp(iter_162_6.color.r, arg_159_1.hightColor2.r, var_162_18)
								local var_162_20 = Mathf.Lerp(iter_162_6.color.g, arg_159_1.hightColor2.g, var_162_18)
								local var_162_21 = Mathf.Lerp(iter_162_6.color.b, arg_159_1.hightColor2.b, var_162_18)

								iter_162_6.color = Color.New(var_162_19, var_162_20, var_162_21)
							else
								local var_162_22 = Mathf.Lerp(iter_162_6.color.r, 0.5, var_162_18)

								iter_162_6.color = Color.New(var_162_22, var_162_22, var_162_22)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps10093 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_162_8 then
						if arg_159_1.isInRecall_ then
							iter_162_8.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10093 = nil
			end

			local var_162_23 = 0
			local var_162_24 = 0.3

			if var_162_23 < arg_159_1.time_ and arg_159_1.time_ <= var_162_23 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_25 = arg_159_1:FormatText(StoryNameCfg[614].name)

				arg_159_1.leftNameTxt_.text = var_162_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_26 = arg_159_1:GetWordFromCfg(413101038)
				local var_162_27 = arg_159_1:FormatText(var_162_26.content)

				arg_159_1.text_.text = var_162_27

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_28 = 12
				local var_162_29 = utf8.len(var_162_27)
				local var_162_30 = var_162_28 <= 0 and var_162_24 or var_162_24 * (var_162_29 / var_162_28)

				if var_162_30 > 0 and var_162_24 < var_162_30 then
					arg_159_1.talkMaxDuration = var_162_30

					if var_162_30 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_30 + var_162_23
					end
				end

				arg_159_1.text_.text = var_162_27
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101038", "story_v_out_413101.awb") ~= 0 then
					local var_162_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101038", "story_v_out_413101.awb") / 1000

					if var_162_31 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_31 + var_162_23
					end

					if var_162_26.prefab_name ~= "" and arg_159_1.actors_[var_162_26.prefab_name] ~= nil then
						local var_162_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_26.prefab_name].transform, "story_v_out_413101", "413101038", "story_v_out_413101.awb")

						arg_159_1:RecordAudio("413101038", var_162_32)
						arg_159_1:RecordAudio("413101038", var_162_32)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413101", "413101038", "story_v_out_413101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413101", "413101038", "story_v_out_413101.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_33 = math.max(var_162_24, arg_159_1.talkMaxDuration)

			if var_162_23 <= arg_159_1.time_ and arg_159_1.time_ < var_162_23 + var_162_33 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_23) / var_162_33

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_23 + var_162_33 and arg_159_1.time_ < var_162_23 + var_162_33 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play413101039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413101039
		arg_163_1.duration_ = 4.83

		local var_163_0 = {
			zh = 3.3,
			ja = 4.833
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
				arg_163_0:Play413101040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10093"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10093 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10093", 4)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_6" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(390, -345, -245)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10093, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_166_7 = arg_163_1.actors_["10093"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10093 == nil then
				arg_163_1.var_.actorSpriteComps10093 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10093 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10093 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10093 = nil
			end

			local var_166_15 = arg_163_1.actors_["10022"]
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_17 = 2

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 and not isNil(var_166_15) then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17

				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								local var_166_19 = Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor2.r, var_166_18)
								local var_166_20 = Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor2.g, var_166_18)
								local var_166_21 = Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor2.b, var_166_18)

								iter_166_6.color = Color.New(var_166_19, var_166_20, var_166_21)
							else
								local var_166_22 = Mathf.Lerp(iter_166_6.color.r, 0.5, var_166_18)

								iter_166_6.color = Color.New(var_166_22, var_166_22, var_166_22)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_8 then
						if arg_163_1.isInRecall_ then
							iter_166_8.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_23 = 0
			local var_166_24 = 0.35

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_25 = arg_163_1:FormatText(StoryNameCfg[28].name)

				arg_163_1.leftNameTxt_.text = var_166_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_26 = arg_163_1:GetWordFromCfg(413101039)
				local var_166_27 = arg_163_1:FormatText(var_166_26.content)

				arg_163_1.text_.text = var_166_27

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_28 = 14
				local var_166_29 = utf8.len(var_166_27)
				local var_166_30 = var_166_28 <= 0 and var_166_24 or var_166_24 * (var_166_29 / var_166_28)

				if var_166_30 > 0 and var_166_24 < var_166_30 then
					arg_163_1.talkMaxDuration = var_166_30

					if var_166_30 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_30 + var_166_23
					end
				end

				arg_163_1.text_.text = var_166_27
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101039", "story_v_out_413101.awb") ~= 0 then
					local var_166_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101039", "story_v_out_413101.awb") / 1000

					if var_166_31 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_23
					end

					if var_166_26.prefab_name ~= "" and arg_163_1.actors_[var_166_26.prefab_name] ~= nil then
						local var_166_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_26.prefab_name].transform, "story_v_out_413101", "413101039", "story_v_out_413101.awb")

						arg_163_1:RecordAudio("413101039", var_166_32)
						arg_163_1:RecordAudio("413101039", var_166_32)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413101", "413101039", "story_v_out_413101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413101", "413101039", "story_v_out_413101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_33 = math.max(var_166_24, arg_163_1.talkMaxDuration)

			if var_166_23 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_33 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_23) / var_166_33

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_23 + var_166_33 and arg_163_1.time_ < var_166_23 + var_166_33 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play413101040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413101040
		arg_167_1.duration_ = 11.3

		local var_167_0 = {
			zh = 4.766,
			ja = 11.3
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play413101041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10092"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 2)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "split_1_1" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(-389.49, -300, -295)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_170_7 = arg_167_1.actors_["10092"]
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 2

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 and not isNil(var_170_7) then
				local var_170_10 = (arg_167_1.time_ - var_170_8) / var_170_9

				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								local var_170_11 = Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor1.r, var_170_10)
								local var_170_12 = Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor1.g, var_170_10)
								local var_170_13 = Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor1.b, var_170_10)

								iter_170_2.color = Color.New(var_170_11, var_170_12, var_170_13)
							else
								local var_170_14 = Mathf.Lerp(iter_170_2.color.r, 1, var_170_10)

								iter_170_2.color = Color.New(var_170_14, var_170_14, var_170_14)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_4 then
						if arg_167_1.isInRecall_ then
							iter_170_4.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_15 = arg_167_1.actors_["10093"]
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = var_170_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_17 = 2

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 and not isNil(var_170_15) then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17

				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_6 then
							if arg_167_1.isInRecall_ then
								local var_170_19 = Mathf.Lerp(iter_170_6.color.r, arg_167_1.hightColor2.r, var_170_18)
								local var_170_20 = Mathf.Lerp(iter_170_6.color.g, arg_167_1.hightColor2.g, var_170_18)
								local var_170_21 = Mathf.Lerp(iter_170_6.color.b, arg_167_1.hightColor2.b, var_170_18)

								iter_170_6.color = Color.New(var_170_19, var_170_20, var_170_21)
							else
								local var_170_22 = Mathf.Lerp(iter_170_6.color.r, 0.5, var_170_18)

								iter_170_6.color = Color.New(var_170_22, var_170_22, var_170_22)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_8 then
						if arg_167_1.isInRecall_ then
							iter_170_8.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_23 = 0
			local var_170_24 = 0.675

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_25 = arg_167_1:FormatText(StoryNameCfg[996].name)

				arg_167_1.leftNameTxt_.text = var_170_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(413101040)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 27
				local var_170_29 = utf8.len(var_170_27)
				local var_170_30 = var_170_28 <= 0 and var_170_24 or var_170_24 * (var_170_29 / var_170_28)

				if var_170_30 > 0 and var_170_24 < var_170_30 then
					arg_167_1.talkMaxDuration = var_170_30

					if var_170_30 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_23
					end
				end

				arg_167_1.text_.text = var_170_27
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101040", "story_v_out_413101.awb") ~= 0 then
					local var_170_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101040", "story_v_out_413101.awb") / 1000

					if var_170_31 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_23
					end

					if var_170_26.prefab_name ~= "" and arg_167_1.actors_[var_170_26.prefab_name] ~= nil then
						local var_170_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_26.prefab_name].transform, "story_v_out_413101", "413101040", "story_v_out_413101.awb")

						arg_167_1:RecordAudio("413101040", var_170_32)
						arg_167_1:RecordAudio("413101040", var_170_32)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413101", "413101040", "story_v_out_413101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413101", "413101040", "story_v_out_413101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_33 = math.max(var_170_24, arg_167_1.talkMaxDuration)

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_33 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_23) / var_170_33

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_23 + var_170_33 and arg_167_1.time_ < var_170_23 + var_170_33 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play413101041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413101041
		arg_171_1.duration_ = 6.93

		local var_171_0 = {
			zh = 2.533,
			ja = 6.933
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
				arg_171_0:Play413101042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10092"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 2)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "split_2" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(-389.49, -300, -295)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_174_7 = 0
			local var_174_8 = 0.325

			if var_174_7 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_9 = arg_171_1:FormatText(StoryNameCfg[996].name)

				arg_171_1.leftNameTxt_.text = var_174_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(413101041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_12 = 13
				local var_174_13 = utf8.len(var_174_11)
				local var_174_14 = var_174_12 <= 0 and var_174_8 or var_174_8 * (var_174_13 / var_174_12)

				if var_174_14 > 0 and var_174_8 < var_174_14 then
					arg_171_1.talkMaxDuration = var_174_14

					if var_174_14 + var_174_7 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_7
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101041", "story_v_out_413101.awb") ~= 0 then
					local var_174_15 = manager.audio:GetVoiceLength("story_v_out_413101", "413101041", "story_v_out_413101.awb") / 1000

					if var_174_15 + var_174_7 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_7
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_413101", "413101041", "story_v_out_413101.awb")

						arg_171_1:RecordAudio("413101041", var_174_16)
						arg_171_1:RecordAudio("413101041", var_174_16)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413101", "413101041", "story_v_out_413101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413101", "413101041", "story_v_out_413101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_17 = math.max(var_174_8, arg_171_1.talkMaxDuration)

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_17 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_7) / var_174_17

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_7 + var_174_17 and arg_171_1.time_ < var_174_7 + var_174_17 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play413101042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413101042
		arg_175_1.duration_ = 7.1

		local var_175_0 = {
			zh = 3.466,
			ja = 7.1
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play413101043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10093"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10093 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10093", 4)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "split_4" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(390, -345, -245)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10093, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_178_7 = arg_175_1.actors_["10092"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10092 == nil then
				arg_175_1.var_.actorSpriteComps10092 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 2

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps10092 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor2.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor2.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor2.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 0.5, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps10092 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_178_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10092 = nil
			end

			local var_178_15 = arg_175_1.actors_["10093"]
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.actorSpriteComps10093 == nil then
				arg_175_1.var_.actorSpriteComps10093 = var_178_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_17 = 2

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 and not isNil(var_178_15) then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17

				if arg_175_1.var_.actorSpriteComps10093 then
					for iter_178_5, iter_178_6 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_178_6 then
							if arg_175_1.isInRecall_ then
								local var_178_19 = Mathf.Lerp(iter_178_6.color.r, arg_175_1.hightColor1.r, var_178_18)
								local var_178_20 = Mathf.Lerp(iter_178_6.color.g, arg_175_1.hightColor1.g, var_178_18)
								local var_178_21 = Mathf.Lerp(iter_178_6.color.b, arg_175_1.hightColor1.b, var_178_18)

								iter_178_6.color = Color.New(var_178_19, var_178_20, var_178_21)
							else
								local var_178_22 = Mathf.Lerp(iter_178_6.color.r, 1, var_178_18)

								iter_178_6.color = Color.New(var_178_22, var_178_22, var_178_22)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.actorSpriteComps10093 then
				for iter_178_7, iter_178_8 in pairs(arg_175_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_178_8 then
						if arg_175_1.isInRecall_ then
							iter_178_8.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps10093 = nil
			end

			local var_178_23 = 0
			local var_178_24 = 0.5

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_25 = arg_175_1:FormatText(StoryNameCfg[28].name)

				arg_175_1.leftNameTxt_.text = var_178_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_26 = arg_175_1:GetWordFromCfg(413101042)
				local var_178_27 = arg_175_1:FormatText(var_178_26.content)

				arg_175_1.text_.text = var_178_27

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_28 = 20
				local var_178_29 = utf8.len(var_178_27)
				local var_178_30 = var_178_28 <= 0 and var_178_24 or var_178_24 * (var_178_29 / var_178_28)

				if var_178_30 > 0 and var_178_24 < var_178_30 then
					arg_175_1.talkMaxDuration = var_178_30

					if var_178_30 + var_178_23 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_30 + var_178_23
					end
				end

				arg_175_1.text_.text = var_178_27
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101042", "story_v_out_413101.awb") ~= 0 then
					local var_178_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101042", "story_v_out_413101.awb") / 1000

					if var_178_31 + var_178_23 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_31 + var_178_23
					end

					if var_178_26.prefab_name ~= "" and arg_175_1.actors_[var_178_26.prefab_name] ~= nil then
						local var_178_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_26.prefab_name].transform, "story_v_out_413101", "413101042", "story_v_out_413101.awb")

						arg_175_1:RecordAudio("413101042", var_178_32)
						arg_175_1:RecordAudio("413101042", var_178_32)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413101", "413101042", "story_v_out_413101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413101", "413101042", "story_v_out_413101.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_33 = math.max(var_178_24, arg_175_1.talkMaxDuration)

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_33 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_23) / var_178_33

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_23 + var_178_33 and arg_175_1.time_ < var_178_23 + var_178_33 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play413101043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413101043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413101044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10092"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10092 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10092", 6)

				local var_182_2 = var_182_0.childCount

				for iter_182_0 = 0, var_182_2 - 1 do
					local var_182_3 = var_182_0:GetChild(iter_182_0)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_4 then
				local var_182_5 = (arg_179_1.time_ - var_182_1) / var_182_4
				local var_182_6 = Vector3.New(1500, -300, -295)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10092, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_182_7 = arg_179_1.actors_["10093"].transform
			local var_182_8 = 0

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.var_.moveOldPos10093 = var_182_7.localPosition
				var_182_7.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10093", 6)

				local var_182_9 = var_182_7.childCount

				for iter_182_1 = 0, var_182_9 - 1 do
					local var_182_10 = var_182_7:GetChild(iter_182_1)

					if var_182_10.name == "" or not string.find(var_182_10.name, "split") then
						var_182_10.gameObject:SetActive(true)
					else
						var_182_10.gameObject:SetActive(false)
					end
				end
			end

			local var_182_11 = 0.001

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_11 then
				local var_182_12 = (arg_179_1.time_ - var_182_8) / var_182_11
				local var_182_13 = Vector3.New(1500, -345, -245)

				var_182_7.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10093, var_182_13, var_182_12)
			end

			if arg_179_1.time_ >= var_182_8 + var_182_11 and arg_179_1.time_ < var_182_8 + var_182_11 + arg_182_0 then
				var_182_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_182_14 = arg_179_1.actors_["10092"]
			local var_182_15 = 0

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.actorSpriteComps10092 == nil then
				arg_179_1.var_.actorSpriteComps10092 = var_182_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_16 = 2

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_16 and not isNil(var_182_14) then
				local var_182_17 = (arg_179_1.time_ - var_182_15) / var_182_16

				if arg_179_1.var_.actorSpriteComps10092 then
					for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_182_3 then
							if arg_179_1.isInRecall_ then
								local var_182_18 = Mathf.Lerp(iter_182_3.color.r, arg_179_1.hightColor2.r, var_182_17)
								local var_182_19 = Mathf.Lerp(iter_182_3.color.g, arg_179_1.hightColor2.g, var_182_17)
								local var_182_20 = Mathf.Lerp(iter_182_3.color.b, arg_179_1.hightColor2.b, var_182_17)

								iter_182_3.color = Color.New(var_182_18, var_182_19, var_182_20)
							else
								local var_182_21 = Mathf.Lerp(iter_182_3.color.r, 0.5, var_182_17)

								iter_182_3.color = Color.New(var_182_21, var_182_21, var_182_21)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_15 + var_182_16 and arg_179_1.time_ < var_182_15 + var_182_16 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.actorSpriteComps10092 then
				for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_182_5 then
						if arg_179_1.isInRecall_ then
							iter_182_5.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10092 = nil
			end

			local var_182_22 = arg_179_1.actors_["10093"]
			local var_182_23 = 0

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.actorSpriteComps10093 == nil then
				arg_179_1.var_.actorSpriteComps10093 = var_182_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_24 = 2

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_24 and not isNil(var_182_22) then
				local var_182_25 = (arg_179_1.time_ - var_182_23) / var_182_24

				if arg_179_1.var_.actorSpriteComps10093 then
					for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_182_7 then
							if arg_179_1.isInRecall_ then
								local var_182_26 = Mathf.Lerp(iter_182_7.color.r, arg_179_1.hightColor2.r, var_182_25)
								local var_182_27 = Mathf.Lerp(iter_182_7.color.g, arg_179_1.hightColor2.g, var_182_25)
								local var_182_28 = Mathf.Lerp(iter_182_7.color.b, arg_179_1.hightColor2.b, var_182_25)

								iter_182_7.color = Color.New(var_182_26, var_182_27, var_182_28)
							else
								local var_182_29 = Mathf.Lerp(iter_182_7.color.r, 0.5, var_182_25)

								iter_182_7.color = Color.New(var_182_29, var_182_29, var_182_29)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_23 + var_182_24 and arg_179_1.time_ < var_182_23 + var_182_24 + arg_182_0 and not isNil(var_182_22) and arg_179_1.var_.actorSpriteComps10093 then
				for iter_182_8, iter_182_9 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_182_9 then
						if arg_179_1.isInRecall_ then
							iter_182_9.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10093 = nil
			end

			local var_182_30 = 0
			local var_182_31 = 1.1

			if var_182_30 < arg_179_1.time_ and arg_179_1.time_ <= var_182_30 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_32 = arg_179_1:GetWordFromCfg(413101043)
				local var_182_33 = arg_179_1:FormatText(var_182_32.content)

				arg_179_1.text_.text = var_182_33

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_34 = 44
				local var_182_35 = utf8.len(var_182_33)
				local var_182_36 = var_182_34 <= 0 and var_182_31 or var_182_31 * (var_182_35 / var_182_34)

				if var_182_36 > 0 and var_182_31 < var_182_36 then
					arg_179_1.talkMaxDuration = var_182_36

					if var_182_36 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_36 + var_182_30
					end
				end

				arg_179_1.text_.text = var_182_33
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_37 = math.max(var_182_31, arg_179_1.talkMaxDuration)

			if var_182_30 <= arg_179_1.time_ and arg_179_1.time_ < var_182_30 + var_182_37 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_30) / var_182_37

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_30 + var_182_37 and arg_179_1.time_ < var_182_30 + var_182_37 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play413101044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413101044
		arg_183_1.duration_ = 6.33

		local var_183_0 = {
			zh = 3.733,
			ja = 6.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play413101045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10092"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10092 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10092", 3)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(0, -300, -295)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10092, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_186_7 = arg_183_1.actors_["10093"].transform
			local var_186_8 = 0

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.var_.moveOldPos10093 = var_186_7.localPosition
				var_186_7.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10093", 7)

				local var_186_9 = var_186_7.childCount

				for iter_186_1 = 0, var_186_9 - 1 do
					local var_186_10 = var_186_7:GetChild(iter_186_1)

					if var_186_10.name == "" or not string.find(var_186_10.name, "split") then
						var_186_10.gameObject:SetActive(true)
					else
						var_186_10.gameObject:SetActive(false)
					end
				end
			end

			local var_186_11 = 0.001

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_11 then
				local var_186_12 = (arg_183_1.time_ - var_186_8) / var_186_11
				local var_186_13 = Vector3.New(0, -2000, 0)

				var_186_7.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10093, var_186_13, var_186_12)
			end

			if arg_183_1.time_ >= var_186_8 + var_186_11 and arg_183_1.time_ < var_186_8 + var_186_11 + arg_186_0 then
				var_186_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_14 = arg_183_1.actors_["10092"]
			local var_186_15 = 0

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.actorSpriteComps10092 == nil then
				arg_183_1.var_.actorSpriteComps10092 = var_186_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_16 = 2

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_16 and not isNil(var_186_14) then
				local var_186_17 = (arg_183_1.time_ - var_186_15) / var_186_16

				if arg_183_1.var_.actorSpriteComps10092 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								local var_186_18 = Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, var_186_17)
								local var_186_19 = Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, var_186_17)
								local var_186_20 = Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, var_186_17)

								iter_186_3.color = Color.New(var_186_18, var_186_19, var_186_20)
							else
								local var_186_21 = Mathf.Lerp(iter_186_3.color.r, 1, var_186_17)

								iter_186_3.color = Color.New(var_186_21, var_186_21, var_186_21)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_15 + var_186_16 and arg_183_1.time_ < var_186_15 + var_186_16 + arg_186_0 and not isNil(var_186_14) and arg_183_1.var_.actorSpriteComps10092 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_186_5 then
						if arg_183_1.isInRecall_ then
							iter_186_5.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10092 = nil
			end

			local var_186_22 = arg_183_1.actors_["10093"]
			local var_186_23 = 0

			if var_186_23 < arg_183_1.time_ and arg_183_1.time_ <= var_186_23 + arg_186_0 and not isNil(var_186_22) and arg_183_1.var_.actorSpriteComps10093 == nil then
				arg_183_1.var_.actorSpriteComps10093 = var_186_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_24 = 2

			if var_186_23 <= arg_183_1.time_ and arg_183_1.time_ < var_186_23 + var_186_24 and not isNil(var_186_22) then
				local var_186_25 = (arg_183_1.time_ - var_186_23) / var_186_24

				if arg_183_1.var_.actorSpriteComps10093 then
					for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_186_7 then
							if arg_183_1.isInRecall_ then
								local var_186_26 = Mathf.Lerp(iter_186_7.color.r, arg_183_1.hightColor2.r, var_186_25)
								local var_186_27 = Mathf.Lerp(iter_186_7.color.g, arg_183_1.hightColor2.g, var_186_25)
								local var_186_28 = Mathf.Lerp(iter_186_7.color.b, arg_183_1.hightColor2.b, var_186_25)

								iter_186_7.color = Color.New(var_186_26, var_186_27, var_186_28)
							else
								local var_186_29 = Mathf.Lerp(iter_186_7.color.r, 0.5, var_186_25)

								iter_186_7.color = Color.New(var_186_29, var_186_29, var_186_29)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_23 + var_186_24 and arg_183_1.time_ < var_186_23 + var_186_24 + arg_186_0 and not isNil(var_186_22) and arg_183_1.var_.actorSpriteComps10093 then
				for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_186_9 then
						if arg_183_1.isInRecall_ then
							iter_186_9.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10093 = nil
			end

			local var_186_30 = 0
			local var_186_31 = 0.475

			if var_186_30 < arg_183_1.time_ and arg_183_1.time_ <= var_186_30 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_32 = arg_183_1:FormatText(StoryNameCfg[996].name)

				arg_183_1.leftNameTxt_.text = var_186_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_33 = arg_183_1:GetWordFromCfg(413101044)
				local var_186_34 = arg_183_1:FormatText(var_186_33.content)

				arg_183_1.text_.text = var_186_34

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_35 = 19
				local var_186_36 = utf8.len(var_186_34)
				local var_186_37 = var_186_35 <= 0 and var_186_31 or var_186_31 * (var_186_36 / var_186_35)

				if var_186_37 > 0 and var_186_31 < var_186_37 then
					arg_183_1.talkMaxDuration = var_186_37

					if var_186_37 + var_186_30 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_37 + var_186_30
					end
				end

				arg_183_1.text_.text = var_186_34
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101044", "story_v_out_413101.awb") ~= 0 then
					local var_186_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101044", "story_v_out_413101.awb") / 1000

					if var_186_38 + var_186_30 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_38 + var_186_30
					end

					if var_186_33.prefab_name ~= "" and arg_183_1.actors_[var_186_33.prefab_name] ~= nil then
						local var_186_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_33.prefab_name].transform, "story_v_out_413101", "413101044", "story_v_out_413101.awb")

						arg_183_1:RecordAudio("413101044", var_186_39)
						arg_183_1:RecordAudio("413101044", var_186_39)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_413101", "413101044", "story_v_out_413101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_413101", "413101044", "story_v_out_413101.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_40 = math.max(var_186_31, arg_183_1.talkMaxDuration)

			if var_186_30 <= arg_183_1.time_ and arg_183_1.time_ < var_186_30 + var_186_40 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_30) / var_186_40

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_30 + var_186_40 and arg_183_1.time_ < var_186_30 + var_186_40 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play413101045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413101045
		arg_187_1.duration_ = 7.23

		local var_187_0 = {
			zh = 7.133,
			ja = 7.233
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413101046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.075

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[996].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(413101045)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 43
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101045", "story_v_out_413101.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101045", "story_v_out_413101.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_413101", "413101045", "story_v_out_413101.awb")

						arg_187_1:RecordAudio("413101045", var_190_9)
						arg_187_1:RecordAudio("413101045", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413101", "413101045", "story_v_out_413101.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413101", "413101045", "story_v_out_413101.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play413101046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413101046
		arg_191_1.duration_ = 5.53

		local var_191_0 = {
			zh = 3.033,
			ja = 5.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413101047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10092"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10092 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10092", 3)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "split_2" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(0, -300, -295)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10092, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_194_7 = arg_191_1.actors_["10092"]
			local var_194_8 = 0

			if var_194_8 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10092 == nil then
				arg_191_1.var_.actorSpriteComps10092 = var_194_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 and not isNil(var_194_7) then
				local var_194_10 = (arg_191_1.time_ - var_194_8) / var_194_9

				if arg_191_1.var_.actorSpriteComps10092 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								local var_194_11 = Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, var_194_10)
								local var_194_12 = Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, var_194_10)
								local var_194_13 = Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, var_194_10)

								iter_194_2.color = Color.New(var_194_11, var_194_12, var_194_13)
							else
								local var_194_14 = Mathf.Lerp(iter_194_2.color.r, 1, var_194_10)

								iter_194_2.color = Color.New(var_194_14, var_194_14, var_194_14)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10092 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_194_4 then
						if arg_191_1.isInRecall_ then
							iter_194_4.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10092 = nil
			end

			local var_194_15 = 0
			local var_194_16 = 0.375

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[996].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(413101046)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 15
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101046", "story_v_out_413101.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101046", "story_v_out_413101.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_413101", "413101046", "story_v_out_413101.awb")

						arg_191_1:RecordAudio("413101046", var_194_24)
						arg_191_1:RecordAudio("413101046", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_413101", "413101046", "story_v_out_413101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_413101", "413101046", "story_v_out_413101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play413101047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413101047
		arg_195_1.duration_ = 5.17

		local var_195_0 = {
			zh = 5.166,
			ja = 4.3
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play413101048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10093"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10093 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10093", 4)

				local var_198_2 = var_198_0.childCount

				for iter_198_0 = 0, var_198_2 - 1 do
					local var_198_3 = var_198_0:GetChild(iter_198_0)

					if var_198_3.name == "split_4" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_4 then
				local var_198_5 = (arg_195_1.time_ - var_198_1) / var_198_4
				local var_198_6 = Vector3.New(390, -345, -245)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10093, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_198_7 = arg_195_1.actors_["10092"]
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.actorSpriteComps10092 == nil then
				arg_195_1.var_.actorSpriteComps10092 = var_198_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_9 = 2

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_9 and not isNil(var_198_7) then
				local var_198_10 = (arg_195_1.time_ - var_198_8) / var_198_9

				if arg_195_1.var_.actorSpriteComps10092 then
					for iter_198_1, iter_198_2 in pairs(arg_195_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_198_2 then
							if arg_195_1.isInRecall_ then
								local var_198_11 = Mathf.Lerp(iter_198_2.color.r, arg_195_1.hightColor2.r, var_198_10)
								local var_198_12 = Mathf.Lerp(iter_198_2.color.g, arg_195_1.hightColor2.g, var_198_10)
								local var_198_13 = Mathf.Lerp(iter_198_2.color.b, arg_195_1.hightColor2.b, var_198_10)

								iter_198_2.color = Color.New(var_198_11, var_198_12, var_198_13)
							else
								local var_198_14 = Mathf.Lerp(iter_198_2.color.r, 0.5, var_198_10)

								iter_198_2.color = Color.New(var_198_14, var_198_14, var_198_14)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_8 + var_198_9 and arg_195_1.time_ < var_198_8 + var_198_9 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.actorSpriteComps10092 then
				for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_198_4 then
						if arg_195_1.isInRecall_ then
							iter_198_4.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10092 = nil
			end

			local var_198_15 = arg_195_1.actors_["10093"]
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.actorSpriteComps10093 == nil then
				arg_195_1.var_.actorSpriteComps10093 = var_198_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_17 = 2

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 and not isNil(var_198_15) then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17

				if arg_195_1.var_.actorSpriteComps10093 then
					for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_198_6 then
							if arg_195_1.isInRecall_ then
								local var_198_19 = Mathf.Lerp(iter_198_6.color.r, arg_195_1.hightColor1.r, var_198_18)
								local var_198_20 = Mathf.Lerp(iter_198_6.color.g, arg_195_1.hightColor1.g, var_198_18)
								local var_198_21 = Mathf.Lerp(iter_198_6.color.b, arg_195_1.hightColor1.b, var_198_18)

								iter_198_6.color = Color.New(var_198_19, var_198_20, var_198_21)
							else
								local var_198_22 = Mathf.Lerp(iter_198_6.color.r, 1, var_198_18)

								iter_198_6.color = Color.New(var_198_22, var_198_22, var_198_22)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 and not isNil(var_198_15) and arg_195_1.var_.actorSpriteComps10093 then
				for iter_198_7, iter_198_8 in pairs(arg_195_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_198_8 then
						if arg_195_1.isInRecall_ then
							iter_198_8.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10093 = nil
			end

			local var_198_23 = arg_195_1.actors_["10092"].transform
			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1.var_.moveOldPos10092 = var_198_23.localPosition
				var_198_23.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10092", 2)

				local var_198_25 = var_198_23.childCount

				for iter_198_9 = 0, var_198_25 - 1 do
					local var_198_26 = var_198_23:GetChild(iter_198_9)

					if var_198_26.name == "split_2" or not string.find(var_198_26.name, "split") then
						var_198_26.gameObject:SetActive(true)
					else
						var_198_26.gameObject:SetActive(false)
					end
				end
			end

			local var_198_27 = 0.001

			if var_198_24 <= arg_195_1.time_ and arg_195_1.time_ < var_198_24 + var_198_27 then
				local var_198_28 = (arg_195_1.time_ - var_198_24) / var_198_27
				local var_198_29 = Vector3.New(-389.49, -300, -295)

				var_198_23.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10092, var_198_29, var_198_28)
			end

			if arg_195_1.time_ >= var_198_24 + var_198_27 and arg_195_1.time_ < var_198_24 + var_198_27 + arg_198_0 then
				var_198_23.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_198_30 = 0
			local var_198_31 = 0.475

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_32 = arg_195_1:FormatText(StoryNameCfg[28].name)

				arg_195_1.leftNameTxt_.text = var_198_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_33 = arg_195_1:GetWordFromCfg(413101047)
				local var_198_34 = arg_195_1:FormatText(var_198_33.content)

				arg_195_1.text_.text = var_198_34

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_35 = 19
				local var_198_36 = utf8.len(var_198_34)
				local var_198_37 = var_198_35 <= 0 and var_198_31 or var_198_31 * (var_198_36 / var_198_35)

				if var_198_37 > 0 and var_198_31 < var_198_37 then
					arg_195_1.talkMaxDuration = var_198_37

					if var_198_37 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_37 + var_198_30
					end
				end

				arg_195_1.text_.text = var_198_34
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101047", "story_v_out_413101.awb") ~= 0 then
					local var_198_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101047", "story_v_out_413101.awb") / 1000

					if var_198_38 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_38 + var_198_30
					end

					if var_198_33.prefab_name ~= "" and arg_195_1.actors_[var_198_33.prefab_name] ~= nil then
						local var_198_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_33.prefab_name].transform, "story_v_out_413101", "413101047", "story_v_out_413101.awb")

						arg_195_1:RecordAudio("413101047", var_198_39)
						arg_195_1:RecordAudio("413101047", var_198_39)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413101", "413101047", "story_v_out_413101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413101", "413101047", "story_v_out_413101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_40 = math.max(var_198_31, arg_195_1.talkMaxDuration)

			if var_198_30 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_40 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_40

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_40 and arg_195_1.time_ < var_198_30 + var_198_40 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play413101048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413101048
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			zh = 4.96633333333333,
			ja = 5.73333333333333
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
				arg_199_0:Play413101049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10022"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10022 = var_202_0.localPosition
				var_202_0.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10022", 2)

				local var_202_2 = var_202_0.childCount

				for iter_202_0 = 0, var_202_2 - 1 do
					local var_202_3 = var_202_0:GetChild(iter_202_0)

					if var_202_3.name == "split_8" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_4 then
				local var_202_5 = (arg_199_1.time_ - var_202_1) / var_202_4
				local var_202_6 = Vector3.New(-390, -315, -320)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10022, var_202_6, var_202_5)
			end

			if arg_199_1.time_ >= var_202_1 + var_202_4 and arg_199_1.time_ < var_202_1 + var_202_4 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_202_7 = arg_199_1.actors_["10022"]
			local var_202_8 = 0

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps10022 == nil then
				arg_199_1.var_.actorSpriteComps10022 = var_202_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_9 = 2

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 and not isNil(var_202_7) then
				local var_202_10 = (arg_199_1.time_ - var_202_8) / var_202_9

				if arg_199_1.var_.actorSpriteComps10022 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								local var_202_11 = Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, var_202_10)
								local var_202_12 = Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, var_202_10)
								local var_202_13 = Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, var_202_10)

								iter_202_2.color = Color.New(var_202_11, var_202_12, var_202_13)
							else
								local var_202_14 = Mathf.Lerp(iter_202_2.color.r, 1, var_202_10)

								iter_202_2.color = Color.New(var_202_14, var_202_14, var_202_14)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps10022 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_202_4 then
						if arg_199_1.isInRecall_ then
							iter_202_4.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10022 = nil
			end

			local var_202_15 = arg_199_1.actors_["10093"]
			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.actorSpriteComps10093 == nil then
				arg_199_1.var_.actorSpriteComps10093 = var_202_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_17 = 2

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 and not isNil(var_202_15) then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17

				if arg_199_1.var_.actorSpriteComps10093 then
					for iter_202_5, iter_202_6 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_202_6 then
							if arg_199_1.isInRecall_ then
								local var_202_19 = Mathf.Lerp(iter_202_6.color.r, arg_199_1.hightColor2.r, var_202_18)
								local var_202_20 = Mathf.Lerp(iter_202_6.color.g, arg_199_1.hightColor2.g, var_202_18)
								local var_202_21 = Mathf.Lerp(iter_202_6.color.b, arg_199_1.hightColor2.b, var_202_18)

								iter_202_6.color = Color.New(var_202_19, var_202_20, var_202_21)
							else
								local var_202_22 = Mathf.Lerp(iter_202_6.color.r, 0.5, var_202_18)

								iter_202_6.color = Color.New(var_202_22, var_202_22, var_202_22)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.actorSpriteComps10093 then
				for iter_202_7, iter_202_8 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_202_8 then
						if arg_199_1.isInRecall_ then
							iter_202_8.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps10093 = nil
			end

			local var_202_23 = arg_199_1.actors_["10022"]
			local var_202_24 = 0

			if var_202_24 < arg_199_1.time_ and arg_199_1.time_ <= var_202_24 + arg_202_0 then
				local var_202_25 = var_202_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_202_25 then
					arg_199_1.var_.alphaOldValue10022 = var_202_25.alpha
					arg_199_1.var_.characterEffect10022 = var_202_25
				end

				arg_199_1.var_.alphaOldValue10022 = 0
			end

			local var_202_26 = 0.2

			if var_202_24 <= arg_199_1.time_ and arg_199_1.time_ < var_202_24 + var_202_26 then
				local var_202_27 = (arg_199_1.time_ - var_202_24) / var_202_26
				local var_202_28 = Mathf.Lerp(arg_199_1.var_.alphaOldValue10022, 1, var_202_27)

				if arg_199_1.var_.characterEffect10022 then
					arg_199_1.var_.characterEffect10022.alpha = var_202_28
				end
			end

			if arg_199_1.time_ >= var_202_24 + var_202_26 and arg_199_1.time_ < var_202_24 + var_202_26 + arg_202_0 and arg_199_1.var_.characterEffect10022 then
				arg_199_1.var_.characterEffect10022.alpha = 1
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_29 = 0.433333333333333
			local var_202_30 = 0.725

			if var_202_29 < arg_199_1.time_ and arg_199_1.time_ <= var_202_29 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_31 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_31:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_32 = arg_199_1:FormatText(StoryNameCfg[614].name)

				arg_199_1.leftNameTxt_.text = var_202_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_33 = arg_199_1:GetWordFromCfg(413101048)
				local var_202_34 = arg_199_1:FormatText(var_202_33.content)

				arg_199_1.text_.text = var_202_34

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_35 = 27
				local var_202_36 = utf8.len(var_202_34)
				local var_202_37 = var_202_35 <= 0 and var_202_30 or var_202_30 * (var_202_36 / var_202_35)

				if var_202_37 > 0 and var_202_30 < var_202_37 then
					arg_199_1.talkMaxDuration = var_202_37
					var_202_29 = var_202_29 + 0.3

					if var_202_37 + var_202_29 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_37 + var_202_29
					end
				end

				arg_199_1.text_.text = var_202_34
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101048", "story_v_out_413101.awb") ~= 0 then
					local var_202_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101048", "story_v_out_413101.awb") / 1000

					if var_202_38 + var_202_29 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_38 + var_202_29
					end

					if var_202_33.prefab_name ~= "" and arg_199_1.actors_[var_202_33.prefab_name] ~= nil then
						local var_202_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_33.prefab_name].transform, "story_v_out_413101", "413101048", "story_v_out_413101.awb")

						arg_199_1:RecordAudio("413101048", var_202_39)
						arg_199_1:RecordAudio("413101048", var_202_39)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413101", "413101048", "story_v_out_413101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413101", "413101048", "story_v_out_413101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_40 = var_202_29 + 0.3
			local var_202_41 = math.max(var_202_30, arg_199_1.talkMaxDuration)

			if var_202_40 <= arg_199_1.time_ and arg_199_1.time_ < var_202_40 + var_202_41 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_40) / var_202_41

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_40 + var_202_41 and arg_199_1.time_ < var_202_40 + var_202_41 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play413101049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413101049
		arg_205_1.duration_ = 6.6

		local var_205_0 = {
			zh = 5.9,
			ja = 6.6
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
				arg_205_0:Play413101050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.725

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[614].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(413101049)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 29
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101049", "story_v_out_413101.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101049", "story_v_out_413101.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_413101", "413101049", "story_v_out_413101.awb")

						arg_205_1:RecordAudio("413101049", var_208_9)
						arg_205_1:RecordAudio("413101049", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413101", "413101049", "story_v_out_413101.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413101", "413101049", "story_v_out_413101.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413101050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413101050
		arg_209_1.duration_ = 4.7

		local var_209_0 = {
			zh = 4.7,
			ja = 2.466
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
				arg_209_0:Play413101051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10022"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10022 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10022", 2)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(-390, -315, -320)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10022, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_212_7 = arg_209_1.actors_["10093"].transform
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = var_212_7.localPosition
				var_212_7.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 4)

				local var_212_9 = var_212_7.childCount

				for iter_212_1 = 0, var_212_9 - 1 do
					local var_212_10 = var_212_7:GetChild(iter_212_1)

					if var_212_10.name == "split_5" or not string.find(var_212_10.name, "split") then
						var_212_10.gameObject:SetActive(true)
					else
						var_212_10.gameObject:SetActive(false)
					end
				end
			end

			local var_212_11 = 0.001

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_8) / var_212_11
				local var_212_13 = Vector3.New(390, -345, -245)

				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, var_212_13, var_212_12)
			end

			if arg_209_1.time_ >= var_212_8 + var_212_11 and arg_209_1.time_ < var_212_8 + var_212_11 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_212_14 = arg_209_1.actors_["10022"]
			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.actorSpriteComps10022 == nil then
				arg_209_1.var_.actorSpriteComps10022 = var_212_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_16 = 2

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_16 and not isNil(var_212_14) then
				local var_212_17 = (arg_209_1.time_ - var_212_15) / var_212_16

				if arg_209_1.var_.actorSpriteComps10022 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								local var_212_18 = Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor2.r, var_212_17)
								local var_212_19 = Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor2.g, var_212_17)
								local var_212_20 = Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor2.b, var_212_17)

								iter_212_3.color = Color.New(var_212_18, var_212_19, var_212_20)
							else
								local var_212_21 = Mathf.Lerp(iter_212_3.color.r, 0.5, var_212_17)

								iter_212_3.color = Color.New(var_212_21, var_212_21, var_212_21)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_15 + var_212_16 and arg_209_1.time_ < var_212_15 + var_212_16 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.actorSpriteComps10022 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_212_5 then
						if arg_209_1.isInRecall_ then
							iter_212_5.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10022 = nil
			end

			local var_212_22 = arg_209_1.actors_["10093"]
			local var_212_23 = 0

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.actorSpriteComps10093 == nil then
				arg_209_1.var_.actorSpriteComps10093 = var_212_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_24 = 2

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 and not isNil(var_212_22) then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24

				if arg_209_1.var_.actorSpriteComps10093 then
					for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_212_7 then
							if arg_209_1.isInRecall_ then
								local var_212_26 = Mathf.Lerp(iter_212_7.color.r, arg_209_1.hightColor1.r, var_212_25)
								local var_212_27 = Mathf.Lerp(iter_212_7.color.g, arg_209_1.hightColor1.g, var_212_25)
								local var_212_28 = Mathf.Lerp(iter_212_7.color.b, arg_209_1.hightColor1.b, var_212_25)

								iter_212_7.color = Color.New(var_212_26, var_212_27, var_212_28)
							else
								local var_212_29 = Mathf.Lerp(iter_212_7.color.r, 1, var_212_25)

								iter_212_7.color = Color.New(var_212_29, var_212_29, var_212_29)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.actorSpriteComps10093 then
				for iter_212_8, iter_212_9 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_212_9 then
						if arg_209_1.isInRecall_ then
							iter_212_9.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10093 = nil
			end

			local var_212_30 = 0
			local var_212_31 = 0.325

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_32 = arg_209_1:FormatText(StoryNameCfg[28].name)

				arg_209_1.leftNameTxt_.text = var_212_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_33 = arg_209_1:GetWordFromCfg(413101050)
				local var_212_34 = arg_209_1:FormatText(var_212_33.content)

				arg_209_1.text_.text = var_212_34

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_35 = 12
				local var_212_36 = utf8.len(var_212_34)
				local var_212_37 = var_212_35 <= 0 and var_212_31 or var_212_31 * (var_212_36 / var_212_35)

				if var_212_37 > 0 and var_212_31 < var_212_37 then
					arg_209_1.talkMaxDuration = var_212_37

					if var_212_37 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_37 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_34
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101050", "story_v_out_413101.awb") ~= 0 then
					local var_212_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101050", "story_v_out_413101.awb") / 1000

					if var_212_38 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_30
					end

					if var_212_33.prefab_name ~= "" and arg_209_1.actors_[var_212_33.prefab_name] ~= nil then
						local var_212_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_33.prefab_name].transform, "story_v_out_413101", "413101050", "story_v_out_413101.awb")

						arg_209_1:RecordAudio("413101050", var_212_39)
						arg_209_1:RecordAudio("413101050", var_212_39)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413101", "413101050", "story_v_out_413101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413101", "413101050", "story_v_out_413101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_40 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_40 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_40

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_40 and arg_209_1.time_ < var_212_30 + var_212_40 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play413101051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413101051
		arg_213_1.duration_ = 7.6

		local var_213_0 = {
			zh = 7.6,
			ja = 4.566
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
				arg_213_0:Play413101052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10022"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10022 == nil then
				arg_213_1.var_.actorSpriteComps10022 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10022 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 1, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10022 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10022 = nil
			end

			local var_216_8 = arg_213_1.actors_["10093"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_12 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, var_216_11)
								local var_216_13 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, var_216_11)
								local var_216_14 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, var_216_11)

								iter_216_5.color = Color.New(var_216_12, var_216_13, var_216_14)
							else
								local var_216_15 = Mathf.Lerp(iter_216_5.color.r, 0.5, var_216_11)

								iter_216_5.color = Color.New(var_216_15, var_216_15, var_216_15)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_16 = 0
			local var_216_17 = 1.025

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_18 = arg_213_1:FormatText(StoryNameCfg[614].name)

				arg_213_1.leftNameTxt_.text = var_216_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_19 = arg_213_1:GetWordFromCfg(413101051)
				local var_216_20 = arg_213_1:FormatText(var_216_19.content)

				arg_213_1.text_.text = var_216_20

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_21 = 41
				local var_216_22 = utf8.len(var_216_20)
				local var_216_23 = var_216_21 <= 0 and var_216_17 or var_216_17 * (var_216_22 / var_216_21)

				if var_216_23 > 0 and var_216_17 < var_216_23 then
					arg_213_1.talkMaxDuration = var_216_23

					if var_216_23 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_16
					end
				end

				arg_213_1.text_.text = var_216_20
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101051", "story_v_out_413101.awb") ~= 0 then
					local var_216_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101051", "story_v_out_413101.awb") / 1000

					if var_216_24 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_24 + var_216_16
					end

					if var_216_19.prefab_name ~= "" and arg_213_1.actors_[var_216_19.prefab_name] ~= nil then
						local var_216_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_19.prefab_name].transform, "story_v_out_413101", "413101051", "story_v_out_413101.awb")

						arg_213_1:RecordAudio("413101051", var_216_25)
						arg_213_1:RecordAudio("413101051", var_216_25)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413101", "413101051", "story_v_out_413101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413101", "413101051", "story_v_out_413101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_26 = math.max(var_216_17, arg_213_1.talkMaxDuration)

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_26 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_16) / var_216_26

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_16 + var_216_26 and arg_213_1.time_ < var_216_16 + var_216_26 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413101052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413101052
		arg_217_1.duration_ = 12.3

		local var_217_0 = {
			zh = 12.3,
			ja = 3.3
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
				arg_217_0:Play413101053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10022"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10022 == nil then
				arg_217_1.var_.actorSpriteComps10022 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10022 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 1, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10022 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10022 = nil
			end

			local var_220_8 = arg_217_1.actors_["10093"]
			local var_220_9 = 0

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps10093 == nil then
				arg_217_1.var_.actorSpriteComps10093 = var_220_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_10 = 2

			if var_220_9 <= arg_217_1.time_ and arg_217_1.time_ < var_220_9 + var_220_10 and not isNil(var_220_8) then
				local var_220_11 = (arg_217_1.time_ - var_220_9) / var_220_10

				if arg_217_1.var_.actorSpriteComps10093 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_220_5 then
							if arg_217_1.isInRecall_ then
								local var_220_12 = Mathf.Lerp(iter_220_5.color.r, arg_217_1.hightColor2.r, var_220_11)
								local var_220_13 = Mathf.Lerp(iter_220_5.color.g, arg_217_1.hightColor2.g, var_220_11)
								local var_220_14 = Mathf.Lerp(iter_220_5.color.b, arg_217_1.hightColor2.b, var_220_11)

								iter_220_5.color = Color.New(var_220_12, var_220_13, var_220_14)
							else
								local var_220_15 = Mathf.Lerp(iter_220_5.color.r, 0.5, var_220_11)

								iter_220_5.color = Color.New(var_220_15, var_220_15, var_220_15)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_9 + var_220_10 and arg_217_1.time_ < var_220_9 + var_220_10 + arg_220_0 and not isNil(var_220_8) and arg_217_1.var_.actorSpriteComps10093 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_220_7 then
						if arg_217_1.isInRecall_ then
							iter_220_7.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10093 = nil
			end

			local var_220_16 = 0
			local var_220_17 = 1.625

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_18 = arg_217_1:FormatText(StoryNameCfg[614].name)

				arg_217_1.leftNameTxt_.text = var_220_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_19 = arg_217_1:GetWordFromCfg(413101052)
				local var_220_20 = arg_217_1:FormatText(var_220_19.content)

				arg_217_1.text_.text = var_220_20

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_21 = 65
				local var_220_22 = utf8.len(var_220_20)
				local var_220_23 = var_220_21 <= 0 and var_220_17 or var_220_17 * (var_220_22 / var_220_21)

				if var_220_23 > 0 and var_220_17 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23

					if var_220_23 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_16
					end
				end

				arg_217_1.text_.text = var_220_20
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101052", "story_v_out_413101.awb") ~= 0 then
					local var_220_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101052", "story_v_out_413101.awb") / 1000

					if var_220_24 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_16
					end

					if var_220_19.prefab_name ~= "" and arg_217_1.actors_[var_220_19.prefab_name] ~= nil then
						local var_220_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_19.prefab_name].transform, "story_v_out_413101", "413101052", "story_v_out_413101.awb")

						arg_217_1:RecordAudio("413101052", var_220_25)
						arg_217_1:RecordAudio("413101052", var_220_25)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413101", "413101052", "story_v_out_413101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413101", "413101052", "story_v_out_413101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_26 = math.max(var_220_17, arg_217_1.talkMaxDuration)

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_26 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_16) / var_220_26

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_16 + var_220_26 and arg_217_1.time_ < var_220_16 + var_220_26 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413101053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413101053
		arg_221_1.duration_ = 8.67

		local var_221_0 = {
			zh = 6.366,
			ja = 8.666
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
				arg_221_0:Play413101054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10093"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10093 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10093", 4)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_4" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(390, -345, -245)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10093, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_224_7 = arg_221_1.actors_["10022"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10022 == nil then
				arg_221_1.var_.actorSpriteComps10022 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10022 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor2.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor2.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor2.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 0.5, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10022 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10022 = nil
			end

			local var_224_15 = arg_221_1.actors_["10093"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 2

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_19 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, var_224_18)
								local var_224_20 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, var_224_18)
								local var_224_21 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, var_224_18)

								iter_224_6.color = Color.New(var_224_19, var_224_20, var_224_21)
							else
								local var_224_22 = Mathf.Lerp(iter_224_6.color.r, 1, var_224_18)

								iter_224_6.color = Color.New(var_224_22, var_224_22, var_224_22)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.85

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[28].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(413101053)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 34
				local var_224_29 = utf8.len(var_224_27)
				local var_224_30 = var_224_28 <= 0 and var_224_24 or var_224_24 * (var_224_29 / var_224_28)

				if var_224_30 > 0 and var_224_24 < var_224_30 then
					arg_221_1.talkMaxDuration = var_224_30

					if var_224_30 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_30 + var_224_23
					end
				end

				arg_221_1.text_.text = var_224_27
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101053", "story_v_out_413101.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101053", "story_v_out_413101.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_413101", "413101053", "story_v_out_413101.awb")

						arg_221_1:RecordAudio("413101053", var_224_32)
						arg_221_1:RecordAudio("413101053", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413101", "413101053", "story_v_out_413101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413101", "413101053", "story_v_out_413101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_33 = math.max(var_224_24, arg_221_1.talkMaxDuration)

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_33 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_23) / var_224_33

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_23 + var_224_33 and arg_221_1.time_ < var_224_23 + var_224_33 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play413101054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413101054
		arg_225_1.duration_ = 3.73

		local var_225_0 = {
			zh = 3.733,
			ja = 3.3
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
				arg_225_0:Play413101055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10022"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10022 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10022", 6)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(1500, -315, -320)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10022, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_228_7 = arg_225_1.actors_["10093"].transform
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.var_.moveOldPos10093 = var_228_7.localPosition
				var_228_7.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10093", 6)

				local var_228_9 = var_228_7.childCount

				for iter_228_1 = 0, var_228_9 - 1 do
					local var_228_10 = var_228_7:GetChild(iter_228_1)

					if var_228_10.name == "" or not string.find(var_228_10.name, "split") then
						var_228_10.gameObject:SetActive(true)
					else
						var_228_10.gameObject:SetActive(false)
					end
				end
			end

			local var_228_11 = 0.001

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_11 then
				local var_228_12 = (arg_225_1.time_ - var_228_8) / var_228_11
				local var_228_13 = Vector3.New(1500, -345, -245)

				var_228_7.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10093, var_228_13, var_228_12)
			end

			if arg_225_1.time_ >= var_228_8 + var_228_11 and arg_225_1.time_ < var_228_8 + var_228_11 + arg_228_0 then
				var_228_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_228_14 = arg_225_1.actors_["10094"].transform
			local var_228_15 = 0

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_14.localPosition
				var_228_14.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 3)

				local var_228_16 = var_228_14.childCount

				for iter_228_2 = 0, var_228_16 - 1 do
					local var_228_17 = var_228_14:GetChild(iter_228_2)

					if var_228_17.name == "" or not string.find(var_228_17.name, "split") then
						var_228_17.gameObject:SetActive(true)
					else
						var_228_17.gameObject:SetActive(false)
					end
				end
			end

			local var_228_18 = 0.001

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_18 then
				local var_228_19 = (arg_225_1.time_ - var_228_15) / var_228_18
				local var_228_20 = Vector3.New(0, -340, -414)

				var_228_14.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, var_228_20, var_228_19)
			end

			if arg_225_1.time_ >= var_228_15 + var_228_18 and arg_225_1.time_ < var_228_15 + var_228_18 + arg_228_0 then
				var_228_14.localPosition = Vector3.New(0, -340, -414)
			end

			local var_228_21 = arg_225_1.actors_["10022"]
			local var_228_22 = 0

			if var_228_22 < arg_225_1.time_ and arg_225_1.time_ <= var_228_22 + arg_228_0 and not isNil(var_228_21) and arg_225_1.var_.actorSpriteComps10022 == nil then
				arg_225_1.var_.actorSpriteComps10022 = var_228_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_23 = 2

			if var_228_22 <= arg_225_1.time_ and arg_225_1.time_ < var_228_22 + var_228_23 and not isNil(var_228_21) then
				local var_228_24 = (arg_225_1.time_ - var_228_22) / var_228_23

				if arg_225_1.var_.actorSpriteComps10022 then
					for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_228_4 then
							if arg_225_1.isInRecall_ then
								local var_228_25 = Mathf.Lerp(iter_228_4.color.r, arg_225_1.hightColor2.r, var_228_24)
								local var_228_26 = Mathf.Lerp(iter_228_4.color.g, arg_225_1.hightColor2.g, var_228_24)
								local var_228_27 = Mathf.Lerp(iter_228_4.color.b, arg_225_1.hightColor2.b, var_228_24)

								iter_228_4.color = Color.New(var_228_25, var_228_26, var_228_27)
							else
								local var_228_28 = Mathf.Lerp(iter_228_4.color.r, 0.5, var_228_24)

								iter_228_4.color = Color.New(var_228_28, var_228_28, var_228_28)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_22 + var_228_23 and arg_225_1.time_ < var_228_22 + var_228_23 + arg_228_0 and not isNil(var_228_21) and arg_225_1.var_.actorSpriteComps10022 then
				for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_228_6 then
						if arg_225_1.isInRecall_ then
							iter_228_6.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10022 = nil
			end

			local var_228_29 = arg_225_1.actors_["10093"]
			local var_228_30 = 0

			if var_228_30 < arg_225_1.time_ and arg_225_1.time_ <= var_228_30 + arg_228_0 and not isNil(var_228_29) and arg_225_1.var_.actorSpriteComps10093 == nil then
				arg_225_1.var_.actorSpriteComps10093 = var_228_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_31 = 2

			if var_228_30 <= arg_225_1.time_ and arg_225_1.time_ < var_228_30 + var_228_31 and not isNil(var_228_29) then
				local var_228_32 = (arg_225_1.time_ - var_228_30) / var_228_31

				if arg_225_1.var_.actorSpriteComps10093 then
					for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_228_8 then
							if arg_225_1.isInRecall_ then
								local var_228_33 = Mathf.Lerp(iter_228_8.color.r, arg_225_1.hightColor2.r, var_228_32)
								local var_228_34 = Mathf.Lerp(iter_228_8.color.g, arg_225_1.hightColor2.g, var_228_32)
								local var_228_35 = Mathf.Lerp(iter_228_8.color.b, arg_225_1.hightColor2.b, var_228_32)

								iter_228_8.color = Color.New(var_228_33, var_228_34, var_228_35)
							else
								local var_228_36 = Mathf.Lerp(iter_228_8.color.r, 0.5, var_228_32)

								iter_228_8.color = Color.New(var_228_36, var_228_36, var_228_36)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_30 + var_228_31 and arg_225_1.time_ < var_228_30 + var_228_31 + arg_228_0 and not isNil(var_228_29) and arg_225_1.var_.actorSpriteComps10093 then
				for iter_228_9, iter_228_10 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_228_10 then
						if arg_225_1.isInRecall_ then
							iter_228_10.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10093 = nil
			end

			local var_228_37 = arg_225_1.actors_["10094"]
			local var_228_38 = 0

			if var_228_38 < arg_225_1.time_ and arg_225_1.time_ <= var_228_38 + arg_228_0 and not isNil(var_228_37) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_39 = 2

			if var_228_38 <= arg_225_1.time_ and arg_225_1.time_ < var_228_38 + var_228_39 and not isNil(var_228_37) then
				local var_228_40 = (arg_225_1.time_ - var_228_38) / var_228_39

				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_11, iter_228_12 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_12 then
							if arg_225_1.isInRecall_ then
								local var_228_41 = Mathf.Lerp(iter_228_12.color.r, arg_225_1.hightColor1.r, var_228_40)
								local var_228_42 = Mathf.Lerp(iter_228_12.color.g, arg_225_1.hightColor1.g, var_228_40)
								local var_228_43 = Mathf.Lerp(iter_228_12.color.b, arg_225_1.hightColor1.b, var_228_40)

								iter_228_12.color = Color.New(var_228_41, var_228_42, var_228_43)
							else
								local var_228_44 = Mathf.Lerp(iter_228_12.color.r, 1, var_228_40)

								iter_228_12.color = Color.New(var_228_44, var_228_44, var_228_44)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_38 + var_228_39 and arg_225_1.time_ < var_228_38 + var_228_39 + arg_228_0 and not isNil(var_228_37) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_14 then
						if arg_225_1.isInRecall_ then
							iter_228_14.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_45 = 0
			local var_228_46 = 0.55

			if var_228_45 < arg_225_1.time_ and arg_225_1.time_ <= var_228_45 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_47 = arg_225_1:FormatText(StoryNameCfg[259].name)

				arg_225_1.leftNameTxt_.text = var_228_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_48 = arg_225_1:GetWordFromCfg(413101054)
				local var_228_49 = arg_225_1:FormatText(var_228_48.content)

				arg_225_1.text_.text = var_228_49

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_50 = 22
				local var_228_51 = utf8.len(var_228_49)
				local var_228_52 = var_228_50 <= 0 and var_228_46 or var_228_46 * (var_228_51 / var_228_50)

				if var_228_52 > 0 and var_228_46 < var_228_52 then
					arg_225_1.talkMaxDuration = var_228_52

					if var_228_52 + var_228_45 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_52 + var_228_45
					end
				end

				arg_225_1.text_.text = var_228_49
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101054", "story_v_out_413101.awb") ~= 0 then
					local var_228_53 = manager.audio:GetVoiceLength("story_v_out_413101", "413101054", "story_v_out_413101.awb") / 1000

					if var_228_53 + var_228_45 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_53 + var_228_45
					end

					if var_228_48.prefab_name ~= "" and arg_225_1.actors_[var_228_48.prefab_name] ~= nil then
						local var_228_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_48.prefab_name].transform, "story_v_out_413101", "413101054", "story_v_out_413101.awb")

						arg_225_1:RecordAudio("413101054", var_228_54)
						arg_225_1:RecordAudio("413101054", var_228_54)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413101", "413101054", "story_v_out_413101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413101", "413101054", "story_v_out_413101.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_55 = math.max(var_228_46, arg_225_1.talkMaxDuration)

			if var_228_45 <= arg_225_1.time_ and arg_225_1.time_ < var_228_45 + var_228_55 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_45) / var_228_55

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_45 + var_228_55 and arg_225_1.time_ < var_228_45 + var_228_55 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_225_1:InitPlayNodeList()
	end,
	Play413101055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413101055
		arg_229_1.duration_ = 8.47

		local var_229_0 = {
			zh = 8.466,
			ja = 6.533
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
				arg_229_0:Play413101056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.825

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[259].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(413101055)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 33
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101055", "story_v_out_413101.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101055", "story_v_out_413101.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_413101", "413101055", "story_v_out_413101.awb")

						arg_229_1:RecordAudio("413101055", var_232_9)
						arg_229_1:RecordAudio("413101055", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413101", "413101055", "story_v_out_413101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413101", "413101055", "story_v_out_413101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413101056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413101056
		arg_233_1.duration_ = 15.1

		local var_233_0 = {
			zh = 10.566,
			ja = 15.1
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
				arg_233_0:Play413101057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10094"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10094 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10094", 3)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "split_2" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(0, -340, -414)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10094, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_236_7 = arg_233_1.actors_["10094"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps10094 == nil then
				arg_233_1.var_.actorSpriteComps10094 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 2

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 and not isNil(var_236_7) then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps10094 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								local var_236_11 = Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor1.r, var_236_10)
								local var_236_12 = Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor1.g, var_236_10)
								local var_236_13 = Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor1.b, var_236_10)

								iter_236_2.color = Color.New(var_236_11, var_236_12, var_236_13)
							else
								local var_236_14 = Mathf.Lerp(iter_236_2.color.r, 1, var_236_10)

								iter_236_2.color = Color.New(var_236_14, var_236_14, var_236_14)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps10094 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_236_4 then
						if arg_233_1.isInRecall_ then
							iter_236_4.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10094 = nil
			end

			local var_236_15 = 0
			local var_236_16 = 1.25

			if var_236_15 < arg_233_1.time_ and arg_233_1.time_ <= var_236_15 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_17 = arg_233_1:FormatText(StoryNameCfg[259].name)

				arg_233_1.leftNameTxt_.text = var_236_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_18 = arg_233_1:GetWordFromCfg(413101056)
				local var_236_19 = arg_233_1:FormatText(var_236_18.content)

				arg_233_1.text_.text = var_236_19

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_20 = 50
				local var_236_21 = utf8.len(var_236_19)
				local var_236_22 = var_236_20 <= 0 and var_236_16 or var_236_16 * (var_236_21 / var_236_20)

				if var_236_22 > 0 and var_236_16 < var_236_22 then
					arg_233_1.talkMaxDuration = var_236_22

					if var_236_22 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_22 + var_236_15
					end
				end

				arg_233_1.text_.text = var_236_19
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101056", "story_v_out_413101.awb") ~= 0 then
					local var_236_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101056", "story_v_out_413101.awb") / 1000

					if var_236_23 + var_236_15 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_23 + var_236_15
					end

					if var_236_18.prefab_name ~= "" and arg_233_1.actors_[var_236_18.prefab_name] ~= nil then
						local var_236_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_18.prefab_name].transform, "story_v_out_413101", "413101056", "story_v_out_413101.awb")

						arg_233_1:RecordAudio("413101056", var_236_24)
						arg_233_1:RecordAudio("413101056", var_236_24)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413101", "413101056", "story_v_out_413101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413101", "413101056", "story_v_out_413101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_25 = math.max(var_236_16, arg_233_1.talkMaxDuration)

			if var_236_15 <= arg_233_1.time_ and arg_233_1.time_ < var_236_15 + var_236_25 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_15) / var_236_25

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_15 + var_236_25 and arg_233_1.time_ < var_236_15 + var_236_25 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play413101057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413101057
		arg_237_1.duration_ = 5.67

		local var_237_0 = {
			zh = 2.533,
			ja = 5.666
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play413101058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10094"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10094 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10094", 2)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_2" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(-390, -340, -414)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10094, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_240_7 = arg_237_1.actors_["10092"].transform
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.var_.moveOldPos10092 = var_240_7.localPosition
				var_240_7.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10092", 4)

				local var_240_9 = var_240_7.childCount

				for iter_240_1 = 0, var_240_9 - 1 do
					local var_240_10 = var_240_7:GetChild(iter_240_1)

					if var_240_10.name == "split_1_1" or not string.find(var_240_10.name, "split") then
						var_240_10.gameObject:SetActive(true)
					else
						var_240_10.gameObject:SetActive(false)
					end
				end
			end

			local var_240_11 = 0.001

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_11 then
				local var_240_12 = (arg_237_1.time_ - var_240_8) / var_240_11
				local var_240_13 = Vector3.New(390, -300, -295)

				var_240_7.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10092, var_240_13, var_240_12)
			end

			if arg_237_1.time_ >= var_240_8 + var_240_11 and arg_237_1.time_ < var_240_8 + var_240_11 + arg_240_0 then
				var_240_7.localPosition = Vector3.New(390, -300, -295)
			end

			local var_240_14 = arg_237_1.actors_["10094"]
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.actorSpriteComps10094 == nil then
				arg_237_1.var_.actorSpriteComps10094 = var_240_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_16 = 2

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 and not isNil(var_240_14) then
				local var_240_17 = (arg_237_1.time_ - var_240_15) / var_240_16

				if arg_237_1.var_.actorSpriteComps10094 then
					for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_240_3 then
							if arg_237_1.isInRecall_ then
								local var_240_18 = Mathf.Lerp(iter_240_3.color.r, arg_237_1.hightColor2.r, var_240_17)
								local var_240_19 = Mathf.Lerp(iter_240_3.color.g, arg_237_1.hightColor2.g, var_240_17)
								local var_240_20 = Mathf.Lerp(iter_240_3.color.b, arg_237_1.hightColor2.b, var_240_17)

								iter_240_3.color = Color.New(var_240_18, var_240_19, var_240_20)
							else
								local var_240_21 = Mathf.Lerp(iter_240_3.color.r, 0.5, var_240_17)

								iter_240_3.color = Color.New(var_240_21, var_240_21, var_240_21)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 and not isNil(var_240_14) and arg_237_1.var_.actorSpriteComps10094 then
				for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_240_5 then
						if arg_237_1.isInRecall_ then
							iter_240_5.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10094 = nil
			end

			local var_240_22 = arg_237_1.actors_["10092"]
			local var_240_23 = 0

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.actorSpriteComps10092 == nil then
				arg_237_1.var_.actorSpriteComps10092 = var_240_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_24 = 2

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_24 and not isNil(var_240_22) then
				local var_240_25 = (arg_237_1.time_ - var_240_23) / var_240_24

				if arg_237_1.var_.actorSpriteComps10092 then
					for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_240_7 then
							if arg_237_1.isInRecall_ then
								local var_240_26 = Mathf.Lerp(iter_240_7.color.r, arg_237_1.hightColor1.r, var_240_25)
								local var_240_27 = Mathf.Lerp(iter_240_7.color.g, arg_237_1.hightColor1.g, var_240_25)
								local var_240_28 = Mathf.Lerp(iter_240_7.color.b, arg_237_1.hightColor1.b, var_240_25)

								iter_240_7.color = Color.New(var_240_26, var_240_27, var_240_28)
							else
								local var_240_29 = Mathf.Lerp(iter_240_7.color.r, 1, var_240_25)

								iter_240_7.color = Color.New(var_240_29, var_240_29, var_240_29)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_23 + var_240_24 and arg_237_1.time_ < var_240_23 + var_240_24 + arg_240_0 and not isNil(var_240_22) and arg_237_1.var_.actorSpriteComps10092 then
				for iter_240_8, iter_240_9 in pairs(arg_237_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_240_9 then
						if arg_237_1.isInRecall_ then
							iter_240_9.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10092 = nil
			end

			local var_240_30 = 0
			local var_240_31 = 0.375

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[996].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(413101057)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 15
				local var_240_36 = utf8.len(var_240_34)
				local var_240_37 = var_240_35 <= 0 and var_240_31 or var_240_31 * (var_240_36 / var_240_35)

				if var_240_37 > 0 and var_240_31 < var_240_37 then
					arg_237_1.talkMaxDuration = var_240_37

					if var_240_37 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_37 + var_240_30
					end
				end

				arg_237_1.text_.text = var_240_34
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101057", "story_v_out_413101.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101057", "story_v_out_413101.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_413101", "413101057", "story_v_out_413101.awb")

						arg_237_1:RecordAudio("413101057", var_240_39)
						arg_237_1:RecordAudio("413101057", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_413101", "413101057", "story_v_out_413101.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_413101", "413101057", "story_v_out_413101.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_40 = math.max(var_240_31, arg_237_1.talkMaxDuration)

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_30) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_30 + var_240_40 and arg_237_1.time_ < var_240_30 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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

		arg_237_1:InitPlayNodeList()
	end,
	Play413101058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413101058
		arg_241_1.duration_ = 11.33

		local var_241_0 = {
			zh = 8.5,
			ja = 11.333
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
				arg_241_0:Play413101059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 1.25

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[996].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(413101058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101058", "story_v_out_413101.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101058", "story_v_out_413101.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_413101", "413101058", "story_v_out_413101.awb")

						arg_241_1:RecordAudio("413101058", var_244_9)
						arg_241_1:RecordAudio("413101058", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413101", "413101058", "story_v_out_413101.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413101", "413101058", "story_v_out_413101.awb")
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
	Play413101059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413101059
		arg_245_1.duration_ = 9.8

		local var_245_0 = {
			zh = 9.3,
			ja = 9.8
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
				arg_245_0:Play413101060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10022"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos10022 = var_248_0.localPosition
				var_248_0.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10022", 2)

				local var_248_2 = var_248_0.childCount

				for iter_248_0 = 0, var_248_2 - 1 do
					local var_248_3 = var_248_0:GetChild(iter_248_0)

					if var_248_3.name == "" or not string.find(var_248_3.name, "split") then
						var_248_3.gameObject:SetActive(true)
					else
						var_248_3.gameObject:SetActive(false)
					end
				end
			end

			local var_248_4 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_4 then
				local var_248_5 = (arg_245_1.time_ - var_248_1) / var_248_4
				local var_248_6 = Vector3.New(-390, -315, -320)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10022, var_248_6, var_248_5)
			end

			if arg_245_1.time_ >= var_248_1 + var_248_4 and arg_245_1.time_ < var_248_1 + var_248_4 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_248_7 = arg_245_1.actors_["10022"]
			local var_248_8 = 0

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps10022 == nil then
				arg_245_1.var_.actorSpriteComps10022 = var_248_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_9 = 2

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_9 and not isNil(var_248_7) then
				local var_248_10 = (arg_245_1.time_ - var_248_8) / var_248_9

				if arg_245_1.var_.actorSpriteComps10022 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_248_2 then
							if arg_245_1.isInRecall_ then
								local var_248_11 = Mathf.Lerp(iter_248_2.color.r, arg_245_1.hightColor1.r, var_248_10)
								local var_248_12 = Mathf.Lerp(iter_248_2.color.g, arg_245_1.hightColor1.g, var_248_10)
								local var_248_13 = Mathf.Lerp(iter_248_2.color.b, arg_245_1.hightColor1.b, var_248_10)

								iter_248_2.color = Color.New(var_248_11, var_248_12, var_248_13)
							else
								local var_248_14 = Mathf.Lerp(iter_248_2.color.r, 1, var_248_10)

								iter_248_2.color = Color.New(var_248_14, var_248_14, var_248_14)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_8 + var_248_9 and arg_245_1.time_ < var_248_8 + var_248_9 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps10022 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_248_4 then
						if arg_245_1.isInRecall_ then
							iter_248_4.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10022 = nil
			end

			local var_248_15 = arg_245_1.actors_["10092"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps10092 == nil then
				arg_245_1.var_.actorSpriteComps10092 = var_248_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_17 = 2

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.actorSpriteComps10092 then
					for iter_248_5, iter_248_6 in pairs(arg_245_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_248_6 then
							if arg_245_1.isInRecall_ then
								local var_248_19 = Mathf.Lerp(iter_248_6.color.r, arg_245_1.hightColor2.r, var_248_18)
								local var_248_20 = Mathf.Lerp(iter_248_6.color.g, arg_245_1.hightColor2.g, var_248_18)
								local var_248_21 = Mathf.Lerp(iter_248_6.color.b, arg_245_1.hightColor2.b, var_248_18)

								iter_248_6.color = Color.New(var_248_19, var_248_20, var_248_21)
							else
								local var_248_22 = Mathf.Lerp(iter_248_6.color.r, 0.5, var_248_18)

								iter_248_6.color = Color.New(var_248_22, var_248_22, var_248_22)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps10092 then
				for iter_248_7, iter_248_8 in pairs(arg_245_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_248_8 then
						if arg_245_1.isInRecall_ then
							iter_248_8.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10092 = nil
			end

			local var_248_23 = 0
			local var_248_24 = 1.15

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_25 = arg_245_1:FormatText(StoryNameCfg[614].name)

				arg_245_1.leftNameTxt_.text = var_248_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_26 = arg_245_1:GetWordFromCfg(413101059)
				local var_248_27 = arg_245_1:FormatText(var_248_26.content)

				arg_245_1.text_.text = var_248_27

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_28 = 46
				local var_248_29 = utf8.len(var_248_27)
				local var_248_30 = var_248_28 <= 0 and var_248_24 or var_248_24 * (var_248_29 / var_248_28)

				if var_248_30 > 0 and var_248_24 < var_248_30 then
					arg_245_1.talkMaxDuration = var_248_30

					if var_248_30 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_23
					end
				end

				arg_245_1.text_.text = var_248_27
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101059", "story_v_out_413101.awb") ~= 0 then
					local var_248_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101059", "story_v_out_413101.awb") / 1000

					if var_248_31 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_23
					end

					if var_248_26.prefab_name ~= "" and arg_245_1.actors_[var_248_26.prefab_name] ~= nil then
						local var_248_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_26.prefab_name].transform, "story_v_out_413101", "413101059", "story_v_out_413101.awb")

						arg_245_1:RecordAudio("413101059", var_248_32)
						arg_245_1:RecordAudio("413101059", var_248_32)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413101", "413101059", "story_v_out_413101.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413101", "413101059", "story_v_out_413101.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_33 = math.max(var_248_24, arg_245_1.talkMaxDuration)

			if var_248_23 <= arg_245_1.time_ and arg_245_1.time_ < var_248_23 + var_248_33 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_23) / var_248_33

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_23 + var_248_33 and arg_245_1.time_ < var_248_23 + var_248_33 + arg_248_0 then
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
	Play413101060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413101060
		arg_249_1.duration_ = 6.2

		local var_249_0 = {
			zh = 3.733,
			ja = 6.2
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413101061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10022"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10022 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10022", 2)

				local var_252_2 = var_252_0.childCount

				for iter_252_0 = 0, var_252_2 - 1 do
					local var_252_3 = var_252_0:GetChild(iter_252_0)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_4 then
				local var_252_5 = (arg_249_1.time_ - var_252_1) / var_252_4
				local var_252_6 = Vector3.New(-390, -315, -320)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10022, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_252_7 = arg_249_1.actors_["10094"].transform
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.var_.moveOldPos10094 = var_252_7.localPosition
				var_252_7.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10094", 4)

				local var_252_9 = var_252_7.childCount

				for iter_252_1 = 0, var_252_9 - 1 do
					local var_252_10 = var_252_7:GetChild(iter_252_1)

					if var_252_10.name == "" or not string.find(var_252_10.name, "split") then
						var_252_10.gameObject:SetActive(true)
					else
						var_252_10.gameObject:SetActive(false)
					end
				end
			end

			local var_252_11 = 0.001

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_11 then
				local var_252_12 = (arg_249_1.time_ - var_252_8) / var_252_11
				local var_252_13 = Vector3.New(390, -340, -414)

				var_252_7.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10094, var_252_13, var_252_12)
			end

			if arg_249_1.time_ >= var_252_8 + var_252_11 and arg_249_1.time_ < var_252_8 + var_252_11 + arg_252_0 then
				var_252_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_252_14 = arg_249_1.actors_["10022"]
			local var_252_15 = 0

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps10022 == nil then
				arg_249_1.var_.actorSpriteComps10022 = var_252_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_16 = 2

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_16 and not isNil(var_252_14) then
				local var_252_17 = (arg_249_1.time_ - var_252_15) / var_252_16

				if arg_249_1.var_.actorSpriteComps10022 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								local var_252_18 = Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor2.r, var_252_17)
								local var_252_19 = Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor2.g, var_252_17)
								local var_252_20 = Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor2.b, var_252_17)

								iter_252_3.color = Color.New(var_252_18, var_252_19, var_252_20)
							else
								local var_252_21 = Mathf.Lerp(iter_252_3.color.r, 0.5, var_252_17)

								iter_252_3.color = Color.New(var_252_21, var_252_21, var_252_21)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_15 + var_252_16 and arg_249_1.time_ < var_252_15 + var_252_16 + arg_252_0 and not isNil(var_252_14) and arg_249_1.var_.actorSpriteComps10022 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_252_5 then
						if arg_249_1.isInRecall_ then
							iter_252_5.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10022 = nil
			end

			local var_252_22 = arg_249_1.actors_["10094"]
			local var_252_23 = 0

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10094 == nil then
				arg_249_1.var_.actorSpriteComps10094 = var_252_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_24 = 2

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_24 and not isNil(var_252_22) then
				local var_252_25 = (arg_249_1.time_ - var_252_23) / var_252_24

				if arg_249_1.var_.actorSpriteComps10094 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								local var_252_26 = Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor1.r, var_252_25)
								local var_252_27 = Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor1.g, var_252_25)
								local var_252_28 = Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor1.b, var_252_25)

								iter_252_7.color = Color.New(var_252_26, var_252_27, var_252_28)
							else
								local var_252_29 = Mathf.Lerp(iter_252_7.color.r, 1, var_252_25)

								iter_252_7.color = Color.New(var_252_29, var_252_29, var_252_29)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_23 + var_252_24 and arg_249_1.time_ < var_252_23 + var_252_24 + arg_252_0 and not isNil(var_252_22) and arg_249_1.var_.actorSpriteComps10094 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_252_9 then
						if arg_249_1.isInRecall_ then
							iter_252_9.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10094 = nil
			end

			local var_252_30 = 0
			local var_252_31 = 0.4

			if var_252_30 < arg_249_1.time_ and arg_249_1.time_ <= var_252_30 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_32 = arg_249_1:FormatText(StoryNameCfg[259].name)

				arg_249_1.leftNameTxt_.text = var_252_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_33 = arg_249_1:GetWordFromCfg(413101060)
				local var_252_34 = arg_249_1:FormatText(var_252_33.content)

				arg_249_1.text_.text = var_252_34

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_35 = 16
				local var_252_36 = utf8.len(var_252_34)
				local var_252_37 = var_252_35 <= 0 and var_252_31 or var_252_31 * (var_252_36 / var_252_35)

				if var_252_37 > 0 and var_252_31 < var_252_37 then
					arg_249_1.talkMaxDuration = var_252_37

					if var_252_37 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_37 + var_252_30
					end
				end

				arg_249_1.text_.text = var_252_34
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101060", "story_v_out_413101.awb") ~= 0 then
					local var_252_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101060", "story_v_out_413101.awb") / 1000

					if var_252_38 + var_252_30 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_38 + var_252_30
					end

					if var_252_33.prefab_name ~= "" and arg_249_1.actors_[var_252_33.prefab_name] ~= nil then
						local var_252_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_33.prefab_name].transform, "story_v_out_413101", "413101060", "story_v_out_413101.awb")

						arg_249_1:RecordAudio("413101060", var_252_39)
						arg_249_1:RecordAudio("413101060", var_252_39)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413101", "413101060", "story_v_out_413101.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413101", "413101060", "story_v_out_413101.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_40 = math.max(var_252_31, arg_249_1.talkMaxDuration)

			if var_252_30 <= arg_249_1.time_ and arg_249_1.time_ < var_252_30 + var_252_40 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_30) / var_252_40

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_30 + var_252_40 and arg_249_1.time_ < var_252_30 + var_252_40 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_249_1:InitPlayNodeList()
	end,
	Play413101061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413101061
		arg_253_1.duration_ = 5.73

		local var_253_0 = {
			zh = 4.2,
			ja = 5.733
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
				arg_253_0:Play413101062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10022"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos10022 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10022", 2)

				local var_256_2 = var_256_0.childCount

				for iter_256_0 = 0, var_256_2 - 1 do
					local var_256_3 = var_256_0:GetChild(iter_256_0)

					if var_256_3.name == "split_3" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_4 then
				local var_256_5 = (arg_253_1.time_ - var_256_1) / var_256_4
				local var_256_6 = Vector3.New(-390, -315, -320)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10022, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_256_7 = arg_253_1.actors_["10094"].transform
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.var_.moveOldPos10094 = var_256_7.localPosition
				var_256_7.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10094", 4)

				local var_256_9 = var_256_7.childCount

				for iter_256_1 = 0, var_256_9 - 1 do
					local var_256_10 = var_256_7:GetChild(iter_256_1)

					if var_256_10.name == "" or not string.find(var_256_10.name, "split") then
						var_256_10.gameObject:SetActive(true)
					else
						var_256_10.gameObject:SetActive(false)
					end
				end
			end

			local var_256_11 = 0.001

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_11 then
				local var_256_12 = (arg_253_1.time_ - var_256_8) / var_256_11
				local var_256_13 = Vector3.New(390, -340, -414)

				var_256_7.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10094, var_256_13, var_256_12)
			end

			if arg_253_1.time_ >= var_256_8 + var_256_11 and arg_253_1.time_ < var_256_8 + var_256_11 + arg_256_0 then
				var_256_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_256_14 = arg_253_1.actors_["10022"]
			local var_256_15 = 0

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 and not isNil(var_256_14) and arg_253_1.var_.actorSpriteComps10022 == nil then
				arg_253_1.var_.actorSpriteComps10022 = var_256_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_16 = 2

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_16 and not isNil(var_256_14) then
				local var_256_17 = (arg_253_1.time_ - var_256_15) / var_256_16

				if arg_253_1.var_.actorSpriteComps10022 then
					for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_256_3 then
							if arg_253_1.isInRecall_ then
								local var_256_18 = Mathf.Lerp(iter_256_3.color.r, arg_253_1.hightColor1.r, var_256_17)
								local var_256_19 = Mathf.Lerp(iter_256_3.color.g, arg_253_1.hightColor1.g, var_256_17)
								local var_256_20 = Mathf.Lerp(iter_256_3.color.b, arg_253_1.hightColor1.b, var_256_17)

								iter_256_3.color = Color.New(var_256_18, var_256_19, var_256_20)
							else
								local var_256_21 = Mathf.Lerp(iter_256_3.color.r, 1, var_256_17)

								iter_256_3.color = Color.New(var_256_21, var_256_21, var_256_21)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_15 + var_256_16 and arg_253_1.time_ < var_256_15 + var_256_16 + arg_256_0 and not isNil(var_256_14) and arg_253_1.var_.actorSpriteComps10022 then
				for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_256_5 then
						if arg_253_1.isInRecall_ then
							iter_256_5.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10022 = nil
			end

			local var_256_22 = arg_253_1.actors_["10094"]
			local var_256_23 = 0

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 and not isNil(var_256_22) and arg_253_1.var_.actorSpriteComps10094 == nil then
				arg_253_1.var_.actorSpriteComps10094 = var_256_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_24 = 2

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_24 and not isNil(var_256_22) then
				local var_256_25 = (arg_253_1.time_ - var_256_23) / var_256_24

				if arg_253_1.var_.actorSpriteComps10094 then
					for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_256_7 then
							if arg_253_1.isInRecall_ then
								local var_256_26 = Mathf.Lerp(iter_256_7.color.r, arg_253_1.hightColor2.r, var_256_25)
								local var_256_27 = Mathf.Lerp(iter_256_7.color.g, arg_253_1.hightColor2.g, var_256_25)
								local var_256_28 = Mathf.Lerp(iter_256_7.color.b, arg_253_1.hightColor2.b, var_256_25)

								iter_256_7.color = Color.New(var_256_26, var_256_27, var_256_28)
							else
								local var_256_29 = Mathf.Lerp(iter_256_7.color.r, 0.5, var_256_25)

								iter_256_7.color = Color.New(var_256_29, var_256_29, var_256_29)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_23 + var_256_24 and arg_253_1.time_ < var_256_23 + var_256_24 + arg_256_0 and not isNil(var_256_22) and arg_253_1.var_.actorSpriteComps10094 then
				for iter_256_8, iter_256_9 in pairs(arg_253_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_256_9 then
						if arg_253_1.isInRecall_ then
							iter_256_9.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10094 = nil
			end

			local var_256_30 = 0
			local var_256_31 = 0.6

			if var_256_30 < arg_253_1.time_ and arg_253_1.time_ <= var_256_30 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_32 = arg_253_1:FormatText(StoryNameCfg[614].name)

				arg_253_1.leftNameTxt_.text = var_256_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_33 = arg_253_1:GetWordFromCfg(413101061)
				local var_256_34 = arg_253_1:FormatText(var_256_33.content)

				arg_253_1.text_.text = var_256_34

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_35 = 24
				local var_256_36 = utf8.len(var_256_34)
				local var_256_37 = var_256_35 <= 0 and var_256_31 or var_256_31 * (var_256_36 / var_256_35)

				if var_256_37 > 0 and var_256_31 < var_256_37 then
					arg_253_1.talkMaxDuration = var_256_37

					if var_256_37 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_37 + var_256_30
					end
				end

				arg_253_1.text_.text = var_256_34
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101061", "story_v_out_413101.awb") ~= 0 then
					local var_256_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101061", "story_v_out_413101.awb") / 1000

					if var_256_38 + var_256_30 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_38 + var_256_30
					end

					if var_256_33.prefab_name ~= "" and arg_253_1.actors_[var_256_33.prefab_name] ~= nil then
						local var_256_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_33.prefab_name].transform, "story_v_out_413101", "413101061", "story_v_out_413101.awb")

						arg_253_1:RecordAudio("413101061", var_256_39)
						arg_253_1:RecordAudio("413101061", var_256_39)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413101", "413101061", "story_v_out_413101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413101", "413101061", "story_v_out_413101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_40 = math.max(var_256_31, arg_253_1.talkMaxDuration)

			if var_256_30 <= arg_253_1.time_ and arg_253_1.time_ < var_256_30 + var_256_40 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_30) / var_256_40

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_30 + var_256_40 and arg_253_1.time_ < var_256_30 + var_256_40 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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

		arg_253_1:InitPlayNodeList()
	end,
	Play413101062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413101062
		arg_257_1.duration_ = 8.87

		local var_257_0 = {
			zh = 3.166,
			ja = 8.866
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
				arg_257_0:Play413101063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10022"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10022 == nil then
				arg_257_1.var_.actorSpriteComps10022 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10022 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 0.5, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10022 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10022 = nil
			end

			local var_260_8 = arg_257_1.actors_["10094"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10094 == nil then
				arg_257_1.var_.actorSpriteComps10094 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 2

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps10094 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								local var_260_12 = Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor1.r, var_260_11)
								local var_260_13 = Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor1.g, var_260_11)
								local var_260_14 = Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor1.b, var_260_11)

								iter_260_5.color = Color.New(var_260_12, var_260_13, var_260_14)
							else
								local var_260_15 = Mathf.Lerp(iter_260_5.color.r, 1, var_260_11)

								iter_260_5.color = Color.New(var_260_15, var_260_15, var_260_15)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10094 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10094 = nil
			end

			local var_260_16 = 0
			local var_260_17 = 0.45

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_18 = arg_257_1:FormatText(StoryNameCfg[259].name)

				arg_257_1.leftNameTxt_.text = var_260_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_19 = arg_257_1:GetWordFromCfg(413101062)
				local var_260_20 = arg_257_1:FormatText(var_260_19.content)

				arg_257_1.text_.text = var_260_20

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_21 = 18
				local var_260_22 = utf8.len(var_260_20)
				local var_260_23 = var_260_21 <= 0 and var_260_17 or var_260_17 * (var_260_22 / var_260_21)

				if var_260_23 > 0 and var_260_17 < var_260_23 then
					arg_257_1.talkMaxDuration = var_260_23

					if var_260_23 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_16
					end
				end

				arg_257_1.text_.text = var_260_20
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101062", "story_v_out_413101.awb") ~= 0 then
					local var_260_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101062", "story_v_out_413101.awb") / 1000

					if var_260_24 + var_260_16 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_16
					end

					if var_260_19.prefab_name ~= "" and arg_257_1.actors_[var_260_19.prefab_name] ~= nil then
						local var_260_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_19.prefab_name].transform, "story_v_out_413101", "413101062", "story_v_out_413101.awb")

						arg_257_1:RecordAudio("413101062", var_260_25)
						arg_257_1:RecordAudio("413101062", var_260_25)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413101", "413101062", "story_v_out_413101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413101", "413101062", "story_v_out_413101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_26 = math.max(var_260_17, arg_257_1.talkMaxDuration)

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_26 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_16) / var_260_26

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_16 + var_260_26 and arg_257_1.time_ < var_260_16 + var_260_26 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413101063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413101063
		arg_261_1.duration_ = 4.73

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413101064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10022"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps10022 == nil then
				arg_261_1.var_.actorSpriteComps10022 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps10022 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 1, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps10022 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10022 = nil
			end

			local var_264_8 = arg_261_1.actors_["10094"]
			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10094 == nil then
				arg_261_1.var_.actorSpriteComps10094 = var_264_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_10 = 2

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 and not isNil(var_264_8) then
				local var_264_11 = (arg_261_1.time_ - var_264_9) / var_264_10

				if arg_261_1.var_.actorSpriteComps10094 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								local var_264_12 = Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, var_264_11)
								local var_264_13 = Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, var_264_11)
								local var_264_14 = Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, var_264_11)

								iter_264_5.color = Color.New(var_264_12, var_264_13, var_264_14)
							else
								local var_264_15 = Mathf.Lerp(iter_264_5.color.r, 0.5, var_264_11)

								iter_264_5.color = Color.New(var_264_15, var_264_15, var_264_15)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps10094 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_264_7 then
						if arg_261_1.isInRecall_ then
							iter_264_7.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10094 = nil
			end

			local var_264_16 = 0
			local var_264_17 = 0.6

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_18 = arg_261_1:FormatText(StoryNameCfg[614].name)

				arg_261_1.leftNameTxt_.text = var_264_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_19 = arg_261_1:GetWordFromCfg(413101063)
				local var_264_20 = arg_261_1:FormatText(var_264_19.content)

				arg_261_1.text_.text = var_264_20

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_21 = 24
				local var_264_22 = utf8.len(var_264_20)
				local var_264_23 = var_264_21 <= 0 and var_264_17 or var_264_17 * (var_264_22 / var_264_21)

				if var_264_23 > 0 and var_264_17 < var_264_23 then
					arg_261_1.talkMaxDuration = var_264_23

					if var_264_23 + var_264_16 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_16
					end
				end

				arg_261_1.text_.text = var_264_20
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101063", "story_v_out_413101.awb") ~= 0 then
					local var_264_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101063", "story_v_out_413101.awb") / 1000

					if var_264_24 + var_264_16 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_24 + var_264_16
					end

					if var_264_19.prefab_name ~= "" and arg_261_1.actors_[var_264_19.prefab_name] ~= nil then
						local var_264_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_19.prefab_name].transform, "story_v_out_413101", "413101063", "story_v_out_413101.awb")

						arg_261_1:RecordAudio("413101063", var_264_25)
						arg_261_1:RecordAudio("413101063", var_264_25)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413101", "413101063", "story_v_out_413101.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413101", "413101063", "story_v_out_413101.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_26 = math.max(var_264_17, arg_261_1.talkMaxDuration)

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_26 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_16) / var_264_26

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_16 + var_264_26 and arg_261_1.time_ < var_264_16 + var_264_26 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play413101064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413101064
		arg_265_1.duration_ = 5.93

		local var_265_0 = {
			zh = 3.3,
			ja = 5.933
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
				arg_265_0:Play413101065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10094"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10094 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10094", 4)

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
				local var_268_6 = Vector3.New(390, -340, -414)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10094, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(390, -340, -414)
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
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor2.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor2.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor2.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 0.5, var_268_10)

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
							iter_268_4.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10022 = nil
			end

			local var_268_15 = arg_265_1.actors_["10094"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10094 == nil then
				arg_265_1.var_.actorSpriteComps10094 = var_268_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_17 = 2

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.actorSpriteComps10094 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								local var_268_19 = Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor1.r, var_268_18)
								local var_268_20 = Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor1.g, var_268_18)
								local var_268_21 = Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor1.b, var_268_18)

								iter_268_6.color = Color.New(var_268_19, var_268_20, var_268_21)
							else
								local var_268_22 = Mathf.Lerp(iter_268_6.color.r, 1, var_268_18)

								iter_268_6.color = Color.New(var_268_22, var_268_22, var_268_22)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.actorSpriteComps10094 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10094 = nil
			end

			local var_268_23 = 0
			local var_268_24 = 0.375

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[259].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(413101064)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 15
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101064", "story_v_out_413101.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101064", "story_v_out_413101.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_413101", "413101064", "story_v_out_413101.awb")

						arg_265_1:RecordAudio("413101064", var_268_32)
						arg_265_1:RecordAudio("413101064", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_413101", "413101064", "story_v_out_413101.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_413101", "413101064", "story_v_out_413101.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play413101065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413101065
		arg_269_1.duration_ = 7.53

		local var_269_0 = {
			zh = 5.3,
			ja = 7.533
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
				arg_269_0:Play413101066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10092"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos10092 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10092", 2)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "split_1_1" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(-389.49, -300, -295)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10092, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_272_7 = arg_269_1.actors_["10092"]
			local var_272_8 = 0

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10092 == nil then
				arg_269_1.var_.actorSpriteComps10092 = var_272_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 2

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_9 and not isNil(var_272_7) then
				local var_272_10 = (arg_269_1.time_ - var_272_8) / var_272_9

				if arg_269_1.var_.actorSpriteComps10092 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								local var_272_11 = Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, var_272_10)
								local var_272_12 = Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, var_272_10)
								local var_272_13 = Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, var_272_10)

								iter_272_2.color = Color.New(var_272_11, var_272_12, var_272_13)
							else
								local var_272_14 = Mathf.Lerp(iter_272_2.color.r, 1, var_272_10)

								iter_272_2.color = Color.New(var_272_14, var_272_14, var_272_14)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_8 + var_272_9 and arg_269_1.time_ < var_272_8 + var_272_9 + arg_272_0 and not isNil(var_272_7) and arg_269_1.var_.actorSpriteComps10092 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_272_4 then
						if arg_269_1.isInRecall_ then
							iter_272_4.color = arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_272_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10092 = nil
			end

			local var_272_15 = arg_269_1.actors_["10094"]
			local var_272_16 = 0

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps10094 == nil then
				arg_269_1.var_.actorSpriteComps10094 = var_272_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_17 = 2

			if var_272_16 <= arg_269_1.time_ and arg_269_1.time_ < var_272_16 + var_272_17 and not isNil(var_272_15) then
				local var_272_18 = (arg_269_1.time_ - var_272_16) / var_272_17

				if arg_269_1.var_.actorSpriteComps10094 then
					for iter_272_5, iter_272_6 in pairs(arg_269_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_272_6 then
							if arg_269_1.isInRecall_ then
								local var_272_19 = Mathf.Lerp(iter_272_6.color.r, arg_269_1.hightColor2.r, var_272_18)
								local var_272_20 = Mathf.Lerp(iter_272_6.color.g, arg_269_1.hightColor2.g, var_272_18)
								local var_272_21 = Mathf.Lerp(iter_272_6.color.b, arg_269_1.hightColor2.b, var_272_18)

								iter_272_6.color = Color.New(var_272_19, var_272_20, var_272_21)
							else
								local var_272_22 = Mathf.Lerp(iter_272_6.color.r, 0.5, var_272_18)

								iter_272_6.color = Color.New(var_272_22, var_272_22, var_272_22)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.actorSpriteComps10094 then
				for iter_272_7, iter_272_8 in pairs(arg_269_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_272_8 then
						if arg_269_1.isInRecall_ then
							iter_272_8.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps10094 = nil
			end

			local var_272_23 = 0
			local var_272_24 = 0.775

			if var_272_23 < arg_269_1.time_ and arg_269_1.time_ <= var_272_23 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_25 = arg_269_1:FormatText(StoryNameCfg[996].name)

				arg_269_1.leftNameTxt_.text = var_272_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_26 = arg_269_1:GetWordFromCfg(413101065)
				local var_272_27 = arg_269_1:FormatText(var_272_26.content)

				arg_269_1.text_.text = var_272_27

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_28 = 31
				local var_272_29 = utf8.len(var_272_27)
				local var_272_30 = var_272_28 <= 0 and var_272_24 or var_272_24 * (var_272_29 / var_272_28)

				if var_272_30 > 0 and var_272_24 < var_272_30 then
					arg_269_1.talkMaxDuration = var_272_30

					if var_272_30 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_30 + var_272_23
					end
				end

				arg_269_1.text_.text = var_272_27
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101065", "story_v_out_413101.awb") ~= 0 then
					local var_272_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101065", "story_v_out_413101.awb") / 1000

					if var_272_31 + var_272_23 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_31 + var_272_23
					end

					if var_272_26.prefab_name ~= "" and arg_269_1.actors_[var_272_26.prefab_name] ~= nil then
						local var_272_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_26.prefab_name].transform, "story_v_out_413101", "413101065", "story_v_out_413101.awb")

						arg_269_1:RecordAudio("413101065", var_272_32)
						arg_269_1:RecordAudio("413101065", var_272_32)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413101", "413101065", "story_v_out_413101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413101", "413101065", "story_v_out_413101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_33 = math.max(var_272_24, arg_269_1.talkMaxDuration)

			if var_272_23 <= arg_269_1.time_ and arg_269_1.time_ < var_272_23 + var_272_33 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_23) / var_272_33

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_23 + var_272_33 and arg_269_1.time_ < var_272_23 + var_272_33 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play413101066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413101066
		arg_273_1.duration_ = 7.2

		local var_273_0 = {
			zh = 3.766,
			ja = 7.2
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
				arg_273_0:Play413101067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.475

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[996].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(413101066)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101066", "story_v_out_413101.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101066", "story_v_out_413101.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_413101", "413101066", "story_v_out_413101.awb")

						arg_273_1:RecordAudio("413101066", var_276_9)
						arg_273_1:RecordAudio("413101066", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413101", "413101066", "story_v_out_413101.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413101", "413101066", "story_v_out_413101.awb")
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
	Play413101067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413101067
		arg_277_1.duration_ = 5.53

		local var_277_0 = {
			zh = 4.833,
			ja = 5.533
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
				arg_277_0:Play413101068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10094"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10094 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10094", 4)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "split_2" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(390, -340, -414)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10094, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_280_7 = arg_277_1.actors_["10092"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps10092 == nil then
				arg_277_1.var_.actorSpriteComps10092 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 2

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps10092 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor2.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor2.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor2.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 0.5, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps10092 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10092 = nil
			end

			local var_280_15 = arg_277_1.actors_["10094"]
			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.actorSpriteComps10094 == nil then
				arg_277_1.var_.actorSpriteComps10094 = var_280_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_17 = 2

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_17 and not isNil(var_280_15) then
				local var_280_18 = (arg_277_1.time_ - var_280_16) / var_280_17

				if arg_277_1.var_.actorSpriteComps10094 then
					for iter_280_5, iter_280_6 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_280_6 then
							if arg_277_1.isInRecall_ then
								local var_280_19 = Mathf.Lerp(iter_280_6.color.r, arg_277_1.hightColor1.r, var_280_18)
								local var_280_20 = Mathf.Lerp(iter_280_6.color.g, arg_277_1.hightColor1.g, var_280_18)
								local var_280_21 = Mathf.Lerp(iter_280_6.color.b, arg_277_1.hightColor1.b, var_280_18)

								iter_280_6.color = Color.New(var_280_19, var_280_20, var_280_21)
							else
								local var_280_22 = Mathf.Lerp(iter_280_6.color.r, 1, var_280_18)

								iter_280_6.color = Color.New(var_280_22, var_280_22, var_280_22)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_16 + var_280_17 and arg_277_1.time_ < var_280_16 + var_280_17 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.actorSpriteComps10094 then
				for iter_280_7, iter_280_8 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_280_8 then
						if arg_277_1.isInRecall_ then
							iter_280_8.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps10094 = nil
			end

			local var_280_23 = 0
			local var_280_24 = 0.5

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_25 = arg_277_1:FormatText(StoryNameCfg[259].name)

				arg_277_1.leftNameTxt_.text = var_280_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_26 = arg_277_1:GetWordFromCfg(413101067)
				local var_280_27 = arg_277_1:FormatText(var_280_26.content)

				arg_277_1.text_.text = var_280_27

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_28 = 20
				local var_280_29 = utf8.len(var_280_27)
				local var_280_30 = var_280_28 <= 0 and var_280_24 or var_280_24 * (var_280_29 / var_280_28)

				if var_280_30 > 0 and var_280_24 < var_280_30 then
					arg_277_1.talkMaxDuration = var_280_30

					if var_280_30 + var_280_23 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_30 + var_280_23
					end
				end

				arg_277_1.text_.text = var_280_27
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101067", "story_v_out_413101.awb") ~= 0 then
					local var_280_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101067", "story_v_out_413101.awb") / 1000

					if var_280_31 + var_280_23 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_31 + var_280_23
					end

					if var_280_26.prefab_name ~= "" and arg_277_1.actors_[var_280_26.prefab_name] ~= nil then
						local var_280_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_26.prefab_name].transform, "story_v_out_413101", "413101067", "story_v_out_413101.awb")

						arg_277_1:RecordAudio("413101067", var_280_32)
						arg_277_1:RecordAudio("413101067", var_280_32)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413101", "413101067", "story_v_out_413101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413101", "413101067", "story_v_out_413101.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_33 = math.max(var_280_24, arg_277_1.talkMaxDuration)

			if var_280_23 <= arg_277_1.time_ and arg_277_1.time_ < var_280_23 + var_280_33 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_23) / var_280_33

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_23 + var_280_33 and arg_277_1.time_ < var_280_23 + var_280_33 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play413101068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413101068
		arg_281_1.duration_ = 5.68

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413101069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10092"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10092 = var_284_0.localPosition
				var_284_0.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10092", 6)

				local var_284_2 = var_284_0.childCount

				for iter_284_0 = 0, var_284_2 - 1 do
					local var_284_3 = var_284_0:GetChild(iter_284_0)

					if var_284_3.name == "" or not string.find(var_284_3.name, "split") then
						var_284_3.gameObject:SetActive(true)
					else
						var_284_3.gameObject:SetActive(false)
					end
				end
			end

			local var_284_4 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_4 then
				local var_284_5 = (arg_281_1.time_ - var_284_1) / var_284_4
				local var_284_6 = Vector3.New(1500, -300, -295)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10092, var_284_6, var_284_5)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_4 and arg_281_1.time_ < var_284_1 + var_284_4 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_284_7 = arg_281_1.actors_["10094"].transform
			local var_284_8 = 0

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.var_.moveOldPos10094 = var_284_7.localPosition
				var_284_7.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10094", 6)

				local var_284_9 = var_284_7.childCount

				for iter_284_1 = 0, var_284_9 - 1 do
					local var_284_10 = var_284_7:GetChild(iter_284_1)

					if var_284_10.name == "" or not string.find(var_284_10.name, "split") then
						var_284_10.gameObject:SetActive(true)
					else
						var_284_10.gameObject:SetActive(false)
					end
				end
			end

			local var_284_11 = 0.001

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_8) / var_284_11
				local var_284_13 = Vector3.New(1500, -340, -414)

				var_284_7.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10094, var_284_13, var_284_12)
			end

			if arg_281_1.time_ >= var_284_8 + var_284_11 and arg_281_1.time_ < var_284_8 + var_284_11 + arg_284_0 then
				var_284_7.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_284_14 = arg_281_1.actors_["10092"]
			local var_284_15 = 0

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 and not isNil(var_284_14) and arg_281_1.var_.actorSpriteComps10092 == nil then
				arg_281_1.var_.actorSpriteComps10092 = var_284_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_16 = 2

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_16 and not isNil(var_284_14) then
				local var_284_17 = (arg_281_1.time_ - var_284_15) / var_284_16

				if arg_281_1.var_.actorSpriteComps10092 then
					for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_284_3 then
							if arg_281_1.isInRecall_ then
								local var_284_18 = Mathf.Lerp(iter_284_3.color.r, arg_281_1.hightColor2.r, var_284_17)
								local var_284_19 = Mathf.Lerp(iter_284_3.color.g, arg_281_1.hightColor2.g, var_284_17)
								local var_284_20 = Mathf.Lerp(iter_284_3.color.b, arg_281_1.hightColor2.b, var_284_17)

								iter_284_3.color = Color.New(var_284_18, var_284_19, var_284_20)
							else
								local var_284_21 = Mathf.Lerp(iter_284_3.color.r, 0.5, var_284_17)

								iter_284_3.color = Color.New(var_284_21, var_284_21, var_284_21)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_15 + var_284_16 and arg_281_1.time_ < var_284_15 + var_284_16 + arg_284_0 and not isNil(var_284_14) and arg_281_1.var_.actorSpriteComps10092 then
				for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_284_5 then
						if arg_281_1.isInRecall_ then
							iter_284_5.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10092 = nil
			end

			local var_284_22 = arg_281_1.actors_["10094"]
			local var_284_23 = 0

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.actorSpriteComps10094 == nil then
				arg_281_1.var_.actorSpriteComps10094 = var_284_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_24 = 2

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_24 and not isNil(var_284_22) then
				local var_284_25 = (arg_281_1.time_ - var_284_23) / var_284_24

				if arg_281_1.var_.actorSpriteComps10094 then
					for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_284_7 then
							if arg_281_1.isInRecall_ then
								local var_284_26 = Mathf.Lerp(iter_284_7.color.r, arg_281_1.hightColor2.r, var_284_25)
								local var_284_27 = Mathf.Lerp(iter_284_7.color.g, arg_281_1.hightColor2.g, var_284_25)
								local var_284_28 = Mathf.Lerp(iter_284_7.color.b, arg_281_1.hightColor2.b, var_284_25)

								iter_284_7.color = Color.New(var_284_26, var_284_27, var_284_28)
							else
								local var_284_29 = Mathf.Lerp(iter_284_7.color.r, 0.5, var_284_25)

								iter_284_7.color = Color.New(var_284_29, var_284_29, var_284_29)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_23 + var_284_24 and arg_281_1.time_ < var_284_23 + var_284_24 + arg_284_0 and not isNil(var_284_22) and arg_281_1.var_.actorSpriteComps10094 then
				for iter_284_8, iter_284_9 in pairs(arg_281_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_284_9 then
						if arg_281_1.isInRecall_ then
							iter_284_9.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps10094 = nil
			end

			local var_284_30 = manager.ui.mainCamera.transform
			local var_284_31 = 0.2

			if var_284_31 < arg_281_1.time_ and arg_281_1.time_ <= var_284_31 + arg_284_0 then
				arg_281_1.var_.shakeOldPos = var_284_30.localPosition
			end

			local var_284_32 = 0.566666666666667

			if var_284_31 <= arg_281_1.time_ and arg_281_1.time_ < var_284_31 + var_284_32 then
				local var_284_33 = (arg_281_1.time_ - var_284_31) / 0.066
				local var_284_34, var_284_35 = math.modf(var_284_33)

				var_284_30.localPosition = Vector3.New(var_284_35 * 0.13, var_284_35 * 0.13, var_284_35 * 0.13) + arg_281_1.var_.shakeOldPos
			end

			if arg_281_1.time_ >= var_284_31 + var_284_32 and arg_281_1.time_ < var_284_31 + var_284_32 + arg_284_0 then
				var_284_30.localPosition = arg_281_1.var_.shakeOldPos
			end

			local var_284_36 = 0

			if var_284_36 < arg_281_1.time_ and arg_281_1.time_ <= var_284_36 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = false

				arg_281_1:SetGaussion(false)
			end

			local var_284_37 = 0.3

			if var_284_36 <= arg_281_1.time_ and arg_281_1.time_ < var_284_36 + var_284_37 then
				local var_284_38 = (arg_281_1.time_ - var_284_36) / var_284_37
				local var_284_39 = Color.New(1, 1, 1)

				var_284_39.a = Mathf.Lerp(1, 0, var_284_38)
				arg_281_1.mask_.color = var_284_39
			end

			if arg_281_1.time_ >= var_284_36 + var_284_37 and arg_281_1.time_ < var_284_36 + var_284_37 + arg_284_0 then
				local var_284_40 = Color.New(1, 1, 1)
				local var_284_41 = 0

				arg_281_1.mask_.enabled = false
				var_284_40.a = var_284_41
				arg_281_1.mask_.color = var_284_40
			end

			local var_284_42 = 0
			local var_284_43 = 1

			if var_284_42 < arg_281_1.time_ and arg_281_1.time_ <= var_284_42 + arg_284_0 then
				local var_284_44 = "play"
				local var_284_45 = "effect"

				arg_281_1:AudioAction(var_284_44, var_284_45, "se_story", "se_story_quake", "")
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_46 = 0.675
			local var_284_47 = 1.325

			if var_284_46 < arg_281_1.time_ and arg_281_1.time_ <= var_284_46 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_48 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_48:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_49 = arg_281_1:GetWordFromCfg(413101068)
				local var_284_50 = arg_281_1:FormatText(var_284_49.content)

				arg_281_1.text_.text = var_284_50

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_51 = 53
				local var_284_52 = utf8.len(var_284_50)
				local var_284_53 = var_284_51 <= 0 and var_284_47 or var_284_47 * (var_284_52 / var_284_51)

				if var_284_53 > 0 and var_284_47 < var_284_53 then
					arg_281_1.talkMaxDuration = var_284_53
					var_284_46 = var_284_46 + 0.3

					if var_284_53 + var_284_46 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_53 + var_284_46
					end
				end

				arg_281_1.text_.text = var_284_50
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_54 = var_284_46 + 0.3
			local var_284_55 = math.max(var_284_47, arg_281_1.talkMaxDuration)

			if var_284_54 <= arg_281_1.time_ and arg_281_1.time_ < var_284_54 + var_284_55 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_54) / var_284_55

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_54 + var_284_55 and arg_281_1.time_ < var_284_54 + var_284_55 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play413101069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413101069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play413101070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 1

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				local var_290_2 = "play"
				local var_290_3 = "effect"

				arg_287_1:AudioAction(var_290_2, var_290_3, "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_290_4 = 0
			local var_290_5 = 1.375

			if var_290_4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(413101069)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_8 = 55
				local var_290_9 = utf8.len(var_290_7)
				local var_290_10 = var_290_8 <= 0 and var_290_5 or var_290_5 * (var_290_9 / var_290_8)

				if var_290_10 > 0 and var_290_5 < var_290_10 then
					arg_287_1.talkMaxDuration = var_290_10

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_11 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_11 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_11

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_11 and arg_287_1.time_ < var_290_4 + var_290_11 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play413101070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413101070
		arg_291_1.duration_ = 5.63

		local var_291_0 = {
			zh = 2.6,
			ja = 5.633
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
				arg_291_0:Play413101071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10094"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos10094 = var_294_0.localPosition
				var_294_0.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10094", 3)

				local var_294_2 = var_294_0.childCount

				for iter_294_0 = 0, var_294_2 - 1 do
					local var_294_3 = var_294_0:GetChild(iter_294_0)

					if var_294_3.name == "split_2" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_4 then
				local var_294_5 = (arg_291_1.time_ - var_294_1) / var_294_4
				local var_294_6 = Vector3.New(0, -340, -414)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10094, var_294_6, var_294_5)
			end

			if arg_291_1.time_ >= var_294_1 + var_294_4 and arg_291_1.time_ < var_294_1 + var_294_4 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_294_7 = arg_291_1.actors_["10094"]
			local var_294_8 = 0

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps10094 == nil then
				arg_291_1.var_.actorSpriteComps10094 = var_294_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_9 = 2

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_9 and not isNil(var_294_7) then
				local var_294_10 = (arg_291_1.time_ - var_294_8) / var_294_9

				if arg_291_1.var_.actorSpriteComps10094 then
					for iter_294_1, iter_294_2 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_294_2 then
							if arg_291_1.isInRecall_ then
								local var_294_11 = Mathf.Lerp(iter_294_2.color.r, arg_291_1.hightColor1.r, var_294_10)
								local var_294_12 = Mathf.Lerp(iter_294_2.color.g, arg_291_1.hightColor1.g, var_294_10)
								local var_294_13 = Mathf.Lerp(iter_294_2.color.b, arg_291_1.hightColor1.b, var_294_10)

								iter_294_2.color = Color.New(var_294_11, var_294_12, var_294_13)
							else
								local var_294_14 = Mathf.Lerp(iter_294_2.color.r, 1, var_294_10)

								iter_294_2.color = Color.New(var_294_14, var_294_14, var_294_14)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_8 + var_294_9 and arg_291_1.time_ < var_294_8 + var_294_9 + arg_294_0 and not isNil(var_294_7) and arg_291_1.var_.actorSpriteComps10094 then
				for iter_294_3, iter_294_4 in pairs(arg_291_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_294_4 then
						if arg_291_1.isInRecall_ then
							iter_294_4.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10094 = nil
			end

			local var_294_15 = 0
			local var_294_16 = 0.325

			if var_294_15 < arg_291_1.time_ and arg_291_1.time_ <= var_294_15 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_17 = arg_291_1:FormatText(StoryNameCfg[259].name)

				arg_291_1.leftNameTxt_.text = var_294_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_18 = arg_291_1:GetWordFromCfg(413101070)
				local var_294_19 = arg_291_1:FormatText(var_294_18.content)

				arg_291_1.text_.text = var_294_19

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_20 = 13
				local var_294_21 = utf8.len(var_294_19)
				local var_294_22 = var_294_20 <= 0 and var_294_16 or var_294_16 * (var_294_21 / var_294_20)

				if var_294_22 > 0 and var_294_16 < var_294_22 then
					arg_291_1.talkMaxDuration = var_294_22

					if var_294_22 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_22 + var_294_15
					end
				end

				arg_291_1.text_.text = var_294_19
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101070", "story_v_out_413101.awb") ~= 0 then
					local var_294_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101070", "story_v_out_413101.awb") / 1000

					if var_294_23 + var_294_15 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_15
					end

					if var_294_18.prefab_name ~= "" and arg_291_1.actors_[var_294_18.prefab_name] ~= nil then
						local var_294_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_18.prefab_name].transform, "story_v_out_413101", "413101070", "story_v_out_413101.awb")

						arg_291_1:RecordAudio("413101070", var_294_24)
						arg_291_1:RecordAudio("413101070", var_294_24)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413101", "413101070", "story_v_out_413101.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413101", "413101070", "story_v_out_413101.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_25 = math.max(var_294_16, arg_291_1.talkMaxDuration)

			if var_294_15 <= arg_291_1.time_ and arg_291_1.time_ < var_294_15 + var_294_25 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_15) / var_294_25

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_15 + var_294_25 and arg_291_1.time_ < var_294_15 + var_294_25 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play413101071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413101071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play413101072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10094"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10094 = var_298_0.localPosition
				var_298_0.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10094", 6)

				local var_298_2 = var_298_0.childCount

				for iter_298_0 = 0, var_298_2 - 1 do
					local var_298_3 = var_298_0:GetChild(iter_298_0)

					if var_298_3.name == "" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_4 then
				local var_298_5 = (arg_295_1.time_ - var_298_1) / var_298_4
				local var_298_6 = Vector3.New(1500, -340, -414)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10094, var_298_6, var_298_5)
			end

			if arg_295_1.time_ >= var_298_1 + var_298_4 and arg_295_1.time_ < var_298_1 + var_298_4 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_298_7 = arg_295_1.actors_["10094"]
			local var_298_8 = 0

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 and not isNil(var_298_7) and arg_295_1.var_.actorSpriteComps10094 == nil then
				arg_295_1.var_.actorSpriteComps10094 = var_298_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_9 = 2

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_9 and not isNil(var_298_7) then
				local var_298_10 = (arg_295_1.time_ - var_298_8) / var_298_9

				if arg_295_1.var_.actorSpriteComps10094 then
					for iter_298_1, iter_298_2 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_298_2 then
							if arg_295_1.isInRecall_ then
								local var_298_11 = Mathf.Lerp(iter_298_2.color.r, arg_295_1.hightColor2.r, var_298_10)
								local var_298_12 = Mathf.Lerp(iter_298_2.color.g, arg_295_1.hightColor2.g, var_298_10)
								local var_298_13 = Mathf.Lerp(iter_298_2.color.b, arg_295_1.hightColor2.b, var_298_10)

								iter_298_2.color = Color.New(var_298_11, var_298_12, var_298_13)
							else
								local var_298_14 = Mathf.Lerp(iter_298_2.color.r, 0.5, var_298_10)

								iter_298_2.color = Color.New(var_298_14, var_298_14, var_298_14)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_8 + var_298_9 and arg_295_1.time_ < var_298_8 + var_298_9 + arg_298_0 and not isNil(var_298_7) and arg_295_1.var_.actorSpriteComps10094 then
				for iter_298_3, iter_298_4 in pairs(arg_295_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_298_4 then
						if arg_295_1.isInRecall_ then
							iter_298_4.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10094 = nil
			end

			local var_298_15 = 0
			local var_298_16 = 1.425

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_17 = arg_295_1:GetWordFromCfg(413101071)
				local var_298_18 = arg_295_1:FormatText(var_298_17.content)

				arg_295_1.text_.text = var_298_18

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_19 = 57
				local var_298_20 = utf8.len(var_298_18)
				local var_298_21 = var_298_19 <= 0 and var_298_16 or var_298_16 * (var_298_20 / var_298_19)

				if var_298_21 > 0 and var_298_16 < var_298_21 then
					arg_295_1.talkMaxDuration = var_298_21

					if var_298_21 + var_298_15 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_21 + var_298_15
					end
				end

				arg_295_1.text_.text = var_298_18
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_22 = math.max(var_298_16, arg_295_1.talkMaxDuration)

			if var_298_15 <= arg_295_1.time_ and arg_295_1.time_ < var_298_15 + var_298_22 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_15) / var_298_22

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_15 + var_298_22 and arg_295_1.time_ < var_298_15 + var_298_22 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play413101072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413101072
		arg_299_1.duration_ = 2.53

		local var_299_0 = {
			zh = 2.533,
			ja = 1.999999999999
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
				arg_299_0:Play413101073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10092"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos10092 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10092", 3)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "split_1_1" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(0, -300, -295)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10092, var_302_6, var_302_5)
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_302_7 = arg_299_1.actors_["10092"]
			local var_302_8 = 0

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps10092 == nil then
				arg_299_1.var_.actorSpriteComps10092 = var_302_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_9 = 2

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_9 and not isNil(var_302_7) then
				local var_302_10 = (arg_299_1.time_ - var_302_8) / var_302_9

				if arg_299_1.var_.actorSpriteComps10092 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_299_1.time_ >= var_302_8 + var_302_9 and arg_299_1.time_ < var_302_8 + var_302_9 + arg_302_0 and not isNil(var_302_7) and arg_299_1.var_.actorSpriteComps10092 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_302_4 then
						if arg_299_1.isInRecall_ then
							iter_302_4.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10092 = nil
			end

			local var_302_15 = 0
			local var_302_16 = 0.375

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[996].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(413101072)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101072", "story_v_out_413101.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101072", "story_v_out_413101.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_413101", "413101072", "story_v_out_413101.awb")

						arg_299_1:RecordAudio("413101072", var_302_24)
						arg_299_1:RecordAudio("413101072", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413101", "413101072", "story_v_out_413101.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413101", "413101072", "story_v_out_413101.awb")
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
				actorName = "10092",
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
	Play413101073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413101073
		arg_303_1.duration_ = 4.63

		local var_303_0 = {
			zh = 4.3,
			ja = 4.633
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
				arg_303_0:Play413101074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10092"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos10092 = var_306_0.localPosition
				var_306_0.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10092", 2)

				local var_306_2 = var_306_0.childCount

				for iter_306_0 = 0, var_306_2 - 1 do
					local var_306_3 = var_306_0:GetChild(iter_306_0)

					if var_306_3.name == "split_1_1" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_4 then
				local var_306_5 = (arg_303_1.time_ - var_306_1) / var_306_4
				local var_306_6 = Vector3.New(-389.49, -300, -295)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10092, var_306_6, var_306_5)
			end

			if arg_303_1.time_ >= var_306_1 + var_306_4 and arg_303_1.time_ < var_306_1 + var_306_4 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_306_7 = arg_303_1.actors_["10022"].transform
			local var_306_8 = 0

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.var_.moveOldPos10022 = var_306_7.localPosition
				var_306_7.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10022", 4)

				local var_306_9 = var_306_7.childCount

				for iter_306_1 = 0, var_306_9 - 1 do
					local var_306_10 = var_306_7:GetChild(iter_306_1)

					if var_306_10.name == "split_6" or not string.find(var_306_10.name, "split") then
						var_306_10.gameObject:SetActive(true)
					else
						var_306_10.gameObject:SetActive(false)
					end
				end
			end

			local var_306_11 = 0.001

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_11 then
				local var_306_12 = (arg_303_1.time_ - var_306_8) / var_306_11
				local var_306_13 = Vector3.New(390, -315, -320)

				var_306_7.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10022, var_306_13, var_306_12)
			end

			if arg_303_1.time_ >= var_306_8 + var_306_11 and arg_303_1.time_ < var_306_8 + var_306_11 + arg_306_0 then
				var_306_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_306_14 = arg_303_1.actors_["10092"]
			local var_306_15 = 0

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 and not isNil(var_306_14) and arg_303_1.var_.actorSpriteComps10092 == nil then
				arg_303_1.var_.actorSpriteComps10092 = var_306_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_16 = 2

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_16 and not isNil(var_306_14) then
				local var_306_17 = (arg_303_1.time_ - var_306_15) / var_306_16

				if arg_303_1.var_.actorSpriteComps10092 then
					for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_306_3 then
							if arg_303_1.isInRecall_ then
								local var_306_18 = Mathf.Lerp(iter_306_3.color.r, arg_303_1.hightColor2.r, var_306_17)
								local var_306_19 = Mathf.Lerp(iter_306_3.color.g, arg_303_1.hightColor2.g, var_306_17)
								local var_306_20 = Mathf.Lerp(iter_306_3.color.b, arg_303_1.hightColor2.b, var_306_17)

								iter_306_3.color = Color.New(var_306_18, var_306_19, var_306_20)
							else
								local var_306_21 = Mathf.Lerp(iter_306_3.color.r, 0.5, var_306_17)

								iter_306_3.color = Color.New(var_306_21, var_306_21, var_306_21)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_15 + var_306_16 and arg_303_1.time_ < var_306_15 + var_306_16 + arg_306_0 and not isNil(var_306_14) and arg_303_1.var_.actorSpriteComps10092 then
				for iter_306_4, iter_306_5 in pairs(arg_303_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_306_5 then
						if arg_303_1.isInRecall_ then
							iter_306_5.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10092 = nil
			end

			local var_306_22 = arg_303_1.actors_["10022"]
			local var_306_23 = 0

			if var_306_23 < arg_303_1.time_ and arg_303_1.time_ <= var_306_23 + arg_306_0 and not isNil(var_306_22) and arg_303_1.var_.actorSpriteComps10022 == nil then
				arg_303_1.var_.actorSpriteComps10022 = var_306_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_24 = 2

			if var_306_23 <= arg_303_1.time_ and arg_303_1.time_ < var_306_23 + var_306_24 and not isNil(var_306_22) then
				local var_306_25 = (arg_303_1.time_ - var_306_23) / var_306_24

				if arg_303_1.var_.actorSpriteComps10022 then
					for iter_306_6, iter_306_7 in pairs(arg_303_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_306_7 then
							if arg_303_1.isInRecall_ then
								local var_306_26 = Mathf.Lerp(iter_306_7.color.r, arg_303_1.hightColor1.r, var_306_25)
								local var_306_27 = Mathf.Lerp(iter_306_7.color.g, arg_303_1.hightColor1.g, var_306_25)
								local var_306_28 = Mathf.Lerp(iter_306_7.color.b, arg_303_1.hightColor1.b, var_306_25)

								iter_306_7.color = Color.New(var_306_26, var_306_27, var_306_28)
							else
								local var_306_29 = Mathf.Lerp(iter_306_7.color.r, 1, var_306_25)

								iter_306_7.color = Color.New(var_306_29, var_306_29, var_306_29)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_23 + var_306_24 and arg_303_1.time_ < var_306_23 + var_306_24 + arg_306_0 and not isNil(var_306_22) and arg_303_1.var_.actorSpriteComps10022 then
				for iter_306_8, iter_306_9 in pairs(arg_303_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_306_9 then
						if arg_303_1.isInRecall_ then
							iter_306_9.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10022 = nil
			end

			local var_306_30 = 0
			local var_306_31 = 0.525

			if var_306_30 < arg_303_1.time_ and arg_303_1.time_ <= var_306_30 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_32 = arg_303_1:FormatText(StoryNameCfg[614].name)

				arg_303_1.leftNameTxt_.text = var_306_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_33 = arg_303_1:GetWordFromCfg(413101073)
				local var_306_34 = arg_303_1:FormatText(var_306_33.content)

				arg_303_1.text_.text = var_306_34

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_35 = 21
				local var_306_36 = utf8.len(var_306_34)
				local var_306_37 = var_306_35 <= 0 and var_306_31 or var_306_31 * (var_306_36 / var_306_35)

				if var_306_37 > 0 and var_306_31 < var_306_37 then
					arg_303_1.talkMaxDuration = var_306_37

					if var_306_37 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_37 + var_306_30
					end
				end

				arg_303_1.text_.text = var_306_34
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101073", "story_v_out_413101.awb") ~= 0 then
					local var_306_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101073", "story_v_out_413101.awb") / 1000

					if var_306_38 + var_306_30 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_38 + var_306_30
					end

					if var_306_33.prefab_name ~= "" and arg_303_1.actors_[var_306_33.prefab_name] ~= nil then
						local var_306_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_33.prefab_name].transform, "story_v_out_413101", "413101073", "story_v_out_413101.awb")

						arg_303_1:RecordAudio("413101073", var_306_39)
						arg_303_1:RecordAudio("413101073", var_306_39)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413101", "413101073", "story_v_out_413101.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413101", "413101073", "story_v_out_413101.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_40 = math.max(var_306_31, arg_303_1.talkMaxDuration)

			if var_306_30 <= arg_303_1.time_ and arg_303_1.time_ < var_306_30 + var_306_40 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_30) / var_306_40

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_30 + var_306_40 and arg_303_1.time_ < var_306_30 + var_306_40 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play413101074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413101074
		arg_307_1.duration_ = 5.37

		local var_307_0 = {
			zh = 2.866,
			ja = 5.366
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
				arg_307_0:Play413101075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10092"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10092 == nil then
				arg_307_1.var_.actorSpriteComps10092 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10092 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10092 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10092 = nil
			end

			local var_310_8 = arg_307_1.actors_["10022"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10022 == nil then
				arg_307_1.var_.actorSpriteComps10022 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps10022 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								local var_310_12 = Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor2.r, var_310_11)
								local var_310_13 = Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor2.g, var_310_11)
								local var_310_14 = Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor2.b, var_310_11)

								iter_310_5.color = Color.New(var_310_12, var_310_13, var_310_14)
							else
								local var_310_15 = Mathf.Lerp(iter_310_5.color.r, 0.5, var_310_11)

								iter_310_5.color = Color.New(var_310_15, var_310_15, var_310_15)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10022 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10022 = nil
			end

			local var_310_16 = 0
			local var_310_17 = 0.425

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_18 = arg_307_1:FormatText(StoryNameCfg[996].name)

				arg_307_1.leftNameTxt_.text = var_310_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_19 = arg_307_1:GetWordFromCfg(413101074)
				local var_310_20 = arg_307_1:FormatText(var_310_19.content)

				arg_307_1.text_.text = var_310_20

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_21 = 17
				local var_310_22 = utf8.len(var_310_20)
				local var_310_23 = var_310_21 <= 0 and var_310_17 or var_310_17 * (var_310_22 / var_310_21)

				if var_310_23 > 0 and var_310_17 < var_310_23 then
					arg_307_1.talkMaxDuration = var_310_23

					if var_310_23 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_16
					end
				end

				arg_307_1.text_.text = var_310_20
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101074", "story_v_out_413101.awb") ~= 0 then
					local var_310_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101074", "story_v_out_413101.awb") / 1000

					if var_310_24 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_16
					end

					if var_310_19.prefab_name ~= "" and arg_307_1.actors_[var_310_19.prefab_name] ~= nil then
						local var_310_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_19.prefab_name].transform, "story_v_out_413101", "413101074", "story_v_out_413101.awb")

						arg_307_1:RecordAudio("413101074", var_310_25)
						arg_307_1:RecordAudio("413101074", var_310_25)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413101", "413101074", "story_v_out_413101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413101", "413101074", "story_v_out_413101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_26 = math.max(var_310_17, arg_307_1.talkMaxDuration)

			if var_310_16 <= arg_307_1.time_ and arg_307_1.time_ < var_310_16 + var_310_26 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_16) / var_310_26

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_16 + var_310_26 and arg_307_1.time_ < var_310_16 + var_310_26 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play413101075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 413101075
		arg_311_1.duration_ = 3.33

		local var_311_0 = {
			zh = 2.366,
			ja = 3.333
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play413101076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10092"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10092 == nil then
				arg_311_1.var_.actorSpriteComps10092 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps10092 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10092 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10092 = nil
			end

			local var_314_8 = arg_311_1.actors_["10022"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10022 == nil then
				arg_311_1.var_.actorSpriteComps10022 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps10022 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor1.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor1.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor1.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 1, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps10022 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10022 = nil
			end

			local var_314_16 = 0
			local var_314_17 = 0.425

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_18 = arg_311_1:FormatText(StoryNameCfg[614].name)

				arg_311_1.leftNameTxt_.text = var_314_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(413101075)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_21 = 17
				local var_314_22 = utf8.len(var_314_20)
				local var_314_23 = var_314_21 <= 0 and var_314_17 or var_314_17 * (var_314_22 / var_314_21)

				if var_314_23 > 0 and var_314_17 < var_314_23 then
					arg_311_1.talkMaxDuration = var_314_23

					if var_314_23 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_16
					end
				end

				arg_311_1.text_.text = var_314_20
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101075", "story_v_out_413101.awb") ~= 0 then
					local var_314_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101075", "story_v_out_413101.awb") / 1000

					if var_314_24 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_24 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_413101", "413101075", "story_v_out_413101.awb")

						arg_311_1:RecordAudio("413101075", var_314_25)
						arg_311_1:RecordAudio("413101075", var_314_25)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_413101", "413101075", "story_v_out_413101.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_413101", "413101075", "story_v_out_413101.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_26 = math.max(var_314_17, arg_311_1.talkMaxDuration)

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_26 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_16) / var_314_26

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_16 + var_314_26 and arg_311_1.time_ < var_314_16 + var_314_26 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play413101076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413101076
		arg_315_1.duration_ = 7.77

		local var_315_0 = {
			zh = 4.5,
			ja = 7.766
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play413101077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.7

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[614].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(413101076)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 28
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101076", "story_v_out_413101.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101076", "story_v_out_413101.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_413101", "413101076", "story_v_out_413101.awb")

						arg_315_1:RecordAudio("413101076", var_318_9)
						arg_315_1:RecordAudio("413101076", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413101", "413101076", "story_v_out_413101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413101", "413101076", "story_v_out_413101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play413101077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413101077
		arg_319_1.duration_ = 9.7

		local var_319_0 = {
			zh = 3.966,
			ja = 9.7
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
				arg_319_0:Play413101078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10092"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos10092 = var_322_0.localPosition
				var_322_0.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10092", 2)

				local var_322_2 = var_322_0.childCount

				for iter_322_0 = 0, var_322_2 - 1 do
					local var_322_3 = var_322_0:GetChild(iter_322_0)

					if var_322_3.name == "split_1_1" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_4 then
				local var_322_5 = (arg_319_1.time_ - var_322_1) / var_322_4
				local var_322_6 = Vector3.New(-389.49, -300, -295)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10092, var_322_6, var_322_5)
			end

			if arg_319_1.time_ >= var_322_1 + var_322_4 and arg_319_1.time_ < var_322_1 + var_322_4 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_322_7 = arg_319_1.actors_["10022"].transform
			local var_322_8 = 0

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.var_.moveOldPos10022 = var_322_7.localPosition
				var_322_7.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10022", 4)

				local var_322_9 = var_322_7.childCount

				for iter_322_1 = 0, var_322_9 - 1 do
					local var_322_10 = var_322_7:GetChild(iter_322_1)

					if var_322_10.name == "" or not string.find(var_322_10.name, "split") then
						var_322_10.gameObject:SetActive(true)
					else
						var_322_10.gameObject:SetActive(false)
					end
				end
			end

			local var_322_11 = 0.001

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_11 then
				local var_322_12 = (arg_319_1.time_ - var_322_8) / var_322_11
				local var_322_13 = Vector3.New(390, -315, -320)

				var_322_7.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10022, var_322_13, var_322_12)
			end

			if arg_319_1.time_ >= var_322_8 + var_322_11 and arg_319_1.time_ < var_322_8 + var_322_11 + arg_322_0 then
				var_322_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_322_14 = arg_319_1.actors_["10092"]
			local var_322_15 = 0

			if var_322_15 < arg_319_1.time_ and arg_319_1.time_ <= var_322_15 + arg_322_0 and not isNil(var_322_14) and arg_319_1.var_.actorSpriteComps10092 == nil then
				arg_319_1.var_.actorSpriteComps10092 = var_322_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_16 = 2

			if var_322_15 <= arg_319_1.time_ and arg_319_1.time_ < var_322_15 + var_322_16 and not isNil(var_322_14) then
				local var_322_17 = (arg_319_1.time_ - var_322_15) / var_322_16

				if arg_319_1.var_.actorSpriteComps10092 then
					for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_322_3 then
							if arg_319_1.isInRecall_ then
								local var_322_18 = Mathf.Lerp(iter_322_3.color.r, arg_319_1.hightColor1.r, var_322_17)
								local var_322_19 = Mathf.Lerp(iter_322_3.color.g, arg_319_1.hightColor1.g, var_322_17)
								local var_322_20 = Mathf.Lerp(iter_322_3.color.b, arg_319_1.hightColor1.b, var_322_17)

								iter_322_3.color = Color.New(var_322_18, var_322_19, var_322_20)
							else
								local var_322_21 = Mathf.Lerp(iter_322_3.color.r, 1, var_322_17)

								iter_322_3.color = Color.New(var_322_21, var_322_21, var_322_21)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_15 + var_322_16 and arg_319_1.time_ < var_322_15 + var_322_16 + arg_322_0 and not isNil(var_322_14) and arg_319_1.var_.actorSpriteComps10092 then
				for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_322_5 then
						if arg_319_1.isInRecall_ then
							iter_322_5.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10092 = nil
			end

			local var_322_22 = arg_319_1.actors_["10022"]
			local var_322_23 = 0

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 and not isNil(var_322_22) and arg_319_1.var_.actorSpriteComps10022 == nil then
				arg_319_1.var_.actorSpriteComps10022 = var_322_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_24 = 2

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_24 and not isNil(var_322_22) then
				local var_322_25 = (arg_319_1.time_ - var_322_23) / var_322_24

				if arg_319_1.var_.actorSpriteComps10022 then
					for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_322_7 then
							if arg_319_1.isInRecall_ then
								local var_322_26 = Mathf.Lerp(iter_322_7.color.r, arg_319_1.hightColor2.r, var_322_25)
								local var_322_27 = Mathf.Lerp(iter_322_7.color.g, arg_319_1.hightColor2.g, var_322_25)
								local var_322_28 = Mathf.Lerp(iter_322_7.color.b, arg_319_1.hightColor2.b, var_322_25)

								iter_322_7.color = Color.New(var_322_26, var_322_27, var_322_28)
							else
								local var_322_29 = Mathf.Lerp(iter_322_7.color.r, 0.5, var_322_25)

								iter_322_7.color = Color.New(var_322_29, var_322_29, var_322_29)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_23 + var_322_24 and arg_319_1.time_ < var_322_23 + var_322_24 + arg_322_0 and not isNil(var_322_22) and arg_319_1.var_.actorSpriteComps10022 then
				for iter_322_8, iter_322_9 in pairs(arg_319_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_322_9 then
						if arg_319_1.isInRecall_ then
							iter_322_9.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10022 = nil
			end

			local var_322_30 = 0
			local var_322_31 = 0.675

			if var_322_30 < arg_319_1.time_ and arg_319_1.time_ <= var_322_30 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_32 = arg_319_1:FormatText(StoryNameCfg[996].name)

				arg_319_1.leftNameTxt_.text = var_322_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_33 = arg_319_1:GetWordFromCfg(413101077)
				local var_322_34 = arg_319_1:FormatText(var_322_33.content)

				arg_319_1.text_.text = var_322_34

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_35 = 27
				local var_322_36 = utf8.len(var_322_34)
				local var_322_37 = var_322_35 <= 0 and var_322_31 or var_322_31 * (var_322_36 / var_322_35)

				if var_322_37 > 0 and var_322_31 < var_322_37 then
					arg_319_1.talkMaxDuration = var_322_37

					if var_322_37 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_37 + var_322_30
					end
				end

				arg_319_1.text_.text = var_322_34
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101077", "story_v_out_413101.awb") ~= 0 then
					local var_322_38 = manager.audio:GetVoiceLength("story_v_out_413101", "413101077", "story_v_out_413101.awb") / 1000

					if var_322_38 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_38 + var_322_30
					end

					if var_322_33.prefab_name ~= "" and arg_319_1.actors_[var_322_33.prefab_name] ~= nil then
						local var_322_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_33.prefab_name].transform, "story_v_out_413101", "413101077", "story_v_out_413101.awb")

						arg_319_1:RecordAudio("413101077", var_322_39)
						arg_319_1:RecordAudio("413101077", var_322_39)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_413101", "413101077", "story_v_out_413101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_413101", "413101077", "story_v_out_413101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_40 = math.max(var_322_31, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_40 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_40

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_40 and arg_319_1.time_ < var_322_30 + var_322_40 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413101078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413101078
		arg_323_1.duration_ = 8.83

		local var_323_0 = {
			zh = 7.3,
			ja = 8.833
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
				arg_323_0:Play413101079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10022"].transform
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.var_.moveOldPos10022 = var_326_0.localPosition
				var_326_0.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10022", 4)

				local var_326_2 = var_326_0.childCount

				for iter_326_0 = 0, var_326_2 - 1 do
					local var_326_3 = var_326_0:GetChild(iter_326_0)

					if var_326_3.name == "split_6" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_4 then
				local var_326_5 = (arg_323_1.time_ - var_326_1) / var_326_4
				local var_326_6 = Vector3.New(390, -315, -320)

				var_326_0.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10022, var_326_6, var_326_5)
			end

			if arg_323_1.time_ >= var_326_1 + var_326_4 and arg_323_1.time_ < var_326_1 + var_326_4 + arg_326_0 then
				var_326_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_326_7 = arg_323_1.actors_["10092"]
			local var_326_8 = 0

			if var_326_8 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps10092 == nil then
				arg_323_1.var_.actorSpriteComps10092 = var_326_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_9 = 2

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_9 and not isNil(var_326_7) then
				local var_326_10 = (arg_323_1.time_ - var_326_8) / var_326_9

				if arg_323_1.var_.actorSpriteComps10092 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								local var_326_11 = Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor2.r, var_326_10)
								local var_326_12 = Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor2.g, var_326_10)
								local var_326_13 = Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor2.b, var_326_10)

								iter_326_2.color = Color.New(var_326_11, var_326_12, var_326_13)
							else
								local var_326_14 = Mathf.Lerp(iter_326_2.color.r, 0.5, var_326_10)

								iter_326_2.color = Color.New(var_326_14, var_326_14, var_326_14)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_8 + var_326_9 and arg_323_1.time_ < var_326_8 + var_326_9 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.actorSpriteComps10092 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_326_4 then
						if arg_323_1.isInRecall_ then
							iter_326_4.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10092 = nil
			end

			local var_326_15 = arg_323_1.actors_["10022"]
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.actorSpriteComps10022 == nil then
				arg_323_1.var_.actorSpriteComps10022 = var_326_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_17 = 2

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_17 and not isNil(var_326_15) then
				local var_326_18 = (arg_323_1.time_ - var_326_16) / var_326_17

				if arg_323_1.var_.actorSpriteComps10022 then
					for iter_326_5, iter_326_6 in pairs(arg_323_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_326_6 then
							if arg_323_1.isInRecall_ then
								local var_326_19 = Mathf.Lerp(iter_326_6.color.r, arg_323_1.hightColor1.r, var_326_18)
								local var_326_20 = Mathf.Lerp(iter_326_6.color.g, arg_323_1.hightColor1.g, var_326_18)
								local var_326_21 = Mathf.Lerp(iter_326_6.color.b, arg_323_1.hightColor1.b, var_326_18)

								iter_326_6.color = Color.New(var_326_19, var_326_20, var_326_21)
							else
								local var_326_22 = Mathf.Lerp(iter_326_6.color.r, 1, var_326_18)

								iter_326_6.color = Color.New(var_326_22, var_326_22, var_326_22)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_16 + var_326_17 and arg_323_1.time_ < var_326_16 + var_326_17 + arg_326_0 and not isNil(var_326_15) and arg_323_1.var_.actorSpriteComps10022 then
				for iter_326_7, iter_326_8 in pairs(arg_323_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_326_8 then
						if arg_323_1.isInRecall_ then
							iter_326_8.color = arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_326_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10022 = nil
			end

			local var_326_23 = 0
			local var_326_24 = 0.9

			if var_326_23 < arg_323_1.time_ and arg_323_1.time_ <= var_326_23 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_25 = arg_323_1:FormatText(StoryNameCfg[614].name)

				arg_323_1.leftNameTxt_.text = var_326_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_26 = arg_323_1:GetWordFromCfg(413101078)
				local var_326_27 = arg_323_1:FormatText(var_326_26.content)

				arg_323_1.text_.text = var_326_27

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_28 = 36
				local var_326_29 = utf8.len(var_326_27)
				local var_326_30 = var_326_28 <= 0 and var_326_24 or var_326_24 * (var_326_29 / var_326_28)

				if var_326_30 > 0 and var_326_24 < var_326_30 then
					arg_323_1.talkMaxDuration = var_326_30

					if var_326_30 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_30 + var_326_23
					end
				end

				arg_323_1.text_.text = var_326_27
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101078", "story_v_out_413101.awb") ~= 0 then
					local var_326_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101078", "story_v_out_413101.awb") / 1000

					if var_326_31 + var_326_23 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_31 + var_326_23
					end

					if var_326_26.prefab_name ~= "" and arg_323_1.actors_[var_326_26.prefab_name] ~= nil then
						local var_326_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_26.prefab_name].transform, "story_v_out_413101", "413101078", "story_v_out_413101.awb")

						arg_323_1:RecordAudio("413101078", var_326_32)
						arg_323_1:RecordAudio("413101078", var_326_32)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413101", "413101078", "story_v_out_413101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413101", "413101078", "story_v_out_413101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_33 = math.max(var_326_24, arg_323_1.talkMaxDuration)

			if var_326_23 <= arg_323_1.time_ and arg_323_1.time_ < var_326_23 + var_326_33 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_23) / var_326_33

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_23 + var_326_33 and arg_323_1.time_ < var_326_23 + var_326_33 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play413101079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413101079
		arg_327_1.duration_ = 8.8

		local var_327_0 = {
			zh = 3.966,
			ja = 8.8
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play413101080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0
			local var_330_1 = 0.575

			if var_330_0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_2 = arg_327_1:FormatText(StoryNameCfg[614].name)

				arg_327_1.leftNameTxt_.text = var_330_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:GetWordFromCfg(413101079)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101079", "story_v_out_413101.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101079", "story_v_out_413101.awb") / 1000

					if var_330_8 + var_330_0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_0
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_out_413101", "413101079", "story_v_out_413101.awb")

						arg_327_1:RecordAudio("413101079", var_330_9)
						arg_327_1:RecordAudio("413101079", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413101", "413101079", "story_v_out_413101.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413101", "413101079", "story_v_out_413101.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_1, arg_327_1.talkMaxDuration)

			if var_330_0 <= arg_327_1.time_ and arg_327_1.time_ < var_330_0 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_0) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_0 + var_330_10 and arg_327_1.time_ < var_330_0 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play413101080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413101080
		arg_331_1.duration_ = 9.33

		local var_331_0 = {
			zh = 6.433,
			ja = 9.333
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play413101081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10092"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos10092 = var_334_0.localPosition
				var_334_0.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10092", 2)

				local var_334_2 = var_334_0.childCount

				for iter_334_0 = 0, var_334_2 - 1 do
					local var_334_3 = var_334_0:GetChild(iter_334_0)

					if var_334_3.name == "split_6" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_4 then
				local var_334_5 = (arg_331_1.time_ - var_334_1) / var_334_4
				local var_334_6 = Vector3.New(-389.49, -300, -295)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10092, var_334_6, var_334_5)
			end

			if arg_331_1.time_ >= var_334_1 + var_334_4 and arg_331_1.time_ < var_334_1 + var_334_4 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_334_7 = arg_331_1.actors_["10092"]
			local var_334_8 = 0

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps10092 == nil then
				arg_331_1.var_.actorSpriteComps10092 = var_334_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_9 = 2

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 and not isNil(var_334_7) then
				local var_334_10 = (arg_331_1.time_ - var_334_8) / var_334_9

				if arg_331_1.var_.actorSpriteComps10092 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_334_2 then
							if arg_331_1.isInRecall_ then
								local var_334_11 = Mathf.Lerp(iter_334_2.color.r, arg_331_1.hightColor1.r, var_334_10)
								local var_334_12 = Mathf.Lerp(iter_334_2.color.g, arg_331_1.hightColor1.g, var_334_10)
								local var_334_13 = Mathf.Lerp(iter_334_2.color.b, arg_331_1.hightColor1.b, var_334_10)

								iter_334_2.color = Color.New(var_334_11, var_334_12, var_334_13)
							else
								local var_334_14 = Mathf.Lerp(iter_334_2.color.r, 1, var_334_10)

								iter_334_2.color = Color.New(var_334_14, var_334_14, var_334_14)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps10092 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_334_4 then
						if arg_331_1.isInRecall_ then
							iter_334_4.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10092 = nil
			end

			local var_334_15 = arg_331_1.actors_["10022"]
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps10022 == nil then
				arg_331_1.var_.actorSpriteComps10022 = var_334_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_17 = 2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 and not isNil(var_334_15) then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17

				if arg_331_1.var_.actorSpriteComps10022 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_334_6 then
							if arg_331_1.isInRecall_ then
								local var_334_19 = Mathf.Lerp(iter_334_6.color.r, arg_331_1.hightColor2.r, var_334_18)
								local var_334_20 = Mathf.Lerp(iter_334_6.color.g, arg_331_1.hightColor2.g, var_334_18)
								local var_334_21 = Mathf.Lerp(iter_334_6.color.b, arg_331_1.hightColor2.b, var_334_18)

								iter_334_6.color = Color.New(var_334_19, var_334_20, var_334_21)
							else
								local var_334_22 = Mathf.Lerp(iter_334_6.color.r, 0.5, var_334_18)

								iter_334_6.color = Color.New(var_334_22, var_334_22, var_334_22)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps10022 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_334_8 then
						if arg_331_1.isInRecall_ then
							iter_334_8.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10022 = nil
			end

			local var_334_23 = 0
			local var_334_24 = 0.825

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_25 = arg_331_1:FormatText(StoryNameCfg[996].name)

				arg_331_1.leftNameTxt_.text = var_334_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_26 = arg_331_1:GetWordFromCfg(413101080)
				local var_334_27 = arg_331_1:FormatText(var_334_26.content)

				arg_331_1.text_.text = var_334_27

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_28 = 33
				local var_334_29 = utf8.len(var_334_27)
				local var_334_30 = var_334_28 <= 0 and var_334_24 or var_334_24 * (var_334_29 / var_334_28)

				if var_334_30 > 0 and var_334_24 < var_334_30 then
					arg_331_1.talkMaxDuration = var_334_30

					if var_334_30 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_30 + var_334_23
					end
				end

				arg_331_1.text_.text = var_334_27
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101080", "story_v_out_413101.awb") ~= 0 then
					local var_334_31 = manager.audio:GetVoiceLength("story_v_out_413101", "413101080", "story_v_out_413101.awb") / 1000

					if var_334_31 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_31 + var_334_23
					end

					if var_334_26.prefab_name ~= "" and arg_331_1.actors_[var_334_26.prefab_name] ~= nil then
						local var_334_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_26.prefab_name].transform, "story_v_out_413101", "413101080", "story_v_out_413101.awb")

						arg_331_1:RecordAudio("413101080", var_334_32)
						arg_331_1:RecordAudio("413101080", var_334_32)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413101", "413101080", "story_v_out_413101.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413101", "413101080", "story_v_out_413101.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_33 = math.max(var_334_24, arg_331_1.talkMaxDuration)

			if var_334_23 <= arg_331_1.time_ and arg_331_1.time_ < var_334_23 + var_334_33 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_23) / var_334_33

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_23 + var_334_33 and arg_331_1.time_ < var_334_23 + var_334_33 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play413101081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413101081
		arg_335_1.duration_ = 9.07

		local var_335_0 = {
			zh = 5.7,
			ja = 9.066
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
				arg_335_0:Play413101082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10092"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10092 == nil then
				arg_335_1.var_.actorSpriteComps10092 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps10092 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 0.5, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10092 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10092 = nil
			end

			local var_338_8 = arg_335_1.actors_["10022"]
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10022 == nil then
				arg_335_1.var_.actorSpriteComps10022 = var_338_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_10 = 2

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_10 and not isNil(var_338_8) then
				local var_338_11 = (arg_335_1.time_ - var_338_9) / var_338_10

				if arg_335_1.var_.actorSpriteComps10022 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								local var_338_12 = Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor1.r, var_338_11)
								local var_338_13 = Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor1.g, var_338_11)
								local var_338_14 = Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor1.b, var_338_11)

								iter_338_5.color = Color.New(var_338_12, var_338_13, var_338_14)
							else
								local var_338_15 = Mathf.Lerp(iter_338_5.color.r, 1, var_338_11)

								iter_338_5.color = Color.New(var_338_15, var_338_15, var_338_15)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_9 + var_338_10 and arg_335_1.time_ < var_338_9 + var_338_10 + arg_338_0 and not isNil(var_338_8) and arg_335_1.var_.actorSpriteComps10022 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_338_7 then
						if arg_335_1.isInRecall_ then
							iter_338_7.color = arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_338_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10022 = nil
			end

			local var_338_16 = 0
			local var_338_17 = 0.8

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_18 = arg_335_1:FormatText(StoryNameCfg[614].name)

				arg_335_1.leftNameTxt_.text = var_338_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_19 = arg_335_1:GetWordFromCfg(413101081)
				local var_338_20 = arg_335_1:FormatText(var_338_19.content)

				arg_335_1.text_.text = var_338_20

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_21 = 32
				local var_338_22 = utf8.len(var_338_20)
				local var_338_23 = var_338_21 <= 0 and var_338_17 or var_338_17 * (var_338_22 / var_338_21)

				if var_338_23 > 0 and var_338_17 < var_338_23 then
					arg_335_1.talkMaxDuration = var_338_23

					if var_338_23 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_16
					end
				end

				arg_335_1.text_.text = var_338_20
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101081", "story_v_out_413101.awb") ~= 0 then
					local var_338_24 = manager.audio:GetVoiceLength("story_v_out_413101", "413101081", "story_v_out_413101.awb") / 1000

					if var_338_24 + var_338_16 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_24 + var_338_16
					end

					if var_338_19.prefab_name ~= "" and arg_335_1.actors_[var_338_19.prefab_name] ~= nil then
						local var_338_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_19.prefab_name].transform, "story_v_out_413101", "413101081", "story_v_out_413101.awb")

						arg_335_1:RecordAudio("413101081", var_338_25)
						arg_335_1:RecordAudio("413101081", var_338_25)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_413101", "413101081", "story_v_out_413101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_413101", "413101081", "story_v_out_413101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_26 = math.max(var_338_17, arg_335_1.talkMaxDuration)

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_26 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_16) / var_338_26

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_16 + var_338_26 and arg_335_1.time_ < var_338_16 + var_338_26 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play413101082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413101082
		arg_339_1.duration_ = 5.93

		local var_339_0 = {
			zh = 5.933,
			ja = 5.466
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play413101083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.8

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[614].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:GetWordFromCfg(413101082)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 32
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101082", "story_v_out_413101.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_413101", "413101082", "story_v_out_413101.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_413101", "413101082", "story_v_out_413101.awb")

						arg_339_1:RecordAudio("413101082", var_342_9)
						arg_339_1:RecordAudio("413101082", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413101", "413101082", "story_v_out_413101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413101", "413101082", "story_v_out_413101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play413101083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413101083
		arg_343_1.duration_ = 7.03

		local var_343_0 = {
			zh = 7.03266666666667,
			ja = 6.83266666666667
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
				arg_343_0:Play413101084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = "F09f"

			if arg_343_1.bgs_[var_346_0] == nil then
				local var_346_1 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_346_0)
				var_346_1.name = var_346_0
				var_346_1.transform.parent = arg_343_1.stage_.transform
				var_346_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_[var_346_0] = var_346_1
			end

			local var_346_2 = 2

			if var_346_2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				local var_346_3 = manager.ui.mainCamera.transform.localPosition
				local var_346_4 = Vector3.New(0, 0, 10) + Vector3.New(var_346_3.x, var_346_3.y, 0)
				local var_346_5 = arg_343_1.bgs_.F09f

				var_346_5.transform.localPosition = var_346_4
				var_346_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_6 = var_346_5:GetComponent("SpriteRenderer")

				if var_346_6 and var_346_6.sprite then
					local var_346_7 = (var_346_5.transform.localPosition - var_346_3).z
					local var_346_8 = manager.ui.mainCameraCom_
					local var_346_9 = 2 * var_346_7 * Mathf.Tan(var_346_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_346_10 = var_346_9 * var_346_8.aspect
					local var_346_11 = var_346_6.sprite.bounds.size.x
					local var_346_12 = var_346_6.sprite.bounds.size.y
					local var_346_13 = var_346_10 / var_346_11
					local var_346_14 = var_346_9 / var_346_12
					local var_346_15 = var_346_14 < var_346_13 and var_346_13 or var_346_14

					var_346_5.transform.localScale = Vector3.New(var_346_15, var_346_15, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "F09f" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_16 = 3.96666666666667

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			local var_346_17 = 0.3

			if arg_343_1.time_ >= var_346_16 + var_346_17 and arg_343_1.time_ < var_346_16 + var_346_17 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_18 = 0

			if var_346_18 < arg_343_1.time_ and arg_343_1.time_ <= var_346_18 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_19 = 2

			if var_346_18 <= arg_343_1.time_ and arg_343_1.time_ < var_346_18 + var_346_19 then
				local var_346_20 = (arg_343_1.time_ - var_346_18) / var_346_19
				local var_346_21 = Color.New(0, 0, 0)

				var_346_21.a = Mathf.Lerp(0, 1, var_346_20)
				arg_343_1.mask_.color = var_346_21
			end

			if arg_343_1.time_ >= var_346_18 + var_346_19 and arg_343_1.time_ < var_346_18 + var_346_19 + arg_346_0 then
				local var_346_22 = Color.New(0, 0, 0)

				var_346_22.a = 1
				arg_343_1.mask_.color = var_346_22
			end

			local var_346_23 = 2

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_24 = 2

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_24 then
				local var_346_25 = (arg_343_1.time_ - var_346_23) / var_346_24
				local var_346_26 = Color.New(0, 0, 0)

				var_346_26.a = Mathf.Lerp(1, 0, var_346_25)
				arg_343_1.mask_.color = var_346_26
			end

			if arg_343_1.time_ >= var_346_23 + var_346_24 and arg_343_1.time_ < var_346_23 + var_346_24 + arg_346_0 then
				local var_346_27 = Color.New(0, 0, 0)
				local var_346_28 = 0

				arg_343_1.mask_.enabled = false
				var_346_27.a = var_346_28
				arg_343_1.mask_.color = var_346_27
			end

			local var_346_29 = arg_343_1.actors_["10092"].transform
			local var_346_30 = 2

			if var_346_30 < arg_343_1.time_ and arg_343_1.time_ <= var_346_30 + arg_346_0 then
				arg_343_1.var_.moveOldPos10092 = var_346_29.localPosition
				var_346_29.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10092", 7)

				local var_346_31 = var_346_29.childCount

				for iter_346_2 = 0, var_346_31 - 1 do
					local var_346_32 = var_346_29:GetChild(iter_346_2)

					if var_346_32.name == "" or not string.find(var_346_32.name, "split") then
						var_346_32.gameObject:SetActive(true)
					else
						var_346_32.gameObject:SetActive(false)
					end
				end
			end

			local var_346_33 = 0.001

			if var_346_30 <= arg_343_1.time_ and arg_343_1.time_ < var_346_30 + var_346_33 then
				local var_346_34 = (arg_343_1.time_ - var_346_30) / var_346_33
				local var_346_35 = Vector3.New(0, -2000, 0)

				var_346_29.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10092, var_346_35, var_346_34)
			end

			if arg_343_1.time_ >= var_346_30 + var_346_33 and arg_343_1.time_ < var_346_30 + var_346_33 + arg_346_0 then
				var_346_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_36 = arg_343_1.actors_["10022"].transform
			local var_346_37 = 2

			if var_346_37 < arg_343_1.time_ and arg_343_1.time_ <= var_346_37 + arg_346_0 then
				arg_343_1.var_.moveOldPos10022 = var_346_36.localPosition
				var_346_36.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10022", 7)

				local var_346_38 = var_346_36.childCount

				for iter_346_3 = 0, var_346_38 - 1 do
					local var_346_39 = var_346_36:GetChild(iter_346_3)

					if var_346_39.name == "" or not string.find(var_346_39.name, "split") then
						var_346_39.gameObject:SetActive(true)
					else
						var_346_39.gameObject:SetActive(false)
					end
				end
			end

			local var_346_40 = 0.001

			if var_346_37 <= arg_343_1.time_ and arg_343_1.time_ < var_346_37 + var_346_40 then
				local var_346_41 = (arg_343_1.time_ - var_346_37) / var_346_40
				local var_346_42 = Vector3.New(0, -2000, 0)

				var_346_36.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10022, var_346_42, var_346_41)
			end

			if arg_343_1.time_ >= var_346_37 + var_346_40 and arg_343_1.time_ < var_346_37 + var_346_40 + arg_346_0 then
				var_346_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_43 = arg_343_1.actors_["10094"].transform
			local var_346_44 = 3.8

			if var_346_44 < arg_343_1.time_ and arg_343_1.time_ <= var_346_44 + arg_346_0 then
				arg_343_1.var_.moveOldPos10094 = var_346_43.localPosition
				var_346_43.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10094", 3)

				local var_346_45 = var_346_43.childCount

				for iter_346_4 = 0, var_346_45 - 1 do
					local var_346_46 = var_346_43:GetChild(iter_346_4)

					if var_346_46.name == "split_5" or not string.find(var_346_46.name, "split") then
						var_346_46.gameObject:SetActive(true)
					else
						var_346_46.gameObject:SetActive(false)
					end
				end
			end

			local var_346_47 = 0.001

			if var_346_44 <= arg_343_1.time_ and arg_343_1.time_ < var_346_44 + var_346_47 then
				local var_346_48 = (arg_343_1.time_ - var_346_44) / var_346_47
				local var_346_49 = Vector3.New(0, -340, -414)

				var_346_43.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10094, var_346_49, var_346_48)
			end

			if arg_343_1.time_ >= var_346_44 + var_346_47 and arg_343_1.time_ < var_346_44 + var_346_47 + arg_346_0 then
				var_346_43.localPosition = Vector3.New(0, -340, -414)
			end

			local var_346_50 = arg_343_1.actors_["10094"]
			local var_346_51 = 3.8

			if var_346_51 < arg_343_1.time_ and arg_343_1.time_ <= var_346_51 + arg_346_0 and not isNil(var_346_50) and arg_343_1.var_.actorSpriteComps10094 == nil then
				arg_343_1.var_.actorSpriteComps10094 = var_346_50:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_52 = 2

			if var_346_51 <= arg_343_1.time_ and arg_343_1.time_ < var_346_51 + var_346_52 and not isNil(var_346_50) then
				local var_346_53 = (arg_343_1.time_ - var_346_51) / var_346_52

				if arg_343_1.var_.actorSpriteComps10094 then
					for iter_346_5, iter_346_6 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_346_6 then
							if arg_343_1.isInRecall_ then
								local var_346_54 = Mathf.Lerp(iter_346_6.color.r, arg_343_1.hightColor1.r, var_346_53)
								local var_346_55 = Mathf.Lerp(iter_346_6.color.g, arg_343_1.hightColor1.g, var_346_53)
								local var_346_56 = Mathf.Lerp(iter_346_6.color.b, arg_343_1.hightColor1.b, var_346_53)

								iter_346_6.color = Color.New(var_346_54, var_346_55, var_346_56)
							else
								local var_346_57 = Mathf.Lerp(iter_346_6.color.r, 1, var_346_53)

								iter_346_6.color = Color.New(var_346_57, var_346_57, var_346_57)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_51 + var_346_52 and arg_343_1.time_ < var_346_51 + var_346_52 + arg_346_0 and not isNil(var_346_50) and arg_343_1.var_.actorSpriteComps10094 then
				for iter_346_7, iter_346_8 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_346_8 then
						if arg_343_1.isInRecall_ then
							iter_346_8.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10094 = nil
			end

			local var_346_58 = arg_343_1.actors_["10094"]
			local var_346_59 = 3.8

			if var_346_59 < arg_343_1.time_ and arg_343_1.time_ <= var_346_59 + arg_346_0 then
				local var_346_60 = var_346_58:GetComponentInChildren(typeof(CanvasGroup))

				if var_346_60 then
					arg_343_1.var_.alphaOldValue10094 = var_346_60.alpha
					arg_343_1.var_.characterEffect10094 = var_346_60
				end

				arg_343_1.var_.alphaOldValue10094 = 0
			end

			local var_346_61 = 0.3

			if var_346_59 <= arg_343_1.time_ and arg_343_1.time_ < var_346_59 + var_346_61 then
				local var_346_62 = (arg_343_1.time_ - var_346_59) / var_346_61
				local var_346_63 = Mathf.Lerp(arg_343_1.var_.alphaOldValue10094, 1, var_346_62)

				if arg_343_1.var_.characterEffect10094 then
					arg_343_1.var_.characterEffect10094.alpha = var_346_63
				end
			end

			if arg_343_1.time_ >= var_346_59 + var_346_61 and arg_343_1.time_ < var_346_59 + var_346_61 + arg_346_0 and arg_343_1.var_.characterEffect10094 then
				arg_343_1.var_.characterEffect10094.alpha = 1
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_64 = 4.26666666666667
			local var_346_65 = 0.325

			if var_346_64 < arg_343_1.time_ and arg_343_1.time_ <= var_346_64 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_66 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_66:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_67 = arg_343_1:FormatText(StoryNameCfg[259].name)

				arg_343_1.leftNameTxt_.text = var_346_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_68 = arg_343_1:GetWordFromCfg(413101083)
				local var_346_69 = arg_343_1:FormatText(var_346_68.content)

				arg_343_1.text_.text = var_346_69

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_70 = 13
				local var_346_71 = utf8.len(var_346_69)
				local var_346_72 = var_346_70 <= 0 and var_346_65 or var_346_65 * (var_346_71 / var_346_70)

				if var_346_72 > 0 and var_346_65 < var_346_72 then
					arg_343_1.talkMaxDuration = var_346_72
					var_346_64 = var_346_64 + 0.3

					if var_346_72 + var_346_64 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_72 + var_346_64
					end
				end

				arg_343_1.text_.text = var_346_69
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101083", "story_v_out_413101.awb") ~= 0 then
					local var_346_73 = manager.audio:GetVoiceLength("story_v_out_413101", "413101083", "story_v_out_413101.awb") / 1000

					if var_346_73 + var_346_64 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_73 + var_346_64
					end

					if var_346_68.prefab_name ~= "" and arg_343_1.actors_[var_346_68.prefab_name] ~= nil then
						local var_346_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_68.prefab_name].transform, "story_v_out_413101", "413101083", "story_v_out_413101.awb")

						arg_343_1:RecordAudio("413101083", var_346_74)
						arg_343_1:RecordAudio("413101083", var_346_74)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413101", "413101083", "story_v_out_413101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413101", "413101083", "story_v_out_413101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_75 = var_346_64 + 0.3
			local var_346_76 = math.max(var_346_65, arg_343_1.talkMaxDuration)

			if var_346_75 <= arg_343_1.time_ and arg_343_1.time_ < var_346_75 + var_346_76 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_75) / var_346_76

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_75 + var_346_76 and arg_343_1.time_ < var_346_75 + var_346_76 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play413101084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 413101084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play413101085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10094"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos10094 = var_352_0.localPosition
				var_352_0.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("10094", 6)

				local var_352_2 = var_352_0.childCount

				for iter_352_0 = 0, var_352_2 - 1 do
					local var_352_3 = var_352_0:GetChild(iter_352_0)

					if var_352_3.name == "" or not string.find(var_352_3.name, "split") then
						var_352_3.gameObject:SetActive(true)
					else
						var_352_3.gameObject:SetActive(false)
					end
				end
			end

			local var_352_4 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_4 then
				local var_352_5 = (arg_349_1.time_ - var_352_1) / var_352_4
				local var_352_6 = Vector3.New(1500, -340, -414)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10094, var_352_6, var_352_5)
			end

			if arg_349_1.time_ >= var_352_1 + var_352_4 and arg_349_1.time_ < var_352_1 + var_352_4 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_352_7 = arg_349_1.actors_["10094"]
			local var_352_8 = 0

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 and not isNil(var_352_7) and arg_349_1.var_.actorSpriteComps10094 == nil then
				arg_349_1.var_.actorSpriteComps10094 = var_352_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_9 = 2

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_9 and not isNil(var_352_7) then
				local var_352_10 = (arg_349_1.time_ - var_352_8) / var_352_9

				if arg_349_1.var_.actorSpriteComps10094 then
					for iter_352_1, iter_352_2 in pairs(arg_349_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_352_2 then
							if arg_349_1.isInRecall_ then
								local var_352_11 = Mathf.Lerp(iter_352_2.color.r, arg_349_1.hightColor2.r, var_352_10)
								local var_352_12 = Mathf.Lerp(iter_352_2.color.g, arg_349_1.hightColor2.g, var_352_10)
								local var_352_13 = Mathf.Lerp(iter_352_2.color.b, arg_349_1.hightColor2.b, var_352_10)

								iter_352_2.color = Color.New(var_352_11, var_352_12, var_352_13)
							else
								local var_352_14 = Mathf.Lerp(iter_352_2.color.r, 0.5, var_352_10)

								iter_352_2.color = Color.New(var_352_14, var_352_14, var_352_14)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_8 + var_352_9 and arg_349_1.time_ < var_352_8 + var_352_9 + arg_352_0 and not isNil(var_352_7) and arg_349_1.var_.actorSpriteComps10094 then
				for iter_352_3, iter_352_4 in pairs(arg_349_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_352_4 then
						if arg_349_1.isInRecall_ then
							iter_352_4.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10094 = nil
			end

			local var_352_15 = 0
			local var_352_16 = 1.325

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_17 = arg_349_1:GetWordFromCfg(413101084)
				local var_352_18 = arg_349_1:FormatText(var_352_17.content)

				arg_349_1.text_.text = var_352_18

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_19 = 53
				local var_352_20 = utf8.len(var_352_18)
				local var_352_21 = var_352_19 <= 0 and var_352_16 or var_352_16 * (var_352_20 / var_352_19)

				if var_352_21 > 0 and var_352_16 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_18
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_22 and arg_349_1.time_ < var_352_15 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play413101085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 413101085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play413101086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1.55

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:GetWordFromCfg(413101085)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 62
				local var_356_5 = utf8.len(var_356_3)
				local var_356_6 = var_356_4 <= 0 and var_356_1 or var_356_1 * (var_356_5 / var_356_4)

				if var_356_6 > 0 and var_356_1 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_7 and arg_353_1.time_ < var_356_0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play413101086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 413101086
		arg_357_1.duration_ = 3.93

		local var_357_0 = {
			zh = 3.433,
			ja = 3.933
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
				arg_357_0:Play413101087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10094"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos10094 = var_360_0.localPosition
				var_360_0.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10094", 3)

				local var_360_2 = var_360_0.childCount

				for iter_360_0 = 0, var_360_2 - 1 do
					local var_360_3 = var_360_0:GetChild(iter_360_0)

					if var_360_3.name == "" or not string.find(var_360_3.name, "split") then
						var_360_3.gameObject:SetActive(true)
					else
						var_360_3.gameObject:SetActive(false)
					end
				end
			end

			local var_360_4 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_4 then
				local var_360_5 = (arg_357_1.time_ - var_360_1) / var_360_4
				local var_360_6 = Vector3.New(0, -340, -414)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10094, var_360_6, var_360_5)
			end

			if arg_357_1.time_ >= var_360_1 + var_360_4 and arg_357_1.time_ < var_360_1 + var_360_4 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_360_7 = arg_357_1.actors_["10094"]
			local var_360_8 = 0

			if var_360_8 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps10094 == nil then
				arg_357_1.var_.actorSpriteComps10094 = var_360_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_9 = 2

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_9 and not isNil(var_360_7) then
				local var_360_10 = (arg_357_1.time_ - var_360_8) / var_360_9

				if arg_357_1.var_.actorSpriteComps10094 then
					for iter_360_1, iter_360_2 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_360_2 then
							if arg_357_1.isInRecall_ then
								local var_360_11 = Mathf.Lerp(iter_360_2.color.r, arg_357_1.hightColor1.r, var_360_10)
								local var_360_12 = Mathf.Lerp(iter_360_2.color.g, arg_357_1.hightColor1.g, var_360_10)
								local var_360_13 = Mathf.Lerp(iter_360_2.color.b, arg_357_1.hightColor1.b, var_360_10)

								iter_360_2.color = Color.New(var_360_11, var_360_12, var_360_13)
							else
								local var_360_14 = Mathf.Lerp(iter_360_2.color.r, 1, var_360_10)

								iter_360_2.color = Color.New(var_360_14, var_360_14, var_360_14)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_8 + var_360_9 and arg_357_1.time_ < var_360_8 + var_360_9 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.actorSpriteComps10094 then
				for iter_360_3, iter_360_4 in pairs(arg_357_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_360_4 then
						if arg_357_1.isInRecall_ then
							iter_360_4.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10094 = nil
			end

			local var_360_15 = 0
			local var_360_16 = 0.325

			if var_360_15 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_17 = arg_357_1:FormatText(StoryNameCfg[259].name)

				arg_357_1.leftNameTxt_.text = var_360_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_18 = arg_357_1:GetWordFromCfg(413101086)
				local var_360_19 = arg_357_1:FormatText(var_360_18.content)

				arg_357_1.text_.text = var_360_19

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_20 = 13
				local var_360_21 = utf8.len(var_360_19)
				local var_360_22 = var_360_20 <= 0 and var_360_16 or var_360_16 * (var_360_21 / var_360_20)

				if var_360_22 > 0 and var_360_16 < var_360_22 then
					arg_357_1.talkMaxDuration = var_360_22

					if var_360_22 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_22 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_19
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101086", "story_v_out_413101.awb") ~= 0 then
					local var_360_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101086", "story_v_out_413101.awb") / 1000

					if var_360_23 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_23 + var_360_15
					end

					if var_360_18.prefab_name ~= "" and arg_357_1.actors_[var_360_18.prefab_name] ~= nil then
						local var_360_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_18.prefab_name].transform, "story_v_out_413101", "413101086", "story_v_out_413101.awb")

						arg_357_1:RecordAudio("413101086", var_360_24)
						arg_357_1:RecordAudio("413101086", var_360_24)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_413101", "413101086", "story_v_out_413101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_413101", "413101086", "story_v_out_413101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_25 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 <= arg_357_1.time_ and arg_357_1.time_ < var_360_15 + var_360_25 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_15) / var_360_25

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_15 + var_360_25 and arg_357_1.time_ < var_360_15 + var_360_25 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play413101087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 413101087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play413101088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10094"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos10094 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10094", 7)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(0, -2000, 0)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10094, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_364_7 = arg_361_1.actors_["10094"]
			local var_364_8 = 0

			if var_364_8 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10094 == nil then
				arg_361_1.var_.actorSpriteComps10094 = var_364_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_9 = 2

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_9 and not isNil(var_364_7) then
				local var_364_10 = (arg_361_1.time_ - var_364_8) / var_364_9

				if arg_361_1.var_.actorSpriteComps10094 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								local var_364_11 = Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor2.r, var_364_10)
								local var_364_12 = Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor2.g, var_364_10)
								local var_364_13 = Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor2.b, var_364_10)

								iter_364_2.color = Color.New(var_364_11, var_364_12, var_364_13)
							else
								local var_364_14 = Mathf.Lerp(iter_364_2.color.r, 0.5, var_364_10)

								iter_364_2.color = Color.New(var_364_14, var_364_14, var_364_14)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_8 + var_364_9 and arg_361_1.time_ < var_364_8 + var_364_9 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10094 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_364_4 then
						if arg_361_1.isInRecall_ then
							iter_364_4.color = arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_364_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps10094 = nil
			end

			local var_364_15 = 0
			local var_364_16 = 1.05

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_17 = arg_361_1:GetWordFromCfg(413101087)
				local var_364_18 = arg_361_1:FormatText(var_364_17.content)

				arg_361_1.text_.text = var_364_18

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_19 = 42
				local var_364_20 = utf8.len(var_364_18)
				local var_364_21 = var_364_19 <= 0 and var_364_16 or var_364_16 * (var_364_20 / var_364_19)

				if var_364_21 > 0 and var_364_16 < var_364_21 then
					arg_361_1.talkMaxDuration = var_364_21

					if var_364_21 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_21 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_18
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_22 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_22 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_22

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_22 and arg_361_1.time_ < var_364_15 + var_364_22 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play413101088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 413101088
		arg_365_1.duration_ = 3.97

		local var_365_0 = {
			zh = 3.966,
			ja = 3.766
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play413101089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10094"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos10094 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10094", 3)

				local var_368_2 = var_368_0.childCount

				for iter_368_0 = 0, var_368_2 - 1 do
					local var_368_3 = var_368_0:GetChild(iter_368_0)

					if var_368_3.name == "" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_4 then
				local var_368_5 = (arg_365_1.time_ - var_368_1) / var_368_4
				local var_368_6 = Vector3.New(0, -340, -414)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10094, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_368_7 = arg_365_1.actors_["10094"]
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10094 == nil then
				arg_365_1.var_.actorSpriteComps10094 = var_368_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_9 = 2

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_9 and not isNil(var_368_7) then
				local var_368_10 = (arg_365_1.time_ - var_368_8) / var_368_9

				if arg_365_1.var_.actorSpriteComps10094 then
					for iter_368_1, iter_368_2 in pairs(arg_365_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_368_2 then
							if arg_365_1.isInRecall_ then
								local var_368_11 = Mathf.Lerp(iter_368_2.color.r, arg_365_1.hightColor1.r, var_368_10)
								local var_368_12 = Mathf.Lerp(iter_368_2.color.g, arg_365_1.hightColor1.g, var_368_10)
								local var_368_13 = Mathf.Lerp(iter_368_2.color.b, arg_365_1.hightColor1.b, var_368_10)

								iter_368_2.color = Color.New(var_368_11, var_368_12, var_368_13)
							else
								local var_368_14 = Mathf.Lerp(iter_368_2.color.r, 1, var_368_10)

								iter_368_2.color = Color.New(var_368_14, var_368_14, var_368_14)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_8 + var_368_9 and arg_365_1.time_ < var_368_8 + var_368_9 + arg_368_0 and not isNil(var_368_7) and arg_365_1.var_.actorSpriteComps10094 then
				for iter_368_3, iter_368_4 in pairs(arg_365_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_368_4 then
						if arg_365_1.isInRecall_ then
							iter_368_4.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10094 = nil
			end

			local var_368_15 = 0
			local var_368_16 = 0.325

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_17 = arg_365_1:FormatText(StoryNameCfg[259].name)

				arg_365_1.leftNameTxt_.text = var_368_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_18 = arg_365_1:GetWordFromCfg(413101088)
				local var_368_19 = arg_365_1:FormatText(var_368_18.content)

				arg_365_1.text_.text = var_368_19

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_20 = 13
				local var_368_21 = utf8.len(var_368_19)
				local var_368_22 = var_368_20 <= 0 and var_368_16 or var_368_16 * (var_368_21 / var_368_20)

				if var_368_22 > 0 and var_368_16 < var_368_22 then
					arg_365_1.talkMaxDuration = var_368_22

					if var_368_22 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_19
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413101", "413101088", "story_v_out_413101.awb") ~= 0 then
					local var_368_23 = manager.audio:GetVoiceLength("story_v_out_413101", "413101088", "story_v_out_413101.awb") / 1000

					if var_368_23 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_15
					end

					if var_368_18.prefab_name ~= "" and arg_365_1.actors_[var_368_18.prefab_name] ~= nil then
						local var_368_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_18.prefab_name].transform, "story_v_out_413101", "413101088", "story_v_out_413101.awb")

						arg_365_1:RecordAudio("413101088", var_368_24)
						arg_365_1:RecordAudio("413101088", var_368_24)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_413101", "413101088", "story_v_out_413101.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_413101", "413101088", "story_v_out_413101.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_25 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_25 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_25

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_25 and arg_365_1.time_ < var_368_15 + var_368_25 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play413101089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 413101089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
			arg_369_1.auto_ = false
		end

		function arg_369_1.playNext_(arg_371_0)
			arg_369_1.onStoryFinished_()
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10094"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos10094 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10094", 6)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(1500, -340, -414)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10094, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_372_7 = arg_369_1.actors_["10094"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10094 == nil then
				arg_369_1.var_.actorSpriteComps10094 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 2

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps10094 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								local var_372_11 = Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor2.r, var_372_10)
								local var_372_12 = Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor2.g, var_372_10)
								local var_372_13 = Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor2.b, var_372_10)

								iter_372_2.color = Color.New(var_372_11, var_372_12, var_372_13)
							else
								local var_372_14 = Mathf.Lerp(iter_372_2.color.r, 0.5, var_372_10)

								iter_372_2.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10094 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10094 = nil
			end

			local var_372_15 = 0
			local var_372_16 = 1.025

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_17 = arg_369_1:GetWordFromCfg(413101089)
				local var_372_18 = arg_369_1:FormatText(var_372_17.content)

				arg_369_1.text_.text = var_372_18

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_19 = 41
				local var_372_20 = utf8.len(var_372_18)
				local var_372_21 = var_372_19 <= 0 and var_372_16 or var_372_16 * (var_372_20 / var_372_19)

				if var_372_21 > 0 and var_372_16 < var_372_21 then
					arg_369_1.talkMaxDuration = var_372_21

					if var_372_21 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_21 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_18
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_22 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_22 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_22

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_22 and arg_369_1.time_ < var_372_15 + var_372_22 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F09f"
	},
	voices = {
		"story_v_out_413101.awb"
	}
}
