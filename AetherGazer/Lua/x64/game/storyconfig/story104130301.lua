return {
	Play413031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413031001
		arg_1_1.duration_ = 4.13

		local var_1_0 = {
			zh = 4.133,
			ja = 3.3
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
				arg_1_0:Play413031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0601"

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
				local var_4_5 = arg_1_1.bgs_.ST0601

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
					if iter_4_0 ~= "ST0601" then
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
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_4" or not string.find(var_4_31.name, "split") then
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
			local var_4_36 = 1.8

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10093 == nil then
				arg_1_1.var_.actorSpriteComps10093 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 0.1

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
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10093 = var_4_45.alpha
					arg_1_1.var_.characterEffect10093 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_46 = 0.2

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

			local var_4_49 = arg_1_1.actors_["10093"]
			local var_4_50 = 1.799999999999

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_51 = var_4_49:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_51 then
					arg_1_1.var_.alphaOldValue10093 = var_4_51.alpha
					arg_1_1.var_.characterEffect10093 = var_4_51
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_52 = 0.5

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_52 then
				local var_4_53 = (arg_1_1.time_ - var_4_50) / var_4_52
				local var_4_54 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, var_4_53)

				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = var_4_54
				end
			end

			if arg_1_1.time_ >= var_4_50 + var_4_52 and arg_1_1.time_ < var_4_50 + var_4_52 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			local var_4_55 = 0
			local var_4_56 = 0.266666666666667

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_61 = 0.366666666666667
			local var_4_62 = 0.833333333333333

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "music"

				arg_1_1:AudioAction(var_4_63, var_4_64, "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_65 = ""
				local var_4_66 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if var_4_66 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_66 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_66

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_66
						arg_1_1.bgmTxt2_.text = var_4_66
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

			local var_4_67 = 2
			local var_4_68 = 0.15

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_69 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_69:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_70 = arg_1_1:FormatText(StoryNameCfg[28].name)

				arg_1_1.leftNameTxt_.text = var_4_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_71 = arg_1_1:GetWordFromCfg(413031001)
				local var_4_72 = arg_1_1:FormatText(var_4_71.content)

				arg_1_1.text_.text = var_4_72

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_73 = 6
				local var_4_74 = utf8.len(var_4_72)
				local var_4_75 = var_4_73 <= 0 and var_4_68 or var_4_68 * (var_4_74 / var_4_73)

				if var_4_75 > 0 and var_4_68 < var_4_75 then
					arg_1_1.talkMaxDuration = var_4_75
					var_4_67 = var_4_67 + 0.3

					if var_4_75 + var_4_67 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_75 + var_4_67
					end
				end

				arg_1_1.text_.text = var_4_72
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031001", "story_v_out_413031.awb") ~= 0 then
					local var_4_76 = manager.audio:GetVoiceLength("story_v_out_413031", "413031001", "story_v_out_413031.awb") / 1000

					if var_4_76 + var_4_67 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_67
					end

					if var_4_71.prefab_name ~= "" and arg_1_1.actors_[var_4_71.prefab_name] ~= nil then
						local var_4_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_71.prefab_name].transform, "story_v_out_413031", "413031001", "story_v_out_413031.awb")

						arg_1_1:RecordAudio("413031001", var_4_77)
						arg_1_1:RecordAudio("413031001", var_4_77)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413031", "413031001", "story_v_out_413031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413031", "413031001", "story_v_out_413031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_78 = var_4_67 + 0.3
			local var_4_79 = math.max(var_4_68, arg_1_1.talkMaxDuration)

			if var_4_78 <= arg_1_1.time_ and arg_1_1.time_ < var_4_78 + var_4_79 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_78) / var_4_79

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_78 + var_4_79 and arg_1_1.time_ < var_4_78 + var_4_79 + arg_4_0 then
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
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play413031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413031002
		arg_9_1.duration_ = 4.3

		local var_9_0 = {
			zh = 2.966,
			ja = 4.3
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413031003(arg_9_1)
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

					if var_12_3.name == "split_7" or not string.find(var_12_3.name, "split") then
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

			local var_12_7 = "10092"

			if arg_9_1.actors_[var_12_7] == nil then
				local var_12_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_12_8) then
					local var_12_9 = Object.Instantiate(var_12_8, arg_9_1.canvasGo_.transform)

					var_12_9.transform:SetSiblingIndex(1)

					var_12_9.name = var_12_7
					var_12_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_7] = var_12_9

					local var_12_10 = var_12_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_1, iter_12_2 in ipairs(var_12_10) do
							iter_12_2.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_11 = arg_9_1.actors_["10092"].transform
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092", 3)

				local var_12_13 = var_12_11.childCount

				for iter_12_3 = 0, var_12_13 - 1 do
					local var_12_14 = var_12_11:GetChild(iter_12_3)

					if var_12_14.name == "split_8" or not string.find(var_12_14.name, "split") then
						var_12_14.gameObject:SetActive(true)
					else
						var_12_14.gameObject:SetActive(false)
					end
				end
			end

			local var_12_15 = 0.001

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_15 then
				local var_12_16 = (arg_9_1.time_ - var_12_12) / var_12_15
				local var_12_17 = Vector3.New(0, -300, -295)

				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092, var_12_17, var_12_16)
			end

			if arg_9_1.time_ >= var_12_12 + var_12_15 and arg_9_1.time_ < var_12_12 + var_12_15 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(0, -300, -295)
			end

			local var_12_18 = arg_9_1.actors_["10093"]
			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_20 = 2

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 and not isNil(var_12_18) then
				local var_12_21 = (arg_9_1.time_ - var_12_19) / var_12_20

				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								local var_12_22 = Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor2.r, var_12_21)
								local var_12_23 = Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor2.g, var_12_21)
								local var_12_24 = Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor2.b, var_12_21)

								iter_12_5.color = Color.New(var_12_22, var_12_23, var_12_24)
							else
								local var_12_25 = Mathf.Lerp(iter_12_5.color.r, 0.5, var_12_21)

								iter_12_5.color = Color.New(var_12_25, var_12_25, var_12_25)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_7 then
						if arg_9_1.isInRecall_ then
							iter_12_7.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_26 = arg_9_1.actors_["10092"]
			local var_12_27 = 0

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10092 == nil then
				arg_9_1.var_.actorSpriteComps10092 = var_12_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_28 = 2

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_28 and not isNil(var_12_26) then
				local var_12_29 = (arg_9_1.time_ - var_12_27) / var_12_28

				if arg_9_1.var_.actorSpriteComps10092 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_12_9 then
							if arg_9_1.isInRecall_ then
								local var_12_30 = Mathf.Lerp(iter_12_9.color.r, arg_9_1.hightColor1.r, var_12_29)
								local var_12_31 = Mathf.Lerp(iter_12_9.color.g, arg_9_1.hightColor1.g, var_12_29)
								local var_12_32 = Mathf.Lerp(iter_12_9.color.b, arg_9_1.hightColor1.b, var_12_29)

								iter_12_9.color = Color.New(var_12_30, var_12_31, var_12_32)
							else
								local var_12_33 = Mathf.Lerp(iter_12_9.color.r, 1, var_12_29)

								iter_12_9.color = Color.New(var_12_33, var_12_33, var_12_33)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_27 + var_12_28 and arg_9_1.time_ < var_12_27 + var_12_28 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10092 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_12_11 then
						if arg_9_1.isInRecall_ then
							iter_12_11.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10092 = nil
			end

			local var_12_34 = 0
			local var_12_35 = 0.3

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[996].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(413031002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 12
				local var_12_40 = utf8.len(var_12_38)
				local var_12_41 = var_12_39 <= 0 and var_12_35 or var_12_35 * (var_12_40 / var_12_39)

				if var_12_41 > 0 and var_12_35 < var_12_41 then
					arg_9_1.talkMaxDuration = var_12_41

					if var_12_41 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_34
					end
				end

				arg_9_1.text_.text = var_12_38
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031002", "story_v_out_413031.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_413031", "413031002", "story_v_out_413031.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_413031", "413031002", "story_v_out_413031.awb")

						arg_9_1:RecordAudio("413031002", var_12_43)
						arg_9_1:RecordAudio("413031002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413031", "413031002", "story_v_out_413031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413031", "413031002", "story_v_out_413031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_44 = math.max(var_12_35, arg_9_1.talkMaxDuration)

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_44 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_34) / var_12_44

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_34 + var_12_44 and arg_9_1.time_ < var_12_34 + var_12_44 + arg_12_0 then
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

		arg_9_1:InitPlayNodeList()
	end,
	Play413031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10092"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10092 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10092", 7)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_4" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(0, -2000, 0)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10092, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_16_7 = arg_13_1.actors_["10092"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10092 == nil then
				arg_13_1.var_.actorSpriteComps10092 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10092 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor2.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor2.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor2.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 0.5, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10092 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10092 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.65

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(413031003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 26
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_16 or var_16_16 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_16 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_15
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_16, arg_13_1.talkMaxDuration)

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_22 and arg_13_1.time_ < var_16_15 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play413031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413031004
		arg_17_1.duration_ = 7.63

		local var_17_0 = {
			zh = 5.7,
			ja = 7.633
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
				arg_17_0:Play413031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10092"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092 = var_20_0.localPosition
				var_20_0.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092", 3)

				local var_20_2 = var_20_0.childCount

				for iter_20_0 = 0, var_20_2 - 1 do
					local var_20_3 = var_20_0:GetChild(iter_20_0)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_4 then
				local var_20_5 = (arg_17_1.time_ - var_20_1) / var_20_4
				local var_20_6 = Vector3.New(0, -300, -295)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092, var_20_6, var_20_5)
			end

			if arg_17_1.time_ >= var_20_1 + var_20_4 and arg_17_1.time_ < var_20_1 + var_20_4 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_20_7 = arg_17_1.actors_["10092"]
			local var_20_8 = 0

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10092 == nil then
				arg_17_1.var_.actorSpriteComps10092 = var_20_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_9 = 2

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 and not isNil(var_20_7) then
				local var_20_10 = (arg_17_1.time_ - var_20_8) / var_20_9

				if arg_17_1.var_.actorSpriteComps10092 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								local var_20_11 = Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, var_20_10)
								local var_20_12 = Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, var_20_10)
								local var_20_13 = Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, var_20_10)

								iter_20_2.color = Color.New(var_20_11, var_20_12, var_20_13)
							else
								local var_20_14 = Mathf.Lerp(iter_20_2.color.r, 1, var_20_10)

								iter_20_2.color = Color.New(var_20_14, var_20_14, var_20_14)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.actorSpriteComps10092 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_20_4 then
						if arg_17_1.isInRecall_ then
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10092 = nil
			end

			local var_20_15 = 0
			local var_20_16 = 0.575

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[996].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(413031004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 23
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031004", "story_v_out_413031.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031004", "story_v_out_413031.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_413031", "413031004", "story_v_out_413031.awb")

						arg_17_1:RecordAudio("413031004", var_20_24)
						arg_17_1:RecordAudio("413031004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413031", "413031004", "story_v_out_413031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413031", "413031004", "story_v_out_413031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play413031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413031005
		arg_21_1.duration_ = 11.6

		local var_21_0 = {
			zh = 4.266,
			ja = 11.6
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
				arg_21_0:Play413031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10092"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092", 0)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(0, -5000, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_24_7 = "10094"

			if arg_21_1.actors_[var_24_7] == nil then
				local var_24_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_24_8) then
					local var_24_9 = Object.Instantiate(var_24_8, arg_21_1.canvasGo_.transform)

					var_24_9.transform:SetSiblingIndex(1)

					var_24_9.name = var_24_7
					var_24_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_7] = var_24_9

					local var_24_10 = var_24_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_1, iter_24_2 in ipairs(var_24_10) do
							iter_24_2.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_11 = arg_21_1.actors_["10094"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos10094 = var_24_11.localPosition
				var_24_11.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10094", 3)

				local var_24_13 = var_24_11.childCount

				for iter_24_3 = 0, var_24_13 - 1 do
					local var_24_14 = var_24_11:GetChild(iter_24_3)

					if var_24_14.name == "" or not string.find(var_24_14.name, "split") then
						var_24_14.gameObject:SetActive(true)
					else
						var_24_14.gameObject:SetActive(false)
					end
				end
			end

			local var_24_15 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_15 then
				local var_24_16 = (arg_21_1.time_ - var_24_12) / var_24_15
				local var_24_17 = Vector3.New(0, -340, -414)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10094, var_24_17, var_24_16)
			end

			if arg_21_1.time_ >= var_24_12 + var_24_15 and arg_21_1.time_ < var_24_12 + var_24_15 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0, -340, -414)
			end

			local var_24_18 = arg_21_1.actors_["10092"]
			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.actorSpriteComps10092 == nil then
				arg_21_1.var_.actorSpriteComps10092 = var_24_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_20 = 2

			if var_24_19 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_20 and not isNil(var_24_18) then
				local var_24_21 = (arg_21_1.time_ - var_24_19) / var_24_20

				if arg_21_1.var_.actorSpriteComps10092 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_22 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_21)
								local var_24_23 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_21)
								local var_24_24 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_21)

								iter_24_5.color = Color.New(var_24_22, var_24_23, var_24_24)
							else
								local var_24_25 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_21)

								iter_24_5.color = Color.New(var_24_25, var_24_25, var_24_25)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_19 + var_24_20 and arg_21_1.time_ < var_24_19 + var_24_20 + arg_24_0 and not isNil(var_24_18) and arg_21_1.var_.actorSpriteComps10092 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10092 = nil
			end

			local var_24_26 = arg_21_1.actors_["10094"]
			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 and not isNil(var_24_26) and arg_21_1.var_.actorSpriteComps10094 == nil then
				arg_21_1.var_.actorSpriteComps10094 = var_24_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_28 = 2

			if var_24_27 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 and not isNil(var_24_26) then
				local var_24_29 = (arg_21_1.time_ - var_24_27) / var_24_28

				if arg_21_1.var_.actorSpriteComps10094 then
					for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_24_9 then
							if arg_21_1.isInRecall_ then
								local var_24_30 = Mathf.Lerp(iter_24_9.color.r, arg_21_1.hightColor1.r, var_24_29)
								local var_24_31 = Mathf.Lerp(iter_24_9.color.g, arg_21_1.hightColor1.g, var_24_29)
								local var_24_32 = Mathf.Lerp(iter_24_9.color.b, arg_21_1.hightColor1.b, var_24_29)

								iter_24_9.color = Color.New(var_24_30, var_24_31, var_24_32)
							else
								local var_24_33 = Mathf.Lerp(iter_24_9.color.r, 1, var_24_29)

								iter_24_9.color = Color.New(var_24_33, var_24_33, var_24_33)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 and not isNil(var_24_26) and arg_21_1.var_.actorSpriteComps10094 then
				for iter_24_10, iter_24_11 in pairs(arg_21_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_24_11 then
						if arg_21_1.isInRecall_ then
							iter_24_11.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10094 = nil
			end

			local var_24_34 = 0
			local var_24_35 = 0.525

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_36 = arg_21_1:FormatText(StoryNameCfg[259].name)

				arg_21_1.leftNameTxt_.text = var_24_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_37 = arg_21_1:GetWordFromCfg(413031005)
				local var_24_38 = arg_21_1:FormatText(var_24_37.content)

				arg_21_1.text_.text = var_24_38

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_39 = 21
				local var_24_40 = utf8.len(var_24_38)
				local var_24_41 = var_24_39 <= 0 and var_24_35 or var_24_35 * (var_24_40 / var_24_39)

				if var_24_41 > 0 and var_24_35 < var_24_41 then
					arg_21_1.talkMaxDuration = var_24_41

					if var_24_41 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_41 + var_24_34
					end
				end

				arg_21_1.text_.text = var_24_38
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031005", "story_v_out_413031.awb") ~= 0 then
					local var_24_42 = manager.audio:GetVoiceLength("story_v_out_413031", "413031005", "story_v_out_413031.awb") / 1000

					if var_24_42 + var_24_34 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_34
					end

					if var_24_37.prefab_name ~= "" and arg_21_1.actors_[var_24_37.prefab_name] ~= nil then
						local var_24_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_37.prefab_name].transform, "story_v_out_413031", "413031005", "story_v_out_413031.awb")

						arg_21_1:RecordAudio("413031005", var_24_43)
						arg_21_1:RecordAudio("413031005", var_24_43)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413031", "413031005", "story_v_out_413031.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413031", "413031005", "story_v_out_413031.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_44 = math.max(var_24_35, arg_21_1.talkMaxDuration)

			if var_24_34 <= arg_21_1.time_ and arg_21_1.time_ < var_24_34 + var_24_44 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_34) / var_24_44

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_34 + var_24_44 and arg_21_1.time_ < var_24_34 + var_24_44 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play413031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413031006
		arg_25_1.duration_ = 14.97

		local var_25_0 = {
			zh = 8.866,
			ja = 14.966
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
				arg_25_0:Play413031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10022"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["10022"].transform
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				local var_28_6 = var_28_4.childCount

				for iter_28_2 = 0, var_28_6 - 1 do
					local var_28_7 = var_28_4:GetChild(iter_28_2)

					if var_28_7.name == "split_3" or not string.find(var_28_7.name, "split") then
						var_28_7.gameObject:SetActive(true)
					else
						var_28_7.gameObject:SetActive(false)
					end
				end
			end

			local var_28_8 = 0.001

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_5) / var_28_8
				local var_28_10 = Vector3.New(0, -315, -320)

				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, var_28_10, var_28_9)
			end

			if arg_25_1.time_ >= var_28_5 + var_28_8 and arg_25_1.time_ < var_28_5 + var_28_8 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_11 = arg_25_1.actors_["10022"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_13 = 2

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_4 then
							if arg_25_1.isInRecall_ then
								local var_28_15 = Mathf.Lerp(iter_28_4.color.r, arg_25_1.hightColor1.r, var_28_14)
								local var_28_16 = Mathf.Lerp(iter_28_4.color.g, arg_25_1.hightColor1.g, var_28_14)
								local var_28_17 = Mathf.Lerp(iter_28_4.color.b, arg_25_1.hightColor1.b, var_28_14)

								iter_28_4.color = Color.New(var_28_15, var_28_16, var_28_17)
							else
								local var_28_18 = Mathf.Lerp(iter_28_4.color.r, 1, var_28_14)

								iter_28_4.color = Color.New(var_28_18, var_28_18, var_28_18)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_6 then
						if arg_25_1.isInRecall_ then
							iter_28_6.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_19 = arg_25_1.actors_["10094"]
			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.actorSpriteComps10094 == nil then
				arg_25_1.var_.actorSpriteComps10094 = var_28_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_21 = 2

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_21 and not isNil(var_28_19) then
				local var_28_22 = (arg_25_1.time_ - var_28_20) / var_28_21

				if arg_25_1.var_.actorSpriteComps10094 then
					for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_28_8 then
							if arg_25_1.isInRecall_ then
								local var_28_23 = Mathf.Lerp(iter_28_8.color.r, arg_25_1.hightColor2.r, var_28_22)
								local var_28_24 = Mathf.Lerp(iter_28_8.color.g, arg_25_1.hightColor2.g, var_28_22)
								local var_28_25 = Mathf.Lerp(iter_28_8.color.b, arg_25_1.hightColor2.b, var_28_22)

								iter_28_8.color = Color.New(var_28_23, var_28_24, var_28_25)
							else
								local var_28_26 = Mathf.Lerp(iter_28_8.color.r, 0.5, var_28_22)

								iter_28_8.color = Color.New(var_28_26, var_28_26, var_28_26)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_20 + var_28_21 and arg_25_1.time_ < var_28_20 + var_28_21 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.actorSpriteComps10094 then
				for iter_28_9, iter_28_10 in pairs(arg_25_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_28_10 then
						if arg_25_1.isInRecall_ then
							iter_28_10.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10094 = nil
			end

			local var_28_27 = 0
			local var_28_28 = 1.1

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_29 = arg_25_1:FormatText(StoryNameCfg[614].name)

				arg_25_1.leftNameTxt_.text = var_28_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_30 = arg_25_1:GetWordFromCfg(413031006)
				local var_28_31 = arg_25_1:FormatText(var_28_30.content)

				arg_25_1.text_.text = var_28_31

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_32 = 44
				local var_28_33 = utf8.len(var_28_31)
				local var_28_34 = var_28_32 <= 0 and var_28_28 or var_28_28 * (var_28_33 / var_28_32)

				if var_28_34 > 0 and var_28_28 < var_28_34 then
					arg_25_1.talkMaxDuration = var_28_34

					if var_28_34 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_34 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_31
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031006", "story_v_out_413031.awb") ~= 0 then
					local var_28_35 = manager.audio:GetVoiceLength("story_v_out_413031", "413031006", "story_v_out_413031.awb") / 1000

					if var_28_35 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_27
					end

					if var_28_30.prefab_name ~= "" and arg_25_1.actors_[var_28_30.prefab_name] ~= nil then
						local var_28_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_30.prefab_name].transform, "story_v_out_413031", "413031006", "story_v_out_413031.awb")

						arg_25_1:RecordAudio("413031006", var_28_36)
						arg_25_1:RecordAudio("413031006", var_28_36)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413031", "413031006", "story_v_out_413031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413031", "413031006", "story_v_out_413031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_37 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_27) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_27 + var_28_37 and arg_25_1.time_ < var_28_27 + var_28_37 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413031007
		arg_29_1.duration_ = 9.6

		local var_29_0 = {
			zh = 5.733,
			ja = 9.6
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
				arg_29_0:Play413031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.8

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[614].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(413031007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031007", "story_v_out_413031.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031007", "story_v_out_413031.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_413031", "413031007", "story_v_out_413031.awb")

						arg_29_1:RecordAudio("413031007", var_32_9)
						arg_29_1:RecordAudio("413031007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413031", "413031007", "story_v_out_413031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413031", "413031007", "story_v_out_413031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413031008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10092"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10092 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10092", 3)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_5" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(0, -300, -295)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10092, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_36_7 = arg_33_1.actors_["10092"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10092 == nil then
				arg_33_1.var_.actorSpriteComps10092 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10092 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10092 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10092 = nil
			end

			local var_36_15 = arg_33_1.actors_["10022"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = var_36_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_17 = 2

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								local var_36_19 = Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor2.r, var_36_18)
								local var_36_20 = Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor2.g, var_36_18)
								local var_36_21 = Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor2.b, var_36_18)

								iter_36_6.color = Color.New(var_36_19, var_36_20, var_36_21)
							else
								local var_36_22 = Mathf.Lerp(iter_36_6.color.r, 0.5, var_36_18)

								iter_36_6.color = Color.New(var_36_22, var_36_22, var_36_22)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_8 then
						if arg_33_1.isInRecall_ then
							iter_36_8.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_23 = 0
			local var_36_24 = 0.125

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[996].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(413031008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 5
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_24 or var_36_24 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_24 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_23
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031008", "story_v_out_413031.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031008", "story_v_out_413031.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_413031", "413031008", "story_v_out_413031.awb")

						arg_33_1:RecordAudio("413031008", var_36_32)
						arg_33_1:RecordAudio("413031008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413031", "413031008", "story_v_out_413031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413031", "413031008", "story_v_out_413031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_24, arg_33_1.talkMaxDuration)

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_33 and arg_33_1.time_ < var_36_23 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play413031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413031009
		arg_37_1.duration_ = 6.83

		local var_37_0 = {
			zh = 6.833,
			ja = 5.433
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play413031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10022"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_3" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(0, -315, -320)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_40_7 = arg_37_1.actors_["10022"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_15 = 0
			local var_40_16 = 0.975

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[614].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(413031009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 39
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031009", "story_v_out_413031.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031009", "story_v_out_413031.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_413031", "413031009", "story_v_out_413031.awb")

						arg_37_1:RecordAudio("413031009", var_40_24)
						arg_37_1:RecordAudio("413031009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413031", "413031009", "story_v_out_413031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413031", "413031009", "story_v_out_413031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play413031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413031010
		arg_41_1.duration_ = 2.03

		local var_41_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_41_0:Play413031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10092"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092", 0)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(0, -5000, 0)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_44_7 = arg_41_1.actors_["10094"].transform
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.var_.moveOldPos10094 = var_44_7.localPosition
				var_44_7.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10094", 3)

				local var_44_9 = var_44_7.childCount

				for iter_44_1 = 0, var_44_9 - 1 do
					local var_44_10 = var_44_7:GetChild(iter_44_1)

					if var_44_10.name == "" or not string.find(var_44_10.name, "split") then
						var_44_10.gameObject:SetActive(true)
					else
						var_44_10.gameObject:SetActive(false)
					end
				end
			end

			local var_44_11 = 0.001

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_8) / var_44_11
				local var_44_13 = Vector3.New(0, -340, -414)

				var_44_7.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10094, var_44_13, var_44_12)
			end

			if arg_41_1.time_ >= var_44_8 + var_44_11 and arg_41_1.time_ < var_44_8 + var_44_11 + arg_44_0 then
				var_44_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_44_14 = arg_41_1.actors_["10092"]
			local var_44_15 = 0

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps10092 == nil then
				arg_41_1.var_.actorSpriteComps10092 = var_44_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_16 = 2

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_16 and not isNil(var_44_14) then
				local var_44_17 = (arg_41_1.time_ - var_44_15) / var_44_16

				if arg_41_1.var_.actorSpriteComps10092 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								local var_44_18 = Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor2.r, var_44_17)
								local var_44_19 = Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor2.g, var_44_17)
								local var_44_20 = Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor2.b, var_44_17)

								iter_44_3.color = Color.New(var_44_18, var_44_19, var_44_20)
							else
								local var_44_21 = Mathf.Lerp(iter_44_3.color.r, 0.5, var_44_17)

								iter_44_3.color = Color.New(var_44_21, var_44_21, var_44_21)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_15 + var_44_16 and arg_41_1.time_ < var_44_15 + var_44_16 + arg_44_0 and not isNil(var_44_14) and arg_41_1.var_.actorSpriteComps10092 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_44_5 then
						if arg_41_1.isInRecall_ then
							iter_44_5.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10092 = nil
			end

			local var_44_22 = arg_41_1.actors_["10094"]
			local var_44_23 = 0

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps10094 == nil then
				arg_41_1.var_.actorSpriteComps10094 = var_44_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_24 = 2

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 and not isNil(var_44_22) then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24

				if arg_41_1.var_.actorSpriteComps10094 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								local var_44_26 = Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor1.r, var_44_25)
								local var_44_27 = Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor1.g, var_44_25)
								local var_44_28 = Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor1.b, var_44_25)

								iter_44_7.color = Color.New(var_44_26, var_44_27, var_44_28)
							else
								local var_44_29 = Mathf.Lerp(iter_44_7.color.r, 1, var_44_25)

								iter_44_7.color = Color.New(var_44_29, var_44_29, var_44_29)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 and not isNil(var_44_22) and arg_41_1.var_.actorSpriteComps10094 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_44_9 then
						if arg_41_1.isInRecall_ then
							iter_44_9.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10094 = nil
			end

			local var_44_30 = 0
			local var_44_31 = 0.275

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[259].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(413031010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 11
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031010", "story_v_out_413031.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031010", "story_v_out_413031.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_413031", "413031010", "story_v_out_413031.awb")

						arg_41_1:RecordAudio("413031010", var_44_39)
						arg_41_1:RecordAudio("413031010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413031", "413031010", "story_v_out_413031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413031", "413031010", "story_v_out_413031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play413031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413031011
		arg_45_1.duration_ = 8.7

		local var_45_0 = {
			zh = 4.3,
			ja = 8.7
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
				arg_45_0:Play413031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10022"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10022 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10022", 3)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_3" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(0, -315, -320)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10022, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_48_7 = arg_45_1.actors_["10094"].transform
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.var_.moveOldPos10094 = var_48_7.localPosition
				var_48_7.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10094", 0)

				local var_48_9 = var_48_7.childCount

				for iter_48_1 = 0, var_48_9 - 1 do
					local var_48_10 = var_48_7:GetChild(iter_48_1)

					if var_48_10.name == "" or not string.find(var_48_10.name, "split") then
						var_48_10.gameObject:SetActive(true)
					else
						var_48_10.gameObject:SetActive(false)
					end
				end
			end

			local var_48_11 = 0.001

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_8) / var_48_11
				local var_48_13 = Vector3.New(-5000, -340, -414)

				var_48_7.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10094, var_48_13, var_48_12)
			end

			if arg_45_1.time_ >= var_48_8 + var_48_11 and arg_45_1.time_ < var_48_8 + var_48_11 + arg_48_0 then
				var_48_7.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_48_14 = arg_45_1.actors_["10022"]
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_16 = 2

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 and not isNil(var_48_14) then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16

				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								local var_48_18 = Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, var_48_17)
								local var_48_19 = Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, var_48_17)
								local var_48_20 = Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, var_48_17)

								iter_48_3.color = Color.New(var_48_18, var_48_19, var_48_20)
							else
								local var_48_21 = Mathf.Lerp(iter_48_3.color.r, 1, var_48_17)

								iter_48_3.color = Color.New(var_48_21, var_48_21, var_48_21)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_22 = arg_45_1.actors_["10094"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps10094 == nil then
				arg_45_1.var_.actorSpriteComps10094 = var_48_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_24 = 2

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.actorSpriteComps10094 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_26 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_25)
								local var_48_27 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_25)
								local var_48_28 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_25)

								iter_48_7.color = Color.New(var_48_26, var_48_27, var_48_28)
							else
								local var_48_29 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_25)

								iter_48_7.color = Color.New(var_48_29, var_48_29, var_48_29)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.actorSpriteComps10094 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10094 = nil
			end

			local var_48_30 = 0
			local var_48_31 = 0.5

			if var_48_30 < arg_45_1.time_ and arg_45_1.time_ <= var_48_30 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_32 = arg_45_1:FormatText(StoryNameCfg[614].name)

				arg_45_1.leftNameTxt_.text = var_48_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_33 = arg_45_1:GetWordFromCfg(413031011)
				local var_48_34 = arg_45_1:FormatText(var_48_33.content)

				arg_45_1.text_.text = var_48_34

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_35 = 20
				local var_48_36 = utf8.len(var_48_34)
				local var_48_37 = var_48_35 <= 0 and var_48_31 or var_48_31 * (var_48_36 / var_48_35)

				if var_48_37 > 0 and var_48_31 < var_48_37 then
					arg_45_1.talkMaxDuration = var_48_37

					if var_48_37 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_30
					end
				end

				arg_45_1.text_.text = var_48_34
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031011", "story_v_out_413031.awb") ~= 0 then
					local var_48_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031011", "story_v_out_413031.awb") / 1000

					if var_48_38 + var_48_30 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_38 + var_48_30
					end

					if var_48_33.prefab_name ~= "" and arg_45_1.actors_[var_48_33.prefab_name] ~= nil then
						local var_48_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_33.prefab_name].transform, "story_v_out_413031", "413031011", "story_v_out_413031.awb")

						arg_45_1:RecordAudio("413031011", var_48_39)
						arg_45_1:RecordAudio("413031011", var_48_39)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413031", "413031011", "story_v_out_413031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413031", "413031011", "story_v_out_413031.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_40 = math.max(var_48_31, arg_45_1.talkMaxDuration)

			if var_48_30 <= arg_45_1.time_ and arg_45_1.time_ < var_48_30 + var_48_40 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_30) / var_48_40

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_30 + var_48_40 and arg_45_1.time_ < var_48_30 + var_48_40 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play413031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413031012
		arg_49_1.duration_ = 3.6

		local var_49_0 = {
			zh = 3.6,
			ja = 2.633
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
				arg_49_0:Play413031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10022"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 0.5, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.225

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_10 = arg_49_1:FormatText(StoryNameCfg[999].name)

				arg_49_1.leftNameTxt_.text = var_52_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_11 = arg_49_1:GetWordFromCfg(413031012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 9
				local var_52_14 = utf8.len(var_52_12)
				local var_52_15 = var_52_13 <= 0 and var_52_9 or var_52_9 * (var_52_14 / var_52_13)

				if var_52_15 > 0 and var_52_9 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031012", "story_v_out_413031.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031012", "story_v_out_413031.awb") / 1000

					if var_52_16 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_8
					end

					if var_52_11.prefab_name ~= "" and arg_49_1.actors_[var_52_11.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_11.prefab_name].transform, "story_v_out_413031", "413031012", "story_v_out_413031.awb")

						arg_49_1:RecordAudio("413031012", var_52_17)
						arg_49_1:RecordAudio("413031012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413031", "413031012", "story_v_out_413031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413031", "413031012", "story_v_out_413031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_18 and arg_49_1.time_ < var_52_8 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413031013
		arg_53_1.duration_ = 3.63

		local var_53_0 = {
			zh = 2.233,
			ja = 3.633
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play413031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10092"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10092 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10092", 3)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(0, -300, -295)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10092, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_56_7 = arg_53_1.actors_["10092"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10092 == nil then
				arg_53_1.var_.actorSpriteComps10092 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 2

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10092 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								local var_56_11 = Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, var_56_10)
								local var_56_12 = Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, var_56_10)
								local var_56_13 = Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, var_56_10)

								iter_56_2.color = Color.New(var_56_11, var_56_12, var_56_13)
							else
								local var_56_14 = Mathf.Lerp(iter_56_2.color.r, 1, var_56_10)

								iter_56_2.color = Color.New(var_56_14, var_56_14, var_56_14)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10092 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10092 = nil
			end

			local var_56_15 = 0
			local var_56_16 = 0.225

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[996].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(413031013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 9
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031013", "story_v_out_413031.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031013", "story_v_out_413031.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_413031", "413031013", "story_v_out_413031.awb")

						arg_53_1:RecordAudio("413031013", var_56_24)
						arg_53_1:RecordAudio("413031013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413031", "413031013", "story_v_out_413031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413031", "413031013", "story_v_out_413031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play413031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413031014
		arg_57_1.duration_ = 4.17

		local var_57_0 = {
			zh = 4.166,
			ja = 2.5
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
				arg_57_0:Play413031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10092"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092 == nil then
				arg_57_1.var_.actorSpriteComps10092 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10092 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10092 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10092 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.325

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[999].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_11 = arg_57_1:GetWordFromCfg(413031014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 13
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031014", "story_v_out_413031.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031014", "story_v_out_413031.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_413031", "413031014", "story_v_out_413031.awb")

						arg_57_1:RecordAudio("413031014", var_60_17)
						arg_57_1:RecordAudio("413031014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413031", "413031014", "story_v_out_413031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413031", "413031014", "story_v_out_413031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413031015
		arg_61_1.duration_ = 14.57

		local var_61_0 = {
			zh = 10.733,
			ja = 14.566
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
				arg_61_0:Play413031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10092"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092 == nil then
				arg_61_1.var_.actorSpriteComps10092 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10092 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10092 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10092 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 1.2

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[996].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(413031015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 48
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031015", "story_v_out_413031.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031015", "story_v_out_413031.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_413031", "413031015", "story_v_out_413031.awb")

						arg_61_1:RecordAudio("413031015", var_64_17)
						arg_61_1:RecordAudio("413031015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413031", "413031015", "story_v_out_413031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413031", "413031015", "story_v_out_413031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413031016
		arg_65_1.duration_ = 5.83

		local var_65_0 = {
			zh = 5.833,
			ja = 3.533
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
				arg_65_0:Play413031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10092"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10092 == nil then
				arg_65_1.var_.actorSpriteComps10092 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10092 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10092 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10092 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.475

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[999].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_11 = arg_65_1:GetWordFromCfg(413031016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031016", "story_v_out_413031.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031016", "story_v_out_413031.awb") / 1000

					if var_68_16 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_8
					end

					if var_68_11.prefab_name ~= "" and arg_65_1.actors_[var_68_11.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_11.prefab_name].transform, "story_v_out_413031", "413031016", "story_v_out_413031.awb")

						arg_65_1:RecordAudio("413031016", var_68_17)
						arg_65_1:RecordAudio("413031016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413031", "413031016", "story_v_out_413031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413031", "413031016", "story_v_out_413031.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_18 and arg_65_1.time_ < var_68_8 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413031017
		arg_69_1.duration_ = 3.8

		local var_69_0 = {
			zh = 3,
			ja = 3.8
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
				arg_69_0:Play413031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10092"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10092 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10092", 3)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_1_1" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(0, -300, -295)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10092, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_72_7 = arg_69_1.actors_["10092"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10092 == nil then
				arg_69_1.var_.actorSpriteComps10092 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps10092 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10092 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10092 = nil
			end

			local var_72_15 = 0
			local var_72_16 = 0.325

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[996].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(413031017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031017", "story_v_out_413031.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031017", "story_v_out_413031.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_413031", "413031017", "story_v_out_413031.awb")

						arg_69_1:RecordAudio("413031017", var_72_24)
						arg_69_1:RecordAudio("413031017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413031", "413031017", "story_v_out_413031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413031", "413031017", "story_v_out_413031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413031018
		arg_73_1.duration_ = 11.03

		local var_73_0 = {
			zh = 9.533,
			ja = 11.033
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
				arg_73_0:Play413031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10092"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10092 == nil then
				arg_73_1.var_.actorSpriteComps10092 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10092 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10092 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10092 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 1

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[999].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_11 = arg_73_1:GetWordFromCfg(413031018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031018", "story_v_out_413031.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031018", "story_v_out_413031.awb") / 1000

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end

					if var_76_11.prefab_name ~= "" and arg_73_1.actors_[var_76_11.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_11.prefab_name].transform, "story_v_out_413031", "413031018", "story_v_out_413031.awb")

						arg_73_1:RecordAudio("413031018", var_76_17)
						arg_73_1:RecordAudio("413031018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413031", "413031018", "story_v_out_413031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413031", "413031018", "story_v_out_413031.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_18 and arg_73_1.time_ < var_76_8 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413031019
		arg_77_1.duration_ = 12.8

		local var_77_0 = {
			zh = 10.565999999999,
			ja = 12.799999999999
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
				arg_77_0:Play413031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "F08i"

			if arg_77_1.bgs_[var_80_0] == nil then
				local var_80_1 = Object.Instantiate(arg_77_1.paintGo_)

				var_80_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_80_0)
				var_80_1.name = var_80_0
				var_80_1.transform.parent = arg_77_1.stage_.transform
				var_80_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.bgs_[var_80_0] = var_80_1
			end

			local var_80_2 = 2

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				local var_80_3 = manager.ui.mainCamera.transform.localPosition
				local var_80_4 = Vector3.New(0, 0, 10) + Vector3.New(var_80_3.x, var_80_3.y, 0)
				local var_80_5 = arg_77_1.bgs_.F08i

				var_80_5.transform.localPosition = var_80_4
				var_80_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_6 = var_80_5:GetComponent("SpriteRenderer")

				if var_80_6 and var_80_6.sprite then
					local var_80_7 = (var_80_5.transform.localPosition - var_80_3).z
					local var_80_8 = manager.ui.mainCameraCom_
					local var_80_9 = 2 * var_80_7 * Mathf.Tan(var_80_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_10 = var_80_9 * var_80_8.aspect
					local var_80_11 = var_80_6.sprite.bounds.size.x
					local var_80_12 = var_80_6.sprite.bounds.size.y
					local var_80_13 = var_80_10 / var_80_11
					local var_80_14 = var_80_9 / var_80_12
					local var_80_15 = var_80_14 < var_80_13 and var_80_13 or var_80_14

					var_80_5.transform.localScale = Vector3.New(var_80_15, var_80_15, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "F08i" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_16 = 3.999999999999

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_17 = 0.3

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_19 = 2

			if var_80_18 <= arg_77_1.time_ and arg_77_1.time_ < var_80_18 + var_80_19 then
				local var_80_20 = (arg_77_1.time_ - var_80_18) / var_80_19
				local var_80_21 = Color.New(0, 0, 0)

				var_80_21.a = Mathf.Lerp(0, 1, var_80_20)
				arg_77_1.mask_.color = var_80_21
			end

			if arg_77_1.time_ >= var_80_18 + var_80_19 and arg_77_1.time_ < var_80_18 + var_80_19 + arg_80_0 then
				local var_80_22 = Color.New(0, 0, 0)

				var_80_22.a = 1
				arg_77_1.mask_.color = var_80_22
			end

			local var_80_23 = 2

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_24 = 2

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_24 then
				local var_80_25 = (arg_77_1.time_ - var_80_23) / var_80_24
				local var_80_26 = Color.New(0, 0, 0)

				var_80_26.a = Mathf.Lerp(1, 0, var_80_25)
				arg_77_1.mask_.color = var_80_26
			end

			if arg_77_1.time_ >= var_80_23 + var_80_24 and arg_77_1.time_ < var_80_23 + var_80_24 + arg_80_0 then
				local var_80_27 = Color.New(0, 0, 0)
				local var_80_28 = 0

				arg_77_1.mask_.enabled = false
				var_80_27.a = var_80_28
				arg_77_1.mask_.color = var_80_27
			end

			local var_80_29 = arg_77_1.actors_["10092"].transform
			local var_80_30 = 1.966

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092 = var_80_29.localPosition
				var_80_29.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092", 0)

				local var_80_31 = var_80_29.childCount

				for iter_80_2 = 0, var_80_31 - 1 do
					local var_80_32 = var_80_29:GetChild(iter_80_2)

					if var_80_32.name == "" or not string.find(var_80_32.name, "split") then
						var_80_32.gameObject:SetActive(true)
					else
						var_80_32.gameObject:SetActive(false)
					end
				end
			end

			local var_80_33 = 0.001

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_33 then
				local var_80_34 = (arg_77_1.time_ - var_80_30) / var_80_33
				local var_80_35 = Vector3.New(0, -5000, 0)

				var_80_29.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092, var_80_35, var_80_34)
			end

			if arg_77_1.time_ >= var_80_30 + var_80_33 and arg_77_1.time_ < var_80_30 + var_80_33 + arg_80_0 then
				var_80_29.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_80_36 = arg_77_1.actors_["10093"].transform
			local var_80_37 = 3.8

			if var_80_37 < arg_77_1.time_ and arg_77_1.time_ <= var_80_37 + arg_80_0 then
				arg_77_1.var_.moveOldPos10093 = var_80_36.localPosition
				var_80_36.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10093", 3)

				local var_80_38 = var_80_36.childCount

				for iter_80_3 = 0, var_80_38 - 1 do
					local var_80_39 = var_80_36:GetChild(iter_80_3)

					if var_80_39.name == "" or not string.find(var_80_39.name, "split") then
						var_80_39.gameObject:SetActive(true)
					else
						var_80_39.gameObject:SetActive(false)
					end
				end
			end

			local var_80_40 = 0.001

			if var_80_37 <= arg_77_1.time_ and arg_77_1.time_ < var_80_37 + var_80_40 then
				local var_80_41 = (arg_77_1.time_ - var_80_37) / var_80_40
				local var_80_42 = Vector3.New(0, -345, -245)

				var_80_36.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10093, var_80_42, var_80_41)
			end

			if arg_77_1.time_ >= var_80_37 + var_80_40 and arg_77_1.time_ < var_80_37 + var_80_40 + arg_80_0 then
				var_80_36.localPosition = Vector3.New(0, -345, -245)
			end

			local var_80_43 = arg_77_1.actors_["10092"]
			local var_80_44 = 1.966

			if var_80_44 < arg_77_1.time_ and arg_77_1.time_ <= var_80_44 + arg_80_0 and not isNil(var_80_43) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_45 = 0.034

			if var_80_44 <= arg_77_1.time_ and arg_77_1.time_ < var_80_44 + var_80_45 and not isNil(var_80_43) then
				local var_80_46 = (arg_77_1.time_ - var_80_44) / var_80_45

				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_47 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_46)
								local var_80_48 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_46)
								local var_80_49 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_46)

								iter_80_5.color = Color.New(var_80_47, var_80_48, var_80_49)
							else
								local var_80_50 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_46)

								iter_80_5.color = Color.New(var_80_50, var_80_50, var_80_50)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_44 + var_80_45 and arg_77_1.time_ < var_80_44 + var_80_45 + arg_80_0 and not isNil(var_80_43) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_51 = arg_77_1.actors_["10093"]
			local var_80_52 = 3.8

			if var_80_52 < arg_77_1.time_ and arg_77_1.time_ <= var_80_52 + arg_80_0 and not isNil(var_80_51) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_51:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_53 = 0.034

			if var_80_52 <= arg_77_1.time_ and arg_77_1.time_ < var_80_52 + var_80_53 and not isNil(var_80_51) then
				local var_80_54 = (arg_77_1.time_ - var_80_52) / var_80_53

				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_80_9 then
							if arg_77_1.isInRecall_ then
								local var_80_55 = Mathf.Lerp(iter_80_9.color.r, arg_77_1.hightColor1.r, var_80_54)
								local var_80_56 = Mathf.Lerp(iter_80_9.color.g, arg_77_1.hightColor1.g, var_80_54)
								local var_80_57 = Mathf.Lerp(iter_80_9.color.b, arg_77_1.hightColor1.b, var_80_54)

								iter_80_9.color = Color.New(var_80_55, var_80_56, var_80_57)
							else
								local var_80_58 = Mathf.Lerp(iter_80_9.color.r, 1, var_80_54)

								iter_80_9.color = Color.New(var_80_58, var_80_58, var_80_58)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_52 + var_80_53 and arg_77_1.time_ < var_80_52 + var_80_53 + arg_80_0 and not isNil(var_80_51) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_10, iter_80_11 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_11 then
						if arg_77_1.isInRecall_ then
							iter_80_11.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_59 = arg_77_1.actors_["10093"]
			local var_80_60 = 3.799999999999

			if var_80_60 < arg_77_1.time_ and arg_77_1.time_ <= var_80_60 + arg_80_0 then
				local var_80_61 = var_80_59:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_61 then
					arg_77_1.var_.alphaOldValue10093 = var_80_61.alpha
					arg_77_1.var_.characterEffect10093 = var_80_61
				end

				arg_77_1.var_.alphaOldValue10093 = 0
			end

			local var_80_62 = 0.2

			if var_80_60 <= arg_77_1.time_ and arg_77_1.time_ < var_80_60 + var_80_62 then
				local var_80_63 = (arg_77_1.time_ - var_80_60) / var_80_62
				local var_80_64 = Mathf.Lerp(arg_77_1.var_.alphaOldValue10093, 1, var_80_63)

				if arg_77_1.var_.characterEffect10093 then
					arg_77_1.var_.characterEffect10093.alpha = var_80_64
				end
			end

			if arg_77_1.time_ >= var_80_60 + var_80_62 and arg_77_1.time_ < var_80_60 + var_80_62 + arg_80_0 and arg_77_1.var_.characterEffect10093 then
				arg_77_1.var_.characterEffect10093.alpha = 1
			end

			local var_80_65 = 0
			local var_80_66 = 0.266666666666667

			if var_80_65 < arg_77_1.time_ and arg_77_1.time_ <= var_80_65 + arg_80_0 then
				local var_80_67 = "play"
				local var_80_68 = "music"

				arg_77_1:AudioAction(var_80_67, var_80_68, "ui_battle", "ui_battle_stopbgm", "")

				local var_80_69 = ""
				local var_80_70 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_80_70 ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_70 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_70

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_70
						arg_77_1.bgmTxt2_.text = var_80_70
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_80_71 = 2
			local var_80_72 = 1.43333333333333

			if var_80_71 < arg_77_1.time_ and arg_77_1.time_ <= var_80_71 + arg_80_0 then
				local var_80_73 = "play"
				local var_80_74 = "music"

				arg_77_1:AudioAction(var_80_73, var_80_74, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_80_75 = ""
				local var_80_76 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_80_76 ~= "" then
					if arg_77_1.bgmTxt_.text ~= var_80_76 and arg_77_1.bgmTxt_.text ~= "" then
						if arg_77_1.bgmTxt2_.text ~= "" then
							arg_77_1.bgmTxt_.text = arg_77_1.bgmTxt2_.text
						end

						arg_77_1.bgmTxt2_.text = var_80_76

						arg_77_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_77_1.bgmTxt_.text = var_80_76
						arg_77_1.bgmTxt2_.text = var_80_76
					end

					if arg_77_1.bgmTimer then
						arg_77_1.bgmTimer:Stop()

						arg_77_1.bgmTimer = nil
					end

					if arg_77_1.settingData.show_music_name == 1 then
						arg_77_1.musicController:SetSelectedState("show")
						arg_77_1.musicAnimator_:Play("open", 0, 0)

						if arg_77_1.settingData.music_time ~= 0 then
							arg_77_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_77_1.settingData.music_time), function()
								if arg_77_1 == nil or isNil(arg_77_1.bgmTxt_) then
									return
								end

								arg_77_1.musicController:SetSelectedState("hide")
								arg_77_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_77 = 3.999999999999
			local var_80_78 = 0.8

			if var_80_77 < arg_77_1.time_ and arg_77_1.time_ <= var_80_77 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_79 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_79:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_77_1.dialogCg_.alpha = arg_83_0
				end))
				var_80_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_80 = arg_77_1:FormatText(StoryNameCfg[28].name)

				arg_77_1.leftNameTxt_.text = var_80_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_81 = arg_77_1:GetWordFromCfg(413031019)
				local var_80_82 = arg_77_1:FormatText(var_80_81.content)

				arg_77_1.text_.text = var_80_82

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_83 = 32
				local var_80_84 = utf8.len(var_80_82)
				local var_80_85 = var_80_83 <= 0 and var_80_78 or var_80_78 * (var_80_84 / var_80_83)

				if var_80_85 > 0 and var_80_78 < var_80_85 then
					arg_77_1.talkMaxDuration = var_80_85
					var_80_77 = var_80_77 + 0.3

					if var_80_85 + var_80_77 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_85 + var_80_77
					end
				end

				arg_77_1.text_.text = var_80_82
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031019", "story_v_out_413031.awb") ~= 0 then
					local var_80_86 = manager.audio:GetVoiceLength("story_v_out_413031", "413031019", "story_v_out_413031.awb") / 1000

					if var_80_86 + var_80_77 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_86 + var_80_77
					end

					if var_80_81.prefab_name ~= "" and arg_77_1.actors_[var_80_81.prefab_name] ~= nil then
						local var_80_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_81.prefab_name].transform, "story_v_out_413031", "413031019", "story_v_out_413031.awb")

						arg_77_1:RecordAudio("413031019", var_80_87)
						arg_77_1:RecordAudio("413031019", var_80_87)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413031", "413031019", "story_v_out_413031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413031", "413031019", "story_v_out_413031.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_88 = var_80_77 + 0.3
			local var_80_89 = math.max(var_80_78, arg_77_1.talkMaxDuration)

			if var_80_88 <= arg_77_1.time_ and arg_77_1.time_ < var_80_88 + var_80_89 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_88) / var_80_89

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_88 + var_80_89 and arg_77_1.time_ < var_80_88 + var_80_89 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413031020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413031020
		arg_85_1.duration_ = 6.83

		local var_85_0 = {
			zh = 4.466,
			ja = 6.833
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
				arg_85_0:Play413031021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.625

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[28].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(413031020)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 25
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031020", "story_v_out_413031.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031020", "story_v_out_413031.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_413031", "413031020", "story_v_out_413031.awb")

						arg_85_1:RecordAudio("413031020", var_88_9)
						arg_85_1:RecordAudio("413031020", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413031", "413031020", "story_v_out_413031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413031", "413031020", "story_v_out_413031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413031021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413031021
		arg_89_1.duration_ = 7.57

		local var_89_0 = {
			zh = 7.566,
			ja = 2.966
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
				arg_89_0:Play413031022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10093"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_5" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(0, -345, -245)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_92_7 = arg_89_1.actors_["10093"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.shakeOldPos10093 = var_92_7.localPosition
			end

			local var_92_9 = 0.6

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / 0.066
				local var_92_11, var_92_12 = math.modf(var_92_10)

				var_92_7.localPosition = Vector3.New(var_92_12 * 0.13, var_92_12 * 0.13, var_92_12 * 0.13) + arg_89_1.var_.shakeOldPos10093
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 then
				var_92_7.localPosition = arg_89_1.var_.shakeOldPos10093
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_14 = 0.6

			if arg_89_1.time_ >= var_92_13 + var_92_14 and arg_89_1.time_ < var_92_13 + var_92_14 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_15 = 0
			local var_92_16 = 0.475

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

				local var_92_18 = arg_89_1:GetWordFromCfg(413031021)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031021", "story_v_out_413031.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031021", "story_v_out_413031.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_413031", "413031021", "story_v_out_413031.awb")

						arg_89_1:RecordAudio("413031021", var_92_24)
						arg_89_1:RecordAudio("413031021", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413031", "413031021", "story_v_out_413031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413031", "413031021", "story_v_out_413031.awb")
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
	Play413031022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413031022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play413031023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10093"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10093 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10093", 7)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_4" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(0, -2000, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10093, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_7 = arg_93_1.actors_["10093"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor2.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor2.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor2.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 0.5, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_15 = 0
			local var_96_16 = 1.75

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(413031022)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 70
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_16 or var_96_16 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_16 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_22 and arg_93_1.time_ < var_96_15 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413031023
		arg_97_1.duration_ = 5.8

		local var_97_0 = {
			zh = 4.1,
			ja = 5.8
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
				arg_97_0:Play413031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10093"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 3)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_3" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(0, -345, -245)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_100_7 = arg_97_1.actors_["10093"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_15 = 0
			local var_100_16 = 0.425

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[28].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(413031023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031023", "story_v_out_413031.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031023", "story_v_out_413031.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_413031", "413031023", "story_v_out_413031.awb")

						arg_97_1:RecordAudio("413031023", var_100_24)
						arg_97_1:RecordAudio("413031023", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413031", "413031023", "story_v_out_413031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413031", "413031023", "story_v_out_413031.awb")
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
				actorName = "10093",
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
	Play413031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413031024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10093"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 3)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(0, -345, -245)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_104_7 = arg_101_1.actors_["10093"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 0.5, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_15 = 0
			local var_104_16 = 1.2

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(413031024)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 48
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_16 or var_104_16 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_22 and arg_101_1.time_ < var_104_15 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413031025
		arg_105_1.duration_ = 2.33

		local var_105_0 = {
			zh = 2.333,
			ja = 2.233
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
				arg_105_0:Play413031026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10093"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10093 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10093", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "split_5" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -345, -245)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10093, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_108_7 = arg_105_1.actors_["10093"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.2

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[28].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(413031025)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 8
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031025", "story_v_out_413031.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031025", "story_v_out_413031.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_413031", "413031025", "story_v_out_413031.awb")

						arg_105_1:RecordAudio("413031025", var_108_24)
						arg_105_1:RecordAudio("413031025", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413031", "413031025", "story_v_out_413031.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413031", "413031025", "story_v_out_413031.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play413031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413031026
		arg_109_1.duration_ = 1.5

		local var_109_0 = {
			zh = 1.5,
			ja = 1.2
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
				arg_109_0:Play413031027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.15

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[28].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(413031026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 6
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031026", "story_v_out_413031.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031026", "story_v_out_413031.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_413031", "413031026", "story_v_out_413031.awb")

						arg_109_1:RecordAudio("413031026", var_112_9)
						arg_109_1:RecordAudio("413031026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413031", "413031026", "story_v_out_413031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413031", "413031026", "story_v_out_413031.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413031027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413031027
		arg_113_1.duration_ = 8.87

		local var_113_0 = {
			zh = 8.3,
			ja = 8.866
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
				arg_113_0:Play413031028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "F08f"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 2

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.F08f

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "F08f" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 3.999999999999

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			local var_116_17 = 0.3

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			local var_116_18 = 0

			if var_116_18 < arg_113_1.time_ and arg_113_1.time_ <= var_116_18 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_19 = 2

			if var_116_18 <= arg_113_1.time_ and arg_113_1.time_ < var_116_18 + var_116_19 then
				local var_116_20 = (arg_113_1.time_ - var_116_18) / var_116_19
				local var_116_21 = Color.New(0, 0, 0)

				var_116_21.a = Mathf.Lerp(0, 1, var_116_20)
				arg_113_1.mask_.color = var_116_21
			end

			if arg_113_1.time_ >= var_116_18 + var_116_19 and arg_113_1.time_ < var_116_18 + var_116_19 + arg_116_0 then
				local var_116_22 = Color.New(0, 0, 0)

				var_116_22.a = 1
				arg_113_1.mask_.color = var_116_22
			end

			local var_116_23 = 2

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_24 = 2

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / var_116_24
				local var_116_26 = Color.New(0, 0, 0)

				var_116_26.a = Mathf.Lerp(1, 0, var_116_25)
				arg_113_1.mask_.color = var_116_26
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 then
				local var_116_27 = Color.New(0, 0, 0)
				local var_116_28 = 0

				arg_113_1.mask_.enabled = false
				var_116_27.a = var_116_28
				arg_113_1.mask_.color = var_116_27
			end

			local var_116_29 = arg_113_1.actors_["10093"].transform
			local var_116_30 = 1.966

			if var_116_30 < arg_113_1.time_ and arg_113_1.time_ <= var_116_30 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = var_116_29.localPosition
				var_116_29.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 0)

				local var_116_31 = var_116_29.childCount

				for iter_116_2 = 0, var_116_31 - 1 do
					local var_116_32 = var_116_29:GetChild(iter_116_2)

					if var_116_32.name == "" or not string.find(var_116_32.name, "split") then
						var_116_32.gameObject:SetActive(true)
					else
						var_116_32.gameObject:SetActive(false)
					end
				end
			end

			local var_116_33 = 0.001

			if var_116_30 <= arg_113_1.time_ and arg_113_1.time_ < var_116_30 + var_116_33 then
				local var_116_34 = (arg_113_1.time_ - var_116_30) / var_116_33
				local var_116_35 = Vector3.New(-5000, -345, -245)

				var_116_29.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, var_116_35, var_116_34)
			end

			if arg_113_1.time_ >= var_116_30 + var_116_33 and arg_113_1.time_ < var_116_30 + var_116_33 + arg_116_0 then
				var_116_29.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_116_36 = arg_113_1.actors_["10093"]
			local var_116_37 = 1.966

			if var_116_37 < arg_113_1.time_ and arg_113_1.time_ <= var_116_37 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_36:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_38 = 0.034

			if var_116_37 <= arg_113_1.time_ and arg_113_1.time_ < var_116_37 + var_116_38 and not isNil(var_116_36) then
				local var_116_39 = (arg_113_1.time_ - var_116_37) / var_116_38

				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_4 then
							if arg_113_1.isInRecall_ then
								local var_116_40 = Mathf.Lerp(iter_116_4.color.r, arg_113_1.hightColor2.r, var_116_39)
								local var_116_41 = Mathf.Lerp(iter_116_4.color.g, arg_113_1.hightColor2.g, var_116_39)
								local var_116_42 = Mathf.Lerp(iter_116_4.color.b, arg_113_1.hightColor2.b, var_116_39)

								iter_116_4.color = Color.New(var_116_40, var_116_41, var_116_42)
							else
								local var_116_43 = Mathf.Lerp(iter_116_4.color.r, 0.5, var_116_39)

								iter_116_4.color = Color.New(var_116_43, var_116_43, var_116_43)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_37 + var_116_38 and arg_113_1.time_ < var_116_37 + var_116_38 + arg_116_0 and not isNil(var_116_36) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_6 then
						if arg_113_1.isInRecall_ then
							iter_116_6.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_44 = 4
			local var_116_45 = 0.425

			if var_116_44 < arg_113_1.time_ and arg_113_1.time_ <= var_116_44 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_46 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_46:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_47 = arg_113_1:FormatText(StoryNameCfg[998].name)

				arg_113_1.leftNameTxt_.text = var_116_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_48 = arg_113_1:GetWordFromCfg(413031027)
				local var_116_49 = arg_113_1:FormatText(var_116_48.content)

				arg_113_1.text_.text = var_116_49

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_50 = 17
				local var_116_51 = utf8.len(var_116_49)
				local var_116_52 = var_116_50 <= 0 and var_116_45 or var_116_45 * (var_116_51 / var_116_50)

				if var_116_52 > 0 and var_116_45 < var_116_52 then
					arg_113_1.talkMaxDuration = var_116_52
					var_116_44 = var_116_44 + 0.3

					if var_116_52 + var_116_44 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_52 + var_116_44
					end
				end

				arg_113_1.text_.text = var_116_49
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031027", "story_v_out_413031.awb") ~= 0 then
					local var_116_53 = manager.audio:GetVoiceLength("story_v_out_413031", "413031027", "story_v_out_413031.awb") / 1000

					if var_116_53 + var_116_44 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_53 + var_116_44
					end

					if var_116_48.prefab_name ~= "" and arg_113_1.actors_[var_116_48.prefab_name] ~= nil then
						local var_116_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_48.prefab_name].transform, "story_v_out_413031", "413031027", "story_v_out_413031.awb")

						arg_113_1:RecordAudio("413031027", var_116_54)
						arg_113_1:RecordAudio("413031027", var_116_54)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413031", "413031027", "story_v_out_413031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413031", "413031027", "story_v_out_413031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_55 = var_116_44 + 0.3
			local var_116_56 = math.max(var_116_45, arg_113_1.talkMaxDuration)

			if var_116_55 <= arg_113_1.time_ and arg_113_1.time_ < var_116_55 + var_116_56 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_55) / var_116_56

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_55 + var_116_56 and arg_113_1.time_ < var_116_55 + var_116_56 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play413031028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413031028
		arg_119_1.duration_ = 7.27

		local var_119_0 = {
			zh = 4.4,
			ja = 7.266
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
				arg_119_0:Play413031029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10022"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10022 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10022", 3)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "split_6" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -315, -320)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10022, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_122_7 = arg_119_1.actors_["10022"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10022 == nil then
				arg_119_1.var_.actorSpriteComps10022 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 2

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps10022 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps10022 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10022 = nil
			end

			local var_122_15 = 0
			local var_122_16 = 0.625

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[614].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(413031028)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031028", "story_v_out_413031.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031028", "story_v_out_413031.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_413031", "413031028", "story_v_out_413031.awb")

						arg_119_1:RecordAudio("413031028", var_122_24)
						arg_119_1:RecordAudio("413031028", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413031", "413031028", "story_v_out_413031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413031", "413031028", "story_v_out_413031.awb")
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
	Play413031029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413031029
		arg_123_1.duration_ = 13.1

		local var_123_0 = {
			zh = 7.233,
			ja = 13.1
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
				arg_123_0:Play413031030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10022"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10022 == nil then
				arg_123_1.var_.actorSpriteComps10022 = var_126_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_2 = 2

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.actorSpriteComps10022 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.actorSpriteComps10022 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_126_3 then
						if arg_123_1.isInRecall_ then
							iter_126_3.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10022 = nil
			end

			local var_126_8 = 0
			local var_126_9 = 0.625

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_10 = arg_123_1:FormatText(StoryNameCfg[998].name)

				arg_123_1.leftNameTxt_.text = var_126_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_11 = arg_123_1:GetWordFromCfg(413031029)
				local var_126_12 = arg_123_1:FormatText(var_126_11.content)

				arg_123_1.text_.text = var_126_12

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031029", "story_v_out_413031.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031029", "story_v_out_413031.awb") / 1000

					if var_126_16 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_8
					end

					if var_126_11.prefab_name ~= "" and arg_123_1.actors_[var_126_11.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_11.prefab_name].transform, "story_v_out_413031", "413031029", "story_v_out_413031.awb")

						arg_123_1:RecordAudio("413031029", var_126_17)
						arg_123_1:RecordAudio("413031029", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413031", "413031029", "story_v_out_413031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413031", "413031029", "story_v_out_413031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_18 and arg_123_1.time_ < var_126_8 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413031030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413031030
		arg_127_1.duration_ = 6.97

		local var_127_0 = {
			zh = 4.4,
			ja = 6.966
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
				arg_127_0:Play413031031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10022"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10022 == nil then
				arg_127_1.var_.actorSpriteComps10022 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10022 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10022 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10022 = nil
			end

			local var_130_8 = 0
			local var_130_9 = 0.625

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_10 = arg_127_1:FormatText(StoryNameCfg[614].name)

				arg_127_1.leftNameTxt_.text = var_130_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_11 = arg_127_1:GetWordFromCfg(413031030)
				local var_130_12 = arg_127_1:FormatText(var_130_11.content)

				arg_127_1.text_.text = var_130_12

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 25
				local var_130_14 = utf8.len(var_130_12)
				local var_130_15 = var_130_13 <= 0 and var_130_9 or var_130_9 * (var_130_14 / var_130_13)

				if var_130_15 > 0 and var_130_9 < var_130_15 then
					arg_127_1.talkMaxDuration = var_130_15

					if var_130_15 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_15 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_12
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031030", "story_v_out_413031.awb") ~= 0 then
					local var_130_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031030", "story_v_out_413031.awb") / 1000

					if var_130_16 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_8
					end

					if var_130_11.prefab_name ~= "" and arg_127_1.actors_[var_130_11.prefab_name] ~= nil then
						local var_130_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_11.prefab_name].transform, "story_v_out_413031", "413031030", "story_v_out_413031.awb")

						arg_127_1:RecordAudio("413031030", var_130_17)
						arg_127_1:RecordAudio("413031030", var_130_17)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413031", "413031030", "story_v_out_413031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413031", "413031030", "story_v_out_413031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_18 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_18 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_18

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_18 and arg_127_1.time_ < var_130_8 + var_130_18 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413031031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413031031
		arg_131_1.duration_ = 3.53

		local var_131_0 = {
			zh = 2.4,
			ja = 3.533
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
				arg_131_0:Play413031032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10022"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10022 == nil then
				arg_131_1.var_.actorSpriteComps10022 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10022 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10022 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10022 = nil
			end

			local var_134_8 = 0
			local var_134_9 = 0.275

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_10 = arg_131_1:FormatText(StoryNameCfg[998].name)

				arg_131_1.leftNameTxt_.text = var_134_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_11 = arg_131_1:GetWordFromCfg(413031031)
				local var_134_12 = arg_131_1:FormatText(var_134_11.content)

				arg_131_1.text_.text = var_134_12

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031031", "story_v_out_413031.awb") ~= 0 then
					local var_134_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031031", "story_v_out_413031.awb") / 1000

					if var_134_16 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_8
					end

					if var_134_11.prefab_name ~= "" and arg_131_1.actors_[var_134_11.prefab_name] ~= nil then
						local var_134_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_11.prefab_name].transform, "story_v_out_413031", "413031031", "story_v_out_413031.awb")

						arg_131_1:RecordAudio("413031031", var_134_17)
						arg_131_1:RecordAudio("413031031", var_134_17)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413031", "413031031", "story_v_out_413031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413031", "413031031", "story_v_out_413031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_18 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_18 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_18

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_18 and arg_131_1.time_ < var_134_8 + var_134_18 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413031032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413031032
		arg_135_1.duration_ = 10.2

		local var_135_0 = {
			zh = 8.466,
			ja = 10.2
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
				arg_135_0:Play413031033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10022"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10022 == nil then
				arg_135_1.var_.actorSpriteComps10022 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10022 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10022 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10022 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 1.075

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[614].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_11 = arg_135_1:GetWordFromCfg(413031032)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031032", "story_v_out_413031.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031032", "story_v_out_413031.awb") / 1000

					if var_138_16 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_8
					end

					if var_138_11.prefab_name ~= "" and arg_135_1.actors_[var_138_11.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_11.prefab_name].transform, "story_v_out_413031", "413031032", "story_v_out_413031.awb")

						arg_135_1:RecordAudio("413031032", var_138_17)
						arg_135_1:RecordAudio("413031032", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413031", "413031032", "story_v_out_413031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413031", "413031032", "story_v_out_413031.awb")
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
	Play413031033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413031033
		arg_139_1.duration_ = 3.8

		local var_139_0 = {
			zh = 2.5,
			ja = 3.8
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
				arg_139_0:Play413031034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10022"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10022 == nil then
				arg_139_1.var_.actorSpriteComps10022 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10022 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10022 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10022 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.225

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_10 = arg_139_1:FormatText(StoryNameCfg[998].name)

				arg_139_1.leftNameTxt_.text = var_142_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_11 = arg_139_1:GetWordFromCfg(413031033)
				local var_142_12 = arg_139_1:FormatText(var_142_11.content)

				arg_139_1.text_.text = var_142_12

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 9
				local var_142_14 = utf8.len(var_142_12)
				local var_142_15 = var_142_13 <= 0 and var_142_9 or var_142_9 * (var_142_14 / var_142_13)

				if var_142_15 > 0 and var_142_9 < var_142_15 then
					arg_139_1.talkMaxDuration = var_142_15

					if var_142_15 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_12
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031033", "story_v_out_413031.awb") ~= 0 then
					local var_142_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031033", "story_v_out_413031.awb") / 1000

					if var_142_16 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_8
					end

					if var_142_11.prefab_name ~= "" and arg_139_1.actors_[var_142_11.prefab_name] ~= nil then
						local var_142_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_11.prefab_name].transform, "story_v_out_413031", "413031033", "story_v_out_413031.awb")

						arg_139_1:RecordAudio("413031033", var_142_17)
						arg_139_1:RecordAudio("413031033", var_142_17)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413031", "413031033", "story_v_out_413031.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413031", "413031033", "story_v_out_413031.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_18 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_18 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_18

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_18 and arg_139_1.time_ < var_142_8 + var_142_18 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play413031034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413031034
		arg_143_1.duration_ = 5.43

		local var_143_0 = {
			zh = 4,
			ja = 5.433
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
				arg_143_0:Play413031035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.525

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[998].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(413031034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031034", "story_v_out_413031.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031034", "story_v_out_413031.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_413031", "413031034", "story_v_out_413031.awb")

						arg_143_1:RecordAudio("413031034", var_146_9)
						arg_143_1:RecordAudio("413031034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413031", "413031034", "story_v_out_413031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413031", "413031034", "story_v_out_413031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play413031035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413031035
		arg_147_1.duration_ = 15.7

		local var_147_0 = {
			zh = 8.2,
			ja = 15.7
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
				arg_147_0:Play413031036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10022"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10022 == nil then
				arg_147_1.var_.actorSpriteComps10022 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps10022 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps10022 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10022 = nil
			end

			local var_150_8 = 0
			local var_150_9 = 1.125

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_10 = arg_147_1:FormatText(StoryNameCfg[614].name)

				arg_147_1.leftNameTxt_.text = var_150_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_11 = arg_147_1:GetWordFromCfg(413031035)
				local var_150_12 = arg_147_1:FormatText(var_150_11.content)

				arg_147_1.text_.text = var_150_12

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 45
				local var_150_14 = utf8.len(var_150_12)
				local var_150_15 = var_150_13 <= 0 and var_150_9 or var_150_9 * (var_150_14 / var_150_13)

				if var_150_15 > 0 and var_150_9 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_12
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031035", "story_v_out_413031.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031035", "story_v_out_413031.awb") / 1000

					if var_150_16 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_8
					end

					if var_150_11.prefab_name ~= "" and arg_147_1.actors_[var_150_11.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_11.prefab_name].transform, "story_v_out_413031", "413031035", "story_v_out_413031.awb")

						arg_147_1:RecordAudio("413031035", var_150_17)
						arg_147_1:RecordAudio("413031035", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413031", "413031035", "story_v_out_413031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413031", "413031035", "story_v_out_413031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_18 and arg_147_1.time_ < var_150_8 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413031036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413031036
		arg_151_1.duration_ = 11.2

		local var_151_0 = {
			zh = 8.4,
			ja = 11.2
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
				arg_151_0:Play413031037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10022"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 1.125

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[998].name)

				arg_151_1.leftNameTxt_.text = var_154_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_11 = arg_151_1:GetWordFromCfg(413031036)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031036", "story_v_out_413031.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031036", "story_v_out_413031.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_413031", "413031036", "story_v_out_413031.awb")

						arg_151_1:RecordAudio("413031036", var_154_17)
						arg_151_1:RecordAudio("413031036", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413031", "413031036", "story_v_out_413031.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413031", "413031036", "story_v_out_413031.awb")
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
	Play413031037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413031037
		arg_155_1.duration_ = 3

		local var_155_0 = {
			zh = 2.566,
			ja = 3
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
				arg_155_0:Play413031038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10022"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 3)

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
				local var_158_6 = Vector3.New(0, -315, -320)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_158_7 = arg_155_1.actors_["10022"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_15 = 0
			local var_158_16 = 0.375

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_17 = arg_155_1:FormatText(StoryNameCfg[614].name)

				arg_155_1.leftNameTxt_.text = var_158_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:GetWordFromCfg(413031037)
				local var_158_19 = arg_155_1:FormatText(var_158_18.content)

				arg_155_1.text_.text = var_158_19

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031037", "story_v_out_413031.awb") ~= 0 then
					local var_158_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031037", "story_v_out_413031.awb") / 1000

					if var_158_23 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_15
					end

					if var_158_18.prefab_name ~= "" and arg_155_1.actors_[var_158_18.prefab_name] ~= nil then
						local var_158_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_18.prefab_name].transform, "story_v_out_413031", "413031037", "story_v_out_413031.awb")

						arg_155_1:RecordAudio("413031037", var_158_24)
						arg_155_1:RecordAudio("413031037", var_158_24)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413031", "413031037", "story_v_out_413031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413031", "413031037", "story_v_out_413031.awb")
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
				actorName = "10022",
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
	Play413031038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413031038
		arg_159_1.duration_ = 5.13

		local var_159_0 = {
			zh = 3.033,
			ja = 5.133
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
				arg_159_0:Play413031039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10022"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10022 == nil then
				arg_159_1.var_.actorSpriteComps10022 = var_162_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_2 = 2

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.actorSpriteComps10022 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.actorSpriteComps10022 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_162_3 then
						if arg_159_1.isInRecall_ then
							iter_162_3.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10022 = nil
			end

			local var_162_8 = 0
			local var_162_9 = 0.425

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_10 = arg_159_1:FormatText(StoryNameCfg[992].name)

				arg_159_1.leftNameTxt_.text = var_162_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_11 = arg_159_1:GetWordFromCfg(413031038)
				local var_162_12 = arg_159_1:FormatText(var_162_11.content)

				arg_159_1.text_.text = var_162_12

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031038", "story_v_out_413031.awb") ~= 0 then
					local var_162_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031038", "story_v_out_413031.awb") / 1000

					if var_162_16 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_16 + var_162_8
					end

					if var_162_11.prefab_name ~= "" and arg_159_1.actors_[var_162_11.prefab_name] ~= nil then
						local var_162_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_11.prefab_name].transform, "story_v_out_413031", "413031038", "story_v_out_413031.awb")

						arg_159_1:RecordAudio("413031038", var_162_17)
						arg_159_1:RecordAudio("413031038", var_162_17)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413031", "413031038", "story_v_out_413031.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413031", "413031038", "story_v_out_413031.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_18 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_18 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_18

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_18 and arg_159_1.time_ < var_162_8 + var_162_18 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play413031039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413031039
		arg_163_1.duration_ = 10.37

		local var_163_0 = {
			zh = 7.066,
			ja = 10.366
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
				arg_163_0:Play413031040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10022"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_3" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(0, -315, -320)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_166_7 = arg_163_1.actors_["10022"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 == nil then
				arg_163_1.var_.actorSpriteComps10022 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10022 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10022 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10022 = nil
			end

			local var_166_15 = 0
			local var_166_16 = 0.875

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[614].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(413031039)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031039", "story_v_out_413031.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031039", "story_v_out_413031.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_413031", "413031039", "story_v_out_413031.awb")

						arg_163_1:RecordAudio("413031039", var_166_24)
						arg_163_1:RecordAudio("413031039", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413031", "413031039", "story_v_out_413031.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413031", "413031039", "story_v_out_413031.awb")
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
				actorName = "10022",
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
	Play413031040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413031040
		arg_167_1.duration_ = 4.47

		local var_167_0 = {
			zh = 3.833,
			ja = 4.466
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
				arg_167_0:Play413031041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10022"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10022 == nil then
				arg_167_1.var_.actorSpriteComps10022 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps10022 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps10022 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10022 = nil
			end

			local var_170_8 = 0
			local var_170_9 = 0.475

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_10 = arg_167_1:FormatText(StoryNameCfg[998].name)

				arg_167_1.leftNameTxt_.text = var_170_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_11 = arg_167_1:GetWordFromCfg(413031040)
				local var_170_12 = arg_167_1:FormatText(var_170_11.content)

				arg_167_1.text_.text = var_170_12

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 19
				local var_170_14 = utf8.len(var_170_12)
				local var_170_15 = var_170_13 <= 0 and var_170_9 or var_170_9 * (var_170_14 / var_170_13)

				if var_170_15 > 0 and var_170_9 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_12
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031040", "story_v_out_413031.awb") ~= 0 then
					local var_170_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031040", "story_v_out_413031.awb") / 1000

					if var_170_16 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_8
					end

					if var_170_11.prefab_name ~= "" and arg_167_1.actors_[var_170_11.prefab_name] ~= nil then
						local var_170_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_11.prefab_name].transform, "story_v_out_413031", "413031040", "story_v_out_413031.awb")

						arg_167_1:RecordAudio("413031040", var_170_17)
						arg_167_1:RecordAudio("413031040", var_170_17)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413031", "413031040", "story_v_out_413031.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413031", "413031040", "story_v_out_413031.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_18 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_18

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_18 and arg_167_1.time_ < var_170_8 + var_170_18 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play413031041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413031041
		arg_171_1.duration_ = 9.27

		local var_171_0 = {
			zh = 9.266,
			ja = 9.166
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
				arg_171_0:Play413031042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = "F08l"

			if arg_171_1.bgs_[var_174_0] == nil then
				local var_174_1 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_0)
				var_174_1.name = var_174_0
				var_174_1.transform.parent = arg_171_1.stage_.transform
				var_174_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_0] = var_174_1
			end

			local var_174_2 = 2

			if var_174_2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				local var_174_3 = manager.ui.mainCamera.transform.localPosition
				local var_174_4 = Vector3.New(0, 0, 10) + Vector3.New(var_174_3.x, var_174_3.y, 0)
				local var_174_5 = arg_171_1.bgs_.F08l

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
					if iter_174_0 ~= "F08l" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_16 = 4

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

			local var_174_19 = 2

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

			local var_174_23 = 2

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_24 = 2

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

			local var_174_29 = arg_171_1.actors_["10022"].transform
			local var_174_30 = 1.966

			if var_174_30 < arg_171_1.time_ and arg_171_1.time_ <= var_174_30 + arg_174_0 then
				arg_171_1.var_.moveOldPos10022 = var_174_29.localPosition
				var_174_29.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10022", 0)

				local var_174_31 = var_174_29.childCount

				for iter_174_2 = 0, var_174_31 - 1 do
					local var_174_32 = var_174_29:GetChild(iter_174_2)

					if var_174_32.name == "" or not string.find(var_174_32.name, "split") then
						var_174_32.gameObject:SetActive(true)
					else
						var_174_32.gameObject:SetActive(false)
					end
				end
			end

			local var_174_33 = 0.001

			if var_174_30 <= arg_171_1.time_ and arg_171_1.time_ < var_174_30 + var_174_33 then
				local var_174_34 = (arg_171_1.time_ - var_174_30) / var_174_33
				local var_174_35 = Vector3.New(-5000, -315, -320)

				var_174_29.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10022, var_174_35, var_174_34)
			end

			if arg_171_1.time_ >= var_174_30 + var_174_33 and arg_171_1.time_ < var_174_30 + var_174_33 + arg_174_0 then
				var_174_29.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_174_36 = arg_171_1.actors_["10093"].transform
			local var_174_37 = 3.8

			if var_174_37 < arg_171_1.time_ and arg_171_1.time_ <= var_174_37 + arg_174_0 then
				arg_171_1.var_.moveOldPos10093 = var_174_36.localPosition
				var_174_36.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10093", 3)

				local var_174_38 = var_174_36.childCount

				for iter_174_3 = 0, var_174_38 - 1 do
					local var_174_39 = var_174_36:GetChild(iter_174_3)

					if var_174_39.name == "split_5" or not string.find(var_174_39.name, "split") then
						var_174_39.gameObject:SetActive(true)
					else
						var_174_39.gameObject:SetActive(false)
					end
				end
			end

			local var_174_40 = 0.001

			if var_174_37 <= arg_171_1.time_ and arg_171_1.time_ < var_174_37 + var_174_40 then
				local var_174_41 = (arg_171_1.time_ - var_174_37) / var_174_40
				local var_174_42 = Vector3.New(0, -345, -245)

				var_174_36.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10093, var_174_42, var_174_41)
			end

			if arg_171_1.time_ >= var_174_37 + var_174_40 and arg_171_1.time_ < var_174_37 + var_174_40 + arg_174_0 then
				var_174_36.localPosition = Vector3.New(0, -345, -245)
			end

			local var_174_43 = arg_171_1.actors_["10093"]
			local var_174_44 = 3.8

			if var_174_44 < arg_171_1.time_ and arg_171_1.time_ <= var_174_44 + arg_174_0 and not isNil(var_174_43) and arg_171_1.var_.actorSpriteComps10093 == nil then
				arg_171_1.var_.actorSpriteComps10093 = var_174_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_45 = 0.1

			if var_174_44 <= arg_171_1.time_ and arg_171_1.time_ < var_174_44 + var_174_45 and not isNil(var_174_43) then
				local var_174_46 = (arg_171_1.time_ - var_174_44) / var_174_45

				if arg_171_1.var_.actorSpriteComps10093 then
					for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_174_5 then
							if arg_171_1.isInRecall_ then
								local var_174_47 = Mathf.Lerp(iter_174_5.color.r, arg_171_1.hightColor1.r, var_174_46)
								local var_174_48 = Mathf.Lerp(iter_174_5.color.g, arg_171_1.hightColor1.g, var_174_46)
								local var_174_49 = Mathf.Lerp(iter_174_5.color.b, arg_171_1.hightColor1.b, var_174_46)

								iter_174_5.color = Color.New(var_174_47, var_174_48, var_174_49)
							else
								local var_174_50 = Mathf.Lerp(iter_174_5.color.r, 1, var_174_46)

								iter_174_5.color = Color.New(var_174_50, var_174_50, var_174_50)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_44 + var_174_45 and arg_171_1.time_ < var_174_44 + var_174_45 + arg_174_0 and not isNil(var_174_43) and arg_171_1.var_.actorSpriteComps10093 then
				for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_174_7 then
						if arg_171_1.isInRecall_ then
							iter_174_7.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10093 = nil
			end

			local var_174_51 = arg_171_1.actors_["10093"]
			local var_174_52 = 3.8

			if var_174_52 < arg_171_1.time_ and arg_171_1.time_ <= var_174_52 + arg_174_0 then
				local var_174_53 = var_174_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_174_53 then
					arg_171_1.var_.alphaOldValue10093 = var_174_53.alpha
					arg_171_1.var_.characterEffect10093 = var_174_53
				end

				arg_171_1.var_.alphaOldValue10093 = 0
			end

			local var_174_54 = 0.5

			if var_174_52 <= arg_171_1.time_ and arg_171_1.time_ < var_174_52 + var_174_54 then
				local var_174_55 = (arg_171_1.time_ - var_174_52) / var_174_54
				local var_174_56 = Mathf.Lerp(arg_171_1.var_.alphaOldValue10093, 1, var_174_55)

				if arg_171_1.var_.characterEffect10093 then
					arg_171_1.var_.characterEffect10093.alpha = var_174_56
				end
			end

			if arg_171_1.time_ >= var_174_52 + var_174_54 and arg_171_1.time_ < var_174_52 + var_174_54 + arg_174_0 and arg_171_1.var_.characterEffect10093 then
				arg_171_1.var_.characterEffect10093.alpha = 1
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_57 = 4
			local var_174_58 = 0.325

			if var_174_57 < arg_171_1.time_ and arg_171_1.time_ <= var_174_57 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_59 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_59:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_60 = arg_171_1:FormatText(StoryNameCfg[28].name)

				arg_171_1.leftNameTxt_.text = var_174_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_61 = arg_171_1:GetWordFromCfg(413031041)
				local var_174_62 = arg_171_1:FormatText(var_174_61.content)

				arg_171_1.text_.text = var_174_62

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_63 = 13
				local var_174_64 = utf8.len(var_174_62)
				local var_174_65 = var_174_63 <= 0 and var_174_58 or var_174_58 * (var_174_64 / var_174_63)

				if var_174_65 > 0 and var_174_58 < var_174_65 then
					arg_171_1.talkMaxDuration = var_174_65
					var_174_57 = var_174_57 + 0.3

					if var_174_65 + var_174_57 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_65 + var_174_57
					end
				end

				arg_171_1.text_.text = var_174_62
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031041", "story_v_out_413031.awb") ~= 0 then
					local var_174_66 = manager.audio:GetVoiceLength("story_v_out_413031", "413031041", "story_v_out_413031.awb") / 1000

					if var_174_66 + var_174_57 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_66 + var_174_57
					end

					if var_174_61.prefab_name ~= "" and arg_171_1.actors_[var_174_61.prefab_name] ~= nil then
						local var_174_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_61.prefab_name].transform, "story_v_out_413031", "413031041", "story_v_out_413031.awb")

						arg_171_1:RecordAudio("413031041", var_174_67)
						arg_171_1:RecordAudio("413031041", var_174_67)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413031", "413031041", "story_v_out_413031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413031", "413031041", "story_v_out_413031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_68 = var_174_57 + 0.3
			local var_174_69 = math.max(var_174_58, arg_171_1.talkMaxDuration)

			if var_174_68 <= arg_171_1.time_ and arg_171_1.time_ < var_174_68 + var_174_69 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_68) / var_174_69

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_68 + var_174_69 and arg_171_1.time_ < var_174_68 + var_174_69 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play413031042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413031042
		arg_177_1.duration_ = 6.2

		local var_177_0 = {
			zh = 6.2,
			ja = 5.4
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
				arg_177_0:Play413031043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.525

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[28].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(413031042)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031042", "story_v_out_413031.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031042", "story_v_out_413031.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_413031", "413031042", "story_v_out_413031.awb")

						arg_177_1:RecordAudio("413031042", var_180_9)
						arg_177_1:RecordAudio("413031042", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413031", "413031042", "story_v_out_413031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413031", "413031042", "story_v_out_413031.awb")
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
	Play413031043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413031043
		arg_181_1.duration_ = 9.5

		local var_181_0 = {
			zh = 4.633,
			ja = 9.5
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
				arg_181_0:Play413031044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10093"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10093 == nil then
				arg_181_1.var_.actorSpriteComps10093 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10093 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10093 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10093 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 0.575

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_10 = arg_181_1:FormatText(StoryNameCfg[993].name)

				arg_181_1.leftNameTxt_.text = var_184_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_11 = arg_181_1:GetWordFromCfg(413031043)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 23
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_9 or var_184_9 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_9 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031043", "story_v_out_413031.awb") ~= 0 then
					local var_184_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031043", "story_v_out_413031.awb") / 1000

					if var_184_16 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_16 + var_184_8
					end

					if var_184_11.prefab_name ~= "" and arg_181_1.actors_[var_184_11.prefab_name] ~= nil then
						local var_184_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_11.prefab_name].transform, "story_v_out_413031", "413031043", "story_v_out_413031.awb")

						arg_181_1:RecordAudio("413031043", var_184_17)
						arg_181_1:RecordAudio("413031043", var_184_17)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413031", "413031043", "story_v_out_413031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413031", "413031043", "story_v_out_413031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_18 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_18 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_18

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_18 and arg_181_1.time_ < var_184_8 + var_184_18 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413031044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413031044
		arg_185_1.duration_ = 5.33

		local var_185_0 = {
			zh = 3.833,
			ja = 5.333
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
				arg_185_0:Play413031045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.45

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[995].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(413031044)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031044", "story_v_out_413031.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031044", "story_v_out_413031.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_413031", "413031044", "story_v_out_413031.awb")

						arg_185_1:RecordAudio("413031044", var_188_9)
						arg_185_1:RecordAudio("413031044", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413031", "413031044", "story_v_out_413031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413031", "413031044", "story_v_out_413031.awb")
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
	Play413031045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413031045
		arg_189_1.duration_ = 2.17

		local var_189_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_189_0:Play413031046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10093"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10093 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10093", 3)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "split_5" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(0, -345, -245)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10093, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_192_7 = arg_189_1.actors_["10093"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10093 == nil then
				arg_189_1.var_.actorSpriteComps10093 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps10093 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 1, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps10093 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10093 = nil
			end

			local var_192_15 = 0
			local var_192_16 = 0.225

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[28].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(413031045)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 9
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031045", "story_v_out_413031.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031045", "story_v_out_413031.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_413031", "413031045", "story_v_out_413031.awb")

						arg_189_1:RecordAudio("413031045", var_192_24)
						arg_189_1:RecordAudio("413031045", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413031", "413031045", "story_v_out_413031.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413031", "413031045", "story_v_out_413031.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play413031046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413031046
		arg_193_1.duration_ = 5.7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play413031047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10093"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10093 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10093", 7)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -2000, 0)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10093, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_7 = arg_193_1.actors_["10093"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10093 == nil then
				arg_193_1.var_.actorSpriteComps10093 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps10093 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor2.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor2.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor2.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 0.5, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps10093 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10093 = nil
			end

			local var_196_15 = manager.ui.mainCamera.transform
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.var_.shakeOldPos = var_196_15.localPosition
			end

			local var_196_17 = 0.6

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / 0.066
				local var_196_19, var_196_20 = math.modf(var_196_18)

				var_196_15.localPosition = Vector3.New(var_196_20 * 0.13, var_196_20 * 0.13, var_196_20 * 0.13) + arg_193_1.var_.shakeOldPos
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				var_196_15.localPosition = arg_193_1.var_.shakeOldPos
			end

			local var_196_21 = 0

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_22 = 0.6

			if arg_193_1.time_ >= var_196_21 + var_196_22 and arg_193_1.time_ < var_196_21 + var_196_22 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_23 = 0
			local var_196_24 = 0.491666666666667

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 then
				local var_196_25 = "play"
				local var_196_26 = "effect"

				arg_193_1:AudioAction(var_196_25, var_196_26, "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			local var_196_27 = 0
			local var_196_28 = 0.266666666666667

			if var_196_27 < arg_193_1.time_ and arg_193_1.time_ <= var_196_27 + arg_196_0 then
				local var_196_29 = "play"
				local var_196_30 = "music"

				arg_193_1:AudioAction(var_196_29, var_196_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_196_31 = ""
				local var_196_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_196_32 ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_32 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_32

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_32
						arg_193_1.bgmTxt2_.text = var_196_32
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_33 = 0.366666666666667
			local var_196_34 = 0.833333333333333

			if var_196_33 < arg_193_1.time_ and arg_193_1.time_ <= var_196_33 + arg_196_0 then
				local var_196_35 = "play"
				local var_196_36 = "music"

				arg_193_1:AudioAction(var_196_35, var_196_36, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_196_37 = ""
				local var_196_38 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_196_38 ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_38 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_38

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_38
						arg_193_1.bgmTxt2_.text = var_196_38
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_39 = 0

			if var_196_39 < arg_193_1.time_ and arg_193_1.time_ <= var_196_39 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_40 = 0.433333333333333

			if var_196_39 <= arg_193_1.time_ and arg_193_1.time_ < var_196_39 + var_196_40 then
				local var_196_41 = (arg_193_1.time_ - var_196_39) / var_196_40
				local var_196_42 = Color.New(1, 1, 1)

				var_196_42.a = Mathf.Lerp(1, 0, var_196_41)
				arg_193_1.mask_.color = var_196_42
			end

			if arg_193_1.time_ >= var_196_39 + var_196_40 and arg_193_1.time_ < var_196_39 + var_196_40 + arg_196_0 then
				local var_196_43 = Color.New(1, 1, 1)
				local var_196_44 = 0

				arg_193_1.mask_.enabled = false
				var_196_43.a = var_196_44
				arg_193_1.mask_.color = var_196_43
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_45 = 0.7
			local var_196_46 = 1.3

			if var_196_45 < arg_193_1.time_ and arg_193_1.time_ <= var_196_45 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_47 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_47:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_193_1.dialogCg_.alpha = arg_199_0
				end))
				var_196_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_48 = arg_193_1:GetWordFromCfg(413031046)
				local var_196_49 = arg_193_1:FormatText(var_196_48.content)

				arg_193_1.text_.text = var_196_49

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_50 = 52
				local var_196_51 = utf8.len(var_196_49)
				local var_196_52 = var_196_50 <= 0 and var_196_46 or var_196_46 * (var_196_51 / var_196_50)

				if var_196_52 > 0 and var_196_46 < var_196_52 then
					arg_193_1.talkMaxDuration = var_196_52
					var_196_45 = var_196_45 + 0.3

					if var_196_52 + var_196_45 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_52 + var_196_45
					end
				end

				arg_193_1.text_.text = var_196_49
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_53 = var_196_45 + 0.3
			local var_196_54 = math.max(var_196_46, arg_193_1.talkMaxDuration)

			if var_196_53 <= arg_193_1.time_ and arg_193_1.time_ < var_196_53 + var_196_54 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_53) / var_196_54

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_53 + var_196_54 and arg_193_1.time_ < var_196_53 + var_196_54 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play413031047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413031047
		arg_201_1.duration_ = 4.07

		local var_201_0 = {
			zh = 1.9,
			ja = 4.066
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play413031048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.15

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[995].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:GetWordFromCfg(413031047)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 6
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031047", "story_v_out_413031.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031047", "story_v_out_413031.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_413031", "413031047", "story_v_out_413031.awb")

						arg_201_1:RecordAudio("413031047", var_204_9)
						arg_201_1:RecordAudio("413031047", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413031", "413031047", "story_v_out_413031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413031", "413031047", "story_v_out_413031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413031048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413031048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play413031049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.375

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_2 = arg_205_1:GetWordFromCfg(413031048)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 55
				local var_208_5 = utf8.len(var_208_3)
				local var_208_6 = var_208_4 <= 0 and var_208_1 or var_208_1 * (var_208_5 / var_208_4)

				if var_208_6 > 0 and var_208_1 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_7 and arg_205_1.time_ < var_208_0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413031049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413031049
		arg_209_1.duration_ = 4.6

		local var_209_0 = {
			zh = 2.4,
			ja = 4.6
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
				arg_209_0:Play413031050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = manager.ui.mainCamera.transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = var_212_0.localPosition
			end

			local var_212_2 = 0.6

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / 0.066
				local var_212_4, var_212_5 = math.modf(var_212_3)

				var_212_0.localPosition = Vector3.New(var_212_5 * 0.13, var_212_5 * 0.13, var_212_5 * 0.13) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = arg_209_1.var_.shakeOldPos
			end

			local var_212_6 = 0

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_7 = 0.6

			if arg_209_1.time_ >= var_212_6 + var_212_7 and arg_209_1.time_ < var_212_6 + var_212_7 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_8 = 0
			local var_212_9 = 0.25

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[995].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_11 = arg_209_1:GetWordFromCfg(413031049)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 10
				local var_212_14 = utf8.len(var_212_12)
				local var_212_15 = var_212_13 <= 0 and var_212_9 or var_212_9 * (var_212_14 / var_212_13)

				if var_212_15 > 0 and var_212_9 < var_212_15 then
					arg_209_1.talkMaxDuration = var_212_15

					if var_212_15 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_15 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_12
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031049", "story_v_out_413031.awb") ~= 0 then
					local var_212_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031049", "story_v_out_413031.awb") / 1000

					if var_212_16 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_8
					end

					if var_212_11.prefab_name ~= "" and arg_209_1.actors_[var_212_11.prefab_name] ~= nil then
						local var_212_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_11.prefab_name].transform, "story_v_out_413031", "413031049", "story_v_out_413031.awb")

						arg_209_1:RecordAudio("413031049", var_212_17)
						arg_209_1:RecordAudio("413031049", var_212_17)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413031", "413031049", "story_v_out_413031.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413031", "413031049", "story_v_out_413031.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_18 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_18 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_18

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_18 and arg_209_1.time_ < var_212_8 + var_212_18 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play413031050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413031050
		arg_213_1.duration_ = 8.1

		local var_213_0 = {
			zh = 5.733,
			ja = 8.1
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
				arg_213_0:Play413031051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10093"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10093 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10093", 3)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_4" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(0, -345, -245)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10093, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_216_7 = arg_213_1.actors_["10093"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 2

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 and not isNil(var_216_7) then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								local var_216_11 = Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, var_216_10)
								local var_216_12 = Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, var_216_10)
								local var_216_13 = Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, var_216_10)

								iter_216_2.color = Color.New(var_216_11, var_216_12, var_216_13)
							else
								local var_216_14 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_10)

								iter_216_2.color = Color.New(var_216_14, var_216_14, var_216_14)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_15 = 0
			local var_216_16 = 0.85

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[28].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(413031050)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 34
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031050", "story_v_out_413031.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031050", "story_v_out_413031.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_413031", "413031050", "story_v_out_413031.awb")

						arg_213_1:RecordAudio("413031050", var_216_24)
						arg_213_1:RecordAudio("413031050", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413031", "413031050", "story_v_out_413031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413031", "413031050", "story_v_out_413031.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play413031051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413031051
		arg_217_1.duration_ = 2.47

		local var_217_0 = {
			zh = 2.266,
			ja = 2.466
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
				arg_217_0:Play413031052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.3

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[28].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_3 = arg_217_1:GetWordFromCfg(413031051)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 12
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031051", "story_v_out_413031.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031051", "story_v_out_413031.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_413031", "413031051", "story_v_out_413031.awb")

						arg_217_1:RecordAudio("413031051", var_220_9)
						arg_217_1:RecordAudio("413031051", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413031", "413031051", "story_v_out_413031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413031", "413031051", "story_v_out_413031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413031052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413031052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play413031053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10093"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 1.075

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(413031052)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_12 = 43
				local var_224_13 = utf8.len(var_224_11)
				local var_224_14 = var_224_12 <= 0 and var_224_9 or var_224_9 * (var_224_13 / var_224_12)

				if var_224_14 > 0 and var_224_9 < var_224_14 then
					arg_221_1.talkMaxDuration = var_224_14

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_15 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_15 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_15

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_15 and arg_221_1.time_ < var_224_8 + var_224_15 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play413031053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413031053
		arg_225_1.duration_ = 8.07

		local var_225_0 = {
			zh = 6.833,
			ja = 8.066
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
				arg_225_0:Play413031054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.6

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[995].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(413031053)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 24
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031053", "story_v_out_413031.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031053", "story_v_out_413031.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_413031", "413031053", "story_v_out_413031.awb")

						arg_225_1:RecordAudio("413031053", var_228_9)
						arg_225_1:RecordAudio("413031053", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413031", "413031053", "story_v_out_413031.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413031", "413031053", "story_v_out_413031.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_10 and arg_225_1.time_ < var_228_0 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413031054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413031054
		arg_229_1.duration_ = 2.63

		local var_229_0 = {
			zh = 1.999999999999,
			ja = 2.633
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
				arg_229_0:Play413031055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10093"].transform
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos10093 = var_232_0.localPosition
				var_232_0.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10093", 3)

				local var_232_2 = var_232_0.childCount

				for iter_232_0 = 0, var_232_2 - 1 do
					local var_232_3 = var_232_0:GetChild(iter_232_0)

					if var_232_3.name == "split_6" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_4 then
				local var_232_5 = (arg_229_1.time_ - var_232_1) / var_232_4
				local var_232_6 = Vector3.New(0, -345, -245)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10093, var_232_6, var_232_5)
			end

			if arg_229_1.time_ >= var_232_1 + var_232_4 and arg_229_1.time_ < var_232_1 + var_232_4 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_232_7 = arg_229_1.actors_["10093"]
			local var_232_8 = 0

			if var_232_8 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10093 == nil then
				arg_229_1.var_.actorSpriteComps10093 = var_232_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 and not isNil(var_232_7) then
				local var_232_10 = (arg_229_1.time_ - var_232_8) / var_232_9

				if arg_229_1.var_.actorSpriteComps10093 then
					for iter_232_1, iter_232_2 in pairs(arg_229_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_232_2 then
							if arg_229_1.isInRecall_ then
								local var_232_11 = Mathf.Lerp(iter_232_2.color.r, arg_229_1.hightColor1.r, var_232_10)
								local var_232_12 = Mathf.Lerp(iter_232_2.color.g, arg_229_1.hightColor1.g, var_232_10)
								local var_232_13 = Mathf.Lerp(iter_232_2.color.b, arg_229_1.hightColor1.b, var_232_10)

								iter_232_2.color = Color.New(var_232_11, var_232_12, var_232_13)
							else
								local var_232_14 = Mathf.Lerp(iter_232_2.color.r, 1, var_232_10)

								iter_232_2.color = Color.New(var_232_14, var_232_14, var_232_14)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 and not isNil(var_232_7) and arg_229_1.var_.actorSpriteComps10093 then
				for iter_232_3, iter_232_4 in pairs(arg_229_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_232_4 then
						if arg_229_1.isInRecall_ then
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps10093 = nil
			end

			local var_232_15 = 0
			local var_232_16 = 0.1

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[28].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(413031054)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 5
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031054", "story_v_out_413031.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031054", "story_v_out_413031.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_413031", "413031054", "story_v_out_413031.awb")

						arg_229_1:RecordAudio("413031054", var_232_24)
						arg_229_1:RecordAudio("413031054", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413031", "413031054", "story_v_out_413031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413031", "413031054", "story_v_out_413031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play413031055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413031055
		arg_233_1.duration_ = 6.97

		local var_233_0 = {
			zh = 6.966,
			ja = 6.233
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
				arg_233_0:Play413031056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10093"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10093 == nil then
				arg_233_1.var_.actorSpriteComps10093 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps10093 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 0.5, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps10093 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps10093 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.675

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_10 = arg_233_1:FormatText(StoryNameCfg[995].name)

				arg_233_1.leftNameTxt_.text = var_236_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_11 = arg_233_1:GetWordFromCfg(413031055)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 27
				local var_236_14 = utf8.len(var_236_12)
				local var_236_15 = var_236_13 <= 0 and var_236_9 or var_236_9 * (var_236_14 / var_236_13)

				if var_236_15 > 0 and var_236_9 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_12
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031055", "story_v_out_413031.awb") ~= 0 then
					local var_236_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031055", "story_v_out_413031.awb") / 1000

					if var_236_16 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_8
					end

					if var_236_11.prefab_name ~= "" and arg_233_1.actors_[var_236_11.prefab_name] ~= nil then
						local var_236_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_11.prefab_name].transform, "story_v_out_413031", "413031055", "story_v_out_413031.awb")

						arg_233_1:RecordAudio("413031055", var_236_17)
						arg_233_1:RecordAudio("413031055", var_236_17)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413031", "413031055", "story_v_out_413031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413031", "413031055", "story_v_out_413031.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_18 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_18

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_18 and arg_233_1.time_ < var_236_8 + var_236_18 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play413031056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413031056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play413031057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.225

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(413031056)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 49
				local var_240_5 = utf8.len(var_240_3)
				local var_240_6 = var_240_4 <= 0 and var_240_1 or var_240_1 * (var_240_5 / var_240_4)

				if var_240_6 > 0 and var_240_1 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_7 and arg_237_1.time_ < var_240_0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play413031057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413031057
		arg_241_1.duration_ = 9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413031058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.999999999999

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				local var_244_1 = manager.ui.mainCamera.transform.localPosition
				local var_244_2 = Vector3.New(0, 0, 10) + Vector3.New(var_244_1.x, var_244_1.y, 0)
				local var_244_3 = arg_241_1.bgs_.F08l

				var_244_3.transform.localPosition = var_244_2
				var_244_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_4 = var_244_3:GetComponent("SpriteRenderer")

				if var_244_4 and var_244_4.sprite then
					local var_244_5 = (var_244_3.transform.localPosition - var_244_1).z
					local var_244_6 = manager.ui.mainCameraCom_
					local var_244_7 = 2 * var_244_5 * Mathf.Tan(var_244_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_244_8 = var_244_7 * var_244_6.aspect
					local var_244_9 = var_244_4.sprite.bounds.size.x
					local var_244_10 = var_244_4.sprite.bounds.size.y
					local var_244_11 = var_244_8 / var_244_9
					local var_244_12 = var_244_7 / var_244_10
					local var_244_13 = var_244_12 < var_244_11 and var_244_11 or var_244_12

					var_244_3.transform.localScale = Vector3.New(var_244_13, var_244_13, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "F08l" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_14 = 4.033333333331

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_15 = 0.2

			if arg_241_1.time_ >= var_244_14 + var_244_15 and arg_241_1.time_ < var_244_14 + var_244_15 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_17 = 2

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17
				local var_244_19 = Color.New(0, 0, 0)

				var_244_19.a = Mathf.Lerp(0, 1, var_244_18)
				arg_241_1.mask_.color = var_244_19
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 then
				local var_244_20 = Color.New(0, 0, 0)

				var_244_20.a = 1
				arg_241_1.mask_.color = var_244_20
			end

			local var_244_21 = 2

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_22 = 2

			if var_244_21 <= arg_241_1.time_ and arg_241_1.time_ < var_244_21 + var_244_22 then
				local var_244_23 = (arg_241_1.time_ - var_244_21) / var_244_22
				local var_244_24 = Color.New(0, 0, 0)

				var_244_24.a = Mathf.Lerp(1, 0, var_244_23)
				arg_241_1.mask_.color = var_244_24
			end

			if arg_241_1.time_ >= var_244_21 + var_244_22 and arg_241_1.time_ < var_244_21 + var_244_22 + arg_244_0 then
				local var_244_25 = Color.New(0, 0, 0)
				local var_244_26 = 0

				arg_241_1.mask_.enabled = false
				var_244_25.a = var_244_26
				arg_241_1.mask_.color = var_244_25
			end

			local var_244_27 = arg_241_1.actors_["10093"].transform
			local var_244_28 = 1.98333333333333

			if var_244_28 < arg_241_1.time_ and arg_241_1.time_ <= var_244_28 + arg_244_0 then
				arg_241_1.var_.moveOldPos10093 = var_244_27.localPosition
				var_244_27.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("10093", 7)

				local var_244_29 = var_244_27.childCount

				for iter_244_2 = 0, var_244_29 - 1 do
					local var_244_30 = var_244_27:GetChild(iter_244_2)

					if var_244_30.name == "" or not string.find(var_244_30.name, "split") then
						var_244_30.gameObject:SetActive(true)
					else
						var_244_30.gameObject:SetActive(false)
					end
				end
			end

			local var_244_31 = 0.001

			if var_244_28 <= arg_241_1.time_ and arg_241_1.time_ < var_244_28 + var_244_31 then
				local var_244_32 = (arg_241_1.time_ - var_244_28) / var_244_31
				local var_244_33 = Vector3.New(0, -2000, 0)

				var_244_27.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10093, var_244_33, var_244_32)
			end

			if arg_241_1.time_ >= var_244_28 + var_244_31 and arg_241_1.time_ < var_244_28 + var_244_31 + arg_244_0 then
				var_244_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_244_34 = arg_241_1.actors_["10093"]
			local var_244_35 = 1.98333333333333

			if var_244_35 < arg_241_1.time_ and arg_241_1.time_ <= var_244_35 + arg_244_0 and not isNil(var_244_34) and arg_241_1.var_.actorSpriteComps10093 == nil then
				arg_241_1.var_.actorSpriteComps10093 = var_244_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_36 = 0.0166666666666666

			if var_244_35 <= arg_241_1.time_ and arg_241_1.time_ < var_244_35 + var_244_36 and not isNil(var_244_34) then
				local var_244_37 = (arg_241_1.time_ - var_244_35) / var_244_36

				if arg_241_1.var_.actorSpriteComps10093 then
					for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_244_4 then
							if arg_241_1.isInRecall_ then
								local var_244_38 = Mathf.Lerp(iter_244_4.color.r, arg_241_1.hightColor2.r, var_244_37)
								local var_244_39 = Mathf.Lerp(iter_244_4.color.g, arg_241_1.hightColor2.g, var_244_37)
								local var_244_40 = Mathf.Lerp(iter_244_4.color.b, arg_241_1.hightColor2.b, var_244_37)

								iter_244_4.color = Color.New(var_244_38, var_244_39, var_244_40)
							else
								local var_244_41 = Mathf.Lerp(iter_244_4.color.r, 0.5, var_244_37)

								iter_244_4.color = Color.New(var_244_41, var_244_41, var_244_41)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_35 + var_244_36 and arg_241_1.time_ < var_244_35 + var_244_36 + arg_244_0 and not isNil(var_244_34) and arg_241_1.var_.actorSpriteComps10093 then
				for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_244_6 then
						if arg_241_1.isInRecall_ then
							iter_244_6.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps10093 = nil
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_42 = 3.999999999999
			local var_244_43 = 1.45

			if var_244_42 < arg_241_1.time_ and arg_241_1.time_ <= var_244_42 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_44 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_44:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_45 = arg_241_1:GetWordFromCfg(413031057)
				local var_244_46 = arg_241_1:FormatText(var_244_45.content)

				arg_241_1.text_.text = var_244_46

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_47 = 58
				local var_244_48 = utf8.len(var_244_46)
				local var_244_49 = var_244_47 <= 0 and var_244_43 or var_244_43 * (var_244_48 / var_244_47)

				if var_244_49 > 0 and var_244_43 < var_244_49 then
					arg_241_1.talkMaxDuration = var_244_49
					var_244_42 = var_244_42 + 0.3

					if var_244_49 + var_244_42 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_49 + var_244_42
					end
				end

				arg_241_1.text_.text = var_244_46
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_50 = var_244_42 + 0.3
			local var_244_51 = math.max(var_244_43, arg_241_1.talkMaxDuration)

			if var_244_50 <= arg_241_1.time_ and arg_241_1.time_ < var_244_50 + var_244_51 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_50) / var_244_51

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_50 + var_244_51 and arg_241_1.time_ < var_244_50 + var_244_51 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play413031058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413031058
		arg_247_1.duration_ = 4.03

		local var_247_0 = {
			zh = 3.733,
			ja = 4.033
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
				arg_247_0:Play413031059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10093"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10093 = var_250_0.localPosition
				var_250_0.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10093", 3)

				local var_250_2 = var_250_0.childCount

				for iter_250_0 = 0, var_250_2 - 1 do
					local var_250_3 = var_250_0:GetChild(iter_250_0)

					if var_250_3.name == "split_4" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_4 then
				local var_250_5 = (arg_247_1.time_ - var_250_1) / var_250_4
				local var_250_6 = Vector3.New(0, -345, -245)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10093, var_250_6, var_250_5)
			end

			if arg_247_1.time_ >= var_250_1 + var_250_4 and arg_247_1.time_ < var_250_1 + var_250_4 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_250_7 = arg_247_1.actors_["10093"]
			local var_250_8 = 0

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 and not isNil(var_250_7) and arg_247_1.var_.actorSpriteComps10093 == nil then
				arg_247_1.var_.actorSpriteComps10093 = var_250_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_9 = 2

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_9 and not isNil(var_250_7) then
				local var_250_10 = (arg_247_1.time_ - var_250_8) / var_250_9

				if arg_247_1.var_.actorSpriteComps10093 then
					for iter_250_1, iter_250_2 in pairs(arg_247_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_250_2 then
							if arg_247_1.isInRecall_ then
								local var_250_11 = Mathf.Lerp(iter_250_2.color.r, arg_247_1.hightColor1.r, var_250_10)
								local var_250_12 = Mathf.Lerp(iter_250_2.color.g, arg_247_1.hightColor1.g, var_250_10)
								local var_250_13 = Mathf.Lerp(iter_250_2.color.b, arg_247_1.hightColor1.b, var_250_10)

								iter_250_2.color = Color.New(var_250_11, var_250_12, var_250_13)
							else
								local var_250_14 = Mathf.Lerp(iter_250_2.color.r, 1, var_250_10)

								iter_250_2.color = Color.New(var_250_14, var_250_14, var_250_14)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_8 + var_250_9 and arg_247_1.time_ < var_250_8 + var_250_9 + arg_250_0 and not isNil(var_250_7) and arg_247_1.var_.actorSpriteComps10093 then
				for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_250_4 then
						if arg_247_1.isInRecall_ then
							iter_250_4.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10093 = nil
			end

			local var_250_15 = 0
			local var_250_16 = 0.45

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[28].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(413031058)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 18
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031058", "story_v_out_413031.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031058", "story_v_out_413031.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_413031", "413031058", "story_v_out_413031.awb")

						arg_247_1:RecordAudio("413031058", var_250_24)
						arg_247_1:RecordAudio("413031058", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413031", "413031058", "story_v_out_413031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413031", "413031058", "story_v_out_413031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play413031059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413031059
		arg_251_1.duration_ = 2.33

		local var_251_0 = {
			zh = 2.333,
			ja = 2.266
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
				arg_251_0:Play413031060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10093"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10093 == nil then
				arg_251_1.var_.actorSpriteComps10093 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps10093 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 0.5, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps10093 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10093 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 0.175

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_10 = arg_251_1:FormatText(StoryNameCfg[492].name)

				arg_251_1.leftNameTxt_.text = var_254_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_11 = arg_251_1:GetWordFromCfg(413031059)
				local var_254_12 = arg_251_1:FormatText(var_254_11.content)

				arg_251_1.text_.text = var_254_12

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 7
				local var_254_14 = utf8.len(var_254_12)
				local var_254_15 = var_254_13 <= 0 and var_254_9 or var_254_9 * (var_254_14 / var_254_13)

				if var_254_15 > 0 and var_254_9 < var_254_15 then
					arg_251_1.talkMaxDuration = var_254_15

					if var_254_15 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_15 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_12
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031059", "story_v_out_413031.awb") ~= 0 then
					local var_254_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031059", "story_v_out_413031.awb") / 1000

					if var_254_16 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_16 + var_254_8
					end

					if var_254_11.prefab_name ~= "" and arg_251_1.actors_[var_254_11.prefab_name] ~= nil then
						local var_254_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_11.prefab_name].transform, "story_v_out_413031", "413031059", "story_v_out_413031.awb")

						arg_251_1:RecordAudio("413031059", var_254_17)
						arg_251_1:RecordAudio("413031059", var_254_17)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413031", "413031059", "story_v_out_413031.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413031", "413031059", "story_v_out_413031.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_18 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_18 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_18

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_18 and arg_251_1.time_ < var_254_8 + var_254_18 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play413031060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 413031060
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play413031061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.733333333333333
			local var_258_1 = 0.491666666666667

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				local var_258_2 = "play"
				local var_258_3 = "effect"

				arg_255_1:AudioAction(var_258_2, var_258_3, "se_story_16", "se_story_16_foot03", "")
			end

			local var_258_4 = 0
			local var_258_5 = 1.225

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(413031060)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 49
				local var_258_9 = utf8.len(var_258_7)
				local var_258_10 = var_258_8 <= 0 and var_258_5 or var_258_5 * (var_258_9 / var_258_8)

				if var_258_10 > 0 and var_258_5 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_11 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_11 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_11

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_11 and arg_255_1.time_ < var_258_4 + var_258_11 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play413031061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 413031061
		arg_259_1.duration_ = 2.57

		local var_259_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_259_0:Play413031062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10093"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos10093 = var_262_0.localPosition
				var_262_0.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10093", 3)

				local var_262_2 = var_262_0.childCount

				for iter_262_0 = 0, var_262_2 - 1 do
					local var_262_3 = var_262_0:GetChild(iter_262_0)

					if var_262_3.name == "" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_4 then
				local var_262_5 = (arg_259_1.time_ - var_262_1) / var_262_4
				local var_262_6 = Vector3.New(0, -345, -245)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10093, var_262_6, var_262_5)
			end

			if arg_259_1.time_ >= var_262_1 + var_262_4 and arg_259_1.time_ < var_262_1 + var_262_4 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_262_7 = arg_259_1.actors_["10093"]
			local var_262_8 = 0

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 and not isNil(var_262_7) and arg_259_1.var_.actorSpriteComps10093 == nil then
				arg_259_1.var_.actorSpriteComps10093 = var_262_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_9 = 2

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_9 and not isNil(var_262_7) then
				local var_262_10 = (arg_259_1.time_ - var_262_8) / var_262_9

				if arg_259_1.var_.actorSpriteComps10093 then
					for iter_262_1, iter_262_2 in pairs(arg_259_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_262_2 then
							if arg_259_1.isInRecall_ then
								local var_262_11 = Mathf.Lerp(iter_262_2.color.r, arg_259_1.hightColor1.r, var_262_10)
								local var_262_12 = Mathf.Lerp(iter_262_2.color.g, arg_259_1.hightColor1.g, var_262_10)
								local var_262_13 = Mathf.Lerp(iter_262_2.color.b, arg_259_1.hightColor1.b, var_262_10)

								iter_262_2.color = Color.New(var_262_11, var_262_12, var_262_13)
							else
								local var_262_14 = Mathf.Lerp(iter_262_2.color.r, 1, var_262_10)

								iter_262_2.color = Color.New(var_262_14, var_262_14, var_262_14)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_8 + var_262_9 and arg_259_1.time_ < var_262_8 + var_262_9 + arg_262_0 and not isNil(var_262_7) and arg_259_1.var_.actorSpriteComps10093 then
				for iter_262_3, iter_262_4 in pairs(arg_259_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_262_4 then
						if arg_259_1.isInRecall_ then
							iter_262_4.color = arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_262_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10093 = nil
			end

			local var_262_15 = 0
			local var_262_16 = 0.075

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[28].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(413031061)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 3
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031061", "story_v_out_413031.awb") ~= 0 then
					local var_262_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031061", "story_v_out_413031.awb") / 1000

					if var_262_23 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_15
					end

					if var_262_18.prefab_name ~= "" and arg_259_1.actors_[var_262_18.prefab_name] ~= nil then
						local var_262_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_18.prefab_name].transform, "story_v_out_413031", "413031061", "story_v_out_413031.awb")

						arg_259_1:RecordAudio("413031061", var_262_24)
						arg_259_1:RecordAudio("413031061", var_262_24)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_413031", "413031061", "story_v_out_413031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_413031", "413031061", "story_v_out_413031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_25 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_25 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_25

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_25 and arg_259_1.time_ < var_262_15 + var_262_25 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play413031062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 413031062
		arg_263_1.duration_ = 7.3

		local var_263_0 = {
			zh = 4.1,
			ja = 7.3
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
				arg_263_0:Play413031063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10093"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10093 == nil then
				arg_263_1.var_.actorSpriteComps10093 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10093 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor2.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor2.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor2.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 0.5, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10093 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10093 = nil
			end

			local var_266_8 = 0
			local var_266_9 = 0.35

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_10 = arg_263_1:FormatText(StoryNameCfg[492].name)

				arg_263_1.leftNameTxt_.text = var_266_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_11 = arg_263_1:GetWordFromCfg(413031062)
				local var_266_12 = arg_263_1:FormatText(var_266_11.content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 14
				local var_266_14 = utf8.len(var_266_12)
				local var_266_15 = var_266_13 <= 0 and var_266_9 or var_266_9 * (var_266_14 / var_266_13)

				if var_266_15 > 0 and var_266_9 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031062", "story_v_out_413031.awb") ~= 0 then
					local var_266_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031062", "story_v_out_413031.awb") / 1000

					if var_266_16 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_16 + var_266_8
					end

					if var_266_11.prefab_name ~= "" and arg_263_1.actors_[var_266_11.prefab_name] ~= nil then
						local var_266_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_11.prefab_name].transform, "story_v_out_413031", "413031062", "story_v_out_413031.awb")

						arg_263_1:RecordAudio("413031062", var_266_17)
						arg_263_1:RecordAudio("413031062", var_266_17)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_413031", "413031062", "story_v_out_413031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_413031", "413031062", "story_v_out_413031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_18 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_18 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_18

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_18 and arg_263_1.time_ < var_266_8 + var_266_18 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play413031063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413031063
		arg_267_1.duration_ = 7.47

		local var_267_0 = {
			zh = 4.4,
			ja = 7.466
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
				arg_267_0:Play413031064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 0.425

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_2 = arg_267_1:FormatText(StoryNameCfg[492].name)

				arg_267_1.leftNameTxt_.text = var_270_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:GetWordFromCfg(413031063)
				local var_270_4 = arg_267_1:FormatText(var_270_3.content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 17
				local var_270_6 = utf8.len(var_270_4)
				local var_270_7 = var_270_5 <= 0 and var_270_1 or var_270_1 * (var_270_6 / var_270_5)

				if var_270_7 > 0 and var_270_1 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031063", "story_v_out_413031.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031063", "story_v_out_413031.awb") / 1000

					if var_270_8 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_0
					end

					if var_270_3.prefab_name ~= "" and arg_267_1.actors_[var_270_3.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_3.prefab_name].transform, "story_v_out_413031", "413031063", "story_v_out_413031.awb")

						arg_267_1:RecordAudio("413031063", var_270_9)
						arg_267_1:RecordAudio("413031063", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413031", "413031063", "story_v_out_413031.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413031", "413031063", "story_v_out_413031.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_10 and arg_267_1.time_ < var_270_0 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413031064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413031064
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play413031065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10093"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos10093 = var_274_0.localPosition
				var_274_0.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10093", 3)

				local var_274_2 = var_274_0.childCount

				for iter_274_0 = 0, var_274_2 - 1 do
					local var_274_3 = var_274_0:GetChild(iter_274_0)

					if var_274_3.name == "split_4" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_4 then
				local var_274_5 = (arg_271_1.time_ - var_274_1) / var_274_4
				local var_274_6 = Vector3.New(0, -345, -245)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10093, var_274_6, var_274_5)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_4 and arg_271_1.time_ < var_274_1 + var_274_4 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_274_7 = arg_271_1.actors_["10093"]
			local var_274_8 = 0

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps10093 == nil then
				arg_271_1.var_.actorSpriteComps10093 = var_274_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_9 = 2

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 and not isNil(var_274_7) then
				local var_274_10 = (arg_271_1.time_ - var_274_8) / var_274_9

				if arg_271_1.var_.actorSpriteComps10093 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_274_2 then
							if arg_271_1.isInRecall_ then
								local var_274_11 = Mathf.Lerp(iter_274_2.color.r, arg_271_1.hightColor1.r, var_274_10)
								local var_274_12 = Mathf.Lerp(iter_274_2.color.g, arg_271_1.hightColor1.g, var_274_10)
								local var_274_13 = Mathf.Lerp(iter_274_2.color.b, arg_271_1.hightColor1.b, var_274_10)

								iter_274_2.color = Color.New(var_274_11, var_274_12, var_274_13)
							else
								local var_274_14 = Mathf.Lerp(iter_274_2.color.r, 1, var_274_10)

								iter_274_2.color = Color.New(var_274_14, var_274_14, var_274_14)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps10093 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_274_4 then
						if arg_271_1.isInRecall_ then
							iter_274_4.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10093 = nil
			end

			local var_274_15 = 0
			local var_274_16 = 0.05

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[28].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(413031064)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 2
				local var_274_21 = utf8.len(var_274_19)
				local var_274_22 = var_274_20 <= 0 and var_274_16 or var_274_16 * (var_274_21 / var_274_20)

				if var_274_22 > 0 and var_274_16 < var_274_22 then
					arg_271_1.talkMaxDuration = var_274_22

					if var_274_22 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_22 + var_274_15
					end
				end

				arg_271_1.text_.text = var_274_19
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031064", "story_v_out_413031.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031064", "story_v_out_413031.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_413031", "413031064", "story_v_out_413031.awb")

						arg_271_1:RecordAudio("413031064", var_274_24)
						arg_271_1:RecordAudio("413031064", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413031", "413031064", "story_v_out_413031.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413031", "413031064", "story_v_out_413031.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_25 = math.max(var_274_16, arg_271_1.talkMaxDuration)

			if var_274_15 <= arg_271_1.time_ and arg_271_1.time_ < var_274_15 + var_274_25 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_15) / var_274_25

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_15 + var_274_25 and arg_271_1.time_ < var_274_15 + var_274_25 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play413031065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 413031065
		arg_275_1.duration_ = 10.57

		local var_275_0 = {
			zh = 6.866,
			ja = 10.566
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
				arg_275_0:Play413031066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = "10096"

			if arg_275_1.actors_[var_278_0] == nil then
				local var_278_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_278_1) then
					local var_278_2 = Object.Instantiate(var_278_1, arg_275_1.canvasGo_.transform)

					var_278_2.transform:SetSiblingIndex(1)

					var_278_2.name = var_278_0
					var_278_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_275_1.actors_[var_278_0] = var_278_2

					local var_278_3 = var_278_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_275_1.isInRecall_ then
						for iter_278_0, iter_278_1 in ipairs(var_278_3) do
							iter_278_1.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_278_4 = arg_275_1.actors_["10096"].transform
			local var_278_5 = 0

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.var_.moveOldPos10096 = var_278_4.localPosition
				var_278_4.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10096", 2)

				local var_278_6 = var_278_4.childCount

				for iter_278_2 = 0, var_278_6 - 1 do
					local var_278_7 = var_278_4:GetChild(iter_278_2)

					if var_278_7.name == "" or not string.find(var_278_7.name, "split") then
						var_278_7.gameObject:SetActive(true)
					else
						var_278_7.gameObject:SetActive(false)
					end
				end
			end

			local var_278_8 = 0.001

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_8 then
				local var_278_9 = (arg_275_1.time_ - var_278_5) / var_278_8
				local var_278_10 = Vector3.New(-390, -350, -210)

				var_278_4.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10096, var_278_10, var_278_9)
			end

			if arg_275_1.time_ >= var_278_5 + var_278_8 and arg_275_1.time_ < var_278_5 + var_278_8 + arg_278_0 then
				var_278_4.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_278_11 = arg_275_1.actors_["10096"]
			local var_278_12 = 0

			if var_278_12 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 and not isNil(var_278_11) and arg_275_1.var_.actorSpriteComps10096 == nil then
				arg_275_1.var_.actorSpriteComps10096 = var_278_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_13 = 2

			if var_278_12 <= arg_275_1.time_ and arg_275_1.time_ < var_278_12 + var_278_13 and not isNil(var_278_11) then
				local var_278_14 = (arg_275_1.time_ - var_278_12) / var_278_13

				if arg_275_1.var_.actorSpriteComps10096 then
					for iter_278_3, iter_278_4 in pairs(arg_275_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_278_4 then
							if arg_275_1.isInRecall_ then
								local var_278_15 = Mathf.Lerp(iter_278_4.color.r, arg_275_1.hightColor1.r, var_278_14)
								local var_278_16 = Mathf.Lerp(iter_278_4.color.g, arg_275_1.hightColor1.g, var_278_14)
								local var_278_17 = Mathf.Lerp(iter_278_4.color.b, arg_275_1.hightColor1.b, var_278_14)

								iter_278_4.color = Color.New(var_278_15, var_278_16, var_278_17)
							else
								local var_278_18 = Mathf.Lerp(iter_278_4.color.r, 1, var_278_14)

								iter_278_4.color = Color.New(var_278_18, var_278_18, var_278_18)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_12 + var_278_13 and arg_275_1.time_ < var_278_12 + var_278_13 + arg_278_0 and not isNil(var_278_11) and arg_275_1.var_.actorSpriteComps10096 then
				for iter_278_5, iter_278_6 in pairs(arg_275_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_278_6 then
						if arg_275_1.isInRecall_ then
							iter_278_6.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10096 = nil
			end

			local var_278_19 = arg_275_1.actors_["10093"]
			local var_278_20 = 0

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 and not isNil(var_278_19) and arg_275_1.var_.actorSpriteComps10093 == nil then
				arg_275_1.var_.actorSpriteComps10093 = var_278_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_21 = 2

			if var_278_20 <= arg_275_1.time_ and arg_275_1.time_ < var_278_20 + var_278_21 and not isNil(var_278_19) then
				local var_278_22 = (arg_275_1.time_ - var_278_20) / var_278_21

				if arg_275_1.var_.actorSpriteComps10093 then
					for iter_278_7, iter_278_8 in pairs(arg_275_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_278_8 then
							if arg_275_1.isInRecall_ then
								local var_278_23 = Mathf.Lerp(iter_278_8.color.r, arg_275_1.hightColor2.r, var_278_22)
								local var_278_24 = Mathf.Lerp(iter_278_8.color.g, arg_275_1.hightColor2.g, var_278_22)
								local var_278_25 = Mathf.Lerp(iter_278_8.color.b, arg_275_1.hightColor2.b, var_278_22)

								iter_278_8.color = Color.New(var_278_23, var_278_24, var_278_25)
							else
								local var_278_26 = Mathf.Lerp(iter_278_8.color.r, 0.5, var_278_22)

								iter_278_8.color = Color.New(var_278_26, var_278_26, var_278_26)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_20 + var_278_21 and arg_275_1.time_ < var_278_20 + var_278_21 + arg_278_0 and not isNil(var_278_19) and arg_275_1.var_.actorSpriteComps10093 then
				for iter_278_9, iter_278_10 in pairs(arg_275_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_278_10 then
						if arg_275_1.isInRecall_ then
							iter_278_10.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10093 = nil
			end

			local var_278_27 = arg_275_1.actors_["10096"]
			local var_278_28 = 0

			if var_278_28 < arg_275_1.time_ and arg_275_1.time_ <= var_278_28 + arg_278_0 then
				local var_278_29 = var_278_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_278_29 then
					arg_275_1.var_.alphaOldValue10096 = var_278_29.alpha
					arg_275_1.var_.characterEffect10096 = var_278_29
				end

				arg_275_1.var_.alphaOldValue10096 = 0
			end

			local var_278_30 = 0.2

			if var_278_28 <= arg_275_1.time_ and arg_275_1.time_ < var_278_28 + var_278_30 then
				local var_278_31 = (arg_275_1.time_ - var_278_28) / var_278_30
				local var_278_32 = Mathf.Lerp(arg_275_1.var_.alphaOldValue10096, 1, var_278_31)

				if arg_275_1.var_.characterEffect10096 then
					arg_275_1.var_.characterEffect10096.alpha = var_278_32
				end
			end

			if arg_275_1.time_ >= var_278_28 + var_278_30 and arg_275_1.time_ < var_278_28 + var_278_30 + arg_278_0 and arg_275_1.var_.characterEffect10096 then
				arg_275_1.var_.characterEffect10096.alpha = 1
			end

			local var_278_33 = arg_275_1.actors_["10093"].transform
			local var_278_34 = 0

			if var_278_34 < arg_275_1.time_ and arg_275_1.time_ <= var_278_34 + arg_278_0 then
				arg_275_1.var_.moveOldPos10093 = var_278_33.localPosition
				var_278_33.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10093", 4)

				local var_278_35 = var_278_33.childCount

				for iter_278_11 = 0, var_278_35 - 1 do
					local var_278_36 = var_278_33:GetChild(iter_278_11)

					if var_278_36.name == "" or not string.find(var_278_36.name, "split") then
						var_278_36.gameObject:SetActive(true)
					else
						var_278_36.gameObject:SetActive(false)
					end
				end
			end

			local var_278_37 = 0.001

			if var_278_34 <= arg_275_1.time_ and arg_275_1.time_ < var_278_34 + var_278_37 then
				local var_278_38 = (arg_275_1.time_ - var_278_34) / var_278_37
				local var_278_39 = Vector3.New(390, -345, -245)

				var_278_33.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10093, var_278_39, var_278_38)
			end

			if arg_275_1.time_ >= var_278_34 + var_278_37 and arg_275_1.time_ < var_278_34 + var_278_37 + arg_278_0 then
				var_278_33.localPosition = Vector3.New(390, -345, -245)
			end

			local var_278_40 = 0
			local var_278_41 = 0.475

			if var_278_40 < arg_275_1.time_ and arg_275_1.time_ <= var_278_40 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_42 = arg_275_1:FormatText(StoryNameCfg[492].name)

				arg_275_1.leftNameTxt_.text = var_278_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_43 = arg_275_1:GetWordFromCfg(413031065)
				local var_278_44 = arg_275_1:FormatText(var_278_43.content)

				arg_275_1.text_.text = var_278_44

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_45 = 19
				local var_278_46 = utf8.len(var_278_44)
				local var_278_47 = var_278_45 <= 0 and var_278_41 or var_278_41 * (var_278_46 / var_278_45)

				if var_278_47 > 0 and var_278_41 < var_278_47 then
					arg_275_1.talkMaxDuration = var_278_47

					if var_278_47 + var_278_40 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_47 + var_278_40
					end
				end

				arg_275_1.text_.text = var_278_44
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031065", "story_v_out_413031.awb") ~= 0 then
					local var_278_48 = manager.audio:GetVoiceLength("story_v_out_413031", "413031065", "story_v_out_413031.awb") / 1000

					if var_278_48 + var_278_40 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_48 + var_278_40
					end

					if var_278_43.prefab_name ~= "" and arg_275_1.actors_[var_278_43.prefab_name] ~= nil then
						local var_278_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_43.prefab_name].transform, "story_v_out_413031", "413031065", "story_v_out_413031.awb")

						arg_275_1:RecordAudio("413031065", var_278_49)
						arg_275_1:RecordAudio("413031065", var_278_49)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_413031", "413031065", "story_v_out_413031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_413031", "413031065", "story_v_out_413031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_50 = math.max(var_278_41, arg_275_1.talkMaxDuration)

			if var_278_40 <= arg_275_1.time_ and arg_275_1.time_ < var_278_40 + var_278_50 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_40) / var_278_50

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_40 + var_278_50 and arg_275_1.time_ < var_278_40 + var_278_50 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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

		arg_275_1:InitPlayNodeList()
	end,
	Play413031066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 413031066
		arg_279_1.duration_ = 3.67

		local var_279_0 = {
			zh = 3.666,
			ja = 1.999999999999
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
				arg_279_0:Play413031067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10093"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10093 == nil then
				arg_279_1.var_.actorSpriteComps10093 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps10093 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps10093 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10093 = nil
			end

			local var_282_8 = arg_279_1.actors_["10096"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10096 == nil then
				arg_279_1.var_.actorSpriteComps10096 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps10096 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10096 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10096 = nil
			end

			local var_282_16 = 0
			local var_282_17 = 0.3

			if var_282_16 < arg_279_1.time_ and arg_279_1.time_ <= var_282_16 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_18 = arg_279_1:FormatText(StoryNameCfg[28].name)

				arg_279_1.leftNameTxt_.text = var_282_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_19 = arg_279_1:GetWordFromCfg(413031066)
				local var_282_20 = arg_279_1:FormatText(var_282_19.content)

				arg_279_1.text_.text = var_282_20

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_21 = 12
				local var_282_22 = utf8.len(var_282_20)
				local var_282_23 = var_282_21 <= 0 and var_282_17 or var_282_17 * (var_282_22 / var_282_21)

				if var_282_23 > 0 and var_282_17 < var_282_23 then
					arg_279_1.talkMaxDuration = var_282_23

					if var_282_23 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_16
					end
				end

				arg_279_1.text_.text = var_282_20
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031066", "story_v_out_413031.awb") ~= 0 then
					local var_282_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031066", "story_v_out_413031.awb") / 1000

					if var_282_24 + var_282_16 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_24 + var_282_16
					end

					if var_282_19.prefab_name ~= "" and arg_279_1.actors_[var_282_19.prefab_name] ~= nil then
						local var_282_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_19.prefab_name].transform, "story_v_out_413031", "413031066", "story_v_out_413031.awb")

						arg_279_1:RecordAudio("413031066", var_282_25)
						arg_279_1:RecordAudio("413031066", var_282_25)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_413031", "413031066", "story_v_out_413031.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_413031", "413031066", "story_v_out_413031.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_26 = math.max(var_282_17, arg_279_1.talkMaxDuration)

			if var_282_16 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_26 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_16) / var_282_26

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_16 + var_282_26 and arg_279_1.time_ < var_282_16 + var_282_26 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play413031067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 413031067
		arg_283_1.duration_ = 7.33

		local var_283_0 = {
			zh = 6.3,
			ja = 7.333
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
				arg_283_0:Play413031068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10096"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10096 == nil then
				arg_283_1.var_.actorSpriteComps10096 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10096 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 1, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10096 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10096 = nil
			end

			local var_286_8 = arg_283_1.actors_["10093"]
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps10093 == nil then
				arg_283_1.var_.actorSpriteComps10093 = var_286_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_10 = 2

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_10 and not isNil(var_286_8) then
				local var_286_11 = (arg_283_1.time_ - var_286_9) / var_286_10

				if arg_283_1.var_.actorSpriteComps10093 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_286_5 then
							if arg_283_1.isInRecall_ then
								local var_286_12 = Mathf.Lerp(iter_286_5.color.r, arg_283_1.hightColor2.r, var_286_11)
								local var_286_13 = Mathf.Lerp(iter_286_5.color.g, arg_283_1.hightColor2.g, var_286_11)
								local var_286_14 = Mathf.Lerp(iter_286_5.color.b, arg_283_1.hightColor2.b, var_286_11)

								iter_286_5.color = Color.New(var_286_12, var_286_13, var_286_14)
							else
								local var_286_15 = Mathf.Lerp(iter_286_5.color.r, 0.5, var_286_11)

								iter_286_5.color = Color.New(var_286_15, var_286_15, var_286_15)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_9 + var_286_10 and arg_283_1.time_ < var_286_9 + var_286_10 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps10093 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_286_7 then
						if arg_283_1.isInRecall_ then
							iter_286_7.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10093 = nil
			end

			local var_286_16 = 0
			local var_286_17 = 0.425

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_18 = arg_283_1:FormatText(StoryNameCfg[492].name)

				arg_283_1.leftNameTxt_.text = var_286_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_19 = arg_283_1:GetWordFromCfg(413031067)
				local var_286_20 = arg_283_1:FormatText(var_286_19.content)

				arg_283_1.text_.text = var_286_20

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_21 = 17
				local var_286_22 = utf8.len(var_286_20)
				local var_286_23 = var_286_21 <= 0 and var_286_17 or var_286_17 * (var_286_22 / var_286_21)

				if var_286_23 > 0 and var_286_17 < var_286_23 then
					arg_283_1.talkMaxDuration = var_286_23

					if var_286_23 + var_286_16 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_23 + var_286_16
					end
				end

				arg_283_1.text_.text = var_286_20
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031067", "story_v_out_413031.awb") ~= 0 then
					local var_286_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031067", "story_v_out_413031.awb") / 1000

					if var_286_24 + var_286_16 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_24 + var_286_16
					end

					if var_286_19.prefab_name ~= "" and arg_283_1.actors_[var_286_19.prefab_name] ~= nil then
						local var_286_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_19.prefab_name].transform, "story_v_out_413031", "413031067", "story_v_out_413031.awb")

						arg_283_1:RecordAudio("413031067", var_286_25)
						arg_283_1:RecordAudio("413031067", var_286_25)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_413031", "413031067", "story_v_out_413031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_413031", "413031067", "story_v_out_413031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_26 = math.max(var_286_17, arg_283_1.talkMaxDuration)

			if var_286_16 <= arg_283_1.time_ and arg_283_1.time_ < var_286_16 + var_286_26 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_16) / var_286_26

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_16 + var_286_26 and arg_283_1.time_ < var_286_16 + var_286_26 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play413031068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 413031068
		arg_287_1.duration_ = 2

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play413031069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10093"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10093 == nil then
				arg_287_1.var_.actorSpriteComps10093 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10093 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10093 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10093 = nil
			end

			local var_290_8 = arg_287_1.actors_["10096"]
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10096 == nil then
				arg_287_1.var_.actorSpriteComps10096 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_10 = 2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 and not isNil(var_290_8) then
				local var_290_11 = (arg_287_1.time_ - var_290_9) / var_290_10

				if arg_287_1.var_.actorSpriteComps10096 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_290_5 then
							if arg_287_1.isInRecall_ then
								local var_290_12 = Mathf.Lerp(iter_290_5.color.r, arg_287_1.hightColor2.r, var_290_11)
								local var_290_13 = Mathf.Lerp(iter_290_5.color.g, arg_287_1.hightColor2.g, var_290_11)
								local var_290_14 = Mathf.Lerp(iter_290_5.color.b, arg_287_1.hightColor2.b, var_290_11)

								iter_290_5.color = Color.New(var_290_12, var_290_13, var_290_14)
							else
								local var_290_15 = Mathf.Lerp(iter_290_5.color.r, 0.5, var_290_11)

								iter_290_5.color = Color.New(var_290_15, var_290_15, var_290_15)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps10096 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_290_7 then
						if arg_287_1.isInRecall_ then
							iter_290_7.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10096 = nil
			end

			local var_290_16 = 0
			local var_290_17 = 0.225

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_18 = arg_287_1:FormatText(StoryNameCfg[28].name)

				arg_287_1.leftNameTxt_.text = var_290_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:GetWordFromCfg(413031068)
				local var_290_20 = arg_287_1:FormatText(var_290_19.content)

				arg_287_1.text_.text = var_290_20

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 9
				local var_290_22 = utf8.len(var_290_20)
				local var_290_23 = var_290_21 <= 0 and var_290_17 or var_290_17 * (var_290_22 / var_290_21)

				if var_290_23 > 0 and var_290_17 < var_290_23 then
					arg_287_1.talkMaxDuration = var_290_23

					if var_290_23 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_16
					end
				end

				arg_287_1.text_.text = var_290_20
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031068", "story_v_out_413031.awb") ~= 0 then
					local var_290_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031068", "story_v_out_413031.awb") / 1000

					if var_290_24 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_24 + var_290_16
					end

					if var_290_19.prefab_name ~= "" and arg_287_1.actors_[var_290_19.prefab_name] ~= nil then
						local var_290_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_19.prefab_name].transform, "story_v_out_413031", "413031068", "story_v_out_413031.awb")

						arg_287_1:RecordAudio("413031068", var_290_25)
						arg_287_1:RecordAudio("413031068", var_290_25)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_413031", "413031068", "story_v_out_413031.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_413031", "413031068", "story_v_out_413031.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_26 = math.max(var_290_17, arg_287_1.talkMaxDuration)

			if var_290_16 <= arg_287_1.time_ and arg_287_1.time_ < var_290_16 + var_290_26 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_16) / var_290_26

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_16 + var_290_26 and arg_287_1.time_ < var_290_16 + var_290_26 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play413031069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 413031069
		arg_291_1.duration_ = 11.9

		local var_291_0 = {
			zh = 4.033,
			ja = 11.9
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
				arg_291_0:Play413031070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10096"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10096 == nil then
				arg_291_1.var_.actorSpriteComps10096 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps10096 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps10096 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10096 = nil
			end

			local var_294_8 = arg_291_1.actors_["10093"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10093 == nil then
				arg_291_1.var_.actorSpriteComps10093 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps10093 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10093 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10093 = nil
			end

			local var_294_16 = 0
			local var_294_17 = 0.35

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_18 = arg_291_1:FormatText(StoryNameCfg[492].name)

				arg_291_1.leftNameTxt_.text = var_294_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_19 = arg_291_1:GetWordFromCfg(413031069)
				local var_294_20 = arg_291_1:FormatText(var_294_19.content)

				arg_291_1.text_.text = var_294_20

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_21 = 14
				local var_294_22 = utf8.len(var_294_20)
				local var_294_23 = var_294_21 <= 0 and var_294_17 or var_294_17 * (var_294_22 / var_294_21)

				if var_294_23 > 0 and var_294_17 < var_294_23 then
					arg_291_1.talkMaxDuration = var_294_23

					if var_294_23 + var_294_16 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_23 + var_294_16
					end
				end

				arg_291_1.text_.text = var_294_20
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031069", "story_v_out_413031.awb") ~= 0 then
					local var_294_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031069", "story_v_out_413031.awb") / 1000

					if var_294_24 + var_294_16 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_24 + var_294_16
					end

					if var_294_19.prefab_name ~= "" and arg_291_1.actors_[var_294_19.prefab_name] ~= nil then
						local var_294_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_19.prefab_name].transform, "story_v_out_413031", "413031069", "story_v_out_413031.awb")

						arg_291_1:RecordAudio("413031069", var_294_25)
						arg_291_1:RecordAudio("413031069", var_294_25)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_413031", "413031069", "story_v_out_413031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_413031", "413031069", "story_v_out_413031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_26 = math.max(var_294_17, arg_291_1.talkMaxDuration)

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_26 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_16) / var_294_26

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_16 + var_294_26 and arg_291_1.time_ < var_294_16 + var_294_26 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play413031070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413031070
		arg_295_1.duration_ = 8.13

		local var_295_0 = {
			zh = 3.7,
			ja = 8.133
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
				arg_295_0:Play413031071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10093"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10093 = var_298_0.localPosition
				var_298_0.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10093", 4)

				local var_298_2 = var_298_0.childCount

				for iter_298_0 = 0, var_298_2 - 1 do
					local var_298_3 = var_298_0:GetChild(iter_298_0)

					if var_298_3.name == "split_3" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_4 then
				local var_298_5 = (arg_295_1.time_ - var_298_1) / var_298_4
				local var_298_6 = Vector3.New(390, -345, -245)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10093, var_298_6, var_298_5)
			end

			if arg_295_1.time_ >= var_298_1 + var_298_4 and arg_295_1.time_ < var_298_1 + var_298_4 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_298_7 = arg_295_1.actors_["10093"]
			local var_298_8 = 0

			if var_298_8 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 and not isNil(var_298_7) and arg_295_1.var_.actorSpriteComps10093 == nil then
				arg_295_1.var_.actorSpriteComps10093 = var_298_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_9 = 2

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_9 and not isNil(var_298_7) then
				local var_298_10 = (arg_295_1.time_ - var_298_8) / var_298_9

				if arg_295_1.var_.actorSpriteComps10093 then
					for iter_298_1, iter_298_2 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_298_2 then
							if arg_295_1.isInRecall_ then
								local var_298_11 = Mathf.Lerp(iter_298_2.color.r, arg_295_1.hightColor1.r, var_298_10)
								local var_298_12 = Mathf.Lerp(iter_298_2.color.g, arg_295_1.hightColor1.g, var_298_10)
								local var_298_13 = Mathf.Lerp(iter_298_2.color.b, arg_295_1.hightColor1.b, var_298_10)

								iter_298_2.color = Color.New(var_298_11, var_298_12, var_298_13)
							else
								local var_298_14 = Mathf.Lerp(iter_298_2.color.r, 1, var_298_10)

								iter_298_2.color = Color.New(var_298_14, var_298_14, var_298_14)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_8 + var_298_9 and arg_295_1.time_ < var_298_8 + var_298_9 + arg_298_0 and not isNil(var_298_7) and arg_295_1.var_.actorSpriteComps10093 then
				for iter_298_3, iter_298_4 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_298_4 then
						if arg_295_1.isInRecall_ then
							iter_298_4.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10093 = nil
			end

			local var_298_15 = arg_295_1.actors_["10096"]
			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.actorSpriteComps10096 == nil then
				arg_295_1.var_.actorSpriteComps10096 = var_298_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_17 = 2

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 and not isNil(var_298_15) then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17

				if arg_295_1.var_.actorSpriteComps10096 then
					for iter_298_5, iter_298_6 in pairs(arg_295_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_298_6 then
							if arg_295_1.isInRecall_ then
								local var_298_19 = Mathf.Lerp(iter_298_6.color.r, arg_295_1.hightColor2.r, var_298_18)
								local var_298_20 = Mathf.Lerp(iter_298_6.color.g, arg_295_1.hightColor2.g, var_298_18)
								local var_298_21 = Mathf.Lerp(iter_298_6.color.b, arg_295_1.hightColor2.b, var_298_18)

								iter_298_6.color = Color.New(var_298_19, var_298_20, var_298_21)
							else
								local var_298_22 = Mathf.Lerp(iter_298_6.color.r, 0.5, var_298_18)

								iter_298_6.color = Color.New(var_298_22, var_298_22, var_298_22)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 and not isNil(var_298_15) and arg_295_1.var_.actorSpriteComps10096 then
				for iter_298_7, iter_298_8 in pairs(arg_295_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_298_8 then
						if arg_295_1.isInRecall_ then
							iter_298_8.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10096 = nil
			end

			local var_298_23 = 0
			local var_298_24 = 0.45

			if var_298_23 < arg_295_1.time_ and arg_295_1.time_ <= var_298_23 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_25 = arg_295_1:FormatText(StoryNameCfg[28].name)

				arg_295_1.leftNameTxt_.text = var_298_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_26 = arg_295_1:GetWordFromCfg(413031070)
				local var_298_27 = arg_295_1:FormatText(var_298_26.content)

				arg_295_1.text_.text = var_298_27

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_28 = 18
				local var_298_29 = utf8.len(var_298_27)
				local var_298_30 = var_298_28 <= 0 and var_298_24 or var_298_24 * (var_298_29 / var_298_28)

				if var_298_30 > 0 and var_298_24 < var_298_30 then
					arg_295_1.talkMaxDuration = var_298_30

					if var_298_30 + var_298_23 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_30 + var_298_23
					end
				end

				arg_295_1.text_.text = var_298_27
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031070", "story_v_out_413031.awb") ~= 0 then
					local var_298_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031070", "story_v_out_413031.awb") / 1000

					if var_298_31 + var_298_23 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_31 + var_298_23
					end

					if var_298_26.prefab_name ~= "" and arg_295_1.actors_[var_298_26.prefab_name] ~= nil then
						local var_298_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_26.prefab_name].transform, "story_v_out_413031", "413031070", "story_v_out_413031.awb")

						arg_295_1:RecordAudio("413031070", var_298_32)
						arg_295_1:RecordAudio("413031070", var_298_32)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413031", "413031070", "story_v_out_413031.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413031", "413031070", "story_v_out_413031.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_33 = math.max(var_298_24, arg_295_1.talkMaxDuration)

			if var_298_23 <= arg_295_1.time_ and arg_295_1.time_ < var_298_23 + var_298_33 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_23) / var_298_33

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_23 + var_298_33 and arg_295_1.time_ < var_298_23 + var_298_33 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play413031071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413031071
		arg_299_1.duration_ = 9.17

		local var_299_0 = {
			zh = 8.5,
			ja = 9.166
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
				arg_299_0:Play413031072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10096"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10096 == nil then
				arg_299_1.var_.actorSpriteComps10096 = var_302_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_2 = 2

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.actorSpriteComps10096 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.actorSpriteComps10096 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_302_3 then
						if arg_299_1.isInRecall_ then
							iter_302_3.color = arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_302_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10096 = nil
			end

			local var_302_8 = arg_299_1.actors_["10093"]
			local var_302_9 = 0

			if var_302_9 < arg_299_1.time_ and arg_299_1.time_ <= var_302_9 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps10093 == nil then
				arg_299_1.var_.actorSpriteComps10093 = var_302_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_10 = 2

			if var_302_9 <= arg_299_1.time_ and arg_299_1.time_ < var_302_9 + var_302_10 and not isNil(var_302_8) then
				local var_302_11 = (arg_299_1.time_ - var_302_9) / var_302_10

				if arg_299_1.var_.actorSpriteComps10093 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								local var_302_12 = Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, var_302_11)
								local var_302_13 = Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, var_302_11)
								local var_302_14 = Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, var_302_11)

								iter_302_5.color = Color.New(var_302_12, var_302_13, var_302_14)
							else
								local var_302_15 = Mathf.Lerp(iter_302_5.color.r, 0.5, var_302_11)

								iter_302_5.color = Color.New(var_302_15, var_302_15, var_302_15)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= var_302_9 + var_302_10 and arg_299_1.time_ < var_302_9 + var_302_10 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.actorSpriteComps10093 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_302_7 then
						if arg_299_1.isInRecall_ then
							iter_302_7.color = arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_302_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_299_1.var_.actorSpriteComps10093 = nil
			end

			local var_302_16 = 0
			local var_302_17 = 0.775

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_18 = arg_299_1:FormatText(StoryNameCfg[492].name)

				arg_299_1.leftNameTxt_.text = var_302_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_19 = arg_299_1:GetWordFromCfg(413031071)
				local var_302_20 = arg_299_1:FormatText(var_302_19.content)

				arg_299_1.text_.text = var_302_20

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_21 = 31
				local var_302_22 = utf8.len(var_302_20)
				local var_302_23 = var_302_21 <= 0 and var_302_17 or var_302_17 * (var_302_22 / var_302_21)

				if var_302_23 > 0 and var_302_17 < var_302_23 then
					arg_299_1.talkMaxDuration = var_302_23

					if var_302_23 + var_302_16 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_16
					end
				end

				arg_299_1.text_.text = var_302_20
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031071", "story_v_out_413031.awb") ~= 0 then
					local var_302_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031071", "story_v_out_413031.awb") / 1000

					if var_302_24 + var_302_16 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_24 + var_302_16
					end

					if var_302_19.prefab_name ~= "" and arg_299_1.actors_[var_302_19.prefab_name] ~= nil then
						local var_302_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_19.prefab_name].transform, "story_v_out_413031", "413031071", "story_v_out_413031.awb")

						arg_299_1:RecordAudio("413031071", var_302_25)
						arg_299_1:RecordAudio("413031071", var_302_25)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413031", "413031071", "story_v_out_413031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413031", "413031071", "story_v_out_413031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_26 = math.max(var_302_17, arg_299_1.talkMaxDuration)

			if var_302_16 <= arg_299_1.time_ and arg_299_1.time_ < var_302_16 + var_302_26 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_16) / var_302_26

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_16 + var_302_26 and arg_299_1.time_ < var_302_16 + var_302_26 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play413031072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413031072
		arg_303_1.duration_ = 3.13

		local var_303_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_303_0:Play413031073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10093"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos10093 = var_306_0.localPosition
				var_306_0.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10093", 4)

				local var_306_2 = var_306_0.childCount

				for iter_306_0 = 0, var_306_2 - 1 do
					local var_306_3 = var_306_0:GetChild(iter_306_0)

					if var_306_3.name == "" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_4 then
				local var_306_5 = (arg_303_1.time_ - var_306_1) / var_306_4
				local var_306_6 = Vector3.New(390, -345, -245)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10093, var_306_6, var_306_5)
			end

			if arg_303_1.time_ >= var_306_1 + var_306_4 and arg_303_1.time_ < var_306_1 + var_306_4 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_306_7 = arg_303_1.actors_["10093"]
			local var_306_8 = 0

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 and not isNil(var_306_7) and arg_303_1.var_.actorSpriteComps10093 == nil then
				arg_303_1.var_.actorSpriteComps10093 = var_306_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_9 = 2

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_9 and not isNil(var_306_7) then
				local var_306_10 = (arg_303_1.time_ - var_306_8) / var_306_9

				if arg_303_1.var_.actorSpriteComps10093 then
					for iter_306_1, iter_306_2 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_306_2 then
							if arg_303_1.isInRecall_ then
								local var_306_11 = Mathf.Lerp(iter_306_2.color.r, arg_303_1.hightColor1.r, var_306_10)
								local var_306_12 = Mathf.Lerp(iter_306_2.color.g, arg_303_1.hightColor1.g, var_306_10)
								local var_306_13 = Mathf.Lerp(iter_306_2.color.b, arg_303_1.hightColor1.b, var_306_10)

								iter_306_2.color = Color.New(var_306_11, var_306_12, var_306_13)
							else
								local var_306_14 = Mathf.Lerp(iter_306_2.color.r, 1, var_306_10)

								iter_306_2.color = Color.New(var_306_14, var_306_14, var_306_14)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_8 + var_306_9 and arg_303_1.time_ < var_306_8 + var_306_9 + arg_306_0 and not isNil(var_306_7) and arg_303_1.var_.actorSpriteComps10093 then
				for iter_306_3, iter_306_4 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_306_4 then
						if arg_303_1.isInRecall_ then
							iter_306_4.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10093 = nil
			end

			local var_306_15 = arg_303_1.actors_["10096"]
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 and not isNil(var_306_15) and arg_303_1.var_.actorSpriteComps10096 == nil then
				arg_303_1.var_.actorSpriteComps10096 = var_306_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_17 = 2

			if var_306_16 <= arg_303_1.time_ and arg_303_1.time_ < var_306_16 + var_306_17 and not isNil(var_306_15) then
				local var_306_18 = (arg_303_1.time_ - var_306_16) / var_306_17

				if arg_303_1.var_.actorSpriteComps10096 then
					for iter_306_5, iter_306_6 in pairs(arg_303_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_306_6 then
							if arg_303_1.isInRecall_ then
								local var_306_19 = Mathf.Lerp(iter_306_6.color.r, arg_303_1.hightColor2.r, var_306_18)
								local var_306_20 = Mathf.Lerp(iter_306_6.color.g, arg_303_1.hightColor2.g, var_306_18)
								local var_306_21 = Mathf.Lerp(iter_306_6.color.b, arg_303_1.hightColor2.b, var_306_18)

								iter_306_6.color = Color.New(var_306_19, var_306_20, var_306_21)
							else
								local var_306_22 = Mathf.Lerp(iter_306_6.color.r, 0.5, var_306_18)

								iter_306_6.color = Color.New(var_306_22, var_306_22, var_306_22)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_16 + var_306_17 and arg_303_1.time_ < var_306_16 + var_306_17 + arg_306_0 and not isNil(var_306_15) and arg_303_1.var_.actorSpriteComps10096 then
				for iter_306_7, iter_306_8 in pairs(arg_303_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_306_8 then
						if arg_303_1.isInRecall_ then
							iter_306_8.color = arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_306_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10096 = nil
			end

			local var_306_23 = 0
			local var_306_24 = 0.2

			if var_306_23 < arg_303_1.time_ and arg_303_1.time_ <= var_306_23 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_25 = arg_303_1:FormatText(StoryNameCfg[28].name)

				arg_303_1.leftNameTxt_.text = var_306_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_26 = arg_303_1:GetWordFromCfg(413031072)
				local var_306_27 = arg_303_1:FormatText(var_306_26.content)

				arg_303_1.text_.text = var_306_27

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_28 = 8
				local var_306_29 = utf8.len(var_306_27)
				local var_306_30 = var_306_28 <= 0 and var_306_24 or var_306_24 * (var_306_29 / var_306_28)

				if var_306_30 > 0 and var_306_24 < var_306_30 then
					arg_303_1.talkMaxDuration = var_306_30

					if var_306_30 + var_306_23 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_30 + var_306_23
					end
				end

				arg_303_1.text_.text = var_306_27
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031072", "story_v_out_413031.awb") ~= 0 then
					local var_306_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031072", "story_v_out_413031.awb") / 1000

					if var_306_31 + var_306_23 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_31 + var_306_23
					end

					if var_306_26.prefab_name ~= "" and arg_303_1.actors_[var_306_26.prefab_name] ~= nil then
						local var_306_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_26.prefab_name].transform, "story_v_out_413031", "413031072", "story_v_out_413031.awb")

						arg_303_1:RecordAudio("413031072", var_306_32)
						arg_303_1:RecordAudio("413031072", var_306_32)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413031", "413031072", "story_v_out_413031.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413031", "413031072", "story_v_out_413031.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_33 = math.max(var_306_24, arg_303_1.talkMaxDuration)

			if var_306_23 <= arg_303_1.time_ and arg_303_1.time_ < var_306_23 + var_306_33 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_23) / var_306_33

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_23 + var_306_33 and arg_303_1.time_ < var_306_23 + var_306_33 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play413031073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413031073
		arg_307_1.duration_ = 10.73

		local var_307_0 = {
			zh = 5.266,
			ja = 10.733
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
				arg_307_0:Play413031074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["10096"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10096 == nil then
				arg_307_1.var_.actorSpriteComps10096 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps10096 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps10096 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10096 = nil
			end

			local var_310_8 = arg_307_1.actors_["10093"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10093 == nil then
				arg_307_1.var_.actorSpriteComps10093 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps10093 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10093 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10093 = nil
			end

			local var_310_16 = 0
			local var_310_17 = 0.575

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_18 = arg_307_1:FormatText(StoryNameCfg[492].name)

				arg_307_1.leftNameTxt_.text = var_310_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_19 = arg_307_1:GetWordFromCfg(413031073)
				local var_310_20 = arg_307_1:FormatText(var_310_19.content)

				arg_307_1.text_.text = var_310_20

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_21 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031073", "story_v_out_413031.awb") ~= 0 then
					local var_310_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031073", "story_v_out_413031.awb") / 1000

					if var_310_24 + var_310_16 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_24 + var_310_16
					end

					if var_310_19.prefab_name ~= "" and arg_307_1.actors_[var_310_19.prefab_name] ~= nil then
						local var_310_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_19.prefab_name].transform, "story_v_out_413031", "413031073", "story_v_out_413031.awb")

						arg_307_1:RecordAudio("413031073", var_310_25)
						arg_307_1:RecordAudio("413031073", var_310_25)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413031", "413031073", "story_v_out_413031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413031", "413031073", "story_v_out_413031.awb")
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
	Play413031074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 413031074
		arg_311_1.duration_ = 10.73

		local var_311_0 = {
			zh = 7.166,
			ja = 10.733
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
				arg_311_0:Play413031075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.6

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[492].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:GetWordFromCfg(413031074)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 24
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031074", "story_v_out_413031.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031074", "story_v_out_413031.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_413031", "413031074", "story_v_out_413031.awb")

						arg_311_1:RecordAudio("413031074", var_314_9)
						arg_311_1:RecordAudio("413031074", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_413031", "413031074", "story_v_out_413031.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_413031", "413031074", "story_v_out_413031.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play413031075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413031075
		arg_315_1.duration_ = 4

		local var_315_0 = {
			zh = 2.5,
			ja = 4
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
				arg_315_0:Play413031076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["10093"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10093 == nil then
				arg_315_1.var_.actorSpriteComps10093 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps10093 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 1, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps10093 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10093 = nil
			end

			local var_318_8 = arg_315_1.actors_["10096"]
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10096 == nil then
				arg_315_1.var_.actorSpriteComps10096 = var_318_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_10 = 2

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_10 and not isNil(var_318_8) then
				local var_318_11 = (arg_315_1.time_ - var_318_9) / var_318_10

				if arg_315_1.var_.actorSpriteComps10096 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								local var_318_12 = Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, var_318_11)
								local var_318_13 = Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, var_318_11)
								local var_318_14 = Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, var_318_11)

								iter_318_5.color = Color.New(var_318_12, var_318_13, var_318_14)
							else
								local var_318_15 = Mathf.Lerp(iter_318_5.color.r, 0.5, var_318_11)

								iter_318_5.color = Color.New(var_318_15, var_318_15, var_318_15)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_9 + var_318_10 and arg_315_1.time_ < var_318_9 + var_318_10 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10096 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_318_7 then
						if arg_315_1.isInRecall_ then
							iter_318_7.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10096 = nil
			end

			local var_318_16 = 0
			local var_318_17 = 0.4

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_18 = arg_315_1:FormatText(StoryNameCfg[28].name)

				arg_315_1.leftNameTxt_.text = var_318_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_19 = arg_315_1:GetWordFromCfg(413031075)
				local var_318_20 = arg_315_1:FormatText(var_318_19.content)

				arg_315_1.text_.text = var_318_20

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_21 = 16
				local var_318_22 = utf8.len(var_318_20)
				local var_318_23 = var_318_21 <= 0 and var_318_17 or var_318_17 * (var_318_22 / var_318_21)

				if var_318_23 > 0 and var_318_17 < var_318_23 then
					arg_315_1.talkMaxDuration = var_318_23

					if var_318_23 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_23 + var_318_16
					end
				end

				arg_315_1.text_.text = var_318_20
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031075", "story_v_out_413031.awb") ~= 0 then
					local var_318_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031075", "story_v_out_413031.awb") / 1000

					if var_318_24 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_16
					end

					if var_318_19.prefab_name ~= "" and arg_315_1.actors_[var_318_19.prefab_name] ~= nil then
						local var_318_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_19.prefab_name].transform, "story_v_out_413031", "413031075", "story_v_out_413031.awb")

						arg_315_1:RecordAudio("413031075", var_318_25)
						arg_315_1:RecordAudio("413031075", var_318_25)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413031", "413031075", "story_v_out_413031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413031", "413031075", "story_v_out_413031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_26 = math.max(var_318_17, arg_315_1.talkMaxDuration)

			if var_318_16 <= arg_315_1.time_ and arg_315_1.time_ < var_318_16 + var_318_26 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_16) / var_318_26

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_16 + var_318_26 and arg_315_1.time_ < var_318_16 + var_318_26 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play413031076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413031076
		arg_319_1.duration_ = 15.23

		local var_319_0 = {
			zh = 8,
			ja = 15.233
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
				arg_319_0:Play413031077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10096"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos10096 = var_322_0.localPosition
				var_322_0.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10096", 2)

				local var_322_2 = var_322_0.childCount

				for iter_322_0 = 0, var_322_2 - 1 do
					local var_322_3 = var_322_0:GetChild(iter_322_0)

					if var_322_3.name == "" or not string.find(var_322_3.name, "split") then
						var_322_3.gameObject:SetActive(true)
					else
						var_322_3.gameObject:SetActive(false)
					end
				end
			end

			local var_322_4 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_4 then
				local var_322_5 = (arg_319_1.time_ - var_322_1) / var_322_4
				local var_322_6 = Vector3.New(-390, -350, -210)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10096, var_322_6, var_322_5)
			end

			if arg_319_1.time_ >= var_322_1 + var_322_4 and arg_319_1.time_ < var_322_1 + var_322_4 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_322_7 = arg_319_1.actors_["10096"]
			local var_322_8 = 0

			if var_322_8 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.actorSpriteComps10096 == nil then
				arg_319_1.var_.actorSpriteComps10096 = var_322_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_9 = 2

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_9 and not isNil(var_322_7) then
				local var_322_10 = (arg_319_1.time_ - var_322_8) / var_322_9

				if arg_319_1.var_.actorSpriteComps10096 then
					for iter_322_1, iter_322_2 in pairs(arg_319_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_322_2 then
							if arg_319_1.isInRecall_ then
								local var_322_11 = Mathf.Lerp(iter_322_2.color.r, arg_319_1.hightColor1.r, var_322_10)
								local var_322_12 = Mathf.Lerp(iter_322_2.color.g, arg_319_1.hightColor1.g, var_322_10)
								local var_322_13 = Mathf.Lerp(iter_322_2.color.b, arg_319_1.hightColor1.b, var_322_10)

								iter_322_2.color = Color.New(var_322_11, var_322_12, var_322_13)
							else
								local var_322_14 = Mathf.Lerp(iter_322_2.color.r, 1, var_322_10)

								iter_322_2.color = Color.New(var_322_14, var_322_14, var_322_14)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_8 + var_322_9 and arg_319_1.time_ < var_322_8 + var_322_9 + arg_322_0 and not isNil(var_322_7) and arg_319_1.var_.actorSpriteComps10096 then
				for iter_322_3, iter_322_4 in pairs(arg_319_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_322_4 then
						if arg_319_1.isInRecall_ then
							iter_322_4.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10096 = nil
			end

			local var_322_15 = arg_319_1.actors_["10093"]
			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.actorSpriteComps10093 == nil then
				arg_319_1.var_.actorSpriteComps10093 = var_322_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_17 = 2

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 and not isNil(var_322_15) then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17

				if arg_319_1.var_.actorSpriteComps10093 then
					for iter_322_5, iter_322_6 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_322_6 then
							if arg_319_1.isInRecall_ then
								local var_322_19 = Mathf.Lerp(iter_322_6.color.r, arg_319_1.hightColor2.r, var_322_18)
								local var_322_20 = Mathf.Lerp(iter_322_6.color.g, arg_319_1.hightColor2.g, var_322_18)
								local var_322_21 = Mathf.Lerp(iter_322_6.color.b, arg_319_1.hightColor2.b, var_322_18)

								iter_322_6.color = Color.New(var_322_19, var_322_20, var_322_21)
							else
								local var_322_22 = Mathf.Lerp(iter_322_6.color.r, 0.5, var_322_18)

								iter_322_6.color = Color.New(var_322_22, var_322_22, var_322_22)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 and not isNil(var_322_15) and arg_319_1.var_.actorSpriteComps10093 then
				for iter_322_7, iter_322_8 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_322_8 then
						if arg_319_1.isInRecall_ then
							iter_322_8.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10093 = nil
			end

			local var_322_23 = 0
			local var_322_24 = 0.725

			if var_322_23 < arg_319_1.time_ and arg_319_1.time_ <= var_322_23 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_25 = arg_319_1:FormatText(StoryNameCfg[492].name)

				arg_319_1.leftNameTxt_.text = var_322_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_26 = arg_319_1:GetWordFromCfg(413031076)
				local var_322_27 = arg_319_1:FormatText(var_322_26.content)

				arg_319_1.text_.text = var_322_27

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_28 = 29
				local var_322_29 = utf8.len(var_322_27)
				local var_322_30 = var_322_28 <= 0 and var_322_24 or var_322_24 * (var_322_29 / var_322_28)

				if var_322_30 > 0 and var_322_24 < var_322_30 then
					arg_319_1.talkMaxDuration = var_322_30

					if var_322_30 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_30 + var_322_23
					end
				end

				arg_319_1.text_.text = var_322_27
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031076", "story_v_out_413031.awb") ~= 0 then
					local var_322_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031076", "story_v_out_413031.awb") / 1000

					if var_322_31 + var_322_23 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_31 + var_322_23
					end

					if var_322_26.prefab_name ~= "" and arg_319_1.actors_[var_322_26.prefab_name] ~= nil then
						local var_322_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_26.prefab_name].transform, "story_v_out_413031", "413031076", "story_v_out_413031.awb")

						arg_319_1:RecordAudio("413031076", var_322_32)
						arg_319_1:RecordAudio("413031076", var_322_32)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_413031", "413031076", "story_v_out_413031.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_413031", "413031076", "story_v_out_413031.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_33 = math.max(var_322_24, arg_319_1.talkMaxDuration)

			if var_322_23 <= arg_319_1.time_ and arg_319_1.time_ < var_322_23 + var_322_33 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_23) / var_322_33

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_23 + var_322_33 and arg_319_1.time_ < var_322_23 + var_322_33 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play413031077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413031077
		arg_323_1.duration_ = 7.9

		local var_323_0 = {
			zh = 3.466,
			ja = 7.9
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
				arg_323_0:Play413031078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0
			local var_326_1 = 0.3

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_2 = arg_323_1:FormatText(StoryNameCfg[492].name)

				arg_323_1.leftNameTxt_.text = var_326_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_3 = arg_323_1:GetWordFromCfg(413031077)
				local var_326_4 = arg_323_1:FormatText(var_326_3.content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 12
				local var_326_6 = utf8.len(var_326_4)
				local var_326_7 = var_326_5 <= 0 and var_326_1 or var_326_1 * (var_326_6 / var_326_5)

				if var_326_7 > 0 and var_326_1 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_0
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031077", "story_v_out_413031.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031077", "story_v_out_413031.awb") / 1000

					if var_326_8 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_0
					end

					if var_326_3.prefab_name ~= "" and arg_323_1.actors_[var_326_3.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_3.prefab_name].transform, "story_v_out_413031", "413031077", "story_v_out_413031.awb")

						arg_323_1:RecordAudio("413031077", var_326_9)
						arg_323_1:RecordAudio("413031077", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413031", "413031077", "story_v_out_413031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413031", "413031077", "story_v_out_413031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_1, arg_323_1.talkMaxDuration)

			if var_326_0 <= arg_323_1.time_ and arg_323_1.time_ < var_326_0 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_0) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_0 + var_326_10 and arg_323_1.time_ < var_326_0 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play413031078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413031078
		arg_327_1.duration_ = 2.9

		local var_327_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_327_0:Play413031079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10093"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos10093 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10093", 4)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "split_3" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(390, -345, -245)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10093, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_330_7 = arg_327_1.actors_["10096"].transform
			local var_330_8 = 0

			if var_330_8 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.var_.moveOldPos10096 = var_330_7.localPosition
				var_330_7.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10096", 2)

				local var_330_9 = var_330_7.childCount

				for iter_330_1 = 0, var_330_9 - 1 do
					local var_330_10 = var_330_7:GetChild(iter_330_1)

					if var_330_10.name == "" or not string.find(var_330_10.name, "split") then
						var_330_10.gameObject:SetActive(true)
					else
						var_330_10.gameObject:SetActive(false)
					end
				end
			end

			local var_330_11 = 0.001

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_11 then
				local var_330_12 = (arg_327_1.time_ - var_330_8) / var_330_11
				local var_330_13 = Vector3.New(-390, -350, -210)

				var_330_7.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10096, var_330_13, var_330_12)
			end

			if arg_327_1.time_ >= var_330_8 + var_330_11 and arg_327_1.time_ < var_330_8 + var_330_11 + arg_330_0 then
				var_330_7.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_330_14 = arg_327_1.actors_["10093"]
			local var_330_15 = 0

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 and not isNil(var_330_14) and arg_327_1.var_.actorSpriteComps10093 == nil then
				arg_327_1.var_.actorSpriteComps10093 = var_330_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_16 = 2

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_16 and not isNil(var_330_14) then
				local var_330_17 = (arg_327_1.time_ - var_330_15) / var_330_16

				if arg_327_1.var_.actorSpriteComps10093 then
					for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_330_3 then
							if arg_327_1.isInRecall_ then
								local var_330_18 = Mathf.Lerp(iter_330_3.color.r, arg_327_1.hightColor1.r, var_330_17)
								local var_330_19 = Mathf.Lerp(iter_330_3.color.g, arg_327_1.hightColor1.g, var_330_17)
								local var_330_20 = Mathf.Lerp(iter_330_3.color.b, arg_327_1.hightColor1.b, var_330_17)

								iter_330_3.color = Color.New(var_330_18, var_330_19, var_330_20)
							else
								local var_330_21 = Mathf.Lerp(iter_330_3.color.r, 1, var_330_17)

								iter_330_3.color = Color.New(var_330_21, var_330_21, var_330_21)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_15 + var_330_16 and arg_327_1.time_ < var_330_15 + var_330_16 + arg_330_0 and not isNil(var_330_14) and arg_327_1.var_.actorSpriteComps10093 then
				for iter_330_4, iter_330_5 in pairs(arg_327_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_330_5 then
						if arg_327_1.isInRecall_ then
							iter_330_5.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10093 = nil
			end

			local var_330_22 = arg_327_1.actors_["10096"]
			local var_330_23 = 0

			if var_330_23 < arg_327_1.time_ and arg_327_1.time_ <= var_330_23 + arg_330_0 and not isNil(var_330_22) and arg_327_1.var_.actorSpriteComps10096 == nil then
				arg_327_1.var_.actorSpriteComps10096 = var_330_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_24 = 2

			if var_330_23 <= arg_327_1.time_ and arg_327_1.time_ < var_330_23 + var_330_24 and not isNil(var_330_22) then
				local var_330_25 = (arg_327_1.time_ - var_330_23) / var_330_24

				if arg_327_1.var_.actorSpriteComps10096 then
					for iter_330_6, iter_330_7 in pairs(arg_327_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_330_7 then
							if arg_327_1.isInRecall_ then
								local var_330_26 = Mathf.Lerp(iter_330_7.color.r, arg_327_1.hightColor2.r, var_330_25)
								local var_330_27 = Mathf.Lerp(iter_330_7.color.g, arg_327_1.hightColor2.g, var_330_25)
								local var_330_28 = Mathf.Lerp(iter_330_7.color.b, arg_327_1.hightColor2.b, var_330_25)

								iter_330_7.color = Color.New(var_330_26, var_330_27, var_330_28)
							else
								local var_330_29 = Mathf.Lerp(iter_330_7.color.r, 0.5, var_330_25)

								iter_330_7.color = Color.New(var_330_29, var_330_29, var_330_29)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_23 + var_330_24 and arg_327_1.time_ < var_330_23 + var_330_24 + arg_330_0 and not isNil(var_330_22) and arg_327_1.var_.actorSpriteComps10096 then
				for iter_330_8, iter_330_9 in pairs(arg_327_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_330_9 then
						if arg_327_1.isInRecall_ then
							iter_330_9.color = arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_330_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10096 = nil
			end

			local var_330_30 = 0
			local var_330_31 = 0.15

			if var_330_30 < arg_327_1.time_ and arg_327_1.time_ <= var_330_30 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_32 = arg_327_1:FormatText(StoryNameCfg[28].name)

				arg_327_1.leftNameTxt_.text = var_330_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_33 = arg_327_1:GetWordFromCfg(413031078)
				local var_330_34 = arg_327_1:FormatText(var_330_33.content)

				arg_327_1.text_.text = var_330_34

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_35 = 6
				local var_330_36 = utf8.len(var_330_34)
				local var_330_37 = var_330_35 <= 0 and var_330_31 or var_330_31 * (var_330_36 / var_330_35)

				if var_330_37 > 0 and var_330_31 < var_330_37 then
					arg_327_1.talkMaxDuration = var_330_37

					if var_330_37 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_37 + var_330_30
					end
				end

				arg_327_1.text_.text = var_330_34
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031078", "story_v_out_413031.awb") ~= 0 then
					local var_330_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031078", "story_v_out_413031.awb") / 1000

					if var_330_38 + var_330_30 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_38 + var_330_30
					end

					if var_330_33.prefab_name ~= "" and arg_327_1.actors_[var_330_33.prefab_name] ~= nil then
						local var_330_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_33.prefab_name].transform, "story_v_out_413031", "413031078", "story_v_out_413031.awb")

						arg_327_1:RecordAudio("413031078", var_330_39)
						arg_327_1:RecordAudio("413031078", var_330_39)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413031", "413031078", "story_v_out_413031.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413031", "413031078", "story_v_out_413031.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_40 = math.max(var_330_31, arg_327_1.talkMaxDuration)

			if var_330_30 <= arg_327_1.time_ and arg_327_1.time_ < var_330_30 + var_330_40 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_30) / var_330_40

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_30 + var_330_40 and arg_327_1.time_ < var_330_30 + var_330_40 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play413031079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413031079
		arg_331_1.duration_ = 9.2

		local var_331_0 = {
			zh = 9.2,
			ja = 8.9
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
				arg_331_0:Play413031080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10093"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos10093 = var_334_0.localPosition
				var_334_0.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10093", 4)

				local var_334_2 = var_334_0.childCount

				for iter_334_0 = 0, var_334_2 - 1 do
					local var_334_3 = var_334_0:GetChild(iter_334_0)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_4 then
				local var_334_5 = (arg_331_1.time_ - var_334_1) / var_334_4
				local var_334_6 = Vector3.New(390, -345, -245)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10093, var_334_6, var_334_5)
			end

			if arg_331_1.time_ >= var_334_1 + var_334_4 and arg_331_1.time_ < var_334_1 + var_334_4 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_334_7 = arg_331_1.actors_["10096"]
			local var_334_8 = 0

			if var_334_8 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps10096 == nil then
				arg_331_1.var_.actorSpriteComps10096 = var_334_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_9 = 2

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_9 and not isNil(var_334_7) then
				local var_334_10 = (arg_331_1.time_ - var_334_8) / var_334_9

				if arg_331_1.var_.actorSpriteComps10096 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_331_1.time_ >= var_334_8 + var_334_9 and arg_331_1.time_ < var_334_8 + var_334_9 + arg_334_0 and not isNil(var_334_7) and arg_331_1.var_.actorSpriteComps10096 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_334_4 then
						if arg_331_1.isInRecall_ then
							iter_334_4.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10096 = nil
			end

			local var_334_15 = arg_331_1.actors_["10093"]
			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps10093 == nil then
				arg_331_1.var_.actorSpriteComps10093 = var_334_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_17 = 2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 and not isNil(var_334_15) then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17

				if arg_331_1.var_.actorSpriteComps10093 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 and not isNil(var_334_15) and arg_331_1.var_.actorSpriteComps10093 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_334_8 then
						if arg_331_1.isInRecall_ then
							iter_334_8.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10093 = nil
			end

			local var_334_23 = 0
			local var_334_24 = 0.675

			if var_334_23 < arg_331_1.time_ and arg_331_1.time_ <= var_334_23 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_25 = arg_331_1:FormatText(StoryNameCfg[492].name)

				arg_331_1.leftNameTxt_.text = var_334_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_26 = arg_331_1:GetWordFromCfg(413031079)
				local var_334_27 = arg_331_1:FormatText(var_334_26.content)

				arg_331_1.text_.text = var_334_27

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_28 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031079", "story_v_out_413031.awb") ~= 0 then
					local var_334_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031079", "story_v_out_413031.awb") / 1000

					if var_334_31 + var_334_23 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_31 + var_334_23
					end

					if var_334_26.prefab_name ~= "" and arg_331_1.actors_[var_334_26.prefab_name] ~= nil then
						local var_334_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_26.prefab_name].transform, "story_v_out_413031", "413031079", "story_v_out_413031.awb")

						arg_331_1:RecordAudio("413031079", var_334_32)
						arg_331_1:RecordAudio("413031079", var_334_32)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413031", "413031079", "story_v_out_413031.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413031", "413031079", "story_v_out_413031.awb")
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
				actorName = "10093",
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
	Play413031080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413031080
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play413031081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10096"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos10096 = var_338_0.localPosition
				var_338_0.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10096", 2)

				local var_338_2 = var_338_0.childCount

				for iter_338_0 = 0, var_338_2 - 1 do
					local var_338_3 = var_338_0:GetChild(iter_338_0)

					if var_338_3.name == "" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_4 then
				local var_338_5 = (arg_335_1.time_ - var_338_1) / var_338_4
				local var_338_6 = Vector3.New(-390, -350, -210)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10096, var_338_6, var_338_5)
			end

			if arg_335_1.time_ >= var_338_1 + var_338_4 and arg_335_1.time_ < var_338_1 + var_338_4 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_338_7 = arg_335_1.actors_["10096"]
			local var_338_8 = 0

			if var_338_8 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 and not isNil(var_338_7) and arg_335_1.var_.actorSpriteComps10096 == nil then
				arg_335_1.var_.actorSpriteComps10096 = var_338_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_9 = 2

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_9 and not isNil(var_338_7) then
				local var_338_10 = (arg_335_1.time_ - var_338_8) / var_338_9

				if arg_335_1.var_.actorSpriteComps10096 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								local var_338_11 = Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor2.r, var_338_10)
								local var_338_12 = Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor2.g, var_338_10)
								local var_338_13 = Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor2.b, var_338_10)

								iter_338_2.color = Color.New(var_338_11, var_338_12, var_338_13)
							else
								local var_338_14 = Mathf.Lerp(iter_338_2.color.r, 0.5, var_338_10)

								iter_338_2.color = Color.New(var_338_14, var_338_14, var_338_14)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_8 + var_338_9 and arg_335_1.time_ < var_338_8 + var_338_9 + arg_338_0 and not isNil(var_338_7) and arg_335_1.var_.actorSpriteComps10096 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_338_4 then
						if arg_335_1.isInRecall_ then
							iter_338_4.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10096 = nil
			end

			local var_338_15 = 0
			local var_338_16 = 1.2

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_17 = arg_335_1:GetWordFromCfg(413031080)
				local var_338_18 = arg_335_1:FormatText(var_338_17.content)

				arg_335_1.text_.text = var_338_18

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_19 = 48
				local var_338_20 = utf8.len(var_338_18)
				local var_338_21 = var_338_19 <= 0 and var_338_16 or var_338_16 * (var_338_20 / var_338_19)

				if var_338_21 > 0 and var_338_16 < var_338_21 then
					arg_335_1.talkMaxDuration = var_338_21

					if var_338_21 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_21 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_18
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_22 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_22 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_22

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_22 and arg_335_1.time_ < var_338_15 + var_338_22 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play413031081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413031081
		arg_339_1.duration_ = 15.53

		local var_339_0 = {
			zh = 8.166,
			ja = 15.533
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
				arg_339_0:Play413031082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10096"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos10096 = var_342_0.localPosition
				var_342_0.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10096", 2)

				local var_342_2 = var_342_0.childCount

				for iter_342_0 = 0, var_342_2 - 1 do
					local var_342_3 = var_342_0:GetChild(iter_342_0)

					if var_342_3.name == "" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_4 then
				local var_342_5 = (arg_339_1.time_ - var_342_1) / var_342_4
				local var_342_6 = Vector3.New(-390, -350, -210)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10096, var_342_6, var_342_5)
			end

			if arg_339_1.time_ >= var_342_1 + var_342_4 and arg_339_1.time_ < var_342_1 + var_342_4 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_342_7 = arg_339_1.actors_["10096"]
			local var_342_8 = 0

			if var_342_8 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps10096 == nil then
				arg_339_1.var_.actorSpriteComps10096 = var_342_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_9 = 2

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_9 and not isNil(var_342_7) then
				local var_342_10 = (arg_339_1.time_ - var_342_8) / var_342_9

				if arg_339_1.var_.actorSpriteComps10096 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								local var_342_11 = Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, var_342_10)
								local var_342_12 = Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, var_342_10)
								local var_342_13 = Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, var_342_10)

								iter_342_2.color = Color.New(var_342_11, var_342_12, var_342_13)
							else
								local var_342_14 = Mathf.Lerp(iter_342_2.color.r, 1, var_342_10)

								iter_342_2.color = Color.New(var_342_14, var_342_14, var_342_14)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= var_342_8 + var_342_9 and arg_339_1.time_ < var_342_8 + var_342_9 + arg_342_0 and not isNil(var_342_7) and arg_339_1.var_.actorSpriteComps10096 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_342_4 then
						if arg_339_1.isInRecall_ then
							iter_342_4.color = arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_342_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_339_1.var_.actorSpriteComps10096 = nil
			end

			local var_342_15 = 0
			local var_342_16 = 0.625

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[492].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(413031081)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 25
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031081", "story_v_out_413031.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031081", "story_v_out_413031.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_413031", "413031081", "story_v_out_413031.awb")

						arg_339_1:RecordAudio("413031081", var_342_24)
						arg_339_1:RecordAudio("413031081", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413031", "413031081", "story_v_out_413031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413031", "413031081", "story_v_out_413031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play413031082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413031082
		arg_343_1.duration_ = 3.17

		local var_343_0 = {
			zh = 3.166,
			ja = 2.133
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
				arg_343_0:Play413031083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10093"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos10093 = var_346_0.localPosition
				var_346_0.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10093", 4)

				local var_346_2 = var_346_0.childCount

				for iter_346_0 = 0, var_346_2 - 1 do
					local var_346_3 = var_346_0:GetChild(iter_346_0)

					if var_346_3.name == "split_5" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_4 then
				local var_346_5 = (arg_343_1.time_ - var_346_1) / var_346_4
				local var_346_6 = Vector3.New(390, -345, -245)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10093, var_346_6, var_346_5)
			end

			if arg_343_1.time_ >= var_346_1 + var_346_4 and arg_343_1.time_ < var_346_1 + var_346_4 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_346_7 = arg_343_1.actors_["10096"].transform
			local var_346_8 = 0

			if var_346_8 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.var_.moveOldPos10096 = var_346_7.localPosition
				var_346_7.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10096", 2)

				local var_346_9 = var_346_7.childCount

				for iter_346_1 = 0, var_346_9 - 1 do
					local var_346_10 = var_346_7:GetChild(iter_346_1)

					if var_346_10.name == "" or not string.find(var_346_10.name, "split") then
						var_346_10.gameObject:SetActive(true)
					else
						var_346_10.gameObject:SetActive(false)
					end
				end
			end

			local var_346_11 = 0.001

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_11 then
				local var_346_12 = (arg_343_1.time_ - var_346_8) / var_346_11
				local var_346_13 = Vector3.New(-390, -350, -210)

				var_346_7.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10096, var_346_13, var_346_12)
			end

			if arg_343_1.time_ >= var_346_8 + var_346_11 and arg_343_1.time_ < var_346_8 + var_346_11 + arg_346_0 then
				var_346_7.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_346_14 = arg_343_1.actors_["10093"]
			local var_346_15 = 0

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 and not isNil(var_346_14) and arg_343_1.var_.actorSpriteComps10093 == nil then
				arg_343_1.var_.actorSpriteComps10093 = var_346_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_16 = 2

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_16 and not isNil(var_346_14) then
				local var_346_17 = (arg_343_1.time_ - var_346_15) / var_346_16

				if arg_343_1.var_.actorSpriteComps10093 then
					for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_346_3 then
							if arg_343_1.isInRecall_ then
								local var_346_18 = Mathf.Lerp(iter_346_3.color.r, arg_343_1.hightColor1.r, var_346_17)
								local var_346_19 = Mathf.Lerp(iter_346_3.color.g, arg_343_1.hightColor1.g, var_346_17)
								local var_346_20 = Mathf.Lerp(iter_346_3.color.b, arg_343_1.hightColor1.b, var_346_17)

								iter_346_3.color = Color.New(var_346_18, var_346_19, var_346_20)
							else
								local var_346_21 = Mathf.Lerp(iter_346_3.color.r, 1, var_346_17)

								iter_346_3.color = Color.New(var_346_21, var_346_21, var_346_21)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_15 + var_346_16 and arg_343_1.time_ < var_346_15 + var_346_16 + arg_346_0 and not isNil(var_346_14) and arg_343_1.var_.actorSpriteComps10093 then
				for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_346_5 then
						if arg_343_1.isInRecall_ then
							iter_346_5.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10093 = nil
			end

			local var_346_22 = arg_343_1.actors_["10096"]
			local var_346_23 = 0

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 and not isNil(var_346_22) and arg_343_1.var_.actorSpriteComps10096 == nil then
				arg_343_1.var_.actorSpriteComps10096 = var_346_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_24 = 2

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_24 and not isNil(var_346_22) then
				local var_346_25 = (arg_343_1.time_ - var_346_23) / var_346_24

				if arg_343_1.var_.actorSpriteComps10096 then
					for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_346_7 then
							if arg_343_1.isInRecall_ then
								local var_346_26 = Mathf.Lerp(iter_346_7.color.r, arg_343_1.hightColor2.r, var_346_25)
								local var_346_27 = Mathf.Lerp(iter_346_7.color.g, arg_343_1.hightColor2.g, var_346_25)
								local var_346_28 = Mathf.Lerp(iter_346_7.color.b, arg_343_1.hightColor2.b, var_346_25)

								iter_346_7.color = Color.New(var_346_26, var_346_27, var_346_28)
							else
								local var_346_29 = Mathf.Lerp(iter_346_7.color.r, 0.5, var_346_25)

								iter_346_7.color = Color.New(var_346_29, var_346_29, var_346_29)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_23 + var_346_24 and arg_343_1.time_ < var_346_23 + var_346_24 + arg_346_0 and not isNil(var_346_22) and arg_343_1.var_.actorSpriteComps10096 then
				for iter_346_8, iter_346_9 in pairs(arg_343_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_346_9 then
						if arg_343_1.isInRecall_ then
							iter_346_9.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10096 = nil
			end

			local var_346_30 = 0
			local var_346_31 = 0.2

			if var_346_30 < arg_343_1.time_ and arg_343_1.time_ <= var_346_30 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_32 = arg_343_1:FormatText(StoryNameCfg[28].name)

				arg_343_1.leftNameTxt_.text = var_346_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_33 = arg_343_1:GetWordFromCfg(413031082)
				local var_346_34 = arg_343_1:FormatText(var_346_33.content)

				arg_343_1.text_.text = var_346_34

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_35 = 8
				local var_346_36 = utf8.len(var_346_34)
				local var_346_37 = var_346_35 <= 0 and var_346_31 or var_346_31 * (var_346_36 / var_346_35)

				if var_346_37 > 0 and var_346_31 < var_346_37 then
					arg_343_1.talkMaxDuration = var_346_37

					if var_346_37 + var_346_30 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_37 + var_346_30
					end
				end

				arg_343_1.text_.text = var_346_34
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031082", "story_v_out_413031.awb") ~= 0 then
					local var_346_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031082", "story_v_out_413031.awb") / 1000

					if var_346_38 + var_346_30 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_38 + var_346_30
					end

					if var_346_33.prefab_name ~= "" and arg_343_1.actors_[var_346_33.prefab_name] ~= nil then
						local var_346_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_33.prefab_name].transform, "story_v_out_413031", "413031082", "story_v_out_413031.awb")

						arg_343_1:RecordAudio("413031082", var_346_39)
						arg_343_1:RecordAudio("413031082", var_346_39)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413031", "413031082", "story_v_out_413031.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413031", "413031082", "story_v_out_413031.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_40 = math.max(var_346_31, arg_343_1.talkMaxDuration)

			if var_346_30 <= arg_343_1.time_ and arg_343_1.time_ < var_346_30 + var_346_40 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_30) / var_346_40

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_30 + var_346_40 and arg_343_1.time_ < var_346_30 + var_346_40 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play413031083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413031083
		arg_347_1.duration_ = 12.9

		local var_347_0 = {
			zh = 8.5,
			ja = 12.9
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
				arg_347_0:Play413031084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10096"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos10096 = var_350_0.localPosition
				var_350_0.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10096", 2)

				local var_350_2 = var_350_0.childCount

				for iter_350_0 = 0, var_350_2 - 1 do
					local var_350_3 = var_350_0:GetChild(iter_350_0)

					if var_350_3.name == "" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_1) / var_350_4
				local var_350_6 = Vector3.New(-390, -350, -210)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10096, var_350_6, var_350_5)
			end

			if arg_347_1.time_ >= var_350_1 + var_350_4 and arg_347_1.time_ < var_350_1 + var_350_4 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_350_7 = arg_347_1.actors_["10096"]
			local var_350_8 = 0

			if var_350_8 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps10096 == nil then
				arg_347_1.var_.actorSpriteComps10096 = var_350_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_9 = 2

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_9 and not isNil(var_350_7) then
				local var_350_10 = (arg_347_1.time_ - var_350_8) / var_350_9

				if arg_347_1.var_.actorSpriteComps10096 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								local var_350_11 = Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, var_350_10)
								local var_350_12 = Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, var_350_10)
								local var_350_13 = Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, var_350_10)

								iter_350_2.color = Color.New(var_350_11, var_350_12, var_350_13)
							else
								local var_350_14 = Mathf.Lerp(iter_350_2.color.r, 1, var_350_10)

								iter_350_2.color = Color.New(var_350_14, var_350_14, var_350_14)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_8 + var_350_9 and arg_347_1.time_ < var_350_8 + var_350_9 + arg_350_0 and not isNil(var_350_7) and arg_347_1.var_.actorSpriteComps10096 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_350_4 then
						if arg_347_1.isInRecall_ then
							iter_350_4.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10096 = nil
			end

			local var_350_15 = arg_347_1.actors_["10093"]
			local var_350_16 = 0

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 and not isNil(var_350_15) and arg_347_1.var_.actorSpriteComps10093 == nil then
				arg_347_1.var_.actorSpriteComps10093 = var_350_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_17 = 2

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_17 and not isNil(var_350_15) then
				local var_350_18 = (arg_347_1.time_ - var_350_16) / var_350_17

				if arg_347_1.var_.actorSpriteComps10093 then
					for iter_350_5, iter_350_6 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_350_6 then
							if arg_347_1.isInRecall_ then
								local var_350_19 = Mathf.Lerp(iter_350_6.color.r, arg_347_1.hightColor2.r, var_350_18)
								local var_350_20 = Mathf.Lerp(iter_350_6.color.g, arg_347_1.hightColor2.g, var_350_18)
								local var_350_21 = Mathf.Lerp(iter_350_6.color.b, arg_347_1.hightColor2.b, var_350_18)

								iter_350_6.color = Color.New(var_350_19, var_350_20, var_350_21)
							else
								local var_350_22 = Mathf.Lerp(iter_350_6.color.r, 0.5, var_350_18)

								iter_350_6.color = Color.New(var_350_22, var_350_22, var_350_22)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_16 + var_350_17 and arg_347_1.time_ < var_350_16 + var_350_17 + arg_350_0 and not isNil(var_350_15) and arg_347_1.var_.actorSpriteComps10093 then
				for iter_350_7, iter_350_8 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_350_8 then
						if arg_347_1.isInRecall_ then
							iter_350_8.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10093 = nil
			end

			local var_350_23 = 0
			local var_350_24 = 0.725

			if var_350_23 < arg_347_1.time_ and arg_347_1.time_ <= var_350_23 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_25 = arg_347_1:FormatText(StoryNameCfg[492].name)

				arg_347_1.leftNameTxt_.text = var_350_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_26 = arg_347_1:GetWordFromCfg(413031083)
				local var_350_27 = arg_347_1:FormatText(var_350_26.content)

				arg_347_1.text_.text = var_350_27

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_28 = 29
				local var_350_29 = utf8.len(var_350_27)
				local var_350_30 = var_350_28 <= 0 and var_350_24 or var_350_24 * (var_350_29 / var_350_28)

				if var_350_30 > 0 and var_350_24 < var_350_30 then
					arg_347_1.talkMaxDuration = var_350_30

					if var_350_30 + var_350_23 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_30 + var_350_23
					end
				end

				arg_347_1.text_.text = var_350_27
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031083", "story_v_out_413031.awb") ~= 0 then
					local var_350_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031083", "story_v_out_413031.awb") / 1000

					if var_350_31 + var_350_23 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_31 + var_350_23
					end

					if var_350_26.prefab_name ~= "" and arg_347_1.actors_[var_350_26.prefab_name] ~= nil then
						local var_350_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_26.prefab_name].transform, "story_v_out_413031", "413031083", "story_v_out_413031.awb")

						arg_347_1:RecordAudio("413031083", var_350_32)
						arg_347_1:RecordAudio("413031083", var_350_32)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413031", "413031083", "story_v_out_413031.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413031", "413031083", "story_v_out_413031.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_33 = math.max(var_350_24, arg_347_1.talkMaxDuration)

			if var_350_23 <= arg_347_1.time_ and arg_347_1.time_ < var_350_23 + var_350_33 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_23) / var_350_33

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_23 + var_350_33 and arg_347_1.time_ < var_350_23 + var_350_33 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play413031084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413031084
		arg_351_1.duration_ = 12.27

		local var_351_0 = {
			zh = 5.833,
			ja = 12.266
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
				arg_351_0:Play413031085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			local var_354_1 = 1

			if arg_351_1.time_ >= var_354_0 + var_354_1 and arg_351_1.time_ < var_354_0 + var_354_1 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_2 = 0
			local var_354_3 = 0.425

			if var_354_2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_4 = arg_351_1:FormatText(StoryNameCfg[492].name)

				arg_351_1.leftNameTxt_.text = var_354_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_5 = arg_351_1:GetWordFromCfg(413031084)
				local var_354_6 = arg_351_1:FormatText(var_354_5.content)

				arg_351_1.text_.text = var_354_6

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 17
				local var_354_8 = utf8.len(var_354_6)
				local var_354_9 = var_354_7 <= 0 and var_354_3 or var_354_3 * (var_354_8 / var_354_7)

				if var_354_9 > 0 and var_354_3 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_6
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031084", "story_v_out_413031.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_413031", "413031084", "story_v_out_413031.awb") / 1000

					if var_354_10 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_2
					end

					if var_354_5.prefab_name ~= "" and arg_351_1.actors_[var_354_5.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_5.prefab_name].transform, "story_v_out_413031", "413031084", "story_v_out_413031.awb")

						arg_351_1:RecordAudio("413031084", var_354_11)
						arg_351_1:RecordAudio("413031084", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413031", "413031084", "story_v_out_413031.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413031", "413031084", "story_v_out_413031.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_12 and arg_351_1.time_ < var_354_2 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413031085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413031085
		arg_355_1.duration_ = 6

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413031086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10096"].transform
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.var_.moveOldPos10096 = var_358_0.localPosition
				var_358_0.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10096", 0)

				local var_358_2 = var_358_0.childCount

				for iter_358_0 = 0, var_358_2 - 1 do
					local var_358_3 = var_358_0:GetChild(iter_358_0)

					if var_358_3.name == "" or not string.find(var_358_3.name, "split") then
						var_358_3.gameObject:SetActive(true)
					else
						var_358_3.gameObject:SetActive(false)
					end
				end
			end

			local var_358_4 = 0.001

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_4 then
				local var_358_5 = (arg_355_1.time_ - var_358_1) / var_358_4
				local var_358_6 = Vector3.New(-5000, -350, -210)

				var_358_0.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10096, var_358_6, var_358_5)
			end

			if arg_355_1.time_ >= var_358_1 + var_358_4 and arg_355_1.time_ < var_358_1 + var_358_4 + arg_358_0 then
				var_358_0.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_358_7 = arg_355_1.actors_["10093"].transform
			local var_358_8 = 0

			if var_358_8 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.var_.moveOldPos10093 = var_358_7.localPosition
				var_358_7.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10093", 0)

				local var_358_9 = var_358_7.childCount

				for iter_358_1 = 0, var_358_9 - 1 do
					local var_358_10 = var_358_7:GetChild(iter_358_1)

					if var_358_10.name == "" or not string.find(var_358_10.name, "split") then
						var_358_10.gameObject:SetActive(true)
					else
						var_358_10.gameObject:SetActive(false)
					end
				end
			end

			local var_358_11 = 0.001

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_11 then
				local var_358_12 = (arg_355_1.time_ - var_358_8) / var_358_11
				local var_358_13 = Vector3.New(-5000, -345, -245)

				var_358_7.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10093, var_358_13, var_358_12)
			end

			if arg_355_1.time_ >= var_358_8 + var_358_11 and arg_355_1.time_ < var_358_8 + var_358_11 + arg_358_0 then
				var_358_7.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_358_14 = arg_355_1.actors_["10096"]
			local var_358_15 = 0

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.actorSpriteComps10096 == nil then
				arg_355_1.var_.actorSpriteComps10096 = var_358_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_16 = 2

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_16 and not isNil(var_358_14) then
				local var_358_17 = (arg_355_1.time_ - var_358_15) / var_358_16

				if arg_355_1.var_.actorSpriteComps10096 then
					for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_358_3 then
							if arg_355_1.isInRecall_ then
								local var_358_18 = Mathf.Lerp(iter_358_3.color.r, arg_355_1.hightColor2.r, var_358_17)
								local var_358_19 = Mathf.Lerp(iter_358_3.color.g, arg_355_1.hightColor2.g, var_358_17)
								local var_358_20 = Mathf.Lerp(iter_358_3.color.b, arg_355_1.hightColor2.b, var_358_17)

								iter_358_3.color = Color.New(var_358_18, var_358_19, var_358_20)
							else
								local var_358_21 = Mathf.Lerp(iter_358_3.color.r, 0.5, var_358_17)

								iter_358_3.color = Color.New(var_358_21, var_358_21, var_358_21)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_15 + var_358_16 and arg_355_1.time_ < var_358_15 + var_358_16 + arg_358_0 and not isNil(var_358_14) and arg_355_1.var_.actorSpriteComps10096 then
				for iter_358_4, iter_358_5 in pairs(arg_355_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_358_5 then
						if arg_355_1.isInRecall_ then
							iter_358_5.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10096 = nil
			end

			local var_358_22 = arg_355_1.actors_["10093"]
			local var_358_23 = 0

			if var_358_23 < arg_355_1.time_ and arg_355_1.time_ <= var_358_23 + arg_358_0 and not isNil(var_358_22) and arg_355_1.var_.actorSpriteComps10093 == nil then
				arg_355_1.var_.actorSpriteComps10093 = var_358_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_24 = 2

			if var_358_23 <= arg_355_1.time_ and arg_355_1.time_ < var_358_23 + var_358_24 and not isNil(var_358_22) then
				local var_358_25 = (arg_355_1.time_ - var_358_23) / var_358_24

				if arg_355_1.var_.actorSpriteComps10093 then
					for iter_358_6, iter_358_7 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_358_7 then
							if arg_355_1.isInRecall_ then
								local var_358_26 = Mathf.Lerp(iter_358_7.color.r, arg_355_1.hightColor2.r, var_358_25)
								local var_358_27 = Mathf.Lerp(iter_358_7.color.g, arg_355_1.hightColor2.g, var_358_25)
								local var_358_28 = Mathf.Lerp(iter_358_7.color.b, arg_355_1.hightColor2.b, var_358_25)

								iter_358_7.color = Color.New(var_358_26, var_358_27, var_358_28)
							else
								local var_358_29 = Mathf.Lerp(iter_358_7.color.r, 0.5, var_358_25)

								iter_358_7.color = Color.New(var_358_29, var_358_29, var_358_29)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_23 + var_358_24 and arg_355_1.time_ < var_358_23 + var_358_24 + arg_358_0 and not isNil(var_358_22) and arg_355_1.var_.actorSpriteComps10093 then
				for iter_358_8, iter_358_9 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_358_9 then
						if arg_355_1.isInRecall_ then
							iter_358_9.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10093 = nil
			end

			local var_358_30 = manager.ui.mainCamera.transform
			local var_358_31 = 0

			if var_358_31 < arg_355_1.time_ and arg_355_1.time_ <= var_358_31 + arg_358_0 then
				arg_355_1.var_.shakeOldPos = var_358_30.localPosition
			end

			local var_358_32 = 0.6

			if var_358_31 <= arg_355_1.time_ and arg_355_1.time_ < var_358_31 + var_358_32 then
				local var_358_33 = (arg_355_1.time_ - var_358_31) / 0.066
				local var_358_34, var_358_35 = math.modf(var_358_33)

				var_358_30.localPosition = Vector3.New(var_358_35 * 0.13, var_358_35 * 0.13, var_358_35 * 0.13) + arg_355_1.var_.shakeOldPos
			end

			if arg_355_1.time_ >= var_358_31 + var_358_32 and arg_355_1.time_ < var_358_31 + var_358_32 + arg_358_0 then
				var_358_30.localPosition = arg_355_1.var_.shakeOldPos
			end

			local var_358_36 = 0

			if var_358_36 < arg_355_1.time_ and arg_355_1.time_ <= var_358_36 + arg_358_0 then
				arg_355_1.allBtn_.enabled = false
			end

			local var_358_37 = 0.6

			if arg_355_1.time_ >= var_358_36 + var_358_37 and arg_355_1.time_ < var_358_36 + var_358_37 + arg_358_0 then
				arg_355_1.allBtn_.enabled = true
			end

			if arg_355_1.frameCnt_ <= 1 then
				arg_355_1.dialog_:SetActive(false)
			end

			local var_358_38 = 1
			local var_358_39 = 1.575

			if var_358_38 < arg_355_1.time_ and arg_355_1.time_ <= var_358_38 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				arg_355_1.dialog_:SetActive(true)

				arg_355_1.dialogCg_.alpha = 0

				local var_358_40 = LeanTween.value(arg_355_1.dialog_, 0, 1, 0.3)

				var_358_40:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_355_1.dialogCg_.alpha = arg_359_0
				end))
				var_358_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_355_1.dialog_)
					var_358_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_355_1.duration_ = arg_355_1.duration_ + 0.3

				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_41 = arg_355_1:GetWordFromCfg(413031085)
				local var_358_42 = arg_355_1:FormatText(var_358_41.content)

				arg_355_1.text_.text = var_358_42

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_43 = 63
				local var_358_44 = utf8.len(var_358_42)
				local var_358_45 = var_358_43 <= 0 and var_358_39 or var_358_39 * (var_358_44 / var_358_43)

				if var_358_45 > 0 and var_358_39 < var_358_45 then
					arg_355_1.talkMaxDuration = var_358_45
					var_358_38 = var_358_38 + 0.3

					if var_358_45 + var_358_38 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_45 + var_358_38
					end
				end

				arg_355_1.text_.text = var_358_42
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_46 = var_358_38 + 0.3
			local var_358_47 = math.max(var_358_39, arg_355_1.talkMaxDuration)

			if var_358_46 <= arg_355_1.time_ and arg_355_1.time_ < var_358_46 + var_358_47 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_46) / var_358_47

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_46 + var_358_47 and arg_355_1.time_ < var_358_46 + var_358_47 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
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

		arg_355_1:InitPlayNodeList()
	end,
	Play413031086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 413031086
		arg_361_1.duration_ = 4.47

		local var_361_0 = {
			zh = 3.833,
			ja = 4.466
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
				arg_361_0:Play413031087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10022"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos10022 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10022", 3)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "split_8" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(0, -315, -320)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10022, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_364_7 = arg_361_1.actors_["10022"]
			local var_364_8 = 0

			if var_364_8 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10022 == nil then
				arg_361_1.var_.actorSpriteComps10022 = var_364_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_9 = 2

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_9 and not isNil(var_364_7) then
				local var_364_10 = (arg_361_1.time_ - var_364_8) / var_364_9

				if arg_361_1.var_.actorSpriteComps10022 then
					for iter_364_1, iter_364_2 in pairs(arg_361_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_364_2 then
							if arg_361_1.isInRecall_ then
								local var_364_11 = Mathf.Lerp(iter_364_2.color.r, arg_361_1.hightColor1.r, var_364_10)
								local var_364_12 = Mathf.Lerp(iter_364_2.color.g, arg_361_1.hightColor1.g, var_364_10)
								local var_364_13 = Mathf.Lerp(iter_364_2.color.b, arg_361_1.hightColor1.b, var_364_10)

								iter_364_2.color = Color.New(var_364_11, var_364_12, var_364_13)
							else
								local var_364_14 = Mathf.Lerp(iter_364_2.color.r, 1, var_364_10)

								iter_364_2.color = Color.New(var_364_14, var_364_14, var_364_14)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_8 + var_364_9 and arg_361_1.time_ < var_364_8 + var_364_9 + arg_364_0 and not isNil(var_364_7) and arg_361_1.var_.actorSpriteComps10022 then
				for iter_364_3, iter_364_4 in pairs(arg_361_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_364_4 then
						if arg_361_1.isInRecall_ then
							iter_364_4.color = arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_364_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps10022 = nil
			end

			local var_364_15 = 0
			local var_364_16 = 0.5

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_17 = arg_361_1:FormatText(StoryNameCfg[614].name)

				arg_361_1.leftNameTxt_.text = var_364_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_18 = arg_361_1:GetWordFromCfg(413031086)
				local var_364_19 = arg_361_1:FormatText(var_364_18.content)

				arg_361_1.text_.text = var_364_19

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_20 = 20
				local var_364_21 = utf8.len(var_364_19)
				local var_364_22 = var_364_20 <= 0 and var_364_16 or var_364_16 * (var_364_21 / var_364_20)

				if var_364_22 > 0 and var_364_16 < var_364_22 then
					arg_361_1.talkMaxDuration = var_364_22

					if var_364_22 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_22 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_19
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031086", "story_v_out_413031.awb") ~= 0 then
					local var_364_23 = manager.audio:GetVoiceLength("story_v_out_413031", "413031086", "story_v_out_413031.awb") / 1000

					if var_364_23 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_23 + var_364_15
					end

					if var_364_18.prefab_name ~= "" and arg_361_1.actors_[var_364_18.prefab_name] ~= nil then
						local var_364_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_18.prefab_name].transform, "story_v_out_413031", "413031086", "story_v_out_413031.awb")

						arg_361_1:RecordAudio("413031086", var_364_24)
						arg_361_1:RecordAudio("413031086", var_364_24)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_413031", "413031086", "story_v_out_413031.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_413031", "413031086", "story_v_out_413031.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_25 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_25 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_25

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_25 and arg_361_1.time_ < var_364_15 + var_364_25 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play413031087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 413031087
		arg_365_1.duration_ = 2

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play413031088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10093"].transform
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 then
				arg_365_1.var_.moveOldPos10093 = var_368_0.localPosition
				var_368_0.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10093", 3)

				local var_368_2 = var_368_0.childCount

				for iter_368_0 = 0, var_368_2 - 1 do
					local var_368_3 = var_368_0:GetChild(iter_368_0)

					if var_368_3.name == "split_4" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_4 then
				local var_368_5 = (arg_365_1.time_ - var_368_1) / var_368_4
				local var_368_6 = Vector3.New(0, -345, -245)

				var_368_0.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10093, var_368_6, var_368_5)
			end

			if arg_365_1.time_ >= var_368_1 + var_368_4 and arg_365_1.time_ < var_368_1 + var_368_4 + arg_368_0 then
				var_368_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_368_7 = arg_365_1.actors_["10022"].transform
			local var_368_8 = 0

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.var_.moveOldPos10022 = var_368_7.localPosition
				var_368_7.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10022", 7)

				local var_368_9 = var_368_7.childCount

				for iter_368_1 = 0, var_368_9 - 1 do
					local var_368_10 = var_368_7:GetChild(iter_368_1)

					if var_368_10.name == "" or not string.find(var_368_10.name, "split") then
						var_368_10.gameObject:SetActive(true)
					else
						var_368_10.gameObject:SetActive(false)
					end
				end
			end

			local var_368_11 = 0.001

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_11 then
				local var_368_12 = (arg_365_1.time_ - var_368_8) / var_368_11
				local var_368_13 = Vector3.New(0, -2000, 0)

				var_368_7.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10022, var_368_13, var_368_12)
			end

			if arg_365_1.time_ >= var_368_8 + var_368_11 and arg_365_1.time_ < var_368_8 + var_368_11 + arg_368_0 then
				var_368_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_368_14 = arg_365_1.actors_["10093"]
			local var_368_15 = 0

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 and not isNil(var_368_14) and arg_365_1.var_.actorSpriteComps10093 == nil then
				arg_365_1.var_.actorSpriteComps10093 = var_368_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_16 = 2

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_16 and not isNil(var_368_14) then
				local var_368_17 = (arg_365_1.time_ - var_368_15) / var_368_16

				if arg_365_1.var_.actorSpriteComps10093 then
					for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_368_3 then
							if arg_365_1.isInRecall_ then
								local var_368_18 = Mathf.Lerp(iter_368_3.color.r, arg_365_1.hightColor1.r, var_368_17)
								local var_368_19 = Mathf.Lerp(iter_368_3.color.g, arg_365_1.hightColor1.g, var_368_17)
								local var_368_20 = Mathf.Lerp(iter_368_3.color.b, arg_365_1.hightColor1.b, var_368_17)

								iter_368_3.color = Color.New(var_368_18, var_368_19, var_368_20)
							else
								local var_368_21 = Mathf.Lerp(iter_368_3.color.r, 1, var_368_17)

								iter_368_3.color = Color.New(var_368_21, var_368_21, var_368_21)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_15 + var_368_16 and arg_365_1.time_ < var_368_15 + var_368_16 + arg_368_0 and not isNil(var_368_14) and arg_365_1.var_.actorSpriteComps10093 then
				for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_368_5 then
						if arg_365_1.isInRecall_ then
							iter_368_5.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10093 = nil
			end

			local var_368_22 = arg_365_1.actors_["10022"]
			local var_368_23 = 0

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 and not isNil(var_368_22) and arg_365_1.var_.actorSpriteComps10022 == nil then
				arg_365_1.var_.actorSpriteComps10022 = var_368_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_24 = 2

			if var_368_23 <= arg_365_1.time_ and arg_365_1.time_ < var_368_23 + var_368_24 and not isNil(var_368_22) then
				local var_368_25 = (arg_365_1.time_ - var_368_23) / var_368_24

				if arg_365_1.var_.actorSpriteComps10022 then
					for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_368_7 then
							if arg_365_1.isInRecall_ then
								local var_368_26 = Mathf.Lerp(iter_368_7.color.r, arg_365_1.hightColor2.r, var_368_25)
								local var_368_27 = Mathf.Lerp(iter_368_7.color.g, arg_365_1.hightColor2.g, var_368_25)
								local var_368_28 = Mathf.Lerp(iter_368_7.color.b, arg_365_1.hightColor2.b, var_368_25)

								iter_368_7.color = Color.New(var_368_26, var_368_27, var_368_28)
							else
								local var_368_29 = Mathf.Lerp(iter_368_7.color.r, 0.5, var_368_25)

								iter_368_7.color = Color.New(var_368_29, var_368_29, var_368_29)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_23 + var_368_24 and arg_365_1.time_ < var_368_23 + var_368_24 + arg_368_0 and not isNil(var_368_22) and arg_365_1.var_.actorSpriteComps10022 then
				for iter_368_8, iter_368_9 in pairs(arg_365_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_368_9 then
						if arg_365_1.isInRecall_ then
							iter_368_9.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10022 = nil
			end

			local var_368_30 = 0
			local var_368_31 = 0.1

			if var_368_30 < arg_365_1.time_ and arg_365_1.time_ <= var_368_30 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_32 = arg_365_1:FormatText(StoryNameCfg[28].name)

				arg_365_1.leftNameTxt_.text = var_368_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_33 = arg_365_1:GetWordFromCfg(413031087)
				local var_368_34 = arg_365_1:FormatText(var_368_33.content)

				arg_365_1.text_.text = var_368_34

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_35 = 4
				local var_368_36 = utf8.len(var_368_34)
				local var_368_37 = var_368_35 <= 0 and var_368_31 or var_368_31 * (var_368_36 / var_368_35)

				if var_368_37 > 0 and var_368_31 < var_368_37 then
					arg_365_1.talkMaxDuration = var_368_37

					if var_368_37 + var_368_30 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_37 + var_368_30
					end
				end

				arg_365_1.text_.text = var_368_34
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031087", "story_v_out_413031.awb") ~= 0 then
					local var_368_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031087", "story_v_out_413031.awb") / 1000

					if var_368_38 + var_368_30 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_38 + var_368_30
					end

					if var_368_33.prefab_name ~= "" and arg_365_1.actors_[var_368_33.prefab_name] ~= nil then
						local var_368_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_33.prefab_name].transform, "story_v_out_413031", "413031087", "story_v_out_413031.awb")

						arg_365_1:RecordAudio("413031087", var_368_39)
						arg_365_1:RecordAudio("413031087", var_368_39)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_413031", "413031087", "story_v_out_413031.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_413031", "413031087", "story_v_out_413031.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_40 = math.max(var_368_31, arg_365_1.talkMaxDuration)

			if var_368_30 <= arg_365_1.time_ and arg_365_1.time_ < var_368_30 + var_368_40 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_30) / var_368_40

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_30 + var_368_40 and arg_365_1.time_ < var_368_30 + var_368_40 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413031088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 413031088
		arg_369_1.duration_ = 5.53

		local var_369_0 = {
			zh = 4.966,
			ja = 5.533
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
				arg_369_0:Play413031089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10022"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos10022 = var_372_0.localPosition
				var_372_0.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10022", 3)

				local var_372_2 = var_372_0.childCount

				for iter_372_0 = 0, var_372_2 - 1 do
					local var_372_3 = var_372_0:GetChild(iter_372_0)

					if var_372_3.name == "split_6" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_4 then
				local var_372_5 = (arg_369_1.time_ - var_372_1) / var_372_4
				local var_372_6 = Vector3.New(0, -315, -320)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10022, var_372_6, var_372_5)
			end

			if arg_369_1.time_ >= var_372_1 + var_372_4 and arg_369_1.time_ < var_372_1 + var_372_4 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_372_7 = arg_369_1.actors_["10022"]
			local var_372_8 = 0

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10022 == nil then
				arg_369_1.var_.actorSpriteComps10022 = var_372_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_9 = 2

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_9 and not isNil(var_372_7) then
				local var_372_10 = (arg_369_1.time_ - var_372_8) / var_372_9

				if arg_369_1.var_.actorSpriteComps10022 then
					for iter_372_1, iter_372_2 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_372_2 then
							if arg_369_1.isInRecall_ then
								local var_372_11 = Mathf.Lerp(iter_372_2.color.r, arg_369_1.hightColor1.r, var_372_10)
								local var_372_12 = Mathf.Lerp(iter_372_2.color.g, arg_369_1.hightColor1.g, var_372_10)
								local var_372_13 = Mathf.Lerp(iter_372_2.color.b, arg_369_1.hightColor1.b, var_372_10)

								iter_372_2.color = Color.New(var_372_11, var_372_12, var_372_13)
							else
								local var_372_14 = Mathf.Lerp(iter_372_2.color.r, 1, var_372_10)

								iter_372_2.color = Color.New(var_372_14, var_372_14, var_372_14)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_8 + var_372_9 and arg_369_1.time_ < var_372_8 + var_372_9 + arg_372_0 and not isNil(var_372_7) and arg_369_1.var_.actorSpriteComps10022 then
				for iter_372_3, iter_372_4 in pairs(arg_369_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_372_4 then
						if arg_369_1.isInRecall_ then
							iter_372_4.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10022 = nil
			end

			local var_372_15 = arg_369_1.actors_["10093"]
			local var_372_16 = 0

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps10093 == nil then
				arg_369_1.var_.actorSpriteComps10093 = var_372_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_17 = 2

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_17 and not isNil(var_372_15) then
				local var_372_18 = (arg_369_1.time_ - var_372_16) / var_372_17

				if arg_369_1.var_.actorSpriteComps10093 then
					for iter_372_5, iter_372_6 in pairs(arg_369_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_372_6 then
							if arg_369_1.isInRecall_ then
								local var_372_19 = Mathf.Lerp(iter_372_6.color.r, arg_369_1.hightColor2.r, var_372_18)
								local var_372_20 = Mathf.Lerp(iter_372_6.color.g, arg_369_1.hightColor2.g, var_372_18)
								local var_372_21 = Mathf.Lerp(iter_372_6.color.b, arg_369_1.hightColor2.b, var_372_18)

								iter_372_6.color = Color.New(var_372_19, var_372_20, var_372_21)
							else
								local var_372_22 = Mathf.Lerp(iter_372_6.color.r, 0.5, var_372_18)

								iter_372_6.color = Color.New(var_372_22, var_372_22, var_372_22)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 and not isNil(var_372_15) and arg_369_1.var_.actorSpriteComps10093 then
				for iter_372_7, iter_372_8 in pairs(arg_369_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_372_8 then
						if arg_369_1.isInRecall_ then
							iter_372_8.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10093 = nil
			end

			local var_372_23 = 0
			local var_372_24 = 0.625

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_25 = arg_369_1:FormatText(StoryNameCfg[614].name)

				arg_369_1.leftNameTxt_.text = var_372_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_26 = arg_369_1:GetWordFromCfg(413031088)
				local var_372_27 = arg_369_1:FormatText(var_372_26.content)

				arg_369_1.text_.text = var_372_27

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_28 = 25
				local var_372_29 = utf8.len(var_372_27)
				local var_372_30 = var_372_28 <= 0 and var_372_24 or var_372_24 * (var_372_29 / var_372_28)

				if var_372_30 > 0 and var_372_24 < var_372_30 then
					arg_369_1.talkMaxDuration = var_372_30

					if var_372_30 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_30 + var_372_23
					end
				end

				arg_369_1.text_.text = var_372_27
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031088", "story_v_out_413031.awb") ~= 0 then
					local var_372_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031088", "story_v_out_413031.awb") / 1000

					if var_372_31 + var_372_23 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_31 + var_372_23
					end

					if var_372_26.prefab_name ~= "" and arg_369_1.actors_[var_372_26.prefab_name] ~= nil then
						local var_372_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_26.prefab_name].transform, "story_v_out_413031", "413031088", "story_v_out_413031.awb")

						arg_369_1:RecordAudio("413031088", var_372_32)
						arg_369_1:RecordAudio("413031088", var_372_32)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_413031", "413031088", "story_v_out_413031.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_413031", "413031088", "story_v_out_413031.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_33 = math.max(var_372_24, arg_369_1.talkMaxDuration)

			if var_372_23 <= arg_369_1.time_ and arg_369_1.time_ < var_372_23 + var_372_33 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_23) / var_372_33

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_23 + var_372_33 and arg_369_1.time_ < var_372_23 + var_372_33 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play413031089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 413031089
		arg_373_1.duration_ = 8.73

		local var_373_0 = {
			zh = 8.733,
			ja = 8.466
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
				arg_373_0:Play413031090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10022"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos10022 = var_376_0.localPosition
				var_376_0.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10022", 0)

				local var_376_2 = var_376_0.childCount

				for iter_376_0 = 0, var_376_2 - 1 do
					local var_376_3 = var_376_0:GetChild(iter_376_0)

					if var_376_3.name == "" or not string.find(var_376_3.name, "split") then
						var_376_3.gameObject:SetActive(true)
					else
						var_376_3.gameObject:SetActive(false)
					end
				end
			end

			local var_376_4 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_4 then
				local var_376_5 = (arg_373_1.time_ - var_376_1) / var_376_4
				local var_376_6 = Vector3.New(-5000, -315, -320)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10022, var_376_6, var_376_5)
			end

			if arg_373_1.time_ >= var_376_1 + var_376_4 and arg_373_1.time_ < var_376_1 + var_376_4 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_376_7 = arg_373_1.actors_["10096"].transform
			local var_376_8 = 0

			if var_376_8 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.var_.moveOldPos10096 = var_376_7.localPosition
				var_376_7.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10096", 3)

				local var_376_9 = var_376_7.childCount

				for iter_376_1 = 0, var_376_9 - 1 do
					local var_376_10 = var_376_7:GetChild(iter_376_1)

					if var_376_10.name == "" or not string.find(var_376_10.name, "split") then
						var_376_10.gameObject:SetActive(true)
					else
						var_376_10.gameObject:SetActive(false)
					end
				end
			end

			local var_376_11 = 0.001

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_11 then
				local var_376_12 = (arg_373_1.time_ - var_376_8) / var_376_11
				local var_376_13 = Vector3.New(0, -350, -210)

				var_376_7.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10096, var_376_13, var_376_12)
			end

			if arg_373_1.time_ >= var_376_8 + var_376_11 and arg_373_1.time_ < var_376_8 + var_376_11 + arg_376_0 then
				var_376_7.localPosition = Vector3.New(0, -350, -210)
			end

			local var_376_14 = arg_373_1.actors_["10022"]
			local var_376_15 = 0

			if var_376_15 < arg_373_1.time_ and arg_373_1.time_ <= var_376_15 + arg_376_0 and not isNil(var_376_14) and arg_373_1.var_.actorSpriteComps10022 == nil then
				arg_373_1.var_.actorSpriteComps10022 = var_376_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_16 = 2

			if var_376_15 <= arg_373_1.time_ and arg_373_1.time_ < var_376_15 + var_376_16 and not isNil(var_376_14) then
				local var_376_17 = (arg_373_1.time_ - var_376_15) / var_376_16

				if arg_373_1.var_.actorSpriteComps10022 then
					for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_376_3 then
							if arg_373_1.isInRecall_ then
								local var_376_18 = Mathf.Lerp(iter_376_3.color.r, arg_373_1.hightColor2.r, var_376_17)
								local var_376_19 = Mathf.Lerp(iter_376_3.color.g, arg_373_1.hightColor2.g, var_376_17)
								local var_376_20 = Mathf.Lerp(iter_376_3.color.b, arg_373_1.hightColor2.b, var_376_17)

								iter_376_3.color = Color.New(var_376_18, var_376_19, var_376_20)
							else
								local var_376_21 = Mathf.Lerp(iter_376_3.color.r, 0.5, var_376_17)

								iter_376_3.color = Color.New(var_376_21, var_376_21, var_376_21)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_15 + var_376_16 and arg_373_1.time_ < var_376_15 + var_376_16 + arg_376_0 and not isNil(var_376_14) and arg_373_1.var_.actorSpriteComps10022 then
				for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_376_5 then
						if arg_373_1.isInRecall_ then
							iter_376_5.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10022 = nil
			end

			local var_376_22 = arg_373_1.actors_["10096"]
			local var_376_23 = 0

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 and not isNil(var_376_22) and arg_373_1.var_.actorSpriteComps10096 == nil then
				arg_373_1.var_.actorSpriteComps10096 = var_376_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_24 = 2

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_24 and not isNil(var_376_22) then
				local var_376_25 = (arg_373_1.time_ - var_376_23) / var_376_24

				if arg_373_1.var_.actorSpriteComps10096 then
					for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_376_7 then
							if arg_373_1.isInRecall_ then
								local var_376_26 = Mathf.Lerp(iter_376_7.color.r, arg_373_1.hightColor1.r, var_376_25)
								local var_376_27 = Mathf.Lerp(iter_376_7.color.g, arg_373_1.hightColor1.g, var_376_25)
								local var_376_28 = Mathf.Lerp(iter_376_7.color.b, arg_373_1.hightColor1.b, var_376_25)

								iter_376_7.color = Color.New(var_376_26, var_376_27, var_376_28)
							else
								local var_376_29 = Mathf.Lerp(iter_376_7.color.r, 1, var_376_25)

								iter_376_7.color = Color.New(var_376_29, var_376_29, var_376_29)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_23 + var_376_24 and arg_373_1.time_ < var_376_23 + var_376_24 + arg_376_0 and not isNil(var_376_22) and arg_373_1.var_.actorSpriteComps10096 then
				for iter_376_8, iter_376_9 in pairs(arg_373_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_376_9 then
						if arg_373_1.isInRecall_ then
							iter_376_9.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10096 = nil
			end

			local var_376_30 = 0
			local var_376_31 = 0.575

			if var_376_30 < arg_373_1.time_ and arg_373_1.time_ <= var_376_30 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_32 = arg_373_1:FormatText(StoryNameCfg[492].name)

				arg_373_1.leftNameTxt_.text = var_376_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_33 = arg_373_1:GetWordFromCfg(413031089)
				local var_376_34 = arg_373_1:FormatText(var_376_33.content)

				arg_373_1.text_.text = var_376_34

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_35 = 23
				local var_376_36 = utf8.len(var_376_34)
				local var_376_37 = var_376_35 <= 0 and var_376_31 or var_376_31 * (var_376_36 / var_376_35)

				if var_376_37 > 0 and var_376_31 < var_376_37 then
					arg_373_1.talkMaxDuration = var_376_37

					if var_376_37 + var_376_30 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_37 + var_376_30
					end
				end

				arg_373_1.text_.text = var_376_34
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031089", "story_v_out_413031.awb") ~= 0 then
					local var_376_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031089", "story_v_out_413031.awb") / 1000

					if var_376_38 + var_376_30 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_38 + var_376_30
					end

					if var_376_33.prefab_name ~= "" and arg_373_1.actors_[var_376_33.prefab_name] ~= nil then
						local var_376_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_33.prefab_name].transform, "story_v_out_413031", "413031089", "story_v_out_413031.awb")

						arg_373_1:RecordAudio("413031089", var_376_39)
						arg_373_1:RecordAudio("413031089", var_376_39)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_413031", "413031089", "story_v_out_413031.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_413031", "413031089", "story_v_out_413031.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_40 = math.max(var_376_31, arg_373_1.talkMaxDuration)

			if var_376_30 <= arg_373_1.time_ and arg_373_1.time_ < var_376_30 + var_376_40 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_30) / var_376_40

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_30 + var_376_40 and arg_373_1.time_ < var_376_30 + var_376_40 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play413031090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 413031090
		arg_377_1.duration_ = 7.9

		local var_377_0 = {
			zh = 4.8,
			ja = 7.9
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
				arg_377_0:Play413031091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10022"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos10022 = var_380_0.localPosition
				var_380_0.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10022", 3)

				local var_380_2 = var_380_0.childCount

				for iter_380_0 = 0, var_380_2 - 1 do
					local var_380_3 = var_380_0:GetChild(iter_380_0)

					if var_380_3.name == "split_6" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_4 then
				local var_380_5 = (arg_377_1.time_ - var_380_1) / var_380_4
				local var_380_6 = Vector3.New(0, -315, -320)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10022, var_380_6, var_380_5)
			end

			if arg_377_1.time_ >= var_380_1 + var_380_4 and arg_377_1.time_ < var_380_1 + var_380_4 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_380_7 = arg_377_1.actors_["10096"].transform
			local var_380_8 = 0

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.var_.moveOldPos10096 = var_380_7.localPosition
				var_380_7.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10096", 0)

				local var_380_9 = var_380_7.childCount

				for iter_380_1 = 0, var_380_9 - 1 do
					local var_380_10 = var_380_7:GetChild(iter_380_1)

					if var_380_10.name == "" or not string.find(var_380_10.name, "split") then
						var_380_10.gameObject:SetActive(true)
					else
						var_380_10.gameObject:SetActive(false)
					end
				end
			end

			local var_380_11 = 0.001

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_11 then
				local var_380_12 = (arg_377_1.time_ - var_380_8) / var_380_11
				local var_380_13 = Vector3.New(-5000, -350, -210)

				var_380_7.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10096, var_380_13, var_380_12)
			end

			if arg_377_1.time_ >= var_380_8 + var_380_11 and arg_377_1.time_ < var_380_8 + var_380_11 + arg_380_0 then
				var_380_7.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_380_14 = arg_377_1.actors_["10022"]
			local var_380_15 = 0

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 and not isNil(var_380_14) and arg_377_1.var_.actorSpriteComps10022 == nil then
				arg_377_1.var_.actorSpriteComps10022 = var_380_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_16 = 2

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_16 and not isNil(var_380_14) then
				local var_380_17 = (arg_377_1.time_ - var_380_15) / var_380_16

				if arg_377_1.var_.actorSpriteComps10022 then
					for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_380_3 then
							if arg_377_1.isInRecall_ then
								local var_380_18 = Mathf.Lerp(iter_380_3.color.r, arg_377_1.hightColor1.r, var_380_17)
								local var_380_19 = Mathf.Lerp(iter_380_3.color.g, arg_377_1.hightColor1.g, var_380_17)
								local var_380_20 = Mathf.Lerp(iter_380_3.color.b, arg_377_1.hightColor1.b, var_380_17)

								iter_380_3.color = Color.New(var_380_18, var_380_19, var_380_20)
							else
								local var_380_21 = Mathf.Lerp(iter_380_3.color.r, 1, var_380_17)

								iter_380_3.color = Color.New(var_380_21, var_380_21, var_380_21)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_15 + var_380_16 and arg_377_1.time_ < var_380_15 + var_380_16 + arg_380_0 and not isNil(var_380_14) and arg_377_1.var_.actorSpriteComps10022 then
				for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_380_5 then
						if arg_377_1.isInRecall_ then
							iter_380_5.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10022 = nil
			end

			local var_380_22 = arg_377_1.actors_["10096"]
			local var_380_23 = 0

			if var_380_23 < arg_377_1.time_ and arg_377_1.time_ <= var_380_23 + arg_380_0 and not isNil(var_380_22) and arg_377_1.var_.actorSpriteComps10096 == nil then
				arg_377_1.var_.actorSpriteComps10096 = var_380_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_24 = 2

			if var_380_23 <= arg_377_1.time_ and arg_377_1.time_ < var_380_23 + var_380_24 and not isNil(var_380_22) then
				local var_380_25 = (arg_377_1.time_ - var_380_23) / var_380_24

				if arg_377_1.var_.actorSpriteComps10096 then
					for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_380_7 then
							if arg_377_1.isInRecall_ then
								local var_380_26 = Mathf.Lerp(iter_380_7.color.r, arg_377_1.hightColor2.r, var_380_25)
								local var_380_27 = Mathf.Lerp(iter_380_7.color.g, arg_377_1.hightColor2.g, var_380_25)
								local var_380_28 = Mathf.Lerp(iter_380_7.color.b, arg_377_1.hightColor2.b, var_380_25)

								iter_380_7.color = Color.New(var_380_26, var_380_27, var_380_28)
							else
								local var_380_29 = Mathf.Lerp(iter_380_7.color.r, 0.5, var_380_25)

								iter_380_7.color = Color.New(var_380_29, var_380_29, var_380_29)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_23 + var_380_24 and arg_377_1.time_ < var_380_23 + var_380_24 + arg_380_0 and not isNil(var_380_22) and arg_377_1.var_.actorSpriteComps10096 then
				for iter_380_8, iter_380_9 in pairs(arg_377_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_380_9 then
						if arg_377_1.isInRecall_ then
							iter_380_9.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10096 = nil
			end

			local var_380_30 = 0
			local var_380_31 = 0.6

			if var_380_30 < arg_377_1.time_ and arg_377_1.time_ <= var_380_30 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_32 = arg_377_1:FormatText(StoryNameCfg[614].name)

				arg_377_1.leftNameTxt_.text = var_380_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_33 = arg_377_1:GetWordFromCfg(413031090)
				local var_380_34 = arg_377_1:FormatText(var_380_33.content)

				arg_377_1.text_.text = var_380_34

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_35 = 24
				local var_380_36 = utf8.len(var_380_34)
				local var_380_37 = var_380_35 <= 0 and var_380_31 or var_380_31 * (var_380_36 / var_380_35)

				if var_380_37 > 0 and var_380_31 < var_380_37 then
					arg_377_1.talkMaxDuration = var_380_37

					if var_380_37 + var_380_30 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_37 + var_380_30
					end
				end

				arg_377_1.text_.text = var_380_34
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031090", "story_v_out_413031.awb") ~= 0 then
					local var_380_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031090", "story_v_out_413031.awb") / 1000

					if var_380_38 + var_380_30 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_38 + var_380_30
					end

					if var_380_33.prefab_name ~= "" and arg_377_1.actors_[var_380_33.prefab_name] ~= nil then
						local var_380_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_33.prefab_name].transform, "story_v_out_413031", "413031090", "story_v_out_413031.awb")

						arg_377_1:RecordAudio("413031090", var_380_39)
						arg_377_1:RecordAudio("413031090", var_380_39)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_413031", "413031090", "story_v_out_413031.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_413031", "413031090", "story_v_out_413031.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_40 = math.max(var_380_31, arg_377_1.talkMaxDuration)

			if var_380_30 <= arg_377_1.time_ and arg_377_1.time_ < var_380_30 + var_380_40 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_30) / var_380_40

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_30 + var_380_40 and arg_377_1.time_ < var_380_30 + var_380_40 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play413031091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 413031091
		arg_381_1.duration_ = 14.33

		local var_381_0 = {
			zh = 7.966,
			ja = 14.333
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
				arg_381_0:Play413031092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10022"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos10022 = var_384_0.localPosition
				var_384_0.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10022", 0)

				local var_384_2 = var_384_0.childCount

				for iter_384_0 = 0, var_384_2 - 1 do
					local var_384_3 = var_384_0:GetChild(iter_384_0)

					if var_384_3.name == "" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_4 then
				local var_384_5 = (arg_381_1.time_ - var_384_1) / var_384_4
				local var_384_6 = Vector3.New(-5000, -315, -320)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10022, var_384_6, var_384_5)
			end

			if arg_381_1.time_ >= var_384_1 + var_384_4 and arg_381_1.time_ < var_384_1 + var_384_4 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_384_7 = arg_381_1.actors_["10096"].transform
			local var_384_8 = 0

			if var_384_8 < arg_381_1.time_ and arg_381_1.time_ <= var_384_8 + arg_384_0 then
				arg_381_1.var_.moveOldPos10096 = var_384_7.localPosition
				var_384_7.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10096", 3)

				local var_384_9 = var_384_7.childCount

				for iter_384_1 = 0, var_384_9 - 1 do
					local var_384_10 = var_384_7:GetChild(iter_384_1)

					if var_384_10.name == "" or not string.find(var_384_10.name, "split") then
						var_384_10.gameObject:SetActive(true)
					else
						var_384_10.gameObject:SetActive(false)
					end
				end
			end

			local var_384_11 = 0.001

			if var_384_8 <= arg_381_1.time_ and arg_381_1.time_ < var_384_8 + var_384_11 then
				local var_384_12 = (arg_381_1.time_ - var_384_8) / var_384_11
				local var_384_13 = Vector3.New(0, -350, -210)

				var_384_7.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10096, var_384_13, var_384_12)
			end

			if arg_381_1.time_ >= var_384_8 + var_384_11 and arg_381_1.time_ < var_384_8 + var_384_11 + arg_384_0 then
				var_384_7.localPosition = Vector3.New(0, -350, -210)
			end

			local var_384_14 = arg_381_1.actors_["10022"]
			local var_384_15 = 0

			if var_384_15 < arg_381_1.time_ and arg_381_1.time_ <= var_384_15 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps10022 == nil then
				arg_381_1.var_.actorSpriteComps10022 = var_384_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_16 = 2

			if var_384_15 <= arg_381_1.time_ and arg_381_1.time_ < var_384_15 + var_384_16 and not isNil(var_384_14) then
				local var_384_17 = (arg_381_1.time_ - var_384_15) / var_384_16

				if arg_381_1.var_.actorSpriteComps10022 then
					for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_384_3 then
							if arg_381_1.isInRecall_ then
								local var_384_18 = Mathf.Lerp(iter_384_3.color.r, arg_381_1.hightColor2.r, var_384_17)
								local var_384_19 = Mathf.Lerp(iter_384_3.color.g, arg_381_1.hightColor2.g, var_384_17)
								local var_384_20 = Mathf.Lerp(iter_384_3.color.b, arg_381_1.hightColor2.b, var_384_17)

								iter_384_3.color = Color.New(var_384_18, var_384_19, var_384_20)
							else
								local var_384_21 = Mathf.Lerp(iter_384_3.color.r, 0.5, var_384_17)

								iter_384_3.color = Color.New(var_384_21, var_384_21, var_384_21)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_15 + var_384_16 and arg_381_1.time_ < var_384_15 + var_384_16 + arg_384_0 and not isNil(var_384_14) and arg_381_1.var_.actorSpriteComps10022 then
				for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_384_5 then
						if arg_381_1.isInRecall_ then
							iter_384_5.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps10022 = nil
			end

			local var_384_22 = arg_381_1.actors_["10096"]
			local var_384_23 = 0

			if var_384_23 < arg_381_1.time_ and arg_381_1.time_ <= var_384_23 + arg_384_0 and not isNil(var_384_22) and arg_381_1.var_.actorSpriteComps10096 == nil then
				arg_381_1.var_.actorSpriteComps10096 = var_384_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_24 = 2

			if var_384_23 <= arg_381_1.time_ and arg_381_1.time_ < var_384_23 + var_384_24 and not isNil(var_384_22) then
				local var_384_25 = (arg_381_1.time_ - var_384_23) / var_384_24

				if arg_381_1.var_.actorSpriteComps10096 then
					for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_384_7 then
							if arg_381_1.isInRecall_ then
								local var_384_26 = Mathf.Lerp(iter_384_7.color.r, arg_381_1.hightColor1.r, var_384_25)
								local var_384_27 = Mathf.Lerp(iter_384_7.color.g, arg_381_1.hightColor1.g, var_384_25)
								local var_384_28 = Mathf.Lerp(iter_384_7.color.b, arg_381_1.hightColor1.b, var_384_25)

								iter_384_7.color = Color.New(var_384_26, var_384_27, var_384_28)
							else
								local var_384_29 = Mathf.Lerp(iter_384_7.color.r, 1, var_384_25)

								iter_384_7.color = Color.New(var_384_29, var_384_29, var_384_29)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_23 + var_384_24 and arg_381_1.time_ < var_384_23 + var_384_24 + arg_384_0 and not isNil(var_384_22) and arg_381_1.var_.actorSpriteComps10096 then
				for iter_384_8, iter_384_9 in pairs(arg_381_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_384_9 then
						if arg_381_1.isInRecall_ then
							iter_384_9.color = arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_384_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps10096 = nil
			end

			local var_384_30 = 0
			local var_384_31 = 0.5

			if var_384_30 < arg_381_1.time_ and arg_381_1.time_ <= var_384_30 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_32 = arg_381_1:FormatText(StoryNameCfg[492].name)

				arg_381_1.leftNameTxt_.text = var_384_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_33 = arg_381_1:GetWordFromCfg(413031091)
				local var_384_34 = arg_381_1:FormatText(var_384_33.content)

				arg_381_1.text_.text = var_384_34

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_35 = 20
				local var_384_36 = utf8.len(var_384_34)
				local var_384_37 = var_384_35 <= 0 and var_384_31 or var_384_31 * (var_384_36 / var_384_35)

				if var_384_37 > 0 and var_384_31 < var_384_37 then
					arg_381_1.talkMaxDuration = var_384_37

					if var_384_37 + var_384_30 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_37 + var_384_30
					end
				end

				arg_381_1.text_.text = var_384_34
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031091", "story_v_out_413031.awb") ~= 0 then
					local var_384_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031091", "story_v_out_413031.awb") / 1000

					if var_384_38 + var_384_30 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_38 + var_384_30
					end

					if var_384_33.prefab_name ~= "" and arg_381_1.actors_[var_384_33.prefab_name] ~= nil then
						local var_384_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_33.prefab_name].transform, "story_v_out_413031", "413031091", "story_v_out_413031.awb")

						arg_381_1:RecordAudio("413031091", var_384_39)
						arg_381_1:RecordAudio("413031091", var_384_39)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_413031", "413031091", "story_v_out_413031.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_413031", "413031091", "story_v_out_413031.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_40 = math.max(var_384_31, arg_381_1.talkMaxDuration)

			if var_384_30 <= arg_381_1.time_ and arg_381_1.time_ < var_384_30 + var_384_40 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_30) / var_384_40

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_30 + var_384_40 and arg_381_1.time_ < var_384_30 + var_384_40 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play413031092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 413031092
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play413031093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10096"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos10096 = var_388_0.localPosition
				var_388_0.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10096", 0)

				local var_388_2 = var_388_0.childCount

				for iter_388_0 = 0, var_388_2 - 1 do
					local var_388_3 = var_388_0:GetChild(iter_388_0)

					if var_388_3.name == "" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_4 then
				local var_388_5 = (arg_385_1.time_ - var_388_1) / var_388_4
				local var_388_6 = Vector3.New(-5000, -350, -210)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10096, var_388_6, var_388_5)
			end

			if arg_385_1.time_ >= var_388_1 + var_388_4 and arg_385_1.time_ < var_388_1 + var_388_4 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(-5000, -350, -210)
			end

			local var_388_7 = arg_385_1.actors_["10096"]
			local var_388_8 = 0

			if var_388_8 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps10096 == nil then
				arg_385_1.var_.actorSpriteComps10096 = var_388_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_9 = 2

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_9 and not isNil(var_388_7) then
				local var_388_10 = (arg_385_1.time_ - var_388_8) / var_388_9

				if arg_385_1.var_.actorSpriteComps10096 then
					for iter_388_1, iter_388_2 in pairs(arg_385_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_388_2 then
							if arg_385_1.isInRecall_ then
								local var_388_11 = Mathf.Lerp(iter_388_2.color.r, arg_385_1.hightColor2.r, var_388_10)
								local var_388_12 = Mathf.Lerp(iter_388_2.color.g, arg_385_1.hightColor2.g, var_388_10)
								local var_388_13 = Mathf.Lerp(iter_388_2.color.b, arg_385_1.hightColor2.b, var_388_10)

								iter_388_2.color = Color.New(var_388_11, var_388_12, var_388_13)
							else
								local var_388_14 = Mathf.Lerp(iter_388_2.color.r, 0.5, var_388_10)

								iter_388_2.color = Color.New(var_388_14, var_388_14, var_388_14)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_8 + var_388_9 and arg_385_1.time_ < var_388_8 + var_388_9 + arg_388_0 and not isNil(var_388_7) and arg_385_1.var_.actorSpriteComps10096 then
				for iter_388_3, iter_388_4 in pairs(arg_385_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_388_4 then
						if arg_385_1.isInRecall_ then
							iter_388_4.color = arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_388_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps10096 = nil
			end

			local var_388_15 = 0
			local var_388_16 = 1.075

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_17 = arg_385_1:GetWordFromCfg(413031092)
				local var_388_18 = arg_385_1:FormatText(var_388_17.content)

				arg_385_1.text_.text = var_388_18

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_19 = 43
				local var_388_20 = utf8.len(var_388_18)
				local var_388_21 = var_388_19 <= 0 and var_388_16 or var_388_16 * (var_388_20 / var_388_19)

				if var_388_21 > 0 and var_388_16 < var_388_21 then
					arg_385_1.talkMaxDuration = var_388_21

					if var_388_21 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_21 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_18
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_22 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_22 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_22

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_22 and arg_385_1.time_ < var_388_15 + var_388_22 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play413031093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 413031093
		arg_389_1.duration_ = 15.88

		local var_389_0 = {
			zh = 13.1111379988407,
			ja = 15.8781379988407
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
				arg_389_0:Play413031094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 2

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				local var_392_1 = manager.ui.mainCamera.transform.localPosition
				local var_392_2 = Vector3.New(0, 0, 10) + Vector3.New(var_392_1.x, var_392_1.y, 0)
				local var_392_3 = arg_389_1.bgs_.F08l

				var_392_3.transform.localPosition = var_392_2
				var_392_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_392_4 = var_392_3:GetComponent("SpriteRenderer")

				if var_392_4 and var_392_4.sprite then
					local var_392_5 = (var_392_3.transform.localPosition - var_392_1).z
					local var_392_6 = manager.ui.mainCameraCom_
					local var_392_7 = 2 * var_392_5 * Mathf.Tan(var_392_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_392_8 = var_392_7 * var_392_6.aspect
					local var_392_9 = var_392_4.sprite.bounds.size.x
					local var_392_10 = var_392_4.sprite.bounds.size.y
					local var_392_11 = var_392_8 / var_392_9
					local var_392_12 = var_392_7 / var_392_10
					local var_392_13 = var_392_12 < var_392_11 and var_392_11 or var_392_12

					var_392_3.transform.localScale = Vector3.New(var_392_13, var_392_13, 0)
				end

				for iter_392_0, iter_392_1 in pairs(arg_389_1.bgs_) do
					if iter_392_0 ~= "F08l" then
						iter_392_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_392_14 = 3.8

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1.allBtn_.enabled = false
			end

			local var_392_15 = 0.3

			if arg_389_1.time_ >= var_392_14 + var_392_15 and arg_389_1.time_ < var_392_14 + var_392_15 + arg_392_0 then
				arg_389_1.allBtn_.enabled = true
			end

			local var_392_16 = 0

			if var_392_16 < arg_389_1.time_ and arg_389_1.time_ <= var_392_16 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_17 = 2

			if var_392_16 <= arg_389_1.time_ and arg_389_1.time_ < var_392_16 + var_392_17 then
				local var_392_18 = (arg_389_1.time_ - var_392_16) / var_392_17
				local var_392_19 = Color.New(0, 0, 0)

				var_392_19.a = Mathf.Lerp(0, 1, var_392_18)
				arg_389_1.mask_.color = var_392_19
			end

			if arg_389_1.time_ >= var_392_16 + var_392_17 and arg_389_1.time_ < var_392_16 + var_392_17 + arg_392_0 then
				local var_392_20 = Color.New(0, 0, 0)

				var_392_20.a = 1
				arg_389_1.mask_.color = var_392_20
			end

			local var_392_21 = 2

			if var_392_21 < arg_389_1.time_ and arg_389_1.time_ <= var_392_21 + arg_392_0 then
				arg_389_1.mask_.enabled = true
				arg_389_1.mask_.raycastTarget = true

				arg_389_1:SetGaussion(false)
			end

			local var_392_22 = 2

			if var_392_21 <= arg_389_1.time_ and arg_389_1.time_ < var_392_21 + var_392_22 then
				local var_392_23 = (arg_389_1.time_ - var_392_21) / var_392_22
				local var_392_24 = Color.New(0, 0, 0)

				var_392_24.a = Mathf.Lerp(1, 0, var_392_23)
				arg_389_1.mask_.color = var_392_24
			end

			if arg_389_1.time_ >= var_392_21 + var_392_22 and arg_389_1.time_ < var_392_21 + var_392_22 + arg_392_0 then
				local var_392_25 = Color.New(0, 0, 0)
				local var_392_26 = 0

				arg_389_1.mask_.enabled = false
				var_392_25.a = var_392_26
				arg_389_1.mask_.color = var_392_25
			end

			local var_392_27 = arg_389_1.actors_["10022"].transform
			local var_392_28 = 3.8

			if var_392_28 < arg_389_1.time_ and arg_389_1.time_ <= var_392_28 + arg_392_0 then
				arg_389_1.var_.moveOldPos10022 = var_392_27.localPosition
				var_392_27.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10022", 3)

				local var_392_29 = var_392_27.childCount

				for iter_392_2 = 0, var_392_29 - 1 do
					local var_392_30 = var_392_27:GetChild(iter_392_2)

					if var_392_30.name == "split_6" or not string.find(var_392_30.name, "split") then
						var_392_30.gameObject:SetActive(true)
					else
						var_392_30.gameObject:SetActive(false)
					end
				end
			end

			local var_392_31 = 0.001

			if var_392_28 <= arg_389_1.time_ and arg_389_1.time_ < var_392_28 + var_392_31 then
				local var_392_32 = (arg_389_1.time_ - var_392_28) / var_392_31
				local var_392_33 = Vector3.New(0, -315, -320)

				var_392_27.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10022, var_392_33, var_392_32)
			end

			if arg_389_1.time_ >= var_392_28 + var_392_31 and arg_389_1.time_ < var_392_28 + var_392_31 + arg_392_0 then
				var_392_27.localPosition = Vector3.New(0, -315, -320)
			end

			local var_392_34 = arg_389_1.actors_["10022"]
			local var_392_35 = 3.8

			if var_392_35 < arg_389_1.time_ and arg_389_1.time_ <= var_392_35 + arg_392_0 and not isNil(var_392_34) and arg_389_1.var_.actorSpriteComps10022 == nil then
				arg_389_1.var_.actorSpriteComps10022 = var_392_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_36 = 0.034

			if var_392_35 <= arg_389_1.time_ and arg_389_1.time_ < var_392_35 + var_392_36 and not isNil(var_392_34) then
				local var_392_37 = (arg_389_1.time_ - var_392_35) / var_392_36

				if arg_389_1.var_.actorSpriteComps10022 then
					for iter_392_3, iter_392_4 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_392_4 then
							if arg_389_1.isInRecall_ then
								local var_392_38 = Mathf.Lerp(iter_392_4.color.r, arg_389_1.hightColor1.r, var_392_37)
								local var_392_39 = Mathf.Lerp(iter_392_4.color.g, arg_389_1.hightColor1.g, var_392_37)
								local var_392_40 = Mathf.Lerp(iter_392_4.color.b, arg_389_1.hightColor1.b, var_392_37)

								iter_392_4.color = Color.New(var_392_38, var_392_39, var_392_40)
							else
								local var_392_41 = Mathf.Lerp(iter_392_4.color.r, 1, var_392_37)

								iter_392_4.color = Color.New(var_392_41, var_392_41, var_392_41)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_35 + var_392_36 and arg_389_1.time_ < var_392_35 + var_392_36 + arg_392_0 and not isNil(var_392_34) and arg_389_1.var_.actorSpriteComps10022 then
				for iter_392_5, iter_392_6 in pairs(arg_389_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_392_6 then
						if arg_389_1.isInRecall_ then
							iter_392_6.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10022 = nil
			end

			local var_392_42 = arg_389_1.actors_["10022"]
			local var_392_43 = 3.8

			if var_392_43 < arg_389_1.time_ and arg_389_1.time_ <= var_392_43 + arg_392_0 then
				local var_392_44 = var_392_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_392_44 then
					arg_389_1.var_.alphaOldValue10022 = var_392_44.alpha
					arg_389_1.var_.characterEffect10022 = var_392_44
				end

				arg_389_1.var_.alphaOldValue10022 = 0
			end

			local var_392_45 = 0.2

			if var_392_43 <= arg_389_1.time_ and arg_389_1.time_ < var_392_43 + var_392_45 then
				local var_392_46 = (arg_389_1.time_ - var_392_43) / var_392_45
				local var_392_47 = Mathf.Lerp(arg_389_1.var_.alphaOldValue10022, 1, var_392_46)

				if arg_389_1.var_.characterEffect10022 then
					arg_389_1.var_.characterEffect10022.alpha = var_392_47
				end
			end

			if arg_389_1.time_ >= var_392_43 + var_392_45 and arg_389_1.time_ < var_392_43 + var_392_45 + arg_392_0 and arg_389_1.var_.characterEffect10022 then
				arg_389_1.var_.characterEffect10022.alpha = 1
			end

			local var_392_48 = 2
			local var_392_49 = 2.1

			if var_392_48 < arg_389_1.time_ and arg_389_1.time_ <= var_392_48 + arg_392_0 then
				local var_392_50 = "play"
				local var_392_51 = "music"

				arg_389_1:AudioAction(var_392_50, var_392_51, "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_392_52 = ""
				local var_392_53 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

				if var_392_53 ~= "" then
					if arg_389_1.bgmTxt_.text ~= var_392_53 and arg_389_1.bgmTxt_.text ~= "" then
						if arg_389_1.bgmTxt2_.text ~= "" then
							arg_389_1.bgmTxt_.text = arg_389_1.bgmTxt2_.text
						end

						arg_389_1.bgmTxt2_.text = var_392_53

						arg_389_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_389_1.bgmTxt_.text = var_392_53
						arg_389_1.bgmTxt2_.text = var_392_53
					end

					if arg_389_1.bgmTimer then
						arg_389_1.bgmTimer:Stop()

						arg_389_1.bgmTimer = nil
					end

					if arg_389_1.settingData.show_music_name == 1 then
						arg_389_1.musicController:SetSelectedState("show")
						arg_389_1.musicAnimator_:Play("open", 0, 0)

						if arg_389_1.settingData.music_time ~= 0 then
							arg_389_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_389_1.settingData.music_time), function()
								if arg_389_1 == nil or isNil(arg_389_1.bgmTxt_) then
									return
								end

								arg_389_1.musicController:SetSelectedState("hide")
								arg_389_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_389_1.frameCnt_ <= 1 then
				arg_389_1.dialog_:SetActive(false)
			end

			local var_392_54 = 3.9781379988407
			local var_392_55 = 1.1

			if var_392_54 < arg_389_1.time_ and arg_389_1.time_ <= var_392_54 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0

				arg_389_1.dialog_:SetActive(true)

				arg_389_1.dialogCg_.alpha = 0

				local var_392_56 = LeanTween.value(arg_389_1.dialog_, 0, 1, 0.3)

				var_392_56:setOnUpdate(LuaHelper.FloatAction(function(arg_394_0)
					arg_389_1.dialogCg_.alpha = arg_394_0
				end))
				var_392_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_389_1.dialog_)
					var_392_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_389_1.duration_ = arg_389_1.duration_ + 0.3

				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_57 = arg_389_1:FormatText(StoryNameCfg[614].name)

				arg_389_1.leftNameTxt_.text = var_392_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_58 = arg_389_1:GetWordFromCfg(413031093)
				local var_392_59 = arg_389_1:FormatText(var_392_58.content)

				arg_389_1.text_.text = var_392_59

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_60 = 44
				local var_392_61 = utf8.len(var_392_59)
				local var_392_62 = var_392_60 <= 0 and var_392_55 or var_392_55 * (var_392_61 / var_392_60)

				if var_392_62 > 0 and var_392_55 < var_392_62 then
					arg_389_1.talkMaxDuration = var_392_62
					var_392_54 = var_392_54 + 0.3

					if var_392_62 + var_392_54 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_62 + var_392_54
					end
				end

				arg_389_1.text_.text = var_392_59
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031093", "story_v_out_413031.awb") ~= 0 then
					local var_392_63 = manager.audio:GetVoiceLength("story_v_out_413031", "413031093", "story_v_out_413031.awb") / 1000

					if var_392_63 + var_392_54 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_63 + var_392_54
					end

					if var_392_58.prefab_name ~= "" and arg_389_1.actors_[var_392_58.prefab_name] ~= nil then
						local var_392_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_58.prefab_name].transform, "story_v_out_413031", "413031093", "story_v_out_413031.awb")

						arg_389_1:RecordAudio("413031093", var_392_64)
						arg_389_1:RecordAudio("413031093", var_392_64)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_413031", "413031093", "story_v_out_413031.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_413031", "413031093", "story_v_out_413031.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_65 = var_392_54 + 0.3
			local var_392_66 = math.max(var_392_55, arg_389_1.talkMaxDuration)

			if var_392_65 <= arg_389_1.time_ and arg_389_1.time_ < var_392_65 + var_392_66 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_65) / var_392_66

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_65 + var_392_66 and arg_389_1.time_ < var_392_65 + var_392_66 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play413031094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 413031094
		arg_396_1.duration_ = 2.5

		local var_396_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play413031095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10093"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos10093 = var_399_0.localPosition
				var_399_0.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("10093", 3)

				local var_399_2 = var_399_0.childCount

				for iter_399_0 = 0, var_399_2 - 1 do
					local var_399_3 = var_399_0:GetChild(iter_399_0)

					if var_399_3.name == "split_4" or not string.find(var_399_3.name, "split") then
						var_399_3.gameObject:SetActive(true)
					else
						var_399_3.gameObject:SetActive(false)
					end
				end
			end

			local var_399_4 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_4 then
				local var_399_5 = (arg_396_1.time_ - var_399_1) / var_399_4
				local var_399_6 = Vector3.New(0, -345, -245)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos10093, var_399_6, var_399_5)
			end

			if arg_396_1.time_ >= var_399_1 + var_399_4 and arg_396_1.time_ < var_399_1 + var_399_4 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_399_7 = arg_396_1.actors_["10093"]
			local var_399_8 = 0

			if var_399_8 < arg_396_1.time_ and arg_396_1.time_ <= var_399_8 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.actorSpriteComps10093 == nil then
				arg_396_1.var_.actorSpriteComps10093 = var_399_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_9 = 2

			if var_399_8 <= arg_396_1.time_ and arg_396_1.time_ < var_399_8 + var_399_9 and not isNil(var_399_7) then
				local var_399_10 = (arg_396_1.time_ - var_399_8) / var_399_9

				if arg_396_1.var_.actorSpriteComps10093 then
					for iter_399_1, iter_399_2 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_399_2 then
							if arg_396_1.isInRecall_ then
								local var_399_11 = Mathf.Lerp(iter_399_2.color.r, arg_396_1.hightColor1.r, var_399_10)
								local var_399_12 = Mathf.Lerp(iter_399_2.color.g, arg_396_1.hightColor1.g, var_399_10)
								local var_399_13 = Mathf.Lerp(iter_399_2.color.b, arg_396_1.hightColor1.b, var_399_10)

								iter_399_2.color = Color.New(var_399_11, var_399_12, var_399_13)
							else
								local var_399_14 = Mathf.Lerp(iter_399_2.color.r, 1, var_399_10)

								iter_399_2.color = Color.New(var_399_14, var_399_14, var_399_14)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_8 + var_399_9 and arg_396_1.time_ < var_399_8 + var_399_9 + arg_399_0 and not isNil(var_399_7) and arg_396_1.var_.actorSpriteComps10093 then
				for iter_399_3, iter_399_4 in pairs(arg_396_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_399_4 then
						if arg_396_1.isInRecall_ then
							iter_399_4.color = arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_399_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps10093 = nil
			end

			local var_399_15 = arg_396_1.actors_["10022"]
			local var_399_16 = 0

			if var_399_16 < arg_396_1.time_ and arg_396_1.time_ <= var_399_16 + arg_399_0 and not isNil(var_399_15) and arg_396_1.var_.actorSpriteComps10022 == nil then
				arg_396_1.var_.actorSpriteComps10022 = var_399_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_17 = 2

			if var_399_16 <= arg_396_1.time_ and arg_396_1.time_ < var_399_16 + var_399_17 and not isNil(var_399_15) then
				local var_399_18 = (arg_396_1.time_ - var_399_16) / var_399_17

				if arg_396_1.var_.actorSpriteComps10022 then
					for iter_399_5, iter_399_6 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_399_6 then
							if arg_396_1.isInRecall_ then
								local var_399_19 = Mathf.Lerp(iter_399_6.color.r, arg_396_1.hightColor2.r, var_399_18)
								local var_399_20 = Mathf.Lerp(iter_399_6.color.g, arg_396_1.hightColor2.g, var_399_18)
								local var_399_21 = Mathf.Lerp(iter_399_6.color.b, arg_396_1.hightColor2.b, var_399_18)

								iter_399_6.color = Color.New(var_399_19, var_399_20, var_399_21)
							else
								local var_399_22 = Mathf.Lerp(iter_399_6.color.r, 0.5, var_399_18)

								iter_399_6.color = Color.New(var_399_22, var_399_22, var_399_22)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_16 + var_399_17 and arg_396_1.time_ < var_399_16 + var_399_17 + arg_399_0 and not isNil(var_399_15) and arg_396_1.var_.actorSpriteComps10022 then
				for iter_399_7, iter_399_8 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_399_8 then
						if arg_396_1.isInRecall_ then
							iter_399_8.color = arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_399_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps10022 = nil
			end

			local var_399_23 = arg_396_1.actors_["10093"]
			local var_399_24 = 0

			if var_399_24 < arg_396_1.time_ and arg_396_1.time_ <= var_399_24 + arg_399_0 then
				local var_399_25 = var_399_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_399_25 then
					arg_396_1.var_.alphaOldValue10093 = var_399_25.alpha
					arg_396_1.var_.characterEffect10093 = var_399_25
				end

				arg_396_1.var_.alphaOldValue10093 = 0
			end

			local var_399_26 = 0.2

			if var_399_24 <= arg_396_1.time_ and arg_396_1.time_ < var_399_24 + var_399_26 then
				local var_399_27 = (arg_396_1.time_ - var_399_24) / var_399_26
				local var_399_28 = Mathf.Lerp(arg_396_1.var_.alphaOldValue10093, 1, var_399_27)

				if arg_396_1.var_.characterEffect10093 then
					arg_396_1.var_.characterEffect10093.alpha = var_399_28
				end
			end

			if arg_396_1.time_ >= var_399_24 + var_399_26 and arg_396_1.time_ < var_399_24 + var_399_26 + arg_399_0 and arg_396_1.var_.characterEffect10093 then
				arg_396_1.var_.characterEffect10093.alpha = 1
			end

			local var_399_29 = 0
			local var_399_30 = 0.15

			if var_399_29 < arg_396_1.time_ and arg_396_1.time_ <= var_399_29 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_31 = arg_396_1:FormatText(StoryNameCfg[28].name)

				arg_396_1.leftNameTxt_.text = var_399_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_32 = arg_396_1:GetWordFromCfg(413031094)
				local var_399_33 = arg_396_1:FormatText(var_399_32.content)

				arg_396_1.text_.text = var_399_33

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_34 = 6
				local var_399_35 = utf8.len(var_399_33)
				local var_399_36 = var_399_34 <= 0 and var_399_30 or var_399_30 * (var_399_35 / var_399_34)

				if var_399_36 > 0 and var_399_30 < var_399_36 then
					arg_396_1.talkMaxDuration = var_399_36

					if var_399_36 + var_399_29 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_36 + var_399_29
					end
				end

				arg_396_1.text_.text = var_399_33
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031094", "story_v_out_413031.awb") ~= 0 then
					local var_399_37 = manager.audio:GetVoiceLength("story_v_out_413031", "413031094", "story_v_out_413031.awb") / 1000

					if var_399_37 + var_399_29 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_37 + var_399_29
					end

					if var_399_32.prefab_name ~= "" and arg_396_1.actors_[var_399_32.prefab_name] ~= nil then
						local var_399_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_32.prefab_name].transform, "story_v_out_413031", "413031094", "story_v_out_413031.awb")

						arg_396_1:RecordAudio("413031094", var_399_38)
						arg_396_1:RecordAudio("413031094", var_399_38)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_413031", "413031094", "story_v_out_413031.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_413031", "413031094", "story_v_out_413031.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_39 = math.max(var_399_30, arg_396_1.talkMaxDuration)

			if var_399_29 <= arg_396_1.time_ and arg_396_1.time_ < var_399_29 + var_399_39 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_29) / var_399_39

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_29 + var_399_39 and arg_396_1.time_ < var_399_29 + var_399_39 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
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

		arg_396_1:InitPlayNodeList()
	end,
	Play413031095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 413031095
		arg_400_1.duration_ = 7.67

		local var_400_0 = {
			zh = 5,
			ja = 7.666
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play413031096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["10093"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos10093 = var_403_0.localPosition
				var_403_0.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10093", 2)

				local var_403_2 = var_403_0.childCount

				for iter_403_0 = 0, var_403_2 - 1 do
					local var_403_3 = var_403_0:GetChild(iter_403_0)

					if var_403_3.name == "" or not string.find(var_403_3.name, "split") then
						var_403_3.gameObject:SetActive(true)
					else
						var_403_3.gameObject:SetActive(false)
					end
				end
			end

			local var_403_4 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_4 then
				local var_403_5 = (arg_400_1.time_ - var_403_1) / var_403_4
				local var_403_6 = Vector3.New(-390, -345, -245)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10093, var_403_6, var_403_5)
			end

			if arg_400_1.time_ >= var_403_1 + var_403_4 and arg_400_1.time_ < var_403_1 + var_403_4 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_403_7 = arg_400_1.actors_["10022"].transform
			local var_403_8 = 0

			if var_403_8 < arg_400_1.time_ and arg_400_1.time_ <= var_403_8 + arg_403_0 then
				arg_400_1.var_.moveOldPos10022 = var_403_7.localPosition
				var_403_7.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10022", 4)

				local var_403_9 = var_403_7.childCount

				for iter_403_1 = 0, var_403_9 - 1 do
					local var_403_10 = var_403_7:GetChild(iter_403_1)

					if var_403_10.name == "split_6" or not string.find(var_403_10.name, "split") then
						var_403_10.gameObject:SetActive(true)
					else
						var_403_10.gameObject:SetActive(false)
					end
				end
			end

			local var_403_11 = 0.001

			if var_403_8 <= arg_400_1.time_ and arg_400_1.time_ < var_403_8 + var_403_11 then
				local var_403_12 = (arg_400_1.time_ - var_403_8) / var_403_11
				local var_403_13 = Vector3.New(390, -315, -320)

				var_403_7.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10022, var_403_13, var_403_12)
			end

			if arg_400_1.time_ >= var_403_8 + var_403_11 and arg_400_1.time_ < var_403_8 + var_403_11 + arg_403_0 then
				var_403_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_403_14 = arg_400_1.actors_["10093"]
			local var_403_15 = 0

			if var_403_15 < arg_400_1.time_ and arg_400_1.time_ <= var_403_15 + arg_403_0 and not isNil(var_403_14) and arg_400_1.var_.actorSpriteComps10093 == nil then
				arg_400_1.var_.actorSpriteComps10093 = var_403_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_16 = 2

			if var_403_15 <= arg_400_1.time_ and arg_400_1.time_ < var_403_15 + var_403_16 and not isNil(var_403_14) then
				local var_403_17 = (arg_400_1.time_ - var_403_15) / var_403_16

				if arg_400_1.var_.actorSpriteComps10093 then
					for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_403_3 then
							if arg_400_1.isInRecall_ then
								local var_403_18 = Mathf.Lerp(iter_403_3.color.r, arg_400_1.hightColor2.r, var_403_17)
								local var_403_19 = Mathf.Lerp(iter_403_3.color.g, arg_400_1.hightColor2.g, var_403_17)
								local var_403_20 = Mathf.Lerp(iter_403_3.color.b, arg_400_1.hightColor2.b, var_403_17)

								iter_403_3.color = Color.New(var_403_18, var_403_19, var_403_20)
							else
								local var_403_21 = Mathf.Lerp(iter_403_3.color.r, 0.5, var_403_17)

								iter_403_3.color = Color.New(var_403_21, var_403_21, var_403_21)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_15 + var_403_16 and arg_400_1.time_ < var_403_15 + var_403_16 + arg_403_0 and not isNil(var_403_14) and arg_400_1.var_.actorSpriteComps10093 then
				for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_403_5 then
						if arg_400_1.isInRecall_ then
							iter_403_5.color = arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_403_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps10093 = nil
			end

			local var_403_22 = arg_400_1.actors_["10022"]
			local var_403_23 = 0

			if var_403_23 < arg_400_1.time_ and arg_400_1.time_ <= var_403_23 + arg_403_0 and not isNil(var_403_22) and arg_400_1.var_.actorSpriteComps10022 == nil then
				arg_400_1.var_.actorSpriteComps10022 = var_403_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_24 = 2

			if var_403_23 <= arg_400_1.time_ and arg_400_1.time_ < var_403_23 + var_403_24 and not isNil(var_403_22) then
				local var_403_25 = (arg_400_1.time_ - var_403_23) / var_403_24

				if arg_400_1.var_.actorSpriteComps10022 then
					for iter_403_6, iter_403_7 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_403_7 then
							if arg_400_1.isInRecall_ then
								local var_403_26 = Mathf.Lerp(iter_403_7.color.r, arg_400_1.hightColor1.r, var_403_25)
								local var_403_27 = Mathf.Lerp(iter_403_7.color.g, arg_400_1.hightColor1.g, var_403_25)
								local var_403_28 = Mathf.Lerp(iter_403_7.color.b, arg_400_1.hightColor1.b, var_403_25)

								iter_403_7.color = Color.New(var_403_26, var_403_27, var_403_28)
							else
								local var_403_29 = Mathf.Lerp(iter_403_7.color.r, 1, var_403_25)

								iter_403_7.color = Color.New(var_403_29, var_403_29, var_403_29)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= var_403_23 + var_403_24 and arg_400_1.time_ < var_403_23 + var_403_24 + arg_403_0 and not isNil(var_403_22) and arg_400_1.var_.actorSpriteComps10022 then
				for iter_403_8, iter_403_9 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_403_9 then
						if arg_400_1.isInRecall_ then
							iter_403_9.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_403_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_400_1.var_.actorSpriteComps10022 = nil
			end

			local var_403_30 = 0
			local var_403_31 = 0.7

			if var_403_30 < arg_400_1.time_ and arg_400_1.time_ <= var_403_30 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_32 = arg_400_1:FormatText(StoryNameCfg[614].name)

				arg_400_1.leftNameTxt_.text = var_403_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_33 = arg_400_1:GetWordFromCfg(413031095)
				local var_403_34 = arg_400_1:FormatText(var_403_33.content)

				arg_400_1.text_.text = var_403_34

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_35 = 28
				local var_403_36 = utf8.len(var_403_34)
				local var_403_37 = var_403_35 <= 0 and var_403_31 or var_403_31 * (var_403_36 / var_403_35)

				if var_403_37 > 0 and var_403_31 < var_403_37 then
					arg_400_1.talkMaxDuration = var_403_37

					if var_403_37 + var_403_30 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_37 + var_403_30
					end
				end

				arg_400_1.text_.text = var_403_34
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031095", "story_v_out_413031.awb") ~= 0 then
					local var_403_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031095", "story_v_out_413031.awb") / 1000

					if var_403_38 + var_403_30 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_38 + var_403_30
					end

					if var_403_33.prefab_name ~= "" and arg_400_1.actors_[var_403_33.prefab_name] ~= nil then
						local var_403_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_33.prefab_name].transform, "story_v_out_413031", "413031095", "story_v_out_413031.awb")

						arg_400_1:RecordAudio("413031095", var_403_39)
						arg_400_1:RecordAudio("413031095", var_403_39)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_413031", "413031095", "story_v_out_413031.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_413031", "413031095", "story_v_out_413031.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_40 = math.max(var_403_31, arg_400_1.talkMaxDuration)

			if var_403_30 <= arg_400_1.time_ and arg_400_1.time_ < var_403_30 + var_403_40 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_30) / var_403_40

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_30 + var_403_40 and arg_400_1.time_ < var_403_30 + var_403_40 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play413031096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 413031096
		arg_404_1.duration_ = 7.4

		local var_404_0 = {
			zh = 7.4,
			ja = 5.466
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play413031097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["10093"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos10093 = var_407_0.localPosition
				var_407_0.localScale = Vector3.New(1, 1, 1)

				arg_404_1:CheckSpriteTmpPos("10093", 2)

				local var_407_2 = var_407_0.childCount

				for iter_407_0 = 0, var_407_2 - 1 do
					local var_407_3 = var_407_0:GetChild(iter_407_0)

					if var_407_3.name == "split_4" or not string.find(var_407_3.name, "split") then
						var_407_3.gameObject:SetActive(true)
					else
						var_407_3.gameObject:SetActive(false)
					end
				end
			end

			local var_407_4 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_4 then
				local var_407_5 = (arg_404_1.time_ - var_407_1) / var_407_4
				local var_407_6 = Vector3.New(-390, -345, -245)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10093, var_407_6, var_407_5)
			end

			if arg_404_1.time_ >= var_407_1 + var_407_4 and arg_404_1.time_ < var_407_1 + var_407_4 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_407_7 = arg_404_1.actors_["10093"]
			local var_407_8 = 0

			if var_407_8 < arg_404_1.time_ and arg_404_1.time_ <= var_407_8 + arg_407_0 and not isNil(var_407_7) and arg_404_1.var_.actorSpriteComps10093 == nil then
				arg_404_1.var_.actorSpriteComps10093 = var_407_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_9 = 2

			if var_407_8 <= arg_404_1.time_ and arg_404_1.time_ < var_407_8 + var_407_9 and not isNil(var_407_7) then
				local var_407_10 = (arg_404_1.time_ - var_407_8) / var_407_9

				if arg_404_1.var_.actorSpriteComps10093 then
					for iter_407_1, iter_407_2 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_407_2 then
							if arg_404_1.isInRecall_ then
								local var_407_11 = Mathf.Lerp(iter_407_2.color.r, arg_404_1.hightColor1.r, var_407_10)
								local var_407_12 = Mathf.Lerp(iter_407_2.color.g, arg_404_1.hightColor1.g, var_407_10)
								local var_407_13 = Mathf.Lerp(iter_407_2.color.b, arg_404_1.hightColor1.b, var_407_10)

								iter_407_2.color = Color.New(var_407_11, var_407_12, var_407_13)
							else
								local var_407_14 = Mathf.Lerp(iter_407_2.color.r, 1, var_407_10)

								iter_407_2.color = Color.New(var_407_14, var_407_14, var_407_14)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_8 + var_407_9 and arg_404_1.time_ < var_407_8 + var_407_9 + arg_407_0 and not isNil(var_407_7) and arg_404_1.var_.actorSpriteComps10093 then
				for iter_407_3, iter_407_4 in pairs(arg_404_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_407_4 then
						if arg_404_1.isInRecall_ then
							iter_407_4.color = arg_404_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_407_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps10093 = nil
			end

			local var_407_15 = arg_404_1.actors_["10022"]
			local var_407_16 = 0

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.actorSpriteComps10022 == nil then
				arg_404_1.var_.actorSpriteComps10022 = var_407_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_17 = 2

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 and not isNil(var_407_15) then
				local var_407_18 = (arg_404_1.time_ - var_407_16) / var_407_17

				if arg_404_1.var_.actorSpriteComps10022 then
					for iter_407_5, iter_407_6 in pairs(arg_404_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_407_6 then
							if arg_404_1.isInRecall_ then
								local var_407_19 = Mathf.Lerp(iter_407_6.color.r, arg_404_1.hightColor2.r, var_407_18)
								local var_407_20 = Mathf.Lerp(iter_407_6.color.g, arg_404_1.hightColor2.g, var_407_18)
								local var_407_21 = Mathf.Lerp(iter_407_6.color.b, arg_404_1.hightColor2.b, var_407_18)

								iter_407_6.color = Color.New(var_407_19, var_407_20, var_407_21)
							else
								local var_407_22 = Mathf.Lerp(iter_407_6.color.r, 0.5, var_407_18)

								iter_407_6.color = Color.New(var_407_22, var_407_22, var_407_22)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 and not isNil(var_407_15) and arg_404_1.var_.actorSpriteComps10022 then
				for iter_407_7, iter_407_8 in pairs(arg_404_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_407_8 then
						if arg_404_1.isInRecall_ then
							iter_407_8.color = arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_407_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps10022 = nil
			end

			local var_407_23 = 0
			local var_407_24 = 0.95

			if var_407_23 < arg_404_1.time_ and arg_404_1.time_ <= var_407_23 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_25 = arg_404_1:FormatText(StoryNameCfg[28].name)

				arg_404_1.leftNameTxt_.text = var_407_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_26 = arg_404_1:GetWordFromCfg(413031096)
				local var_407_27 = arg_404_1:FormatText(var_407_26.content)

				arg_404_1.text_.text = var_407_27

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_28 = 38
				local var_407_29 = utf8.len(var_407_27)
				local var_407_30 = var_407_28 <= 0 and var_407_24 or var_407_24 * (var_407_29 / var_407_28)

				if var_407_30 > 0 and var_407_24 < var_407_30 then
					arg_404_1.talkMaxDuration = var_407_30

					if var_407_30 + var_407_23 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_30 + var_407_23
					end
				end

				arg_404_1.text_.text = var_407_27
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031096", "story_v_out_413031.awb") ~= 0 then
					local var_407_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031096", "story_v_out_413031.awb") / 1000

					if var_407_31 + var_407_23 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_31 + var_407_23
					end

					if var_407_26.prefab_name ~= "" and arg_404_1.actors_[var_407_26.prefab_name] ~= nil then
						local var_407_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_26.prefab_name].transform, "story_v_out_413031", "413031096", "story_v_out_413031.awb")

						arg_404_1:RecordAudio("413031096", var_407_32)
						arg_404_1:RecordAudio("413031096", var_407_32)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_413031", "413031096", "story_v_out_413031.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_413031", "413031096", "story_v_out_413031.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_33 = math.max(var_407_24, arg_404_1.talkMaxDuration)

			if var_407_23 <= arg_404_1.time_ and arg_404_1.time_ < var_407_23 + var_407_33 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_23) / var_407_33

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_23 + var_407_33 and arg_404_1.time_ < var_407_23 + var_407_33 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play413031097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 413031097
		arg_408_1.duration_ = 8.17

		local var_408_0 = {
			zh = 5.866,
			ja = 8.166
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play413031098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.8

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_2 = arg_408_1:FormatText(StoryNameCfg[28].name)

				arg_408_1.leftNameTxt_.text = var_411_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(413031097)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 32
				local var_411_6 = utf8.len(var_411_4)
				local var_411_7 = var_411_5 <= 0 and var_411_1 or var_411_1 * (var_411_6 / var_411_5)

				if var_411_7 > 0 and var_411_1 < var_411_7 then
					arg_408_1.talkMaxDuration = var_411_7

					if var_411_7 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031097", "story_v_out_413031.awb") ~= 0 then
					local var_411_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031097", "story_v_out_413031.awb") / 1000

					if var_411_8 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_0
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_413031", "413031097", "story_v_out_413031.awb")

						arg_408_1:RecordAudio("413031097", var_411_9)
						arg_408_1:RecordAudio("413031097", var_411_9)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_413031", "413031097", "story_v_out_413031.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_413031", "413031097", "story_v_out_413031.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_10 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_10 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_10

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_10 and arg_408_1.time_ < var_411_0 + var_411_10 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play413031098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 413031098
		arg_412_1.duration_ = 6.63

		local var_412_0 = {
			zh = 3.133,
			ja = 6.633
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play413031099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10093"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps10093 == nil then
				arg_412_1.var_.actorSpriteComps10093 = var_415_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_2 = 2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.actorSpriteComps10093 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								local var_415_4 = Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor2.r, var_415_3)
								local var_415_5 = Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor2.g, var_415_3)
								local var_415_6 = Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor2.b, var_415_3)

								iter_415_1.color = Color.New(var_415_4, var_415_5, var_415_6)
							else
								local var_415_7 = Mathf.Lerp(iter_415_1.color.r, 0.5, var_415_3)

								iter_415_1.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps10093 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_415_3 then
						if arg_412_1.isInRecall_ then
							iter_415_3.color = arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_415_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps10093 = nil
			end

			local var_415_8 = arg_412_1.actors_["10022"]
			local var_415_9 = 0

			if var_415_9 < arg_412_1.time_ and arg_412_1.time_ <= var_415_9 + arg_415_0 and not isNil(var_415_8) and arg_412_1.var_.actorSpriteComps10022 == nil then
				arg_412_1.var_.actorSpriteComps10022 = var_415_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_10 = 2

			if var_415_9 <= arg_412_1.time_ and arg_412_1.time_ < var_415_9 + var_415_10 and not isNil(var_415_8) then
				local var_415_11 = (arg_412_1.time_ - var_415_9) / var_415_10

				if arg_412_1.var_.actorSpriteComps10022 then
					for iter_415_4, iter_415_5 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_415_5 then
							if arg_412_1.isInRecall_ then
								local var_415_12 = Mathf.Lerp(iter_415_5.color.r, arg_412_1.hightColor1.r, var_415_11)
								local var_415_13 = Mathf.Lerp(iter_415_5.color.g, arg_412_1.hightColor1.g, var_415_11)
								local var_415_14 = Mathf.Lerp(iter_415_5.color.b, arg_412_1.hightColor1.b, var_415_11)

								iter_415_5.color = Color.New(var_415_12, var_415_13, var_415_14)
							else
								local var_415_15 = Mathf.Lerp(iter_415_5.color.r, 1, var_415_11)

								iter_415_5.color = Color.New(var_415_15, var_415_15, var_415_15)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_9 + var_415_10 and arg_412_1.time_ < var_415_9 + var_415_10 + arg_415_0 and not isNil(var_415_8) and arg_412_1.var_.actorSpriteComps10022 then
				for iter_415_6, iter_415_7 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_415_7 then
						if arg_412_1.isInRecall_ then
							iter_415_7.color = arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_415_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps10022 = nil
			end

			local var_415_16 = 0
			local var_415_17 = 0.475

			if var_415_16 < arg_412_1.time_ and arg_412_1.time_ <= var_415_16 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_18 = arg_412_1:FormatText(StoryNameCfg[614].name)

				arg_412_1.leftNameTxt_.text = var_415_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_19 = arg_412_1:GetWordFromCfg(413031098)
				local var_415_20 = arg_412_1:FormatText(var_415_19.content)

				arg_412_1.text_.text = var_415_20

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_21 = 19
				local var_415_22 = utf8.len(var_415_20)
				local var_415_23 = var_415_21 <= 0 and var_415_17 or var_415_17 * (var_415_22 / var_415_21)

				if var_415_23 > 0 and var_415_17 < var_415_23 then
					arg_412_1.talkMaxDuration = var_415_23

					if var_415_23 + var_415_16 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_16
					end
				end

				arg_412_1.text_.text = var_415_20
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031098", "story_v_out_413031.awb") ~= 0 then
					local var_415_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031098", "story_v_out_413031.awb") / 1000

					if var_415_24 + var_415_16 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_24 + var_415_16
					end

					if var_415_19.prefab_name ~= "" and arg_412_1.actors_[var_415_19.prefab_name] ~= nil then
						local var_415_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_19.prefab_name].transform, "story_v_out_413031", "413031098", "story_v_out_413031.awb")

						arg_412_1:RecordAudio("413031098", var_415_25)
						arg_412_1:RecordAudio("413031098", var_415_25)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_413031", "413031098", "story_v_out_413031.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_413031", "413031098", "story_v_out_413031.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_26 = math.max(var_415_17, arg_412_1.talkMaxDuration)

			if var_415_16 <= arg_412_1.time_ and arg_412_1.time_ < var_415_16 + var_415_26 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_16) / var_415_26

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_16 + var_415_26 and arg_412_1.time_ < var_415_16 + var_415_26 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play413031099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 413031099
		arg_416_1.duration_ = 11.03

		local var_416_0 = {
			zh = 9.833,
			ja = 11.033
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play413031100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10093"].transform
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.var_.moveOldPos10093 = var_419_0.localPosition
				var_419_0.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10093", 2)

				local var_419_2 = var_419_0.childCount

				for iter_419_0 = 0, var_419_2 - 1 do
					local var_419_3 = var_419_0:GetChild(iter_419_0)

					if var_419_3.name == "split_6" or not string.find(var_419_3.name, "split") then
						var_419_3.gameObject:SetActive(true)
					else
						var_419_3.gameObject:SetActive(false)
					end
				end
			end

			local var_419_4 = 0.001

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_4 then
				local var_419_5 = (arg_416_1.time_ - var_419_1) / var_419_4
				local var_419_6 = Vector3.New(-390, -345, -245)

				var_419_0.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10093, var_419_6, var_419_5)
			end

			if arg_416_1.time_ >= var_419_1 + var_419_4 and arg_416_1.time_ < var_419_1 + var_419_4 + arg_419_0 then
				var_419_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_419_7 = arg_416_1.actors_["10093"]
			local var_419_8 = 0

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 and not isNil(var_419_7) and arg_416_1.var_.actorSpriteComps10093 == nil then
				arg_416_1.var_.actorSpriteComps10093 = var_419_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_9 = 2

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_9 and not isNil(var_419_7) then
				local var_419_10 = (arg_416_1.time_ - var_419_8) / var_419_9

				if arg_416_1.var_.actorSpriteComps10093 then
					for iter_419_1, iter_419_2 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_419_2 then
							if arg_416_1.isInRecall_ then
								local var_419_11 = Mathf.Lerp(iter_419_2.color.r, arg_416_1.hightColor1.r, var_419_10)
								local var_419_12 = Mathf.Lerp(iter_419_2.color.g, arg_416_1.hightColor1.g, var_419_10)
								local var_419_13 = Mathf.Lerp(iter_419_2.color.b, arg_416_1.hightColor1.b, var_419_10)

								iter_419_2.color = Color.New(var_419_11, var_419_12, var_419_13)
							else
								local var_419_14 = Mathf.Lerp(iter_419_2.color.r, 1, var_419_10)

								iter_419_2.color = Color.New(var_419_14, var_419_14, var_419_14)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_8 + var_419_9 and arg_416_1.time_ < var_419_8 + var_419_9 + arg_419_0 and not isNil(var_419_7) and arg_416_1.var_.actorSpriteComps10093 then
				for iter_419_3, iter_419_4 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_419_4 then
						if arg_416_1.isInRecall_ then
							iter_419_4.color = arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_419_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10093 = nil
			end

			local var_419_15 = arg_416_1.actors_["10022"]
			local var_419_16 = 0

			if var_419_16 < arg_416_1.time_ and arg_416_1.time_ <= var_419_16 + arg_419_0 and not isNil(var_419_15) and arg_416_1.var_.actorSpriteComps10022 == nil then
				arg_416_1.var_.actorSpriteComps10022 = var_419_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_17 = 2

			if var_419_16 <= arg_416_1.time_ and arg_416_1.time_ < var_419_16 + var_419_17 and not isNil(var_419_15) then
				local var_419_18 = (arg_416_1.time_ - var_419_16) / var_419_17

				if arg_416_1.var_.actorSpriteComps10022 then
					for iter_419_5, iter_419_6 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_419_6 then
							if arg_416_1.isInRecall_ then
								local var_419_19 = Mathf.Lerp(iter_419_6.color.r, arg_416_1.hightColor2.r, var_419_18)
								local var_419_20 = Mathf.Lerp(iter_419_6.color.g, arg_416_1.hightColor2.g, var_419_18)
								local var_419_21 = Mathf.Lerp(iter_419_6.color.b, arg_416_1.hightColor2.b, var_419_18)

								iter_419_6.color = Color.New(var_419_19, var_419_20, var_419_21)
							else
								local var_419_22 = Mathf.Lerp(iter_419_6.color.r, 0.5, var_419_18)

								iter_419_6.color = Color.New(var_419_22, var_419_22, var_419_22)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_16 + var_419_17 and arg_416_1.time_ < var_419_16 + var_419_17 + arg_419_0 and not isNil(var_419_15) and arg_416_1.var_.actorSpriteComps10022 then
				for iter_419_7, iter_419_8 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_419_8 then
						if arg_416_1.isInRecall_ then
							iter_419_8.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10022 = nil
			end

			local var_419_23 = 0
			local var_419_24 = 1.05

			if var_419_23 < arg_416_1.time_ and arg_416_1.time_ <= var_419_23 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_25 = arg_416_1:FormatText(StoryNameCfg[28].name)

				arg_416_1.leftNameTxt_.text = var_419_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_26 = arg_416_1:GetWordFromCfg(413031099)
				local var_419_27 = arg_416_1:FormatText(var_419_26.content)

				arg_416_1.text_.text = var_419_27

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_28 = 42
				local var_419_29 = utf8.len(var_419_27)
				local var_419_30 = var_419_28 <= 0 and var_419_24 or var_419_24 * (var_419_29 / var_419_28)

				if var_419_30 > 0 and var_419_24 < var_419_30 then
					arg_416_1.talkMaxDuration = var_419_30

					if var_419_30 + var_419_23 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_30 + var_419_23
					end
				end

				arg_416_1.text_.text = var_419_27
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031099", "story_v_out_413031.awb") ~= 0 then
					local var_419_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031099", "story_v_out_413031.awb") / 1000

					if var_419_31 + var_419_23 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_31 + var_419_23
					end

					if var_419_26.prefab_name ~= "" and arg_416_1.actors_[var_419_26.prefab_name] ~= nil then
						local var_419_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_26.prefab_name].transform, "story_v_out_413031", "413031099", "story_v_out_413031.awb")

						arg_416_1:RecordAudio("413031099", var_419_32)
						arg_416_1:RecordAudio("413031099", var_419_32)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_413031", "413031099", "story_v_out_413031.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_413031", "413031099", "story_v_out_413031.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_33 = math.max(var_419_24, arg_416_1.talkMaxDuration)

			if var_419_23 <= arg_416_1.time_ and arg_416_1.time_ < var_419_23 + var_419_33 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_23) / var_419_33

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_23 + var_419_33 and arg_416_1.time_ < var_419_23 + var_419_33 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play413031100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 413031100
		arg_420_1.duration_ = 8.83

		local var_420_0 = {
			zh = 3.933,
			ja = 8.833
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play413031101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10022"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos10022 = var_423_0.localPosition
				var_423_0.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10022", 4)

				local var_423_2 = var_423_0.childCount

				for iter_423_0 = 0, var_423_2 - 1 do
					local var_423_3 = var_423_0:GetChild(iter_423_0)

					if var_423_3.name == "split_8" or not string.find(var_423_3.name, "split") then
						var_423_3.gameObject:SetActive(true)
					else
						var_423_3.gameObject:SetActive(false)
					end
				end
			end

			local var_423_4 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_4 then
				local var_423_5 = (arg_420_1.time_ - var_423_1) / var_423_4
				local var_423_6 = Vector3.New(390, -315, -320)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10022, var_423_6, var_423_5)
			end

			if arg_420_1.time_ >= var_423_1 + var_423_4 and arg_420_1.time_ < var_423_1 + var_423_4 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_423_7 = arg_420_1.actors_["10093"]
			local var_423_8 = 0

			if var_423_8 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 and not isNil(var_423_7) and arg_420_1.var_.actorSpriteComps10093 == nil then
				arg_420_1.var_.actorSpriteComps10093 = var_423_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_9 = 2

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_9 and not isNil(var_423_7) then
				local var_423_10 = (arg_420_1.time_ - var_423_8) / var_423_9

				if arg_420_1.var_.actorSpriteComps10093 then
					for iter_423_1, iter_423_2 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_423_2 then
							if arg_420_1.isInRecall_ then
								local var_423_11 = Mathf.Lerp(iter_423_2.color.r, arg_420_1.hightColor2.r, var_423_10)
								local var_423_12 = Mathf.Lerp(iter_423_2.color.g, arg_420_1.hightColor2.g, var_423_10)
								local var_423_13 = Mathf.Lerp(iter_423_2.color.b, arg_420_1.hightColor2.b, var_423_10)

								iter_423_2.color = Color.New(var_423_11, var_423_12, var_423_13)
							else
								local var_423_14 = Mathf.Lerp(iter_423_2.color.r, 0.5, var_423_10)

								iter_423_2.color = Color.New(var_423_14, var_423_14, var_423_14)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_8 + var_423_9 and arg_420_1.time_ < var_423_8 + var_423_9 + arg_423_0 and not isNil(var_423_7) and arg_420_1.var_.actorSpriteComps10093 then
				for iter_423_3, iter_423_4 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_423_4 then
						if arg_420_1.isInRecall_ then
							iter_423_4.color = arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_423_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10093 = nil
			end

			local var_423_15 = arg_420_1.actors_["10022"]
			local var_423_16 = 0

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 and not isNil(var_423_15) and arg_420_1.var_.actorSpriteComps10022 == nil then
				arg_420_1.var_.actorSpriteComps10022 = var_423_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_17 = 2

			if var_423_16 <= arg_420_1.time_ and arg_420_1.time_ < var_423_16 + var_423_17 and not isNil(var_423_15) then
				local var_423_18 = (arg_420_1.time_ - var_423_16) / var_423_17

				if arg_420_1.var_.actorSpriteComps10022 then
					for iter_423_5, iter_423_6 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_423_6 then
							if arg_420_1.isInRecall_ then
								local var_423_19 = Mathf.Lerp(iter_423_6.color.r, arg_420_1.hightColor1.r, var_423_18)
								local var_423_20 = Mathf.Lerp(iter_423_6.color.g, arg_420_1.hightColor1.g, var_423_18)
								local var_423_21 = Mathf.Lerp(iter_423_6.color.b, arg_420_1.hightColor1.b, var_423_18)

								iter_423_6.color = Color.New(var_423_19, var_423_20, var_423_21)
							else
								local var_423_22 = Mathf.Lerp(iter_423_6.color.r, 1, var_423_18)

								iter_423_6.color = Color.New(var_423_22, var_423_22, var_423_22)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_16 + var_423_17 and arg_420_1.time_ < var_423_16 + var_423_17 + arg_423_0 and not isNil(var_423_15) and arg_420_1.var_.actorSpriteComps10022 then
				for iter_423_7, iter_423_8 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_423_8 then
						if arg_420_1.isInRecall_ then
							iter_423_8.color = arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_423_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10022 = nil
			end

			local var_423_23 = 0
			local var_423_24 = 0.6

			if var_423_23 < arg_420_1.time_ and arg_420_1.time_ <= var_423_23 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_25 = arg_420_1:FormatText(StoryNameCfg[614].name)

				arg_420_1.leftNameTxt_.text = var_423_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_26 = arg_420_1:GetWordFromCfg(413031100)
				local var_423_27 = arg_420_1:FormatText(var_423_26.content)

				arg_420_1.text_.text = var_423_27

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_28 = 24
				local var_423_29 = utf8.len(var_423_27)
				local var_423_30 = var_423_28 <= 0 and var_423_24 or var_423_24 * (var_423_29 / var_423_28)

				if var_423_30 > 0 and var_423_24 < var_423_30 then
					arg_420_1.talkMaxDuration = var_423_30

					if var_423_30 + var_423_23 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_30 + var_423_23
					end
				end

				arg_420_1.text_.text = var_423_27
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031100", "story_v_out_413031.awb") ~= 0 then
					local var_423_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031100", "story_v_out_413031.awb") / 1000

					if var_423_31 + var_423_23 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_31 + var_423_23
					end

					if var_423_26.prefab_name ~= "" and arg_420_1.actors_[var_423_26.prefab_name] ~= nil then
						local var_423_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_26.prefab_name].transform, "story_v_out_413031", "413031100", "story_v_out_413031.awb")

						arg_420_1:RecordAudio("413031100", var_423_32)
						arg_420_1:RecordAudio("413031100", var_423_32)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_413031", "413031100", "story_v_out_413031.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_413031", "413031100", "story_v_out_413031.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_33 = math.max(var_423_24, arg_420_1.talkMaxDuration)

			if var_423_23 <= arg_420_1.time_ and arg_420_1.time_ < var_423_23 + var_423_33 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_23) / var_423_33

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_23 + var_423_33 and arg_420_1.time_ < var_423_23 + var_423_33 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
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

		arg_420_1:InitPlayNodeList()
	end,
	Play413031101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413031101
		arg_424_1.duration_ = 3.23

		local var_424_0 = {
			zh = 3,
			ja = 3.233
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play413031102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10093"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos10093 = var_427_0.localPosition
				var_427_0.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10093", 2)

				local var_427_2 = var_427_0.childCount

				for iter_427_0 = 0, var_427_2 - 1 do
					local var_427_3 = var_427_0:GetChild(iter_427_0)

					if var_427_3.name == "split_4" or not string.find(var_427_3.name, "split") then
						var_427_3.gameObject:SetActive(true)
					else
						var_427_3.gameObject:SetActive(false)
					end
				end
			end

			local var_427_4 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_4 then
				local var_427_5 = (arg_424_1.time_ - var_427_1) / var_427_4
				local var_427_6 = Vector3.New(-390, -345, -245)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10093, var_427_6, var_427_5)
			end

			if arg_424_1.time_ >= var_427_1 + var_427_4 and arg_424_1.time_ < var_427_1 + var_427_4 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_427_7 = arg_424_1.actors_["10093"]
			local var_427_8 = 0

			if var_427_8 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 and not isNil(var_427_7) and arg_424_1.var_.actorSpriteComps10093 == nil then
				arg_424_1.var_.actorSpriteComps10093 = var_427_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_9 = 2

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_9 and not isNil(var_427_7) then
				local var_427_10 = (arg_424_1.time_ - var_427_8) / var_427_9

				if arg_424_1.var_.actorSpriteComps10093 then
					for iter_427_1, iter_427_2 in pairs(arg_424_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_427_2 then
							if arg_424_1.isInRecall_ then
								local var_427_11 = Mathf.Lerp(iter_427_2.color.r, arg_424_1.hightColor1.r, var_427_10)
								local var_427_12 = Mathf.Lerp(iter_427_2.color.g, arg_424_1.hightColor1.g, var_427_10)
								local var_427_13 = Mathf.Lerp(iter_427_2.color.b, arg_424_1.hightColor1.b, var_427_10)

								iter_427_2.color = Color.New(var_427_11, var_427_12, var_427_13)
							else
								local var_427_14 = Mathf.Lerp(iter_427_2.color.r, 1, var_427_10)

								iter_427_2.color = Color.New(var_427_14, var_427_14, var_427_14)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= var_427_8 + var_427_9 and arg_424_1.time_ < var_427_8 + var_427_9 + arg_427_0 and not isNil(var_427_7) and arg_424_1.var_.actorSpriteComps10093 then
				for iter_427_3, iter_427_4 in pairs(arg_424_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_427_4 then
						if arg_424_1.isInRecall_ then
							iter_427_4.color = arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_427_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_424_1.var_.actorSpriteComps10093 = nil
			end

			local var_427_15 = arg_424_1.actors_["10022"]
			local var_427_16 = 0

			if var_427_16 < arg_424_1.time_ and arg_424_1.time_ <= var_427_16 + arg_427_0 and not isNil(var_427_15) and arg_424_1.var_.actorSpriteComps10022 == nil then
				arg_424_1.var_.actorSpriteComps10022 = var_427_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_17 = 2

			if var_427_16 <= arg_424_1.time_ and arg_424_1.time_ < var_427_16 + var_427_17 and not isNil(var_427_15) then
				local var_427_18 = (arg_424_1.time_ - var_427_16) / var_427_17

				if arg_424_1.var_.actorSpriteComps10022 then
					for iter_427_5, iter_427_6 in pairs(arg_424_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_427_6 then
							if arg_424_1.isInRecall_ then
								local var_427_19 = Mathf.Lerp(iter_427_6.color.r, arg_424_1.hightColor2.r, var_427_18)
								local var_427_20 = Mathf.Lerp(iter_427_6.color.g, arg_424_1.hightColor2.g, var_427_18)
								local var_427_21 = Mathf.Lerp(iter_427_6.color.b, arg_424_1.hightColor2.b, var_427_18)

								iter_427_6.color = Color.New(var_427_19, var_427_20, var_427_21)
							else
								local var_427_22 = Mathf.Lerp(iter_427_6.color.r, 0.5, var_427_18)

								iter_427_6.color = Color.New(var_427_22, var_427_22, var_427_22)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= var_427_16 + var_427_17 and arg_424_1.time_ < var_427_16 + var_427_17 + arg_427_0 and not isNil(var_427_15) and arg_424_1.var_.actorSpriteComps10022 then
				for iter_427_7, iter_427_8 in pairs(arg_424_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_427_8 then
						if arg_424_1.isInRecall_ then
							iter_427_8.color = arg_424_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_427_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_424_1.var_.actorSpriteComps10022 = nil
			end

			local var_427_23 = 0
			local var_427_24 = 0.375

			if var_427_23 < arg_424_1.time_ and arg_424_1.time_ <= var_427_23 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_25 = arg_424_1:FormatText(StoryNameCfg[28].name)

				arg_424_1.leftNameTxt_.text = var_427_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_26 = arg_424_1:GetWordFromCfg(413031101)
				local var_427_27 = arg_424_1:FormatText(var_427_26.content)

				arg_424_1.text_.text = var_427_27

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_28 = 15
				local var_427_29 = utf8.len(var_427_27)
				local var_427_30 = var_427_28 <= 0 and var_427_24 or var_427_24 * (var_427_29 / var_427_28)

				if var_427_30 > 0 and var_427_24 < var_427_30 then
					arg_424_1.talkMaxDuration = var_427_30

					if var_427_30 + var_427_23 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_30 + var_427_23
					end
				end

				arg_424_1.text_.text = var_427_27
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031101", "story_v_out_413031.awb") ~= 0 then
					local var_427_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031101", "story_v_out_413031.awb") / 1000

					if var_427_31 + var_427_23 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_31 + var_427_23
					end

					if var_427_26.prefab_name ~= "" and arg_424_1.actors_[var_427_26.prefab_name] ~= nil then
						local var_427_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_26.prefab_name].transform, "story_v_out_413031", "413031101", "story_v_out_413031.awb")

						arg_424_1:RecordAudio("413031101", var_427_32)
						arg_424_1:RecordAudio("413031101", var_427_32)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413031", "413031101", "story_v_out_413031.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413031", "413031101", "story_v_out_413031.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_33 = math.max(var_427_24, arg_424_1.talkMaxDuration)

			if var_427_23 <= arg_424_1.time_ and arg_424_1.time_ < var_427_23 + var_427_33 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_23) / var_427_33

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_23 + var_427_33 and arg_424_1.time_ < var_427_23 + var_427_33 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play413031102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 413031102
		arg_428_1.duration_ = 4.3

		local var_428_0 = {
			zh = 3.233,
			ja = 4.3
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play413031103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10022"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos10022 = var_431_0.localPosition
				var_431_0.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10022", 4)

				local var_431_2 = var_431_0.childCount

				for iter_431_0 = 0, var_431_2 - 1 do
					local var_431_3 = var_431_0:GetChild(iter_431_0)

					if var_431_3.name == "split_6" or not string.find(var_431_3.name, "split") then
						var_431_3.gameObject:SetActive(true)
					else
						var_431_3.gameObject:SetActive(false)
					end
				end
			end

			local var_431_4 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_4 then
				local var_431_5 = (arg_428_1.time_ - var_431_1) / var_431_4
				local var_431_6 = Vector3.New(390, -315, -320)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10022, var_431_6, var_431_5)
			end

			if arg_428_1.time_ >= var_431_1 + var_431_4 and arg_428_1.time_ < var_431_1 + var_431_4 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_431_7 = arg_428_1.actors_["10093"]
			local var_431_8 = 0

			if var_431_8 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 and not isNil(var_431_7) and arg_428_1.var_.actorSpriteComps10093 == nil then
				arg_428_1.var_.actorSpriteComps10093 = var_431_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_9 = 2

			if var_431_8 <= arg_428_1.time_ and arg_428_1.time_ < var_431_8 + var_431_9 and not isNil(var_431_7) then
				local var_431_10 = (arg_428_1.time_ - var_431_8) / var_431_9

				if arg_428_1.var_.actorSpriteComps10093 then
					for iter_431_1, iter_431_2 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_431_2 then
							if arg_428_1.isInRecall_ then
								local var_431_11 = Mathf.Lerp(iter_431_2.color.r, arg_428_1.hightColor2.r, var_431_10)
								local var_431_12 = Mathf.Lerp(iter_431_2.color.g, arg_428_1.hightColor2.g, var_431_10)
								local var_431_13 = Mathf.Lerp(iter_431_2.color.b, arg_428_1.hightColor2.b, var_431_10)

								iter_431_2.color = Color.New(var_431_11, var_431_12, var_431_13)
							else
								local var_431_14 = Mathf.Lerp(iter_431_2.color.r, 0.5, var_431_10)

								iter_431_2.color = Color.New(var_431_14, var_431_14, var_431_14)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_8 + var_431_9 and arg_428_1.time_ < var_431_8 + var_431_9 + arg_431_0 and not isNil(var_431_7) and arg_428_1.var_.actorSpriteComps10093 then
				for iter_431_3, iter_431_4 in pairs(arg_428_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_431_4 then
						if arg_428_1.isInRecall_ then
							iter_431_4.color = arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_431_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps10093 = nil
			end

			local var_431_15 = arg_428_1.actors_["10022"]
			local var_431_16 = 0

			if var_431_16 < arg_428_1.time_ and arg_428_1.time_ <= var_431_16 + arg_431_0 and not isNil(var_431_15) and arg_428_1.var_.actorSpriteComps10022 == nil then
				arg_428_1.var_.actorSpriteComps10022 = var_431_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_17 = 2

			if var_431_16 <= arg_428_1.time_ and arg_428_1.time_ < var_431_16 + var_431_17 and not isNil(var_431_15) then
				local var_431_18 = (arg_428_1.time_ - var_431_16) / var_431_17

				if arg_428_1.var_.actorSpriteComps10022 then
					for iter_431_5, iter_431_6 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_431_6 then
							if arg_428_1.isInRecall_ then
								local var_431_19 = Mathf.Lerp(iter_431_6.color.r, arg_428_1.hightColor1.r, var_431_18)
								local var_431_20 = Mathf.Lerp(iter_431_6.color.g, arg_428_1.hightColor1.g, var_431_18)
								local var_431_21 = Mathf.Lerp(iter_431_6.color.b, arg_428_1.hightColor1.b, var_431_18)

								iter_431_6.color = Color.New(var_431_19, var_431_20, var_431_21)
							else
								local var_431_22 = Mathf.Lerp(iter_431_6.color.r, 1, var_431_18)

								iter_431_6.color = Color.New(var_431_22, var_431_22, var_431_22)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_16 + var_431_17 and arg_428_1.time_ < var_431_16 + var_431_17 + arg_431_0 and not isNil(var_431_15) and arg_428_1.var_.actorSpriteComps10022 then
				for iter_431_7, iter_431_8 in pairs(arg_428_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_431_8 then
						if arg_428_1.isInRecall_ then
							iter_431_8.color = arg_428_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_431_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps10022 = nil
			end

			local var_431_23 = 0
			local var_431_24 = 0.35

			if var_431_23 < arg_428_1.time_ and arg_428_1.time_ <= var_431_23 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_25 = arg_428_1:FormatText(StoryNameCfg[614].name)

				arg_428_1.leftNameTxt_.text = var_431_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_26 = arg_428_1:GetWordFromCfg(413031102)
				local var_431_27 = arg_428_1:FormatText(var_431_26.content)

				arg_428_1.text_.text = var_431_27

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_28 = 14
				local var_431_29 = utf8.len(var_431_27)
				local var_431_30 = var_431_28 <= 0 and var_431_24 or var_431_24 * (var_431_29 / var_431_28)

				if var_431_30 > 0 and var_431_24 < var_431_30 then
					arg_428_1.talkMaxDuration = var_431_30

					if var_431_30 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_30 + var_431_23
					end
				end

				arg_428_1.text_.text = var_431_27
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031102", "story_v_out_413031.awb") ~= 0 then
					local var_431_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031102", "story_v_out_413031.awb") / 1000

					if var_431_31 + var_431_23 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_31 + var_431_23
					end

					if var_431_26.prefab_name ~= "" and arg_428_1.actors_[var_431_26.prefab_name] ~= nil then
						local var_431_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_26.prefab_name].transform, "story_v_out_413031", "413031102", "story_v_out_413031.awb")

						arg_428_1:RecordAudio("413031102", var_431_32)
						arg_428_1:RecordAudio("413031102", var_431_32)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_413031", "413031102", "story_v_out_413031.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_413031", "413031102", "story_v_out_413031.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_33 = math.max(var_431_24, arg_428_1.talkMaxDuration)

			if var_431_23 <= arg_428_1.time_ and arg_428_1.time_ < var_431_23 + var_431_33 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_23) / var_431_33

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_23 + var_431_33 and arg_428_1.time_ < var_431_23 + var_431_33 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play413031103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 413031103
		arg_432_1.duration_ = 8.53

		local var_432_0 = {
			zh = 6.733,
			ja = 8.533
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play413031104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["10093"].transform
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.var_.moveOldPos10093 = var_435_0.localPosition
				var_435_0.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10093", 2)

				local var_435_2 = var_435_0.childCount

				for iter_435_0 = 0, var_435_2 - 1 do
					local var_435_3 = var_435_0:GetChild(iter_435_0)

					if var_435_3.name == "" or not string.find(var_435_3.name, "split") then
						var_435_3.gameObject:SetActive(true)
					else
						var_435_3.gameObject:SetActive(false)
					end
				end
			end

			local var_435_4 = 0.001

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_4 then
				local var_435_5 = (arg_432_1.time_ - var_435_1) / var_435_4
				local var_435_6 = Vector3.New(-390, -345, -245)

				var_435_0.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10093, var_435_6, var_435_5)
			end

			if arg_432_1.time_ >= var_435_1 + var_435_4 and arg_432_1.time_ < var_435_1 + var_435_4 + arg_435_0 then
				var_435_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_435_7 = arg_432_1.actors_["10022"].transform
			local var_435_8 = 0

			if var_435_8 < arg_432_1.time_ and arg_432_1.time_ <= var_435_8 + arg_435_0 then
				arg_432_1.var_.moveOldPos10022 = var_435_7.localPosition
				var_435_7.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10022", 4)

				local var_435_9 = var_435_7.childCount

				for iter_435_1 = 0, var_435_9 - 1 do
					local var_435_10 = var_435_7:GetChild(iter_435_1)

					if var_435_10.name == "" or not string.find(var_435_10.name, "split") then
						var_435_10.gameObject:SetActive(true)
					else
						var_435_10.gameObject:SetActive(false)
					end
				end
			end

			local var_435_11 = 0.001

			if var_435_8 <= arg_432_1.time_ and arg_432_1.time_ < var_435_8 + var_435_11 then
				local var_435_12 = (arg_432_1.time_ - var_435_8) / var_435_11
				local var_435_13 = Vector3.New(390, -315, -320)

				var_435_7.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10022, var_435_13, var_435_12)
			end

			if arg_432_1.time_ >= var_435_8 + var_435_11 and arg_432_1.time_ < var_435_8 + var_435_11 + arg_435_0 then
				var_435_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_435_14 = arg_432_1.actors_["10093"]
			local var_435_15 = 0

			if var_435_15 < arg_432_1.time_ and arg_432_1.time_ <= var_435_15 + arg_435_0 and not isNil(var_435_14) and arg_432_1.var_.actorSpriteComps10093 == nil then
				arg_432_1.var_.actorSpriteComps10093 = var_435_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_16 = 2

			if var_435_15 <= arg_432_1.time_ and arg_432_1.time_ < var_435_15 + var_435_16 and not isNil(var_435_14) then
				local var_435_17 = (arg_432_1.time_ - var_435_15) / var_435_16

				if arg_432_1.var_.actorSpriteComps10093 then
					for iter_435_2, iter_435_3 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_435_3 then
							if arg_432_1.isInRecall_ then
								local var_435_18 = Mathf.Lerp(iter_435_3.color.r, arg_432_1.hightColor1.r, var_435_17)
								local var_435_19 = Mathf.Lerp(iter_435_3.color.g, arg_432_1.hightColor1.g, var_435_17)
								local var_435_20 = Mathf.Lerp(iter_435_3.color.b, arg_432_1.hightColor1.b, var_435_17)

								iter_435_3.color = Color.New(var_435_18, var_435_19, var_435_20)
							else
								local var_435_21 = Mathf.Lerp(iter_435_3.color.r, 1, var_435_17)

								iter_435_3.color = Color.New(var_435_21, var_435_21, var_435_21)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_15 + var_435_16 and arg_432_1.time_ < var_435_15 + var_435_16 + arg_435_0 and not isNil(var_435_14) and arg_432_1.var_.actorSpriteComps10093 then
				for iter_435_4, iter_435_5 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_435_5 then
						if arg_432_1.isInRecall_ then
							iter_435_5.color = arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_435_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps10093 = nil
			end

			local var_435_22 = arg_432_1.actors_["10022"]
			local var_435_23 = 0

			if var_435_23 < arg_432_1.time_ and arg_432_1.time_ <= var_435_23 + arg_435_0 and not isNil(var_435_22) and arg_432_1.var_.actorSpriteComps10022 == nil then
				arg_432_1.var_.actorSpriteComps10022 = var_435_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_24 = 2

			if var_435_23 <= arg_432_1.time_ and arg_432_1.time_ < var_435_23 + var_435_24 and not isNil(var_435_22) then
				local var_435_25 = (arg_432_1.time_ - var_435_23) / var_435_24

				if arg_432_1.var_.actorSpriteComps10022 then
					for iter_435_6, iter_435_7 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_435_7 then
							if arg_432_1.isInRecall_ then
								local var_435_26 = Mathf.Lerp(iter_435_7.color.r, arg_432_1.hightColor2.r, var_435_25)
								local var_435_27 = Mathf.Lerp(iter_435_7.color.g, arg_432_1.hightColor2.g, var_435_25)
								local var_435_28 = Mathf.Lerp(iter_435_7.color.b, arg_432_1.hightColor2.b, var_435_25)

								iter_435_7.color = Color.New(var_435_26, var_435_27, var_435_28)
							else
								local var_435_29 = Mathf.Lerp(iter_435_7.color.r, 0.5, var_435_25)

								iter_435_7.color = Color.New(var_435_29, var_435_29, var_435_29)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= var_435_23 + var_435_24 and arg_432_1.time_ < var_435_23 + var_435_24 + arg_435_0 and not isNil(var_435_22) and arg_432_1.var_.actorSpriteComps10022 then
				for iter_435_8, iter_435_9 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_435_9 then
						if arg_432_1.isInRecall_ then
							iter_435_9.color = arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_435_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_432_1.var_.actorSpriteComps10022 = nil
			end

			local var_435_30 = 0
			local var_435_31 = 0.8

			if var_435_30 < arg_432_1.time_ and arg_432_1.time_ <= var_435_30 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_32 = arg_432_1:FormatText(StoryNameCfg[28].name)

				arg_432_1.leftNameTxt_.text = var_435_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_33 = arg_432_1:GetWordFromCfg(413031103)
				local var_435_34 = arg_432_1:FormatText(var_435_33.content)

				arg_432_1.text_.text = var_435_34

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_35 = 32
				local var_435_36 = utf8.len(var_435_34)
				local var_435_37 = var_435_35 <= 0 and var_435_31 or var_435_31 * (var_435_36 / var_435_35)

				if var_435_37 > 0 and var_435_31 < var_435_37 then
					arg_432_1.talkMaxDuration = var_435_37

					if var_435_37 + var_435_30 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_37 + var_435_30
					end
				end

				arg_432_1.text_.text = var_435_34
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031103", "story_v_out_413031.awb") ~= 0 then
					local var_435_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031103", "story_v_out_413031.awb") / 1000

					if var_435_38 + var_435_30 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_38 + var_435_30
					end

					if var_435_33.prefab_name ~= "" and arg_432_1.actors_[var_435_33.prefab_name] ~= nil then
						local var_435_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_33.prefab_name].transform, "story_v_out_413031", "413031103", "story_v_out_413031.awb")

						arg_432_1:RecordAudio("413031103", var_435_39)
						arg_432_1:RecordAudio("413031103", var_435_39)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_413031", "413031103", "story_v_out_413031.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_413031", "413031103", "story_v_out_413031.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_40 = math.max(var_435_31, arg_432_1.talkMaxDuration)

			if var_435_30 <= arg_432_1.time_ and arg_432_1.time_ < var_435_30 + var_435_40 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_30) / var_435_40

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_30 + var_435_40 and arg_432_1.time_ < var_435_30 + var_435_40 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play413031104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 413031104
		arg_436_1.duration_ = 11.77

		local var_436_0 = {
			zh = 7.4,
			ja = 11.766
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play413031105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10093"].transform
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.var_.moveOldPos10093 = var_439_0.localPosition
				var_439_0.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10093", 2)

				local var_439_2 = var_439_0.childCount

				for iter_439_0 = 0, var_439_2 - 1 do
					local var_439_3 = var_439_0:GetChild(iter_439_0)

					if var_439_3.name == "" or not string.find(var_439_3.name, "split") then
						var_439_3.gameObject:SetActive(true)
					else
						var_439_3.gameObject:SetActive(false)
					end
				end
			end

			local var_439_4 = 0.001

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_4 then
				local var_439_5 = (arg_436_1.time_ - var_439_1) / var_439_4
				local var_439_6 = Vector3.New(-390, -345, -245)

				var_439_0.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10093, var_439_6, var_439_5)
			end

			if arg_436_1.time_ >= var_439_1 + var_439_4 and arg_436_1.time_ < var_439_1 + var_439_4 + arg_439_0 then
				var_439_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_439_7 = arg_436_1.actors_["10022"].transform
			local var_439_8 = 0

			if var_439_8 < arg_436_1.time_ and arg_436_1.time_ <= var_439_8 + arg_439_0 then
				arg_436_1.var_.moveOldPos10022 = var_439_7.localPosition
				var_439_7.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10022", 4)

				local var_439_9 = var_439_7.childCount

				for iter_439_1 = 0, var_439_9 - 1 do
					local var_439_10 = var_439_7:GetChild(iter_439_1)

					if var_439_10.name == "split_8" or not string.find(var_439_10.name, "split") then
						var_439_10.gameObject:SetActive(true)
					else
						var_439_10.gameObject:SetActive(false)
					end
				end
			end

			local var_439_11 = 0.001

			if var_439_8 <= arg_436_1.time_ and arg_436_1.time_ < var_439_8 + var_439_11 then
				local var_439_12 = (arg_436_1.time_ - var_439_8) / var_439_11
				local var_439_13 = Vector3.New(390, -315, -320)

				var_439_7.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10022, var_439_13, var_439_12)
			end

			if arg_436_1.time_ >= var_439_8 + var_439_11 and arg_436_1.time_ < var_439_8 + var_439_11 + arg_439_0 then
				var_439_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_439_14 = arg_436_1.actors_["10093"]
			local var_439_15 = 0

			if var_439_15 < arg_436_1.time_ and arg_436_1.time_ <= var_439_15 + arg_439_0 and not isNil(var_439_14) and arg_436_1.var_.actorSpriteComps10093 == nil then
				arg_436_1.var_.actorSpriteComps10093 = var_439_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_16 = 2

			if var_439_15 <= arg_436_1.time_ and arg_436_1.time_ < var_439_15 + var_439_16 and not isNil(var_439_14) then
				local var_439_17 = (arg_436_1.time_ - var_439_15) / var_439_16

				if arg_436_1.var_.actorSpriteComps10093 then
					for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_439_3 then
							if arg_436_1.isInRecall_ then
								local var_439_18 = Mathf.Lerp(iter_439_3.color.r, arg_436_1.hightColor2.r, var_439_17)
								local var_439_19 = Mathf.Lerp(iter_439_3.color.g, arg_436_1.hightColor2.g, var_439_17)
								local var_439_20 = Mathf.Lerp(iter_439_3.color.b, arg_436_1.hightColor2.b, var_439_17)

								iter_439_3.color = Color.New(var_439_18, var_439_19, var_439_20)
							else
								local var_439_21 = Mathf.Lerp(iter_439_3.color.r, 0.5, var_439_17)

								iter_439_3.color = Color.New(var_439_21, var_439_21, var_439_21)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_15 + var_439_16 and arg_436_1.time_ < var_439_15 + var_439_16 + arg_439_0 and not isNil(var_439_14) and arg_436_1.var_.actorSpriteComps10093 then
				for iter_439_4, iter_439_5 in pairs(arg_436_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_439_5 then
						if arg_436_1.isInRecall_ then
							iter_439_5.color = arg_436_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_439_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps10093 = nil
			end

			local var_439_22 = arg_436_1.actors_["10022"]
			local var_439_23 = 0

			if var_439_23 < arg_436_1.time_ and arg_436_1.time_ <= var_439_23 + arg_439_0 and not isNil(var_439_22) and arg_436_1.var_.actorSpriteComps10022 == nil then
				arg_436_1.var_.actorSpriteComps10022 = var_439_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_24 = 2

			if var_439_23 <= arg_436_1.time_ and arg_436_1.time_ < var_439_23 + var_439_24 and not isNil(var_439_22) then
				local var_439_25 = (arg_436_1.time_ - var_439_23) / var_439_24

				if arg_436_1.var_.actorSpriteComps10022 then
					for iter_439_6, iter_439_7 in pairs(arg_436_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_439_7 then
							if arg_436_1.isInRecall_ then
								local var_439_26 = Mathf.Lerp(iter_439_7.color.r, arg_436_1.hightColor1.r, var_439_25)
								local var_439_27 = Mathf.Lerp(iter_439_7.color.g, arg_436_1.hightColor1.g, var_439_25)
								local var_439_28 = Mathf.Lerp(iter_439_7.color.b, arg_436_1.hightColor1.b, var_439_25)

								iter_439_7.color = Color.New(var_439_26, var_439_27, var_439_28)
							else
								local var_439_29 = Mathf.Lerp(iter_439_7.color.r, 1, var_439_25)

								iter_439_7.color = Color.New(var_439_29, var_439_29, var_439_29)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_23 + var_439_24 and arg_436_1.time_ < var_439_23 + var_439_24 + arg_439_0 and not isNil(var_439_22) and arg_436_1.var_.actorSpriteComps10022 then
				for iter_439_8, iter_439_9 in pairs(arg_436_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_439_9 then
						if arg_436_1.isInRecall_ then
							iter_439_9.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_439_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps10022 = nil
			end

			local var_439_30 = 0
			local var_439_31 = 0.875

			if var_439_30 < arg_436_1.time_ and arg_436_1.time_ <= var_439_30 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_32 = arg_436_1:FormatText(StoryNameCfg[614].name)

				arg_436_1.leftNameTxt_.text = var_439_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_33 = arg_436_1:GetWordFromCfg(413031104)
				local var_439_34 = arg_436_1:FormatText(var_439_33.content)

				arg_436_1.text_.text = var_439_34

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_35 = 35
				local var_439_36 = utf8.len(var_439_34)
				local var_439_37 = var_439_35 <= 0 and var_439_31 or var_439_31 * (var_439_36 / var_439_35)

				if var_439_37 > 0 and var_439_31 < var_439_37 then
					arg_436_1.talkMaxDuration = var_439_37

					if var_439_37 + var_439_30 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_37 + var_439_30
					end
				end

				arg_436_1.text_.text = var_439_34
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031104", "story_v_out_413031.awb") ~= 0 then
					local var_439_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031104", "story_v_out_413031.awb") / 1000

					if var_439_38 + var_439_30 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_38 + var_439_30
					end

					if var_439_33.prefab_name ~= "" and arg_436_1.actors_[var_439_33.prefab_name] ~= nil then
						local var_439_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_33.prefab_name].transform, "story_v_out_413031", "413031104", "story_v_out_413031.awb")

						arg_436_1:RecordAudio("413031104", var_439_39)
						arg_436_1:RecordAudio("413031104", var_439_39)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_413031", "413031104", "story_v_out_413031.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_413031", "413031104", "story_v_out_413031.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_40 = math.max(var_439_31, arg_436_1.talkMaxDuration)

			if var_439_30 <= arg_436_1.time_ and arg_436_1.time_ < var_439_30 + var_439_40 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_30) / var_439_40

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_30 + var_439_40 and arg_436_1.time_ < var_439_30 + var_439_40 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play413031105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 413031105
		arg_440_1.duration_ = 8.1

		local var_440_0 = {
			zh = 5.433,
			ja = 8.1
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play413031106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10093"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos10093 = var_443_0.localPosition
				var_443_0.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10093", 2)

				local var_443_2 = var_443_0.childCount

				for iter_443_0 = 0, var_443_2 - 1 do
					local var_443_3 = var_443_0:GetChild(iter_443_0)

					if var_443_3.name == "split_6" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_4 then
				local var_443_5 = (arg_440_1.time_ - var_443_1) / var_443_4
				local var_443_6 = Vector3.New(-390, -345, -245)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10093, var_443_6, var_443_5)
			end

			if arg_440_1.time_ >= var_443_1 + var_443_4 and arg_440_1.time_ < var_443_1 + var_443_4 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_443_7 = arg_440_1.actors_["10022"].transform
			local var_443_8 = 0

			if var_443_8 < arg_440_1.time_ and arg_440_1.time_ <= var_443_8 + arg_443_0 then
				arg_440_1.var_.moveOldPos10022 = var_443_7.localPosition
				var_443_7.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10022", 4)

				local var_443_9 = var_443_7.childCount

				for iter_443_1 = 0, var_443_9 - 1 do
					local var_443_10 = var_443_7:GetChild(iter_443_1)

					if var_443_10.name == "" or not string.find(var_443_10.name, "split") then
						var_443_10.gameObject:SetActive(true)
					else
						var_443_10.gameObject:SetActive(false)
					end
				end
			end

			local var_443_11 = 0.001

			if var_443_8 <= arg_440_1.time_ and arg_440_1.time_ < var_443_8 + var_443_11 then
				local var_443_12 = (arg_440_1.time_ - var_443_8) / var_443_11
				local var_443_13 = Vector3.New(390, -315, -320)

				var_443_7.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10022, var_443_13, var_443_12)
			end

			if arg_440_1.time_ >= var_443_8 + var_443_11 and arg_440_1.time_ < var_443_8 + var_443_11 + arg_443_0 then
				var_443_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_443_14 = arg_440_1.actors_["10093"]
			local var_443_15 = 0

			if var_443_15 < arg_440_1.time_ and arg_440_1.time_ <= var_443_15 + arg_443_0 and not isNil(var_443_14) and arg_440_1.var_.actorSpriteComps10093 == nil then
				arg_440_1.var_.actorSpriteComps10093 = var_443_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_16 = 2

			if var_443_15 <= arg_440_1.time_ and arg_440_1.time_ < var_443_15 + var_443_16 and not isNil(var_443_14) then
				local var_443_17 = (arg_440_1.time_ - var_443_15) / var_443_16

				if arg_440_1.var_.actorSpriteComps10093 then
					for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_443_3 then
							if arg_440_1.isInRecall_ then
								local var_443_18 = Mathf.Lerp(iter_443_3.color.r, arg_440_1.hightColor1.r, var_443_17)
								local var_443_19 = Mathf.Lerp(iter_443_3.color.g, arg_440_1.hightColor1.g, var_443_17)
								local var_443_20 = Mathf.Lerp(iter_443_3.color.b, arg_440_1.hightColor1.b, var_443_17)

								iter_443_3.color = Color.New(var_443_18, var_443_19, var_443_20)
							else
								local var_443_21 = Mathf.Lerp(iter_443_3.color.r, 1, var_443_17)

								iter_443_3.color = Color.New(var_443_21, var_443_21, var_443_21)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_15 + var_443_16 and arg_440_1.time_ < var_443_15 + var_443_16 + arg_443_0 and not isNil(var_443_14) and arg_440_1.var_.actorSpriteComps10093 then
				for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_443_5 then
						if arg_440_1.isInRecall_ then
							iter_443_5.color = arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_443_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10093 = nil
			end

			local var_443_22 = arg_440_1.actors_["10022"]
			local var_443_23 = 0

			if var_443_23 < arg_440_1.time_ and arg_440_1.time_ <= var_443_23 + arg_443_0 and not isNil(var_443_22) and arg_440_1.var_.actorSpriteComps10022 == nil then
				arg_440_1.var_.actorSpriteComps10022 = var_443_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_24 = 2

			if var_443_23 <= arg_440_1.time_ and arg_440_1.time_ < var_443_23 + var_443_24 and not isNil(var_443_22) then
				local var_443_25 = (arg_440_1.time_ - var_443_23) / var_443_24

				if arg_440_1.var_.actorSpriteComps10022 then
					for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_443_7 then
							if arg_440_1.isInRecall_ then
								local var_443_26 = Mathf.Lerp(iter_443_7.color.r, arg_440_1.hightColor2.r, var_443_25)
								local var_443_27 = Mathf.Lerp(iter_443_7.color.g, arg_440_1.hightColor2.g, var_443_25)
								local var_443_28 = Mathf.Lerp(iter_443_7.color.b, arg_440_1.hightColor2.b, var_443_25)

								iter_443_7.color = Color.New(var_443_26, var_443_27, var_443_28)
							else
								local var_443_29 = Mathf.Lerp(iter_443_7.color.r, 0.5, var_443_25)

								iter_443_7.color = Color.New(var_443_29, var_443_29, var_443_29)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_23 + var_443_24 and arg_440_1.time_ < var_443_23 + var_443_24 + arg_443_0 and not isNil(var_443_22) and arg_440_1.var_.actorSpriteComps10022 then
				for iter_443_8, iter_443_9 in pairs(arg_440_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_443_9 then
						if arg_440_1.isInRecall_ then
							iter_443_9.color = arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_443_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10022 = nil
			end

			local var_443_30 = 0
			local var_443_31 = 0.6

			if var_443_30 < arg_440_1.time_ and arg_440_1.time_ <= var_443_30 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_32 = arg_440_1:FormatText(StoryNameCfg[28].name)

				arg_440_1.leftNameTxt_.text = var_443_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_33 = arg_440_1:GetWordFromCfg(413031105)
				local var_443_34 = arg_440_1:FormatText(var_443_33.content)

				arg_440_1.text_.text = var_443_34

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_35 = 24
				local var_443_36 = utf8.len(var_443_34)
				local var_443_37 = var_443_35 <= 0 and var_443_31 or var_443_31 * (var_443_36 / var_443_35)

				if var_443_37 > 0 and var_443_31 < var_443_37 then
					arg_440_1.talkMaxDuration = var_443_37

					if var_443_37 + var_443_30 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_37 + var_443_30
					end
				end

				arg_440_1.text_.text = var_443_34
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031105", "story_v_out_413031.awb") ~= 0 then
					local var_443_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031105", "story_v_out_413031.awb") / 1000

					if var_443_38 + var_443_30 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_38 + var_443_30
					end

					if var_443_33.prefab_name ~= "" and arg_440_1.actors_[var_443_33.prefab_name] ~= nil then
						local var_443_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_33.prefab_name].transform, "story_v_out_413031", "413031105", "story_v_out_413031.awb")

						arg_440_1:RecordAudio("413031105", var_443_39)
						arg_440_1:RecordAudio("413031105", var_443_39)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_413031", "413031105", "story_v_out_413031.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_413031", "413031105", "story_v_out_413031.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_40 = math.max(var_443_31, arg_440_1.talkMaxDuration)

			if var_443_30 <= arg_440_1.time_ and arg_440_1.time_ < var_443_30 + var_443_40 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_30) / var_443_40

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_30 + var_443_40 and arg_440_1.time_ < var_443_30 + var_443_40 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play413031106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 413031106
		arg_444_1.duration_ = 11.67

		local var_444_0 = {
			zh = 8.733,
			ja = 11.666
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play413031107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10093"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos10093 = var_447_0.localPosition
				var_447_0.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10093", 2)

				local var_447_2 = var_447_0.childCount

				for iter_447_0 = 0, var_447_2 - 1 do
					local var_447_3 = var_447_0:GetChild(iter_447_0)

					if var_447_3.name == "" or not string.find(var_447_3.name, "split") then
						var_447_3.gameObject:SetActive(true)
					else
						var_447_3.gameObject:SetActive(false)
					end
				end
			end

			local var_447_4 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_4 then
				local var_447_5 = (arg_444_1.time_ - var_447_1) / var_447_4
				local var_447_6 = Vector3.New(-390, -345, -245)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10093, var_447_6, var_447_5)
			end

			if arg_444_1.time_ >= var_447_1 + var_447_4 and arg_444_1.time_ < var_447_1 + var_447_4 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_447_7 = arg_444_1.actors_["10022"].transform
			local var_447_8 = 0

			if var_447_8 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.var_.moveOldPos10022 = var_447_7.localPosition
				var_447_7.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10022", 4)

				local var_447_9 = var_447_7.childCount

				for iter_447_1 = 0, var_447_9 - 1 do
					local var_447_10 = var_447_7:GetChild(iter_447_1)

					if var_447_10.name == "split_3" or not string.find(var_447_10.name, "split") then
						var_447_10.gameObject:SetActive(true)
					else
						var_447_10.gameObject:SetActive(false)
					end
				end
			end

			local var_447_11 = 0.001

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_11 then
				local var_447_12 = (arg_444_1.time_ - var_447_8) / var_447_11
				local var_447_13 = Vector3.New(390, -315, -320)

				var_447_7.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10022, var_447_13, var_447_12)
			end

			if arg_444_1.time_ >= var_447_8 + var_447_11 and arg_444_1.time_ < var_447_8 + var_447_11 + arg_447_0 then
				var_447_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_447_14 = arg_444_1.actors_["10093"]
			local var_447_15 = 0

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 and not isNil(var_447_14) and arg_444_1.var_.actorSpriteComps10093 == nil then
				arg_444_1.var_.actorSpriteComps10093 = var_447_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_16 = 2

			if var_447_15 <= arg_444_1.time_ and arg_444_1.time_ < var_447_15 + var_447_16 and not isNil(var_447_14) then
				local var_447_17 = (arg_444_1.time_ - var_447_15) / var_447_16

				if arg_444_1.var_.actorSpriteComps10093 then
					for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_447_3 then
							if arg_444_1.isInRecall_ then
								local var_447_18 = Mathf.Lerp(iter_447_3.color.r, arg_444_1.hightColor2.r, var_447_17)
								local var_447_19 = Mathf.Lerp(iter_447_3.color.g, arg_444_1.hightColor2.g, var_447_17)
								local var_447_20 = Mathf.Lerp(iter_447_3.color.b, arg_444_1.hightColor2.b, var_447_17)

								iter_447_3.color = Color.New(var_447_18, var_447_19, var_447_20)
							else
								local var_447_21 = Mathf.Lerp(iter_447_3.color.r, 0.5, var_447_17)

								iter_447_3.color = Color.New(var_447_21, var_447_21, var_447_21)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_15 + var_447_16 and arg_444_1.time_ < var_447_15 + var_447_16 + arg_447_0 and not isNil(var_447_14) and arg_444_1.var_.actorSpriteComps10093 then
				for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_447_5 then
						if arg_444_1.isInRecall_ then
							iter_447_5.color = arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_447_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10093 = nil
			end

			local var_447_22 = arg_444_1.actors_["10022"]
			local var_447_23 = 0

			if var_447_23 < arg_444_1.time_ and arg_444_1.time_ <= var_447_23 + arg_447_0 and not isNil(var_447_22) and arg_444_1.var_.actorSpriteComps10022 == nil then
				arg_444_1.var_.actorSpriteComps10022 = var_447_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_24 = 2

			if var_447_23 <= arg_444_1.time_ and arg_444_1.time_ < var_447_23 + var_447_24 and not isNil(var_447_22) then
				local var_447_25 = (arg_444_1.time_ - var_447_23) / var_447_24

				if arg_444_1.var_.actorSpriteComps10022 then
					for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_447_7 then
							if arg_444_1.isInRecall_ then
								local var_447_26 = Mathf.Lerp(iter_447_7.color.r, arg_444_1.hightColor1.r, var_447_25)
								local var_447_27 = Mathf.Lerp(iter_447_7.color.g, arg_444_1.hightColor1.g, var_447_25)
								local var_447_28 = Mathf.Lerp(iter_447_7.color.b, arg_444_1.hightColor1.b, var_447_25)

								iter_447_7.color = Color.New(var_447_26, var_447_27, var_447_28)
							else
								local var_447_29 = Mathf.Lerp(iter_447_7.color.r, 1, var_447_25)

								iter_447_7.color = Color.New(var_447_29, var_447_29, var_447_29)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_23 + var_447_24 and arg_444_1.time_ < var_447_23 + var_447_24 + arg_447_0 and not isNil(var_447_22) and arg_444_1.var_.actorSpriteComps10022 then
				for iter_447_8, iter_447_9 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_447_9 then
						if arg_444_1.isInRecall_ then
							iter_447_9.color = arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_447_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10022 = nil
			end

			local var_447_30 = 0
			local var_447_31 = 0.975

			if var_447_30 < arg_444_1.time_ and arg_444_1.time_ <= var_447_30 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_32 = arg_444_1:FormatText(StoryNameCfg[614].name)

				arg_444_1.leftNameTxt_.text = var_447_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_33 = arg_444_1:GetWordFromCfg(413031106)
				local var_447_34 = arg_444_1:FormatText(var_447_33.content)

				arg_444_1.text_.text = var_447_34

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_35 = 39
				local var_447_36 = utf8.len(var_447_34)
				local var_447_37 = var_447_35 <= 0 and var_447_31 or var_447_31 * (var_447_36 / var_447_35)

				if var_447_37 > 0 and var_447_31 < var_447_37 then
					arg_444_1.talkMaxDuration = var_447_37

					if var_447_37 + var_447_30 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_37 + var_447_30
					end
				end

				arg_444_1.text_.text = var_447_34
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031106", "story_v_out_413031.awb") ~= 0 then
					local var_447_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031106", "story_v_out_413031.awb") / 1000

					if var_447_38 + var_447_30 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_38 + var_447_30
					end

					if var_447_33.prefab_name ~= "" and arg_444_1.actors_[var_447_33.prefab_name] ~= nil then
						local var_447_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_33.prefab_name].transform, "story_v_out_413031", "413031106", "story_v_out_413031.awb")

						arg_444_1:RecordAudio("413031106", var_447_39)
						arg_444_1:RecordAudio("413031106", var_447_39)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_413031", "413031106", "story_v_out_413031.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_413031", "413031106", "story_v_out_413031.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_40 = math.max(var_447_31, arg_444_1.talkMaxDuration)

			if var_447_30 <= arg_444_1.time_ and arg_444_1.time_ < var_447_30 + var_447_40 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_30) / var_447_40

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_30 + var_447_40 and arg_444_1.time_ < var_447_30 + var_447_40 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play413031107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 413031107
		arg_448_1.duration_ = 5.4

		local var_448_0 = {
			zh = 4.733,
			ja = 5.4
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play413031108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10093"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10093 == nil then
				arg_448_1.var_.actorSpriteComps10093 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps10093 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								local var_451_4 = Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, var_451_3)
								local var_451_5 = Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, var_451_3)
								local var_451_6 = Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, var_451_3)

								iter_451_1.color = Color.New(var_451_4, var_451_5, var_451_6)
							else
								local var_451_7 = Mathf.Lerp(iter_451_1.color.r, 1, var_451_3)

								iter_451_1.color = Color.New(var_451_7, var_451_7, var_451_7)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10093 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_451_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps10093 = nil
			end

			local var_451_8 = arg_448_1.actors_["10022"]
			local var_451_9 = 0

			if var_451_9 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps10022 == nil then
				arg_448_1.var_.actorSpriteComps10022 = var_451_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_10 = 2

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_10 and not isNil(var_451_8) then
				local var_451_11 = (arg_448_1.time_ - var_451_9) / var_451_10

				if arg_448_1.var_.actorSpriteComps10022 then
					for iter_451_4, iter_451_5 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_451_5 then
							if arg_448_1.isInRecall_ then
								local var_451_12 = Mathf.Lerp(iter_451_5.color.r, arg_448_1.hightColor2.r, var_451_11)
								local var_451_13 = Mathf.Lerp(iter_451_5.color.g, arg_448_1.hightColor2.g, var_451_11)
								local var_451_14 = Mathf.Lerp(iter_451_5.color.b, arg_448_1.hightColor2.b, var_451_11)

								iter_451_5.color = Color.New(var_451_12, var_451_13, var_451_14)
							else
								local var_451_15 = Mathf.Lerp(iter_451_5.color.r, 0.5, var_451_11)

								iter_451_5.color = Color.New(var_451_15, var_451_15, var_451_15)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= var_451_9 + var_451_10 and arg_448_1.time_ < var_451_9 + var_451_10 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps10022 then
				for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_451_7 then
						if arg_448_1.isInRecall_ then
							iter_451_7.color = arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_451_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps10022 = nil
			end

			local var_451_16 = 0
			local var_451_17 = 0.6

			if var_451_16 < arg_448_1.time_ and arg_448_1.time_ <= var_451_16 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_18 = arg_448_1:FormatText(StoryNameCfg[28].name)

				arg_448_1.leftNameTxt_.text = var_451_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_19 = arg_448_1:GetWordFromCfg(413031107)
				local var_451_20 = arg_448_1:FormatText(var_451_19.content)

				arg_448_1.text_.text = var_451_20

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_21 = 24
				local var_451_22 = utf8.len(var_451_20)
				local var_451_23 = var_451_21 <= 0 and var_451_17 or var_451_17 * (var_451_22 / var_451_21)

				if var_451_23 > 0 and var_451_17 < var_451_23 then
					arg_448_1.talkMaxDuration = var_451_23

					if var_451_23 + var_451_16 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_23 + var_451_16
					end
				end

				arg_448_1.text_.text = var_451_20
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031107", "story_v_out_413031.awb") ~= 0 then
					local var_451_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031107", "story_v_out_413031.awb") / 1000

					if var_451_24 + var_451_16 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_24 + var_451_16
					end

					if var_451_19.prefab_name ~= "" and arg_448_1.actors_[var_451_19.prefab_name] ~= nil then
						local var_451_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_19.prefab_name].transform, "story_v_out_413031", "413031107", "story_v_out_413031.awb")

						arg_448_1:RecordAudio("413031107", var_451_25)
						arg_448_1:RecordAudio("413031107", var_451_25)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_413031", "413031107", "story_v_out_413031.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_413031", "413031107", "story_v_out_413031.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_26 = math.max(var_451_17, arg_448_1.talkMaxDuration)

			if var_451_16 <= arg_448_1.time_ and arg_448_1.time_ < var_451_16 + var_451_26 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_16) / var_451_26

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_16 + var_451_26 and arg_448_1.time_ < var_451_16 + var_451_26 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play413031108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 413031108
		arg_452_1.duration_ = 10.23

		local var_452_0 = {
			zh = 7.5,
			ja = 10.233
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play413031109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.95

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[28].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_3 = arg_452_1:GetWordFromCfg(413031108)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 38
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031108", "story_v_out_413031.awb") ~= 0 then
					local var_455_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031108", "story_v_out_413031.awb") / 1000

					if var_455_8 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_0
					end

					if var_455_3.prefab_name ~= "" and arg_452_1.actors_[var_455_3.prefab_name] ~= nil then
						local var_455_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_3.prefab_name].transform, "story_v_out_413031", "413031108", "story_v_out_413031.awb")

						arg_452_1:RecordAudio("413031108", var_455_9)
						arg_452_1:RecordAudio("413031108", var_455_9)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_413031", "413031108", "story_v_out_413031.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_413031", "413031108", "story_v_out_413031.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_10 and arg_452_1.time_ < var_455_0 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play413031109 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 413031109
		arg_456_1.duration_ = 10.4

		local var_456_0 = {
			zh = 6.666,
			ja = 10.4
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play413031110(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.825

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[28].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(413031109)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 33
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031109", "story_v_out_413031.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031109", "story_v_out_413031.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_out_413031", "413031109", "story_v_out_413031.awb")

						arg_456_1:RecordAudio("413031109", var_459_9)
						arg_456_1:RecordAudio("413031109", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_413031", "413031109", "story_v_out_413031.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_413031", "413031109", "story_v_out_413031.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_10 and arg_456_1.time_ < var_459_0 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play413031110 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 413031110
		arg_460_1.duration_ = 8.83

		local var_460_0 = {
			zh = 4.6,
			ja = 8.833
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play413031111(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.75

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[28].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:GetWordFromCfg(413031110)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 30
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031110", "story_v_out_413031.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031110", "story_v_out_413031.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_413031", "413031110", "story_v_out_413031.awb")

						arg_460_1:RecordAudio("413031110", var_463_9)
						arg_460_1:RecordAudio("413031110", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_413031", "413031110", "story_v_out_413031.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_413031", "413031110", "story_v_out_413031.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play413031111 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 413031111
		arg_464_1.duration_ = 4.3

		local var_464_0 = {
			zh = 2.166,
			ja = 4.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play413031112(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["10093"].transform
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.var_.moveOldPos10093 = var_467_0.localPosition
				var_467_0.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10093", 2)

				local var_467_2 = var_467_0.childCount

				for iter_467_0 = 0, var_467_2 - 1 do
					local var_467_3 = var_467_0:GetChild(iter_467_0)

					if var_467_3.name == "" or not string.find(var_467_3.name, "split") then
						var_467_3.gameObject:SetActive(true)
					else
						var_467_3.gameObject:SetActive(false)
					end
				end
			end

			local var_467_4 = 0.001

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_4 then
				local var_467_5 = (arg_464_1.time_ - var_467_1) / var_467_4
				local var_467_6 = Vector3.New(-390, -345, -245)

				var_467_0.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10093, var_467_6, var_467_5)
			end

			if arg_464_1.time_ >= var_467_1 + var_467_4 and arg_464_1.time_ < var_467_1 + var_467_4 + arg_467_0 then
				var_467_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_467_7 = arg_464_1.actors_["10022"].transform
			local var_467_8 = 0

			if var_467_8 < arg_464_1.time_ and arg_464_1.time_ <= var_467_8 + arg_467_0 then
				arg_464_1.var_.moveOldPos10022 = var_467_7.localPosition
				var_467_7.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10022", 4)

				local var_467_9 = var_467_7.childCount

				for iter_467_1 = 0, var_467_9 - 1 do
					local var_467_10 = var_467_7:GetChild(iter_467_1)

					if var_467_10.name == "split_3" or not string.find(var_467_10.name, "split") then
						var_467_10.gameObject:SetActive(true)
					else
						var_467_10.gameObject:SetActive(false)
					end
				end
			end

			local var_467_11 = 0.001

			if var_467_8 <= arg_464_1.time_ and arg_464_1.time_ < var_467_8 + var_467_11 then
				local var_467_12 = (arg_464_1.time_ - var_467_8) / var_467_11
				local var_467_13 = Vector3.New(390, -315, -320)

				var_467_7.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10022, var_467_13, var_467_12)
			end

			if arg_464_1.time_ >= var_467_8 + var_467_11 and arg_464_1.time_ < var_467_8 + var_467_11 + arg_467_0 then
				var_467_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_467_14 = arg_464_1.actors_["10093"]
			local var_467_15 = 0

			if var_467_15 < arg_464_1.time_ and arg_464_1.time_ <= var_467_15 + arg_467_0 and not isNil(var_467_14) and arg_464_1.var_.actorSpriteComps10093 == nil then
				arg_464_1.var_.actorSpriteComps10093 = var_467_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_16 = 2

			if var_467_15 <= arg_464_1.time_ and arg_464_1.time_ < var_467_15 + var_467_16 and not isNil(var_467_14) then
				local var_467_17 = (arg_464_1.time_ - var_467_15) / var_467_16

				if arg_464_1.var_.actorSpriteComps10093 then
					for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_467_3 then
							if arg_464_1.isInRecall_ then
								local var_467_18 = Mathf.Lerp(iter_467_3.color.r, arg_464_1.hightColor2.r, var_467_17)
								local var_467_19 = Mathf.Lerp(iter_467_3.color.g, arg_464_1.hightColor2.g, var_467_17)
								local var_467_20 = Mathf.Lerp(iter_467_3.color.b, arg_464_1.hightColor2.b, var_467_17)

								iter_467_3.color = Color.New(var_467_18, var_467_19, var_467_20)
							else
								local var_467_21 = Mathf.Lerp(iter_467_3.color.r, 0.5, var_467_17)

								iter_467_3.color = Color.New(var_467_21, var_467_21, var_467_21)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_15 + var_467_16 and arg_464_1.time_ < var_467_15 + var_467_16 + arg_467_0 and not isNil(var_467_14) and arg_464_1.var_.actorSpriteComps10093 then
				for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_467_5 then
						if arg_464_1.isInRecall_ then
							iter_467_5.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10093 = nil
			end

			local var_467_22 = arg_464_1.actors_["10022"]
			local var_467_23 = 0

			if var_467_23 < arg_464_1.time_ and arg_464_1.time_ <= var_467_23 + arg_467_0 and not isNil(var_467_22) and arg_464_1.var_.actorSpriteComps10022 == nil then
				arg_464_1.var_.actorSpriteComps10022 = var_467_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_24 = 2

			if var_467_23 <= arg_464_1.time_ and arg_464_1.time_ < var_467_23 + var_467_24 and not isNil(var_467_22) then
				local var_467_25 = (arg_464_1.time_ - var_467_23) / var_467_24

				if arg_464_1.var_.actorSpriteComps10022 then
					for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_467_7 then
							if arg_464_1.isInRecall_ then
								local var_467_26 = Mathf.Lerp(iter_467_7.color.r, arg_464_1.hightColor1.r, var_467_25)
								local var_467_27 = Mathf.Lerp(iter_467_7.color.g, arg_464_1.hightColor1.g, var_467_25)
								local var_467_28 = Mathf.Lerp(iter_467_7.color.b, arg_464_1.hightColor1.b, var_467_25)

								iter_467_7.color = Color.New(var_467_26, var_467_27, var_467_28)
							else
								local var_467_29 = Mathf.Lerp(iter_467_7.color.r, 1, var_467_25)

								iter_467_7.color = Color.New(var_467_29, var_467_29, var_467_29)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_23 + var_467_24 and arg_464_1.time_ < var_467_23 + var_467_24 + arg_467_0 and not isNil(var_467_22) and arg_464_1.var_.actorSpriteComps10022 then
				for iter_467_8, iter_467_9 in pairs(arg_464_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_467_9 then
						if arg_464_1.isInRecall_ then
							iter_467_9.color = arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_467_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10022 = nil
			end

			local var_467_30 = 0
			local var_467_31 = 0.375

			if var_467_30 < arg_464_1.time_ and arg_464_1.time_ <= var_467_30 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_32 = arg_464_1:FormatText(StoryNameCfg[614].name)

				arg_464_1.leftNameTxt_.text = var_467_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_33 = arg_464_1:GetWordFromCfg(413031111)
				local var_467_34 = arg_464_1:FormatText(var_467_33.content)

				arg_464_1.text_.text = var_467_34

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_35 = 15
				local var_467_36 = utf8.len(var_467_34)
				local var_467_37 = var_467_35 <= 0 and var_467_31 or var_467_31 * (var_467_36 / var_467_35)

				if var_467_37 > 0 and var_467_31 < var_467_37 then
					arg_464_1.talkMaxDuration = var_467_37

					if var_467_37 + var_467_30 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_37 + var_467_30
					end
				end

				arg_464_1.text_.text = var_467_34
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031111", "story_v_out_413031.awb") ~= 0 then
					local var_467_38 = manager.audio:GetVoiceLength("story_v_out_413031", "413031111", "story_v_out_413031.awb") / 1000

					if var_467_38 + var_467_30 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_38 + var_467_30
					end

					if var_467_33.prefab_name ~= "" and arg_464_1.actors_[var_467_33.prefab_name] ~= nil then
						local var_467_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_33.prefab_name].transform, "story_v_out_413031", "413031111", "story_v_out_413031.awb")

						arg_464_1:RecordAudio("413031111", var_467_39)
						arg_464_1:RecordAudio("413031111", var_467_39)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_413031", "413031111", "story_v_out_413031.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_413031", "413031111", "story_v_out_413031.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_40 = math.max(var_467_31, arg_464_1.talkMaxDuration)

			if var_467_30 <= arg_464_1.time_ and arg_464_1.time_ < var_467_30 + var_467_40 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_30) / var_467_40

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_30 + var_467_40 and arg_464_1.time_ < var_467_30 + var_467_40 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play413031112 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 413031112
		arg_468_1.duration_ = 9

		local var_468_0 = {
			zh = 4.366,
			ja = 9
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play413031113(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["10093"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps10093 == nil then
				arg_468_1.var_.actorSpriteComps10093 = var_471_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_2 = 2

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.actorSpriteComps10093 then
					for iter_471_0, iter_471_1 in pairs(arg_468_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_471_1 then
							if arg_468_1.isInRecall_ then
								local var_471_4 = Mathf.Lerp(iter_471_1.color.r, arg_468_1.hightColor1.r, var_471_3)
								local var_471_5 = Mathf.Lerp(iter_471_1.color.g, arg_468_1.hightColor1.g, var_471_3)
								local var_471_6 = Mathf.Lerp(iter_471_1.color.b, arg_468_1.hightColor1.b, var_471_3)

								iter_471_1.color = Color.New(var_471_4, var_471_5, var_471_6)
							else
								local var_471_7 = Mathf.Lerp(iter_471_1.color.r, 1, var_471_3)

								iter_471_1.color = Color.New(var_471_7, var_471_7, var_471_7)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.actorSpriteComps10093 then
				for iter_471_2, iter_471_3 in pairs(arg_468_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_471_3 then
						if arg_468_1.isInRecall_ then
							iter_471_3.color = arg_468_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_471_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_468_1.var_.actorSpriteComps10093 = nil
			end

			local var_471_8 = arg_468_1.actors_["10022"]
			local var_471_9 = 0

			if var_471_9 < arg_468_1.time_ and arg_468_1.time_ <= var_471_9 + arg_471_0 and not isNil(var_471_8) and arg_468_1.var_.actorSpriteComps10022 == nil then
				arg_468_1.var_.actorSpriteComps10022 = var_471_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_10 = 2

			if var_471_9 <= arg_468_1.time_ and arg_468_1.time_ < var_471_9 + var_471_10 and not isNil(var_471_8) then
				local var_471_11 = (arg_468_1.time_ - var_471_9) / var_471_10

				if arg_468_1.var_.actorSpriteComps10022 then
					for iter_471_4, iter_471_5 in pairs(arg_468_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_471_5 then
							if arg_468_1.isInRecall_ then
								local var_471_12 = Mathf.Lerp(iter_471_5.color.r, arg_468_1.hightColor2.r, var_471_11)
								local var_471_13 = Mathf.Lerp(iter_471_5.color.g, arg_468_1.hightColor2.g, var_471_11)
								local var_471_14 = Mathf.Lerp(iter_471_5.color.b, arg_468_1.hightColor2.b, var_471_11)

								iter_471_5.color = Color.New(var_471_12, var_471_13, var_471_14)
							else
								local var_471_15 = Mathf.Lerp(iter_471_5.color.r, 0.5, var_471_11)

								iter_471_5.color = Color.New(var_471_15, var_471_15, var_471_15)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= var_471_9 + var_471_10 and arg_468_1.time_ < var_471_9 + var_471_10 + arg_471_0 and not isNil(var_471_8) and arg_468_1.var_.actorSpriteComps10022 then
				for iter_471_6, iter_471_7 in pairs(arg_468_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_471_7 then
						if arg_468_1.isInRecall_ then
							iter_471_7.color = arg_468_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_471_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_468_1.var_.actorSpriteComps10022 = nil
			end

			local var_471_16 = 0
			local var_471_17 = 0.625

			if var_471_16 < arg_468_1.time_ and arg_468_1.time_ <= var_471_16 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_18 = arg_468_1:FormatText(StoryNameCfg[28].name)

				arg_468_1.leftNameTxt_.text = var_471_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_19 = arg_468_1:GetWordFromCfg(413031112)
				local var_471_20 = arg_468_1:FormatText(var_471_19.content)

				arg_468_1.text_.text = var_471_20

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_21 = 25
				local var_471_22 = utf8.len(var_471_20)
				local var_471_23 = var_471_21 <= 0 and var_471_17 or var_471_17 * (var_471_22 / var_471_21)

				if var_471_23 > 0 and var_471_17 < var_471_23 then
					arg_468_1.talkMaxDuration = var_471_23

					if var_471_23 + var_471_16 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_23 + var_471_16
					end
				end

				arg_468_1.text_.text = var_471_20
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031112", "story_v_out_413031.awb") ~= 0 then
					local var_471_24 = manager.audio:GetVoiceLength("story_v_out_413031", "413031112", "story_v_out_413031.awb") / 1000

					if var_471_24 + var_471_16 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_24 + var_471_16
					end

					if var_471_19.prefab_name ~= "" and arg_468_1.actors_[var_471_19.prefab_name] ~= nil then
						local var_471_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_19.prefab_name].transform, "story_v_out_413031", "413031112", "story_v_out_413031.awb")

						arg_468_1:RecordAudio("413031112", var_471_25)
						arg_468_1:RecordAudio("413031112", var_471_25)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_413031", "413031112", "story_v_out_413031.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_413031", "413031112", "story_v_out_413031.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_26 = math.max(var_471_17, arg_468_1.talkMaxDuration)

			if var_471_16 <= arg_468_1.time_ and arg_468_1.time_ < var_471_16 + var_471_26 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_16) / var_471_26

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_16 + var_471_26 and arg_468_1.time_ < var_471_16 + var_471_26 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play413031113 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 413031113
		arg_472_1.duration_ = 6.83

		local var_472_0 = {
			zh = 6.833,
			ja = 5.933
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play413031114(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["10093"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos10093 = var_475_0.localPosition
				var_475_0.localScale = Vector3.New(1, 1, 1)

				arg_472_1:CheckSpriteTmpPos("10093", 2)

				local var_475_2 = var_475_0.childCount

				for iter_475_0 = 0, var_475_2 - 1 do
					local var_475_3 = var_475_0:GetChild(iter_475_0)

					if var_475_3.name == "split_4" or not string.find(var_475_3.name, "split") then
						var_475_3.gameObject:SetActive(true)
					else
						var_475_3.gameObject:SetActive(false)
					end
				end
			end

			local var_475_4 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_4 then
				local var_475_5 = (arg_472_1.time_ - var_475_1) / var_475_4
				local var_475_6 = Vector3.New(-390, -345, -245)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos10093, var_475_6, var_475_5)
			end

			if arg_472_1.time_ >= var_475_1 + var_475_4 and arg_472_1.time_ < var_475_1 + var_475_4 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_475_7 = 0
			local var_475_8 = 0.525

			if var_475_7 < arg_472_1.time_ and arg_472_1.time_ <= var_475_7 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_9 = arg_472_1:FormatText(StoryNameCfg[28].name)

				arg_472_1.leftNameTxt_.text = var_475_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_10 = arg_472_1:GetWordFromCfg(413031113)
				local var_475_11 = arg_472_1:FormatText(var_475_10.content)

				arg_472_1.text_.text = var_475_11

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_12 = 21
				local var_475_13 = utf8.len(var_475_11)
				local var_475_14 = var_475_12 <= 0 and var_475_8 or var_475_8 * (var_475_13 / var_475_12)

				if var_475_14 > 0 and var_475_8 < var_475_14 then
					arg_472_1.talkMaxDuration = var_475_14

					if var_475_14 + var_475_7 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_14 + var_475_7
					end
				end

				arg_472_1.text_.text = var_475_11
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031113", "story_v_out_413031.awb") ~= 0 then
					local var_475_15 = manager.audio:GetVoiceLength("story_v_out_413031", "413031113", "story_v_out_413031.awb") / 1000

					if var_475_15 + var_475_7 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_15 + var_475_7
					end

					if var_475_10.prefab_name ~= "" and arg_472_1.actors_[var_475_10.prefab_name] ~= nil then
						local var_475_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_10.prefab_name].transform, "story_v_out_413031", "413031113", "story_v_out_413031.awb")

						arg_472_1:RecordAudio("413031113", var_475_16)
						arg_472_1:RecordAudio("413031113", var_475_16)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_413031", "413031113", "story_v_out_413031.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_413031", "413031113", "story_v_out_413031.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_17 = math.max(var_475_8, arg_472_1.talkMaxDuration)

			if var_475_7 <= arg_472_1.time_ and arg_472_1.time_ < var_475_7 + var_475_17 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_7) / var_475_17

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_7 + var_475_17 and arg_472_1.time_ < var_475_7 + var_475_17 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
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

		arg_472_1:InitPlayNodeList()
	end,
	Play413031114 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 413031114
		arg_476_1.duration_ = 9.43

		local var_476_0 = {
			zh = 7.166,
			ja = 9.433
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play413031115(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.825

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[28].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:GetWordFromCfg(413031114)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 33
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031114", "story_v_out_413031.awb") ~= 0 then
					local var_479_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031114", "story_v_out_413031.awb") / 1000

					if var_479_8 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_8 + var_479_0
					end

					if var_479_3.prefab_name ~= "" and arg_476_1.actors_[var_479_3.prefab_name] ~= nil then
						local var_479_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_3.prefab_name].transform, "story_v_out_413031", "413031114", "story_v_out_413031.awb")

						arg_476_1:RecordAudio("413031114", var_479_9)
						arg_476_1:RecordAudio("413031114", var_479_9)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_413031", "413031114", "story_v_out_413031.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_413031", "413031114", "story_v_out_413031.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_10 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_10 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_10

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_10 and arg_476_1.time_ < var_479_0 + var_479_10 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play413031115 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 413031115
		arg_480_1.duration_ = 14.23

		local var_480_0 = {
			zh = 10.733,
			ja = 14.233
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play413031116(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["10022"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos10022 = var_483_0.localPosition
				var_483_0.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10022", 4)

				local var_483_2 = var_483_0.childCount

				for iter_483_0 = 0, var_483_2 - 1 do
					local var_483_3 = var_483_0:GetChild(iter_483_0)

					if var_483_3.name == "split_3" or not string.find(var_483_3.name, "split") then
						var_483_3.gameObject:SetActive(true)
					else
						var_483_3.gameObject:SetActive(false)
					end
				end
			end

			local var_483_4 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_4 then
				local var_483_5 = (arg_480_1.time_ - var_483_1) / var_483_4
				local var_483_6 = Vector3.New(390, -315, -320)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10022, var_483_6, var_483_5)
			end

			if arg_480_1.time_ >= var_483_1 + var_483_4 and arg_480_1.time_ < var_483_1 + var_483_4 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_483_7 = arg_480_1.actors_["10093"]
			local var_483_8 = 0

			if var_483_8 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 and not isNil(var_483_7) and arg_480_1.var_.actorSpriteComps10093 == nil then
				arg_480_1.var_.actorSpriteComps10093 = var_483_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_9 = 2

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_9 and not isNil(var_483_7) then
				local var_483_10 = (arg_480_1.time_ - var_483_8) / var_483_9

				if arg_480_1.var_.actorSpriteComps10093 then
					for iter_483_1, iter_483_2 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_483_2 then
							if arg_480_1.isInRecall_ then
								local var_483_11 = Mathf.Lerp(iter_483_2.color.r, arg_480_1.hightColor2.r, var_483_10)
								local var_483_12 = Mathf.Lerp(iter_483_2.color.g, arg_480_1.hightColor2.g, var_483_10)
								local var_483_13 = Mathf.Lerp(iter_483_2.color.b, arg_480_1.hightColor2.b, var_483_10)

								iter_483_2.color = Color.New(var_483_11, var_483_12, var_483_13)
							else
								local var_483_14 = Mathf.Lerp(iter_483_2.color.r, 0.5, var_483_10)

								iter_483_2.color = Color.New(var_483_14, var_483_14, var_483_14)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_8 + var_483_9 and arg_480_1.time_ < var_483_8 + var_483_9 + arg_483_0 and not isNil(var_483_7) and arg_480_1.var_.actorSpriteComps10093 then
				for iter_483_3, iter_483_4 in pairs(arg_480_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_483_4 then
						if arg_480_1.isInRecall_ then
							iter_483_4.color = arg_480_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_483_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps10093 = nil
			end

			local var_483_15 = arg_480_1.actors_["10022"]
			local var_483_16 = 0

			if var_483_16 < arg_480_1.time_ and arg_480_1.time_ <= var_483_16 + arg_483_0 and not isNil(var_483_15) and arg_480_1.var_.actorSpriteComps10022 == nil then
				arg_480_1.var_.actorSpriteComps10022 = var_483_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_17 = 2

			if var_483_16 <= arg_480_1.time_ and arg_480_1.time_ < var_483_16 + var_483_17 and not isNil(var_483_15) then
				local var_483_18 = (arg_480_1.time_ - var_483_16) / var_483_17

				if arg_480_1.var_.actorSpriteComps10022 then
					for iter_483_5, iter_483_6 in pairs(arg_480_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_483_6 then
							if arg_480_1.isInRecall_ then
								local var_483_19 = Mathf.Lerp(iter_483_6.color.r, arg_480_1.hightColor1.r, var_483_18)
								local var_483_20 = Mathf.Lerp(iter_483_6.color.g, arg_480_1.hightColor1.g, var_483_18)
								local var_483_21 = Mathf.Lerp(iter_483_6.color.b, arg_480_1.hightColor1.b, var_483_18)

								iter_483_6.color = Color.New(var_483_19, var_483_20, var_483_21)
							else
								local var_483_22 = Mathf.Lerp(iter_483_6.color.r, 1, var_483_18)

								iter_483_6.color = Color.New(var_483_22, var_483_22, var_483_22)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= var_483_16 + var_483_17 and arg_480_1.time_ < var_483_16 + var_483_17 + arg_483_0 and not isNil(var_483_15) and arg_480_1.var_.actorSpriteComps10022 then
				for iter_483_7, iter_483_8 in pairs(arg_480_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_483_8 then
						if arg_480_1.isInRecall_ then
							iter_483_8.color = arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_483_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_480_1.var_.actorSpriteComps10022 = nil
			end

			local var_483_23 = 0
			local var_483_24 = 0.975

			if var_483_23 < arg_480_1.time_ and arg_480_1.time_ <= var_483_23 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_25 = arg_480_1:FormatText(StoryNameCfg[614].name)

				arg_480_1.leftNameTxt_.text = var_483_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_26 = arg_480_1:GetWordFromCfg(413031115)
				local var_483_27 = arg_480_1:FormatText(var_483_26.content)

				arg_480_1.text_.text = var_483_27

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_28 = 39
				local var_483_29 = utf8.len(var_483_27)
				local var_483_30 = var_483_28 <= 0 and var_483_24 or var_483_24 * (var_483_29 / var_483_28)

				if var_483_30 > 0 and var_483_24 < var_483_30 then
					arg_480_1.talkMaxDuration = var_483_30

					if var_483_30 + var_483_23 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_30 + var_483_23
					end
				end

				arg_480_1.text_.text = var_483_27
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031115", "story_v_out_413031.awb") ~= 0 then
					local var_483_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031115", "story_v_out_413031.awb") / 1000

					if var_483_31 + var_483_23 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_31 + var_483_23
					end

					if var_483_26.prefab_name ~= "" and arg_480_1.actors_[var_483_26.prefab_name] ~= nil then
						local var_483_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_26.prefab_name].transform, "story_v_out_413031", "413031115", "story_v_out_413031.awb")

						arg_480_1:RecordAudio("413031115", var_483_32)
						arg_480_1:RecordAudio("413031115", var_483_32)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_413031", "413031115", "story_v_out_413031.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_413031", "413031115", "story_v_out_413031.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_33 = math.max(var_483_24, arg_480_1.talkMaxDuration)

			if var_483_23 <= arg_480_1.time_ and arg_480_1.time_ < var_483_23 + var_483_33 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_23) / var_483_33

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_23 + var_483_33 and arg_480_1.time_ < var_483_23 + var_483_33 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
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

		arg_480_1:InitPlayNodeList()
	end,
	Play413031116 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 413031116
		arg_484_1.duration_ = 13.6

		local var_484_0 = {
			zh = 6.133,
			ja = 13.6
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play413031117(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.85

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[614].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_3 = arg_484_1:GetWordFromCfg(413031116)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 34
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031116", "story_v_out_413031.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031116", "story_v_out_413031.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_413031", "413031116", "story_v_out_413031.awb")

						arg_484_1:RecordAudio("413031116", var_487_9)
						arg_484_1:RecordAudio("413031116", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_413031", "413031116", "story_v_out_413031.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_413031", "413031116", "story_v_out_413031.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play413031117 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 413031117
		arg_488_1.duration_ = 7.73

		local var_488_0 = {
			zh = 4.3,
			ja = 7.733
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play413031118(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.575

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[614].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_3 = arg_488_1:GetWordFromCfg(413031117)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 23
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031117", "story_v_out_413031.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031117", "story_v_out_413031.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_413031", "413031117", "story_v_out_413031.awb")

						arg_488_1:RecordAudio("413031117", var_491_9)
						arg_488_1:RecordAudio("413031117", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_413031", "413031117", "story_v_out_413031.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_413031", "413031117", "story_v_out_413031.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play413031118 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 413031118
		arg_492_1.duration_ = 5.9

		local var_492_0 = {
			zh = 1.999999999999,
			ja = 5.9
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play413031119(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["10093"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos10093 = var_495_0.localPosition
				var_495_0.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10093", 2)

				local var_495_2 = var_495_0.childCount

				for iter_495_0 = 0, var_495_2 - 1 do
					local var_495_3 = var_495_0:GetChild(iter_495_0)

					if var_495_3.name == "split_6" or not string.find(var_495_3.name, "split") then
						var_495_3.gameObject:SetActive(true)
					else
						var_495_3.gameObject:SetActive(false)
					end
				end
			end

			local var_495_4 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_4 then
				local var_495_5 = (arg_492_1.time_ - var_495_1) / var_495_4
				local var_495_6 = Vector3.New(-390, -345, -245)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10093, var_495_6, var_495_5)
			end

			if arg_492_1.time_ >= var_495_1 + var_495_4 and arg_492_1.time_ < var_495_1 + var_495_4 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_495_7 = arg_492_1.actors_["10093"]
			local var_495_8 = 0

			if var_495_8 < arg_492_1.time_ and arg_492_1.time_ <= var_495_8 + arg_495_0 and not isNil(var_495_7) and arg_492_1.var_.actorSpriteComps10093 == nil then
				arg_492_1.var_.actorSpriteComps10093 = var_495_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_9 = 2

			if var_495_8 <= arg_492_1.time_ and arg_492_1.time_ < var_495_8 + var_495_9 and not isNil(var_495_7) then
				local var_495_10 = (arg_492_1.time_ - var_495_8) / var_495_9

				if arg_492_1.var_.actorSpriteComps10093 then
					for iter_495_1, iter_495_2 in pairs(arg_492_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_495_2 then
							if arg_492_1.isInRecall_ then
								local var_495_11 = Mathf.Lerp(iter_495_2.color.r, arg_492_1.hightColor1.r, var_495_10)
								local var_495_12 = Mathf.Lerp(iter_495_2.color.g, arg_492_1.hightColor1.g, var_495_10)
								local var_495_13 = Mathf.Lerp(iter_495_2.color.b, arg_492_1.hightColor1.b, var_495_10)

								iter_495_2.color = Color.New(var_495_11, var_495_12, var_495_13)
							else
								local var_495_14 = Mathf.Lerp(iter_495_2.color.r, 1, var_495_10)

								iter_495_2.color = Color.New(var_495_14, var_495_14, var_495_14)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= var_495_8 + var_495_9 and arg_492_1.time_ < var_495_8 + var_495_9 + arg_495_0 and not isNil(var_495_7) and arg_492_1.var_.actorSpriteComps10093 then
				for iter_495_3, iter_495_4 in pairs(arg_492_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_495_4 then
						if arg_492_1.isInRecall_ then
							iter_495_4.color = arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_495_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_492_1.var_.actorSpriteComps10093 = nil
			end

			local var_495_15 = arg_492_1.actors_["10022"]
			local var_495_16 = 0

			if var_495_16 < arg_492_1.time_ and arg_492_1.time_ <= var_495_16 + arg_495_0 and not isNil(var_495_15) and arg_492_1.var_.actorSpriteComps10022 == nil then
				arg_492_1.var_.actorSpriteComps10022 = var_495_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_17 = 2

			if var_495_16 <= arg_492_1.time_ and arg_492_1.time_ < var_495_16 + var_495_17 and not isNil(var_495_15) then
				local var_495_18 = (arg_492_1.time_ - var_495_16) / var_495_17

				if arg_492_1.var_.actorSpriteComps10022 then
					for iter_495_5, iter_495_6 in pairs(arg_492_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_495_6 then
							if arg_492_1.isInRecall_ then
								local var_495_19 = Mathf.Lerp(iter_495_6.color.r, arg_492_1.hightColor2.r, var_495_18)
								local var_495_20 = Mathf.Lerp(iter_495_6.color.g, arg_492_1.hightColor2.g, var_495_18)
								local var_495_21 = Mathf.Lerp(iter_495_6.color.b, arg_492_1.hightColor2.b, var_495_18)

								iter_495_6.color = Color.New(var_495_19, var_495_20, var_495_21)
							else
								local var_495_22 = Mathf.Lerp(iter_495_6.color.r, 0.5, var_495_18)

								iter_495_6.color = Color.New(var_495_22, var_495_22, var_495_22)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= var_495_16 + var_495_17 and arg_492_1.time_ < var_495_16 + var_495_17 + arg_495_0 and not isNil(var_495_15) and arg_492_1.var_.actorSpriteComps10022 then
				for iter_495_7, iter_495_8 in pairs(arg_492_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_495_8 then
						if arg_492_1.isInRecall_ then
							iter_495_8.color = arg_492_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_495_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_492_1.var_.actorSpriteComps10022 = nil
			end

			local var_495_23 = 0
			local var_495_24 = 0.225

			if var_495_23 < arg_492_1.time_ and arg_492_1.time_ <= var_495_23 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_25 = arg_492_1:FormatText(StoryNameCfg[28].name)

				arg_492_1.leftNameTxt_.text = var_495_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_26 = arg_492_1:GetWordFromCfg(413031118)
				local var_495_27 = arg_492_1:FormatText(var_495_26.content)

				arg_492_1.text_.text = var_495_27

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_28 = 9
				local var_495_29 = utf8.len(var_495_27)
				local var_495_30 = var_495_28 <= 0 and var_495_24 or var_495_24 * (var_495_29 / var_495_28)

				if var_495_30 > 0 and var_495_24 < var_495_30 then
					arg_492_1.talkMaxDuration = var_495_30

					if var_495_30 + var_495_23 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_30 + var_495_23
					end
				end

				arg_492_1.text_.text = var_495_27
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031118", "story_v_out_413031.awb") ~= 0 then
					local var_495_31 = manager.audio:GetVoiceLength("story_v_out_413031", "413031118", "story_v_out_413031.awb") / 1000

					if var_495_31 + var_495_23 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_31 + var_495_23
					end

					if var_495_26.prefab_name ~= "" and arg_492_1.actors_[var_495_26.prefab_name] ~= nil then
						local var_495_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_26.prefab_name].transform, "story_v_out_413031", "413031118", "story_v_out_413031.awb")

						arg_492_1:RecordAudio("413031118", var_495_32)
						arg_492_1:RecordAudio("413031118", var_495_32)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_413031", "413031118", "story_v_out_413031.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_413031", "413031118", "story_v_out_413031.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_33 = math.max(var_495_24, arg_492_1.talkMaxDuration)

			if var_495_23 <= arg_492_1.time_ and arg_492_1.time_ < var_495_23 + var_495_33 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_23) / var_495_33

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_23 + var_495_33 and arg_492_1.time_ < var_495_23 + var_495_33 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
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

		arg_492_1:InitPlayNodeList()
	end,
	Play413031119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 413031119
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play413031120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["10093"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos10093 = var_499_0.localPosition
				var_499_0.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10093", 0)

				local var_499_2 = var_499_0.childCount

				for iter_499_0 = 0, var_499_2 - 1 do
					local var_499_3 = var_499_0:GetChild(iter_499_0)

					if var_499_3.name == "" or not string.find(var_499_3.name, "split") then
						var_499_3.gameObject:SetActive(true)
					else
						var_499_3.gameObject:SetActive(false)
					end
				end
			end

			local var_499_4 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_4 then
				local var_499_5 = (arg_496_1.time_ - var_499_1) / var_499_4
				local var_499_6 = Vector3.New(-5000, -345, -245)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10093, var_499_6, var_499_5)
			end

			if arg_496_1.time_ >= var_499_1 + var_499_4 and arg_496_1.time_ < var_499_1 + var_499_4 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_499_7 = arg_496_1.actors_["10022"].transform
			local var_499_8 = 0

			if var_499_8 < arg_496_1.time_ and arg_496_1.time_ <= var_499_8 + arg_499_0 then
				arg_496_1.var_.moveOldPos10022 = var_499_7.localPosition
				var_499_7.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10022", 0)

				local var_499_9 = var_499_7.childCount

				for iter_499_1 = 0, var_499_9 - 1 do
					local var_499_10 = var_499_7:GetChild(iter_499_1)

					if var_499_10.name == "" or not string.find(var_499_10.name, "split") then
						var_499_10.gameObject:SetActive(true)
					else
						var_499_10.gameObject:SetActive(false)
					end
				end
			end

			local var_499_11 = 0.001

			if var_499_8 <= arg_496_1.time_ and arg_496_1.time_ < var_499_8 + var_499_11 then
				local var_499_12 = (arg_496_1.time_ - var_499_8) / var_499_11
				local var_499_13 = Vector3.New(-5000, -315, -320)

				var_499_7.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10022, var_499_13, var_499_12)
			end

			if arg_496_1.time_ >= var_499_8 + var_499_11 and arg_496_1.time_ < var_499_8 + var_499_11 + arg_499_0 then
				var_499_7.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_499_14 = arg_496_1.actors_["10093"]
			local var_499_15 = 0

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 and not isNil(var_499_14) and arg_496_1.var_.actorSpriteComps10093 == nil then
				arg_496_1.var_.actorSpriteComps10093 = var_499_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_16 = 2

			if var_499_15 <= arg_496_1.time_ and arg_496_1.time_ < var_499_15 + var_499_16 and not isNil(var_499_14) then
				local var_499_17 = (arg_496_1.time_ - var_499_15) / var_499_16

				if arg_496_1.var_.actorSpriteComps10093 then
					for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_499_3 then
							if arg_496_1.isInRecall_ then
								local var_499_18 = Mathf.Lerp(iter_499_3.color.r, arg_496_1.hightColor2.r, var_499_17)
								local var_499_19 = Mathf.Lerp(iter_499_3.color.g, arg_496_1.hightColor2.g, var_499_17)
								local var_499_20 = Mathf.Lerp(iter_499_3.color.b, arg_496_1.hightColor2.b, var_499_17)

								iter_499_3.color = Color.New(var_499_18, var_499_19, var_499_20)
							else
								local var_499_21 = Mathf.Lerp(iter_499_3.color.r, 0.5, var_499_17)

								iter_499_3.color = Color.New(var_499_21, var_499_21, var_499_21)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_15 + var_499_16 and arg_496_1.time_ < var_499_15 + var_499_16 + arg_499_0 and not isNil(var_499_14) and arg_496_1.var_.actorSpriteComps10093 then
				for iter_499_4, iter_499_5 in pairs(arg_496_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_499_5 then
						if arg_496_1.isInRecall_ then
							iter_499_5.color = arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_499_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps10093 = nil
			end

			local var_499_22 = arg_496_1.actors_["10022"]
			local var_499_23 = 0

			if var_499_23 < arg_496_1.time_ and arg_496_1.time_ <= var_499_23 + arg_499_0 and not isNil(var_499_22) and arg_496_1.var_.actorSpriteComps10022 == nil then
				arg_496_1.var_.actorSpriteComps10022 = var_499_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_24 = 2

			if var_499_23 <= arg_496_1.time_ and arg_496_1.time_ < var_499_23 + var_499_24 and not isNil(var_499_22) then
				local var_499_25 = (arg_496_1.time_ - var_499_23) / var_499_24

				if arg_496_1.var_.actorSpriteComps10022 then
					for iter_499_6, iter_499_7 in pairs(arg_496_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_499_7 then
							if arg_496_1.isInRecall_ then
								local var_499_26 = Mathf.Lerp(iter_499_7.color.r, arg_496_1.hightColor2.r, var_499_25)
								local var_499_27 = Mathf.Lerp(iter_499_7.color.g, arg_496_1.hightColor2.g, var_499_25)
								local var_499_28 = Mathf.Lerp(iter_499_7.color.b, arg_496_1.hightColor2.b, var_499_25)

								iter_499_7.color = Color.New(var_499_26, var_499_27, var_499_28)
							else
								local var_499_29 = Mathf.Lerp(iter_499_7.color.r, 0.5, var_499_25)

								iter_499_7.color = Color.New(var_499_29, var_499_29, var_499_29)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_23 + var_499_24 and arg_496_1.time_ < var_499_23 + var_499_24 + arg_499_0 and not isNil(var_499_22) and arg_496_1.var_.actorSpriteComps10022 then
				for iter_499_8, iter_499_9 in pairs(arg_496_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_499_9 then
						if arg_496_1.isInRecall_ then
							iter_499_9.color = arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_499_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps10022 = nil
			end

			local var_499_30 = 0
			local var_499_31 = 1.05

			if var_499_30 < arg_496_1.time_ and arg_496_1.time_ <= var_499_30 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_32 = arg_496_1:GetWordFromCfg(413031119)
				local var_499_33 = arg_496_1:FormatText(var_499_32.content)

				arg_496_1.text_.text = var_499_33

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_34 = 42
				local var_499_35 = utf8.len(var_499_33)
				local var_499_36 = var_499_34 <= 0 and var_499_31 or var_499_31 * (var_499_35 / var_499_34)

				if var_499_36 > 0 and var_499_31 < var_499_36 then
					arg_496_1.talkMaxDuration = var_499_36

					if var_499_36 + var_499_30 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_36 + var_499_30
					end
				end

				arg_496_1.text_.text = var_499_33
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_37 = math.max(var_499_31, arg_496_1.talkMaxDuration)

			if var_499_30 <= arg_496_1.time_ and arg_496_1.time_ < var_499_30 + var_499_37 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_30) / var_499_37

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_30 + var_499_37 and arg_496_1.time_ < var_499_30 + var_499_37 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play413031120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 413031120
		arg_500_1.duration_ = 17.53

		local var_500_0 = {
			zh = 17.5333333333333,
			ja = 14.2333333333333
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play413031121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = "SS1302"

			if arg_500_1.bgs_[var_503_0] == nil then
				local var_503_1 = Object.Instantiate(arg_500_1.paintGo_)

				var_503_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_503_0)
				var_503_1.name = var_503_0
				var_503_1.transform.parent = arg_500_1.stage_.transform
				var_503_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_500_1.bgs_[var_503_0] = var_503_1
			end

			local var_503_2 = 1.98333333333333

			if var_503_2 < arg_500_1.time_ and arg_500_1.time_ <= var_503_2 + arg_503_0 then
				local var_503_3 = manager.ui.mainCamera.transform.localPosition
				local var_503_4 = Vector3.New(0, 0, 10) + Vector3.New(var_503_3.x, var_503_3.y, 0)
				local var_503_5 = arg_500_1.bgs_.SS1302

				var_503_5.transform.localPosition = var_503_4
				var_503_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_503_6 = var_503_5:GetComponent("SpriteRenderer")

				if var_503_6 and var_503_6.sprite then
					local var_503_7 = (var_503_5.transform.localPosition - var_503_3).z
					local var_503_8 = manager.ui.mainCameraCom_
					local var_503_9 = 2 * var_503_7 * Mathf.Tan(var_503_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_503_10 = var_503_9 * var_503_8.aspect
					local var_503_11 = var_503_6.sprite.bounds.size.x
					local var_503_12 = var_503_6.sprite.bounds.size.y
					local var_503_13 = var_503_10 / var_503_11
					local var_503_14 = var_503_9 / var_503_12
					local var_503_15 = var_503_14 < var_503_13 and var_503_13 or var_503_14

					var_503_5.transform.localScale = Vector3.New(var_503_15, var_503_15, 0)
				end

				for iter_503_0, iter_503_1 in pairs(arg_500_1.bgs_) do
					if iter_503_0 ~= "SS1302" then
						iter_503_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_503_16 = 0

			if var_503_16 < arg_500_1.time_ and arg_500_1.time_ <= var_503_16 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_17 = 2

			if var_503_16 <= arg_500_1.time_ and arg_500_1.time_ < var_503_16 + var_503_17 then
				local var_503_18 = (arg_500_1.time_ - var_503_16) / var_503_17
				local var_503_19 = Color.New(0, 0, 0)

				var_503_19.a = Mathf.Lerp(0, 1, var_503_18)
				arg_500_1.mask_.color = var_503_19
			end

			if arg_500_1.time_ >= var_503_16 + var_503_17 and arg_500_1.time_ < var_503_16 + var_503_17 + arg_503_0 then
				local var_503_20 = Color.New(0, 0, 0)

				var_503_20.a = 1
				arg_500_1.mask_.color = var_503_20
			end

			local var_503_21 = 2

			if var_503_21 < arg_500_1.time_ and arg_500_1.time_ <= var_503_21 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_22 = 2

			if var_503_21 <= arg_500_1.time_ and arg_500_1.time_ < var_503_21 + var_503_22 then
				local var_503_23 = (arg_500_1.time_ - var_503_21) / var_503_22
				local var_503_24 = Color.New(0, 0, 0)

				var_503_24.a = Mathf.Lerp(1, 0, var_503_23)
				arg_500_1.mask_.color = var_503_24
			end

			if arg_500_1.time_ >= var_503_21 + var_503_22 and arg_500_1.time_ < var_503_21 + var_503_22 + arg_503_0 then
				local var_503_25 = Color.New(0, 0, 0)
				local var_503_26 = 0

				arg_500_1.mask_.enabled = false
				var_503_25.a = var_503_26
				arg_500_1.mask_.color = var_503_25
			end

			local var_503_27 = arg_500_1.bgs_.SS1302.transform
			local var_503_28 = 2

			if var_503_28 < arg_500_1.time_ and arg_500_1.time_ <= var_503_28 + arg_503_0 then
				arg_500_1.var_.moveOldPosSS1302 = var_503_27.localPosition
			end

			local var_503_29 = 0.001

			if var_503_28 <= arg_500_1.time_ and arg_500_1.time_ < var_503_28 + var_503_29 then
				local var_503_30 = (arg_500_1.time_ - var_503_28) / var_503_29
				local var_503_31 = Vector3.New(0, 1, 10)

				var_503_27.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPosSS1302, var_503_31, var_503_30)
			end

			if arg_500_1.time_ >= var_503_28 + var_503_29 and arg_500_1.time_ < var_503_28 + var_503_29 + arg_503_0 then
				var_503_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_503_32 = arg_500_1.bgs_.SS1302.transform
			local var_503_33 = 2.01666666666667

			if var_503_33 < arg_500_1.time_ and arg_500_1.time_ <= var_503_33 + arg_503_0 then
				arg_500_1.var_.moveOldPosSS1302 = var_503_32.localPosition
			end

			local var_503_34 = 2.15

			if var_503_33 <= arg_500_1.time_ and arg_500_1.time_ < var_503_33 + var_503_34 then
				local var_503_35 = (arg_500_1.time_ - var_503_33) / var_503_34
				local var_503_36 = Vector3.New(0, 0.9, 9.56)

				var_503_32.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPosSS1302, var_503_36, var_503_35)
			end

			if arg_500_1.time_ >= var_503_33 + var_503_34 and arg_500_1.time_ < var_503_33 + var_503_34 + arg_503_0 then
				var_503_32.localPosition = Vector3.New(0, 0.9, 9.56)
			end

			if arg_500_1.frameCnt_ <= 1 then
				arg_500_1.dialog_:SetActive(false)
			end

			local var_503_37 = 3.83333333333333
			local var_503_38 = 0.85

			if var_503_37 < arg_500_1.time_ and arg_500_1.time_ <= var_503_37 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0

				arg_500_1.dialog_:SetActive(true)

				arg_500_1.dialogCg_.alpha = 0

				local var_503_39 = LeanTween.value(arg_500_1.dialog_, 0, 1, 0.3)

				var_503_39:setOnUpdate(LuaHelper.FloatAction(function(arg_504_0)
					arg_500_1.dialogCg_.alpha = arg_504_0
				end))
				var_503_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_500_1.dialog_)
					var_503_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_500_1.duration_ = arg_500_1.duration_ + 0.3

				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_40 = arg_500_1:FormatText(StoryNameCfg[1002].name)

				arg_500_1.leftNameTxt_.text = var_503_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_41 = arg_500_1:GetWordFromCfg(413031120)
				local var_503_42 = arg_500_1:FormatText(var_503_41.content)

				arg_500_1.text_.text = var_503_42

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_43 = 34
				local var_503_44 = utf8.len(var_503_42)
				local var_503_45 = var_503_43 <= 0 and var_503_38 or var_503_38 * (var_503_44 / var_503_43)

				if var_503_45 > 0 and var_503_38 < var_503_45 then
					arg_500_1.talkMaxDuration = var_503_45
					var_503_37 = var_503_37 + 0.3

					if var_503_45 + var_503_37 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_45 + var_503_37
					end
				end

				arg_500_1.text_.text = var_503_42
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031120", "story_v_out_413031.awb") ~= 0 then
					local var_503_46 = manager.audio:GetVoiceLength("story_v_out_413031", "413031120", "story_v_out_413031.awb") / 1000

					if var_503_46 + var_503_37 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_46 + var_503_37
					end

					if var_503_41.prefab_name ~= "" and arg_500_1.actors_[var_503_41.prefab_name] ~= nil then
						local var_503_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_41.prefab_name].transform, "story_v_out_413031", "413031120", "story_v_out_413031.awb")

						arg_500_1:RecordAudio("413031120", var_503_47)
						arg_500_1:RecordAudio("413031120", var_503_47)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_413031", "413031120", "story_v_out_413031.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_413031", "413031120", "story_v_out_413031.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_48 = var_503_37 + 0.3
			local var_503_49 = math.max(var_503_38, arg_500_1.talkMaxDuration)

			if var_503_48 <= arg_500_1.time_ and arg_500_1.time_ < var_503_48 + var_503_49 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_48) / var_503_49

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_48 + var_503_49 and arg_500_1.time_ < var_503_48 + var_503_49 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1302",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.15,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play413031121 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 413031121
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play413031122(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = "10095"

			if arg_506_1.actors_[var_509_0] == nil then
				local var_509_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_509_1) then
					local var_509_2 = Object.Instantiate(var_509_1, arg_506_1.canvasGo_.transform)

					var_509_2.transform:SetSiblingIndex(1)

					var_509_2.name = var_509_0
					var_509_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_506_1.actors_[var_509_0] = var_509_2

					local var_509_3 = var_509_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_506_1.isInRecall_ then
						for iter_509_0, iter_509_1 in ipairs(var_509_3) do
							iter_509_1.color = arg_506_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_509_4 = arg_506_1.actors_["10095"]
			local var_509_5 = 0

			if var_509_5 < arg_506_1.time_ and arg_506_1.time_ <= var_509_5 + arg_509_0 then
				local var_509_6 = var_509_4:GetComponentInChildren(typeof(CanvasGroup))

				if var_509_6 then
					arg_506_1.var_.alphaOldValue10095 = var_509_6.alpha
					arg_506_1.var_.characterEffect10095 = var_509_6
				end

				arg_506_1.var_.alphaOldValue10095 = 1
			end

			local var_509_7 = 0.5

			if var_509_5 <= arg_506_1.time_ and arg_506_1.time_ < var_509_5 + var_509_7 then
				local var_509_8 = (arg_506_1.time_ - var_509_5) / var_509_7
				local var_509_9 = Mathf.Lerp(arg_506_1.var_.alphaOldValue10095, 0, var_509_8)

				if arg_506_1.var_.characterEffect10095 then
					arg_506_1.var_.characterEffect10095.alpha = var_509_9
				end
			end

			if arg_506_1.time_ >= var_509_5 + var_509_7 and arg_506_1.time_ < var_509_5 + var_509_7 + arg_509_0 and arg_506_1.var_.characterEffect10095 then
				arg_506_1.var_.characterEffect10095.alpha = 0
			end

			local var_509_10 = 0
			local var_509_11 = 1.325

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_12 = arg_506_1:GetWordFromCfg(413031121)
				local var_509_13 = arg_506_1:FormatText(var_509_12.content)

				arg_506_1.text_.text = var_509_13

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_14 = 53
				local var_509_15 = utf8.len(var_509_13)
				local var_509_16 = var_509_14 <= 0 and var_509_11 or var_509_11 * (var_509_15 / var_509_14)

				if var_509_16 > 0 and var_509_11 < var_509_16 then
					arg_506_1.talkMaxDuration = var_509_16

					if var_509_16 + var_509_10 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_16 + var_509_10
					end
				end

				arg_506_1.text_.text = var_509_13
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_17 = math.max(var_509_11, arg_506_1.talkMaxDuration)

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_17 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_10) / var_509_17

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_10 + var_509_17 and arg_506_1.time_ < var_509_10 + var_509_17 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play413031122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 413031122
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play413031123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 1.1

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_2 = arg_510_1:GetWordFromCfg(413031122)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 44
				local var_513_5 = utf8.len(var_513_3)
				local var_513_6 = var_513_4 <= 0 and var_513_1 or var_513_1 * (var_513_5 / var_513_4)

				if var_513_6 > 0 and var_513_1 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_7 and arg_510_1.time_ < var_513_0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play413031123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 413031123
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play413031124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.366666666666667
			local var_517_1 = 0.633333333333333

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				local var_517_2 = "play"
				local var_517_3 = "effect"

				arg_514_1:AudioAction(var_517_2, var_517_3, "se_story_134_01", "se_story_134_01_paper", "")
			end

			local var_517_4 = 0
			local var_517_5 = 0.875

			if var_517_4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_6 = arg_514_1:GetWordFromCfg(413031123)
				local var_517_7 = arg_514_1:FormatText(var_517_6.content)

				arg_514_1.text_.text = var_517_7

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_8 = 35
				local var_517_9 = utf8.len(var_517_7)
				local var_517_10 = var_517_8 <= 0 and var_517_5 or var_517_5 * (var_517_9 / var_517_8)

				if var_517_10 > 0 and var_517_5 < var_517_10 then
					arg_514_1.talkMaxDuration = var_517_10

					if var_517_10 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_10 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_7
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_11 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_11 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_11

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_11 and arg_514_1.time_ < var_517_4 + var_517_11 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play413031124 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 413031124
		arg_518_1.duration_ = 9.57

		local var_518_0 = {
			zh = 8.166,
			ja = 9.566
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play413031125(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0
			local var_521_1 = 0.625

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_2 = arg_518_1:FormatText(StoryNameCfg[1002].name)

				arg_518_1.leftNameTxt_.text = var_521_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_3 = arg_518_1:GetWordFromCfg(413031124)
				local var_521_4 = arg_518_1:FormatText(var_521_3.content)

				arg_518_1.text_.text = var_521_4

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 25
				local var_521_6 = utf8.len(var_521_4)
				local var_521_7 = var_521_5 <= 0 and var_521_1 or var_521_1 * (var_521_6 / var_521_5)

				if var_521_7 > 0 and var_521_1 < var_521_7 then
					arg_518_1.talkMaxDuration = var_521_7

					if var_521_7 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_0
					end
				end

				arg_518_1.text_.text = var_521_4
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031124", "story_v_out_413031.awb") ~= 0 then
					local var_521_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031124", "story_v_out_413031.awb") / 1000

					if var_521_8 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_8 + var_521_0
					end

					if var_521_3.prefab_name ~= "" and arg_518_1.actors_[var_521_3.prefab_name] ~= nil then
						local var_521_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_3.prefab_name].transform, "story_v_out_413031", "413031124", "story_v_out_413031.awb")

						arg_518_1:RecordAudio("413031124", var_521_9)
						arg_518_1:RecordAudio("413031124", var_521_9)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_413031", "413031124", "story_v_out_413031.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_413031", "413031124", "story_v_out_413031.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_10 = math.max(var_521_1, arg_518_1.talkMaxDuration)

			if var_521_0 <= arg_518_1.time_ and arg_518_1.time_ < var_521_0 + var_521_10 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_0) / var_521_10

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_0 + var_521_10 and arg_518_1.time_ < var_521_0 + var_521_10 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play413031125 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 413031125
		arg_522_1.duration_ = 5.83

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play413031126(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["10095"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps10095 == nil then
				arg_522_1.var_.actorSpriteComps10095 = var_525_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_525_2 = 2

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.actorSpriteComps10095 then
					for iter_525_0, iter_525_1 in pairs(arg_522_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_525_1 then
							if arg_522_1.isInRecall_ then
								local var_525_4 = Mathf.Lerp(iter_525_1.color.r, arg_522_1.hightColor2.r, var_525_3)
								local var_525_5 = Mathf.Lerp(iter_525_1.color.g, arg_522_1.hightColor2.g, var_525_3)
								local var_525_6 = Mathf.Lerp(iter_525_1.color.b, arg_522_1.hightColor2.b, var_525_3)

								iter_525_1.color = Color.New(var_525_4, var_525_5, var_525_6)
							else
								local var_525_7 = Mathf.Lerp(iter_525_1.color.r, 0.5, var_525_3)

								iter_525_1.color = Color.New(var_525_7, var_525_7, var_525_7)
							end
						end
					end
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.actorSpriteComps10095 then
				for iter_525_2, iter_525_3 in pairs(arg_522_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_525_3 then
						if arg_522_1.isInRecall_ then
							iter_525_3.color = arg_522_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_525_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_522_1.var_.actorSpriteComps10095 = nil
			end

			local var_525_8 = 0

			if var_525_8 < arg_522_1.time_ and arg_522_1.time_ <= var_525_8 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_9 = 1

			if var_525_8 <= arg_522_1.time_ and arg_522_1.time_ < var_525_8 + var_525_9 then
				local var_525_10 = (arg_522_1.time_ - var_525_8) / var_525_9
				local var_525_11 = Color.New(1, 1, 1)

				var_525_11.a = Mathf.Lerp(1, 0, var_525_10)
				arg_522_1.mask_.color = var_525_11
			end

			if arg_522_1.time_ >= var_525_8 + var_525_9 and arg_522_1.time_ < var_525_8 + var_525_9 + arg_525_0 then
				local var_525_12 = Color.New(1, 1, 1)
				local var_525_13 = 0

				arg_522_1.mask_.enabled = false
				var_525_12.a = var_525_13
				arg_522_1.mask_.color = var_525_12
			end

			local var_525_14 = manager.ui.mainCamera.transform
			local var_525_15 = 0

			if var_525_15 < arg_522_1.time_ and arg_522_1.time_ <= var_525_15 + arg_525_0 then
				local var_525_16 = arg_522_1.var_.effectsecainiuqu1
				local var_525_17
				local var_525_18 = var_525_14

				if not var_525_16 then
					var_525_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_525_18)
					var_525_16.name = "secainiuqu1"
					arg_522_1.var_.effectsecainiuqu1 = var_525_16
				else
					var_525_16.transform:SetParent(var_525_18)
				end

				var_525_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_525_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_525_19 = "SS1302a"

			if arg_522_1.bgs_[var_525_19] == nil then
				local var_525_20 = Object.Instantiate(arg_522_1.paintGo_)

				var_525_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_525_19)
				var_525_20.name = var_525_19
				var_525_20.transform.parent = arg_522_1.stage_.transform
				var_525_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_522_1.bgs_[var_525_19] = var_525_20
			end

			local var_525_21 = 0

			if var_525_21 < arg_522_1.time_ and arg_522_1.time_ <= var_525_21 + arg_525_0 then
				local var_525_22 = manager.ui.mainCamera.transform.localPosition
				local var_525_23 = Vector3.New(0, 0, 10) + Vector3.New(var_525_22.x, var_525_22.y, 0)
				local var_525_24 = arg_522_1.bgs_.SS1302a

				var_525_24.transform.localPosition = var_525_23
				var_525_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_25 = var_525_24:GetComponent("SpriteRenderer")

				if var_525_25 and var_525_25.sprite then
					local var_525_26 = (var_525_24.transform.localPosition - var_525_22).z
					local var_525_27 = manager.ui.mainCameraCom_
					local var_525_28 = 2 * var_525_26 * Mathf.Tan(var_525_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_525_29 = var_525_28 * var_525_27.aspect
					local var_525_30 = var_525_25.sprite.bounds.size.x
					local var_525_31 = var_525_25.sprite.bounds.size.y
					local var_525_32 = var_525_29 / var_525_30
					local var_525_33 = var_525_28 / var_525_31
					local var_525_34 = var_525_33 < var_525_32 and var_525_32 or var_525_33

					var_525_24.transform.localScale = Vector3.New(var_525_34, var_525_34, 0)
				end

				for iter_525_4, iter_525_5 in pairs(arg_522_1.bgs_) do
					if iter_525_4 ~= "SS1302a" then
						iter_525_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_35 = 0.833333333333333
			local var_525_36 = 1.5

			if var_525_35 < arg_522_1.time_ and arg_522_1.time_ <= var_525_35 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_37 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_37:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_38 = arg_522_1:GetWordFromCfg(413031125)
				local var_525_39 = arg_522_1:FormatText(var_525_38.content)

				arg_522_1.text_.text = var_525_39

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_40 = 60
				local var_525_41 = utf8.len(var_525_39)
				local var_525_42 = var_525_40 <= 0 and var_525_36 or var_525_36 * (var_525_41 / var_525_40)

				if var_525_42 > 0 and var_525_36 < var_525_42 then
					arg_522_1.talkMaxDuration = var_525_42
					var_525_35 = var_525_35 + 0.3

					if var_525_42 + var_525_35 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_42 + var_525_35
					end
				end

				arg_522_1.text_.text = var_525_39
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_43 = var_525_35 + 0.3
			local var_525_44 = math.max(var_525_36, arg_522_1.talkMaxDuration)

			if var_525_43 <= arg_522_1.time_ and arg_522_1.time_ < var_525_43 + var_525_44 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_43) / var_525_44

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_43 + var_525_44 and arg_522_1.time_ < var_525_43 + var_525_44 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play413031126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 413031126
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play413031127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 1.5

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_2 = arg_528_1:GetWordFromCfg(413031126)
				local var_531_3 = arg_528_1:FormatText(var_531_2.content)

				arg_528_1.text_.text = var_531_3

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 60
				local var_531_5 = utf8.len(var_531_3)
				local var_531_6 = var_531_4 <= 0 and var_531_1 or var_531_1 * (var_531_5 / var_531_4)

				if var_531_6 > 0 and var_531_1 < var_531_6 then
					arg_528_1.talkMaxDuration = var_531_6

					if var_531_6 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_6 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_3
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_7 and arg_528_1.time_ < var_531_0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play413031127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 413031127
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play413031128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 1.025

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_2 = arg_532_1:GetWordFromCfg(413031127)
				local var_535_3 = arg_532_1:FormatText(var_535_2.content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 41
				local var_535_5 = utf8.len(var_535_3)
				local var_535_6 = var_535_4 <= 0 and var_535_1 or var_535_1 * (var_535_5 / var_535_4)

				if var_535_6 > 0 and var_535_1 < var_535_6 then
					arg_532_1.talkMaxDuration = var_535_6

					if var_535_6 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_7 and arg_532_1.time_ < var_535_0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play413031128 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 413031128
		arg_536_1.duration_ = 3.83

		local var_536_0 = {
			zh = 2.6,
			ja = 3.833
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play413031129(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = manager.ui.mainCamera.transform
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				local var_539_2 = arg_536_1.var_.effectsecainiuqu1

				if var_539_2 then
					Object.Destroy(var_539_2)

					arg_536_1.var_.effectsecainiuqu1 = nil
				end
			end

			local var_539_3 = 0
			local var_539_4 = 0.2

			if var_539_3 < arg_536_1.time_ and arg_536_1.time_ <= var_539_3 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_5 = arg_536_1:FormatText(StoryNameCfg[614].name)

				arg_536_1.leftNameTxt_.text = var_539_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_6 = arg_536_1:GetWordFromCfg(413031128)
				local var_539_7 = arg_536_1:FormatText(var_539_6.content)

				arg_536_1.text_.text = var_539_7

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_8 = 8
				local var_539_9 = utf8.len(var_539_7)
				local var_539_10 = var_539_8 <= 0 and var_539_4 or var_539_4 * (var_539_9 / var_539_8)

				if var_539_10 > 0 and var_539_4 < var_539_10 then
					arg_536_1.talkMaxDuration = var_539_10

					if var_539_10 + var_539_3 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_10 + var_539_3
					end
				end

				arg_536_1.text_.text = var_539_7
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031128", "story_v_out_413031.awb") ~= 0 then
					local var_539_11 = manager.audio:GetVoiceLength("story_v_out_413031", "413031128", "story_v_out_413031.awb") / 1000

					if var_539_11 + var_539_3 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_11 + var_539_3
					end

					if var_539_6.prefab_name ~= "" and arg_536_1.actors_[var_539_6.prefab_name] ~= nil then
						local var_539_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_6.prefab_name].transform, "story_v_out_413031", "413031128", "story_v_out_413031.awb")

						arg_536_1:RecordAudio("413031128", var_539_12)
						arg_536_1:RecordAudio("413031128", var_539_12)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_413031", "413031128", "story_v_out_413031.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_413031", "413031128", "story_v_out_413031.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_13 = math.max(var_539_4, arg_536_1.talkMaxDuration)

			if var_539_3 <= arg_536_1.time_ and arg_536_1.time_ < var_539_3 + var_539_13 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_3) / var_539_13

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_3 + var_539_13 and arg_536_1.time_ < var_539_3 + var_539_13 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play413031129 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 413031129
		arg_540_1.duration_ = 2.5

		local var_540_0 = {
			zh = 2.5,
			ja = 1.366
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play413031130(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0
			local var_543_1 = 0.225

			if var_543_0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_2 = arg_540_1:FormatText(StoryNameCfg[28].name)

				arg_540_1.leftNameTxt_.text = var_543_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_1")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_3 = arg_540_1:GetWordFromCfg(413031129)
				local var_543_4 = arg_540_1:FormatText(var_543_3.content)

				arg_540_1.text_.text = var_543_4

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_5 = 9
				local var_543_6 = utf8.len(var_543_4)
				local var_543_7 = var_543_5 <= 0 and var_543_1 or var_543_1 * (var_543_6 / var_543_5)

				if var_543_7 > 0 and var_543_1 < var_543_7 then
					arg_540_1.talkMaxDuration = var_543_7

					if var_543_7 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_7 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_4
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031129", "story_v_out_413031.awb") ~= 0 then
					local var_543_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031129", "story_v_out_413031.awb") / 1000

					if var_543_8 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_8 + var_543_0
					end

					if var_543_3.prefab_name ~= "" and arg_540_1.actors_[var_543_3.prefab_name] ~= nil then
						local var_543_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_3.prefab_name].transform, "story_v_out_413031", "413031129", "story_v_out_413031.awb")

						arg_540_1:RecordAudio("413031129", var_543_9)
						arg_540_1:RecordAudio("413031129", var_543_9)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_413031", "413031129", "story_v_out_413031.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_413031", "413031129", "story_v_out_413031.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_10 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_10 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_10

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_10 and arg_540_1.time_ < var_543_0 + var_543_10 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play413031130 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 413031130
		arg_544_1.duration_ = 7.33

		local var_544_0 = {
			zh = 6.233,
			ja = 7.333
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play413031131(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.775

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[614].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_3 = arg_544_1:GetWordFromCfg(413031130)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 31
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031130", "story_v_out_413031.awb") ~= 0 then
					local var_547_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031130", "story_v_out_413031.awb") / 1000

					if var_547_8 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_8 + var_547_0
					end

					if var_547_3.prefab_name ~= "" and arg_544_1.actors_[var_547_3.prefab_name] ~= nil then
						local var_547_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_3.prefab_name].transform, "story_v_out_413031", "413031130", "story_v_out_413031.awb")

						arg_544_1:RecordAudio("413031130", var_547_9)
						arg_544_1:RecordAudio("413031130", var_547_9)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_413031", "413031130", "story_v_out_413031.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_413031", "413031130", "story_v_out_413031.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_10 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_10 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_10

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_10 and arg_544_1.time_ < var_547_0 + var_547_10 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play413031131 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 413031131
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play413031132(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0
			local var_551_1 = 1.025

			if var_551_0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_2 = arg_548_1:GetWordFromCfg(413031131)
				local var_551_3 = arg_548_1:FormatText(var_551_2.content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 41
				local var_551_5 = utf8.len(var_551_3)
				local var_551_6 = var_551_4 <= 0 and var_551_1 or var_551_1 * (var_551_5 / var_551_4)

				if var_551_6 > 0 and var_551_1 < var_551_6 then
					arg_548_1.talkMaxDuration = var_551_6

					if var_551_6 + var_551_0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_6 + var_551_0
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_1, arg_548_1.talkMaxDuration)

			if var_551_0 <= arg_548_1.time_ and arg_548_1.time_ < var_551_0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_0 + var_551_7 and arg_548_1.time_ < var_551_0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play413031132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 413031132
		arg_552_1.duration_ = 5.03

		local var_552_0 = {
			zh = 3.5,
			ja = 5.033
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play413031133(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.525

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[992].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(413031132)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 21
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031132", "story_v_out_413031.awb") ~= 0 then
					local var_555_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031132", "story_v_out_413031.awb") / 1000

					if var_555_8 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_8 + var_555_0
					end

					if var_555_3.prefab_name ~= "" and arg_552_1.actors_[var_555_3.prefab_name] ~= nil then
						local var_555_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_3.prefab_name].transform, "story_v_out_413031", "413031132", "story_v_out_413031.awb")

						arg_552_1:RecordAudio("413031132", var_555_9)
						arg_552_1:RecordAudio("413031132", var_555_9)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_413031", "413031132", "story_v_out_413031.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_413031", "413031132", "story_v_out_413031.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_10 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_10 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_10

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_10 and arg_552_1.time_ < var_555_0 + var_555_10 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play413031133 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 413031133
		arg_556_1.duration_ = 4.7

		local var_556_0 = {
			zh = 1.833,
			ja = 4.7
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play413031134(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0
			local var_559_1 = 0.225

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				local var_559_2 = arg_556_1:FormatText(StoryNameCfg[614].name)

				arg_556_1.leftNameTxt_.text = var_559_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, true)
				arg_556_1.iconController_:SetSelectedState("hero")

				arg_556_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_556_1.callingController_:SetSelectedState("normal")

				arg_556_1.keyicon_.color = Color.New(1, 1, 1)
				arg_556_1.icon_.color = Color.New(1, 1, 1)

				local var_559_3 = arg_556_1:GetWordFromCfg(413031133)
				local var_559_4 = arg_556_1:FormatText(var_559_3.content)

				arg_556_1.text_.text = var_559_4

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_5 = 9
				local var_559_6 = utf8.len(var_559_4)
				local var_559_7 = var_559_5 <= 0 and var_559_1 or var_559_1 * (var_559_6 / var_559_5)

				if var_559_7 > 0 and var_559_1 < var_559_7 then
					arg_556_1.talkMaxDuration = var_559_7

					if var_559_7 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_7 + var_559_0
					end
				end

				arg_556_1.text_.text = var_559_4
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031133", "story_v_out_413031.awb") ~= 0 then
					local var_559_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031133", "story_v_out_413031.awb") / 1000

					if var_559_8 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_8 + var_559_0
					end

					if var_559_3.prefab_name ~= "" and arg_556_1.actors_[var_559_3.prefab_name] ~= nil then
						local var_559_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_3.prefab_name].transform, "story_v_out_413031", "413031133", "story_v_out_413031.awb")

						arg_556_1:RecordAudio("413031133", var_559_9)
						arg_556_1:RecordAudio("413031133", var_559_9)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_413031", "413031133", "story_v_out_413031.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_413031", "413031133", "story_v_out_413031.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_10 = math.max(var_559_1, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_10 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_0) / var_559_10

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_10 and arg_556_1.time_ < var_559_0 + var_559_10 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play413031134 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 413031134
		arg_560_1.duration_ = 3.13

		local var_560_0 = {
			zh = 3.133,
			ja = 2.033
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play413031135(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0
			local var_563_1 = 0.225

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_2 = arg_560_1:FormatText(StoryNameCfg[992].name)

				arg_560_1.leftNameTxt_.text = var_563_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:GetWordFromCfg(413031134)
				local var_563_4 = arg_560_1:FormatText(var_563_3.content)

				arg_560_1.text_.text = var_563_4

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 9
				local var_563_6 = utf8.len(var_563_4)
				local var_563_7 = var_563_5 <= 0 and var_563_1 or var_563_1 * (var_563_6 / var_563_5)

				if var_563_7 > 0 and var_563_1 < var_563_7 then
					arg_560_1.talkMaxDuration = var_563_7

					if var_563_7 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_7 + var_563_0
					end
				end

				arg_560_1.text_.text = var_563_4
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031134", "story_v_out_413031.awb") ~= 0 then
					local var_563_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031134", "story_v_out_413031.awb") / 1000

					if var_563_8 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_8 + var_563_0
					end

					if var_563_3.prefab_name ~= "" and arg_560_1.actors_[var_563_3.prefab_name] ~= nil then
						local var_563_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_3.prefab_name].transform, "story_v_out_413031", "413031134", "story_v_out_413031.awb")

						arg_560_1:RecordAudio("413031134", var_563_9)
						arg_560_1:RecordAudio("413031134", var_563_9)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_413031", "413031134", "story_v_out_413031.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_413031", "413031134", "story_v_out_413031.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_10 = math.max(var_563_1, arg_560_1.talkMaxDuration)

			if var_563_0 <= arg_560_1.time_ and arg_560_1.time_ < var_563_0 + var_563_10 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_0) / var_563_10

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_0 + var_563_10 and arg_560_1.time_ < var_563_0 + var_563_10 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play413031135 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 413031135
		arg_564_1.duration_ = 3.3

		local var_564_0 = {
			zh = 3.3,
			ja = 1.833
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play413031136(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0
			local var_567_1 = 0.4

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_2 = arg_564_1:FormatText(StoryNameCfg[614].name)

				arg_564_1.leftNameTxt_.text = var_567_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_3 = arg_564_1:GetWordFromCfg(413031135)
				local var_567_4 = arg_564_1:FormatText(var_567_3.content)

				arg_564_1.text_.text = var_567_4

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_5 = 16
				local var_567_6 = utf8.len(var_567_4)
				local var_567_7 = var_567_5 <= 0 and var_567_1 or var_567_1 * (var_567_6 / var_567_5)

				if var_567_7 > 0 and var_567_1 < var_567_7 then
					arg_564_1.talkMaxDuration = var_567_7

					if var_567_7 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_7 + var_567_0
					end
				end

				arg_564_1.text_.text = var_567_4
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031135", "story_v_out_413031.awb") ~= 0 then
					local var_567_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031135", "story_v_out_413031.awb") / 1000

					if var_567_8 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_8 + var_567_0
					end

					if var_567_3.prefab_name ~= "" and arg_564_1.actors_[var_567_3.prefab_name] ~= nil then
						local var_567_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_3.prefab_name].transform, "story_v_out_413031", "413031135", "story_v_out_413031.awb")

						arg_564_1:RecordAudio("413031135", var_567_9)
						arg_564_1:RecordAudio("413031135", var_567_9)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_413031", "413031135", "story_v_out_413031.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_413031", "413031135", "story_v_out_413031.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_10 = math.max(var_567_1, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_0) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_10 and arg_564_1.time_ < var_567_0 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play413031136 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 413031136
		arg_568_1.duration_ = 5.23

		local var_568_0 = {
			zh = 3.966,
			ja = 5.233
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play413031137(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["10022"]
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 and not isNil(var_571_0) and arg_568_1.var_.actorSpriteComps10022 == nil then
				arg_568_1.var_.actorSpriteComps10022 = var_571_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_571_2 = 2

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_2 and not isNil(var_571_0) then
				local var_571_3 = (arg_568_1.time_ - var_571_1) / var_571_2

				if arg_568_1.var_.actorSpriteComps10022 then
					for iter_571_0, iter_571_1 in pairs(arg_568_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_571_1 then
							if arg_568_1.isInRecall_ then
								local var_571_4 = Mathf.Lerp(iter_571_1.color.r, arg_568_1.hightColor2.r, var_571_3)
								local var_571_5 = Mathf.Lerp(iter_571_1.color.g, arg_568_1.hightColor2.g, var_571_3)
								local var_571_6 = Mathf.Lerp(iter_571_1.color.b, arg_568_1.hightColor2.b, var_571_3)

								iter_571_1.color = Color.New(var_571_4, var_571_5, var_571_6)
							else
								local var_571_7 = Mathf.Lerp(iter_571_1.color.r, 0.5, var_571_3)

								iter_571_1.color = Color.New(var_571_7, var_571_7, var_571_7)
							end
						end
					end
				end
			end

			if arg_568_1.time_ >= var_571_1 + var_571_2 and arg_568_1.time_ < var_571_1 + var_571_2 + arg_571_0 and not isNil(var_571_0) and arg_568_1.var_.actorSpriteComps10022 then
				for iter_571_2, iter_571_3 in pairs(arg_568_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_571_3 then
						if arg_568_1.isInRecall_ then
							iter_571_3.color = arg_568_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_571_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_568_1.var_.actorSpriteComps10022 = nil
			end

			local var_571_8 = 0
			local var_571_9 = 0.4

			if var_571_8 < arg_568_1.time_ and arg_568_1.time_ <= var_571_8 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_10 = arg_568_1:FormatText(StoryNameCfg[992].name)

				arg_568_1.leftNameTxt_.text = var_571_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, true)
				arg_568_1.iconController_:SetSelectedState("hero")

				arg_568_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_568_1.callingController_:SetSelectedState("normal")

				arg_568_1.keyicon_.color = Color.New(1, 1, 1)
				arg_568_1.icon_.color = Color.New(1, 1, 1)

				local var_571_11 = arg_568_1:GetWordFromCfg(413031136)
				local var_571_12 = arg_568_1:FormatText(var_571_11.content)

				arg_568_1.text_.text = var_571_12

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_13 = 16
				local var_571_14 = utf8.len(var_571_12)
				local var_571_15 = var_571_13 <= 0 and var_571_9 or var_571_9 * (var_571_14 / var_571_13)

				if var_571_15 > 0 and var_571_9 < var_571_15 then
					arg_568_1.talkMaxDuration = var_571_15

					if var_571_15 + var_571_8 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_15 + var_571_8
					end
				end

				arg_568_1.text_.text = var_571_12
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031136", "story_v_out_413031.awb") ~= 0 then
					local var_571_16 = manager.audio:GetVoiceLength("story_v_out_413031", "413031136", "story_v_out_413031.awb") / 1000

					if var_571_16 + var_571_8 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_16 + var_571_8
					end

					if var_571_11.prefab_name ~= "" and arg_568_1.actors_[var_571_11.prefab_name] ~= nil then
						local var_571_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_11.prefab_name].transform, "story_v_out_413031", "413031136", "story_v_out_413031.awb")

						arg_568_1:RecordAudio("413031136", var_571_17)
						arg_568_1:RecordAudio("413031136", var_571_17)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_413031", "413031136", "story_v_out_413031.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_413031", "413031136", "story_v_out_413031.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_18 = math.max(var_571_9, arg_568_1.talkMaxDuration)

			if var_571_8 <= arg_568_1.time_ and arg_568_1.time_ < var_571_8 + var_571_18 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_8) / var_571_18

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_8 + var_571_18 and arg_568_1.time_ < var_571_8 + var_571_18 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play413031137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 413031137
		arg_572_1.duration_ = 7.07

		local var_572_0 = {
			zh = 7.066,
			ja = 6.733
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
			arg_572_1.auto_ = false
		end

		function arg_572_1.playNext_(arg_574_0)
			arg_572_1.onStoryFinished_()
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0
			local var_575_1 = 0.725

			if var_575_0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_2 = arg_572_1:FormatText(StoryNameCfg[614].name)

				arg_572_1.leftNameTxt_.text = var_575_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_3 = arg_572_1:GetWordFromCfg(413031137)
				local var_575_4 = arg_572_1:FormatText(var_575_3.content)

				arg_572_1.text_.text = var_575_4

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_5 = 29
				local var_575_6 = utf8.len(var_575_4)
				local var_575_7 = var_575_5 <= 0 and var_575_1 or var_575_1 * (var_575_6 / var_575_5)

				if var_575_7 > 0 and var_575_1 < var_575_7 then
					arg_572_1.talkMaxDuration = var_575_7

					if var_575_7 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_7 + var_575_0
					end
				end

				arg_572_1.text_.text = var_575_4
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413031", "413031137", "story_v_out_413031.awb") ~= 0 then
					local var_575_8 = manager.audio:GetVoiceLength("story_v_out_413031", "413031137", "story_v_out_413031.awb") / 1000

					if var_575_8 + var_575_0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_8 + var_575_0
					end

					if var_575_3.prefab_name ~= "" and arg_572_1.actors_[var_575_3.prefab_name] ~= nil then
						local var_575_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_3.prefab_name].transform, "story_v_out_413031", "413031137", "story_v_out_413031.awb")

						arg_572_1:RecordAudio("413031137", var_575_9)
						arg_572_1:RecordAudio("413031137", var_575_9)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_413031", "413031137", "story_v_out_413031.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_413031", "413031137", "story_v_out_413031.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_10 = math.max(var_575_1, arg_572_1.talkMaxDuration)

			if var_575_0 <= arg_572_1.time_ and arg_572_1.time_ < var_575_0 + var_575_10 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_0) / var_575_10

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_0 + var_575_10 and arg_572_1.time_ < var_575_0 + var_575_10 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0601",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/SS1302",
		"TextureConfig/Background/SS1302a"
	},
	voices = {
		"story_v_out_413031.awb"
	}
}
