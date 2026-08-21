return {
	Play410261001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410261001
		arg_1_1.duration_ = 6.53

		local var_1_0 = {
			ja = 6.1,
			CriLanguages = 6.533,
			zh = 6.533
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
				arg_1_0:Play410261002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L01f"

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
				local var_4_5 = arg_1_1.bgs_.L01f

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
					if iter_4_0 ~= "L01f" then
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

			local var_4_22 = "1060"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(var_4_23, arg_1_1.canvasGo_.transform)

					var_4_24.transform:SetSiblingIndex(1)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_25) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_26 = arg_1_1.actors_["1060"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos1060 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1060", 3)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(33.4, -430.8, 6.9)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1060, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_4_33 = arg_1_1.actors_["1060"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1060 == nil then
				arg_1_1.var_.actorSpriteComps1060 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps1060 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_37 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_36)
								local var_4_38 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_36)
								local var_4_39 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_36)

								iter_4_6.color = Color.New(var_4_37, var_4_38, var_4_39)
							else
								local var_4_40 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_36)

								iter_4_6.color = Color.New(var_4_40, var_4_40, var_4_40)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps1060 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1060 = nil
			end

			local var_4_41 = 0
			local var_4_42 = 0.166666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0.3
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.35

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_55 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_55:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[584].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(410261001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 14
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_54 or var_4_54 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_54 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61
					var_4_53 = var_4_53 + 0.3

					if var_4_61 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_53
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261001", "story_v_out_410261.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_410261", "410261001", "story_v_out_410261.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_410261", "410261001", "story_v_out_410261.awb")

						arg_1_1:RecordAudio("410261001", var_4_63)
						arg_1_1:RecordAudio("410261001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410261", "410261001", "story_v_out_410261.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410261", "410261001", "story_v_out_410261.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = var_4_53 + 0.3
			local var_4_65 = math.max(var_4_54, arg_1_1.talkMaxDuration)

			if var_4_64 <= arg_1_1.time_ and arg_1_1.time_ < var_4_64 + var_4_65 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_64) / var_4_65

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_64 + var_4_65 and arg_1_1.time_ < var_4_64 + var_4_65 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410261002
		arg_9_1.duration_ = 10.2

		local var_9_0 = {
			ja = 10.2,
			CriLanguages = 6.9,
			zh = 6.9
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
				arg_9_0:Play410261003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.875

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[584].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(410261002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261002", "story_v_out_410261.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261002", "story_v_out_410261.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_410261", "410261002", "story_v_out_410261.awb")

						arg_9_1:RecordAudio("410261002", var_12_9)
						arg_9_1:RecordAudio("410261002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410261", "410261002", "story_v_out_410261.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410261", "410261002", "story_v_out_410261.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410261003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410261003
		arg_13_1.duration_ = 11.57

		local var_13_0 = {
			ja = 11.566,
			CriLanguages = 7.233,
			zh = 7.233
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
				arg_13_0:Play410261004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1060"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1060 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1060", 3)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(33.4, -430.8, 6.9)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1060, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_16_7 = arg_13_1.actors_["1060"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1060 == nil then
				arg_13_1.var_.actorSpriteComps1060 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps1060 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps1060 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1060 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.925

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_17 = arg_13_1:FormatText(StoryNameCfg[584].name)

				arg_13_1.leftNameTxt_.text = var_16_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_18 = arg_13_1:GetWordFromCfg(410261003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261003", "story_v_out_410261.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_410261", "410261003", "story_v_out_410261.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_410261", "410261003", "story_v_out_410261.awb")

						arg_13_1:RecordAudio("410261003", var_16_24)
						arg_13_1:RecordAudio("410261003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410261", "410261003", "story_v_out_410261.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410261", "410261003", "story_v_out_410261.awb")
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
				actorName = "1060",
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
	Play410261004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410261004
		arg_17_1.duration_ = 15.8

		local var_17_0 = {
			ja = 15.8,
			CriLanguages = 8.333,
			zh = 8.333
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
				arg_17_0:Play410261005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.025

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[584].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(410261004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261004", "story_v_out_410261.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261004", "story_v_out_410261.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_410261", "410261004", "story_v_out_410261.awb")

						arg_17_1:RecordAudio("410261004", var_20_9)
						arg_17_1:RecordAudio("410261004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410261", "410261004", "story_v_out_410261.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410261", "410261004", "story_v_out_410261.awb")
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
	Play410261005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410261005
		arg_21_1.duration_ = 5.1

		local var_21_0 = {
			ja = 5.1,
			CriLanguages = 3.833,
			zh = 3.833
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
				arg_21_0:Play410261006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1060"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1060 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1060", 3)

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
				local var_24_6 = Vector3.New(33.4, -430.8, 6.9)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1060, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_24_7 = arg_21_1.actors_["1060"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 == nil then
				arg_21_1.var_.actorSpriteComps1060 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps1060 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1060 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1060 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.525

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[584].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410261005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261005", "story_v_out_410261.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410261", "410261005", "story_v_out_410261.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410261", "410261005", "story_v_out_410261.awb")

						arg_21_1:RecordAudio("410261005", var_24_24)
						arg_21_1:RecordAudio("410261005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410261", "410261005", "story_v_out_410261.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410261", "410261005", "story_v_out_410261.awb")
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
				actorName = "1060",
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
	Play410261006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410261006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410261007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1060"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 7)

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
				local var_28_6 = Vector3.New(0, -2000, -40)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_28_7 = arg_25_1.actors_["1060"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 == nil then
				arg_25_1.var_.actorSpriteComps1060 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1060 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor2.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor2.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor2.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 0.5, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1060 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1060 = nil
			end

			local var_28_15 = 0
			local var_28_16 = 0.875

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(410261006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 35
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410261007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play410261008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.85

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

				local var_32_2 = arg_29_1:GetWordFromCfg(410261007)
				local var_32_3 = arg_29_1:FormatText(var_32_2.content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 34
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
	Play410261008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410261008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410261009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.025

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(410261008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 41
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play410261009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410261009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410261010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.475

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

				local var_40_2 = arg_37_1:GetWordFromCfg(410261009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 59
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
	Play410261010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410261010
		arg_41_1.duration_ = 4.7

		local var_41_0 = {
			ja = 4.7,
			CriLanguages = 2.1,
			zh = 2.1
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
				arg_41_0:Play410261011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "1061"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_44_1) then
					local var_44_2 = Object.Instantiate(var_44_1, arg_41_1.canvasGo_.transform)

					var_44_2.transform:SetSiblingIndex(1)

					var_44_2.name = var_44_0
					var_44_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_[var_44_0] = var_44_2

					local var_44_3 = var_44_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs(var_44_3) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_4 = arg_41_1.actors_["1061"].transform
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = var_44_4.localPosition
				var_44_4.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 2)

				local var_44_6 = var_44_4.childCount

				for iter_44_2 = 0, var_44_6 - 1 do
					local var_44_7 = var_44_4:GetChild(iter_44_2)

					if var_44_7.name == "split_2" or not string.find(var_44_7.name, "split") then
						var_44_7.gameObject:SetActive(true)
					else
						var_44_7.gameObject:SetActive(false)
					end
				end
			end

			local var_44_8 = 0.001

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_8 then
				local var_44_9 = (arg_41_1.time_ - var_44_5) / var_44_8
				local var_44_10 = Vector3.New(-390, -490, 18)

				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, var_44_10, var_44_9)
			end

			if arg_41_1.time_ >= var_44_5 + var_44_8 and arg_41_1.time_ < var_44_5 + var_44_8 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_44_11 = arg_41_1.actors_["1060"].transform
			local var_44_12 = 0

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.var_.moveOldPos1060 = var_44_11.localPosition
				var_44_11.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1060", 4)

				local var_44_13 = var_44_11.childCount

				for iter_44_3 = 0, var_44_13 - 1 do
					local var_44_14 = var_44_11:GetChild(iter_44_3)

					if var_44_14.name == "" or not string.find(var_44_14.name, "split") then
						var_44_14.gameObject:SetActive(true)
					else
						var_44_14.gameObject:SetActive(false)
					end
				end
			end

			local var_44_15 = 0.001

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_15 then
				local var_44_16 = (arg_41_1.time_ - var_44_12) / var_44_15
				local var_44_17 = Vector3.New(420.9, -430.8, 6.9)

				var_44_11.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1060, var_44_17, var_44_16)
			end

			if arg_41_1.time_ >= var_44_12 + var_44_15 and arg_41_1.time_ < var_44_12 + var_44_15 + arg_44_0 then
				var_44_11.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_44_18 = arg_41_1.actors_["1061"]
			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_20 = 0.034

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 and not isNil(var_44_18) then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / var_44_20

				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_22 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor1.r, var_44_21)
								local var_44_23 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor1.g, var_44_21)
								local var_44_24 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor1.b, var_44_21)

								iter_44_5.color = Color.New(var_44_22, var_44_23, var_44_24)
							else
								local var_44_25 = Mathf.Lerp(iter_44_5.color.r, 1, var_44_21)

								iter_44_5.color = Color.New(var_44_25, var_44_25, var_44_25)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 and not isNil(var_44_18) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_26 = arg_41_1.actors_["1060"]
			local var_44_27 = 0

			if var_44_27 < arg_41_1.time_ and arg_41_1.time_ <= var_44_27 + arg_44_0 and not isNil(var_44_26) and arg_41_1.var_.actorSpriteComps1060 == nil then
				arg_41_1.var_.actorSpriteComps1060 = var_44_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_28 = 0.034

			if var_44_27 <= arg_41_1.time_ and arg_41_1.time_ < var_44_27 + var_44_28 and not isNil(var_44_26) then
				local var_44_29 = (arg_41_1.time_ - var_44_27) / var_44_28

				if arg_41_1.var_.actorSpriteComps1060 then
					for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_44_9 then
							if arg_41_1.isInRecall_ then
								local var_44_30 = Mathf.Lerp(iter_44_9.color.r, arg_41_1.hightColor2.r, var_44_29)
								local var_44_31 = Mathf.Lerp(iter_44_9.color.g, arg_41_1.hightColor2.g, var_44_29)
								local var_44_32 = Mathf.Lerp(iter_44_9.color.b, arg_41_1.hightColor2.b, var_44_29)

								iter_44_9.color = Color.New(var_44_30, var_44_31, var_44_32)
							else
								local var_44_33 = Mathf.Lerp(iter_44_9.color.r, 0.5, var_44_29)

								iter_44_9.color = Color.New(var_44_33, var_44_33, var_44_33)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_27 + var_44_28 and arg_41_1.time_ < var_44_27 + var_44_28 + arg_44_0 and not isNil(var_44_26) and arg_41_1.var_.actorSpriteComps1060 then
				for iter_44_10, iter_44_11 in pairs(arg_41_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_44_11 then
						if arg_41_1.isInRecall_ then
							iter_44_11.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1060 = nil
			end

			local var_44_34 = 0
			local var_44_35 = 0.15

			if var_44_34 < arg_41_1.time_ and arg_41_1.time_ <= var_44_34 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_36 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_37 = arg_41_1:GetWordFromCfg(410261010)
				local var_44_38 = arg_41_1:FormatText(var_44_37.content)

				arg_41_1.text_.text = var_44_38

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_39 = 6
				local var_44_40 = utf8.len(var_44_38)
				local var_44_41 = var_44_39 <= 0 and var_44_35 or var_44_35 * (var_44_40 / var_44_39)

				if var_44_41 > 0 and var_44_35 < var_44_41 then
					arg_41_1.talkMaxDuration = var_44_41

					if var_44_41 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_41 + var_44_34
					end
				end

				arg_41_1.text_.text = var_44_38
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261010", "story_v_out_410261.awb") ~= 0 then
					local var_44_42 = manager.audio:GetVoiceLength("story_v_out_410261", "410261010", "story_v_out_410261.awb") / 1000

					if var_44_42 + var_44_34 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_34
					end

					if var_44_37.prefab_name ~= "" and arg_41_1.actors_[var_44_37.prefab_name] ~= nil then
						local var_44_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_37.prefab_name].transform, "story_v_out_410261", "410261010", "story_v_out_410261.awb")

						arg_41_1:RecordAudio("410261010", var_44_43)
						arg_41_1:RecordAudio("410261010", var_44_43)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410261", "410261010", "story_v_out_410261.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410261", "410261010", "story_v_out_410261.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_44 = math.max(var_44_35, arg_41_1.talkMaxDuration)

			if var_44_34 <= arg_41_1.time_ and arg_41_1.time_ < var_44_34 + var_44_44 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_34) / var_44_44

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_34 + var_44_44 and arg_41_1.time_ < var_44_34 + var_44_44 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410261011
		arg_45_1.duration_ = 5.43

		local var_45_0 = {
			ja = 5.433,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_45_0:Play410261012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1060"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1060 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1060", 4)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(420.9, -430.8, 6.9)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1060, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_48_7 = arg_45_1.actors_["1060"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 == nil then
				arg_45_1.var_.actorSpriteComps1060 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps1060 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1060 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1060 = nil
			end

			local var_48_15 = arg_45_1.actors_["1061"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_19 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, var_48_18)
								local var_48_20 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, var_48_18)
								local var_48_21 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, var_48_18)

								iter_48_6.color = Color.New(var_48_19, var_48_20, var_48_21)
							else
								local var_48_22 = Mathf.Lerp(iter_48_6.color.r, 0.5, var_48_18)

								iter_48_6.color = Color.New(var_48_22, var_48_22, var_48_22)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.4

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[584].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410261011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 16
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261011", "story_v_out_410261.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261011", "story_v_out_410261.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410261", "410261011", "story_v_out_410261.awb")

						arg_45_1:RecordAudio("410261011", var_48_32)
						arg_45_1:RecordAudio("410261011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410261", "410261011", "story_v_out_410261.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410261", "410261011", "story_v_out_410261.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410261012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410261013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 7)

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
				local var_52_6 = Vector3.New(0, -2000, 18)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_52_7 = arg_49_1.actors_["1060"].transform
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.var_.moveOldPos1060 = var_52_7.localPosition
				var_52_7.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1060", 7)

				local var_52_9 = var_52_7.childCount

				for iter_52_1 = 0, var_52_9 - 1 do
					local var_52_10 = var_52_7:GetChild(iter_52_1)

					if var_52_10.name == "" or not string.find(var_52_10.name, "split") then
						var_52_10.gameObject:SetActive(true)
					else
						var_52_10.gameObject:SetActive(false)
					end
				end
			end

			local var_52_11 = 0.001

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_8) / var_52_11
				local var_52_13 = Vector3.New(0, -2000, -40)

				var_52_7.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1060, var_52_13, var_52_12)
			end

			if arg_49_1.time_ >= var_52_8 + var_52_11 and arg_49_1.time_ < var_52_8 + var_52_11 + arg_52_0 then
				var_52_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_52_14 = 0
			local var_52_15 = 1

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_16 = arg_49_1:GetWordFromCfg(410261012)
				local var_52_17 = arg_49_1:FormatText(var_52_16.content)

				arg_49_1.text_.text = var_52_17

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_18 = 40
				local var_52_19 = utf8.len(var_52_17)
				local var_52_20 = var_52_18 <= 0 and var_52_15 or var_52_15 * (var_52_19 / var_52_18)

				if var_52_20 > 0 and var_52_15 < var_52_20 then
					arg_49_1.talkMaxDuration = var_52_20

					if var_52_20 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_14
					end
				end

				arg_49_1.text_.text = var_52_17
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_15, arg_49_1.talkMaxDuration)

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_14) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_14 + var_52_21 and arg_49_1.time_ < var_52_14 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410261013
		arg_53_1.duration_ = 9.77

		local var_53_0 = {
			ja = 9.766,
			CriLanguages = 8.266,
			zh = 8.266
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
				arg_53_0:Play410261014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "LZ0209"

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
				local var_56_5 = arg_53_1.bgs_.LZ0209

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
					if iter_56_0 ~= "LZ0209" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_17 = 2

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17
				local var_56_19 = Color.New(0, 0, 0)

				var_56_19.a = Mathf.Lerp(0, 1, var_56_18)
				arg_53_1.mask_.color = var_56_19
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 then
				local var_56_20 = Color.New(0, 0, 0)

				var_56_20.a = 1
				arg_53_1.mask_.color = var_56_20
			end

			local var_56_21 = 2

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_22 = 2

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_22 then
				local var_56_23 = (arg_53_1.time_ - var_56_21) / var_56_22
				local var_56_24 = Color.New(0, 0, 0)

				var_56_24.a = Mathf.Lerp(1, 0, var_56_23)
				arg_53_1.mask_.color = var_56_24
			end

			if arg_53_1.time_ >= var_56_21 + var_56_22 and arg_53_1.time_ < var_56_21 + var_56_22 + arg_56_0 then
				local var_56_25 = Color.New(0, 0, 0)
				local var_56_26 = 0

				arg_53_1.mask_.enabled = false
				var_56_25.a = var_56_26
				arg_53_1.mask_.color = var_56_25
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_27 = 4
			local var_56_28 = 0.4

			if var_56_27 < arg_53_1.time_ and arg_53_1.time_ <= var_56_27 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_29 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_29:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_30 = arg_53_1:FormatText(StoryNameCfg[584].name)

				arg_53_1.leftNameTxt_.text = var_56_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_31 = arg_53_1:GetWordFromCfg(410261013)
				local var_56_32 = arg_53_1:FormatText(var_56_31.content)

				arg_53_1.text_.text = var_56_32

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_33 = 16
				local var_56_34 = utf8.len(var_56_32)
				local var_56_35 = var_56_33 <= 0 and var_56_28 or var_56_28 * (var_56_34 / var_56_33)

				if var_56_35 > 0 and var_56_28 < var_56_35 then
					arg_53_1.talkMaxDuration = var_56_35
					var_56_27 = var_56_27 + 0.3

					if var_56_35 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_35 + var_56_27
					end
				end

				arg_53_1.text_.text = var_56_32
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261013", "story_v_out_410261.awb") ~= 0 then
					local var_56_36 = manager.audio:GetVoiceLength("story_v_out_410261", "410261013", "story_v_out_410261.awb") / 1000

					if var_56_36 + var_56_27 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_36 + var_56_27
					end

					if var_56_31.prefab_name ~= "" and arg_53_1.actors_[var_56_31.prefab_name] ~= nil then
						local var_56_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_31.prefab_name].transform, "story_v_out_410261", "410261013", "story_v_out_410261.awb")

						arg_53_1:RecordAudio("410261013", var_56_37)
						arg_53_1:RecordAudio("410261013", var_56_37)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410261", "410261013", "story_v_out_410261.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410261", "410261013", "story_v_out_410261.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_38 = var_56_27 + 0.3
			local var_56_39 = math.max(var_56_28, arg_53_1.talkMaxDuration)

			if var_56_38 <= arg_53_1.time_ and arg_53_1.time_ < var_56_38 + var_56_39 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_38) / var_56_39

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_38 + var_56_39 and arg_53_1.time_ < var_56_38 + var_56_39 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410261014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 410261014
		arg_59_1.duration_ = 9.83

		local var_59_0 = {
			ja = 9.833,
			CriLanguages = 5.8,
			zh = 5.8
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
				arg_59_0:Play410261015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.5

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[612].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(410261014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 20
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261014", "story_v_out_410261.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261014", "story_v_out_410261.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_410261", "410261014", "story_v_out_410261.awb")

						arg_59_1:RecordAudio("410261014", var_62_9)
						arg_59_1:RecordAudio("410261014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_410261", "410261014", "story_v_out_410261.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_410261", "410261014", "story_v_out_410261.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play410261015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 410261015
		arg_63_1.duration_ = 3.87

		local var_63_0 = {
			ja = 3.866,
			CriLanguages = 2.566,
			zh = 2.566
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
				arg_63_0:Play410261016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.3

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[612].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:GetWordFromCfg(410261015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 12
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261015", "story_v_out_410261.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261015", "story_v_out_410261.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_410261", "410261015", "story_v_out_410261.awb")

						arg_63_1:RecordAudio("410261015", var_66_9)
						arg_63_1:RecordAudio("410261015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_410261", "410261015", "story_v_out_410261.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_410261", "410261015", "story_v_out_410261.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play410261016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 410261016
		arg_67_1.duration_ = 14.57

		local var_67_0 = {
			ja = 14.566,
			CriLanguages = 5.833,
			zh = 5.833
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
				arg_67_0:Play410261017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.675

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[584].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(410261016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 27
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261016", "story_v_out_410261.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261016", "story_v_out_410261.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_410261", "410261016", "story_v_out_410261.awb")

						arg_67_1:RecordAudio("410261016", var_70_9)
						arg_67_1:RecordAudio("410261016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_410261", "410261016", "story_v_out_410261.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_410261", "410261016", "story_v_out_410261.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play410261017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 410261017
		arg_71_1.duration_ = 7.23

		local var_71_0 = {
			ja = 7.233,
			CriLanguages = 5.233,
			zh = 5.233
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
				arg_71_0:Play410261018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.625

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[612].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(410261017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 25
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261017", "story_v_out_410261.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261017", "story_v_out_410261.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_410261", "410261017", "story_v_out_410261.awb")

						arg_71_1:RecordAudio("410261017", var_74_9)
						arg_71_1:RecordAudio("410261017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_410261", "410261017", "story_v_out_410261.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_410261", "410261017", "story_v_out_410261.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play410261018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410261018
		arg_75_1.duration_ = 7.9

		local var_75_0 = {
			ja = 7.9,
			CriLanguages = 3.066,
			zh = 3.066
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
				arg_75_0:Play410261019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.35

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[584].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(410261018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261018", "story_v_out_410261.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261018", "story_v_out_410261.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_410261", "410261018", "story_v_out_410261.awb")

						arg_75_1:RecordAudio("410261018", var_78_9)
						arg_75_1:RecordAudio("410261018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410261", "410261018", "story_v_out_410261.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410261", "410261018", "story_v_out_410261.awb")
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
	Play410261019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410261019
		arg_79_1.duration_ = 11.63

		local var_79_0 = {
			ja = 11.633,
			CriLanguages = 5.4,
			zh = 5.4
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
				arg_79_0:Play410261020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.625

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[612].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(410261019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 25
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261019", "story_v_out_410261.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261019", "story_v_out_410261.awb") / 1000

					if var_82_8 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_0
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_410261", "410261019", "story_v_out_410261.awb")

						arg_79_1:RecordAudio("410261019", var_82_9)
						arg_79_1:RecordAudio("410261019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410261", "410261019", "story_v_out_410261.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410261", "410261019", "story_v_out_410261.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_10 and arg_79_1.time_ < var_82_0 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play410261020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410261020
		arg_83_1.duration_ = 5.23

		local var_83_0 = {
			ja = 5.233,
			CriLanguages = 4.1,
			zh = 4.1
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
				arg_83_0:Play410261021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.45

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[584].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(410261020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 18
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261020", "story_v_out_410261.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261020", "story_v_out_410261.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_410261", "410261020", "story_v_out_410261.awb")

						arg_83_1:RecordAudio("410261020", var_86_9)
						arg_83_1:RecordAudio("410261020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410261", "410261020", "story_v_out_410261.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410261", "410261020", "story_v_out_410261.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play410261021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410261021
		arg_87_1.duration_ = 13.07

		local var_87_0 = {
			ja = 13.066,
			CriLanguages = 5.7,
			zh = 5.7
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
				arg_87_0:Play410261022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.65

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[612].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(410261021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 26
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261021", "story_v_out_410261.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261021", "story_v_out_410261.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_410261", "410261021", "story_v_out_410261.awb")

						arg_87_1:RecordAudio("410261021", var_90_9)
						arg_87_1:RecordAudio("410261021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410261", "410261021", "story_v_out_410261.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410261", "410261021", "story_v_out_410261.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play410261022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410261022
		arg_91_1.duration_ = 14.6

		local var_91_0 = {
			ja = 14.6,
			CriLanguages = 10.5,
			zh = 10.5
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
				arg_91_0:Play410261023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 1.15

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[612].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(410261022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 46
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261022", "story_v_out_410261.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261022", "story_v_out_410261.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_410261", "410261022", "story_v_out_410261.awb")

						arg_91_1:RecordAudio("410261022", var_94_9)
						arg_91_1:RecordAudio("410261022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410261", "410261022", "story_v_out_410261.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410261", "410261022", "story_v_out_410261.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play410261023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410261023
		arg_95_1.duration_ = 16.5

		local var_95_0 = {
			ja = 16.5,
			CriLanguages = 12.333,
			zh = 12.333
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
				arg_95_0:Play410261024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 1.375

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[612].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(410261023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261023", "story_v_out_410261.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261023", "story_v_out_410261.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_410261", "410261023", "story_v_out_410261.awb")

						arg_95_1:RecordAudio("410261023", var_98_9)
						arg_95_1:RecordAudio("410261023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410261", "410261023", "story_v_out_410261.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410261", "410261023", "story_v_out_410261.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play410261024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410261024
		arg_99_1.duration_ = 5.27

		local var_99_0 = {
			ja = 5.266,
			CriLanguages = 3.866,
			zh = 3.866
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
				arg_99_0:Play410261025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.425

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[584].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(410261024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 17
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261024", "story_v_out_410261.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261024", "story_v_out_410261.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_410261", "410261024", "story_v_out_410261.awb")

						arg_99_1:RecordAudio("410261024", var_102_9)
						arg_99_1:RecordAudio("410261024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410261", "410261024", "story_v_out_410261.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410261", "410261024", "story_v_out_410261.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play410261025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410261025
		arg_103_1.duration_ = 4

		local var_103_0 = {
			ja = 4,
			CriLanguages = 1.8,
			zh = 1.8
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
				arg_103_0:Play410261026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.15

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[612].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(410261025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 6
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261025", "story_v_out_410261.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261025", "story_v_out_410261.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_410261", "410261025", "story_v_out_410261.awb")

						arg_103_1:RecordAudio("410261025", var_106_9)
						arg_103_1:RecordAudio("410261025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410261", "410261025", "story_v_out_410261.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410261", "410261025", "story_v_out_410261.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play410261026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410261026
		arg_107_1.duration_ = 3.5

		local var_107_0 = {
			ja = 3.5,
			CriLanguages = 1.066,
			zh = 1.066
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
				arg_107_0:Play410261027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[584].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(410261026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 4
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261026", "story_v_out_410261.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261026", "story_v_out_410261.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_410261", "410261026", "story_v_out_410261.awb")

						arg_107_1:RecordAudio("410261026", var_110_9)
						arg_107_1:RecordAudio("410261026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410261", "410261026", "story_v_out_410261.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410261", "410261026", "story_v_out_410261.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410261027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410261027
		arg_111_1.duration_ = 6.43

		local var_111_0 = {
			ja = 6.433,
			CriLanguages = 2.533,
			zh = 2.533
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
				arg_111_0:Play410261028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.2

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[612].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(410261027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261027", "story_v_out_410261.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261027", "story_v_out_410261.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_410261", "410261027", "story_v_out_410261.awb")

						arg_111_1:RecordAudio("410261027", var_114_9)
						arg_111_1:RecordAudio("410261027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410261", "410261027", "story_v_out_410261.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410261", "410261027", "story_v_out_410261.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play410261028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410261028
		arg_115_1.duration_ = 9.9

		local var_115_0 = {
			ja = 9.9,
			CriLanguages = 5.533,
			zh = 5.533
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
				arg_115_0:Play410261029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.625

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[612].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(410261028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261028", "story_v_out_410261.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261028", "story_v_out_410261.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_410261", "410261028", "story_v_out_410261.awb")

						arg_115_1:RecordAudio("410261028", var_118_9)
						arg_115_1:RecordAudio("410261028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410261", "410261028", "story_v_out_410261.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410261", "410261028", "story_v_out_410261.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play410261029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410261029
		arg_119_1.duration_ = 6.27

		local var_119_0 = {
			ja = 5.033,
			CriLanguages = 6.266,
			zh = 6.266
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
				arg_119_0:Play410261030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.675

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[584].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(410261029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 27
				local var_122_6 = utf8.len(var_122_4)
				local var_122_7 = var_122_5 <= 0 and var_122_1 or var_122_1 * (var_122_6 / var_122_5)

				if var_122_7 > 0 and var_122_1 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261029", "story_v_out_410261.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261029", "story_v_out_410261.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_410261", "410261029", "story_v_out_410261.awb")

						arg_119_1:RecordAudio("410261029", var_122_9)
						arg_119_1:RecordAudio("410261029", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410261", "410261029", "story_v_out_410261.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410261", "410261029", "story_v_out_410261.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_10 and arg_119_1.time_ < var_122_0 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play410261030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410261030
		arg_123_1.duration_ = 8.2

		local var_123_0 = {
			ja = 8.2,
			CriLanguages = 3.9,
			zh = 3.9
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
				arg_123_0:Play410261031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.375

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[584].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(410261030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 15
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261030", "story_v_out_410261.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261030", "story_v_out_410261.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_410261", "410261030", "story_v_out_410261.awb")

						arg_123_1:RecordAudio("410261030", var_126_9)
						arg_123_1:RecordAudio("410261030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410261", "410261030", "story_v_out_410261.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410261", "410261030", "story_v_out_410261.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play410261031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410261031
		arg_127_1.duration_ = 11.53

		local var_127_0 = {
			ja = 11.533,
			CriLanguages = 3.466,
			zh = 3.466
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
				arg_127_0:Play410261032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.175

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[612].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(410261031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261031", "story_v_out_410261.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261031", "story_v_out_410261.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_410261", "410261031", "story_v_out_410261.awb")

						arg_127_1:RecordAudio("410261031", var_130_9)
						arg_127_1:RecordAudio("410261031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410261", "410261031", "story_v_out_410261.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410261", "410261031", "story_v_out_410261.awb")
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
	Play410261032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410261032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play410261033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.45

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_2 = arg_131_1:GetWordFromCfg(410261032)
				local var_134_3 = arg_131_1:FormatText(var_134_2.content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 18
				local var_134_5 = utf8.len(var_134_3)
				local var_134_6 = var_134_4 <= 0 and var_134_1 or var_134_1 * (var_134_5 / var_134_4)

				if var_134_6 > 0 and var_134_1 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_7 and arg_131_1.time_ < var_134_0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play410261033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410261033
		arg_135_1.duration_ = 6.13

		local var_135_0 = {
			ja = 4.766,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_135_0:Play410261034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.375

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[584].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(410261033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 15
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261033", "story_v_out_410261.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261033", "story_v_out_410261.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_410261", "410261033", "story_v_out_410261.awb")

						arg_135_1:RecordAudio("410261033", var_138_9)
						arg_135_1:RecordAudio("410261033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410261", "410261033", "story_v_out_410261.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410261", "410261033", "story_v_out_410261.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play410261034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410261034
		arg_139_1.duration_ = 4.67

		local var_139_0 = {
			ja = 3.433,
			CriLanguages = 4.666,
			zh = 4.666
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
				arg_139_0:Play410261035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.55

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[612].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(410261034)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261034", "story_v_out_410261.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261034", "story_v_out_410261.awb") / 1000

					if var_142_8 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_0
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_410261", "410261034", "story_v_out_410261.awb")

						arg_139_1:RecordAudio("410261034", var_142_9)
						arg_139_1:RecordAudio("410261034", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410261", "410261034", "story_v_out_410261.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410261", "410261034", "story_v_out_410261.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_10 and arg_139_1.time_ < var_142_0 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play410261035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410261035
		arg_143_1.duration_ = 2.9

		local var_143_0 = {
			ja = 2.9,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_143_0:Play410261036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.275

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[584].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(410261035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261035", "story_v_out_410261.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261035", "story_v_out_410261.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_410261", "410261035", "story_v_out_410261.awb")

						arg_143_1:RecordAudio("410261035", var_146_9)
						arg_143_1:RecordAudio("410261035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410261", "410261035", "story_v_out_410261.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410261", "410261035", "story_v_out_410261.awb")
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
	Play410261036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410261036
		arg_147_1.duration_ = 7.47

		local var_147_0 = {
			ja = 7.466,
			CriLanguages = 3.6,
			zh = 3.6
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
				arg_147_0:Play410261037(arg_147_1)
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

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[612].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(410261036)
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261036", "story_v_out_410261.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261036", "story_v_out_410261.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_410261", "410261036", "story_v_out_410261.awb")

						arg_147_1:RecordAudio("410261036", var_150_9)
						arg_147_1:RecordAudio("410261036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410261", "410261036", "story_v_out_410261.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410261", "410261036", "story_v_out_410261.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play410261037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410261037
		arg_151_1.duration_ = 4.4

		local var_151_0 = {
			ja = 4.4,
			CriLanguages = 2.233,
			zh = 2.233
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
				arg_151_0:Play410261038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.225

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[584].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(410261037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261037", "story_v_out_410261.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261037", "story_v_out_410261.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_410261", "410261037", "story_v_out_410261.awb")

						arg_151_1:RecordAudio("410261037", var_154_9)
						arg_151_1:RecordAudio("410261037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410261", "410261037", "story_v_out_410261.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410261", "410261037", "story_v_out_410261.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play410261038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410261038
		arg_155_1.duration_ = 12.23

		local var_155_0 = {
			ja = 12.233,
			CriLanguages = 9.533,
			zh = 9.533
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
				arg_155_0:Play410261039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[612].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(410261038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261038", "story_v_out_410261.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261038", "story_v_out_410261.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_410261", "410261038", "story_v_out_410261.awb")

						arg_155_1:RecordAudio("410261038", var_158_9)
						arg_155_1:RecordAudio("410261038", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410261", "410261038", "story_v_out_410261.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410261", "410261038", "story_v_out_410261.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play410261039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410261039
		arg_159_1.duration_ = 3.7

		local var_159_0 = {
			ja = 3.133,
			CriLanguages = 3.7,
			zh = 3.7
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
				arg_159_0:Play410261040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.225

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[584].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(410261039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261039", "story_v_out_410261.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261039", "story_v_out_410261.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_410261", "410261039", "story_v_out_410261.awb")

						arg_159_1:RecordAudio("410261039", var_162_9)
						arg_159_1:RecordAudio("410261039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410261", "410261039", "story_v_out_410261.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410261", "410261039", "story_v_out_410261.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play410261040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410261040
		arg_163_1.duration_ = 10.87

		local var_163_0 = {
			ja = 10.866,
			CriLanguages = 3.9,
			zh = 3.9
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
				arg_163_0:Play410261041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.4

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[612].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(410261040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261040", "story_v_out_410261.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261040", "story_v_out_410261.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_410261", "410261040", "story_v_out_410261.awb")

						arg_163_1:RecordAudio("410261040", var_166_9)
						arg_163_1:RecordAudio("410261040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410261", "410261040", "story_v_out_410261.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410261", "410261040", "story_v_out_410261.awb")
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
	Play410261041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410261041
		arg_167_1.duration_ = 10.77

		local var_167_0 = {
			ja = 10.766,
			CriLanguages = 8.233,
			zh = 8.233
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
				arg_167_0:Play410261042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.825

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[612].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(410261041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261041", "story_v_out_410261.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261041", "story_v_out_410261.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_410261", "410261041", "story_v_out_410261.awb")

						arg_167_1:RecordAudio("410261041", var_170_9)
						arg_167_1:RecordAudio("410261041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410261", "410261041", "story_v_out_410261.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410261", "410261041", "story_v_out_410261.awb")
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
	Play410261042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410261042
		arg_171_1.duration_ = 13.13

		local var_171_0 = {
			ja = 13.133,
			CriLanguages = 12.633,
			zh = 12.633
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
				arg_171_0:Play410261043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[612].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(410261042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261042", "story_v_out_410261.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261042", "story_v_out_410261.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_410261", "410261042", "story_v_out_410261.awb")

						arg_171_1:RecordAudio("410261042", var_174_9)
						arg_171_1:RecordAudio("410261042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410261", "410261042", "story_v_out_410261.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410261", "410261042", "story_v_out_410261.awb")
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
	Play410261043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410261043
		arg_175_1.duration_ = 4.63

		local var_175_0 = {
			ja = 4.633,
			CriLanguages = 3.433,
			zh = 3.433
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
				arg_175_0:Play410261044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.15

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[584].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(410261043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261043", "story_v_out_410261.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261043", "story_v_out_410261.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_410261", "410261043", "story_v_out_410261.awb")

						arg_175_1:RecordAudio("410261043", var_178_9)
						arg_175_1:RecordAudio("410261043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410261", "410261043", "story_v_out_410261.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410261", "410261043", "story_v_out_410261.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play410261044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410261044
		arg_179_1.duration_ = 10.47

		local var_179_0 = {
			ja = 10.466,
			CriLanguages = 8.1,
			zh = 8.1
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
				arg_179_0:Play410261045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 2

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				local var_182_1 = manager.ui.mainCamera.transform.localPosition
				local var_182_2 = Vector3.New(0, 0, 10) + Vector3.New(var_182_1.x, var_182_1.y, 0)
				local var_182_3 = arg_179_1.bgs_.L01f

				var_182_3.transform.localPosition = var_182_2
				var_182_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_4 = var_182_3:GetComponent("SpriteRenderer")

				if var_182_4 and var_182_4.sprite then
					local var_182_5 = (var_182_3.transform.localPosition - var_182_1).z
					local var_182_6 = manager.ui.mainCameraCom_
					local var_182_7 = 2 * var_182_5 * Mathf.Tan(var_182_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_182_8 = var_182_7 * var_182_6.aspect
					local var_182_9 = var_182_4.sprite.bounds.size.x
					local var_182_10 = var_182_4.sprite.bounds.size.y
					local var_182_11 = var_182_8 / var_182_9
					local var_182_12 = var_182_7 / var_182_10
					local var_182_13 = var_182_12 < var_182_11 and var_182_11 or var_182_12

					var_182_3.transform.localScale = Vector3.New(var_182_13, var_182_13, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "L01f" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_14 = 0

			if var_182_14 < arg_179_1.time_ and arg_179_1.time_ <= var_182_14 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_15 = 2

			if var_182_14 <= arg_179_1.time_ and arg_179_1.time_ < var_182_14 + var_182_15 then
				local var_182_16 = (arg_179_1.time_ - var_182_14) / var_182_15
				local var_182_17 = Color.New(0, 0, 0)

				var_182_17.a = Mathf.Lerp(0, 1, var_182_16)
				arg_179_1.mask_.color = var_182_17
			end

			if arg_179_1.time_ >= var_182_14 + var_182_15 and arg_179_1.time_ < var_182_14 + var_182_15 + arg_182_0 then
				local var_182_18 = Color.New(0, 0, 0)

				var_182_18.a = 1
				arg_179_1.mask_.color = var_182_18
			end

			local var_182_19 = 2

			if var_182_19 < arg_179_1.time_ and arg_179_1.time_ <= var_182_19 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_20 = 2

			if var_182_19 <= arg_179_1.time_ and arg_179_1.time_ < var_182_19 + var_182_20 then
				local var_182_21 = (arg_179_1.time_ - var_182_19) / var_182_20
				local var_182_22 = Color.New(0, 0, 0)

				var_182_22.a = Mathf.Lerp(1, 0, var_182_21)
				arg_179_1.mask_.color = var_182_22
			end

			if arg_179_1.time_ >= var_182_19 + var_182_20 and arg_179_1.time_ < var_182_19 + var_182_20 + arg_182_0 then
				local var_182_23 = Color.New(0, 0, 0)
				local var_182_24 = 0

				arg_179_1.mask_.enabled = false
				var_182_23.a = var_182_24
				arg_179_1.mask_.color = var_182_23
			end

			local var_182_25 = arg_179_1.actors_["1061"].transform
			local var_182_26 = 4

			if var_182_26 < arg_179_1.time_ and arg_179_1.time_ <= var_182_26 + arg_182_0 then
				arg_179_1.var_.moveOldPos1061 = var_182_25.localPosition
				var_182_25.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1061", 2)

				local var_182_27 = var_182_25.childCount

				for iter_182_2 = 0, var_182_27 - 1 do
					local var_182_28 = var_182_25:GetChild(iter_182_2)

					if var_182_28.name == "" or not string.find(var_182_28.name, "split") then
						var_182_28.gameObject:SetActive(true)
					else
						var_182_28.gameObject:SetActive(false)
					end
				end
			end

			local var_182_29 = 0.001

			if var_182_26 <= arg_179_1.time_ and arg_179_1.time_ < var_182_26 + var_182_29 then
				local var_182_30 = (arg_179_1.time_ - var_182_26) / var_182_29
				local var_182_31 = Vector3.New(-390, -490, 18)

				var_182_25.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1061, var_182_31, var_182_30)
			end

			if arg_179_1.time_ >= var_182_26 + var_182_29 and arg_179_1.time_ < var_182_26 + var_182_29 + arg_182_0 then
				var_182_25.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_182_32 = arg_179_1.actors_["1060"].transform
			local var_182_33 = 4

			if var_182_33 < arg_179_1.time_ and arg_179_1.time_ <= var_182_33 + arg_182_0 then
				arg_179_1.var_.moveOldPos1060 = var_182_32.localPosition
				var_182_32.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1060", 4)

				local var_182_34 = var_182_32.childCount

				for iter_182_3 = 0, var_182_34 - 1 do
					local var_182_35 = var_182_32:GetChild(iter_182_3)

					if var_182_35.name == "" or not string.find(var_182_35.name, "split") then
						var_182_35.gameObject:SetActive(true)
					else
						var_182_35.gameObject:SetActive(false)
					end
				end
			end

			local var_182_36 = 0.001

			if var_182_33 <= arg_179_1.time_ and arg_179_1.time_ < var_182_33 + var_182_36 then
				local var_182_37 = (arg_179_1.time_ - var_182_33) / var_182_36
				local var_182_38 = Vector3.New(420.9, -430.8, 6.9)

				var_182_32.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1060, var_182_38, var_182_37)
			end

			if arg_179_1.time_ >= var_182_33 + var_182_36 and arg_179_1.time_ < var_182_33 + var_182_36 + arg_182_0 then
				var_182_32.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_182_39 = arg_179_1.actors_["1061"]
			local var_182_40 = 4

			if var_182_40 < arg_179_1.time_ and arg_179_1.time_ <= var_182_40 + arg_182_0 and not isNil(var_182_39) and arg_179_1.var_.actorSpriteComps1061 == nil then
				arg_179_1.var_.actorSpriteComps1061 = var_182_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_41 = 0.034

			if var_182_40 <= arg_179_1.time_ and arg_179_1.time_ < var_182_40 + var_182_41 and not isNil(var_182_39) then
				local var_182_42 = (arg_179_1.time_ - var_182_40) / var_182_41

				if arg_179_1.var_.actorSpriteComps1061 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_43 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor1.r, var_182_42)
								local var_182_44 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor1.g, var_182_42)
								local var_182_45 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor1.b, var_182_42)

								iter_182_5.color = Color.New(var_182_43, var_182_44, var_182_45)
							else
								local var_182_46 = Mathf.Lerp(iter_182_5.color.r, 1, var_182_42)

								iter_182_5.color = Color.New(var_182_46, var_182_46, var_182_46)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_40 + var_182_41 and arg_179_1.time_ < var_182_40 + var_182_41 + arg_182_0 and not isNil(var_182_39) and arg_179_1.var_.actorSpriteComps1061 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1061 = nil
			end

			local var_182_47 = arg_179_1.actors_["1060"]
			local var_182_48 = 4

			if var_182_48 < arg_179_1.time_ and arg_179_1.time_ <= var_182_48 + arg_182_0 and not isNil(var_182_47) and arg_179_1.var_.actorSpriteComps1060 == nil then
				arg_179_1.var_.actorSpriteComps1060 = var_182_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_49 = 0.034

			if var_182_48 <= arg_179_1.time_ and arg_179_1.time_ < var_182_48 + var_182_49 and not isNil(var_182_47) then
				local var_182_50 = (arg_179_1.time_ - var_182_48) / var_182_49

				if arg_179_1.var_.actorSpriteComps1060 then
					for iter_182_8, iter_182_9 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_182_9 then
							if arg_179_1.isInRecall_ then
								local var_182_51 = Mathf.Lerp(iter_182_9.color.r, arg_179_1.hightColor2.r, var_182_50)
								local var_182_52 = Mathf.Lerp(iter_182_9.color.g, arg_179_1.hightColor2.g, var_182_50)
								local var_182_53 = Mathf.Lerp(iter_182_9.color.b, arg_179_1.hightColor2.b, var_182_50)

								iter_182_9.color = Color.New(var_182_51, var_182_52, var_182_53)
							else
								local var_182_54 = Mathf.Lerp(iter_182_9.color.r, 0.5, var_182_50)

								iter_182_9.color = Color.New(var_182_54, var_182_54, var_182_54)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_48 + var_182_49 and arg_179_1.time_ < var_182_48 + var_182_49 + arg_182_0 and not isNil(var_182_47) and arg_179_1.var_.actorSpriteComps1060 then
				for iter_182_10, iter_182_11 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_182_11 then
						if arg_179_1.isInRecall_ then
							iter_182_11.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1060 = nil
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_55 = 4
			local var_182_56 = 0.55

			if var_182_55 < arg_179_1.time_ and arg_179_1.time_ <= var_182_55 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_57 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_57:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_58 = arg_179_1:FormatText(StoryNameCfg[612].name)

				arg_179_1.leftNameTxt_.text = var_182_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_59 = arg_179_1:GetWordFromCfg(410261044)
				local var_182_60 = arg_179_1:FormatText(var_182_59.content)

				arg_179_1.text_.text = var_182_60

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_61 = 22
				local var_182_62 = utf8.len(var_182_60)
				local var_182_63 = var_182_61 <= 0 and var_182_56 or var_182_56 * (var_182_62 / var_182_61)

				if var_182_63 > 0 and var_182_56 < var_182_63 then
					arg_179_1.talkMaxDuration = var_182_63
					var_182_55 = var_182_55 + 0.3

					if var_182_63 + var_182_55 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_63 + var_182_55
					end
				end

				arg_179_1.text_.text = var_182_60
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261044", "story_v_out_410261.awb") ~= 0 then
					local var_182_64 = manager.audio:GetVoiceLength("story_v_out_410261", "410261044", "story_v_out_410261.awb") / 1000

					if var_182_64 + var_182_55 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_64 + var_182_55
					end

					if var_182_59.prefab_name ~= "" and arg_179_1.actors_[var_182_59.prefab_name] ~= nil then
						local var_182_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_59.prefab_name].transform, "story_v_out_410261", "410261044", "story_v_out_410261.awb")

						arg_179_1:RecordAudio("410261044", var_182_65)
						arg_179_1:RecordAudio("410261044", var_182_65)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410261", "410261044", "story_v_out_410261.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410261", "410261044", "story_v_out_410261.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_66 = var_182_55 + 0.3
			local var_182_67 = math.max(var_182_56, arg_179_1.talkMaxDuration)

			if var_182_66 <= arg_179_1.time_ and arg_179_1.time_ < var_182_66 + var_182_67 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_66) / var_182_67

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_66 + var_182_67 and arg_179_1.time_ < var_182_66 + var_182_67 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play410261045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 410261045
		arg_185_1.duration_ = 3.13

		local var_185_0 = {
			ja = 3.133,
			CriLanguages = 1.233,
			zh = 1.233
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
				arg_185_0:Play410261046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1060"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1060 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1060", 4)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(420.9, -430.8, 6.9)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1060, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_188_7 = arg_185_1.actors_["1060"]
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1060 == nil then
				arg_185_1.var_.actorSpriteComps1060 = var_188_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_9 = 0.034

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 and not isNil(var_188_7) then
				local var_188_10 = (arg_185_1.time_ - var_188_8) / var_188_9

				if arg_185_1.var_.actorSpriteComps1060 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								local var_188_11 = Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, var_188_10)
								local var_188_12 = Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, var_188_10)
								local var_188_13 = Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, var_188_10)

								iter_188_2.color = Color.New(var_188_11, var_188_12, var_188_13)
							else
								local var_188_14 = Mathf.Lerp(iter_188_2.color.r, 1, var_188_10)

								iter_188_2.color = Color.New(var_188_14, var_188_14, var_188_14)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 and not isNil(var_188_7) and arg_185_1.var_.actorSpriteComps1060 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_188_4 then
						if arg_185_1.isInRecall_ then
							iter_188_4.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1060 = nil
			end

			local var_188_15 = arg_185_1.actors_["1061"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps1061 == nil then
				arg_185_1.var_.actorSpriteComps1061 = var_188_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_17 = 0.034

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.actorSpriteComps1061 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								local var_188_19 = Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, var_188_18)
								local var_188_20 = Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, var_188_18)
								local var_188_21 = Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, var_188_18)

								iter_188_6.color = Color.New(var_188_19, var_188_20, var_188_21)
							else
								local var_188_22 = Mathf.Lerp(iter_188_6.color.r, 0.5, var_188_18)

								iter_188_6.color = Color.New(var_188_22, var_188_22, var_188_22)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.actorSpriteComps1061 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_188_8 then
						if arg_185_1.isInRecall_ then
							iter_188_8.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps1061 = nil
			end

			local var_188_23 = 0
			local var_188_24 = 0.15

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[584].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(410261045)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 6
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261045", "story_v_out_410261.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261045", "story_v_out_410261.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_410261", "410261045", "story_v_out_410261.awb")

						arg_185_1:RecordAudio("410261045", var_188_32)
						arg_185_1:RecordAudio("410261045", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_410261", "410261045", "story_v_out_410261.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_410261", "410261045", "story_v_out_410261.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play410261046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 410261046
		arg_189_1.duration_ = 4.43

		local var_189_0 = {
			ja = 4.433,
			CriLanguages = 1.833,
			zh = 1.833
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
				arg_189_0:Play410261047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1061"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1061 = var_192_0.localPosition
				var_192_0.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1061", 2)

				local var_192_2 = var_192_0.childCount

				for iter_192_0 = 0, var_192_2 - 1 do
					local var_192_3 = var_192_0:GetChild(iter_192_0)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_4 then
				local var_192_5 = (arg_189_1.time_ - var_192_1) / var_192_4
				local var_192_6 = Vector3.New(-390, -490, 18)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1061, var_192_6, var_192_5)
			end

			if arg_189_1.time_ >= var_192_1 + var_192_4 and arg_189_1.time_ < var_192_1 + var_192_4 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_192_7 = arg_189_1.actors_["1060"]
			local var_192_8 = 0

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1060 == nil then
				arg_189_1.var_.actorSpriteComps1060 = var_192_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 0.034

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 and not isNil(var_192_7) then
				local var_192_10 = (arg_189_1.time_ - var_192_8) / var_192_9

				if arg_189_1.var_.actorSpriteComps1060 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								local var_192_11 = Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor2.r, var_192_10)
								local var_192_12 = Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor2.g, var_192_10)
								local var_192_13 = Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor2.b, var_192_10)

								iter_192_2.color = Color.New(var_192_11, var_192_12, var_192_13)
							else
								local var_192_14 = Mathf.Lerp(iter_192_2.color.r, 0.5, var_192_10)

								iter_192_2.color = Color.New(var_192_14, var_192_14, var_192_14)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 and not isNil(var_192_7) and arg_189_1.var_.actorSpriteComps1060 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_192_4 then
						if arg_189_1.isInRecall_ then
							iter_192_4.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1060 = nil
			end

			local var_192_15 = arg_189_1.actors_["1061"]
			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.actorSpriteComps1061 == nil then
				arg_189_1.var_.actorSpriteComps1061 = var_192_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_17 = 0.034

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 and not isNil(var_192_15) then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17

				if arg_189_1.var_.actorSpriteComps1061 then
					for iter_192_5, iter_192_6 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_192_6 then
							if arg_189_1.isInRecall_ then
								local var_192_19 = Mathf.Lerp(iter_192_6.color.r, arg_189_1.hightColor1.r, var_192_18)
								local var_192_20 = Mathf.Lerp(iter_192_6.color.g, arg_189_1.hightColor1.g, var_192_18)
								local var_192_21 = Mathf.Lerp(iter_192_6.color.b, arg_189_1.hightColor1.b, var_192_18)

								iter_192_6.color = Color.New(var_192_19, var_192_20, var_192_21)
							else
								local var_192_22 = Mathf.Lerp(iter_192_6.color.r, 1, var_192_18)

								iter_192_6.color = Color.New(var_192_22, var_192_22, var_192_22)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 and not isNil(var_192_15) and arg_189_1.var_.actorSpriteComps1061 then
				for iter_192_7, iter_192_8 in pairs(arg_189_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_192_8 then
						if arg_189_1.isInRecall_ then
							iter_192_8.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1061 = nil
			end

			local var_192_23 = 0
			local var_192_24 = 0.225

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_25 = arg_189_1:FormatText(StoryNameCfg[612].name)

				arg_189_1.leftNameTxt_.text = var_192_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_26 = arg_189_1:GetWordFromCfg(410261046)
				local var_192_27 = arg_189_1:FormatText(var_192_26.content)

				arg_189_1.text_.text = var_192_27

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_28 = 9
				local var_192_29 = utf8.len(var_192_27)
				local var_192_30 = var_192_28 <= 0 and var_192_24 or var_192_24 * (var_192_29 / var_192_28)

				if var_192_30 > 0 and var_192_24 < var_192_30 then
					arg_189_1.talkMaxDuration = var_192_30

					if var_192_30 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_23
					end
				end

				arg_189_1.text_.text = var_192_27
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261046", "story_v_out_410261.awb") ~= 0 then
					local var_192_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261046", "story_v_out_410261.awb") / 1000

					if var_192_31 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_23
					end

					if var_192_26.prefab_name ~= "" and arg_189_1.actors_[var_192_26.prefab_name] ~= nil then
						local var_192_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_26.prefab_name].transform, "story_v_out_410261", "410261046", "story_v_out_410261.awb")

						arg_189_1:RecordAudio("410261046", var_192_32)
						arg_189_1:RecordAudio("410261046", var_192_32)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_410261", "410261046", "story_v_out_410261.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_410261", "410261046", "story_v_out_410261.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_33 = math.max(var_192_24, arg_189_1.talkMaxDuration)

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_33 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_23) / var_192_33

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_23 + var_192_33 and arg_189_1.time_ < var_192_23 + var_192_33 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410261047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 410261047
		arg_193_1.duration_ = 8.83

		local var_193_0 = {
			ja = 8.833,
			CriLanguages = 3.766,
			zh = 3.766
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
				arg_193_0:Play410261048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1061"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1061 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1061", 2)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "split_2" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(-390, -490, 18)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1061, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_196_7 = arg_193_1.actors_["1061"]
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1061 == nil then
				arg_193_1.var_.actorSpriteComps1061 = var_196_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_9 = 0.034

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 and not isNil(var_196_7) then
				local var_196_10 = (arg_193_1.time_ - var_196_8) / var_196_9

				if arg_193_1.var_.actorSpriteComps1061 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								local var_196_11 = Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, var_196_10)
								local var_196_12 = Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, var_196_10)
								local var_196_13 = Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, var_196_10)

								iter_196_2.color = Color.New(var_196_11, var_196_12, var_196_13)
							else
								local var_196_14 = Mathf.Lerp(iter_196_2.color.r, 1, var_196_10)

								iter_196_2.color = Color.New(var_196_14, var_196_14, var_196_14)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 and not isNil(var_196_7) and arg_193_1.var_.actorSpriteComps1061 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_196_4 then
						if arg_193_1.isInRecall_ then
							iter_196_4.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1061 = nil
			end

			local var_196_15 = 0
			local var_196_16 = 0.25

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[612].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(410261047)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 10
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261047", "story_v_out_410261.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_410261", "410261047", "story_v_out_410261.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_410261", "410261047", "story_v_out_410261.awb")

						arg_193_1:RecordAudio("410261047", var_196_24)
						arg_193_1:RecordAudio("410261047", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_410261", "410261047", "story_v_out_410261.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_410261", "410261047", "story_v_out_410261.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
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
	Play410261048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410261048
		arg_197_1.duration_ = 12.67

		local var_197_0 = {
			ja = 12.666,
			CriLanguages = 2.966,
			zh = 2.966
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410261049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1060"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1060", 4)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_2" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(420.9, -430.8, 6.9)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_200_7 = arg_197_1.actors_["1060"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1060 == nil then
				arg_197_1.var_.actorSpriteComps1060 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 0.034

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps1060 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps1060 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1060 = nil
			end

			local var_200_15 = arg_197_1.actors_["1061"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1061 == nil then
				arg_197_1.var_.actorSpriteComps1061 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 0.034

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps1061 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 0.5, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps1061 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps1061 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.2

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[584].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(410261048)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 8
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261048", "story_v_out_410261.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261048", "story_v_out_410261.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_410261", "410261048", "story_v_out_410261.awb")

						arg_197_1:RecordAudio("410261048", var_200_32)
						arg_197_1:RecordAudio("410261048", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_410261", "410261048", "story_v_out_410261.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_410261", "410261048", "story_v_out_410261.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play410261049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410261049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410261050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1061"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1061 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1061", 7)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(0, -2000, 18)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1061, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_204_7 = arg_201_1.actors_["1060"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos1060 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1060", 7)

				local var_204_9 = var_204_7.childCount

				for iter_204_1 = 0, var_204_9 - 1 do
					local var_204_10 = var_204_7:GetChild(iter_204_1)

					if var_204_10.name == "" or not string.find(var_204_10.name, "split") then
						var_204_10.gameObject:SetActive(true)
					else
						var_204_10.gameObject:SetActive(false)
					end
				end
			end

			local var_204_11 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_8) / var_204_11
				local var_204_13 = Vector3.New(0, -2000, -40)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1060, var_204_13, var_204_12)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_11 and arg_201_1.time_ < var_204_8 + var_204_11 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_204_14 = arg_201_1.actors_["1061"]
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps1061 == nil then
				arg_201_1.var_.actorSpriteComps1061 = var_204_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_16 = 0.034

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_16 and not isNil(var_204_14) then
				local var_204_17 = (arg_201_1.time_ - var_204_15) / var_204_16

				if arg_201_1.var_.actorSpriteComps1061 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								local var_204_18 = Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor2.r, var_204_17)
								local var_204_19 = Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor2.g, var_204_17)
								local var_204_20 = Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor2.b, var_204_17)

								iter_204_3.color = Color.New(var_204_18, var_204_19, var_204_20)
							else
								local var_204_21 = Mathf.Lerp(iter_204_3.color.r, 0.5, var_204_17)

								iter_204_3.color = Color.New(var_204_21, var_204_21, var_204_21)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_15 + var_204_16 and arg_201_1.time_ < var_204_15 + var_204_16 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps1061 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_204_5 then
						if arg_201_1.isInRecall_ then
							iter_204_5.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1061 = nil
			end

			local var_204_22 = arg_201_1.actors_["1060"]
			local var_204_23 = 0

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps1060 == nil then
				arg_201_1.var_.actorSpriteComps1060 = var_204_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_24 = 0.034

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 and not isNil(var_204_22) then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24

				if arg_201_1.var_.actorSpriteComps1060 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								local var_204_26 = Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor2.r, var_204_25)
								local var_204_27 = Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor2.g, var_204_25)
								local var_204_28 = Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor2.b, var_204_25)

								iter_204_7.color = Color.New(var_204_26, var_204_27, var_204_28)
							else
								local var_204_29 = Mathf.Lerp(iter_204_7.color.r, 0.5, var_204_25)

								iter_204_7.color = Color.New(var_204_29, var_204_29, var_204_29)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps1060 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_204_9 then
						if arg_201_1.isInRecall_ then
							iter_204_9.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1060 = nil
			end

			local var_204_30 = 0
			local var_204_31 = 1.25

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_32 = arg_201_1:GetWordFromCfg(410261049)
				local var_204_33 = arg_201_1:FormatText(var_204_32.content)

				arg_201_1.text_.text = var_204_33

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_34 = 50
				local var_204_35 = utf8.len(var_204_33)
				local var_204_36 = var_204_34 <= 0 and var_204_31 or var_204_31 * (var_204_35 / var_204_34)

				if var_204_36 > 0 and var_204_31 < var_204_36 then
					arg_201_1.talkMaxDuration = var_204_36

					if var_204_36 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_36 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_33
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_37 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_37 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_37

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_37 and arg_201_1.time_ < var_204_30 + var_204_37 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play410261050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410261050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play410261051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 1.325

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

				local var_208_2 = arg_205_1:GetWordFromCfg(410261050)
				local var_208_3 = arg_205_1:FormatText(var_208_2.content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 53
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
	Play410261051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410261051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play410261052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.075

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_2 = arg_209_1:GetWordFromCfg(410261051)
				local var_212_3 = arg_209_1:FormatText(var_212_2.content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 43
				local var_212_5 = utf8.len(var_212_3)
				local var_212_6 = var_212_4 <= 0 and var_212_1 or var_212_1 * (var_212_5 / var_212_4)

				if var_212_6 > 0 and var_212_1 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_7 and arg_209_1.time_ < var_212_0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play410261052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410261052
		arg_213_1.duration_ = 6.53

		local var_213_0 = {
			ja = 6.533,
			CriLanguages = 3,
			zh = 3
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
				arg_213_0:Play410261053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1060"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1060 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1060", 2)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1060, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_216_7 = "1012"

			if arg_213_1.actors_[var_216_7] == nil then
				local var_216_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_216_8) then
					local var_216_9 = Object.Instantiate(var_216_8, arg_213_1.canvasGo_.transform)

					var_216_9.transform:SetSiblingIndex(1)

					var_216_9.name = var_216_7
					var_216_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_213_1.actors_[var_216_7] = var_216_9

					local var_216_10 = var_216_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_213_1.isInRecall_ then
						for iter_216_1, iter_216_2 in ipairs(var_216_10) do
							iter_216_2.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_216_11 = arg_213_1.actors_["1012"].transform
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.var_.moveOldPos1012 = var_216_11.localPosition
				var_216_11.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1012", 4)

				local var_216_13 = var_216_11.childCount

				for iter_216_3 = 0, var_216_13 - 1 do
					local var_216_14 = var_216_11:GetChild(iter_216_3)

					if var_216_14.name == "" or not string.find(var_216_14.name, "split") then
						var_216_14.gameObject:SetActive(true)
					else
						var_216_14.gameObject:SetActive(false)
					end
				end
			end

			local var_216_15 = 0.001

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_15 then
				local var_216_16 = (arg_213_1.time_ - var_216_12) / var_216_15
				local var_216_17 = Vector3.New(390, -465, 300)

				var_216_11.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1012, var_216_17, var_216_16)
			end

			if arg_213_1.time_ >= var_216_12 + var_216_15 and arg_213_1.time_ < var_216_12 + var_216_15 + arg_216_0 then
				var_216_11.localPosition = Vector3.New(390, -465, 300)
			end

			local var_216_18 = arg_213_1.actors_["1060"]
			local var_216_19 = 0

			if var_216_19 < arg_213_1.time_ and arg_213_1.time_ <= var_216_19 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.actorSpriteComps1060 == nil then
				arg_213_1.var_.actorSpriteComps1060 = var_216_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_20 = 0.034

			if var_216_19 <= arg_213_1.time_ and arg_213_1.time_ < var_216_19 + var_216_20 and not isNil(var_216_18) then
				local var_216_21 = (arg_213_1.time_ - var_216_19) / var_216_20

				if arg_213_1.var_.actorSpriteComps1060 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_22 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor1.r, var_216_21)
								local var_216_23 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor1.g, var_216_21)
								local var_216_24 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor1.b, var_216_21)

								iter_216_5.color = Color.New(var_216_22, var_216_23, var_216_24)
							else
								local var_216_25 = Mathf.Lerp(iter_216_5.color.r, 1, var_216_21)

								iter_216_5.color = Color.New(var_216_25, var_216_25, var_216_25)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_19 + var_216_20 and arg_213_1.time_ < var_216_19 + var_216_20 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.actorSpriteComps1060 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1060 = nil
			end

			local var_216_26 = arg_213_1.actors_["1012"]
			local var_216_27 = 0

			if var_216_27 < arg_213_1.time_ and arg_213_1.time_ <= var_216_27 + arg_216_0 and not isNil(var_216_26) and arg_213_1.var_.actorSpriteComps1012 == nil then
				arg_213_1.var_.actorSpriteComps1012 = var_216_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_28 = 0.034

			if var_216_27 <= arg_213_1.time_ and arg_213_1.time_ < var_216_27 + var_216_28 and not isNil(var_216_26) then
				local var_216_29 = (arg_213_1.time_ - var_216_27) / var_216_28

				if arg_213_1.var_.actorSpriteComps1012 then
					for iter_216_8, iter_216_9 in pairs(arg_213_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_216_9 then
							if arg_213_1.isInRecall_ then
								local var_216_30 = Mathf.Lerp(iter_216_9.color.r, arg_213_1.hightColor2.r, var_216_29)
								local var_216_31 = Mathf.Lerp(iter_216_9.color.g, arg_213_1.hightColor2.g, var_216_29)
								local var_216_32 = Mathf.Lerp(iter_216_9.color.b, arg_213_1.hightColor2.b, var_216_29)

								iter_216_9.color = Color.New(var_216_30, var_216_31, var_216_32)
							else
								local var_216_33 = Mathf.Lerp(iter_216_9.color.r, 0.5, var_216_29)

								iter_216_9.color = Color.New(var_216_33, var_216_33, var_216_33)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_27 + var_216_28 and arg_213_1.time_ < var_216_27 + var_216_28 + arg_216_0 and not isNil(var_216_26) and arg_213_1.var_.actorSpriteComps1012 then
				for iter_216_10, iter_216_11 in pairs(arg_213_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_216_11 then
						if arg_213_1.isInRecall_ then
							iter_216_11.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1012 = nil
			end

			local var_216_34 = 0
			local var_216_35 = 0.45

			if var_216_34 < arg_213_1.time_ and arg_213_1.time_ <= var_216_34 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_36 = arg_213_1:FormatText(StoryNameCfg[584].name)

				arg_213_1.leftNameTxt_.text = var_216_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_37 = arg_213_1:GetWordFromCfg(410261052)
				local var_216_38 = arg_213_1:FormatText(var_216_37.content)

				arg_213_1.text_.text = var_216_38

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_39 = 18
				local var_216_40 = utf8.len(var_216_38)
				local var_216_41 = var_216_39 <= 0 and var_216_35 or var_216_35 * (var_216_40 / var_216_39)

				if var_216_41 > 0 and var_216_35 < var_216_41 then
					arg_213_1.talkMaxDuration = var_216_41

					if var_216_41 + var_216_34 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_41 + var_216_34
					end
				end

				arg_213_1.text_.text = var_216_38
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261052", "story_v_out_410261.awb") ~= 0 then
					local var_216_42 = manager.audio:GetVoiceLength("story_v_out_410261", "410261052", "story_v_out_410261.awb") / 1000

					if var_216_42 + var_216_34 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_42 + var_216_34
					end

					if var_216_37.prefab_name ~= "" and arg_213_1.actors_[var_216_37.prefab_name] ~= nil then
						local var_216_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_37.prefab_name].transform, "story_v_out_410261", "410261052", "story_v_out_410261.awb")

						arg_213_1:RecordAudio("410261052", var_216_43)
						arg_213_1:RecordAudio("410261052", var_216_43)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410261", "410261052", "story_v_out_410261.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410261", "410261052", "story_v_out_410261.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_44 = math.max(var_216_35, arg_213_1.talkMaxDuration)

			if var_216_34 <= arg_213_1.time_ and arg_213_1.time_ < var_216_34 + var_216_44 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_34) / var_216_44

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_34 + var_216_44 and arg_213_1.time_ < var_216_34 + var_216_44 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
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
	Play410261053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410261053
		arg_217_1.duration_ = 14.83

		local var_217_0 = {
			ja = 14.833,
			CriLanguages = 6.7,
			zh = 6.7
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
				arg_217_0:Play410261054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1012"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1012 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1012", 4)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(390, -465, 300)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1012, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_220_7 = arg_217_1.actors_["1012"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1012 == nil then
				arg_217_1.var_.actorSpriteComps1012 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 0.034

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps1012 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								local var_220_11 = Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, var_220_10)
								local var_220_12 = Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, var_220_10)
								local var_220_13 = Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, var_220_10)

								iter_220_2.color = Color.New(var_220_11, var_220_12, var_220_13)
							else
								local var_220_14 = Mathf.Lerp(iter_220_2.color.r, 1, var_220_10)

								iter_220_2.color = Color.New(var_220_14, var_220_14, var_220_14)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1012 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1012 = nil
			end

			local var_220_15 = arg_217_1.actors_["1060"]
			local var_220_16 = 0

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 and not isNil(var_220_15) and arg_217_1.var_.actorSpriteComps1060 == nil then
				arg_217_1.var_.actorSpriteComps1060 = var_220_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_17 = 0.034

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_17 and not isNil(var_220_15) then
				local var_220_18 = (arg_217_1.time_ - var_220_16) / var_220_17

				if arg_217_1.var_.actorSpriteComps1060 then
					for iter_220_5, iter_220_6 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_220_6 then
							if arg_217_1.isInRecall_ then
								local var_220_19 = Mathf.Lerp(iter_220_6.color.r, arg_217_1.hightColor2.r, var_220_18)
								local var_220_20 = Mathf.Lerp(iter_220_6.color.g, arg_217_1.hightColor2.g, var_220_18)
								local var_220_21 = Mathf.Lerp(iter_220_6.color.b, arg_217_1.hightColor2.b, var_220_18)

								iter_220_6.color = Color.New(var_220_19, var_220_20, var_220_21)
							else
								local var_220_22 = Mathf.Lerp(iter_220_6.color.r, 0.5, var_220_18)

								iter_220_6.color = Color.New(var_220_22, var_220_22, var_220_22)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_16 + var_220_17 and arg_217_1.time_ < var_220_16 + var_220_17 + arg_220_0 and not isNil(var_220_15) and arg_217_1.var_.actorSpriteComps1060 then
				for iter_220_7, iter_220_8 in pairs(arg_217_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_220_8 then
						if arg_217_1.isInRecall_ then
							iter_220_8.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1060 = nil
			end

			local var_220_23 = 0
			local var_220_24 = 0.8

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_25 = arg_217_1:FormatText(StoryNameCfg[595].name)

				arg_217_1.leftNameTxt_.text = var_220_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_26 = arg_217_1:GetWordFromCfg(410261053)
				local var_220_27 = arg_217_1:FormatText(var_220_26.content)

				arg_217_1.text_.text = var_220_27

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_28 = 32
				local var_220_29 = utf8.len(var_220_27)
				local var_220_30 = var_220_28 <= 0 and var_220_24 or var_220_24 * (var_220_29 / var_220_28)

				if var_220_30 > 0 and var_220_24 < var_220_30 then
					arg_217_1.talkMaxDuration = var_220_30

					if var_220_30 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_30 + var_220_23
					end
				end

				arg_217_1.text_.text = var_220_27
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261053", "story_v_out_410261.awb") ~= 0 then
					local var_220_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261053", "story_v_out_410261.awb") / 1000

					if var_220_31 + var_220_23 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_31 + var_220_23
					end

					if var_220_26.prefab_name ~= "" and arg_217_1.actors_[var_220_26.prefab_name] ~= nil then
						local var_220_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_26.prefab_name].transform, "story_v_out_410261", "410261053", "story_v_out_410261.awb")

						arg_217_1:RecordAudio("410261053", var_220_32)
						arg_217_1:RecordAudio("410261053", var_220_32)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410261", "410261053", "story_v_out_410261.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410261", "410261053", "story_v_out_410261.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_33 = math.max(var_220_24, arg_217_1.talkMaxDuration)

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_33 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_23) / var_220_33

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_23 + var_220_33 and arg_217_1.time_ < var_220_23 + var_220_33 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play410261054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410261054
		arg_221_1.duration_ = 3.53

		local var_221_0 = {
			ja = 3.533,
			CriLanguages = 1.333,
			zh = 1.333
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
				arg_221_0:Play410261055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1060"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1060 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1060", 2)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1060, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_224_7 = arg_221_1.actors_["1060"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1060 == nil then
				arg_221_1.var_.actorSpriteComps1060 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 0.034

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps1060 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps1060 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1060 = nil
			end

			local var_224_15 = arg_221_1.actors_["1012"]
			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1012 == nil then
				arg_221_1.var_.actorSpriteComps1012 = var_224_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_17 = 0.034

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 and not isNil(var_224_15) then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17

				if arg_221_1.var_.actorSpriteComps1012 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								local var_224_19 = Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor2.r, var_224_18)
								local var_224_20 = Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor2.g, var_224_18)
								local var_224_21 = Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor2.b, var_224_18)

								iter_224_6.color = Color.New(var_224_19, var_224_20, var_224_21)
							else
								local var_224_22 = Mathf.Lerp(iter_224_6.color.r, 0.5, var_224_18)

								iter_224_6.color = Color.New(var_224_22, var_224_22, var_224_22)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 and not isNil(var_224_15) and arg_221_1.var_.actorSpriteComps1012 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_224_8 then
						if arg_221_1.isInRecall_ then
							iter_224_8.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1012 = nil
			end

			local var_224_23 = 0
			local var_224_24 = 0.125

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_25 = arg_221_1:FormatText(StoryNameCfg[584].name)

				arg_221_1.leftNameTxt_.text = var_224_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_26 = arg_221_1:GetWordFromCfg(410261054)
				local var_224_27 = arg_221_1:FormatText(var_224_26.content)

				arg_221_1.text_.text = var_224_27

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261054", "story_v_out_410261.awb") ~= 0 then
					local var_224_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261054", "story_v_out_410261.awb") / 1000

					if var_224_31 + var_224_23 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_31 + var_224_23
					end

					if var_224_26.prefab_name ~= "" and arg_221_1.actors_[var_224_26.prefab_name] ~= nil then
						local var_224_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_26.prefab_name].transform, "story_v_out_410261", "410261054", "story_v_out_410261.awb")

						arg_221_1:RecordAudio("410261054", var_224_32)
						arg_221_1:RecordAudio("410261054", var_224_32)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410261", "410261054", "story_v_out_410261.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410261", "410261054", "story_v_out_410261.awb")
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
				actorName = "1060",
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
	Play410261055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410261055
		arg_225_1.duration_ = 16.33

		local var_225_0 = {
			ja = 16.333,
			CriLanguages = 6.766,
			zh = 6.766
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
				arg_225_0:Play410261056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1012"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1012 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1012", 4)

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
				local var_228_6 = Vector3.New(390, -465, 300)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1012, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_228_7 = arg_225_1.actors_["1012"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1012 == nil then
				arg_225_1.var_.actorSpriteComps1012 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 0.034

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps1012 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor1.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor1.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor1.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 1, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps1012 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1012 = nil
			end

			local var_228_15 = arg_225_1.actors_["1060"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1060 == nil then
				arg_225_1.var_.actorSpriteComps1060 = var_228_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_17 = 0.034

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.actorSpriteComps1060 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								local var_228_19 = Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, var_228_18)
								local var_228_20 = Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, var_228_18)
								local var_228_21 = Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, var_228_18)

								iter_228_6.color = Color.New(var_228_19, var_228_20, var_228_21)
							else
								local var_228_22 = Mathf.Lerp(iter_228_6.color.r, 0.5, var_228_18)

								iter_228_6.color = Color.New(var_228_22, var_228_22, var_228_22)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps1060 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_228_8 then
						if arg_225_1.isInRecall_ then
							iter_228_8.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1060 = nil
			end

			local var_228_23 = 0
			local var_228_24 = 0.825

			if var_228_23 < arg_225_1.time_ and arg_225_1.time_ <= var_228_23 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_25 = arg_225_1:FormatText(StoryNameCfg[595].name)

				arg_225_1.leftNameTxt_.text = var_228_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_26 = arg_225_1:GetWordFromCfg(410261055)
				local var_228_27 = arg_225_1:FormatText(var_228_26.content)

				arg_225_1.text_.text = var_228_27

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_28 = 33
				local var_228_29 = utf8.len(var_228_27)
				local var_228_30 = var_228_28 <= 0 and var_228_24 or var_228_24 * (var_228_29 / var_228_28)

				if var_228_30 > 0 and var_228_24 < var_228_30 then
					arg_225_1.talkMaxDuration = var_228_30

					if var_228_30 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_30 + var_228_23
					end
				end

				arg_225_1.text_.text = var_228_27
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261055", "story_v_out_410261.awb") ~= 0 then
					local var_228_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261055", "story_v_out_410261.awb") / 1000

					if var_228_31 + var_228_23 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_31 + var_228_23
					end

					if var_228_26.prefab_name ~= "" and arg_225_1.actors_[var_228_26.prefab_name] ~= nil then
						local var_228_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_26.prefab_name].transform, "story_v_out_410261", "410261055", "story_v_out_410261.awb")

						arg_225_1:RecordAudio("410261055", var_228_32)
						arg_225_1:RecordAudio("410261055", var_228_32)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410261", "410261055", "story_v_out_410261.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410261", "410261055", "story_v_out_410261.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_33 = math.max(var_228_24, arg_225_1.talkMaxDuration)

			if var_228_23 <= arg_225_1.time_ and arg_225_1.time_ < var_228_23 + var_228_33 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_23) / var_228_33

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_23 + var_228_33 and arg_225_1.time_ < var_228_23 + var_228_33 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410261056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410261056
		arg_229_1.duration_ = 5.3

		local var_229_0 = {
			ja = 5.3,
			CriLanguages = 3.533,
			zh = 3.533
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
				arg_229_0:Play410261057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.45

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[595].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(410261056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261056", "story_v_out_410261.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261056", "story_v_out_410261.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_410261", "410261056", "story_v_out_410261.awb")

						arg_229_1:RecordAudio("410261056", var_232_9)
						arg_229_1:RecordAudio("410261056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410261", "410261056", "story_v_out_410261.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410261", "410261056", "story_v_out_410261.awb")
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
	Play410261057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410261057
		arg_233_1.duration_ = 4.4

		local var_233_0 = {
			ja = 4.4,
			CriLanguages = 1.466,
			zh = 1.466
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
				arg_233_0:Play410261058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1060"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1060 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1060", 2)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1060, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_236_7 = arg_233_1.actors_["1012"]
			local var_236_8 = 0

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1012 == nil then
				arg_233_1.var_.actorSpriteComps1012 = var_236_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 0.034

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 and not isNil(var_236_7) then
				local var_236_10 = (arg_233_1.time_ - var_236_8) / var_236_9

				if arg_233_1.var_.actorSpriteComps1012 then
					for iter_236_1, iter_236_2 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_236_2 then
							if arg_233_1.isInRecall_ then
								local var_236_11 = Mathf.Lerp(iter_236_2.color.r, arg_233_1.hightColor2.r, var_236_10)
								local var_236_12 = Mathf.Lerp(iter_236_2.color.g, arg_233_1.hightColor2.g, var_236_10)
								local var_236_13 = Mathf.Lerp(iter_236_2.color.b, arg_233_1.hightColor2.b, var_236_10)

								iter_236_2.color = Color.New(var_236_11, var_236_12, var_236_13)
							else
								local var_236_14 = Mathf.Lerp(iter_236_2.color.r, 0.5, var_236_10)

								iter_236_2.color = Color.New(var_236_14, var_236_14, var_236_14)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 and not isNil(var_236_7) and arg_233_1.var_.actorSpriteComps1012 then
				for iter_236_3, iter_236_4 in pairs(arg_233_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_236_4 then
						if arg_233_1.isInRecall_ then
							iter_236_4.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1012 = nil
			end

			local var_236_15 = arg_233_1.actors_["1060"]
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1060 == nil then
				arg_233_1.var_.actorSpriteComps1060 = var_236_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_17 = 0.034

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 and not isNil(var_236_15) then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17

				if arg_233_1.var_.actorSpriteComps1060 then
					for iter_236_5, iter_236_6 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_236_6 then
							if arg_233_1.isInRecall_ then
								local var_236_19 = Mathf.Lerp(iter_236_6.color.r, arg_233_1.hightColor1.r, var_236_18)
								local var_236_20 = Mathf.Lerp(iter_236_6.color.g, arg_233_1.hightColor1.g, var_236_18)
								local var_236_21 = Mathf.Lerp(iter_236_6.color.b, arg_233_1.hightColor1.b, var_236_18)

								iter_236_6.color = Color.New(var_236_19, var_236_20, var_236_21)
							else
								local var_236_22 = Mathf.Lerp(iter_236_6.color.r, 1, var_236_18)

								iter_236_6.color = Color.New(var_236_22, var_236_22, var_236_22)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.actorSpriteComps1060 then
				for iter_236_7, iter_236_8 in pairs(arg_233_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_236_8 then
						if arg_233_1.isInRecall_ then
							iter_236_8.color = arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_236_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1060 = nil
			end

			local var_236_23 = 0
			local var_236_24 = 0.175

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_25 = arg_233_1:FormatText(StoryNameCfg[584].name)

				arg_233_1.leftNameTxt_.text = var_236_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:GetWordFromCfg(410261057)
				local var_236_27 = arg_233_1:FormatText(var_236_26.content)

				arg_233_1.text_.text = var_236_27

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_28 = 7
				local var_236_29 = utf8.len(var_236_27)
				local var_236_30 = var_236_28 <= 0 and var_236_24 or var_236_24 * (var_236_29 / var_236_28)

				if var_236_30 > 0 and var_236_24 < var_236_30 then
					arg_233_1.talkMaxDuration = var_236_30

					if var_236_30 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_30 + var_236_23
					end
				end

				arg_233_1.text_.text = var_236_27
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261057", "story_v_out_410261.awb") ~= 0 then
					local var_236_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261057", "story_v_out_410261.awb") / 1000

					if var_236_31 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_31 + var_236_23
					end

					if var_236_26.prefab_name ~= "" and arg_233_1.actors_[var_236_26.prefab_name] ~= nil then
						local var_236_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_26.prefab_name].transform, "story_v_out_410261", "410261057", "story_v_out_410261.awb")

						arg_233_1:RecordAudio("410261057", var_236_32)
						arg_233_1:RecordAudio("410261057", var_236_32)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_410261", "410261057", "story_v_out_410261.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_410261", "410261057", "story_v_out_410261.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_33 = math.max(var_236_24, arg_233_1.talkMaxDuration)

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_33 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_23) / var_236_33

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_23 + var_236_33 and arg_233_1.time_ < var_236_23 + var_236_33 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410261058
		arg_237_1.duration_ = 12.93

		local var_237_0 = {
			ja = 12.933,
			CriLanguages = 5,
			zh = 5
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
				arg_237_0:Play410261059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1012"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1012 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1012", 4)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_3" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(390, -465, 300)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1012, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_240_7 = arg_237_1.actors_["1012"]
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1012 == nil then
				arg_237_1.var_.actorSpriteComps1012 = var_240_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_9 = 0.034

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 and not isNil(var_240_7) then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / var_240_9

				if arg_237_1.var_.actorSpriteComps1012 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								local var_240_11 = Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor1.r, var_240_10)
								local var_240_12 = Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor1.g, var_240_10)
								local var_240_13 = Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor1.b, var_240_10)

								iter_240_2.color = Color.New(var_240_11, var_240_12, var_240_13)
							else
								local var_240_14 = Mathf.Lerp(iter_240_2.color.r, 1, var_240_10)

								iter_240_2.color = Color.New(var_240_14, var_240_14, var_240_14)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 and not isNil(var_240_7) and arg_237_1.var_.actorSpriteComps1012 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_240_4 then
						if arg_237_1.isInRecall_ then
							iter_240_4.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1012 = nil
			end

			local var_240_15 = arg_237_1.actors_["1060"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1060 == nil then
				arg_237_1.var_.actorSpriteComps1060 = var_240_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_17 = 0.034

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.actorSpriteComps1060 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								local var_240_19 = Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor2.r, var_240_18)
								local var_240_20 = Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor2.g, var_240_18)
								local var_240_21 = Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor2.b, var_240_18)

								iter_240_6.color = Color.New(var_240_19, var_240_20, var_240_21)
							else
								local var_240_22 = Mathf.Lerp(iter_240_6.color.r, 0.5, var_240_18)

								iter_240_6.color = Color.New(var_240_22, var_240_22, var_240_22)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.actorSpriteComps1060 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_240_8 then
						if arg_237_1.isInRecall_ then
							iter_240_8.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps1060 = nil
			end

			local var_240_23 = 0
			local var_240_24 = 0.475

			if var_240_23 < arg_237_1.time_ and arg_237_1.time_ <= var_240_23 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_25 = arg_237_1:FormatText(StoryNameCfg[595].name)

				arg_237_1.leftNameTxt_.text = var_240_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_26 = arg_237_1:GetWordFromCfg(410261058)
				local var_240_27 = arg_237_1:FormatText(var_240_26.content)

				arg_237_1.text_.text = var_240_27

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_28 = 19
				local var_240_29 = utf8.len(var_240_27)
				local var_240_30 = var_240_28 <= 0 and var_240_24 or var_240_24 * (var_240_29 / var_240_28)

				if var_240_30 > 0 and var_240_24 < var_240_30 then
					arg_237_1.talkMaxDuration = var_240_30

					if var_240_30 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_30 + var_240_23
					end
				end

				arg_237_1.text_.text = var_240_27
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261058", "story_v_out_410261.awb") ~= 0 then
					local var_240_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261058", "story_v_out_410261.awb") / 1000

					if var_240_31 + var_240_23 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_31 + var_240_23
					end

					if var_240_26.prefab_name ~= "" and arg_237_1.actors_[var_240_26.prefab_name] ~= nil then
						local var_240_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_26.prefab_name].transform, "story_v_out_410261", "410261058", "story_v_out_410261.awb")

						arg_237_1:RecordAudio("410261058", var_240_32)
						arg_237_1:RecordAudio("410261058", var_240_32)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_410261", "410261058", "story_v_out_410261.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_410261", "410261058", "story_v_out_410261.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_33 = math.max(var_240_24, arg_237_1.talkMaxDuration)

			if var_240_23 <= arg_237_1.time_ and arg_237_1.time_ < var_240_23 + var_240_33 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_23) / var_240_33

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_23 + var_240_33 and arg_237_1.time_ < var_240_23 + var_240_33 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410261059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410261059
		arg_241_1.duration_ = 9.03

		local var_241_0 = {
			ja = 9.033,
			CriLanguages = 4.2,
			zh = 4.2
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
				arg_241_0:Play410261060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1060"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1060 = var_244_0.localPosition
				var_244_0.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1060", 2)

				local var_244_2 = var_244_0.childCount

				for iter_244_0 = 0, var_244_2 - 1 do
					local var_244_3 = var_244_0:GetChild(iter_244_0)

					if var_244_3.name == "" or not string.find(var_244_3.name, "split") then
						var_244_3.gameObject:SetActive(true)
					else
						var_244_3.gameObject:SetActive(false)
					end
				end
			end

			local var_244_4 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_4 then
				local var_244_5 = (arg_241_1.time_ - var_244_1) / var_244_4
				local var_244_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1060, var_244_6, var_244_5)
			end

			if arg_241_1.time_ >= var_244_1 + var_244_4 and arg_241_1.time_ < var_244_1 + var_244_4 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_244_7 = arg_241_1.actors_["1012"]
			local var_244_8 = 0

			if var_244_8 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1012 == nil then
				arg_241_1.var_.actorSpriteComps1012 = var_244_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_9 = 0.034

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_9 and not isNil(var_244_7) then
				local var_244_10 = (arg_241_1.time_ - var_244_8) / var_244_9

				if arg_241_1.var_.actorSpriteComps1012 then
					for iter_244_1, iter_244_2 in pairs(arg_241_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_244_2 then
							if arg_241_1.isInRecall_ then
								local var_244_11 = Mathf.Lerp(iter_244_2.color.r, arg_241_1.hightColor2.r, var_244_10)
								local var_244_12 = Mathf.Lerp(iter_244_2.color.g, arg_241_1.hightColor2.g, var_244_10)
								local var_244_13 = Mathf.Lerp(iter_244_2.color.b, arg_241_1.hightColor2.b, var_244_10)

								iter_244_2.color = Color.New(var_244_11, var_244_12, var_244_13)
							else
								local var_244_14 = Mathf.Lerp(iter_244_2.color.r, 0.5, var_244_10)

								iter_244_2.color = Color.New(var_244_14, var_244_14, var_244_14)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_8 + var_244_9 and arg_241_1.time_ < var_244_8 + var_244_9 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.actorSpriteComps1012 then
				for iter_244_3, iter_244_4 in pairs(arg_241_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_244_4 then
						if arg_241_1.isInRecall_ then
							iter_244_4.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1012 = nil
			end

			local var_244_15 = arg_241_1.actors_["1060"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1060 == nil then
				arg_241_1.var_.actorSpriteComps1060 = var_244_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_17 = 0.034

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.actorSpriteComps1060 then
					for iter_244_5, iter_244_6 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_244_6 then
							if arg_241_1.isInRecall_ then
								local var_244_19 = Mathf.Lerp(iter_244_6.color.r, arg_241_1.hightColor1.r, var_244_18)
								local var_244_20 = Mathf.Lerp(iter_244_6.color.g, arg_241_1.hightColor1.g, var_244_18)
								local var_244_21 = Mathf.Lerp(iter_244_6.color.b, arg_241_1.hightColor1.b, var_244_18)

								iter_244_6.color = Color.New(var_244_19, var_244_20, var_244_21)
							else
								local var_244_22 = Mathf.Lerp(iter_244_6.color.r, 1, var_244_18)

								iter_244_6.color = Color.New(var_244_22, var_244_22, var_244_22)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.actorSpriteComps1060 then
				for iter_244_7, iter_244_8 in pairs(arg_241_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_244_8 then
						if arg_241_1.isInRecall_ then
							iter_244_8.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1060 = nil
			end

			local var_244_23 = 0
			local var_244_24 = 0.55

			if var_244_23 < arg_241_1.time_ and arg_241_1.time_ <= var_244_23 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_25 = arg_241_1:FormatText(StoryNameCfg[584].name)

				arg_241_1.leftNameTxt_.text = var_244_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_26 = arg_241_1:GetWordFromCfg(410261059)
				local var_244_27 = arg_241_1:FormatText(var_244_26.content)

				arg_241_1.text_.text = var_244_27

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 21
				local var_244_29 = utf8.len(var_244_27)
				local var_244_30 = var_244_28 <= 0 and var_244_24 or var_244_24 * (var_244_29 / var_244_28)

				if var_244_30 > 0 and var_244_24 < var_244_30 then
					arg_241_1.talkMaxDuration = var_244_30

					if var_244_30 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_30 + var_244_23
					end
				end

				arg_241_1.text_.text = var_244_27
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261059", "story_v_out_410261.awb") ~= 0 then
					local var_244_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261059", "story_v_out_410261.awb") / 1000

					if var_244_31 + var_244_23 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_31 + var_244_23
					end

					if var_244_26.prefab_name ~= "" and arg_241_1.actors_[var_244_26.prefab_name] ~= nil then
						local var_244_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_26.prefab_name].transform, "story_v_out_410261", "410261059", "story_v_out_410261.awb")

						arg_241_1:RecordAudio("410261059", var_244_32)
						arg_241_1:RecordAudio("410261059", var_244_32)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410261", "410261059", "story_v_out_410261.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410261", "410261059", "story_v_out_410261.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_33 = math.max(var_244_24, arg_241_1.talkMaxDuration)

			if var_244_23 <= arg_241_1.time_ and arg_241_1.time_ < var_244_23 + var_244_33 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_23) / var_244_33

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_23 + var_244_33 and arg_241_1.time_ < var_244_23 + var_244_33 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play410261060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410261060
		arg_245_1.duration_ = 4.83

		local var_245_0 = {
			ja = 4.833,
			CriLanguages = 1.266,
			zh = 1.266
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
				arg_245_0:Play410261061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1012"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1012 = var_248_0.localPosition
				var_248_0.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1012", 4)

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
				local var_248_6 = Vector3.New(390, -465, 300)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1012, var_248_6, var_248_5)
			end

			if arg_245_1.time_ >= var_248_1 + var_248_4 and arg_245_1.time_ < var_248_1 + var_248_4 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_248_7 = arg_245_1.actors_["1012"]
			local var_248_8 = 0

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps1012 == nil then
				arg_245_1.var_.actorSpriteComps1012 = var_248_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_9 = 0.034

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_9 and not isNil(var_248_7) then
				local var_248_10 = (arg_245_1.time_ - var_248_8) / var_248_9

				if arg_245_1.var_.actorSpriteComps1012 then
					for iter_248_1, iter_248_2 in pairs(arg_245_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_245_1.time_ >= var_248_8 + var_248_9 and arg_245_1.time_ < var_248_8 + var_248_9 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.actorSpriteComps1012 then
				for iter_248_3, iter_248_4 in pairs(arg_245_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_248_4 then
						if arg_245_1.isInRecall_ then
							iter_248_4.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1012 = nil
			end

			local var_248_15 = arg_245_1.actors_["1060"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps1060 == nil then
				arg_245_1.var_.actorSpriteComps1060 = var_248_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_17 = 0.034

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.actorSpriteComps1060 then
					for iter_248_5, iter_248_6 in pairs(arg_245_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.actorSpriteComps1060 then
				for iter_248_7, iter_248_8 in pairs(arg_245_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_248_8 then
						if arg_245_1.isInRecall_ then
							iter_248_8.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1060 = nil
			end

			local var_248_23 = 0
			local var_248_24 = 0.1

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_25 = arg_245_1:FormatText(StoryNameCfg[595].name)

				arg_245_1.leftNameTxt_.text = var_248_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_26 = arg_245_1:GetWordFromCfg(410261060)
				local var_248_27 = arg_245_1:FormatText(var_248_26.content)

				arg_245_1.text_.text = var_248_27

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_28 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261060", "story_v_out_410261.awb") ~= 0 then
					local var_248_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261060", "story_v_out_410261.awb") / 1000

					if var_248_31 + var_248_23 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_23
					end

					if var_248_26.prefab_name ~= "" and arg_245_1.actors_[var_248_26.prefab_name] ~= nil then
						local var_248_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_26.prefab_name].transform, "story_v_out_410261", "410261060", "story_v_out_410261.awb")

						arg_245_1:RecordAudio("410261060", var_248_32)
						arg_245_1:RecordAudio("410261060", var_248_32)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_410261", "410261060", "story_v_out_410261.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_410261", "410261060", "story_v_out_410261.awb")
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
				actorName = "1012",
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
	Play410261061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410261061
		arg_249_1.duration_ = 7.97

		local var_249_0 = {
			ja = 7.966,
			CriLanguages = 2.6,
			zh = 2.6
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
				arg_249_0:Play410261062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1060"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1060 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1060", 2)

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
				local var_252_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1060, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_252_7 = arg_249_1.actors_["1012"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1012 == nil then
				arg_249_1.var_.actorSpriteComps1012 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps1012 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								local var_252_11 = Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor2.r, var_252_10)
								local var_252_12 = Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor2.g, var_252_10)
								local var_252_13 = Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor2.b, var_252_10)

								iter_252_2.color = Color.New(var_252_11, var_252_12, var_252_13)
							else
								local var_252_14 = Mathf.Lerp(iter_252_2.color.r, 0.5, var_252_10)

								iter_252_2.color = Color.New(var_252_14, var_252_14, var_252_14)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1012 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1012 = nil
			end

			local var_252_15 = arg_249_1.actors_["1060"]
			local var_252_16 = 0

			if var_252_16 < arg_249_1.time_ and arg_249_1.time_ <= var_252_16 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1060 == nil then
				arg_249_1.var_.actorSpriteComps1060 = var_252_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_17 = 0.034

			if var_252_16 <= arg_249_1.time_ and arg_249_1.time_ < var_252_16 + var_252_17 and not isNil(var_252_15) then
				local var_252_18 = (arg_249_1.time_ - var_252_16) / var_252_17

				if arg_249_1.var_.actorSpriteComps1060 then
					for iter_252_5, iter_252_6 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_252_6 then
							if arg_249_1.isInRecall_ then
								local var_252_19 = Mathf.Lerp(iter_252_6.color.r, arg_249_1.hightColor1.r, var_252_18)
								local var_252_20 = Mathf.Lerp(iter_252_6.color.g, arg_249_1.hightColor1.g, var_252_18)
								local var_252_21 = Mathf.Lerp(iter_252_6.color.b, arg_249_1.hightColor1.b, var_252_18)

								iter_252_6.color = Color.New(var_252_19, var_252_20, var_252_21)
							else
								local var_252_22 = Mathf.Lerp(iter_252_6.color.r, 1, var_252_18)

								iter_252_6.color = Color.New(var_252_22, var_252_22, var_252_22)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_16 + var_252_17 and arg_249_1.time_ < var_252_16 + var_252_17 + arg_252_0 and not isNil(var_252_15) and arg_249_1.var_.actorSpriteComps1060 then
				for iter_252_7, iter_252_8 in pairs(arg_249_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_252_8 then
						if arg_249_1.isInRecall_ then
							iter_252_8.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1060 = nil
			end

			local var_252_23 = 0
			local var_252_24 = 0.325

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_25 = arg_249_1:FormatText(StoryNameCfg[584].name)

				arg_249_1.leftNameTxt_.text = var_252_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_26 = arg_249_1:GetWordFromCfg(410261061)
				local var_252_27 = arg_249_1:FormatText(var_252_26.content)

				arg_249_1.text_.text = var_252_27

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_28 = 13
				local var_252_29 = utf8.len(var_252_27)
				local var_252_30 = var_252_28 <= 0 and var_252_24 or var_252_24 * (var_252_29 / var_252_28)

				if var_252_30 > 0 and var_252_24 < var_252_30 then
					arg_249_1.talkMaxDuration = var_252_30

					if var_252_30 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_30 + var_252_23
					end
				end

				arg_249_1.text_.text = var_252_27
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261061", "story_v_out_410261.awb") ~= 0 then
					local var_252_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261061", "story_v_out_410261.awb") / 1000

					if var_252_31 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_31 + var_252_23
					end

					if var_252_26.prefab_name ~= "" and arg_249_1.actors_[var_252_26.prefab_name] ~= nil then
						local var_252_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_26.prefab_name].transform, "story_v_out_410261", "410261061", "story_v_out_410261.awb")

						arg_249_1:RecordAudio("410261061", var_252_32)
						arg_249_1:RecordAudio("410261061", var_252_32)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410261", "410261061", "story_v_out_410261.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410261", "410261061", "story_v_out_410261.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_33 = math.max(var_252_24, arg_249_1.talkMaxDuration)

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_33 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_23) / var_252_33

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_23 + var_252_33 and arg_249_1.time_ < var_252_23 + var_252_33 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410261062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410261062
		arg_253_1.duration_ = 5.4

		local var_253_0 = {
			ja = 5.4,
			CriLanguages = 2.9,
			zh = 2.9
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
				arg_253_0:Play410261063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1012"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1012 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1012", 4)

				local var_256_2 = var_256_0.childCount

				for iter_256_0 = 0, var_256_2 - 1 do
					local var_256_3 = var_256_0:GetChild(iter_256_0)

					if var_256_3.name == "" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_4 then
				local var_256_5 = (arg_253_1.time_ - var_256_1) / var_256_4
				local var_256_6 = Vector3.New(390, -465, 300)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1012, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_256_7 = arg_253_1.actors_["1012"]
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1012 == nil then
				arg_253_1.var_.actorSpriteComps1012 = var_256_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 0.034

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_9 and not isNil(var_256_7) then
				local var_256_10 = (arg_253_1.time_ - var_256_8) / var_256_9

				if arg_253_1.var_.actorSpriteComps1012 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_256_2 then
							if arg_253_1.isInRecall_ then
								local var_256_11 = Mathf.Lerp(iter_256_2.color.r, arg_253_1.hightColor1.r, var_256_10)
								local var_256_12 = Mathf.Lerp(iter_256_2.color.g, arg_253_1.hightColor1.g, var_256_10)
								local var_256_13 = Mathf.Lerp(iter_256_2.color.b, arg_253_1.hightColor1.b, var_256_10)

								iter_256_2.color = Color.New(var_256_11, var_256_12, var_256_13)
							else
								local var_256_14 = Mathf.Lerp(iter_256_2.color.r, 1, var_256_10)

								iter_256_2.color = Color.New(var_256_14, var_256_14, var_256_14)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_8 + var_256_9 and arg_253_1.time_ < var_256_8 + var_256_9 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1012 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_256_4 then
						if arg_253_1.isInRecall_ then
							iter_256_4.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1012 = nil
			end

			local var_256_15 = arg_253_1.actors_["1060"]
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.actorSpriteComps1060 == nil then
				arg_253_1.var_.actorSpriteComps1060 = var_256_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_17 = 0.034

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 and not isNil(var_256_15) then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17

				if arg_253_1.var_.actorSpriteComps1060 then
					for iter_256_5, iter_256_6 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_256_6 then
							if arg_253_1.isInRecall_ then
								local var_256_19 = Mathf.Lerp(iter_256_6.color.r, arg_253_1.hightColor2.r, var_256_18)
								local var_256_20 = Mathf.Lerp(iter_256_6.color.g, arg_253_1.hightColor2.g, var_256_18)
								local var_256_21 = Mathf.Lerp(iter_256_6.color.b, arg_253_1.hightColor2.b, var_256_18)

								iter_256_6.color = Color.New(var_256_19, var_256_20, var_256_21)
							else
								local var_256_22 = Mathf.Lerp(iter_256_6.color.r, 0.5, var_256_18)

								iter_256_6.color = Color.New(var_256_22, var_256_22, var_256_22)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.actorSpriteComps1060 then
				for iter_256_7, iter_256_8 in pairs(arg_253_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_256_8 then
						if arg_253_1.isInRecall_ then
							iter_256_8.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1060 = nil
			end

			local var_256_23 = 0
			local var_256_24 = 0.4

			if var_256_23 < arg_253_1.time_ and arg_253_1.time_ <= var_256_23 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_25 = arg_253_1:FormatText(StoryNameCfg[595].name)

				arg_253_1.leftNameTxt_.text = var_256_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_26 = arg_253_1:GetWordFromCfg(410261062)
				local var_256_27 = arg_253_1:FormatText(var_256_26.content)

				arg_253_1.text_.text = var_256_27

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_28 = 16
				local var_256_29 = utf8.len(var_256_27)
				local var_256_30 = var_256_28 <= 0 and var_256_24 or var_256_24 * (var_256_29 / var_256_28)

				if var_256_30 > 0 and var_256_24 < var_256_30 then
					arg_253_1.talkMaxDuration = var_256_30

					if var_256_30 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_30 + var_256_23
					end
				end

				arg_253_1.text_.text = var_256_27
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261062", "story_v_out_410261.awb") ~= 0 then
					local var_256_31 = manager.audio:GetVoiceLength("story_v_out_410261", "410261062", "story_v_out_410261.awb") / 1000

					if var_256_31 + var_256_23 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_31 + var_256_23
					end

					if var_256_26.prefab_name ~= "" and arg_253_1.actors_[var_256_26.prefab_name] ~= nil then
						local var_256_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_26.prefab_name].transform, "story_v_out_410261", "410261062", "story_v_out_410261.awb")

						arg_253_1:RecordAudio("410261062", var_256_32)
						arg_253_1:RecordAudio("410261062", var_256_32)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410261", "410261062", "story_v_out_410261.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410261", "410261062", "story_v_out_410261.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_33 = math.max(var_256_24, arg_253_1.talkMaxDuration)

			if var_256_23 <= arg_253_1.time_ and arg_253_1.time_ < var_256_23 + var_256_33 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_23) / var_256_33

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_23 + var_256_33 and arg_253_1.time_ < var_256_23 + var_256_33 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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
	Play410261063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410261063
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play410261064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = "STblack"

			if arg_257_1.bgs_[var_260_0] == nil then
				local var_260_1 = Object.Instantiate(arg_257_1.paintGo_)

				var_260_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_260_0)
				var_260_1.name = var_260_0
				var_260_1.transform.parent = arg_257_1.stage_.transform
				var_260_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.bgs_[var_260_0] = var_260_1
			end

			local var_260_2 = 2

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				local var_260_3 = manager.ui.mainCamera.transform.localPosition
				local var_260_4 = Vector3.New(0, 0, 10) + Vector3.New(var_260_3.x, var_260_3.y, 0)
				local var_260_5 = arg_257_1.bgs_.STblack

				var_260_5.transform.localPosition = var_260_4
				var_260_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_6 = var_260_5:GetComponent("SpriteRenderer")

				if var_260_6 and var_260_6.sprite then
					local var_260_7 = (var_260_5.transform.localPosition - var_260_3).z
					local var_260_8 = manager.ui.mainCameraCom_
					local var_260_9 = 2 * var_260_7 * Mathf.Tan(var_260_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_260_10 = var_260_9 * var_260_8.aspect
					local var_260_11 = var_260_6.sprite.bounds.size.x
					local var_260_12 = var_260_6.sprite.bounds.size.y
					local var_260_13 = var_260_10 / var_260_11
					local var_260_14 = var_260_9 / var_260_12
					local var_260_15 = var_260_14 < var_260_13 and var_260_13 or var_260_14

					var_260_5.transform.localScale = Vector3.New(var_260_15, var_260_15, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "STblack" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_17 = 2

			if var_260_16 <= arg_257_1.time_ and arg_257_1.time_ < var_260_16 + var_260_17 then
				local var_260_18 = (arg_257_1.time_ - var_260_16) / var_260_17
				local var_260_19 = Color.New(0, 0, 0)

				var_260_19.a = Mathf.Lerp(0, 1, var_260_18)
				arg_257_1.mask_.color = var_260_19
			end

			if arg_257_1.time_ >= var_260_16 + var_260_17 and arg_257_1.time_ < var_260_16 + var_260_17 + arg_260_0 then
				local var_260_20 = Color.New(0, 0, 0)

				var_260_20.a = 1
				arg_257_1.mask_.color = var_260_20
			end

			local var_260_21 = 2

			if var_260_21 < arg_257_1.time_ and arg_257_1.time_ <= var_260_21 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_22 = 2

			if var_260_21 <= arg_257_1.time_ and arg_257_1.time_ < var_260_21 + var_260_22 then
				local var_260_23 = (arg_257_1.time_ - var_260_21) / var_260_22
				local var_260_24 = Color.New(0, 0, 0)

				var_260_24.a = Mathf.Lerp(1, 0, var_260_23)
				arg_257_1.mask_.color = var_260_24
			end

			if arg_257_1.time_ >= var_260_21 + var_260_22 and arg_257_1.time_ < var_260_21 + var_260_22 + arg_260_0 then
				local var_260_25 = Color.New(0, 0, 0)
				local var_260_26 = 0

				arg_257_1.mask_.enabled = false
				var_260_25.a = var_260_26
				arg_257_1.mask_.color = var_260_25
			end

			local var_260_27 = arg_257_1.actors_["1060"].transform
			local var_260_28 = 2

			if var_260_28 < arg_257_1.time_ and arg_257_1.time_ <= var_260_28 + arg_260_0 then
				arg_257_1.var_.moveOldPos1060 = var_260_27.localPosition
				var_260_27.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1060", 7)

				local var_260_29 = var_260_27.childCount

				for iter_260_2 = 0, var_260_29 - 1 do
					local var_260_30 = var_260_27:GetChild(iter_260_2)

					if var_260_30.name == "" or not string.find(var_260_30.name, "split") then
						var_260_30.gameObject:SetActive(true)
					else
						var_260_30.gameObject:SetActive(false)
					end
				end
			end

			local var_260_31 = 0.001

			if var_260_28 <= arg_257_1.time_ and arg_257_1.time_ < var_260_28 + var_260_31 then
				local var_260_32 = (arg_257_1.time_ - var_260_28) / var_260_31
				local var_260_33 = Vector3.New(0, -2000, -40)

				var_260_27.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1060, var_260_33, var_260_32)
			end

			if arg_257_1.time_ >= var_260_28 + var_260_31 and arg_257_1.time_ < var_260_28 + var_260_31 + arg_260_0 then
				var_260_27.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_260_34 = arg_257_1.actors_["1012"].transform
			local var_260_35 = 2

			if var_260_35 < arg_257_1.time_ and arg_257_1.time_ <= var_260_35 + arg_260_0 then
				arg_257_1.var_.moveOldPos1012 = var_260_34.localPosition
				var_260_34.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1012", 7)

				local var_260_36 = var_260_34.childCount

				for iter_260_3 = 0, var_260_36 - 1 do
					local var_260_37 = var_260_34:GetChild(iter_260_3)

					if var_260_37.name == "" or not string.find(var_260_37.name, "split") then
						var_260_37.gameObject:SetActive(true)
					else
						var_260_37.gameObject:SetActive(false)
					end
				end
			end

			local var_260_38 = 0.001

			if var_260_35 <= arg_257_1.time_ and arg_257_1.time_ < var_260_35 + var_260_38 then
				local var_260_39 = (arg_257_1.time_ - var_260_35) / var_260_38
				local var_260_40 = Vector3.New(0, -2000, 300)

				var_260_34.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1012, var_260_40, var_260_39)
			end

			if arg_257_1.time_ >= var_260_35 + var_260_38 and arg_257_1.time_ < var_260_35 + var_260_38 + arg_260_0 then
				var_260_34.localPosition = Vector3.New(0, -2000, 300)
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_41 = 4
			local var_260_42 = 0.35

			if var_260_41 < arg_257_1.time_ and arg_257_1.time_ <= var_260_41 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_43 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_43:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_44 = arg_257_1:GetWordFromCfg(410261063)
				local var_260_45 = arg_257_1:FormatText(var_260_44.content)

				arg_257_1.text_.text = var_260_45

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_46 = 14
				local var_260_47 = utf8.len(var_260_45)
				local var_260_48 = var_260_46 <= 0 and var_260_42 or var_260_42 * (var_260_47 / var_260_46)

				if var_260_48 > 0 and var_260_42 < var_260_48 then
					arg_257_1.talkMaxDuration = var_260_48
					var_260_41 = var_260_41 + 0.3

					if var_260_48 + var_260_41 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_48 + var_260_41
					end
				end

				arg_257_1.text_.text = var_260_45
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_49 = var_260_41 + 0.3
			local var_260_50 = math.max(var_260_42, arg_257_1.talkMaxDuration)

			if var_260_49 <= arg_257_1.time_ and arg_257_1.time_ < var_260_49 + var_260_50 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_49) / var_260_50

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_49 + var_260_50 and arg_257_1.time_ < var_260_49 + var_260_50 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play410261064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 410261064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play410261065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 1.525

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(410261064)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 61
				local var_266_5 = utf8.len(var_266_3)
				local var_266_6 = var_266_4 <= 0 and var_266_1 or var_266_1 * (var_266_5 / var_266_4)

				if var_266_6 > 0 and var_266_1 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_7 and arg_263_1.time_ < var_266_0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play410261065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 410261065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play410261066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0
			local var_270_1 = 1.125

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(410261065)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 45
				local var_270_5 = utf8.len(var_270_3)
				local var_270_6 = var_270_4 <= 0 and var_270_1 or var_270_1 * (var_270_5 / var_270_4)

				if var_270_6 > 0 and var_270_1 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_7 and arg_267_1.time_ < var_270_0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play410261066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 410261066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play410261067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.575

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(410261066)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 23
				local var_274_5 = utf8.len(var_274_3)
				local var_274_6 = var_274_4 <= 0 and var_274_1 or var_274_1 * (var_274_5 / var_274_4)

				if var_274_6 > 0 and var_274_1 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_7 and arg_271_1.time_ < var_274_0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play410261067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 410261067
		arg_275_1.duration_ = 7

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play410261068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				local var_278_1 = manager.ui.mainCamera.transform.localPosition
				local var_278_2 = Vector3.New(0, 0, 10) + Vector3.New(var_278_1.x, var_278_1.y, 0)
				local var_278_3 = arg_275_1.bgs_.L01f

				var_278_3.transform.localPosition = var_278_2
				var_278_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_4 = var_278_3:GetComponent("SpriteRenderer")

				if var_278_4 and var_278_4.sprite then
					local var_278_5 = (var_278_3.transform.localPosition - var_278_1).z
					local var_278_6 = manager.ui.mainCameraCom_
					local var_278_7 = 2 * var_278_5 * Mathf.Tan(var_278_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_278_8 = var_278_7 * var_278_6.aspect
					local var_278_9 = var_278_4.sprite.bounds.size.x
					local var_278_10 = var_278_4.sprite.bounds.size.y
					local var_278_11 = var_278_8 / var_278_9
					local var_278_12 = var_278_7 / var_278_10
					local var_278_13 = var_278_12 < var_278_11 and var_278_11 or var_278_12

					var_278_3.transform.localScale = Vector3.New(var_278_13, var_278_13, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "L01f" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_14 = 0

			if var_278_14 < arg_275_1.time_ and arg_275_1.time_ <= var_278_14 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_15 = 2

			if var_278_14 <= arg_275_1.time_ and arg_275_1.time_ < var_278_14 + var_278_15 then
				local var_278_16 = (arg_275_1.time_ - var_278_14) / var_278_15
				local var_278_17 = Color.New(0, 0, 0)

				var_278_17.a = Mathf.Lerp(1, 0, var_278_16)
				arg_275_1.mask_.color = var_278_17
			end

			if arg_275_1.time_ >= var_278_14 + var_278_15 and arg_275_1.time_ < var_278_14 + var_278_15 + arg_278_0 then
				local var_278_18 = Color.New(0, 0, 0)
				local var_278_19 = 0

				arg_275_1.mask_.enabled = false
				var_278_18.a = var_278_19
				arg_275_1.mask_.color = var_278_18
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_20 = 2
			local var_278_21 = 1.65

			if var_278_20 < arg_275_1.time_ and arg_275_1.time_ <= var_278_20 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_22 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_22:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_23 = arg_275_1:GetWordFromCfg(410261067)
				local var_278_24 = arg_275_1:FormatText(var_278_23.content)

				arg_275_1.text_.text = var_278_24

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_25 = 66
				local var_278_26 = utf8.len(var_278_24)
				local var_278_27 = var_278_25 <= 0 and var_278_21 or var_278_21 * (var_278_26 / var_278_25)

				if var_278_27 > 0 and var_278_21 < var_278_27 then
					arg_275_1.talkMaxDuration = var_278_27
					var_278_20 = var_278_20 + 0.3

					if var_278_27 + var_278_20 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_27 + var_278_20
					end
				end

				arg_275_1.text_.text = var_278_24
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_28 = var_278_20 + 0.3
			local var_278_29 = math.max(var_278_21, arg_275_1.talkMaxDuration)

			if var_278_28 <= arg_275_1.time_ and arg_275_1.time_ < var_278_28 + var_278_29 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_28) / var_278_29

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_28 + var_278_29 and arg_275_1.time_ < var_278_28 + var_278_29 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play410261068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410261068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play410261069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 1.5

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(410261068)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 60
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410261069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410261069
		arg_285_1.duration_ = 9

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410261070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = "L03f"

			if arg_285_1.bgs_[var_288_0] == nil then
				local var_288_1 = Object.Instantiate(arg_285_1.paintGo_)

				var_288_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_288_0)
				var_288_1.name = var_288_0
				var_288_1.transform.parent = arg_285_1.stage_.transform
				var_288_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.bgs_[var_288_0] = var_288_1
			end

			local var_288_2 = 2

			if var_288_2 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				local var_288_3 = manager.ui.mainCamera.transform.localPosition
				local var_288_4 = Vector3.New(0, 0, 10) + Vector3.New(var_288_3.x, var_288_3.y, 0)
				local var_288_5 = arg_285_1.bgs_.L03f

				var_288_5.transform.localPosition = var_288_4
				var_288_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_288_6 = var_288_5:GetComponent("SpriteRenderer")

				if var_288_6 and var_288_6.sprite then
					local var_288_7 = (var_288_5.transform.localPosition - var_288_3).z
					local var_288_8 = manager.ui.mainCameraCom_
					local var_288_9 = 2 * var_288_7 * Mathf.Tan(var_288_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_288_10 = var_288_9 * var_288_8.aspect
					local var_288_11 = var_288_6.sprite.bounds.size.x
					local var_288_12 = var_288_6.sprite.bounds.size.y
					local var_288_13 = var_288_10 / var_288_11
					local var_288_14 = var_288_9 / var_288_12
					local var_288_15 = var_288_14 < var_288_13 and var_288_13 or var_288_14

					var_288_5.transform.localScale = Vector3.New(var_288_15, var_288_15, 0)
				end

				for iter_288_0, iter_288_1 in pairs(arg_285_1.bgs_) do
					if iter_288_0 ~= "L03f" then
						iter_288_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_288_16 = 0

			if var_288_16 < arg_285_1.time_ and arg_285_1.time_ <= var_288_16 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_17 = 2

			if var_288_16 <= arg_285_1.time_ and arg_285_1.time_ < var_288_16 + var_288_17 then
				local var_288_18 = (arg_285_1.time_ - var_288_16) / var_288_17
				local var_288_19 = Color.New(0, 0, 0)

				var_288_19.a = Mathf.Lerp(0, 1, var_288_18)
				arg_285_1.mask_.color = var_288_19
			end

			if arg_285_1.time_ >= var_288_16 + var_288_17 and arg_285_1.time_ < var_288_16 + var_288_17 + arg_288_0 then
				local var_288_20 = Color.New(0, 0, 0)

				var_288_20.a = 1
				arg_285_1.mask_.color = var_288_20
			end

			local var_288_21 = 2

			if var_288_21 < arg_285_1.time_ and arg_285_1.time_ <= var_288_21 + arg_288_0 then
				arg_285_1.mask_.enabled = true
				arg_285_1.mask_.raycastTarget = true

				arg_285_1:SetGaussion(false)
			end

			local var_288_22 = 2

			if var_288_21 <= arg_285_1.time_ and arg_285_1.time_ < var_288_21 + var_288_22 then
				local var_288_23 = (arg_285_1.time_ - var_288_21) / var_288_22
				local var_288_24 = Color.New(0, 0, 0)

				var_288_24.a = Mathf.Lerp(1, 0, var_288_23)
				arg_285_1.mask_.color = var_288_24
			end

			if arg_285_1.time_ >= var_288_21 + var_288_22 and arg_285_1.time_ < var_288_21 + var_288_22 + arg_288_0 then
				local var_288_25 = Color.New(0, 0, 0)
				local var_288_26 = 0

				arg_285_1.mask_.enabled = false
				var_288_25.a = var_288_26
				arg_285_1.mask_.color = var_288_25
			end

			if arg_285_1.frameCnt_ <= 1 then
				arg_285_1.dialog_:SetActive(false)
			end

			local var_288_27 = 4
			local var_288_28 = 1.225

			if var_288_27 < arg_285_1.time_ and arg_285_1.time_ <= var_288_27 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0

				arg_285_1.dialog_:SetActive(true)

				arg_285_1.dialogCg_.alpha = 0

				local var_288_29 = LeanTween.value(arg_285_1.dialog_, 0, 1, 0.3)

				var_288_29:setOnUpdate(LuaHelper.FloatAction(function(arg_289_0)
					arg_285_1.dialogCg_.alpha = arg_289_0
				end))
				var_288_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_285_1.dialog_)
					var_288_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_285_1.duration_ = arg_285_1.duration_ + 0.3

				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_30 = arg_285_1:GetWordFromCfg(410261069)
				local var_288_31 = arg_285_1:FormatText(var_288_30.content)

				arg_285_1.text_.text = var_288_31

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_32 = 49
				local var_288_33 = utf8.len(var_288_31)
				local var_288_34 = var_288_32 <= 0 and var_288_28 or var_288_28 * (var_288_33 / var_288_32)

				if var_288_34 > 0 and var_288_28 < var_288_34 then
					arg_285_1.talkMaxDuration = var_288_34
					var_288_27 = var_288_27 + 0.3

					if var_288_34 + var_288_27 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_34 + var_288_27
					end
				end

				arg_285_1.text_.text = var_288_31
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_35 = var_288_27 + 0.3
			local var_288_36 = math.max(var_288_28, arg_285_1.talkMaxDuration)

			if var_288_35 <= arg_285_1.time_ and arg_285_1.time_ < var_288_35 + var_288_36 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_35) / var_288_36

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_35 + var_288_36 and arg_285_1.time_ < var_288_35 + var_288_36 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play410261070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 410261070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play410261071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.375

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_2 = arg_291_1:GetWordFromCfg(410261070)
				local var_294_3 = arg_291_1:FormatText(var_294_2.content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 55
				local var_294_5 = utf8.len(var_294_3)
				local var_294_6 = var_294_4 <= 0 and var_294_1 or var_294_1 * (var_294_5 / var_294_4)

				if var_294_6 > 0 and var_294_1 < var_294_6 then
					arg_291_1.talkMaxDuration = var_294_6

					if var_294_6 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_6 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_7 and arg_291_1.time_ < var_294_0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play410261071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 410261071
		arg_295_1.duration_ = 9

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play410261072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = "ST65"

			if arg_295_1.bgs_[var_298_0] == nil then
				local var_298_1 = Object.Instantiate(arg_295_1.paintGo_)

				var_298_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_298_0)
				var_298_1.name = var_298_0
				var_298_1.transform.parent = arg_295_1.stage_.transform
				var_298_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.bgs_[var_298_0] = var_298_1
			end

			local var_298_2 = 2

			if var_298_2 < arg_295_1.time_ and arg_295_1.time_ <= var_298_2 + arg_298_0 then
				local var_298_3 = manager.ui.mainCamera.transform.localPosition
				local var_298_4 = Vector3.New(0, 0, 10) + Vector3.New(var_298_3.x, var_298_3.y, 0)
				local var_298_5 = arg_295_1.bgs_.ST65

				var_298_5.transform.localPosition = var_298_4
				var_298_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_6 = var_298_5:GetComponent("SpriteRenderer")

				if var_298_6 and var_298_6.sprite then
					local var_298_7 = (var_298_5.transform.localPosition - var_298_3).z
					local var_298_8 = manager.ui.mainCameraCom_
					local var_298_9 = 2 * var_298_7 * Mathf.Tan(var_298_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_298_10 = var_298_9 * var_298_8.aspect
					local var_298_11 = var_298_6.sprite.bounds.size.x
					local var_298_12 = var_298_6.sprite.bounds.size.y
					local var_298_13 = var_298_10 / var_298_11
					local var_298_14 = var_298_9 / var_298_12
					local var_298_15 = var_298_14 < var_298_13 and var_298_13 or var_298_14

					var_298_5.transform.localScale = Vector3.New(var_298_15, var_298_15, 0)
				end

				for iter_298_0, iter_298_1 in pairs(arg_295_1.bgs_) do
					if iter_298_0 ~= "ST65" then
						iter_298_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_16 = 0

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_17 = 2

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_17 then
				local var_298_18 = (arg_295_1.time_ - var_298_16) / var_298_17
				local var_298_19 = Color.New(0, 0, 0)

				var_298_19.a = Mathf.Lerp(0, 1, var_298_18)
				arg_295_1.mask_.color = var_298_19
			end

			if arg_295_1.time_ >= var_298_16 + var_298_17 and arg_295_1.time_ < var_298_16 + var_298_17 + arg_298_0 then
				local var_298_20 = Color.New(0, 0, 0)

				var_298_20.a = 1
				arg_295_1.mask_.color = var_298_20
			end

			local var_298_21 = 2

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_22 = 2

			if var_298_21 <= arg_295_1.time_ and arg_295_1.time_ < var_298_21 + var_298_22 then
				local var_298_23 = (arg_295_1.time_ - var_298_21) / var_298_22
				local var_298_24 = Color.New(0, 0, 0)

				var_298_24.a = Mathf.Lerp(1, 0, var_298_23)
				arg_295_1.mask_.color = var_298_24
			end

			if arg_295_1.time_ >= var_298_21 + var_298_22 and arg_295_1.time_ < var_298_21 + var_298_22 + arg_298_0 then
				local var_298_25 = Color.New(0, 0, 0)
				local var_298_26 = 0

				arg_295_1.mask_.enabled = false
				var_298_25.a = var_298_26
				arg_295_1.mask_.color = var_298_25
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_27 = 4
			local var_298_28 = 1.525

			if var_298_27 < arg_295_1.time_ and arg_295_1.time_ <= var_298_27 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_29 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_29:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_30 = arg_295_1:GetWordFromCfg(410261071)
				local var_298_31 = arg_295_1:FormatText(var_298_30.content)

				arg_295_1.text_.text = var_298_31

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_32 = 61
				local var_298_33 = utf8.len(var_298_31)
				local var_298_34 = var_298_32 <= 0 and var_298_28 or var_298_28 * (var_298_33 / var_298_32)

				if var_298_34 > 0 and var_298_28 < var_298_34 then
					arg_295_1.talkMaxDuration = var_298_34
					var_298_27 = var_298_27 + 0.3

					if var_298_34 + var_298_27 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_34 + var_298_27
					end
				end

				arg_295_1.text_.text = var_298_31
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_35 = var_298_27 + 0.3
			local var_298_36 = math.max(var_298_28, arg_295_1.talkMaxDuration)

			if var_298_35 <= arg_295_1.time_ and arg_295_1.time_ < var_298_35 + var_298_36 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_35) / var_298_36

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_35 + var_298_36 and arg_295_1.time_ < var_298_35 + var_298_36 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play410261072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410261072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410261073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.2

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(410261072)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 48
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play410261073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410261073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play410261074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 1.05

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_2 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_2:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(410261073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 42
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7
					var_308_0 = var_308_0 + 0.3

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = var_308_0 + 0.3
			local var_308_9 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_9

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play410261074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 410261074
		arg_311_1.duration_ = 10.47

		local var_311_0 = {
			ja = 10.466,
			CriLanguages = 7,
			zh = 7
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
				arg_311_0:Play410261075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1061"].transform
			local var_314_1 = 3.8

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1061 = var_314_0.localPosition
				var_314_0.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("1061", 3)

				local var_314_2 = var_314_0.childCount

				for iter_314_0 = 0, var_314_2 - 1 do
					local var_314_3 = var_314_0:GetChild(iter_314_0)

					if var_314_3.name == "split_7" or not string.find(var_314_3.name, "split") then
						var_314_3.gameObject:SetActive(true)
					else
						var_314_3.gameObject:SetActive(false)
					end
				end
			end

			local var_314_4 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_4 then
				local var_314_5 = (arg_311_1.time_ - var_314_1) / var_314_4
				local var_314_6 = Vector3.New(0, -490, 18)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1061, var_314_6, var_314_5)
			end

			if arg_311_1.time_ >= var_314_1 + var_314_4 and arg_311_1.time_ < var_314_1 + var_314_4 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_314_7 = arg_311_1.actors_["1061"]
			local var_314_8 = 3.8

			if var_314_8 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 and not isNil(var_314_7) and arg_311_1.var_.actorSpriteComps1061 == nil then
				arg_311_1.var_.actorSpriteComps1061 = var_314_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_9 = 0.034

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_9 and not isNil(var_314_7) then
				local var_314_10 = (arg_311_1.time_ - var_314_8) / var_314_9

				if arg_311_1.var_.actorSpriteComps1061 then
					for iter_314_1, iter_314_2 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_314_2 then
							if arg_311_1.isInRecall_ then
								local var_314_11 = Mathf.Lerp(iter_314_2.color.r, arg_311_1.hightColor1.r, var_314_10)
								local var_314_12 = Mathf.Lerp(iter_314_2.color.g, arg_311_1.hightColor1.g, var_314_10)
								local var_314_13 = Mathf.Lerp(iter_314_2.color.b, arg_311_1.hightColor1.b, var_314_10)

								iter_314_2.color = Color.New(var_314_11, var_314_12, var_314_13)
							else
								local var_314_14 = Mathf.Lerp(iter_314_2.color.r, 1, var_314_10)

								iter_314_2.color = Color.New(var_314_14, var_314_14, var_314_14)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_8 + var_314_9 and arg_311_1.time_ < var_314_8 + var_314_9 + arg_314_0 and not isNil(var_314_7) and arg_311_1.var_.actorSpriteComps1061 then
				for iter_314_3, iter_314_4 in pairs(arg_311_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_314_4 then
						if arg_311_1.isInRecall_ then
							iter_314_4.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1061 = nil
			end

			local var_314_15 = 0

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_16 = 2

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_16 then
				local var_314_17 = (arg_311_1.time_ - var_314_15) / var_314_16
				local var_314_18 = Color.New(0, 0, 0)

				var_314_18.a = Mathf.Lerp(0, 1, var_314_17)
				arg_311_1.mask_.color = var_314_18
			end

			if arg_311_1.time_ >= var_314_15 + var_314_16 and arg_311_1.time_ < var_314_15 + var_314_16 + arg_314_0 then
				local var_314_19 = Color.New(0, 0, 0)

				var_314_19.a = 1
				arg_311_1.mask_.color = var_314_19
			end

			local var_314_20 = 2

			if var_314_20 < arg_311_1.time_ and arg_311_1.time_ <= var_314_20 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_21 = 2

			if var_314_20 <= arg_311_1.time_ and arg_311_1.time_ < var_314_20 + var_314_21 then
				local var_314_22 = (arg_311_1.time_ - var_314_20) / var_314_21
				local var_314_23 = Color.New(0, 0, 0)

				var_314_23.a = Mathf.Lerp(1, 0, var_314_22)
				arg_311_1.mask_.color = var_314_23
			end

			if arg_311_1.time_ >= var_314_20 + var_314_21 and arg_311_1.time_ < var_314_20 + var_314_21 + arg_314_0 then
				local var_314_24 = Color.New(0, 0, 0)
				local var_314_25 = 0

				arg_311_1.mask_.enabled = false
				var_314_24.a = var_314_25
				arg_311_1.mask_.color = var_314_24
			end

			local var_314_26 = "ST61"

			if arg_311_1.bgs_[var_314_26] == nil then
				local var_314_27 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_314_26)
				var_314_27.name = var_314_26
				var_314_27.transform.parent = arg_311_1.stage_.transform
				var_314_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_[var_314_26] = var_314_27
			end

			local var_314_28 = 2

			if var_314_28 < arg_311_1.time_ and arg_311_1.time_ <= var_314_28 + arg_314_0 then
				local var_314_29 = manager.ui.mainCamera.transform.localPosition
				local var_314_30 = Vector3.New(0, 0, 10) + Vector3.New(var_314_29.x, var_314_29.y, 0)
				local var_314_31 = arg_311_1.bgs_.ST61

				var_314_31.transform.localPosition = var_314_30
				var_314_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_32 = var_314_31:GetComponent("SpriteRenderer")

				if var_314_32 and var_314_32.sprite then
					local var_314_33 = (var_314_31.transform.localPosition - var_314_29).z
					local var_314_34 = manager.ui.mainCameraCom_
					local var_314_35 = 2 * var_314_33 * Mathf.Tan(var_314_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_314_36 = var_314_35 * var_314_34.aspect
					local var_314_37 = var_314_32.sprite.bounds.size.x
					local var_314_38 = var_314_32.sprite.bounds.size.y
					local var_314_39 = var_314_36 / var_314_37
					local var_314_40 = var_314_35 / var_314_38
					local var_314_41 = var_314_40 < var_314_39 and var_314_39 or var_314_40

					var_314_31.transform.localScale = Vector3.New(var_314_41, var_314_41, 0)
				end

				for iter_314_5, iter_314_6 in pairs(arg_311_1.bgs_) do
					if iter_314_5 ~= "ST61" then
						iter_314_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_42 = 4
			local var_314_43 = 0.2

			if var_314_42 < arg_311_1.time_ and arg_311_1.time_ <= var_314_42 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_44 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_44:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_45 = arg_311_1:FormatText(StoryNameCfg[612].name)

				arg_311_1.leftNameTxt_.text = var_314_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_46 = arg_311_1:GetWordFromCfg(410261074)
				local var_314_47 = arg_311_1:FormatText(var_314_46.content)

				arg_311_1.text_.text = var_314_47

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_48 = 8
				local var_314_49 = utf8.len(var_314_47)
				local var_314_50 = var_314_48 <= 0 and var_314_43 or var_314_43 * (var_314_49 / var_314_48)

				if var_314_50 > 0 and var_314_43 < var_314_50 then
					arg_311_1.talkMaxDuration = var_314_50
					var_314_42 = var_314_42 + 0.3

					if var_314_50 + var_314_42 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_50 + var_314_42
					end
				end

				arg_311_1.text_.text = var_314_47
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261074", "story_v_out_410261.awb") ~= 0 then
					local var_314_51 = manager.audio:GetVoiceLength("story_v_out_410261", "410261074", "story_v_out_410261.awb") / 1000

					if var_314_51 + var_314_42 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_51 + var_314_42
					end

					if var_314_46.prefab_name ~= "" and arg_311_1.actors_[var_314_46.prefab_name] ~= nil then
						local var_314_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_46.prefab_name].transform, "story_v_out_410261", "410261074", "story_v_out_410261.awb")

						arg_311_1:RecordAudio("410261074", var_314_52)
						arg_311_1:RecordAudio("410261074", var_314_52)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_410261", "410261074", "story_v_out_410261.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_410261", "410261074", "story_v_out_410261.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_53 = var_314_42 + 0.3
			local var_314_54 = math.max(var_314_43, arg_311_1.talkMaxDuration)

			if var_314_53 <= arg_311_1.time_ and arg_311_1.time_ < var_314_53 + var_314_54 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_53) / var_314_54

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_53 + var_314_54 and arg_311_1.time_ < var_314_53 + var_314_54 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play410261075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410261075
		arg_317_1.duration_ = 8.2

		local var_317_0 = {
			ja = 8.2,
			CriLanguages = 4.233,
			zh = 4.233
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play410261076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1061"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1061 = var_320_0.localPosition
				var_320_0.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1061", 3)

				local var_320_2 = var_320_0.childCount

				for iter_320_0 = 0, var_320_2 - 1 do
					local var_320_3 = var_320_0:GetChild(iter_320_0)

					if var_320_3.name == "split_7" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_4 then
				local var_320_5 = (arg_317_1.time_ - var_320_1) / var_320_4
				local var_320_6 = Vector3.New(0, -490, 18)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1061, var_320_6, var_320_5)
			end

			if arg_317_1.time_ >= var_320_1 + var_320_4 and arg_317_1.time_ < var_320_1 + var_320_4 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_320_7 = arg_317_1.actors_["1061"]
			local var_320_8 = 0

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps1061 == nil then
				arg_317_1.var_.actorSpriteComps1061 = var_320_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_9 = 0.034

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_9 and not isNil(var_320_7) then
				local var_320_10 = (arg_317_1.time_ - var_320_8) / var_320_9

				if arg_317_1.var_.actorSpriteComps1061 then
					for iter_320_1, iter_320_2 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_320_2 then
							if arg_317_1.isInRecall_ then
								local var_320_11 = Mathf.Lerp(iter_320_2.color.r, arg_317_1.hightColor1.r, var_320_10)
								local var_320_12 = Mathf.Lerp(iter_320_2.color.g, arg_317_1.hightColor1.g, var_320_10)
								local var_320_13 = Mathf.Lerp(iter_320_2.color.b, arg_317_1.hightColor1.b, var_320_10)

								iter_320_2.color = Color.New(var_320_11, var_320_12, var_320_13)
							else
								local var_320_14 = Mathf.Lerp(iter_320_2.color.r, 1, var_320_10)

								iter_320_2.color = Color.New(var_320_14, var_320_14, var_320_14)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_8 + var_320_9 and arg_317_1.time_ < var_320_8 + var_320_9 + arg_320_0 and not isNil(var_320_7) and arg_317_1.var_.actorSpriteComps1061 then
				for iter_320_3, iter_320_4 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_320_4 then
						if arg_317_1.isInRecall_ then
							iter_320_4.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1061 = nil
			end

			local var_320_15 = 0
			local var_320_16 = 0.55

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_17 = arg_317_1:FormatText(StoryNameCfg[612].name)

				arg_317_1.leftNameTxt_.text = var_320_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_18 = arg_317_1:GetWordFromCfg(410261075)
				local var_320_19 = arg_317_1:FormatText(var_320_18.content)

				arg_317_1.text_.text = var_320_19

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_20 = 22
				local var_320_21 = utf8.len(var_320_19)
				local var_320_22 = var_320_20 <= 0 and var_320_16 or var_320_16 * (var_320_21 / var_320_20)

				if var_320_22 > 0 and var_320_16 < var_320_22 then
					arg_317_1.talkMaxDuration = var_320_22

					if var_320_22 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_22 + var_320_15
					end
				end

				arg_317_1.text_.text = var_320_19
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261075", "story_v_out_410261.awb") ~= 0 then
					local var_320_23 = manager.audio:GetVoiceLength("story_v_out_410261", "410261075", "story_v_out_410261.awb") / 1000

					if var_320_23 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_15
					end

					if var_320_18.prefab_name ~= "" and arg_317_1.actors_[var_320_18.prefab_name] ~= nil then
						local var_320_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_18.prefab_name].transform, "story_v_out_410261", "410261075", "story_v_out_410261.awb")

						arg_317_1:RecordAudio("410261075", var_320_24)
						arg_317_1:RecordAudio("410261075", var_320_24)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410261", "410261075", "story_v_out_410261.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410261", "410261075", "story_v_out_410261.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_25 = math.max(var_320_16, arg_317_1.talkMaxDuration)

			if var_320_15 <= arg_317_1.time_ and arg_317_1.time_ < var_320_15 + var_320_25 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_15) / var_320_25

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_15 + var_320_25 and arg_317_1.time_ < var_320_15 + var_320_25 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play410261076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410261076
		arg_321_1.duration_ = 5.37

		local var_321_0 = {
			ja = 5.366,
			CriLanguages = 1.266,
			zh = 1.266
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play410261077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1061"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps1061 == nil then
				arg_321_1.var_.actorSpriteComps1061 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.034

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps1061 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								local var_324_4 = Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor2.r, var_324_3)
								local var_324_5 = Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor2.g, var_324_3)
								local var_324_6 = Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor2.b, var_324_3)

								iter_324_1.color = Color.New(var_324_4, var_324_5, var_324_6)
							else
								local var_324_7 = Mathf.Lerp(iter_324_1.color.r, 0.5, var_324_3)

								iter_324_1.color = Color.New(var_324_7, var_324_7, var_324_7)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps1061 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_324_3 then
						if arg_321_1.isInRecall_ then
							iter_324_3.color = arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_324_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps1061 = nil
			end

			local var_324_8 = 0
			local var_324_9 = 0.125

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_10 = arg_321_1:FormatText(StoryNameCfg[36].name)

				arg_321_1.leftNameTxt_.text = var_324_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_11 = arg_321_1:GetWordFromCfg(410261076)
				local var_324_12 = arg_321_1:FormatText(var_324_11.content)

				arg_321_1.text_.text = var_324_12

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 5
				local var_324_14 = utf8.len(var_324_12)
				local var_324_15 = var_324_13 <= 0 and var_324_9 or var_324_9 * (var_324_14 / var_324_13)

				if var_324_15 > 0 and var_324_9 < var_324_15 then
					arg_321_1.talkMaxDuration = var_324_15

					if var_324_15 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_15 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_12
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261076", "story_v_out_410261.awb") ~= 0 then
					local var_324_16 = manager.audio:GetVoiceLength("story_v_out_410261", "410261076", "story_v_out_410261.awb") / 1000

					if var_324_16 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_16 + var_324_8
					end

					if var_324_11.prefab_name ~= "" and arg_321_1.actors_[var_324_11.prefab_name] ~= nil then
						local var_324_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_11.prefab_name].transform, "story_v_out_410261", "410261076", "story_v_out_410261.awb")

						arg_321_1:RecordAudio("410261076", var_324_17)
						arg_321_1:RecordAudio("410261076", var_324_17)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410261", "410261076", "story_v_out_410261.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410261", "410261076", "story_v_out_410261.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_18 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_18 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_18

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_18 and arg_321_1.time_ < var_324_8 + var_324_18 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play410261077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410261077
		arg_325_1.duration_ = 8.6

		local var_325_0 = {
			ja = 8.6,
			CriLanguages = 4.866,
			zh = 4.866
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play410261078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1061"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1061 = var_328_0.localPosition
				var_328_0.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1061", 3)

				local var_328_2 = var_328_0.childCount

				for iter_328_0 = 0, var_328_2 - 1 do
					local var_328_3 = var_328_0:GetChild(iter_328_0)

					if var_328_3.name == "split_5" or not string.find(var_328_3.name, "split") then
						var_328_3.gameObject:SetActive(true)
					else
						var_328_3.gameObject:SetActive(false)
					end
				end
			end

			local var_328_4 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_4 then
				local var_328_5 = (arg_325_1.time_ - var_328_1) / var_328_4
				local var_328_6 = Vector3.New(0, -490, 18)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1061, var_328_6, var_328_5)
			end

			if arg_325_1.time_ >= var_328_1 + var_328_4 and arg_325_1.time_ < var_328_1 + var_328_4 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_328_7 = arg_325_1.actors_["1061"]
			local var_328_8 = 0

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps1061 == nil then
				arg_325_1.var_.actorSpriteComps1061 = var_328_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_9 = 0.034

			if var_328_8 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 and not isNil(var_328_7) then
				local var_328_10 = (arg_325_1.time_ - var_328_8) / var_328_9

				if arg_325_1.var_.actorSpriteComps1061 then
					for iter_328_1, iter_328_2 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_328_2 then
							if arg_325_1.isInRecall_ then
								local var_328_11 = Mathf.Lerp(iter_328_2.color.r, arg_325_1.hightColor1.r, var_328_10)
								local var_328_12 = Mathf.Lerp(iter_328_2.color.g, arg_325_1.hightColor1.g, var_328_10)
								local var_328_13 = Mathf.Lerp(iter_328_2.color.b, arg_325_1.hightColor1.b, var_328_10)

								iter_328_2.color = Color.New(var_328_11, var_328_12, var_328_13)
							else
								local var_328_14 = Mathf.Lerp(iter_328_2.color.r, 1, var_328_10)

								iter_328_2.color = Color.New(var_328_14, var_328_14, var_328_14)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 and not isNil(var_328_7) and arg_325_1.var_.actorSpriteComps1061 then
				for iter_328_3, iter_328_4 in pairs(arg_325_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_328_4 then
						if arg_325_1.isInRecall_ then
							iter_328_4.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps1061 = nil
			end

			local var_328_15 = 0
			local var_328_16 = 0.575

			if var_328_15 < arg_325_1.time_ and arg_325_1.time_ <= var_328_15 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_17 = arg_325_1:FormatText(StoryNameCfg[612].name)

				arg_325_1.leftNameTxt_.text = var_328_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_18 = arg_325_1:GetWordFromCfg(410261077)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 23
				local var_328_21 = utf8.len(var_328_19)
				local var_328_22 = var_328_20 <= 0 and var_328_16 or var_328_16 * (var_328_21 / var_328_20)

				if var_328_22 > 0 and var_328_16 < var_328_22 then
					arg_325_1.talkMaxDuration = var_328_22

					if var_328_22 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_22 + var_328_15
					end
				end

				arg_325_1.text_.text = var_328_19
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261077", "story_v_out_410261.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_out_410261", "410261077", "story_v_out_410261.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_out_410261", "410261077", "story_v_out_410261.awb")

						arg_325_1:RecordAudio("410261077", var_328_24)
						arg_325_1:RecordAudio("410261077", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_410261", "410261077", "story_v_out_410261.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_410261", "410261077", "story_v_out_410261.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_25 = math.max(var_328_16, arg_325_1.talkMaxDuration)

			if var_328_15 <= arg_325_1.time_ and arg_325_1.time_ < var_328_15 + var_328_25 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_15) / var_328_25

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_15 + var_328_25 and arg_325_1.time_ < var_328_15 + var_328_25 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play410261078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410261078
		arg_329_1.duration_ = 11.87

		local var_329_0 = {
			ja = 11.866,
			CriLanguages = 6.233,
			zh = 6.233
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play410261079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1061"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1061 == nil then
				arg_329_1.var_.actorSpriteComps1061 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.034

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1061 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								local var_332_4 = Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor2.r, var_332_3)
								local var_332_5 = Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor2.g, var_332_3)
								local var_332_6 = Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor2.b, var_332_3)

								iter_332_1.color = Color.New(var_332_4, var_332_5, var_332_6)
							else
								local var_332_7 = Mathf.Lerp(iter_332_1.color.r, 0.5, var_332_3)

								iter_332_1.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1061 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1061 = nil
			end

			local var_332_8 = 0
			local var_332_9 = 0.725

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_10 = arg_329_1:FormatText(StoryNameCfg[36].name)

				arg_329_1.leftNameTxt_.text = var_332_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_11 = arg_329_1:GetWordFromCfg(410261078)
				local var_332_12 = arg_329_1:FormatText(var_332_11.content)

				arg_329_1.text_.text = var_332_12

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 29
				local var_332_14 = utf8.len(var_332_12)
				local var_332_15 = var_332_13 <= 0 and var_332_9 or var_332_9 * (var_332_14 / var_332_13)

				if var_332_15 > 0 and var_332_9 < var_332_15 then
					arg_329_1.talkMaxDuration = var_332_15

					if var_332_15 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_15 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_12
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261078", "story_v_out_410261.awb") ~= 0 then
					local var_332_16 = manager.audio:GetVoiceLength("story_v_out_410261", "410261078", "story_v_out_410261.awb") / 1000

					if var_332_16 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_8
					end

					if var_332_11.prefab_name ~= "" and arg_329_1.actors_[var_332_11.prefab_name] ~= nil then
						local var_332_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_11.prefab_name].transform, "story_v_out_410261", "410261078", "story_v_out_410261.awb")

						arg_329_1:RecordAudio("410261078", var_332_17)
						arg_329_1:RecordAudio("410261078", var_332_17)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410261", "410261078", "story_v_out_410261.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410261", "410261078", "story_v_out_410261.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_18 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_18 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_18

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_18 and arg_329_1.time_ < var_332_8 + var_332_18 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play410261079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410261079
		arg_333_1.duration_ = 9.43

		local var_333_0 = {
			ja = 9.433,
			CriLanguages = 2.666,
			zh = 2.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
			arg_333_1.auto_ = false
		end

		function arg_333_1.playNext_(arg_335_0)
			arg_333_1.onStoryFinished_()
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.275

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[36].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:GetWordFromCfg(410261079)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 11
				local var_336_6 = utf8.len(var_336_4)
				local var_336_7 = var_336_5 <= 0 and var_336_1 or var_336_1 * (var_336_6 / var_336_5)

				if var_336_7 > 0 and var_336_1 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_4
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410261", "410261079", "story_v_out_410261.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_410261", "410261079", "story_v_out_410261.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_410261", "410261079", "story_v_out_410261.awb")

						arg_333_1:RecordAudio("410261079", var_336_9)
						arg_333_1:RecordAudio("410261079", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410261", "410261079", "story_v_out_410261.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410261", "410261079", "story_v_out_410261.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_10 and arg_333_1.time_ < var_336_0 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/LZ0209",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L03f",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/ST61"
	},
	voices = {
		"story_v_out_410261.awb"
	}
}
