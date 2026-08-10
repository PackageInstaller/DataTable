return {
	Play423201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423201001
		arg_1_1.duration_ = 9.63

		local var_1_0 = {
			zh = 9.633,
			ja = 9.233
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
				arg_1_0:Play423201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25j"

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
				local var_4_5 = arg_1_1.bgs_.I25j

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
					if iter_4_0 ~= "I25j" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.333333333333333

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

			local var_4_24 = "3054"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

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

			local var_4_28 = arg_1_1.actors_["3054"]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps3054 == nil then
				arg_1_1.var_.actorSpriteComps3054 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps3054 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps3054 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps3054 = nil
			end

			local var_4_36 = arg_1_1.actors_["3054"].transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos3054 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("3054", 3)

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
				local var_4_42 = Vector3.New(0, -275, -280)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3054, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -275, -280)
			end

			local var_4_43 = arg_1_1.actors_["3054"]
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue3054 = var_4_45.alpha
					arg_1_1.var_.characterEffect3054 = var_4_45
				end

				arg_1_1.var_.alphaOldValue3054 = 0
			end

			local var_4_46 = 0.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue3054, 1, var_4_47)

				if arg_1_1.var_.characterEffect3054 then
					arg_1_1.var_.characterEffect3054.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect3054 then
				arg_1_1.var_.characterEffect3054.alpha = 1
			end

			local var_4_49 = 0.166666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_16", "se_story_16_rain02_loop", "")
			end

			local var_4_53 = 0
			local var_4_54 = 0.3

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_59 = 0.500666666666667
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_64 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_64 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_64

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_64
						arg_1_1.bgmTxt2_.text = var_4_64
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

			local var_4_65 = manager.ui.mainCamera.transform
			local var_4_66 = 0

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_67 = arg_1_1.var_.effectzhenzilengyu3
				local var_4_68
				local var_4_69 = var_4_65

				if not var_4_67 then
					var_4_67 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), var_4_69)
					var_4_67.name = "zhenzilengyu3"
					arg_1_1.var_.effectzhenzilengyu3 = var_4_67
				else
					var_4_67.transform:SetParent(var_4_69)
				end

				var_4_67.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_67.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_70 = 2
			local var_4_71 = 0.65

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_72 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_72:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_73 = arg_1_1:FormatText(StoryNameCfg[1339].name)

				arg_1_1.leftNameTxt_.text = var_4_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_74 = arg_1_1:GetWordFromCfg(423201001)
				local var_4_75 = arg_1_1:FormatText(var_4_74.content)

				arg_1_1.text_.text = var_4_75

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_76 = 26
				local var_4_77 = utf8.len(var_4_75)
				local var_4_78 = var_4_76 <= 0 and var_4_71 or var_4_71 * (var_4_77 / var_4_76)

				if var_4_78 > 0 and var_4_71 < var_4_78 then
					arg_1_1.talkMaxDuration = var_4_78
					var_4_70 = var_4_70 + 0.3

					if var_4_78 + var_4_70 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_78 + var_4_70
					end
				end

				arg_1_1.text_.text = var_4_75
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201001", "story_v_out_423201.awb") ~= 0 then
					local var_4_79 = manager.audio:GetVoiceLength("story_v_out_423201", "423201001", "story_v_out_423201.awb") / 1000

					if var_4_79 + var_4_70 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_79 + var_4_70
					end

					if var_4_74.prefab_name ~= "" and arg_1_1.actors_[var_4_74.prefab_name] ~= nil then
						local var_4_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_74.prefab_name].transform, "story_v_out_423201", "423201001", "story_v_out_423201.awb")

						arg_1_1:RecordAudio("423201001", var_4_80)
						arg_1_1:RecordAudio("423201001", var_4_80)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423201", "423201001", "story_v_out_423201.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423201", "423201001", "story_v_out_423201.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_81 = var_4_70 + 0.3
			local var_4_82 = math.max(var_4_71, arg_1_1.talkMaxDuration)

			if var_4_81 <= arg_1_1.time_ and arg_1_1.time_ < var_4_81 + var_4_82 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_81) / var_4_82

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_81 + var_4_82 and arg_1_1.time_ < var_4_81 + var_4_82 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423201002
		arg_9_1.duration_ = 13

		local var_9_0 = {
			zh = 7.6,
			ja = 13
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
				arg_9_0:Play423201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["3054"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps3054 == nil then
				arg_9_1.var_.actorSpriteComps3054 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps3054 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps3054 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps3054 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.825

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[1336].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(423201002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201002", "story_v_out_423201.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_423201", "423201002", "story_v_out_423201.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_423201", "423201002", "story_v_out_423201.awb")

						arg_9_1:RecordAudio("423201002", var_12_17)
						arg_9_1:RecordAudio("423201002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423201", "423201002", "story_v_out_423201.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423201", "423201002", "story_v_out_423201.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_18 and arg_9_1.time_ < var_12_8 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423201003
		arg_13_1.duration_ = 6.87

		local var_13_0 = {
			zh = 6.866,
			ja = 5.8
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
				arg_13_0:Play423201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["3054"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps3054 == nil then
				arg_13_1.var_.actorSpriteComps3054 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps3054 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps3054 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps3054 = nil
			end

			local var_16_8 = arg_13_1.actors_["3054"].transform
			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.var_.moveOldPos3054 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("3054", 3)

				local var_16_10 = var_16_8.childCount

				for iter_16_4 = 0, var_16_10 - 1 do
					local var_16_11 = var_16_8:GetChild(iter_16_4)

					if var_16_11.name == "" or not string.find(var_16_11.name, "split") then
						var_16_11.gameObject:SetActive(true)
					else
						var_16_11.gameObject:SetActive(false)
					end
				end
			end

			local var_16_12 = 0.001

			if var_16_9 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_12 then
				local var_16_13 = (arg_13_1.time_ - var_16_9) / var_16_12
				local var_16_14 = Vector3.New(0, -275, -280)

				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos3054, var_16_14, var_16_13)
			end

			if arg_13_1.time_ >= var_16_9 + var_16_12 and arg_13_1.time_ < var_16_9 + var_16_12 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_16_15 = 0
			local var_16_16 = 0.625

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[1339].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(423201003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201003", "story_v_out_423201.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201003", "story_v_out_423201.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_423201", "423201003", "story_v_out_423201.awb")

						arg_13_1:RecordAudio("423201003", var_16_24)
						arg_13_1:RecordAudio("423201003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423201", "423201003", "story_v_out_423201.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423201", "423201003", "story_v_out_423201.awb")
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
				actorName = "3054",
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
	Play423201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423201004
		arg_17_1.duration_ = 9.3

		local var_17_0 = {
			zh = 6.566,
			ja = 9.3
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
				arg_17_0:Play423201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["3054"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps3054 == nil then
				arg_17_1.var_.actorSpriteComps3054 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps3054 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps3054 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps3054 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.775

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[1336].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(423201004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201004", "story_v_out_423201.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_423201", "423201004", "story_v_out_423201.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_423201", "423201004", "story_v_out_423201.awb")

						arg_17_1:RecordAudio("423201004", var_20_17)
						arg_17_1:RecordAudio("423201004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423201", "423201004", "story_v_out_423201.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423201", "423201004", "story_v_out_423201.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_18 and arg_17_1.time_ < var_20_8 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play423201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423201005
		arg_21_1.duration_ = 5.83

		local var_21_0 = {
			zh = 5.8,
			ja = 5.833
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
				arg_21_0:Play423201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["3054"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps3054 == nil then
				arg_21_1.var_.actorSpriteComps3054 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps3054 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps3054 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps3054 = nil
			end

			local var_24_8 = arg_21_1.actors_["3054"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos3054 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("3054", 3)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "split_3" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -275, -280)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos3054, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_24_15 = 0
			local var_24_16 = 0.55

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[1339].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(423201005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 22
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201005", "story_v_out_423201.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201005", "story_v_out_423201.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_423201", "423201005", "story_v_out_423201.awb")

						arg_21_1:RecordAudio("423201005", var_24_24)
						arg_21_1:RecordAudio("423201005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423201", "423201005", "story_v_out_423201.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423201", "423201005", "story_v_out_423201.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423201006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["3054"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps3054 == nil then
				arg_25_1.var_.actorSpriteComps3054 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps3054 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps3054 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps3054 = nil
			end

			local var_28_8 = arg_25_1.actors_["3054"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos3054 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("3054", 7)

				local var_28_10 = var_28_8.childCount

				for iter_28_4 = 0, var_28_10 - 1 do
					local var_28_11 = var_28_8:GetChild(iter_28_4)

					if var_28_11.name == "" or not string.find(var_28_11.name, "split") then
						var_28_11.gameObject:SetActive(true)
					else
						var_28_11.gameObject:SetActive(false)
					end
				end
			end

			local var_28_12 = 0.001

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_12 then
				local var_28_13 = (arg_25_1.time_ - var_28_9) / var_28_12
				local var_28_14 = Vector3.New(0, -2000, 0)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos3054, var_28_14, var_28_13)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_12 and arg_25_1.time_ < var_28_9 + var_28_12 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_15 = 0
			local var_28_16 = 1

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				local var_28_17 = "play"
				local var_28_18 = "effect"

				arg_25_1:AudioAction(var_28_17, var_28_18, "se_story_1310", "se_story_1310_footstep05", "")
			end

			local var_28_19 = 0.9
			local var_28_20 = 1

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				local var_28_21 = "play"
				local var_28_22 = "effect"

				arg_25_1:AudioAction(var_28_21, var_28_22, "se_story_140", "se_story_140_explosion05", "")
			end

			local var_28_23 = 1
			local var_28_24 = 1

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				local var_28_25 = "play"
				local var_28_26 = "effect"

				arg_25_1:AudioAction(var_28_25, var_28_26, "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_28_27 = 0
			local var_28_28 = 1.375

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_29 = arg_25_1:GetWordFromCfg(423201006)
				local var_28_30 = arg_25_1:FormatText(var_28_29.content)

				arg_25_1.text_.text = var_28_30

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_31 = 55
				local var_28_32 = utf8.len(var_28_30)
				local var_28_33 = var_28_31 <= 0 and var_28_28 or var_28_28 * (var_28_32 / var_28_31)

				if var_28_33 > 0 and var_28_28 < var_28_33 then
					arg_25_1.talkMaxDuration = var_28_33

					if var_28_33 + var_28_27 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_33 + var_28_27
					end
				end

				arg_25_1.text_.text = var_28_30
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_34 = math.max(var_28_28, arg_25_1.talkMaxDuration)

			if var_28_27 <= arg_25_1.time_ and arg_25_1.time_ < var_28_27 + var_28_34 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_27) / var_28_34

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_27 + var_28_34 and arg_25_1.time_ < var_28_27 + var_28_34 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423201007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.5

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

				local var_32_2 = arg_29_1:GetWordFromCfg(423201007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 60
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
	Play423201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423201008
		arg_33_1.duration_ = 7.5

		local var_33_0 = {
			zh = 5.4,
			ja = 7.5
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
				arg_33_0:Play423201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["3054"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps3054 == nil then
				arg_33_1.var_.actorSpriteComps3054 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps3054 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 1, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps3054 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps3054 = nil
			end

			local var_36_8 = arg_33_1.actors_["3054"].transform
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.var_.moveOldPos3054 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("3054", 3)

				local var_36_10 = var_36_8.childCount

				for iter_36_4 = 0, var_36_10 - 1 do
					local var_36_11 = var_36_8:GetChild(iter_36_4)

					if var_36_11.name == "" or not string.find(var_36_11.name, "split") then
						var_36_11.gameObject:SetActive(true)
					else
						var_36_11.gameObject:SetActive(false)
					end
				end
			end

			local var_36_12 = 0.001

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_12 then
				local var_36_13 = (arg_33_1.time_ - var_36_9) / var_36_12
				local var_36_14 = Vector3.New(0, -275, -280)

				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos3054, var_36_14, var_36_13)
			end

			if arg_33_1.time_ >= var_36_9 + var_36_12 and arg_33_1.time_ < var_36_9 + var_36_12 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_36_15 = 0
			local var_36_16 = 0.6

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[1339].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(423201008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 21
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201008", "story_v_out_423201.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201008", "story_v_out_423201.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_423201", "423201008", "story_v_out_423201.awb")

						arg_33_1:RecordAudio("423201008", var_36_24)
						arg_33_1:RecordAudio("423201008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423201", "423201008", "story_v_out_423201.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423201", "423201008", "story_v_out_423201.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423201009
		arg_37_1.duration_ = 11.87

		local var_37_0 = {
			zh = 10.6,
			ja = 11.866
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
				arg_37_0:Play423201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["3054"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps3054 == nil then
				arg_37_1.var_.actorSpriteComps3054 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps3054 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps3054 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps3054 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 1.15

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_10 = arg_37_1:FormatText(StoryNameCfg[1335].name)

				arg_37_1.leftNameTxt_.text = var_40_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_11 = arg_37_1:GetWordFromCfg(423201009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 46
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_9 or var_40_9 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_9 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201009", "story_v_out_423201.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_423201", "423201009", "story_v_out_423201.awb") / 1000

					if var_40_16 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_8
					end

					if var_40_11.prefab_name ~= "" and arg_37_1.actors_[var_40_11.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_11.prefab_name].transform, "story_v_out_423201", "423201009", "story_v_out_423201.awb")

						arg_37_1:RecordAudio("423201009", var_40_17)
						arg_37_1:RecordAudio("423201009", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423201", "423201009", "story_v_out_423201.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423201", "423201009", "story_v_out_423201.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_18 and arg_37_1.time_ < var_40_8 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423201010
		arg_41_1.duration_ = 8.1

		local var_41_0 = {
			zh = 6.066,
			ja = 8.1
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
				arg_41_0:Play423201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["3054"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps3054 == nil then
				arg_41_1.var_.actorSpriteComps3054 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps3054 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps3054 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps3054 = nil
			end

			local var_44_8 = arg_41_1.actors_["3054"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos3054 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("3054", 3)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(0, -275, -280)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos3054, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_44_15 = 0
			local var_44_16 = 0.55

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[1339].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(423201010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 22
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201010", "story_v_out_423201.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201010", "story_v_out_423201.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_423201", "423201010", "story_v_out_423201.awb")

						arg_41_1:RecordAudio("423201010", var_44_24)
						arg_41_1:RecordAudio("423201010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423201", "423201010", "story_v_out_423201.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423201", "423201010", "story_v_out_423201.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423201011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 4.5,
			ja = 4.4
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
				arg_45_0:Play423201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "1083"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_48_1) then
					local var_48_2 = Object.Instantiate(var_48_1, arg_45_1.canvasGo_.transform)

					var_48_2.transform:SetSiblingIndex(1)

					var_48_2.name = var_48_0
					var_48_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_45_1.actors_[var_48_0] = var_48_2

					local var_48_3 = var_48_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_45_1.isInRecall_ then
						for iter_48_0, iter_48_1 in ipairs(var_48_3) do
							iter_48_1.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_48_4 = arg_45_1.actors_["1083"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1083 == nil then
				arg_45_1.var_.actorSpriteComps1083 = var_48_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.actorSpriteComps1083 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_48_3 then
							if arg_45_1.isInRecall_ then
								local var_48_8 = Mathf.Lerp(iter_48_3.color.r, arg_45_1.hightColor1.r, var_48_7)
								local var_48_9 = Mathf.Lerp(iter_48_3.color.g, arg_45_1.hightColor1.g, var_48_7)
								local var_48_10 = Mathf.Lerp(iter_48_3.color.b, arg_45_1.hightColor1.b, var_48_7)

								iter_48_3.color = Color.New(var_48_8, var_48_9, var_48_10)
							else
								local var_48_11 = Mathf.Lerp(iter_48_3.color.r, 1, var_48_7)

								iter_48_3.color = Color.New(var_48_11, var_48_11, var_48_11)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps1083 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1083 = nil
			end

			local var_48_12 = arg_45_1.actors_["3054"]
			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps3054 == nil then
				arg_45_1.var_.actorSpriteComps3054 = var_48_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_14 = 0.2

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_14 and not isNil(var_48_12) then
				local var_48_15 = (arg_45_1.time_ - var_48_13) / var_48_14

				if arg_45_1.var_.actorSpriteComps3054 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_48_7 then
							if arg_45_1.isInRecall_ then
								local var_48_16 = Mathf.Lerp(iter_48_7.color.r, arg_45_1.hightColor2.r, var_48_15)
								local var_48_17 = Mathf.Lerp(iter_48_7.color.g, arg_45_1.hightColor2.g, var_48_15)
								local var_48_18 = Mathf.Lerp(iter_48_7.color.b, arg_45_1.hightColor2.b, var_48_15)

								iter_48_7.color = Color.New(var_48_16, var_48_17, var_48_18)
							else
								local var_48_19 = Mathf.Lerp(iter_48_7.color.r, 0.5, var_48_15)

								iter_48_7.color = Color.New(var_48_19, var_48_19, var_48_19)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_13 + var_48_14 and arg_45_1.time_ < var_48_13 + var_48_14 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps3054 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps3054 = nil
			end

			local var_48_20 = arg_45_1.actors_["3054"].transform
			local var_48_21 = 0

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.var_.moveOldPos3054 = var_48_20.localPosition
				var_48_20.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("3054", 2)

				local var_48_22 = var_48_20.childCount

				for iter_48_10 = 0, var_48_22 - 1 do
					local var_48_23 = var_48_20:GetChild(iter_48_10)

					if var_48_23.name == "" or not string.find(var_48_23.name, "split") then
						var_48_23.gameObject:SetActive(true)
					else
						var_48_23.gameObject:SetActive(false)
					end
				end
			end

			local var_48_24 = 0.001

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_24 then
				local var_48_25 = (arg_45_1.time_ - var_48_21) / var_48_24
				local var_48_26 = Vector3.New(-390, -275, -280)

				var_48_20.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos3054, var_48_26, var_48_25)
			end

			if arg_45_1.time_ >= var_48_21 + var_48_24 and arg_45_1.time_ < var_48_21 + var_48_24 + arg_48_0 then
				var_48_20.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_48_27 = arg_45_1.actors_["1083"].transform
			local var_48_28 = 0

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = var_48_27.localPosition
				var_48_27.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 4)

				local var_48_29 = var_48_27.childCount

				for iter_48_11 = 0, var_48_29 - 1 do
					local var_48_30 = var_48_27:GetChild(iter_48_11)

					if var_48_30.name == "split_7" or not string.find(var_48_30.name, "split") then
						var_48_30.gameObject:SetActive(true)
					else
						var_48_30.gameObject:SetActive(false)
					end
				end
			end

			local var_48_31 = 0.001

			if var_48_28 <= arg_45_1.time_ and arg_45_1.time_ < var_48_28 + var_48_31 then
				local var_48_32 = (arg_45_1.time_ - var_48_28) / var_48_31
				local var_48_33 = Vector3.New(390, -345, -345)

				var_48_27.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, var_48_33, var_48_32)
			end

			if arg_45_1.time_ >= var_48_28 + var_48_31 and arg_45_1.time_ < var_48_28 + var_48_31 + arg_48_0 then
				var_48_27.localPosition = Vector3.New(390, -345, -345)
			end

			local var_48_34 = 0
			local var_48_35 = 0.5

			if var_48_34 < arg_45_1.time_ and arg_45_1.time_ <= var_48_34 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_36 = arg_45_1:FormatText(StoryNameCfg[1332].name)

				arg_45_1.leftNameTxt_.text = var_48_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_37 = arg_45_1:GetWordFromCfg(423201011)
				local var_48_38 = arg_45_1:FormatText(var_48_37.content)

				arg_45_1.text_.text = var_48_38

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_39 = 20
				local var_48_40 = utf8.len(var_48_38)
				local var_48_41 = var_48_39 <= 0 and var_48_35 or var_48_35 * (var_48_40 / var_48_39)

				if var_48_41 > 0 and var_48_35 < var_48_41 then
					arg_45_1.talkMaxDuration = var_48_41

					if var_48_41 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_41 + var_48_34
					end
				end

				arg_45_1.text_.text = var_48_38
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201011", "story_v_out_423201.awb") ~= 0 then
					local var_48_42 = manager.audio:GetVoiceLength("story_v_out_423201", "423201011", "story_v_out_423201.awb") / 1000

					if var_48_42 + var_48_34 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_42 + var_48_34
					end

					if var_48_37.prefab_name ~= "" and arg_45_1.actors_[var_48_37.prefab_name] ~= nil then
						local var_48_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_37.prefab_name].transform, "story_v_out_423201", "423201011", "story_v_out_423201.awb")

						arg_45_1:RecordAudio("423201011", var_48_43)
						arg_45_1:RecordAudio("423201011", var_48_43)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423201", "423201011", "story_v_out_423201.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423201", "423201011", "story_v_out_423201.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_44 = math.max(var_48_35, arg_45_1.talkMaxDuration)

			if var_48_34 <= arg_45_1.time_ and arg_45_1.time_ < var_48_34 + var_48_44 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_34) / var_48_44

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_34 + var_48_44 and arg_45_1.time_ < var_48_34 + var_48_44 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423201012
		arg_49_1.duration_ = 6.93

		local var_49_0 = {
			zh = 6.6,
			ja = 6.933
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
				arg_49_0:Play423201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1083"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1083 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1083", 4)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(390, -345, -345)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1083, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -345, -345)
			end

			local var_52_7 = 0
			local var_52_8 = 0.75

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_9 = arg_49_1:FormatText(StoryNameCfg[1332].name)

				arg_49_1.leftNameTxt_.text = var_52_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(423201012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 30
				local var_52_13 = utf8.len(var_52_11)
				local var_52_14 = var_52_12 <= 0 and var_52_8 or var_52_8 * (var_52_13 / var_52_12)

				if var_52_14 > 0 and var_52_8 < var_52_14 then
					arg_49_1.talkMaxDuration = var_52_14

					if var_52_14 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201012", "story_v_out_423201.awb") ~= 0 then
					local var_52_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201012", "story_v_out_423201.awb") / 1000

					if var_52_15 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_7
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_423201", "423201012", "story_v_out_423201.awb")

						arg_49_1:RecordAudio("423201012", var_52_16)
						arg_49_1:RecordAudio("423201012", var_52_16)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423201", "423201012", "story_v_out_423201.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423201", "423201012", "story_v_out_423201.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_17 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_17 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_17

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_17 and arg_49_1.time_ < var_52_7 + var_52_17 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423201013
		arg_53_1.duration_ = 9

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play423201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "I25i"

			if arg_53_1.bgs_[var_56_0] == nil then
				local var_56_1 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_56_0)
				var_56_1.name = var_56_0
				var_56_1.transform.parent = arg_53_1.stage_.transform
				var_56_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_[var_56_0] = var_56_1
			end

			local var_56_2 = 2

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				local var_56_3 = manager.ui.mainCamera.transform.localPosition
				local var_56_4 = Vector3.New(0, 0, 10) + Vector3.New(var_56_3.x, var_56_3.y, 0)
				local var_56_5 = arg_53_1.bgs_.I25i

				var_56_5.transform.localPosition = var_56_4
				var_56_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_6 = var_56_5:GetComponent("SpriteRenderer")

				if var_56_6 and var_56_6.sprite then
					local var_56_7 = (var_56_5.transform.localPosition - var_56_3).z
					local var_56_8 = manager.ui.mainCameraCom_
					local var_56_9 = 2 * var_56_7 * Mathf.Tan(var_56_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_56_10 = var_56_9 * var_56_8.aspect
					local var_56_11 = var_56_6.sprite.bounds.size.x
					local var_56_12 = var_56_6.sprite.bounds.size.y
					local var_56_13 = var_56_10 / var_56_11
					local var_56_14 = var_56_9 / var_56_12
					local var_56_15 = var_56_14 < var_56_13 and var_56_13 or var_56_14

					var_56_5.transform.localScale = Vector3.New(var_56_15, var_56_15, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "I25i" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 3.999999999999

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			local var_56_17 = 0.3

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_18 = 0

			if var_56_18 < arg_53_1.time_ and arg_53_1.time_ <= var_56_18 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_19 = 2

			if var_56_18 <= arg_53_1.time_ and arg_53_1.time_ < var_56_18 + var_56_19 then
				local var_56_20 = (arg_53_1.time_ - var_56_18) / var_56_19
				local var_56_21 = Color.New(0, 0, 0)

				var_56_21.a = Mathf.Lerp(0, 1, var_56_20)
				arg_53_1.mask_.color = var_56_21
			end

			if arg_53_1.time_ >= var_56_18 + var_56_19 and arg_53_1.time_ < var_56_18 + var_56_19 + arg_56_0 then
				local var_56_22 = Color.New(0, 0, 0)

				var_56_22.a = 1
				arg_53_1.mask_.color = var_56_22
			end

			local var_56_23 = 2

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_24 = 2

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24
				local var_56_26 = Color.New(0, 0, 0)

				var_56_26.a = Mathf.Lerp(1, 0, var_56_25)
				arg_53_1.mask_.color = var_56_26
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				local var_56_27 = Color.New(0, 0, 0)
				local var_56_28 = 0

				arg_53_1.mask_.enabled = false
				var_56_27.a = var_56_28
				arg_53_1.mask_.color = var_56_27
			end

			local var_56_29 = arg_53_1.actors_["1083"]
			local var_56_30 = 1.966

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 and not isNil(var_56_29) and arg_53_1.var_.actorSpriteComps1083 == nil then
				arg_53_1.var_.actorSpriteComps1083 = var_56_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_31 = 0.034

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_31 and not isNil(var_56_29) then
				local var_56_32 = (arg_53_1.time_ - var_56_30) / var_56_31

				if arg_53_1.var_.actorSpriteComps1083 then
					for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_56_3 then
							if arg_53_1.isInRecall_ then
								local var_56_33 = Mathf.Lerp(iter_56_3.color.r, arg_53_1.hightColor2.r, var_56_32)
								local var_56_34 = Mathf.Lerp(iter_56_3.color.g, arg_53_1.hightColor2.g, var_56_32)
								local var_56_35 = Mathf.Lerp(iter_56_3.color.b, arg_53_1.hightColor2.b, var_56_32)

								iter_56_3.color = Color.New(var_56_33, var_56_34, var_56_35)
							else
								local var_56_36 = Mathf.Lerp(iter_56_3.color.r, 0.5, var_56_32)

								iter_56_3.color = Color.New(var_56_36, var_56_36, var_56_36)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_30 + var_56_31 and arg_53_1.time_ < var_56_30 + var_56_31 + arg_56_0 and not isNil(var_56_29) and arg_53_1.var_.actorSpriteComps1083 then
				for iter_56_4, iter_56_5 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_56_5 then
						if arg_53_1.isInRecall_ then
							iter_56_5.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1083 = nil
			end

			local var_56_37 = arg_53_1.actors_["1083"].transform
			local var_56_38 = 1.966

			if var_56_38 < arg_53_1.time_ and arg_53_1.time_ <= var_56_38 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = var_56_37.localPosition
				var_56_37.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 7)

				local var_56_39 = var_56_37.childCount

				for iter_56_6 = 0, var_56_39 - 1 do
					local var_56_40 = var_56_37:GetChild(iter_56_6)

					if var_56_40.name == "" or not string.find(var_56_40.name, "split") then
						var_56_40.gameObject:SetActive(true)
					else
						var_56_40.gameObject:SetActive(false)
					end
				end
			end

			local var_56_41 = 0.001

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_41 then
				local var_56_42 = (arg_53_1.time_ - var_56_38) / var_56_41
				local var_56_43 = Vector3.New(0, -2000, 0)

				var_56_37.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, var_56_43, var_56_42)
			end

			if arg_53_1.time_ >= var_56_38 + var_56_41 and arg_53_1.time_ < var_56_38 + var_56_41 + arg_56_0 then
				var_56_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_44 = arg_53_1.actors_["3054"].transform
			local var_56_45 = 1.966

			if var_56_45 < arg_53_1.time_ and arg_53_1.time_ <= var_56_45 + arg_56_0 then
				arg_53_1.var_.moveOldPos3054 = var_56_44.localPosition
				var_56_44.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("3054", 7)

				local var_56_46 = var_56_44.childCount

				for iter_56_7 = 0, var_56_46 - 1 do
					local var_56_47 = var_56_44:GetChild(iter_56_7)

					if var_56_47.name == "" or not string.find(var_56_47.name, "split") then
						var_56_47.gameObject:SetActive(true)
					else
						var_56_47.gameObject:SetActive(false)
					end
				end
			end

			local var_56_48 = 0.001

			if var_56_45 <= arg_53_1.time_ and arg_53_1.time_ < var_56_45 + var_56_48 then
				local var_56_49 = (arg_53_1.time_ - var_56_45) / var_56_48
				local var_56_50 = Vector3.New(0, -2000, 0)

				var_56_44.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos3054, var_56_50, var_56_49)
			end

			if arg_53_1.time_ >= var_56_45 + var_56_48 and arg_53_1.time_ < var_56_45 + var_56_48 + arg_56_0 then
				var_56_44.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_56_51 = 4.13333333333333
			local var_56_52 = 1

			if var_56_51 < arg_53_1.time_ and arg_53_1.time_ <= var_56_51 + arg_56_0 then
				local var_56_53 = "play"
				local var_56_54 = "effect"

				arg_53_1:AudioAction(var_56_53, var_56_54, "se_story_1311", "se_story_1311_cardoor02", "")
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_55 = 3.999999999999
			local var_56_56 = 1.4

			if var_56_55 < arg_53_1.time_ and arg_53_1.time_ <= var_56_55 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_57 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_57:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_58 = arg_53_1:GetWordFromCfg(423201013)
				local var_56_59 = arg_53_1:FormatText(var_56_58.content)

				arg_53_1.text_.text = var_56_59

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_60 = 56
				local var_56_61 = utf8.len(var_56_59)
				local var_56_62 = var_56_60 <= 0 and var_56_56 or var_56_56 * (var_56_61 / var_56_60)

				if var_56_62 > 0 and var_56_56 < var_56_62 then
					arg_53_1.talkMaxDuration = var_56_62
					var_56_55 = var_56_55 + 0.3

					if var_56_62 + var_56_55 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_62 + var_56_55
					end
				end

				arg_53_1.text_.text = var_56_59
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_63 = var_56_55 + 0.3
			local var_56_64 = math.max(var_56_56, arg_53_1.talkMaxDuration)

			if var_56_63 <= arg_53_1.time_ and arg_53_1.time_ < var_56_63 + var_56_64 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_63) / var_56_64

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_63 + var_56_64 and arg_53_1.time_ < var_56_63 + var_56_64 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play423201014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423201014
		arg_59_1.duration_ = 7.07

		local var_59_0 = {
			zh = 5.666,
			ja = 7.066
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
				arg_59_0:Play423201015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1083"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1083 == nil then
				arg_59_1.var_.actorSpriteComps1083 = var_62_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.actorSpriteComps1083 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.actorSpriteComps1083 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_62_3 then
						if arg_59_1.isInRecall_ then
							iter_62_3.color = arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_62_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_59_1.var_.actorSpriteComps1083 = nil
			end

			local var_62_8 = arg_59_1.actors_["1083"].transform
			local var_62_9 = 0

			if var_62_9 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.var_.moveOldPos1083 = var_62_8.localPosition
				var_62_8.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("1083", 3)

				local var_62_10 = var_62_8.childCount

				for iter_62_4 = 0, var_62_10 - 1 do
					local var_62_11 = var_62_8:GetChild(iter_62_4)

					if var_62_11.name == "split_7" or not string.find(var_62_11.name, "split") then
						var_62_11.gameObject:SetActive(true)
					else
						var_62_11.gameObject:SetActive(false)
					end
				end
			end

			local var_62_12 = 0.001

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_12 then
				local var_62_13 = (arg_59_1.time_ - var_62_9) / var_62_12
				local var_62_14 = Vector3.New(-50, -345, -345)

				var_62_8.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1083, var_62_14, var_62_13)
			end

			if arg_59_1.time_ >= var_62_9 + var_62_12 and arg_59_1.time_ < var_62_9 + var_62_12 + arg_62_0 then
				var_62_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_62_15 = 0
			local var_62_16 = 0.625

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[1332].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(423201014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201014", "story_v_out_423201.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201014", "story_v_out_423201.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_423201", "423201014", "story_v_out_423201.awb")

						arg_59_1:RecordAudio("423201014", var_62_24)
						arg_59_1:RecordAudio("423201014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423201", "423201014", "story_v_out_423201.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423201", "423201014", "story_v_out_423201.awb")
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
				actorName = "1083",
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
	Play423201015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423201015
		arg_63_1.duration_ = 4.8

		local var_63_0 = {
			zh = 4,
			ja = 4.8
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play423201016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1083"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos1083 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("1083", 3)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(-50, -345, -345)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1083, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_66_7 = 0
			local var_66_8 = 0.5

			if var_66_7 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_9 = arg_63_1:FormatText(StoryNameCfg[1332].name)

				arg_63_1.leftNameTxt_.text = var_66_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(423201015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_12 = 20
				local var_66_13 = utf8.len(var_66_11)
				local var_66_14 = var_66_12 <= 0 and var_66_8 or var_66_8 * (var_66_13 / var_66_12)

				if var_66_14 > 0 and var_66_8 < var_66_14 then
					arg_63_1.talkMaxDuration = var_66_14

					if var_66_14 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_7
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201015", "story_v_out_423201.awb") ~= 0 then
					local var_66_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201015", "story_v_out_423201.awb") / 1000

					if var_66_15 + var_66_7 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_15 + var_66_7
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_423201", "423201015", "story_v_out_423201.awb")

						arg_63_1:RecordAudio("423201015", var_66_16)
						arg_63_1:RecordAudio("423201015", var_66_16)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_423201", "423201015", "story_v_out_423201.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_423201", "423201015", "story_v_out_423201.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_17 = math.max(var_66_8, arg_63_1.talkMaxDuration)

			if var_66_7 <= arg_63_1.time_ and arg_63_1.time_ < var_66_7 + var_66_17 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_7) / var_66_17

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_7 + var_66_17 and arg_63_1.time_ < var_66_7 + var_66_17 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play423201016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 423201016
		arg_67_1.duration_ = 6.67

		local var_67_0 = {
			zh = 6.666,
			ja = 4.6
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play423201017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["3054"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps3054 == nil then
				arg_67_1.var_.actorSpriteComps3054 = var_70_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.actorSpriteComps3054 then
					for iter_70_0, iter_70_1 in pairs(arg_67_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_70_1 then
							if arg_67_1.isInRecall_ then
								local var_70_4 = Mathf.Lerp(iter_70_1.color.r, arg_67_1.hightColor1.r, var_70_3)
								local var_70_5 = Mathf.Lerp(iter_70_1.color.g, arg_67_1.hightColor1.g, var_70_3)
								local var_70_6 = Mathf.Lerp(iter_70_1.color.b, arg_67_1.hightColor1.b, var_70_3)

								iter_70_1.color = Color.New(var_70_4, var_70_5, var_70_6)
							else
								local var_70_7 = Mathf.Lerp(iter_70_1.color.r, 1, var_70_3)

								iter_70_1.color = Color.New(var_70_7, var_70_7, var_70_7)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.actorSpriteComps3054 then
				for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_70_3 then
						if arg_67_1.isInRecall_ then
							iter_70_3.color = arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_70_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps3054 = nil
			end

			local var_70_8 = arg_67_1.actors_["1083"]
			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1083 == nil then
				arg_67_1.var_.actorSpriteComps1083 = var_70_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_10 = 0.2

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_10 and not isNil(var_70_8) then
				local var_70_11 = (arg_67_1.time_ - var_70_9) / var_70_10

				if arg_67_1.var_.actorSpriteComps1083 then
					for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_70_5 then
							if arg_67_1.isInRecall_ then
								local var_70_12 = Mathf.Lerp(iter_70_5.color.r, arg_67_1.hightColor2.r, var_70_11)
								local var_70_13 = Mathf.Lerp(iter_70_5.color.g, arg_67_1.hightColor2.g, var_70_11)
								local var_70_14 = Mathf.Lerp(iter_70_5.color.b, arg_67_1.hightColor2.b, var_70_11)

								iter_70_5.color = Color.New(var_70_12, var_70_13, var_70_14)
							else
								local var_70_15 = Mathf.Lerp(iter_70_5.color.r, 0.5, var_70_11)

								iter_70_5.color = Color.New(var_70_15, var_70_15, var_70_15)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_9 + var_70_10 and arg_67_1.time_ < var_70_9 + var_70_10 + arg_70_0 and not isNil(var_70_8) and arg_67_1.var_.actorSpriteComps1083 then
				for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_70_7 then
						if arg_67_1.isInRecall_ then
							iter_70_7.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps1083 = nil
			end

			local var_70_16 = arg_67_1.actors_["1083"].transform
			local var_70_17 = 0

			if var_70_17 < arg_67_1.time_ and arg_67_1.time_ <= var_70_17 + arg_70_0 then
				arg_67_1.var_.moveOldPos1083 = var_70_16.localPosition
				var_70_16.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("1083", 2)

				local var_70_18 = var_70_16.childCount

				for iter_70_8 = 0, var_70_18 - 1 do
					local var_70_19 = var_70_16:GetChild(iter_70_8)

					if var_70_19.name == "" or not string.find(var_70_19.name, "split") then
						var_70_19.gameObject:SetActive(true)
					else
						var_70_19.gameObject:SetActive(false)
					end
				end
			end

			local var_70_20 = 0.001

			if var_70_17 <= arg_67_1.time_ and arg_67_1.time_ < var_70_17 + var_70_20 then
				local var_70_21 = (arg_67_1.time_ - var_70_17) / var_70_20
				local var_70_22 = Vector3.New(-440, -345, -345)

				var_70_16.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1083, var_70_22, var_70_21)
			end

			if arg_67_1.time_ >= var_70_17 + var_70_20 and arg_67_1.time_ < var_70_17 + var_70_20 + arg_70_0 then
				var_70_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_70_23 = arg_67_1.actors_["3054"].transform
			local var_70_24 = 0

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.var_.moveOldPos3054 = var_70_23.localPosition
				var_70_23.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("3054", 4)

				local var_70_25 = var_70_23.childCount

				for iter_70_9 = 0, var_70_25 - 1 do
					local var_70_26 = var_70_23:GetChild(iter_70_9)

					if var_70_26.name == "" or not string.find(var_70_26.name, "split") then
						var_70_26.gameObject:SetActive(true)
					else
						var_70_26.gameObject:SetActive(false)
					end
				end
			end

			local var_70_27 = 0.001

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_27 then
				local var_70_28 = (arg_67_1.time_ - var_70_24) / var_70_27
				local var_70_29 = Vector3.New(390, -275, -280)

				var_70_23.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos3054, var_70_29, var_70_28)
			end

			if arg_67_1.time_ >= var_70_24 + var_70_27 and arg_67_1.time_ < var_70_24 + var_70_27 + arg_70_0 then
				var_70_23.localPosition = Vector3.New(390, -275, -280)
			end

			local var_70_30 = 0
			local var_70_31 = 0.65

			if var_70_30 < arg_67_1.time_ and arg_67_1.time_ <= var_70_30 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_32 = arg_67_1:FormatText(StoryNameCfg[1339].name)

				arg_67_1.leftNameTxt_.text = var_70_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_33 = arg_67_1:GetWordFromCfg(423201016)
				local var_70_34 = arg_67_1:FormatText(var_70_33.content)

				arg_67_1.text_.text = var_70_34

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_35 = 26
				local var_70_36 = utf8.len(var_70_34)
				local var_70_37 = var_70_35 <= 0 and var_70_31 or var_70_31 * (var_70_36 / var_70_35)

				if var_70_37 > 0 and var_70_31 < var_70_37 then
					arg_67_1.talkMaxDuration = var_70_37

					if var_70_37 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_37 + var_70_30
					end
				end

				arg_67_1.text_.text = var_70_34
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201016", "story_v_out_423201.awb") ~= 0 then
					local var_70_38 = manager.audio:GetVoiceLength("story_v_out_423201", "423201016", "story_v_out_423201.awb") / 1000

					if var_70_38 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_38 + var_70_30
					end

					if var_70_33.prefab_name ~= "" and arg_67_1.actors_[var_70_33.prefab_name] ~= nil then
						local var_70_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_33.prefab_name].transform, "story_v_out_423201", "423201016", "story_v_out_423201.awb")

						arg_67_1:RecordAudio("423201016", var_70_39)
						arg_67_1:RecordAudio("423201016", var_70_39)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_423201", "423201016", "story_v_out_423201.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_423201", "423201016", "story_v_out_423201.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_40 = math.max(var_70_31, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_40 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_40

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_40 and arg_67_1.time_ < var_70_30 + var_70_40 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play423201017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 423201017
		arg_71_1.duration_ = 7.37

		local var_71_0 = {
			zh = 7.366,
			ja = 4.933
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play423201018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1083"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1083 == nil then
				arg_71_1.var_.actorSpriteComps1083 = var_74_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.actorSpriteComps1083 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								local var_74_4 = Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor1.r, var_74_3)
								local var_74_5 = Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor1.g, var_74_3)
								local var_74_6 = Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor1.b, var_74_3)

								iter_74_1.color = Color.New(var_74_4, var_74_5, var_74_6)
							else
								local var_74_7 = Mathf.Lerp(iter_74_1.color.r, 1, var_74_3)

								iter_74_1.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.actorSpriteComps1083 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_74_3 then
						if arg_71_1.isInRecall_ then
							iter_74_3.color = arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_74_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps1083 = nil
			end

			local var_74_8 = arg_71_1.actors_["3054"]
			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps3054 == nil then
				arg_71_1.var_.actorSpriteComps3054 = var_74_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_10 = 0.2

			if var_74_9 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 and not isNil(var_74_8) then
				local var_74_11 = (arg_71_1.time_ - var_74_9) / var_74_10

				if arg_71_1.var_.actorSpriteComps3054 then
					for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_74_5 then
							if arg_71_1.isInRecall_ then
								local var_74_12 = Mathf.Lerp(iter_74_5.color.r, arg_71_1.hightColor2.r, var_74_11)
								local var_74_13 = Mathf.Lerp(iter_74_5.color.g, arg_71_1.hightColor2.g, var_74_11)
								local var_74_14 = Mathf.Lerp(iter_74_5.color.b, arg_71_1.hightColor2.b, var_74_11)

								iter_74_5.color = Color.New(var_74_12, var_74_13, var_74_14)
							else
								local var_74_15 = Mathf.Lerp(iter_74_5.color.r, 0.5, var_74_11)

								iter_74_5.color = Color.New(var_74_15, var_74_15, var_74_15)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps3054 then
				for iter_74_6, iter_74_7 in pairs(arg_71_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_74_7 then
						if arg_71_1.isInRecall_ then
							iter_74_7.color = arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_74_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_71_1.var_.actorSpriteComps3054 = nil
			end

			local var_74_16 = arg_71_1.actors_["1083"].transform
			local var_74_17 = 0

			if var_74_17 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 then
				arg_71_1.var_.moveOldPos1083 = var_74_16.localPosition
				var_74_16.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1083", 2)

				local var_74_18 = var_74_16.childCount

				for iter_74_8 = 0, var_74_18 - 1 do
					local var_74_19 = var_74_16:GetChild(iter_74_8)

					if var_74_19.name == "split_7" or not string.find(var_74_19.name, "split") then
						var_74_19.gameObject:SetActive(true)
					else
						var_74_19.gameObject:SetActive(false)
					end
				end
			end

			local var_74_20 = 0.001

			if var_74_17 <= arg_71_1.time_ and arg_71_1.time_ < var_74_17 + var_74_20 then
				local var_74_21 = (arg_71_1.time_ - var_74_17) / var_74_20
				local var_74_22 = Vector3.New(-440, -345, -345)

				var_74_16.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1083, var_74_22, var_74_21)
			end

			if arg_71_1.time_ >= var_74_17 + var_74_20 and arg_71_1.time_ < var_74_17 + var_74_20 + arg_74_0 then
				var_74_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_74_23 = 0
			local var_74_24 = 0.775

			if var_74_23 < arg_71_1.time_ and arg_71_1.time_ <= var_74_23 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_25 = arg_71_1:FormatText(StoryNameCfg[1332].name)

				arg_71_1.leftNameTxt_.text = var_74_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_26 = arg_71_1:GetWordFromCfg(423201017)
				local var_74_27 = arg_71_1:FormatText(var_74_26.content)

				arg_71_1.text_.text = var_74_27

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_28 = 31
				local var_74_29 = utf8.len(var_74_27)
				local var_74_30 = var_74_28 <= 0 and var_74_24 or var_74_24 * (var_74_29 / var_74_28)

				if var_74_30 > 0 and var_74_24 < var_74_30 then
					arg_71_1.talkMaxDuration = var_74_30

					if var_74_30 + var_74_23 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_30 + var_74_23
					end
				end

				arg_71_1.text_.text = var_74_27
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201017", "story_v_out_423201.awb") ~= 0 then
					local var_74_31 = manager.audio:GetVoiceLength("story_v_out_423201", "423201017", "story_v_out_423201.awb") / 1000

					if var_74_31 + var_74_23 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_31 + var_74_23
					end

					if var_74_26.prefab_name ~= "" and arg_71_1.actors_[var_74_26.prefab_name] ~= nil then
						local var_74_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_26.prefab_name].transform, "story_v_out_423201", "423201017", "story_v_out_423201.awb")

						arg_71_1:RecordAudio("423201017", var_74_32)
						arg_71_1:RecordAudio("423201017", var_74_32)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_423201", "423201017", "story_v_out_423201.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_423201", "423201017", "story_v_out_423201.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_33 = math.max(var_74_24, arg_71_1.talkMaxDuration)

			if var_74_23 <= arg_71_1.time_ and arg_71_1.time_ < var_74_23 + var_74_33 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_23) / var_74_33

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_23 + var_74_33 and arg_71_1.time_ < var_74_23 + var_74_33 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play423201018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423201018
		arg_75_1.duration_ = 12.93

		local var_75_0 = {
			zh = 9.566,
			ja = 12.933
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423201019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.05

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[1332].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(423201018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 42
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201018", "story_v_out_423201.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201018", "story_v_out_423201.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_423201", "423201018", "story_v_out_423201.awb")

						arg_75_1:RecordAudio("423201018", var_78_9)
						arg_75_1:RecordAudio("423201018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_423201", "423201018", "story_v_out_423201.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_423201", "423201018", "story_v_out_423201.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423201019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423201019
		arg_79_1.duration_ = 9.33

		local var_79_0 = {
			zh = 9.333,
			ja = 5.1
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
				arg_79_0:Play423201020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1083"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1083 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1083", 2)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "split_7" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(-440, -345, -345)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1083, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_82_7 = 0
			local var_82_8 = 1.15

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_9 = arg_79_1:FormatText(StoryNameCfg[1332].name)

				arg_79_1.leftNameTxt_.text = var_82_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:GetWordFromCfg(423201019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 45
				local var_82_13 = utf8.len(var_82_11)
				local var_82_14 = var_82_12 <= 0 and var_82_8 or var_82_8 * (var_82_13 / var_82_12)

				if var_82_14 > 0 and var_82_8 < var_82_14 then
					arg_79_1.talkMaxDuration = var_82_14

					if var_82_14 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201019", "story_v_out_423201.awb") ~= 0 then
					local var_82_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201019", "story_v_out_423201.awb") / 1000

					if var_82_15 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_7
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_423201", "423201019", "story_v_out_423201.awb")

						arg_79_1:RecordAudio("423201019", var_82_16)
						arg_79_1:RecordAudio("423201019", var_82_16)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_423201", "423201019", "story_v_out_423201.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_423201", "423201019", "story_v_out_423201.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_17 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_17 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_7) / var_82_17

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_7 + var_82_17 and arg_79_1.time_ < var_82_7 + var_82_17 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423201020
		arg_83_1.duration_ = 10.6

		local var_83_0 = {
			zh = 10.566,
			ja = 10.6
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play423201021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["3054"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps3054 == nil then
				arg_83_1.var_.actorSpriteComps3054 = var_86_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.actorSpriteComps3054 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								local var_86_4 = Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor1.r, var_86_3)
								local var_86_5 = Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor1.g, var_86_3)
								local var_86_6 = Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor1.b, var_86_3)

								iter_86_1.color = Color.New(var_86_4, var_86_5, var_86_6)
							else
								local var_86_7 = Mathf.Lerp(iter_86_1.color.r, 1, var_86_3)

								iter_86_1.color = Color.New(var_86_7, var_86_7, var_86_7)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.actorSpriteComps3054 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_86_3 then
						if arg_83_1.isInRecall_ then
							iter_86_3.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps3054 = nil
			end

			local var_86_8 = arg_83_1.actors_["1083"]
			local var_86_9 = 0

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.actorSpriteComps1083 == nil then
				arg_83_1.var_.actorSpriteComps1083 = var_86_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_10 = 0.2

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_10 and not isNil(var_86_8) then
				local var_86_11 = (arg_83_1.time_ - var_86_9) / var_86_10

				if arg_83_1.var_.actorSpriteComps1083 then
					for iter_86_4, iter_86_5 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_86_5 then
							if arg_83_1.isInRecall_ then
								local var_86_12 = Mathf.Lerp(iter_86_5.color.r, arg_83_1.hightColor2.r, var_86_11)
								local var_86_13 = Mathf.Lerp(iter_86_5.color.g, arg_83_1.hightColor2.g, var_86_11)
								local var_86_14 = Mathf.Lerp(iter_86_5.color.b, arg_83_1.hightColor2.b, var_86_11)

								iter_86_5.color = Color.New(var_86_12, var_86_13, var_86_14)
							else
								local var_86_15 = Mathf.Lerp(iter_86_5.color.r, 0.5, var_86_11)

								iter_86_5.color = Color.New(var_86_15, var_86_15, var_86_15)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_9 + var_86_10 and arg_83_1.time_ < var_86_9 + var_86_10 + arg_86_0 and not isNil(var_86_8) and arg_83_1.var_.actorSpriteComps1083 then
				for iter_86_6, iter_86_7 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_86_7 then
						if arg_83_1.isInRecall_ then
							iter_86_7.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1083 = nil
			end

			local var_86_16 = arg_83_1.actors_["3054"].transform
			local var_86_17 = 0

			if var_86_17 < arg_83_1.time_ and arg_83_1.time_ <= var_86_17 + arg_86_0 then
				arg_83_1.var_.moveOldPos3054 = var_86_16.localPosition
				var_86_16.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("3054", 4)

				local var_86_18 = var_86_16.childCount

				for iter_86_8 = 0, var_86_18 - 1 do
					local var_86_19 = var_86_16:GetChild(iter_86_8)

					if var_86_19.name == "" or not string.find(var_86_19.name, "split") then
						var_86_19.gameObject:SetActive(true)
					else
						var_86_19.gameObject:SetActive(false)
					end
				end
			end

			local var_86_20 = 0.001

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_20 then
				local var_86_21 = (arg_83_1.time_ - var_86_17) / var_86_20
				local var_86_22 = Vector3.New(390, -275, -280)

				var_86_16.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos3054, var_86_22, var_86_21)
			end

			if arg_83_1.time_ >= var_86_17 + var_86_20 and arg_83_1.time_ < var_86_17 + var_86_20 + arg_86_0 then
				var_86_16.localPosition = Vector3.New(390, -275, -280)
			end

			local var_86_23 = 0
			local var_86_24 = 0.875

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_25 = arg_83_1:FormatText(StoryNameCfg[1339].name)

				arg_83_1.leftNameTxt_.text = var_86_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_26 = arg_83_1:GetWordFromCfg(423201020)
				local var_86_27 = arg_83_1:FormatText(var_86_26.content)

				arg_83_1.text_.text = var_86_27

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_28 = 35
				local var_86_29 = utf8.len(var_86_27)
				local var_86_30 = var_86_28 <= 0 and var_86_24 or var_86_24 * (var_86_29 / var_86_28)

				if var_86_30 > 0 and var_86_24 < var_86_30 then
					arg_83_1.talkMaxDuration = var_86_30

					if var_86_30 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_30 + var_86_23
					end
				end

				arg_83_1.text_.text = var_86_27
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201020", "story_v_out_423201.awb") ~= 0 then
					local var_86_31 = manager.audio:GetVoiceLength("story_v_out_423201", "423201020", "story_v_out_423201.awb") / 1000

					if var_86_31 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_31 + var_86_23
					end

					if var_86_26.prefab_name ~= "" and arg_83_1.actors_[var_86_26.prefab_name] ~= nil then
						local var_86_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_26.prefab_name].transform, "story_v_out_423201", "423201020", "story_v_out_423201.awb")

						arg_83_1:RecordAudio("423201020", var_86_32)
						arg_83_1:RecordAudio("423201020", var_86_32)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423201", "423201020", "story_v_out_423201.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423201", "423201020", "story_v_out_423201.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_33 = math.max(var_86_24, arg_83_1.talkMaxDuration)

			if var_86_23 <= arg_83_1.time_ and arg_83_1.time_ < var_86_23 + var_86_33 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_23) / var_86_33

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_23 + var_86_33 and arg_83_1.time_ < var_86_23 + var_86_33 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423201021
		arg_87_1.duration_ = 7.27

		local var_87_0 = {
			zh = 7.266,
			ja = 4.666
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play423201022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["3054"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos3054 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("3054", 4)

				local var_90_2 = var_90_0.childCount

				for iter_90_0 = 0, var_90_2 - 1 do
					local var_90_3 = var_90_0:GetChild(iter_90_0)

					if var_90_3.name == "" or not string.find(var_90_3.name, "split") then
						var_90_3.gameObject:SetActive(true)
					else
						var_90_3.gameObject:SetActive(false)
					end
				end
			end

			local var_90_4 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_4 then
				local var_90_5 = (arg_87_1.time_ - var_90_1) / var_90_4
				local var_90_6 = Vector3.New(390, -275, -280)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos3054, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(390, -275, -280)
			end

			local var_90_7 = 0
			local var_90_8 = 0.75

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_9 = arg_87_1:FormatText(StoryNameCfg[1339].name)

				arg_87_1.leftNameTxt_.text = var_90_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(423201021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_12 = 30
				local var_90_13 = utf8.len(var_90_11)
				local var_90_14 = var_90_12 <= 0 and var_90_8 or var_90_8 * (var_90_13 / var_90_12)

				if var_90_14 > 0 and var_90_8 < var_90_14 then
					arg_87_1.talkMaxDuration = var_90_14

					if var_90_14 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_7
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201021", "story_v_out_423201.awb") ~= 0 then
					local var_90_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201021", "story_v_out_423201.awb") / 1000

					if var_90_15 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_7
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_423201", "423201021", "story_v_out_423201.awb")

						arg_87_1:RecordAudio("423201021", var_90_16)
						arg_87_1:RecordAudio("423201021", var_90_16)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_423201", "423201021", "story_v_out_423201.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_423201", "423201021", "story_v_out_423201.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_17 = math.max(var_90_8, arg_87_1.talkMaxDuration)

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_17 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_7) / var_90_17

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_7 + var_90_17 and arg_87_1.time_ < var_90_7 + var_90_17 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423201022
		arg_91_1.duration_ = 6.1

		local var_91_0 = {
			zh = 4.366,
			ja = 6.1
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
				arg_91_0:Play423201023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1083"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps1083 == nil then
				arg_91_1.var_.actorSpriteComps1083 = var_94_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.actorSpriteComps1083 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								local var_94_4 = Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor1.r, var_94_3)
								local var_94_5 = Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor1.g, var_94_3)
								local var_94_6 = Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor1.b, var_94_3)

								iter_94_1.color = Color.New(var_94_4, var_94_5, var_94_6)
							else
								local var_94_7 = Mathf.Lerp(iter_94_1.color.r, 1, var_94_3)

								iter_94_1.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.actorSpriteComps1083 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_94_3 then
						if arg_91_1.isInRecall_ then
							iter_94_3.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1083 = nil
			end

			local var_94_8 = arg_91_1.actors_["3054"]
			local var_94_9 = 0

			if var_94_9 < arg_91_1.time_ and arg_91_1.time_ <= var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps3054 == nil then
				arg_91_1.var_.actorSpriteComps3054 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_10 = 0.2

			if var_94_9 <= arg_91_1.time_ and arg_91_1.time_ < var_94_9 + var_94_10 and not isNil(var_94_8) then
				local var_94_11 = (arg_91_1.time_ - var_94_9) / var_94_10

				if arg_91_1.var_.actorSpriteComps3054 then
					for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_94_5 then
							if arg_91_1.isInRecall_ then
								local var_94_12 = Mathf.Lerp(iter_94_5.color.r, arg_91_1.hightColor2.r, var_94_11)
								local var_94_13 = Mathf.Lerp(iter_94_5.color.g, arg_91_1.hightColor2.g, var_94_11)
								local var_94_14 = Mathf.Lerp(iter_94_5.color.b, arg_91_1.hightColor2.b, var_94_11)

								iter_94_5.color = Color.New(var_94_12, var_94_13, var_94_14)
							else
								local var_94_15 = Mathf.Lerp(iter_94_5.color.r, 0.5, var_94_11)

								iter_94_5.color = Color.New(var_94_15, var_94_15, var_94_15)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_9 + var_94_10 and arg_91_1.time_ < var_94_9 + var_94_10 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps3054 then
				for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_94_7 then
						if arg_91_1.isInRecall_ then
							iter_94_7.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps3054 = nil
			end

			local var_94_16 = arg_91_1.actors_["1083"].transform
			local var_94_17 = 0

			if var_94_17 < arg_91_1.time_ and arg_91_1.time_ <= var_94_17 + arg_94_0 then
				arg_91_1.var_.moveOldPos1083 = var_94_16.localPosition
				var_94_16.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1083", 2)

				local var_94_18 = var_94_16.childCount

				for iter_94_8 = 0, var_94_18 - 1 do
					local var_94_19 = var_94_16:GetChild(iter_94_8)

					if var_94_19.name == "split_7" or not string.find(var_94_19.name, "split") then
						var_94_19.gameObject:SetActive(true)
					else
						var_94_19.gameObject:SetActive(false)
					end
				end
			end

			local var_94_20 = 0.001

			if var_94_17 <= arg_91_1.time_ and arg_91_1.time_ < var_94_17 + var_94_20 then
				local var_94_21 = (arg_91_1.time_ - var_94_17) / var_94_20
				local var_94_22 = Vector3.New(-440, -345, -345)

				var_94_16.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1083, var_94_22, var_94_21)
			end

			if arg_91_1.time_ >= var_94_17 + var_94_20 and arg_91_1.time_ < var_94_17 + var_94_20 + arg_94_0 then
				var_94_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_94_23 = 0
			local var_94_24 = 0.4

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_25 = arg_91_1:FormatText(StoryNameCfg[1332].name)

				arg_91_1.leftNameTxt_.text = var_94_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(423201022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 16
				local var_94_29 = utf8.len(var_94_27)
				local var_94_30 = var_94_28 <= 0 and var_94_24 or var_94_24 * (var_94_29 / var_94_28)

				if var_94_30 > 0 and var_94_24 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201022", "story_v_out_423201.awb") ~= 0 then
					local var_94_31 = manager.audio:GetVoiceLength("story_v_out_423201", "423201022", "story_v_out_423201.awb") / 1000

					if var_94_31 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_23
					end

					if var_94_26.prefab_name ~= "" and arg_91_1.actors_[var_94_26.prefab_name] ~= nil then
						local var_94_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_26.prefab_name].transform, "story_v_out_423201", "423201022", "story_v_out_423201.awb")

						arg_91_1:RecordAudio("423201022", var_94_32)
						arg_91_1:RecordAudio("423201022", var_94_32)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423201", "423201022", "story_v_out_423201.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423201", "423201022", "story_v_out_423201.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_33 = math.max(var_94_24, arg_91_1.talkMaxDuration)

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_33 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_23) / var_94_33

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_23 + var_94_33 and arg_91_1.time_ < var_94_23 + var_94_33 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423201023
		arg_95_1.duration_ = 10.17

		local var_95_0 = {
			zh = 7.433,
			ja = 10.166
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play423201024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1083"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1083 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1083", 2)

				local var_98_2 = var_98_0.childCount

				for iter_98_0 = 0, var_98_2 - 1 do
					local var_98_3 = var_98_0:GetChild(iter_98_0)

					if var_98_3.name == "split_7" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_4 then
				local var_98_5 = (arg_95_1.time_ - var_98_1) / var_98_4
				local var_98_6 = Vector3.New(-440, -345, -345)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1083, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_98_7 = 0
			local var_98_8 = 0.725

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_9 = arg_95_1:FormatText(StoryNameCfg[1332].name)

				arg_95_1.leftNameTxt_.text = var_98_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(423201023)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_12 = 29
				local var_98_13 = utf8.len(var_98_11)
				local var_98_14 = var_98_12 <= 0 and var_98_8 or var_98_8 * (var_98_13 / var_98_12)

				if var_98_14 > 0 and var_98_8 < var_98_14 then
					arg_95_1.talkMaxDuration = var_98_14

					if var_98_14 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_7
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201023", "story_v_out_423201.awb") ~= 0 then
					local var_98_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201023", "story_v_out_423201.awb") / 1000

					if var_98_15 + var_98_7 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_15 + var_98_7
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_423201", "423201023", "story_v_out_423201.awb")

						arg_95_1:RecordAudio("423201023", var_98_16)
						arg_95_1:RecordAudio("423201023", var_98_16)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_423201", "423201023", "story_v_out_423201.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_423201", "423201023", "story_v_out_423201.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_17 = math.max(var_98_8, arg_95_1.talkMaxDuration)

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_17 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_7) / var_98_17

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_7 + var_98_17 and arg_95_1.time_ < var_98_7 + var_98_17 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423201024
		arg_99_1.duration_ = 5.63

		local var_99_0 = {
			zh = 5.233,
			ja = 5.633
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play423201025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["3054"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps3054 == nil then
				arg_99_1.var_.actorSpriteComps3054 = var_102_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_2 = 0.2

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.actorSpriteComps3054 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.actorSpriteComps3054 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_102_3 then
						if arg_99_1.isInRecall_ then
							iter_102_3.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps3054 = nil
			end

			local var_102_8 = arg_99_1.actors_["1083"]
			local var_102_9 = 0

			if var_102_9 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps1083 == nil then
				arg_99_1.var_.actorSpriteComps1083 = var_102_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_10 = 0.2

			if var_102_9 <= arg_99_1.time_ and arg_99_1.time_ < var_102_9 + var_102_10 and not isNil(var_102_8) then
				local var_102_11 = (arg_99_1.time_ - var_102_9) / var_102_10

				if arg_99_1.var_.actorSpriteComps1083 then
					for iter_102_4, iter_102_5 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_99_1.time_ >= var_102_9 + var_102_10 and arg_99_1.time_ < var_102_9 + var_102_10 + arg_102_0 and not isNil(var_102_8) and arg_99_1.var_.actorSpriteComps1083 then
				for iter_102_6, iter_102_7 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_102_7 then
						if arg_99_1.isInRecall_ then
							iter_102_7.color = arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_102_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1083 = nil
			end

			local var_102_16 = arg_99_1.actors_["3054"].transform
			local var_102_17 = 0

			if var_102_17 < arg_99_1.time_ and arg_99_1.time_ <= var_102_17 + arg_102_0 then
				arg_99_1.var_.moveOldPos3054 = var_102_16.localPosition
				var_102_16.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("3054", 4)

				local var_102_18 = var_102_16.childCount

				for iter_102_8 = 0, var_102_18 - 1 do
					local var_102_19 = var_102_16:GetChild(iter_102_8)

					if var_102_19.name == "" or not string.find(var_102_19.name, "split") then
						var_102_19.gameObject:SetActive(true)
					else
						var_102_19.gameObject:SetActive(false)
					end
				end
			end

			local var_102_20 = 0.001

			if var_102_17 <= arg_99_1.time_ and arg_99_1.time_ < var_102_17 + var_102_20 then
				local var_102_21 = (arg_99_1.time_ - var_102_17) / var_102_20
				local var_102_22 = Vector3.New(390, -275, -280)

				var_102_16.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos3054, var_102_22, var_102_21)
			end

			if arg_99_1.time_ >= var_102_17 + var_102_20 and arg_99_1.time_ < var_102_17 + var_102_20 + arg_102_0 then
				var_102_16.localPosition = Vector3.New(390, -275, -280)
			end

			local var_102_23 = 0
			local var_102_24 = 0.5

			if var_102_23 < arg_99_1.time_ and arg_99_1.time_ <= var_102_23 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_25 = arg_99_1:FormatText(StoryNameCfg[1339].name)

				arg_99_1.leftNameTxt_.text = var_102_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_26 = arg_99_1:GetWordFromCfg(423201024)
				local var_102_27 = arg_99_1:FormatText(var_102_26.content)

				arg_99_1.text_.text = var_102_27

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_28 = 20
				local var_102_29 = utf8.len(var_102_27)
				local var_102_30 = var_102_28 <= 0 and var_102_24 or var_102_24 * (var_102_29 / var_102_28)

				if var_102_30 > 0 and var_102_24 < var_102_30 then
					arg_99_1.talkMaxDuration = var_102_30

					if var_102_30 + var_102_23 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_30 + var_102_23
					end
				end

				arg_99_1.text_.text = var_102_27
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201024", "story_v_out_423201.awb") ~= 0 then
					local var_102_31 = manager.audio:GetVoiceLength("story_v_out_423201", "423201024", "story_v_out_423201.awb") / 1000

					if var_102_31 + var_102_23 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_31 + var_102_23
					end

					if var_102_26.prefab_name ~= "" and arg_99_1.actors_[var_102_26.prefab_name] ~= nil then
						local var_102_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_26.prefab_name].transform, "story_v_out_423201", "423201024", "story_v_out_423201.awb")

						arg_99_1:RecordAudio("423201024", var_102_32)
						arg_99_1:RecordAudio("423201024", var_102_32)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_423201", "423201024", "story_v_out_423201.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_423201", "423201024", "story_v_out_423201.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_33 = math.max(var_102_24, arg_99_1.talkMaxDuration)

			if var_102_23 <= arg_99_1.time_ and arg_99_1.time_ < var_102_23 + var_102_33 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_23) / var_102_33

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_23 + var_102_33 and arg_99_1.time_ < var_102_23 + var_102_33 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play423201025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423201025
		arg_103_1.duration_ = 3.63

		local var_103_0 = {
			zh = 3.633,
			ja = 2.433
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
				arg_103_0:Play423201026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["3054"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos3054 = var_106_0.localPosition
				var_106_0.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("3054", 4)

				local var_106_2 = var_106_0.childCount

				for iter_106_0 = 0, var_106_2 - 1 do
					local var_106_3 = var_106_0:GetChild(iter_106_0)

					if var_106_3.name == "split_3" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_4 then
				local var_106_5 = (arg_103_1.time_ - var_106_1) / var_106_4
				local var_106_6 = Vector3.New(390, -275, -280)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos3054, var_106_6, var_106_5)
			end

			if arg_103_1.time_ >= var_106_1 + var_106_4 and arg_103_1.time_ < var_106_1 + var_106_4 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(390, -275, -280)
			end

			local var_106_7 = 0
			local var_106_8 = 0.4

			if var_106_7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_9 = arg_103_1:FormatText(StoryNameCfg[1339].name)

				arg_103_1.leftNameTxt_.text = var_106_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(423201025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_12 = 16
				local var_106_13 = utf8.len(var_106_11)
				local var_106_14 = var_106_12 <= 0 and var_106_8 or var_106_8 * (var_106_13 / var_106_12)

				if var_106_14 > 0 and var_106_8 < var_106_14 then
					arg_103_1.talkMaxDuration = var_106_14

					if var_106_14 + var_106_7 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_7
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201025", "story_v_out_423201.awb") ~= 0 then
					local var_106_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201025", "story_v_out_423201.awb") / 1000

					if var_106_15 + var_106_7 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_15 + var_106_7
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_423201", "423201025", "story_v_out_423201.awb")

						arg_103_1:RecordAudio("423201025", var_106_16)
						arg_103_1:RecordAudio("423201025", var_106_16)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_423201", "423201025", "story_v_out_423201.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_423201", "423201025", "story_v_out_423201.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_17 = math.max(var_106_8, arg_103_1.talkMaxDuration)

			if var_106_7 <= arg_103_1.time_ and arg_103_1.time_ < var_106_7 + var_106_17 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_7) / var_106_17

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_7 + var_106_17 and arg_103_1.time_ < var_106_7 + var_106_17 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423201026
		arg_107_1.duration_ = 5.7

		local var_107_0 = {
			zh = 5.7,
			ja = 5.2
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
				arg_107_0:Play423201027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1083"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1083 == nil then
				arg_107_1.var_.actorSpriteComps1083 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps1083 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps1083 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1083 = nil
			end

			local var_110_8 = arg_107_1.actors_["3054"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps3054 == nil then
				arg_107_1.var_.actorSpriteComps3054 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.2

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps3054 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps3054 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps3054 = nil
			end

			local var_110_16 = arg_107_1.actors_["1083"].transform
			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.var_.moveOldPos1083 = var_110_16.localPosition
				var_110_16.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1083", 2)

				local var_110_18 = var_110_16.childCount

				for iter_110_8 = 0, var_110_18 - 1 do
					local var_110_19 = var_110_16:GetChild(iter_110_8)

					if var_110_19.name == "" or not string.find(var_110_19.name, "split") then
						var_110_19.gameObject:SetActive(true)
					else
						var_110_19.gameObject:SetActive(false)
					end
				end
			end

			local var_110_20 = 0.001

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_20 then
				local var_110_21 = (arg_107_1.time_ - var_110_17) / var_110_20
				local var_110_22 = Vector3.New(-440, -345, -345)

				var_110_16.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1083, var_110_22, var_110_21)
			end

			if arg_107_1.time_ >= var_110_17 + var_110_20 and arg_107_1.time_ < var_110_17 + var_110_20 + arg_110_0 then
				var_110_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_110_23 = 0
			local var_110_24 = 0.65

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[1332].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(423201026)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 26
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201026", "story_v_out_423201.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_423201", "423201026", "story_v_out_423201.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_423201", "423201026", "story_v_out_423201.awb")

						arg_107_1:RecordAudio("423201026", var_110_32)
						arg_107_1:RecordAudio("423201026", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_423201", "423201026", "story_v_out_423201.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_423201", "423201026", "story_v_out_423201.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423201027
		arg_111_1.duration_ = 9.77

		local var_111_0 = {
			zh = 8.133,
			ja = 9.766
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
				arg_111_0:Play423201028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1083"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1083 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1083", 2)

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
				local var_114_6 = Vector3.New(-440, -345, -345)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1083, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_114_7 = 0
			local var_114_8 = 0.95

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_9 = arg_111_1:FormatText(StoryNameCfg[1332].name)

				arg_111_1.leftNameTxt_.text = var_114_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(423201027)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_12 = 38
				local var_114_13 = utf8.len(var_114_11)
				local var_114_14 = var_114_12 <= 0 and var_114_8 or var_114_8 * (var_114_13 / var_114_12)

				if var_114_14 > 0 and var_114_8 < var_114_14 then
					arg_111_1.talkMaxDuration = var_114_14

					if var_114_14 + var_114_7 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_7
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201027", "story_v_out_423201.awb") ~= 0 then
					local var_114_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201027", "story_v_out_423201.awb") / 1000

					if var_114_15 + var_114_7 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_7
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_423201", "423201027", "story_v_out_423201.awb")

						arg_111_1:RecordAudio("423201027", var_114_16)
						arg_111_1:RecordAudio("423201027", var_114_16)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423201", "423201027", "story_v_out_423201.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423201", "423201027", "story_v_out_423201.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_17 = math.max(var_114_8, arg_111_1.talkMaxDuration)

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_17 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_7) / var_114_17

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_7 + var_114_17 and arg_111_1.time_ < var_114_7 + var_114_17 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423201028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play423201029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1083"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1083 == nil then
				arg_115_1.var_.actorSpriteComps1083 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps1083 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor2.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor2.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor2.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 0.5, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps1083 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1083 = nil
			end

			local var_118_8 = arg_115_1.actors_["3054"].transform
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.var_.moveOldPos3054 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("3054", 7)

				local var_118_10 = var_118_8.childCount

				for iter_118_4 = 0, var_118_10 - 1 do
					local var_118_11 = var_118_8:GetChild(iter_118_4)

					if var_118_11.name == "" or not string.find(var_118_11.name, "split") then
						var_118_11.gameObject:SetActive(true)
					else
						var_118_11.gameObject:SetActive(false)
					end
				end
			end

			local var_118_12 = 0.001

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_12 then
				local var_118_13 = (arg_115_1.time_ - var_118_9) / var_118_12
				local var_118_14 = Vector3.New(0, -2000, 0)

				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos3054, var_118_14, var_118_13)
			end

			if arg_115_1.time_ >= var_118_9 + var_118_12 and arg_115_1.time_ < var_118_9 + var_118_12 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_15 = arg_115_1.actors_["1083"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos1083 = var_118_15.localPosition
				var_118_15.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1083", 7)

				local var_118_17 = var_118_15.childCount

				for iter_118_5 = 0, var_118_17 - 1 do
					local var_118_18 = var_118_15:GetChild(iter_118_5)

					if var_118_18.name == "" or not string.find(var_118_18.name, "split") then
						var_118_18.gameObject:SetActive(true)
					else
						var_118_18.gameObject:SetActive(false)
					end
				end
			end

			local var_118_19 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_19 then
				local var_118_20 = (arg_115_1.time_ - var_118_16) / var_118_19
				local var_118_21 = Vector3.New(0, -2000, 0)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1083, var_118_21, var_118_20)
			end

			if arg_115_1.time_ >= var_118_16 + var_118_19 and arg_115_1.time_ < var_118_16 + var_118_19 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_118_22 = 0.2
			local var_118_23 = 1

			if var_118_22 < arg_115_1.time_ and arg_115_1.time_ <= var_118_22 + arg_118_0 then
				local var_118_24 = "play"
				local var_118_25 = "effect"

				arg_115_1:AudioAction(var_118_24, var_118_25, "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_118_26 = 0
			local var_118_27 = 1.775

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_28 = arg_115_1:GetWordFromCfg(423201028)
				local var_118_29 = arg_115_1:FormatText(var_118_28.content)

				arg_115_1.text_.text = var_118_29

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_30 = 71
				local var_118_31 = utf8.len(var_118_29)
				local var_118_32 = var_118_30 <= 0 and var_118_27 or var_118_27 * (var_118_31 / var_118_30)

				if var_118_32 > 0 and var_118_27 < var_118_32 then
					arg_115_1.talkMaxDuration = var_118_32

					if var_118_32 + var_118_26 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_32 + var_118_26
					end
				end

				arg_115_1.text_.text = var_118_29
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_33 = math.max(var_118_27, arg_115_1.talkMaxDuration)

			if var_118_26 <= arg_115_1.time_ and arg_115_1.time_ < var_118_26 + var_118_33 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_26) / var_118_33

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_26 + var_118_33 and arg_115_1.time_ < var_118_26 + var_118_33 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play423201029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423201029
		arg_119_1.duration_ = 6.23

		local var_119_0 = {
			zh = 6.233,
			ja = 4.4
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
				arg_119_0:Play423201030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["3054"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps3054 == nil then
				arg_119_1.var_.actorSpriteComps3054 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps3054 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps3054 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps3054 = nil
			end

			local var_122_8 = arg_119_1.actors_["3054"].transform
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.var_.moveOldPos3054 = var_122_8.localPosition
				var_122_8.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("3054", 3)

				local var_122_10 = var_122_8.childCount

				for iter_122_4 = 0, var_122_10 - 1 do
					local var_122_11 = var_122_8:GetChild(iter_122_4)

					if var_122_11.name == "" or not string.find(var_122_11.name, "split") then
						var_122_11.gameObject:SetActive(true)
					else
						var_122_11.gameObject:SetActive(false)
					end
				end
			end

			local var_122_12 = 0.001

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_12 then
				local var_122_13 = (arg_119_1.time_ - var_122_9) / var_122_12
				local var_122_14 = Vector3.New(0, -275, -280)

				var_122_8.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos3054, var_122_14, var_122_13)
			end

			if arg_119_1.time_ >= var_122_9 + var_122_12 and arg_119_1.time_ < var_122_9 + var_122_12 + arg_122_0 then
				var_122_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_122_15 = 0
			local var_122_16 = 0.5

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[1339].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(423201029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201029", "story_v_out_423201.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_out_423201", "423201029", "story_v_out_423201.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_out_423201", "423201029", "story_v_out_423201.awb")

						arg_119_1:RecordAudio("423201029", var_122_24)
						arg_119_1:RecordAudio("423201029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_423201", "423201029", "story_v_out_423201.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_423201", "423201029", "story_v_out_423201.awb")
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
				actorName = "3054",
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
	Play423201030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 423201030
		arg_123_1.duration_ = 7.13

		local var_123_0 = {
			zh = 7.133,
			ja = 6.6
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
				arg_123_0:Play423201031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["3054"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos3054 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("3054", 3)

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
				local var_126_6 = Vector3.New(0, -275, -280)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos3054, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_126_7 = 0
			local var_126_8 = 0.55

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_9 = arg_123_1:FormatText(StoryNameCfg[1339].name)

				arg_123_1.leftNameTxt_.text = var_126_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(423201030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 21
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_8 or var_126_8 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_8 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201030", "story_v_out_423201.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_423201", "423201030", "story_v_out_423201.awb") / 1000

					if var_126_15 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_7
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_423201", "423201030", "story_v_out_423201.awb")

						arg_123_1:RecordAudio("423201030", var_126_16)
						arg_123_1:RecordAudio("423201030", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_423201", "423201030", "story_v_out_423201.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_423201", "423201030", "story_v_out_423201.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_17 and arg_123_1.time_ < var_126_7 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423201031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423201031
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play423201032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "SS2305"

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
				local var_130_5 = arg_127_1.bgs_.SS2305

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
					if iter_130_0 ~= "SS2305" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_16 = 4

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_17 = 0.3

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_18 = 0

			if var_130_18 < arg_127_1.time_ and arg_127_1.time_ <= var_130_18 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_19 = 2

			if var_130_18 <= arg_127_1.time_ and arg_127_1.time_ < var_130_18 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_18) / var_130_19
				local var_130_21 = Color.New(0, 0, 0)

				var_130_21.a = Mathf.Lerp(0, 1, var_130_20)
				arg_127_1.mask_.color = var_130_21
			end

			if arg_127_1.time_ >= var_130_18 + var_130_19 and arg_127_1.time_ < var_130_18 + var_130_19 + arg_130_0 then
				local var_130_22 = Color.New(0, 0, 0)

				var_130_22.a = 1
				arg_127_1.mask_.color = var_130_22
			end

			local var_130_23 = 2

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_24 = 2

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24
				local var_130_26 = Color.New(0, 0, 0)

				var_130_26.a = Mathf.Lerp(1, 0, var_130_25)
				arg_127_1.mask_.color = var_130_26
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 then
				local var_130_27 = Color.New(0, 0, 0)
				local var_130_28 = 0

				arg_127_1.mask_.enabled = false
				var_130_27.a = var_130_28
				arg_127_1.mask_.color = var_130_27
			end

			local var_130_29 = arg_127_1.bgs_.SS2305.transform
			local var_130_30 = 2

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.var_.moveOldPosSS2305 = var_130_29.localPosition
			end

			local var_130_31 = 4.5

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_31 then
				local var_130_32 = (arg_127_1.time_ - var_130_30) / var_130_31
				local var_130_33 = Vector3.New(0, 1, 10)

				var_130_29.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPosSS2305, var_130_33, var_130_32)
			end

			if arg_127_1.time_ >= var_130_30 + var_130_31 and arg_127_1.time_ < var_130_30 + var_130_31 + arg_130_0 then
				var_130_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_130_34 = 4

			if var_130_34 < arg_127_1.time_ and arg_127_1.time_ <= var_130_34 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_35 = 2.5

			if arg_127_1.time_ >= var_130_34 + var_130_35 and arg_127_1.time_ < var_130_34 + var_130_35 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_36 = 4.025
			local var_130_37 = 1

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 then
				local var_130_38 = "play"
				local var_130_39 = "effect"

				arg_127_1:AudioAction(var_130_38, var_130_39, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_130_40 = arg_127_1.actors_["3054"].transform
			local var_130_41 = 1.966

			if var_130_41 < arg_127_1.time_ and arg_127_1.time_ <= var_130_41 + arg_130_0 then
				arg_127_1.var_.moveOldPos3054 = var_130_40.localPosition
				var_130_40.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("3054", 7)

				local var_130_42 = var_130_40.childCount

				for iter_130_2 = 0, var_130_42 - 1 do
					local var_130_43 = var_130_40:GetChild(iter_130_2)

					if var_130_43.name == "" or not string.find(var_130_43.name, "split") then
						var_130_43.gameObject:SetActive(true)
					else
						var_130_43.gameObject:SetActive(false)
					end
				end
			end

			local var_130_44 = 0.001

			if var_130_41 <= arg_127_1.time_ and arg_127_1.time_ < var_130_41 + var_130_44 then
				local var_130_45 = (arg_127_1.time_ - var_130_41) / var_130_44
				local var_130_46 = Vector3.New(0, -2000, 0)

				var_130_40.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos3054, var_130_46, var_130_45)
			end

			if arg_127_1.time_ >= var_130_41 + var_130_44 and arg_127_1.time_ < var_130_41 + var_130_44 + arg_130_0 then
				var_130_40.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_47 = 1.56666666666667
			local var_130_48 = 1

			if var_130_47 < arg_127_1.time_ and arg_127_1.time_ <= var_130_47 + arg_130_0 then
				local var_130_49 = "play"
				local var_130_50 = "effect"

				arg_127_1:AudioAction(var_130_49, var_130_50, "se_story_144", "se_story_144_bgm_intense_argue_down", "")
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_51 = 4
			local var_130_52 = 1.025

			if var_130_51 < arg_127_1.time_ and arg_127_1.time_ <= var_130_51 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_53 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_53:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_54 = arg_127_1:GetWordFromCfg(423201031)
				local var_130_55 = arg_127_1:FormatText(var_130_54.content)

				arg_127_1.text_.text = var_130_55

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_56 = 41
				local var_130_57 = utf8.len(var_130_55)
				local var_130_58 = var_130_56 <= 0 and var_130_52 or var_130_52 * (var_130_57 / var_130_56)

				if var_130_58 > 0 and var_130_52 < var_130_58 then
					arg_127_1.talkMaxDuration = var_130_58
					var_130_51 = var_130_51 + 0.3

					if var_130_58 + var_130_51 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_58 + var_130_51
					end
				end

				arg_127_1.text_.text = var_130_55
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_59 = var_130_51 + 0.3
			local var_130_60 = math.max(var_130_52, arg_127_1.talkMaxDuration)

			if var_130_59 <= arg_127_1.time_ and arg_127_1.time_ < var_130_59 + var_130_60 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_59) / var_130_60

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_59 + var_130_60 and arg_127_1.time_ < var_130_59 + var_130_60 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2305",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 4.5,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play423201032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423201032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play423201033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.075

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(423201032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 43
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423201033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423201033
		arg_137_1.duration_ = 6.8

		local var_137_0 = {
			zh = 5.5,
			ja = 6.8
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
				arg_137_0:Play423201034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.475

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[1332].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(423201033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201033", "story_v_out_423201.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201033", "story_v_out_423201.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_423201", "423201033", "story_v_out_423201.awb")

						arg_137_1:RecordAudio("423201033", var_140_9)
						arg_137_1:RecordAudio("423201033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_423201", "423201033", "story_v_out_423201.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_423201", "423201033", "story_v_out_423201.awb")
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
	Play423201034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423201034
		arg_141_1.duration_ = 5.03

		local var_141_0 = {
			zh = 5.033,
			ja = 4.433
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
				arg_141_0:Play423201035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.45

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[1339].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(423201034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201034", "story_v_out_423201.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201034", "story_v_out_423201.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_423201", "423201034", "story_v_out_423201.awb")

						arg_141_1:RecordAudio("423201034", var_144_9)
						arg_141_1:RecordAudio("423201034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_423201", "423201034", "story_v_out_423201.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_423201", "423201034", "story_v_out_423201.awb")
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
	Play423201035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423201035
		arg_145_1.duration_ = 10.23

		local var_145_0 = {
			zh = 7.633,
			ja = 10.233
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play423201036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.825

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1332].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(423201035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 33
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201035", "story_v_out_423201.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201035", "story_v_out_423201.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_423201", "423201035", "story_v_out_423201.awb")

						arg_145_1:RecordAudio("423201035", var_148_9)
						arg_145_1:RecordAudio("423201035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423201", "423201035", "story_v_out_423201.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423201", "423201035", "story_v_out_423201.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play423201036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423201036
		arg_149_1.duration_ = 7.2

		local var_149_0 = {
			zh = 7.2,
			ja = 5.233
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
				arg_149_0:Play423201037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.55

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[1339].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(423201036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201036", "story_v_out_423201.awb") ~= 0 then
					local var_152_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201036", "story_v_out_423201.awb") / 1000

					if var_152_8 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_0
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_423201", "423201036", "story_v_out_423201.awb")

						arg_149_1:RecordAudio("423201036", var_152_9)
						arg_149_1:RecordAudio("423201036", var_152_9)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_423201", "423201036", "story_v_out_423201.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_423201", "423201036", "story_v_out_423201.awb")
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
	Play423201037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423201037
		arg_153_1.duration_ = 8.87

		local var_153_0 = {
			zh = 7.133,
			ja = 8.866
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
				arg_153_0:Play423201038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.75

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[1332].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(423201037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201037", "story_v_out_423201.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201037", "story_v_out_423201.awb") / 1000

					if var_156_8 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_0
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_423201", "423201037", "story_v_out_423201.awb")

						arg_153_1:RecordAudio("423201037", var_156_9)
						arg_153_1:RecordAudio("423201037", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423201", "423201037", "story_v_out_423201.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423201", "423201037", "story_v_out_423201.awb")
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
	Play423201038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423201038
		arg_157_1.duration_ = 5.5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play423201039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.bgs_.SS2305.transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPosSS2305 = var_160_0.localPosition
			end

			local var_160_2 = 3.5

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(4, 3.5, -3)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosSS2305, var_160_4, var_160_3)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(4, 3.5, -3)
			end

			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = false

				arg_157_1:SetGaussion(false)
			end

			local var_160_6 = 1

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6
				local var_160_8 = Color.New(1, 1, 1)

				var_160_8.a = Mathf.Lerp(1, 0, var_160_7)
				arg_157_1.mask_.color = var_160_8
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 then
				local var_160_9 = Color.New(1, 1, 1)
				local var_160_10 = 0

				arg_157_1.mask_.enabled = false
				var_160_9.a = var_160_10
				arg_157_1.mask_.color = var_160_9
			end

			local var_160_11 = 0
			local var_160_12 = 1

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				local var_160_13 = "play"
				local var_160_14 = "effect"

				arg_157_1:AudioAction(var_160_13, var_160_14, "se_story_16", "se_story_16_whoosh", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_15 = 0.5
			local var_160_16 = 1.45

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_17 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_17:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(423201038)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 58
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22
					var_160_15 = var_160_15 + 0.3

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_23 = var_160_15 + 0.3
			local var_160_24 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_23) / var_160_24

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2305",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(4, 3.5, -2.5),
					endPos = Vector3.New(4, 3.5, -3),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play423201039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423201039
		arg_163_1.duration_ = 3.4

		local var_163_0 = {
			zh = 3.4,
			ja = 2.566
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
				arg_163_0:Play423201040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.3

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[1339].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(423201039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201039", "story_v_out_423201.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201039", "story_v_out_423201.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_423201", "423201039", "story_v_out_423201.awb")

						arg_163_1:RecordAudio("423201039", var_166_9)
						arg_163_1:RecordAudio("423201039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_423201", "423201039", "story_v_out_423201.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_423201", "423201039", "story_v_out_423201.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play423201040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423201040
		arg_167_1.duration_ = 4.27

		local var_167_0 = {
			zh = 3,
			ja = 4.266
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
				arg_167_0:Play423201041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.3

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[1332].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_7")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(423201040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201040", "story_v_out_423201.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201040", "story_v_out_423201.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_423201", "423201040", "story_v_out_423201.awb")

						arg_167_1:RecordAudio("423201040", var_170_9)
						arg_167_1:RecordAudio("423201040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_423201", "423201040", "story_v_out_423201.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_423201", "423201040", "story_v_out_423201.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423201041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423201041
		arg_171_1.duration_ = 4.67

		local var_171_0 = {
			zh = 3.566,
			ja = 4.666
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
				arg_171_0:Play423201042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.35

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1332].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_7")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:GetWordFromCfg(423201041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201041", "story_v_out_423201.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201041", "story_v_out_423201.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_423201", "423201041", "story_v_out_423201.awb")

						arg_171_1:RecordAudio("423201041", var_174_9)
						arg_171_1:RecordAudio("423201041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_423201", "423201041", "story_v_out_423201.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_423201", "423201041", "story_v_out_423201.awb")
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
	Play423201042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423201042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play423201043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.95

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_2 = arg_175_1:GetWordFromCfg(423201042)
				local var_178_3 = arg_175_1:FormatText(var_178_2.content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 38
				local var_178_5 = utf8.len(var_178_3)
				local var_178_6 = var_178_4 <= 0 and var_178_1 or var_178_1 * (var_178_5 / var_178_4)

				if var_178_6 > 0 and var_178_1 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_7 and arg_175_1.time_ < var_178_0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play423201043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423201043
		arg_179_1.duration_ = 6.7

		local var_179_0 = {
			zh = 6.7,
			ja = 4.766
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play423201044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.425

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[1339].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(423201043)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 17
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201043", "story_v_out_423201.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201043", "story_v_out_423201.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_423201", "423201043", "story_v_out_423201.awb")

						arg_179_1:RecordAudio("423201043", var_182_9)
						arg_179_1:RecordAudio("423201043", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423201", "423201043", "story_v_out_423201.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423201", "423201043", "story_v_out_423201.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play423201044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423201044
		arg_183_1.duration_ = 5.43

		local var_183_0 = {
			zh = 5.433,
			ja = 4.866
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
				arg_183_0:Play423201045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.35

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[1339].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(423201044)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 14
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423201", "423201044", "story_v_out_423201.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_423201", "423201044", "story_v_out_423201.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_423201", "423201044", "story_v_out_423201.awb")

						arg_183_1:RecordAudio("423201044", var_186_9)
						arg_183_1:RecordAudio("423201044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_423201", "423201044", "story_v_out_423201.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_423201", "423201044", "story_v_out_423201.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play423201045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423201045
		arg_187_1.duration_ = 5.5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423201046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.1
			local var_190_1 = 1

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				local var_190_2 = "play"
				local var_190_3 = "effect"

				arg_187_1:AudioAction(var_190_2, var_190_3, "se_story_144", "se_story_144_bell01", "")
			end

			local var_190_4 = 0

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = false

				arg_187_1:SetGaussion(false)
			end

			local var_190_5 = 0.5

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_5 then
				local var_190_6 = (arg_187_1.time_ - var_190_4) / var_190_5
				local var_190_7 = Color.New(1, 1, 1)

				var_190_7.a = Mathf.Lerp(1, 0, var_190_6)
				arg_187_1.mask_.color = var_190_7
			end

			if arg_187_1.time_ >= var_190_4 + var_190_5 and arg_187_1.time_ < var_190_4 + var_190_5 + arg_190_0 then
				local var_190_8 = Color.New(1, 1, 1)
				local var_190_9 = 0

				arg_187_1.mask_.enabled = false
				var_190_8.a = var_190_9
				arg_187_1.mask_.color = var_190_8
			end

			local var_190_10 = arg_187_1.bgs_.SS2305.transform
			local var_190_11 = 0

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.var_.moveOldPosSS2305 = var_190_10.localPosition
			end

			local var_190_12 = 2.13333333333333

			if var_190_11 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_12 then
				local var_190_13 = (arg_187_1.time_ - var_190_11) / var_190_12
				local var_190_14 = Vector3.New(0, 1, 10)

				var_190_10.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPosSS2305, var_190_14, var_190_13)
			end

			if arg_187_1.time_ >= var_190_11 + var_190_12 and arg_187_1.time_ < var_190_11 + var_190_12 + arg_190_0 then
				var_190_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_15 = 0.5
			local var_190_16 = 0.775

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_17 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_17:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(423201045)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 31
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22
					var_190_15 = var_190_15 + 0.3

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_23 = var_190_15 + 0.3
			local var_190_24 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_23 <= arg_187_1.time_ and arg_187_1.time_ < var_190_23 + var_190_24 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_23) / var_190_24

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_23 + var_190_24 and arg_187_1.time_ < var_190_23 + var_190_24 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2305",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play423201046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 423201046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play423201047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.825

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(423201046)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 33
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play423201047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 423201047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play423201048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.925

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

				local var_200_2 = arg_197_1:GetWordFromCfg(423201047)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 37
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
	Play423201048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 423201048
		arg_201_1.duration_ = 5.5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
			arg_201_1.auto_ = false
		end

		function arg_201_1.playNext_(arg_203_0)
			arg_201_1.onStoryFinished_()
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.325
			local var_204_1 = 1

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				local var_204_2 = "play"
				local var_204_3 = "effect"

				arg_201_1:AudioAction(var_204_2, var_204_3, "se_story_1311", "se_story_1311_thunder01", "")
			end

			local var_204_4 = 0.125

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_5 = 0.1

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_5 then
				local var_204_6 = (arg_201_1.time_ - var_204_4) / var_204_5
				local var_204_7 = Color.New(1, 1, 1)

				var_204_7.a = Mathf.Lerp(1, 0, var_204_6)
				arg_201_1.mask_.color = var_204_7
			end

			if arg_201_1.time_ >= var_204_4 + var_204_5 and arg_201_1.time_ < var_204_4 + var_204_5 + arg_204_0 then
				local var_204_8 = Color.New(1, 1, 1)
				local var_204_9 = 0

				arg_201_1.mask_.enabled = false
				var_204_8.a = var_204_9
				arg_201_1.mask_.color = var_204_8
			end

			local var_204_10 = 0.225

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_11 = 0.1

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11
				local var_204_13 = Color.New(1, 1, 1)

				var_204_13.a = Mathf.Lerp(1, 0, var_204_12)
				arg_201_1.mask_.color = var_204_13
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 then
				local var_204_14 = Color.New(1, 1, 1)
				local var_204_15 = 0

				arg_201_1.mask_.enabled = false
				var_204_14.a = var_204_15
				arg_201_1.mask_.color = var_204_14
			end

			local var_204_16 = 0.325

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_17 = 0.1

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_17 then
				local var_204_18 = (arg_201_1.time_ - var_204_16) / var_204_17
				local var_204_19 = Color.New(1, 1, 1)

				var_204_19.a = Mathf.Lerp(1, 0, var_204_18)
				arg_201_1.mask_.color = var_204_19
			end

			if arg_201_1.time_ >= var_204_16 + var_204_17 and arg_201_1.time_ < var_204_16 + var_204_17 + arg_204_0 then
				local var_204_20 = Color.New(1, 1, 1)
				local var_204_21 = 0

				arg_201_1.mask_.enabled = false
				var_204_20.a = var_204_21
				arg_201_1.mask_.color = var_204_20
			end

			local var_204_22 = 0.425

			if var_204_22 < arg_201_1.time_ and arg_201_1.time_ <= var_204_22 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_23 = 0.1

			if var_204_22 <= arg_201_1.time_ and arg_201_1.time_ < var_204_22 + var_204_23 then
				local var_204_24 = (arg_201_1.time_ - var_204_22) / var_204_23
				local var_204_25 = Color.New(1, 1, 1)

				var_204_25.a = Mathf.Lerp(1, 0, var_204_24)
				arg_201_1.mask_.color = var_204_25
			end

			if arg_201_1.time_ >= var_204_22 + var_204_23 and arg_201_1.time_ < var_204_22 + var_204_23 + arg_204_0 then
				local var_204_26 = Color.New(1, 1, 1)
				local var_204_27 = 0

				arg_201_1.mask_.enabled = false
				var_204_26.a = var_204_27
				arg_201_1.mask_.color = var_204_26
			end

			local var_204_28 = 0

			if var_204_28 < arg_201_1.time_ and arg_201_1.time_ <= var_204_28 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_29 = 0.325

			if arg_201_1.time_ >= var_204_28 + var_204_29 and arg_201_1.time_ < var_204_28 + var_204_29 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_30 = 0.5
			local var_204_31 = 0.125

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_32 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_32:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(423201048)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 5
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37
					var_204_30 = var_204_30 + 0.3

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_38 = var_204_30 + 0.3
			local var_204_39 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_38 <= arg_201_1.time_ and arg_201_1.time_ < var_204_38 + var_204_39 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_38) / var_204_39

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_38 + var_204_39 and arg_201_1.time_ < var_204_38 + var_204_39 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25j",
		"TextureConfig/Background/I25i",
		"TextureConfig/Background/SS2305"
	},
	voices = {
		"story_v_out_423201.awb"
	}
}
