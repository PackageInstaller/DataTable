return {
	Play410182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410182001
		arg_1_1.duration_ = 9.17

		local var_1_0 = {
			ja = 9.166,
			CriLanguages = 8.566,
			zh = 8.566
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
				arg_1_0:Play410182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L04g"

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
				local var_4_5 = arg_1_1.bgs_.L04g

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
					if iter_4_0 ~= "L04g" then
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

			local var_4_22 = "10061"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10061")

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

			local var_4_26 = arg_1_1.actors_["10061"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10061 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10061", 3)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "split_5" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(0, -517.5, -100)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10061, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -517.5, -100)
			end

			local var_4_33 = arg_1_1.actors_["10061"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10061 == nil then
				arg_1_1.var_.actorSpriteComps10061 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps10061 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10061 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10061 = nil
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

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

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
			local var_4_54 = 0.475

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[591].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(410182001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182001", "story_v_out_410182.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_410182", "410182001", "story_v_out_410182.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_410182", "410182001", "story_v_out_410182.awb")

						arg_1_1:RecordAudio("410182001", var_4_63)
						arg_1_1:RecordAudio("410182001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410182", "410182001", "story_v_out_410182.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410182", "410182001", "story_v_out_410182.awb")
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
				actorName = "10061",
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
	Play410182002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410182002
		arg_9_1.duration_ = 7.57

		local var_9_0 = {
			ja = 3.933,
			CriLanguages = 7.566,
			zh = 7.566
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
				arg_9_0:Play410182003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10061"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10061 == nil then
				arg_9_1.var_.actorSpriteComps10061 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.034

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps10061 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10061 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10061 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.325

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[608].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(410182002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182002", "story_v_out_410182.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182002", "story_v_out_410182.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_410182", "410182002", "story_v_out_410182.awb")

						arg_9_1:RecordAudio("410182002", var_12_17)
						arg_9_1:RecordAudio("410182002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410182", "410182002", "story_v_out_410182.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410182", "410182002", "story_v_out_410182.awb")
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
	Play410182003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410182003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410182004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10061"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10061 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10061", 7)

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
				local var_16_6 = Vector3.New(0, -2000, -100)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10061, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_16_7 = 0
			local var_16_8 = 1.4

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:GetWordFromCfg(410182003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 56
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_8 or var_16_8 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_8 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_14 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_14 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_7) / var_16_14

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_7 + var_16_14 and arg_13_1.time_ < var_16_7 + var_16_14 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
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
	Play410182004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410182004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play410182005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.925

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(410182004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 37
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play410182005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410182005
		arg_21_1.duration_ = 5.23

		local var_21_0 = {
			ja = 5.233,
			CriLanguages = 3,
			zh = 2.033
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
				arg_21_0:Play410182006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10061"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10061 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10061", 7)

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
				local var_24_6 = Vector3.New(0, -2000, -100)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10061, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -2000, -100)
			end

			local var_24_7 = "10059"

			if arg_21_1.actors_[var_24_7] == nil then
				local var_24_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

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

			local var_24_11 = arg_21_1.actors_["10059"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos10059 = var_24_11.localPosition
				var_24_11.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10059", 2)

				local var_24_13 = var_24_11.childCount

				for iter_24_3 = 0, var_24_13 - 1 do
					local var_24_14 = var_24_11:GetChild(iter_24_3)

					if var_24_14.name == "split_3" or not string.find(var_24_14.name, "split") then
						var_24_14.gameObject:SetActive(true)
					else
						var_24_14.gameObject:SetActive(false)
					end
				end
			end

			local var_24_15 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_15 then
				local var_24_16 = (arg_21_1.time_ - var_24_12) / var_24_15
				local var_24_17 = Vector3.New(-390, -530, 35)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10059, var_24_17, var_24_16)
			end

			if arg_21_1.time_ >= var_24_12 + var_24_15 and arg_21_1.time_ < var_24_12 + var_24_15 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_24_18 = "1061"

			if arg_21_1.actors_[var_24_18] == nil then
				local var_24_19 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_24_19) then
					local var_24_20 = Object.Instantiate(var_24_19, arg_21_1.canvasGo_.transform)

					var_24_20.transform:SetSiblingIndex(1)

					var_24_20.name = var_24_18
					var_24_20.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_[var_24_18] = var_24_20

					local var_24_21 = var_24_20:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_21_1.isInRecall_ then
						for iter_24_4, iter_24_5 in ipairs(var_24_21) do
							iter_24_5.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_22 = arg_21_1.actors_["1061"].transform
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_22.localPosition
				var_24_22.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 4)

				local var_24_24 = var_24_22.childCount

				for iter_24_6 = 0, var_24_24 - 1 do
					local var_24_25 = var_24_22:GetChild(iter_24_6)

					if var_24_25.name == "" or not string.find(var_24_25.name, "split") then
						var_24_25.gameObject:SetActive(true)
					else
						var_24_25.gameObject:SetActive(false)
					end
				end
			end

			local var_24_26 = 0.001

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_26 then
				local var_24_27 = (arg_21_1.time_ - var_24_23) / var_24_26
				local var_24_28 = Vector3.New(390, -490, 18)

				var_24_22.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, var_24_28, var_24_27)
			end

			if arg_21_1.time_ >= var_24_23 + var_24_26 and arg_21_1.time_ < var_24_23 + var_24_26 + arg_24_0 then
				var_24_22.localPosition = Vector3.New(390, -490, 18)
			end

			local var_24_29 = arg_21_1.actors_["10061"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.actorSpriteComps10061 == nil then
				arg_21_1.var_.actorSpriteComps10061 = var_24_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_31 = 0.034

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.actorSpriteComps10061 then
					for iter_24_7, iter_24_8 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_24_8 then
							if arg_21_1.isInRecall_ then
								local var_24_33 = Mathf.Lerp(iter_24_8.color.r, arg_21_1.hightColor2.r, var_24_32)
								local var_24_34 = Mathf.Lerp(iter_24_8.color.g, arg_21_1.hightColor2.g, var_24_32)
								local var_24_35 = Mathf.Lerp(iter_24_8.color.b, arg_21_1.hightColor2.b, var_24_32)

								iter_24_8.color = Color.New(var_24_33, var_24_34, var_24_35)
							else
								local var_24_36 = Mathf.Lerp(iter_24_8.color.r, 0.5, var_24_32)

								iter_24_8.color = Color.New(var_24_36, var_24_36, var_24_36)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.actorSpriteComps10061 then
				for iter_24_9, iter_24_10 in pairs(arg_21_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_24_10 then
						if arg_21_1.isInRecall_ then
							iter_24_10.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10061 = nil
			end

			local var_24_37 = arg_21_1.actors_["10059"]
			local var_24_38 = 0

			if var_24_38 < arg_21_1.time_ and arg_21_1.time_ <= var_24_38 + arg_24_0 and not isNil(var_24_37) and arg_21_1.var_.actorSpriteComps10059 == nil then
				arg_21_1.var_.actorSpriteComps10059 = var_24_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_39 = 0.034

			if var_24_38 <= arg_21_1.time_ and arg_21_1.time_ < var_24_38 + var_24_39 and not isNil(var_24_37) then
				local var_24_40 = (arg_21_1.time_ - var_24_38) / var_24_39

				if arg_21_1.var_.actorSpriteComps10059 then
					for iter_24_11, iter_24_12 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_24_12 then
							if arg_21_1.isInRecall_ then
								local var_24_41 = Mathf.Lerp(iter_24_12.color.r, arg_21_1.hightColor1.r, var_24_40)
								local var_24_42 = Mathf.Lerp(iter_24_12.color.g, arg_21_1.hightColor1.g, var_24_40)
								local var_24_43 = Mathf.Lerp(iter_24_12.color.b, arg_21_1.hightColor1.b, var_24_40)

								iter_24_12.color = Color.New(var_24_41, var_24_42, var_24_43)
							else
								local var_24_44 = Mathf.Lerp(iter_24_12.color.r, 1, var_24_40)

								iter_24_12.color = Color.New(var_24_44, var_24_44, var_24_44)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_38 + var_24_39 and arg_21_1.time_ < var_24_38 + var_24_39 + arg_24_0 and not isNil(var_24_37) and arg_21_1.var_.actorSpriteComps10059 then
				for iter_24_13, iter_24_14 in pairs(arg_21_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_24_14 then
						if arg_21_1.isInRecall_ then
							iter_24_14.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10059 = nil
			end

			local var_24_45 = arg_21_1.actors_["1061"]
			local var_24_46 = 0

			if var_24_46 < arg_21_1.time_ and arg_21_1.time_ <= var_24_46 + arg_24_0 and not isNil(var_24_45) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_45:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_47 = 0.034

			if var_24_46 <= arg_21_1.time_ and arg_21_1.time_ < var_24_46 + var_24_47 and not isNil(var_24_45) then
				local var_24_48 = (arg_21_1.time_ - var_24_46) / var_24_47

				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_15, iter_24_16 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_16 then
							if arg_21_1.isInRecall_ then
								local var_24_49 = Mathf.Lerp(iter_24_16.color.r, arg_21_1.hightColor2.r, var_24_48)
								local var_24_50 = Mathf.Lerp(iter_24_16.color.g, arg_21_1.hightColor2.g, var_24_48)
								local var_24_51 = Mathf.Lerp(iter_24_16.color.b, arg_21_1.hightColor2.b, var_24_48)

								iter_24_16.color = Color.New(var_24_49, var_24_50, var_24_51)
							else
								local var_24_52 = Mathf.Lerp(iter_24_16.color.r, 0.5, var_24_48)

								iter_24_16.color = Color.New(var_24_52, var_24_52, var_24_52)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_46 + var_24_47 and arg_21_1.time_ < var_24_46 + var_24_47 + arg_24_0 and not isNil(var_24_45) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_17, iter_24_18 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_18 then
						if arg_21_1.isInRecall_ then
							iter_24_18.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_18.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_53 = 0
			local var_24_54 = 0.275

			if var_24_53 < arg_21_1.time_ and arg_21_1.time_ <= var_24_53 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_55 = arg_21_1:FormatText(StoryNameCfg[596].name)

				arg_21_1.leftNameTxt_.text = var_24_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_56 = arg_21_1:GetWordFromCfg(410182005)
				local var_24_57 = arg_21_1:FormatText(var_24_56.content)

				arg_21_1.text_.text = var_24_57

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_58 = 11
				local var_24_59 = utf8.len(var_24_57)
				local var_24_60 = var_24_58 <= 0 and var_24_54 or var_24_54 * (var_24_59 / var_24_58)

				if var_24_60 > 0 and var_24_54 < var_24_60 then
					arg_21_1.talkMaxDuration = var_24_60

					if var_24_60 + var_24_53 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_60 + var_24_53
					end
				end

				arg_21_1.text_.text = var_24_57
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182005", "story_v_out_410182.awb") ~= 0 then
					local var_24_61 = manager.audio:GetVoiceLength("story_v_out_410182", "410182005", "story_v_out_410182.awb") / 1000

					if var_24_61 + var_24_53 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_61 + var_24_53
					end

					if var_24_56.prefab_name ~= "" and arg_21_1.actors_[var_24_56.prefab_name] ~= nil then
						local var_24_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_56.prefab_name].transform, "story_v_out_410182", "410182005", "story_v_out_410182.awb")

						arg_21_1:RecordAudio("410182005", var_24_62)
						arg_21_1:RecordAudio("410182005", var_24_62)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410182", "410182005", "story_v_out_410182.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410182", "410182005", "story_v_out_410182.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_63 = math.max(var_24_54, arg_21_1.talkMaxDuration)

			if var_24_53 <= arg_21_1.time_ and arg_21_1.time_ < var_24_53 + var_24_63 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_53) / var_24_63

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_53 + var_24_63 and arg_21_1.time_ < var_24_53 + var_24_63 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_21_1:InitPlayNodeList()
	end,
	Play410182006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410182006
		arg_25_1.duration_ = 10.93

		local var_25_0 = {
			ja = 10.933,
			CriLanguages = 6.133,
			zh = 6.133
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
				arg_25_0:Play410182007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1061"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1061 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1061", 4)

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
				local var_28_6 = Vector3.New(390, -490, 18)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1061, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_28_7 = arg_25_1.actors_["1061"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_15 = arg_25_1.actors_["10059"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 0.034

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								local var_28_19 = Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, var_28_18)
								local var_28_20 = Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, var_28_18)
								local var_28_21 = Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, var_28_18)

								iter_28_6.color = Color.New(var_28_19, var_28_20, var_28_21)
							else
								local var_28_22 = Mathf.Lerp(iter_28_6.color.r, 0.5, var_28_18)

								iter_28_6.color = Color.New(var_28_22, var_28_22, var_28_22)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_23 = 0
			local var_28_24 = 0.8

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[612].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(410182006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 32
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182006", "story_v_out_410182.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182006", "story_v_out_410182.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_410182", "410182006", "story_v_out_410182.awb")

						arg_25_1:RecordAudio("410182006", var_28_32)
						arg_25_1:RecordAudio("410182006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410182", "410182006", "story_v_out_410182.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410182", "410182006", "story_v_out_410182.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play410182007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410182007
		arg_29_1.duration_ = 6.63

		local var_29_0 = {
			ja = 6.633,
			CriLanguages = 3.2,
			zh = 3.2
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
				arg_29_0:Play410182008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1061"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 4)

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
				local var_32_6 = Vector3.New(390, -490, 18)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_32_7 = arg_29_1.actors_["1061"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 1, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_15 = 0
			local var_32_16 = 0.45

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[612].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(410182007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 18
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182007", "story_v_out_410182.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182007", "story_v_out_410182.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_410182", "410182007", "story_v_out_410182.awb")

						arg_29_1:RecordAudio("410182007", var_32_24)
						arg_29_1:RecordAudio("410182007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410182", "410182007", "story_v_out_410182.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410182", "410182007", "story_v_out_410182.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play410182008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410182008
		arg_33_1.duration_ = 5.13

		local var_33_0 = {
			ja = 5.133,
			CriLanguages = 2.6,
			zh = 2.6
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
				arg_33_0:Play410182009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1061"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1061 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1061", 4)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(390, -490, 18)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1061, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_36_7 = arg_33_1.actors_["1061"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_15 = 0
			local var_36_16 = 0.35

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[612].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(410182008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182008", "story_v_out_410182.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182008", "story_v_out_410182.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_410182", "410182008", "story_v_out_410182.awb")

						arg_33_1:RecordAudio("410182008", var_36_24)
						arg_33_1:RecordAudio("410182008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410182", "410182008", "story_v_out_410182.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410182", "410182008", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410182009
		arg_37_1.duration_ = 7.37

		local var_37_0 = {
			ja = 7.366,
			CriLanguages = 2.033,
			zh = 7.066
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
				arg_37_0:Play410182010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10059"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10059 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10059", 2)

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
				local var_40_6 = Vector3.New(-390, -530, 35)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10059, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_40_7 = arg_37_1.actors_["10059"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10059 == nil then
				arg_37_1.var_.actorSpriteComps10059 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10059 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10059 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10059 = nil
			end

			local var_40_15 = arg_37_1.actors_["1061"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps1061 == nil then
				arg_37_1.var_.actorSpriteComps1061 = var_40_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_17 = 0.034

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.actorSpriteComps1061 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_40_6 then
							if arg_37_1.isInRecall_ then
								local var_40_19 = Mathf.Lerp(iter_40_6.color.r, arg_37_1.hightColor2.r, var_40_18)
								local var_40_20 = Mathf.Lerp(iter_40_6.color.g, arg_37_1.hightColor2.g, var_40_18)
								local var_40_21 = Mathf.Lerp(iter_40_6.color.b, arg_37_1.hightColor2.b, var_40_18)

								iter_40_6.color = Color.New(var_40_19, var_40_20, var_40_21)
							else
								local var_40_22 = Mathf.Lerp(iter_40_6.color.r, 0.5, var_40_18)

								iter_40_6.color = Color.New(var_40_22, var_40_22, var_40_22)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps1061 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_40_8 then
						if arg_37_1.isInRecall_ then
							iter_40_8.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps1061 = nil
			end

			local var_40_23 = 0
			local var_40_24 = 0.775

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_25 = arg_37_1:FormatText(StoryNameCfg[596].name)

				arg_37_1.leftNameTxt_.text = var_40_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:GetWordFromCfg(410182009)
				local var_40_27 = arg_37_1:FormatText(var_40_26.content)

				arg_37_1.text_.text = var_40_27

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 31
				local var_40_29 = utf8.len(var_40_27)
				local var_40_30 = var_40_28 <= 0 and var_40_24 or var_40_24 * (var_40_29 / var_40_28)

				if var_40_30 > 0 and var_40_24 < var_40_30 then
					arg_37_1.talkMaxDuration = var_40_30

					if var_40_30 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_30 + var_40_23
					end
				end

				arg_37_1.text_.text = var_40_27
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182009", "story_v_out_410182.awb") ~= 0 then
					local var_40_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182009", "story_v_out_410182.awb") / 1000

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end

					if var_40_26.prefab_name ~= "" and arg_37_1.actors_[var_40_26.prefab_name] ~= nil then
						local var_40_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_26.prefab_name].transform, "story_v_out_410182", "410182009", "story_v_out_410182.awb")

						arg_37_1:RecordAudio("410182009", var_40_32)
						arg_37_1:RecordAudio("410182009", var_40_32)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410182", "410182009", "story_v_out_410182.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410182", "410182009", "story_v_out_410182.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_33 = math.max(var_40_24, arg_37_1.talkMaxDuration)

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_33 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_23) / var_40_33

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_23 + var_40_33 and arg_37_1.time_ < var_40_23 + var_40_33 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410182010
		arg_41_1.duration_ = 4.07

		local var_41_0 = {
			ja = 4.066,
			CriLanguages = 1.766,
			zh = 1.766
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
				arg_41_0:Play410182011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1061"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1061 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1061", 4)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_2" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(390, -490, 18)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1061, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_44_7 = arg_41_1.actors_["1061"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1061 == nil then
				arg_41_1.var_.actorSpriteComps1061 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps1061 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps1061 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1061 = nil
			end

			local var_44_15 = arg_41_1.actors_["10059"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps10059 == nil then
				arg_41_1.var_.actorSpriteComps10059 = var_44_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_17 = 0.034

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.actorSpriteComps10059 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_44_6 then
							if arg_41_1.isInRecall_ then
								local var_44_19 = Mathf.Lerp(iter_44_6.color.r, arg_41_1.hightColor2.r, var_44_18)
								local var_44_20 = Mathf.Lerp(iter_44_6.color.g, arg_41_1.hightColor2.g, var_44_18)
								local var_44_21 = Mathf.Lerp(iter_44_6.color.b, arg_41_1.hightColor2.b, var_44_18)

								iter_44_6.color = Color.New(var_44_19, var_44_20, var_44_21)
							else
								local var_44_22 = Mathf.Lerp(iter_44_6.color.r, 0.5, var_44_18)

								iter_44_6.color = Color.New(var_44_22, var_44_22, var_44_22)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps10059 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_44_8 then
						if arg_41_1.isInRecall_ then
							iter_44_8.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10059 = nil
			end

			local var_44_23 = 0
			local var_44_24 = 0.125

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[612].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(410182010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 5
				local var_44_29 = utf8.len(var_44_27)
				local var_44_30 = var_44_28 <= 0 and var_44_24 or var_44_24 * (var_44_29 / var_44_28)

				if var_44_30 > 0 and var_44_24 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30

					if var_44_30 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_27
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182010", "story_v_out_410182.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182010", "story_v_out_410182.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_410182", "410182010", "story_v_out_410182.awb")

						arg_41_1:RecordAudio("410182010", var_44_32)
						arg_41_1:RecordAudio("410182010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410182", "410182010", "story_v_out_410182.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410182", "410182010", "story_v_out_410182.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_33 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_23) / var_44_33

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_23 + var_44_33 and arg_41_1.time_ < var_44_23 + var_44_33 + arg_44_0 then
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
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play410182011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410182011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410182012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1061"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.034

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.9

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(410182011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 36
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_9 or var_48_9 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_9 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_15 and arg_45_1.time_ < var_48_8 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play410182012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410182012
		arg_49_1.duration_ = 8.77

		local var_49_0 = {
			ja = 8.766,
			CriLanguages = 6.366,
			zh = 6.366
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
				arg_49_0:Play410182013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 4)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "split_5" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(390, -490, 18)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_52_7 = arg_49_1.actors_["1061"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 0.034

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_15 = 0
			local var_52_16 = 0.725

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[612].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(410182012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 29
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182012", "story_v_out_410182.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182012", "story_v_out_410182.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_410182", "410182012", "story_v_out_410182.awb")

						arg_49_1:RecordAudio("410182012", var_52_24)
						arg_49_1:RecordAudio("410182012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410182", "410182012", "story_v_out_410182.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410182", "410182012", "story_v_out_410182.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
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
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410182013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410182013
		arg_53_1.duration_ = 13.1

		local var_53_0 = {
			ja = 13.1,
			CriLanguages = 7.333,
			zh = 7.333
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
				arg_53_0:Play410182014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1061"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1061 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1061", 4)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_5" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(390, -490, 18)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1061, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_56_7 = arg_53_1.actors_["1061"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1061 == nil then
				arg_53_1.var_.actorSpriteComps1061 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 0.034

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps1061 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps1061 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1061 = nil
			end

			local var_56_15 = 0
			local var_56_16 = 0.975

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[612].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(410182013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182013", "story_v_out_410182.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182013", "story_v_out_410182.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_410182", "410182013", "story_v_out_410182.awb")

						arg_53_1:RecordAudio("410182013", var_56_24)
						arg_53_1:RecordAudio("410182013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410182", "410182013", "story_v_out_410182.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410182", "410182013", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410182014
		arg_57_1.duration_ = 12.93

		local var_57_0 = {
			ja = 12.933,
			CriLanguages = 7.433,
			zh = 7.433
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
				arg_57_0:Play410182015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1061"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1061 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1061", 4)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_5" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(390, -490, 18)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1061, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_60_7 = arg_57_1.actors_["1061"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1061 == nil then
				arg_57_1.var_.actorSpriteComps1061 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps1061 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								local var_60_11 = Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, var_60_10)
								local var_60_12 = Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, var_60_10)
								local var_60_13 = Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, var_60_10)

								iter_60_2.color = Color.New(var_60_11, var_60_12, var_60_13)
							else
								local var_60_14 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_10)

								iter_60_2.color = Color.New(var_60_14, var_60_14, var_60_14)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1061 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1061 = nil
			end

			local var_60_15 = 0
			local var_60_16 = 1.1

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[612].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(410182014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 44
				local var_60_21 = utf8.len(var_60_19)
				local var_60_22 = var_60_20 <= 0 and var_60_16 or var_60_16 * (var_60_21 / var_60_20)

				if var_60_22 > 0 and var_60_16 < var_60_22 then
					arg_57_1.talkMaxDuration = var_60_22

					if var_60_22 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_22 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_19
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182014", "story_v_out_410182.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182014", "story_v_out_410182.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_410182", "410182014", "story_v_out_410182.awb")

						arg_57_1:RecordAudio("410182014", var_60_24)
						arg_57_1:RecordAudio("410182014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410182", "410182014", "story_v_out_410182.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410182", "410182014", "story_v_out_410182.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_25 and arg_57_1.time_ < var_60_15 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play410182015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410182015
		arg_61_1.duration_ = 15.67

		local var_61_0 = {
			ja = 15.666,
			CriLanguages = 9.433,
			zh = 9.433
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
				arg_61_0:Play410182016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1061"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 4)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_5" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(390, -490, 18)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_64_7 = arg_61_1.actors_["1061"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								local var_64_11 = Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, var_64_10)
								local var_64_12 = Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, var_64_10)
								local var_64_13 = Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, var_64_10)

								iter_64_2.color = Color.New(var_64_11, var_64_12, var_64_13)
							else
								local var_64_14 = Mathf.Lerp(iter_64_2.color.r, 1, var_64_10)

								iter_64_2.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_15 = 0
			local var_64_16 = 1.275

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[612].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(410182015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182015", "story_v_out_410182.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182015", "story_v_out_410182.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_410182", "410182015", "story_v_out_410182.awb")

						arg_61_1:RecordAudio("410182015", var_64_24)
						arg_61_1:RecordAudio("410182015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410182", "410182015", "story_v_out_410182.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410182", "410182015", "story_v_out_410182.awb")
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410182016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410182016
		arg_65_1.duration_ = 7.03

		local var_65_0 = {
			ja = 1.433,
			CriLanguages = 7.033,
			zh = 1.266
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
				arg_65_0:Play410182017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10059"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10059 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10059", 2)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "split_3" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(-390, -530, 35)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10059, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_68_7 = arg_65_1.actors_["10059"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 == nil then
				arg_65_1.var_.actorSpriteComps10059 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10059 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10059 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10059 = nil
			end

			local var_68_15 = arg_65_1.actors_["1061"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.075

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[596].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(410182016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 3
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182016", "story_v_out_410182.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182016", "story_v_out_410182.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_410182", "410182016", "story_v_out_410182.awb")

						arg_65_1:RecordAudio("410182016", var_68_32)
						arg_65_1:RecordAudio("410182016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410182", "410182016", "story_v_out_410182.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410182", "410182016", "story_v_out_410182.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410182017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410182017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410182018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10059"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10059 == nil then
				arg_69_1.var_.actorSpriteComps10059 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.034

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10059 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10059 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10059 = nil
			end

			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_9 = 2

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_10 = arg_69_1.actors_["10059"].transform
			local var_72_11 = 0

			if var_72_11 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.var_.moveOldPos10059 = var_72_10.localPosition
				var_72_10.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10059", 7)

				local var_72_12 = var_72_10.childCount

				for iter_72_4 = 0, var_72_12 - 1 do
					local var_72_13 = var_72_10:GetChild(iter_72_4)

					if var_72_13.name == "split_3" or not string.find(var_72_13.name, "split") then
						var_72_13.gameObject:SetActive(true)
					else
						var_72_13.gameObject:SetActive(false)
					end
				end
			end

			local var_72_14 = 0.001

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_14 then
				local var_72_15 = (arg_69_1.time_ - var_72_11) / var_72_14
				local var_72_16 = Vector3.New(0, -2000, 35)

				var_72_10.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10059, var_72_16, var_72_15)
			end

			if arg_69_1.time_ >= var_72_11 + var_72_14 and arg_69_1.time_ < var_72_11 + var_72_14 + arg_72_0 then
				var_72_10.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_72_17 = arg_69_1.actors_["1061"].transform
			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_17.localPosition
				var_72_17.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 7)

				local var_72_19 = var_72_17.childCount

				for iter_72_5 = 0, var_72_19 - 1 do
					local var_72_20 = var_72_17:GetChild(iter_72_5)

					if var_72_20.name == "split_3" or not string.find(var_72_20.name, "split") then
						var_72_20.gameObject:SetActive(true)
					else
						var_72_20.gameObject:SetActive(false)
					end
				end
			end

			local var_72_21 = 0.001

			if var_72_18 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_21 then
				local var_72_22 = (arg_69_1.time_ - var_72_18) / var_72_21
				local var_72_23 = Vector3.New(0, -2000, 18)

				var_72_17.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, var_72_23, var_72_22)
			end

			if arg_69_1.time_ >= var_72_18 + var_72_21 and arg_69_1.time_ < var_72_18 + var_72_21 + arg_72_0 then
				var_72_17.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_72_24 = 0
			local var_72_25 = 1.1

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(410182017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 44
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_25 or var_72_25 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_25 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_24 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_24
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_31 = math.max(var_72_25, arg_69_1.talkMaxDuration)

			if var_72_24 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_31 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_24) / var_72_31

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_24 + var_72_31 and arg_69_1.time_ < var_72_24 + var_72_31 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_69_1:InitPlayNodeList()
	end,
	Play410182018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410182018
		arg_73_1.duration_ = 5.93

		local var_73_0 = {
			ja = 5.933,
			CriLanguages = 5.233,
			zh = 5.366
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
				arg_73_0:Play410182019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "ST63"

			if arg_73_1.bgs_[var_76_0] == nil then
				local var_76_1 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_76_0)
				var_76_1.name = var_76_0
				var_76_1.transform.parent = arg_73_1.stage_.transform
				var_76_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_[var_76_0] = var_76_1
			end

			local var_76_2 = 2

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				local var_76_3 = manager.ui.mainCamera.transform.localPosition
				local var_76_4 = Vector3.New(0, 0, 10) + Vector3.New(var_76_3.x, var_76_3.y, 0)
				local var_76_5 = arg_73_1.bgs_.ST63

				var_76_5.transform.localPosition = var_76_4
				var_76_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_6 = var_76_5:GetComponent("SpriteRenderer")

				if var_76_6 and var_76_6.sprite then
					local var_76_7 = (var_76_5.transform.localPosition - var_76_3).z
					local var_76_8 = manager.ui.mainCameraCom_
					local var_76_9 = 2 * var_76_7 * Mathf.Tan(var_76_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_10 = var_76_9 * var_76_8.aspect
					local var_76_11 = var_76_6.sprite.bounds.size.x
					local var_76_12 = var_76_6.sprite.bounds.size.y
					local var_76_13 = var_76_10 / var_76_11
					local var_76_14 = var_76_9 / var_76_12
					local var_76_15 = var_76_14 < var_76_13 and var_76_13 or var_76_14

					var_76_5.transform.localScale = Vector3.New(var_76_15, var_76_15, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "ST63" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17
				local var_76_19 = Color.New(0, 0, 0)

				var_76_19.a = Mathf.Lerp(0, 1, var_76_18)
				arg_73_1.mask_.color = var_76_19
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				local var_76_20 = Color.New(0, 0, 0)

				var_76_20.a = 1
				arg_73_1.mask_.color = var_76_20
			end

			local var_76_21 = 2

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_22 = 2

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_22 then
				local var_76_23 = (arg_73_1.time_ - var_76_21) / var_76_22
				local var_76_24 = Color.New(0, 0, 0)

				var_76_24.a = Mathf.Lerp(1, 0, var_76_23)
				arg_73_1.mask_.color = var_76_24
			end

			if arg_73_1.time_ >= var_76_21 + var_76_22 and arg_73_1.time_ < var_76_21 + var_76_22 + arg_76_0 then
				local var_76_25 = Color.New(0, 0, 0)
				local var_76_26 = 0

				arg_73_1.mask_.enabled = false
				var_76_25.a = var_76_26
				arg_73_1.mask_.color = var_76_25
			end

			local var_76_27 = arg_73_1.actors_["10059"]
			local var_76_28 = 4

			if var_76_28 < arg_73_1.time_ and arg_73_1.time_ <= var_76_28 + arg_76_0 and not isNil(var_76_27) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_29 = 0.034

			if var_76_28 <= arg_73_1.time_ and arg_73_1.time_ < var_76_28 + var_76_29 and not isNil(var_76_27) then
				local var_76_30 = (arg_73_1.time_ - var_76_28) / var_76_29

				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								local var_76_31 = Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor1.r, var_76_30)
								local var_76_32 = Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor1.g, var_76_30)
								local var_76_33 = Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor1.b, var_76_30)

								iter_76_3.color = Color.New(var_76_31, var_76_32, var_76_33)
							else
								local var_76_34 = Mathf.Lerp(iter_76_3.color.r, 1, var_76_30)

								iter_76_3.color = Color.New(var_76_34, var_76_34, var_76_34)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_28 + var_76_29 and arg_73_1.time_ < var_76_28 + var_76_29 + arg_76_0 and not isNil(var_76_27) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_5 then
						if arg_73_1.isInRecall_ then
							iter_76_5.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_35 = arg_73_1.actors_["10059"].transform
			local var_76_36 = 4

			if var_76_36 < arg_73_1.time_ and arg_73_1.time_ <= var_76_36 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = var_76_35.localPosition
				var_76_35.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 2)

				local var_76_37 = var_76_35.childCount

				for iter_76_6 = 0, var_76_37 - 1 do
					local var_76_38 = var_76_35:GetChild(iter_76_6)

					if var_76_38.name == "split_3" or not string.find(var_76_38.name, "split") then
						var_76_38.gameObject:SetActive(true)
					else
						var_76_38.gameObject:SetActive(false)
					end
				end
			end

			local var_76_39 = 0.001

			if var_76_36 <= arg_73_1.time_ and arg_73_1.time_ < var_76_36 + var_76_39 then
				local var_76_40 = (arg_73_1.time_ - var_76_36) / var_76_39
				local var_76_41 = Vector3.New(-390, -530, 35)

				var_76_35.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, var_76_41, var_76_40)
			end

			if arg_73_1.time_ >= var_76_36 + var_76_39 and arg_73_1.time_ < var_76_36 + var_76_39 + arg_76_0 then
				var_76_35.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_76_42 = arg_73_1.actors_["1061"].transform
			local var_76_43 = 4

			if var_76_43 < arg_73_1.time_ and arg_73_1.time_ <= var_76_43 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061 = var_76_42.localPosition
				var_76_42.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1061", 4)

				local var_76_44 = var_76_42.childCount

				for iter_76_7 = 0, var_76_44 - 1 do
					local var_76_45 = var_76_42:GetChild(iter_76_7)

					if var_76_45.name == "split_3" or not string.find(var_76_45.name, "split") then
						var_76_45.gameObject:SetActive(true)
					else
						var_76_45.gameObject:SetActive(false)
					end
				end
			end

			local var_76_46 = 0.001

			if var_76_43 <= arg_73_1.time_ and arg_73_1.time_ < var_76_43 + var_76_46 then
				local var_76_47 = (arg_73_1.time_ - var_76_43) / var_76_46
				local var_76_48 = Vector3.New(390, -490, 18)

				var_76_42.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061, var_76_48, var_76_47)
			end

			if arg_73_1.time_ >= var_76_43 + var_76_46 and arg_73_1.time_ < var_76_43 + var_76_46 + arg_76_0 then
				var_76_42.localPosition = Vector3.New(390, -490, 18)
			end

			local var_76_49 = arg_73_1.actors_["1061"]
			local var_76_50 = 4

			if var_76_50 < arg_73_1.time_ and arg_73_1.time_ <= var_76_50 + arg_76_0 and not isNil(var_76_49) and arg_73_1.var_.actorSpriteComps1061 == nil then
				arg_73_1.var_.actorSpriteComps1061 = var_76_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_51 = 0.034

			if var_76_50 <= arg_73_1.time_ and arg_73_1.time_ < var_76_50 + var_76_51 and not isNil(var_76_49) then
				local var_76_52 = (arg_73_1.time_ - var_76_50) / var_76_51

				if arg_73_1.var_.actorSpriteComps1061 then
					for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_76_9 then
							if arg_73_1.isInRecall_ then
								local var_76_53 = Mathf.Lerp(iter_76_9.color.r, arg_73_1.hightColor2.r, var_76_52)
								local var_76_54 = Mathf.Lerp(iter_76_9.color.g, arg_73_1.hightColor2.g, var_76_52)
								local var_76_55 = Mathf.Lerp(iter_76_9.color.b, arg_73_1.hightColor2.b, var_76_52)

								iter_76_9.color = Color.New(var_76_53, var_76_54, var_76_55)
							else
								local var_76_56 = Mathf.Lerp(iter_76_9.color.r, 0.5, var_76_52)

								iter_76_9.color = Color.New(var_76_56, var_76_56, var_76_56)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_50 + var_76_51 and arg_73_1.time_ < var_76_50 + var_76_51 + arg_76_0 and not isNil(var_76_49) and arg_73_1.var_.actorSpriteComps1061 then
				for iter_76_10, iter_76_11 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_76_11 then
						if arg_73_1.isInRecall_ then
							iter_76_11.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1061 = nil
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_57 = 4
			local var_76_58 = 0.225

			if var_76_57 < arg_73_1.time_ and arg_73_1.time_ <= var_76_57 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_59 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_59:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_60 = arg_73_1:FormatText(StoryNameCfg[596].name)

				arg_73_1.leftNameTxt_.text = var_76_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_61 = arg_73_1:GetWordFromCfg(410182018)
				local var_76_62 = arg_73_1:FormatText(var_76_61.content)

				arg_73_1.text_.text = var_76_62

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_63 = 9
				local var_76_64 = utf8.len(var_76_62)
				local var_76_65 = var_76_63 <= 0 and var_76_58 or var_76_58 * (var_76_64 / var_76_63)

				if var_76_65 > 0 and var_76_58 < var_76_65 then
					arg_73_1.talkMaxDuration = var_76_65
					var_76_57 = var_76_57 + 0.3

					if var_76_65 + var_76_57 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_65 + var_76_57
					end
				end

				arg_73_1.text_.text = var_76_62
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182018", "story_v_out_410182.awb") ~= 0 then
					local var_76_66 = manager.audio:GetVoiceLength("story_v_out_410182", "410182018", "story_v_out_410182.awb") / 1000

					if var_76_66 + var_76_57 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_66 + var_76_57
					end

					if var_76_61.prefab_name ~= "" and arg_73_1.actors_[var_76_61.prefab_name] ~= nil then
						local var_76_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_61.prefab_name].transform, "story_v_out_410182", "410182018", "story_v_out_410182.awb")

						arg_73_1:RecordAudio("410182018", var_76_67)
						arg_73_1:RecordAudio("410182018", var_76_67)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410182", "410182018", "story_v_out_410182.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410182", "410182018", "story_v_out_410182.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_68 = var_76_57 + 0.3
			local var_76_69 = math.max(var_76_58, arg_73_1.talkMaxDuration)

			if var_76_68 <= arg_73_1.time_ and arg_73_1.time_ < var_76_68 + var_76_69 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_68) / var_76_69

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_68 + var_76_69 and arg_73_1.time_ < var_76_68 + var_76_69 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play410182019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410182019
		arg_79_1.duration_ = 12.97

		local var_79_0 = {
			ja = 12.966,
			CriLanguages = 6.4,
			zh = 6.4
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
				arg_79_0:Play410182020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1061"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1061 = var_82_0.localPosition
				var_82_0.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1061", 4)

				local var_82_2 = var_82_0.childCount

				for iter_82_0 = 0, var_82_2 - 1 do
					local var_82_3 = var_82_0:GetChild(iter_82_0)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_4 then
				local var_82_5 = (arg_79_1.time_ - var_82_1) / var_82_4
				local var_82_6 = Vector3.New(390, -490, 18)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1061, var_82_6, var_82_5)
			end

			if arg_79_1.time_ >= var_82_1 + var_82_4 and arg_79_1.time_ < var_82_1 + var_82_4 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_82_7 = arg_79_1.actors_["1061"]
			local var_82_8 = 0

			if var_82_8 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps1061 == nil then
				arg_79_1.var_.actorSpriteComps1061 = var_82_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_9 = 0.034

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_9 and not isNil(var_82_7) then
				local var_82_10 = (arg_79_1.time_ - var_82_8) / var_82_9

				if arg_79_1.var_.actorSpriteComps1061 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_79_1.time_ >= var_82_8 + var_82_9 and arg_79_1.time_ < var_82_8 + var_82_9 + arg_82_0 and not isNil(var_82_7) and arg_79_1.var_.actorSpriteComps1061 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_82_4 then
						if arg_79_1.isInRecall_ then
							iter_82_4.color = arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_82_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps1061 = nil
			end

			local var_82_15 = arg_79_1.actors_["10059"]
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 and not isNil(var_82_15) and arg_79_1.var_.actorSpriteComps10059 == nil then
				arg_79_1.var_.actorSpriteComps10059 = var_82_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_17 = 0.034

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 and not isNil(var_82_15) then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17

				if arg_79_1.var_.actorSpriteComps10059 then
					for iter_82_5, iter_82_6 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_82_6 then
							if arg_79_1.isInRecall_ then
								local var_82_19 = Mathf.Lerp(iter_82_6.color.r, arg_79_1.hightColor2.r, var_82_18)
								local var_82_20 = Mathf.Lerp(iter_82_6.color.g, arg_79_1.hightColor2.g, var_82_18)
								local var_82_21 = Mathf.Lerp(iter_82_6.color.b, arg_79_1.hightColor2.b, var_82_18)

								iter_82_6.color = Color.New(var_82_19, var_82_20, var_82_21)
							else
								local var_82_22 = Mathf.Lerp(iter_82_6.color.r, 0.5, var_82_18)

								iter_82_6.color = Color.New(var_82_22, var_82_22, var_82_22)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 and not isNil(var_82_15) and arg_79_1.var_.actorSpriteComps10059 then
				for iter_82_7, iter_82_8 in pairs(arg_79_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_82_8 then
						if arg_79_1.isInRecall_ then
							iter_82_8.color = arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_82_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_79_1.var_.actorSpriteComps10059 = nil
			end

			local var_82_23 = 0
			local var_82_24 = 0.75

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_25 = arg_79_1:FormatText(StoryNameCfg[612].name)

				arg_79_1.leftNameTxt_.text = var_82_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_26 = arg_79_1:GetWordFromCfg(410182019)
				local var_82_27 = arg_79_1:FormatText(var_82_26.content)

				arg_79_1.text_.text = var_82_27

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_28 = 30
				local var_82_29 = utf8.len(var_82_27)
				local var_82_30 = var_82_28 <= 0 and var_82_24 or var_82_24 * (var_82_29 / var_82_28)

				if var_82_30 > 0 and var_82_24 < var_82_30 then
					arg_79_1.talkMaxDuration = var_82_30

					if var_82_30 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_30 + var_82_23
					end
				end

				arg_79_1.text_.text = var_82_27
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182019", "story_v_out_410182.awb") ~= 0 then
					local var_82_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182019", "story_v_out_410182.awb") / 1000

					if var_82_31 + var_82_23 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_31 + var_82_23
					end

					if var_82_26.prefab_name ~= "" and arg_79_1.actors_[var_82_26.prefab_name] ~= nil then
						local var_82_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_26.prefab_name].transform, "story_v_out_410182", "410182019", "story_v_out_410182.awb")

						arg_79_1:RecordAudio("410182019", var_82_32)
						arg_79_1:RecordAudio("410182019", var_82_32)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_410182", "410182019", "story_v_out_410182.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_410182", "410182019", "story_v_out_410182.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_33 = math.max(var_82_24, arg_79_1.talkMaxDuration)

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_33 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_23) / var_82_33

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_23 + var_82_33 and arg_79_1.time_ < var_82_23 + var_82_33 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play410182020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410182020
		arg_83_1.duration_ = 8.9

		local var_83_0 = {
			ja = 8.533,
			CriLanguages = 1.366,
			zh = 8.9
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
				arg_83_0:Play410182021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10059"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10059 = var_86_0.localPosition
				var_86_0.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10059", 2)

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
				local var_86_6 = Vector3.New(-390, -530, 35)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10059, var_86_6, var_86_5)
			end

			if arg_83_1.time_ >= var_86_1 + var_86_4 and arg_83_1.time_ < var_86_1 + var_86_4 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_86_7 = arg_83_1.actors_["10059"]
			local var_86_8 = 0

			if var_86_8 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10059 == nil then
				arg_83_1.var_.actorSpriteComps10059 = var_86_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_9 = 0.034

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_9 and not isNil(var_86_7) then
				local var_86_10 = (arg_83_1.time_ - var_86_8) / var_86_9

				if arg_83_1.var_.actorSpriteComps10059 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								local var_86_11 = Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, var_86_10)
								local var_86_12 = Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, var_86_10)
								local var_86_13 = Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, var_86_10)

								iter_86_2.color = Color.New(var_86_11, var_86_12, var_86_13)
							else
								local var_86_14 = Mathf.Lerp(iter_86_2.color.r, 1, var_86_10)

								iter_86_2.color = Color.New(var_86_14, var_86_14, var_86_14)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_8 + var_86_9 and arg_83_1.time_ < var_86_8 + var_86_9 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.actorSpriteComps10059 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_86_4 then
						if arg_83_1.isInRecall_ then
							iter_86_4.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_86_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps10059 = nil
			end

			local var_86_15 = arg_83_1.actors_["1061"]
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.actorSpriteComps1061 == nil then
				arg_83_1.var_.actorSpriteComps1061 = var_86_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_17 = 0.034

			if var_86_16 <= arg_83_1.time_ and arg_83_1.time_ < var_86_16 + var_86_17 and not isNil(var_86_15) then
				local var_86_18 = (arg_83_1.time_ - var_86_16) / var_86_17

				if arg_83_1.var_.actorSpriteComps1061 then
					for iter_86_5, iter_86_6 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_86_6 then
							if arg_83_1.isInRecall_ then
								local var_86_19 = Mathf.Lerp(iter_86_6.color.r, arg_83_1.hightColor2.r, var_86_18)
								local var_86_20 = Mathf.Lerp(iter_86_6.color.g, arg_83_1.hightColor2.g, var_86_18)
								local var_86_21 = Mathf.Lerp(iter_86_6.color.b, arg_83_1.hightColor2.b, var_86_18)

								iter_86_6.color = Color.New(var_86_19, var_86_20, var_86_21)
							else
								local var_86_22 = Mathf.Lerp(iter_86_6.color.r, 0.5, var_86_18)

								iter_86_6.color = Color.New(var_86_22, var_86_22, var_86_22)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 and not isNil(var_86_15) and arg_83_1.var_.actorSpriteComps1061 then
				for iter_86_7, iter_86_8 in pairs(arg_83_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_86_8 then
						if arg_83_1.isInRecall_ then
							iter_86_8.color = arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_86_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_83_1.var_.actorSpriteComps1061 = nil
			end

			local var_86_23 = 0
			local var_86_24 = 0.7

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_25 = arg_83_1:FormatText(StoryNameCfg[596].name)

				arg_83_1.leftNameTxt_.text = var_86_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_26 = arg_83_1:GetWordFromCfg(410182020)
				local var_86_27 = arg_83_1:FormatText(var_86_26.content)

				arg_83_1.text_.text = var_86_27

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_28 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182020", "story_v_out_410182.awb") ~= 0 then
					local var_86_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182020", "story_v_out_410182.awb") / 1000

					if var_86_31 + var_86_23 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_31 + var_86_23
					end

					if var_86_26.prefab_name ~= "" and arg_83_1.actors_[var_86_26.prefab_name] ~= nil then
						local var_86_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_26.prefab_name].transform, "story_v_out_410182", "410182020", "story_v_out_410182.awb")

						arg_83_1:RecordAudio("410182020", var_86_32)
						arg_83_1:RecordAudio("410182020", var_86_32)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_410182", "410182020", "story_v_out_410182.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_410182", "410182020", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 410182021
		arg_87_1.duration_ = 4.83

		local var_87_0 = {
			ja = 4.833,
			CriLanguages = 2.366,
			zh = 2.366
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
				arg_87_0:Play410182022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1061"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1061 = var_90_0.localPosition
				var_90_0.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1061", 4)

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
				local var_90_6 = Vector3.New(390, -490, 18)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1061, var_90_6, var_90_5)
			end

			if arg_87_1.time_ >= var_90_1 + var_90_4 and arg_87_1.time_ < var_90_1 + var_90_4 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_90_7 = arg_87_1.actors_["10059"]
			local var_90_8 = 0

			if var_90_8 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10059 == nil then
				arg_87_1.var_.actorSpriteComps10059 = var_90_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_9 = 0.034

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 and not isNil(var_90_7) then
				local var_90_10 = (arg_87_1.time_ - var_90_8) / var_90_9

				if arg_87_1.var_.actorSpriteComps10059 then
					for iter_90_1, iter_90_2 in pairs(arg_87_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_90_2 then
							if arg_87_1.isInRecall_ then
								local var_90_11 = Mathf.Lerp(iter_90_2.color.r, arg_87_1.hightColor2.r, var_90_10)
								local var_90_12 = Mathf.Lerp(iter_90_2.color.g, arg_87_1.hightColor2.g, var_90_10)
								local var_90_13 = Mathf.Lerp(iter_90_2.color.b, arg_87_1.hightColor2.b, var_90_10)

								iter_90_2.color = Color.New(var_90_11, var_90_12, var_90_13)
							else
								local var_90_14 = Mathf.Lerp(iter_90_2.color.r, 0.5, var_90_10)

								iter_90_2.color = Color.New(var_90_14, var_90_14, var_90_14)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 and not isNil(var_90_7) and arg_87_1.var_.actorSpriteComps10059 then
				for iter_90_3, iter_90_4 in pairs(arg_87_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_90_4 then
						if arg_87_1.isInRecall_ then
							iter_90_4.color = arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_90_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps10059 = nil
			end

			local var_90_15 = arg_87_1.actors_["1061"]
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1061 == nil then
				arg_87_1.var_.actorSpriteComps1061 = var_90_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_17 = 0.034

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 and not isNil(var_90_15) then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17

				if arg_87_1.var_.actorSpriteComps1061 then
					for iter_90_5, iter_90_6 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_90_6 then
							if arg_87_1.isInRecall_ then
								local var_90_19 = Mathf.Lerp(iter_90_6.color.r, arg_87_1.hightColor1.r, var_90_18)
								local var_90_20 = Mathf.Lerp(iter_90_6.color.g, arg_87_1.hightColor1.g, var_90_18)
								local var_90_21 = Mathf.Lerp(iter_90_6.color.b, arg_87_1.hightColor1.b, var_90_18)

								iter_90_6.color = Color.New(var_90_19, var_90_20, var_90_21)
							else
								local var_90_22 = Mathf.Lerp(iter_90_6.color.r, 1, var_90_18)

								iter_90_6.color = Color.New(var_90_22, var_90_22, var_90_22)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.actorSpriteComps1061 then
				for iter_90_7, iter_90_8 in pairs(arg_87_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_90_8 then
						if arg_87_1.isInRecall_ then
							iter_90_8.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_90_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_87_1.var_.actorSpriteComps1061 = nil
			end

			local var_90_23 = 0
			local var_90_24 = 0.325

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_25 = arg_87_1:FormatText(StoryNameCfg[612].name)

				arg_87_1.leftNameTxt_.text = var_90_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_26 = arg_87_1:GetWordFromCfg(410182021)
				local var_90_27 = arg_87_1:FormatText(var_90_26.content)

				arg_87_1.text_.text = var_90_27

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_28 = 13
				local var_90_29 = utf8.len(var_90_27)
				local var_90_30 = var_90_28 <= 0 and var_90_24 or var_90_24 * (var_90_29 / var_90_28)

				if var_90_30 > 0 and var_90_24 < var_90_30 then
					arg_87_1.talkMaxDuration = var_90_30

					if var_90_30 + var_90_23 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_30 + var_90_23
					end
				end

				arg_87_1.text_.text = var_90_27
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182021", "story_v_out_410182.awb") ~= 0 then
					local var_90_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182021", "story_v_out_410182.awb") / 1000

					if var_90_31 + var_90_23 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_31 + var_90_23
					end

					if var_90_26.prefab_name ~= "" and arg_87_1.actors_[var_90_26.prefab_name] ~= nil then
						local var_90_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_26.prefab_name].transform, "story_v_out_410182", "410182021", "story_v_out_410182.awb")

						arg_87_1:RecordAudio("410182021", var_90_32)
						arg_87_1:RecordAudio("410182021", var_90_32)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_410182", "410182021", "story_v_out_410182.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_410182", "410182021", "story_v_out_410182.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_33 = math.max(var_90_24, arg_87_1.talkMaxDuration)

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_33 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_23) / var_90_33

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_23 + var_90_33 and arg_87_1.time_ < var_90_23 + var_90_33 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play410182022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 410182022
		arg_91_1.duration_ = 8.9

		local var_91_0 = {
			ja = 3.766,
			CriLanguages = 8.9,
			zh = 2.6
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
				arg_91_0:Play410182023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10059"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos10059 = var_94_0.localPosition
				var_94_0.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10059", 2)

				local var_94_2 = var_94_0.childCount

				for iter_94_0 = 0, var_94_2 - 1 do
					local var_94_3 = var_94_0:GetChild(iter_94_0)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_4 then
				local var_94_5 = (arg_91_1.time_ - var_94_1) / var_94_4
				local var_94_6 = Vector3.New(-390, -530, 35)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10059, var_94_6, var_94_5)
			end

			if arg_91_1.time_ >= var_94_1 + var_94_4 and arg_91_1.time_ < var_94_1 + var_94_4 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_94_7 = arg_91_1.actors_["10059"]
			local var_94_8 = 0

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps10059 == nil then
				arg_91_1.var_.actorSpriteComps10059 = var_94_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 and not isNil(var_94_7) then
				local var_94_10 = (arg_91_1.time_ - var_94_8) / var_94_9

				if arg_91_1.var_.actorSpriteComps10059 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								local var_94_11 = Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, var_94_10)
								local var_94_12 = Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, var_94_10)
								local var_94_13 = Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, var_94_10)

								iter_94_2.color = Color.New(var_94_11, var_94_12, var_94_13)
							else
								local var_94_14 = Mathf.Lerp(iter_94_2.color.r, 1, var_94_10)

								iter_94_2.color = Color.New(var_94_14, var_94_14, var_94_14)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 and not isNil(var_94_7) and arg_91_1.var_.actorSpriteComps10059 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_94_4 then
						if arg_91_1.isInRecall_ then
							iter_94_4.color = arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_94_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps10059 = nil
			end

			local var_94_15 = arg_91_1.actors_["1061"]
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.actorSpriteComps1061 == nil then
				arg_91_1.var_.actorSpriteComps1061 = var_94_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_17 = 0.034

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 and not isNil(var_94_15) then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17

				if arg_91_1.var_.actorSpriteComps1061 then
					for iter_94_5, iter_94_6 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_94_6 then
							if arg_91_1.isInRecall_ then
								local var_94_19 = Mathf.Lerp(iter_94_6.color.r, arg_91_1.hightColor2.r, var_94_18)
								local var_94_20 = Mathf.Lerp(iter_94_6.color.g, arg_91_1.hightColor2.g, var_94_18)
								local var_94_21 = Mathf.Lerp(iter_94_6.color.b, arg_91_1.hightColor2.b, var_94_18)

								iter_94_6.color = Color.New(var_94_19, var_94_20, var_94_21)
							else
								local var_94_22 = Mathf.Lerp(iter_94_6.color.r, 0.5, var_94_18)

								iter_94_6.color = Color.New(var_94_22, var_94_22, var_94_22)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 and not isNil(var_94_15) and arg_91_1.var_.actorSpriteComps1061 then
				for iter_94_7, iter_94_8 in pairs(arg_91_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_94_8 then
						if arg_91_1.isInRecall_ then
							iter_94_8.color = arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_94_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_91_1.var_.actorSpriteComps1061 = nil
			end

			local var_94_23 = 0
			local var_94_24 = 0.2

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_25 = arg_91_1:FormatText(StoryNameCfg[596].name)

				arg_91_1.leftNameTxt_.text = var_94_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(410182022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182022", "story_v_out_410182.awb") ~= 0 then
					local var_94_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182022", "story_v_out_410182.awb") / 1000

					if var_94_31 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_23
					end

					if var_94_26.prefab_name ~= "" and arg_91_1.actors_[var_94_26.prefab_name] ~= nil then
						local var_94_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_26.prefab_name].transform, "story_v_out_410182", "410182022", "story_v_out_410182.awb")

						arg_91_1:RecordAudio("410182022", var_94_32)
						arg_91_1:RecordAudio("410182022", var_94_32)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_410182", "410182022", "story_v_out_410182.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_410182", "410182022", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410182023
		arg_95_1.duration_ = 8.87

		local var_95_0 = {
			ja = 8.866,
			CriLanguages = 6.466,
			zh = 6.466
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
				arg_95_0:Play410182024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1061"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1061 = var_98_0.localPosition
				var_98_0.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1061", 4)

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
				local var_98_6 = Vector3.New(390, -490, 18)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1061, var_98_6, var_98_5)
			end

			if arg_95_1.time_ >= var_98_1 + var_98_4 and arg_95_1.time_ < var_98_1 + var_98_4 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_98_7 = arg_95_1.actors_["10059"]
			local var_98_8 = 0

			if var_98_8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps10059 == nil then
				arg_95_1.var_.actorSpriteComps10059 = var_98_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_9 = 0.034

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_9 and not isNil(var_98_7) then
				local var_98_10 = (arg_95_1.time_ - var_98_8) / var_98_9

				if arg_95_1.var_.actorSpriteComps10059 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								local var_98_11 = Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor2.r, var_98_10)
								local var_98_12 = Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor2.g, var_98_10)
								local var_98_13 = Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor2.b, var_98_10)

								iter_98_2.color = Color.New(var_98_11, var_98_12, var_98_13)
							else
								local var_98_14 = Mathf.Lerp(iter_98_2.color.r, 0.5, var_98_10)

								iter_98_2.color = Color.New(var_98_14, var_98_14, var_98_14)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_8 + var_98_9 and arg_95_1.time_ < var_98_8 + var_98_9 + arg_98_0 and not isNil(var_98_7) and arg_95_1.var_.actorSpriteComps10059 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_98_4 then
						if arg_95_1.isInRecall_ then
							iter_98_4.color = arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_98_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps10059 = nil
			end

			local var_98_15 = arg_95_1.actors_["1061"]
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 and not isNil(var_98_15) and arg_95_1.var_.actorSpriteComps1061 == nil then
				arg_95_1.var_.actorSpriteComps1061 = var_98_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_17 = 0.034

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 and not isNil(var_98_15) then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17

				if arg_95_1.var_.actorSpriteComps1061 then
					for iter_98_5, iter_98_6 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_98_6 then
							if arg_95_1.isInRecall_ then
								local var_98_19 = Mathf.Lerp(iter_98_6.color.r, arg_95_1.hightColor1.r, var_98_18)
								local var_98_20 = Mathf.Lerp(iter_98_6.color.g, arg_95_1.hightColor1.g, var_98_18)
								local var_98_21 = Mathf.Lerp(iter_98_6.color.b, arg_95_1.hightColor1.b, var_98_18)

								iter_98_6.color = Color.New(var_98_19, var_98_20, var_98_21)
							else
								local var_98_22 = Mathf.Lerp(iter_98_6.color.r, 1, var_98_18)

								iter_98_6.color = Color.New(var_98_22, var_98_22, var_98_22)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 and not isNil(var_98_15) and arg_95_1.var_.actorSpriteComps1061 then
				for iter_98_7, iter_98_8 in pairs(arg_95_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_98_8 then
						if arg_95_1.isInRecall_ then
							iter_98_8.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_98_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_95_1.var_.actorSpriteComps1061 = nil
			end

			local var_98_23 = 0
			local var_98_24 = 0.7

			if var_98_23 < arg_95_1.time_ and arg_95_1.time_ <= var_98_23 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_25 = arg_95_1:FormatText(StoryNameCfg[612].name)

				arg_95_1.leftNameTxt_.text = var_98_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_26 = arg_95_1:GetWordFromCfg(410182023)
				local var_98_27 = arg_95_1:FormatText(var_98_26.content)

				arg_95_1.text_.text = var_98_27

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_28 = 28
				local var_98_29 = utf8.len(var_98_27)
				local var_98_30 = var_98_28 <= 0 and var_98_24 or var_98_24 * (var_98_29 / var_98_28)

				if var_98_30 > 0 and var_98_24 < var_98_30 then
					arg_95_1.talkMaxDuration = var_98_30

					if var_98_30 + var_98_23 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_30 + var_98_23
					end
				end

				arg_95_1.text_.text = var_98_27
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182023", "story_v_out_410182.awb") ~= 0 then
					local var_98_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182023", "story_v_out_410182.awb") / 1000

					if var_98_31 + var_98_23 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_31 + var_98_23
					end

					if var_98_26.prefab_name ~= "" and arg_95_1.actors_[var_98_26.prefab_name] ~= nil then
						local var_98_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_26.prefab_name].transform, "story_v_out_410182", "410182023", "story_v_out_410182.awb")

						arg_95_1:RecordAudio("410182023", var_98_32)
						arg_95_1:RecordAudio("410182023", var_98_32)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_410182", "410182023", "story_v_out_410182.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_410182", "410182023", "story_v_out_410182.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_33 = math.max(var_98_24, arg_95_1.talkMaxDuration)

			if var_98_23 <= arg_95_1.time_ and arg_95_1.time_ < var_98_23 + var_98_33 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_23) / var_98_33

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_23 + var_98_33 and arg_95_1.time_ < var_98_23 + var_98_33 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play410182024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410182024
		arg_99_1.duration_ = 11.97

		local var_99_0 = {
			ja = 11.733,
			CriLanguages = 11.966,
			zh = 11.966
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
				arg_99_0:Play410182025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1061"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1061 = var_102_0.localPosition
				var_102_0.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1061", 4)

				local var_102_2 = var_102_0.childCount

				for iter_102_0 = 0, var_102_2 - 1 do
					local var_102_3 = var_102_0:GetChild(iter_102_0)

					if var_102_3.name == "" or not string.find(var_102_3.name, "split") then
						var_102_3.gameObject:SetActive(true)
					else
						var_102_3.gameObject:SetActive(false)
					end
				end
			end

			local var_102_4 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_4 then
				local var_102_5 = (arg_99_1.time_ - var_102_1) / var_102_4
				local var_102_6 = Vector3.New(390, -490, 18)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1061, var_102_6, var_102_5)
			end

			if arg_99_1.time_ >= var_102_1 + var_102_4 and arg_99_1.time_ < var_102_1 + var_102_4 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_102_7 = arg_99_1.actors_["1061"]
			local var_102_8 = 0

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.actorSpriteComps1061 == nil then
				arg_99_1.var_.actorSpriteComps1061 = var_102_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_9 = 0.034

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_9 and not isNil(var_102_7) then
				local var_102_10 = (arg_99_1.time_ - var_102_8) / var_102_9

				if arg_99_1.var_.actorSpriteComps1061 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_102_2 then
							if arg_99_1.isInRecall_ then
								local var_102_11 = Mathf.Lerp(iter_102_2.color.r, arg_99_1.hightColor1.r, var_102_10)
								local var_102_12 = Mathf.Lerp(iter_102_2.color.g, arg_99_1.hightColor1.g, var_102_10)
								local var_102_13 = Mathf.Lerp(iter_102_2.color.b, arg_99_1.hightColor1.b, var_102_10)

								iter_102_2.color = Color.New(var_102_11, var_102_12, var_102_13)
							else
								local var_102_14 = Mathf.Lerp(iter_102_2.color.r, 1, var_102_10)

								iter_102_2.color = Color.New(var_102_14, var_102_14, var_102_14)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= var_102_8 + var_102_9 and arg_99_1.time_ < var_102_8 + var_102_9 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.actorSpriteComps1061 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_102_4 then
						if arg_99_1.isInRecall_ then
							iter_102_4.color = arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_102_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_99_1.var_.actorSpriteComps1061 = nil
			end

			local var_102_15 = 0
			local var_102_16 = 1.475

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[612].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(410182024)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 59
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182024", "story_v_out_410182.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182024", "story_v_out_410182.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_410182", "410182024", "story_v_out_410182.awb")

						arg_99_1:RecordAudio("410182024", var_102_24)
						arg_99_1:RecordAudio("410182024", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410182", "410182024", "story_v_out_410182.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410182", "410182024", "story_v_out_410182.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play410182025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410182025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play410182026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1061"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1061 == nil then
				arg_103_1.var_.actorSpriteComps1061 = var_106_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_2 = 0.034

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.actorSpriteComps1061 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								local var_106_4 = Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor2.r, var_106_3)
								local var_106_5 = Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor2.g, var_106_3)
								local var_106_6 = Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor2.b, var_106_3)

								iter_106_1.color = Color.New(var_106_4, var_106_5, var_106_6)
							else
								local var_106_7 = Mathf.Lerp(iter_106_1.color.r, 0.5, var_106_3)

								iter_106_1.color = Color.New(var_106_7, var_106_7, var_106_7)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.actorSpriteComps1061 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_106_3 then
						if arg_103_1.isInRecall_ then
							iter_106_3.color = arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_106_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1061 = nil
			end

			local var_106_8 = 0
			local var_106_9 = 1.45

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(410182025)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_12 = 58
				local var_106_13 = utf8.len(var_106_11)
				local var_106_14 = var_106_12 <= 0 and var_106_9 or var_106_9 * (var_106_13 / var_106_12)

				if var_106_14 > 0 and var_106_9 < var_106_14 then
					arg_103_1.talkMaxDuration = var_106_14

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_15 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_15 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_15

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_15 and arg_103_1.time_ < var_106_8 + var_106_15 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play410182026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410182026
		arg_107_1.duration_ = 16.17

		local var_107_0 = {
			ja = 16.166,
			CriLanguages = 2.566,
			zh = 10.2
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
				arg_107_0:Play410182027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10059"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10059 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10059", 2)

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
				local var_110_6 = Vector3.New(-390, -530, 35)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10059, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_110_7 = arg_107_1.actors_["10059"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10059 == nil then
				arg_107_1.var_.actorSpriteComps10059 = var_110_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 0.034

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_9 and not isNil(var_110_7) then
				local var_110_10 = (arg_107_1.time_ - var_110_8) / var_110_9

				if arg_107_1.var_.actorSpriteComps10059 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_107_1.time_ >= var_110_8 + var_110_9 and arg_107_1.time_ < var_110_8 + var_110_9 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps10059 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_110_4 then
						if arg_107_1.isInRecall_ then
							iter_110_4.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10059 = nil
			end

			local var_110_15 = 0
			local var_110_16 = 1.075

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[596].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(410182026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 43
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182026", "story_v_out_410182.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182026", "story_v_out_410182.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_410182", "410182026", "story_v_out_410182.awb")

						arg_107_1:RecordAudio("410182026", var_110_24)
						arg_107_1:RecordAudio("410182026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410182", "410182026", "story_v_out_410182.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410182", "410182026", "story_v_out_410182.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410182027
		arg_111_1.duration_ = 6.43

		local var_111_0 = {
			ja = 6.433,
			CriLanguages = 2.933,
			zh = 2.933
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
				arg_111_0:Play410182028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1061"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1061 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1061", 4)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "split_5" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(390, -490, 18)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1061, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_114_7 = arg_111_1.actors_["1061"]
			local var_114_8 = 0

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1061 == nil then
				arg_111_1.var_.actorSpriteComps1061 = var_114_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 0.034

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 and not isNil(var_114_7) then
				local var_114_10 = (arg_111_1.time_ - var_114_8) / var_114_9

				if arg_111_1.var_.actorSpriteComps1061 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								local var_114_11 = Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, var_114_10)
								local var_114_12 = Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, var_114_10)
								local var_114_13 = Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, var_114_10)

								iter_114_2.color = Color.New(var_114_11, var_114_12, var_114_13)
							else
								local var_114_14 = Mathf.Lerp(iter_114_2.color.r, 1, var_114_10)

								iter_114_2.color = Color.New(var_114_14, var_114_14, var_114_14)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1061 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_114_4 then
						if arg_111_1.isInRecall_ then
							iter_114_4.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1061 = nil
			end

			local var_114_15 = arg_111_1.actors_["10059"]
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps10059 == nil then
				arg_111_1.var_.actorSpriteComps10059 = var_114_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_17 = 0.034

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_17 and not isNil(var_114_15) then
				local var_114_18 = (arg_111_1.time_ - var_114_16) / var_114_17

				if arg_111_1.var_.actorSpriteComps10059 then
					for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_111_1.time_ >= var_114_16 + var_114_17 and arg_111_1.time_ < var_114_16 + var_114_17 + arg_114_0 and not isNil(var_114_15) and arg_111_1.var_.actorSpriteComps10059 then
				for iter_114_7, iter_114_8 in pairs(arg_111_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_114_8 then
						if arg_111_1.isInRecall_ then
							iter_114_8.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10059 = nil
			end

			local var_114_23 = 0
			local var_114_24 = 0.375

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_25 = arg_111_1:FormatText(StoryNameCfg[612].name)

				arg_111_1.leftNameTxt_.text = var_114_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_26 = arg_111_1:GetWordFromCfg(410182027)
				local var_114_27 = arg_111_1:FormatText(var_114_26.content)

				arg_111_1.text_.text = var_114_27

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_28 = 15
				local var_114_29 = utf8.len(var_114_27)
				local var_114_30 = var_114_28 <= 0 and var_114_24 or var_114_24 * (var_114_29 / var_114_28)

				if var_114_30 > 0 and var_114_24 < var_114_30 then
					arg_111_1.talkMaxDuration = var_114_30

					if var_114_30 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_30 + var_114_23
					end
				end

				arg_111_1.text_.text = var_114_27
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182027", "story_v_out_410182.awb") ~= 0 then
					local var_114_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182027", "story_v_out_410182.awb") / 1000

					if var_114_31 + var_114_23 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_31 + var_114_23
					end

					if var_114_26.prefab_name ~= "" and arg_111_1.actors_[var_114_26.prefab_name] ~= nil then
						local var_114_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_26.prefab_name].transform, "story_v_out_410182", "410182027", "story_v_out_410182.awb")

						arg_111_1:RecordAudio("410182027", var_114_32)
						arg_111_1:RecordAudio("410182027", var_114_32)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410182", "410182027", "story_v_out_410182.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410182", "410182027", "story_v_out_410182.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_33 = math.max(var_114_24, arg_111_1.talkMaxDuration)

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_33 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_23) / var_114_33

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_23 + var_114_33 and arg_111_1.time_ < var_114_23 + var_114_33 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play410182028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410182028
		arg_115_1.duration_ = 13.87

		local var_115_0 = {
			ja = 13.866,
			CriLanguages = 10.166,
			zh = 8.366
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
				arg_115_0:Play410182029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10059"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10059 = var_118_0.localPosition
				var_118_0.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10059", 2)

				local var_118_2 = var_118_0.childCount

				for iter_118_0 = 0, var_118_2 - 1 do
					local var_118_3 = var_118_0:GetChild(iter_118_0)

					if var_118_3.name == "" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_4 then
				local var_118_5 = (arg_115_1.time_ - var_118_1) / var_118_4
				local var_118_6 = Vector3.New(-390, -530, 35)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10059, var_118_6, var_118_5)
			end

			if arg_115_1.time_ >= var_118_1 + var_118_4 and arg_115_1.time_ < var_118_1 + var_118_4 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_118_7 = arg_115_1.actors_["10059"]
			local var_118_8 = 0

			if var_118_8 < arg_115_1.time_ and arg_115_1.time_ <= var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10059 == nil then
				arg_115_1.var_.actorSpriteComps10059 = var_118_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.034

			if var_118_8 <= arg_115_1.time_ and arg_115_1.time_ < var_118_8 + var_118_9 and not isNil(var_118_7) then
				local var_118_10 = (arg_115_1.time_ - var_118_8) / var_118_9

				if arg_115_1.var_.actorSpriteComps10059 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								local var_118_11 = Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor1.r, var_118_10)
								local var_118_12 = Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor1.g, var_118_10)
								local var_118_13 = Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor1.b, var_118_10)

								iter_118_2.color = Color.New(var_118_11, var_118_12, var_118_13)
							else
								local var_118_14 = Mathf.Lerp(iter_118_2.color.r, 1, var_118_10)

								iter_118_2.color = Color.New(var_118_14, var_118_14, var_118_14)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_8 + var_118_9 and arg_115_1.time_ < var_118_8 + var_118_9 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.actorSpriteComps10059 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_118_4 then
						if arg_115_1.isInRecall_ then
							iter_118_4.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10059 = nil
			end

			local var_118_15 = arg_115_1.actors_["1061"]
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.actorSpriteComps1061 == nil then
				arg_115_1.var_.actorSpriteComps1061 = var_118_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_17 = 0.034

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 and not isNil(var_118_15) then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17

				if arg_115_1.var_.actorSpriteComps1061 then
					for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_118_6 then
							if arg_115_1.isInRecall_ then
								local var_118_19 = Mathf.Lerp(iter_118_6.color.r, arg_115_1.hightColor2.r, var_118_18)
								local var_118_20 = Mathf.Lerp(iter_118_6.color.g, arg_115_1.hightColor2.g, var_118_18)
								local var_118_21 = Mathf.Lerp(iter_118_6.color.b, arg_115_1.hightColor2.b, var_118_18)

								iter_118_6.color = Color.New(var_118_19, var_118_20, var_118_21)
							else
								local var_118_22 = Mathf.Lerp(iter_118_6.color.r, 0.5, var_118_18)

								iter_118_6.color = Color.New(var_118_22, var_118_22, var_118_22)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.actorSpriteComps1061 then
				for iter_118_7, iter_118_8 in pairs(arg_115_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_118_8 then
						if arg_115_1.isInRecall_ then
							iter_118_8.color = arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_118_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps1061 = nil
			end

			local var_118_23 = 0
			local var_118_24 = 0.95

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_25 = arg_115_1:FormatText(StoryNameCfg[596].name)

				arg_115_1.leftNameTxt_.text = var_118_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_26 = arg_115_1:GetWordFromCfg(410182028)
				local var_118_27 = arg_115_1:FormatText(var_118_26.content)

				arg_115_1.text_.text = var_118_27

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_28 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182028", "story_v_out_410182.awb") ~= 0 then
					local var_118_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182028", "story_v_out_410182.awb") / 1000

					if var_118_31 + var_118_23 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_23
					end

					if var_118_26.prefab_name ~= "" and arg_115_1.actors_[var_118_26.prefab_name] ~= nil then
						local var_118_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_26.prefab_name].transform, "story_v_out_410182", "410182028", "story_v_out_410182.awb")

						arg_115_1:RecordAudio("410182028", var_118_32)
						arg_115_1:RecordAudio("410182028", var_118_32)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410182", "410182028", "story_v_out_410182.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410182", "410182028", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410182029
		arg_119_1.duration_ = 7

		local var_119_0 = {
			ja = 5.1,
			CriLanguages = 7,
			zh = 7
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
				arg_119_0:Play410182030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1061"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1061 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1061", 4)

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
				local var_122_6 = Vector3.New(390, -490, 18)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1061, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_122_7 = arg_119_1.actors_["1061"]
			local var_122_8 = 0

			if var_122_8 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 == nil then
				arg_119_1.var_.actorSpriteComps1061 = var_122_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.034

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_9 and not isNil(var_122_7) then
				local var_122_10 = (arg_119_1.time_ - var_122_8) / var_122_9

				if arg_119_1.var_.actorSpriteComps1061 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_119_1.time_ >= var_122_8 + var_122_9 and arg_119_1.time_ < var_122_8 + var_122_9 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.actorSpriteComps1061 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_122_4 then
						if arg_119_1.isInRecall_ then
							iter_122_4.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps1061 = nil
			end

			local var_122_15 = arg_119_1.actors_["10059"]
			local var_122_16 = 0

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10059 == nil then
				arg_119_1.var_.actorSpriteComps10059 = var_122_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_17 = 0.034

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_17 and not isNil(var_122_15) then
				local var_122_18 = (arg_119_1.time_ - var_122_16) / var_122_17

				if arg_119_1.var_.actorSpriteComps10059 then
					for iter_122_5, iter_122_6 in pairs(arg_119_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.actorSpriteComps10059 then
				for iter_122_7, iter_122_8 in pairs(arg_119_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_122_8 then
						if arg_119_1.isInRecall_ then
							iter_122_8.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10059 = nil
			end

			local var_122_23 = 0
			local var_122_24 = 0.95

			if var_122_23 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_25 = arg_119_1:FormatText(StoryNameCfg[612].name)

				arg_119_1.leftNameTxt_.text = var_122_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_26 = arg_119_1:GetWordFromCfg(410182029)
				local var_122_27 = arg_119_1:FormatText(var_122_26.content)

				arg_119_1.text_.text = var_122_27

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182029", "story_v_out_410182.awb") ~= 0 then
					local var_122_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182029", "story_v_out_410182.awb") / 1000

					if var_122_31 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_31 + var_122_23
					end

					if var_122_26.prefab_name ~= "" and arg_119_1.actors_[var_122_26.prefab_name] ~= nil then
						local var_122_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_26.prefab_name].transform, "story_v_out_410182", "410182029", "story_v_out_410182.awb")

						arg_119_1:RecordAudio("410182029", var_122_32)
						arg_119_1:RecordAudio("410182029", var_122_32)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410182", "410182029", "story_v_out_410182.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410182", "410182029", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410182030
		arg_123_1.duration_ = 8.33

		local var_123_0 = {
			ja = 1.966,
			CriLanguages = 8.333,
			zh = 1.366
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
				arg_123_0:Play410182031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10059"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10059 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10059", 2)

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
				local var_126_6 = Vector3.New(-390, -530, 35)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10059, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_126_7 = arg_123_1.actors_["10059"]
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10059 == nil then
				arg_123_1.var_.actorSpriteComps10059 = var_126_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.034

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_9 and not isNil(var_126_7) then
				local var_126_10 = (arg_123_1.time_ - var_126_8) / var_126_9

				if arg_123_1.var_.actorSpriteComps10059 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								local var_126_11 = Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor1.r, var_126_10)
								local var_126_12 = Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor1.g, var_126_10)
								local var_126_13 = Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor1.b, var_126_10)

								iter_126_2.color = Color.New(var_126_11, var_126_12, var_126_13)
							else
								local var_126_14 = Mathf.Lerp(iter_126_2.color.r, 1, var_126_10)

								iter_126_2.color = Color.New(var_126_14, var_126_14, var_126_14)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_8 + var_126_9 and arg_123_1.time_ < var_126_8 + var_126_9 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.actorSpriteComps10059 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_126_4 then
						if arg_123_1.isInRecall_ then
							iter_126_4.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10059 = nil
			end

			local var_126_15 = arg_123_1.actors_["1061"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.actorSpriteComps1061 == nil then
				arg_123_1.var_.actorSpriteComps1061 = var_126_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_17 = 0.034

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.actorSpriteComps1061 then
					for iter_126_5, iter_126_6 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_126_6 then
							if arg_123_1.isInRecall_ then
								local var_126_19 = Mathf.Lerp(iter_126_6.color.r, arg_123_1.hightColor2.r, var_126_18)
								local var_126_20 = Mathf.Lerp(iter_126_6.color.g, arg_123_1.hightColor2.g, var_126_18)
								local var_126_21 = Mathf.Lerp(iter_126_6.color.b, arg_123_1.hightColor2.b, var_126_18)

								iter_126_6.color = Color.New(var_126_19, var_126_20, var_126_21)
							else
								local var_126_22 = Mathf.Lerp(iter_126_6.color.r, 0.5, var_126_18)

								iter_126_6.color = Color.New(var_126_22, var_126_22, var_126_22)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.actorSpriteComps1061 then
				for iter_126_7, iter_126_8 in pairs(arg_123_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_126_8 then
						if arg_123_1.isInRecall_ then
							iter_126_8.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps1061 = nil
			end

			local var_126_23 = 0
			local var_126_24 = 0.15

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_25 = arg_123_1:FormatText(StoryNameCfg[596].name)

				arg_123_1.leftNameTxt_.text = var_126_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_26 = arg_123_1:GetWordFromCfg(410182030)
				local var_126_27 = arg_123_1:FormatText(var_126_26.content)

				arg_123_1.text_.text = var_126_27

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_28 = 6
				local var_126_29 = utf8.len(var_126_27)
				local var_126_30 = var_126_28 <= 0 and var_126_24 or var_126_24 * (var_126_29 / var_126_28)

				if var_126_30 > 0 and var_126_24 < var_126_30 then
					arg_123_1.talkMaxDuration = var_126_30

					if var_126_30 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_30 + var_126_23
					end
				end

				arg_123_1.text_.text = var_126_27
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182030", "story_v_out_410182.awb") ~= 0 then
					local var_126_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182030", "story_v_out_410182.awb") / 1000

					if var_126_31 + var_126_23 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_31 + var_126_23
					end

					if var_126_26.prefab_name ~= "" and arg_123_1.actors_[var_126_26.prefab_name] ~= nil then
						local var_126_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_26.prefab_name].transform, "story_v_out_410182", "410182030", "story_v_out_410182.awb")

						arg_123_1:RecordAudio("410182030", var_126_32)
						arg_123_1:RecordAudio("410182030", var_126_32)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410182", "410182030", "story_v_out_410182.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410182", "410182030", "story_v_out_410182.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_33 = math.max(var_126_24, arg_123_1.talkMaxDuration)

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_33 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_23) / var_126_33

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_23 + var_126_33 and arg_123_1.time_ < var_126_23 + var_126_33 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410182031
		arg_127_1.duration_ = 10.13

		local var_127_0 = {
			ja = 9.333,
			CriLanguages = 1.4,
			zh = 10.133
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
				arg_127_0:Play410182032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10059"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10059 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10059", 2)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(-390, -530, 35)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10059, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_130_7 = arg_127_1.actors_["10059"]
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10059 == nil then
				arg_127_1.var_.actorSpriteComps10059 = var_130_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 and not isNil(var_130_7) then
				local var_130_10 = (arg_127_1.time_ - var_130_8) / var_130_9

				if arg_127_1.var_.actorSpriteComps10059 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								local var_130_11 = Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, var_130_10)
								local var_130_12 = Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, var_130_10)
								local var_130_13 = Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, var_130_10)

								iter_130_2.color = Color.New(var_130_11, var_130_12, var_130_13)
							else
								local var_130_14 = Mathf.Lerp(iter_130_2.color.r, 1, var_130_10)

								iter_130_2.color = Color.New(var_130_14, var_130_14, var_130_14)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps10059 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_130_4 then
						if arg_127_1.isInRecall_ then
							iter_130_4.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10059 = nil
			end

			local var_130_15 = 0
			local var_130_16 = 1.1

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[596].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(410182031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182031", "story_v_out_410182.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182031", "story_v_out_410182.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_410182", "410182031", "story_v_out_410182.awb")

						arg_127_1:RecordAudio("410182031", var_130_24)
						arg_127_1:RecordAudio("410182031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410182", "410182031", "story_v_out_410182.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410182", "410182031", "story_v_out_410182.awb")
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
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play410182032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410182032
		arg_131_1.duration_ = 17.07

		local var_131_0 = {
			ja = 17.066,
			CriLanguages = 6.9,
			zh = 6.9
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
				arg_131_0:Play410182033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1061"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1061 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1061", 4)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "split_5" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(390, -490, 18)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1061, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_134_7 = arg_131_1.actors_["10059"]
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps10059 == nil then
				arg_131_1.var_.actorSpriteComps10059 = var_134_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_9 and not isNil(var_134_7) then
				local var_134_10 = (arg_131_1.time_ - var_134_8) / var_134_9

				if arg_131_1.var_.actorSpriteComps10059 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								local var_134_11 = Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, var_134_10)
								local var_134_12 = Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, var_134_10)
								local var_134_13 = Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, var_134_10)

								iter_134_2.color = Color.New(var_134_11, var_134_12, var_134_13)
							else
								local var_134_14 = Mathf.Lerp(iter_134_2.color.r, 0.5, var_134_10)

								iter_134_2.color = Color.New(var_134_14, var_134_14, var_134_14)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_8 + var_134_9 and arg_131_1.time_ < var_134_8 + var_134_9 + arg_134_0 and not isNil(var_134_7) and arg_131_1.var_.actorSpriteComps10059 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_134_4 then
						if arg_131_1.isInRecall_ then
							iter_134_4.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10059 = nil
			end

			local var_134_15 = arg_131_1.actors_["1061"]
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.actorSpriteComps1061 == nil then
				arg_131_1.var_.actorSpriteComps1061 = var_134_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_17 = 0.034

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 and not isNil(var_134_15) then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17

				if arg_131_1.var_.actorSpriteComps1061 then
					for iter_134_5, iter_134_6 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_134_6 then
							if arg_131_1.isInRecall_ then
								local var_134_19 = Mathf.Lerp(iter_134_6.color.r, arg_131_1.hightColor1.r, var_134_18)
								local var_134_20 = Mathf.Lerp(iter_134_6.color.g, arg_131_1.hightColor1.g, var_134_18)
								local var_134_21 = Mathf.Lerp(iter_134_6.color.b, arg_131_1.hightColor1.b, var_134_18)

								iter_134_6.color = Color.New(var_134_19, var_134_20, var_134_21)
							else
								local var_134_22 = Mathf.Lerp(iter_134_6.color.r, 1, var_134_18)

								iter_134_6.color = Color.New(var_134_22, var_134_22, var_134_22)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 and not isNil(var_134_15) and arg_131_1.var_.actorSpriteComps1061 then
				for iter_134_7, iter_134_8 in pairs(arg_131_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_134_8 then
						if arg_131_1.isInRecall_ then
							iter_134_8.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps1061 = nil
			end

			local var_134_23 = 0
			local var_134_24 = 0.875

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_25 = arg_131_1:FormatText(StoryNameCfg[612].name)

				arg_131_1.leftNameTxt_.text = var_134_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_26 = arg_131_1:GetWordFromCfg(410182032)
				local var_134_27 = arg_131_1:FormatText(var_134_26.content)

				arg_131_1.text_.text = var_134_27

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_28 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182032", "story_v_out_410182.awb") ~= 0 then
					local var_134_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182032", "story_v_out_410182.awb") / 1000

					if var_134_31 + var_134_23 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_31 + var_134_23
					end

					if var_134_26.prefab_name ~= "" and arg_131_1.actors_[var_134_26.prefab_name] ~= nil then
						local var_134_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_26.prefab_name].transform, "story_v_out_410182", "410182032", "story_v_out_410182.awb")

						arg_131_1:RecordAudio("410182032", var_134_32)
						arg_131_1:RecordAudio("410182032", var_134_32)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410182", "410182032", "story_v_out_410182.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410182", "410182032", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410182033
		arg_135_1.duration_ = 10.1

		local var_135_0 = {
			ja = 6.833,
			CriLanguages = 10.1,
			zh = 8.033
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
				arg_135_0:Play410182034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10059"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10059 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10059", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -530, 35)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10059, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_138_7 = arg_135_1.actors_["10059"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10059 == nil then
				arg_135_1.var_.actorSpriteComps10059 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.034

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps10059 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10059 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10059 = nil
			end

			local var_138_15 = arg_135_1.actors_["1061"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps1061 == nil then
				arg_135_1.var_.actorSpriteComps1061 = var_138_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_17 = 0.034

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.actorSpriteComps1061 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps1061 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_138_8 then
						if arg_135_1.isInRecall_ then
							iter_138_8.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1061 = nil
			end

			local var_138_23 = 0
			local var_138_24 = 0.85

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_25 = arg_135_1:FormatText(StoryNameCfg[596].name)

				arg_135_1.leftNameTxt_.text = var_138_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_26 = arg_135_1:GetWordFromCfg(410182033)
				local var_138_27 = arg_135_1:FormatText(var_138_26.content)

				arg_135_1.text_.text = var_138_27

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_28 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182033", "story_v_out_410182.awb") ~= 0 then
					local var_138_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182033", "story_v_out_410182.awb") / 1000

					if var_138_31 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_23
					end

					if var_138_26.prefab_name ~= "" and arg_135_1.actors_[var_138_26.prefab_name] ~= nil then
						local var_138_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_26.prefab_name].transform, "story_v_out_410182", "410182033", "story_v_out_410182.awb")

						arg_135_1:RecordAudio("410182033", var_138_32)
						arg_135_1:RecordAudio("410182033", var_138_32)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410182", "410182033", "story_v_out_410182.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410182", "410182033", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410182034
		arg_139_1.duration_ = 10.83

		local var_139_0 = {
			ja = 9.4,
			CriLanguages = 8,
			zh = 10.833
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
				arg_139_0:Play410182035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10059"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10059 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10059", 2)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(-390, -530, 35)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10059, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_142_7 = arg_139_1.actors_["10059"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10059 == nil then
				arg_139_1.var_.actorSpriteComps10059 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps10059 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps10059 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10059 = nil
			end

			local var_142_15 = 0
			local var_142_16 = 1

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[596].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(410182034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 40
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182034", "story_v_out_410182.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182034", "story_v_out_410182.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_410182", "410182034", "story_v_out_410182.awb")

						arg_139_1:RecordAudio("410182034", var_142_24)
						arg_139_1:RecordAudio("410182034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410182", "410182034", "story_v_out_410182.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410182", "410182034", "story_v_out_410182.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410182035
		arg_143_1.duration_ = 12.17

		local var_143_0 = {
			ja = 12.166,
			CriLanguages = 10.066,
			zh = 10.066
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
				arg_143_0:Play410182036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1061"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1061 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1061", 4)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_5" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(390, -490, 18)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1061, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_146_7 = arg_143_1.actors_["1061"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1061 == nil then
				arg_143_1.var_.actorSpriteComps1061 = var_146_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.034

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.actorSpriteComps1061 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								local var_146_11 = Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, var_146_10)
								local var_146_12 = Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, var_146_10)
								local var_146_13 = Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, var_146_10)

								iter_146_2.color = Color.New(var_146_11, var_146_12, var_146_13)
							else
								local var_146_14 = Mathf.Lerp(iter_146_2.color.r, 1, var_146_10)

								iter_146_2.color = Color.New(var_146_14, var_146_14, var_146_14)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1061 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_146_4 then
						if arg_143_1.isInRecall_ then
							iter_146_4.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1061 = nil
			end

			local var_146_15 = arg_143_1.actors_["10059"]
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.actorSpriteComps10059 == nil then
				arg_143_1.var_.actorSpriteComps10059 = var_146_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_17 = 0.034

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 and not isNil(var_146_15) then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17

				if arg_143_1.var_.actorSpriteComps10059 then
					for iter_146_5, iter_146_6 in pairs(arg_143_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_146_6 then
							if arg_143_1.isInRecall_ then
								local var_146_19 = Mathf.Lerp(iter_146_6.color.r, arg_143_1.hightColor2.r, var_146_18)
								local var_146_20 = Mathf.Lerp(iter_146_6.color.g, arg_143_1.hightColor2.g, var_146_18)
								local var_146_21 = Mathf.Lerp(iter_146_6.color.b, arg_143_1.hightColor2.b, var_146_18)

								iter_146_6.color = Color.New(var_146_19, var_146_20, var_146_21)
							else
								local var_146_22 = Mathf.Lerp(iter_146_6.color.r, 0.5, var_146_18)

								iter_146_6.color = Color.New(var_146_22, var_146_22, var_146_22)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 and not isNil(var_146_15) and arg_143_1.var_.actorSpriteComps10059 then
				for iter_146_7, iter_146_8 in pairs(arg_143_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_146_8 then
						if arg_143_1.isInRecall_ then
							iter_146_8.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10059 = nil
			end

			local var_146_23 = 0
			local var_146_24 = 1.1

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_25 = arg_143_1:FormatText(StoryNameCfg[612].name)

				arg_143_1.leftNameTxt_.text = var_146_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_26 = arg_143_1:GetWordFromCfg(410182035)
				local var_146_27 = arg_143_1:FormatText(var_146_26.content)

				arg_143_1.text_.text = var_146_27

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_28 = 44
				local var_146_29 = utf8.len(var_146_27)
				local var_146_30 = var_146_28 <= 0 and var_146_24 or var_146_24 * (var_146_29 / var_146_28)

				if var_146_30 > 0 and var_146_24 < var_146_30 then
					arg_143_1.talkMaxDuration = var_146_30

					if var_146_30 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_30 + var_146_23
					end
				end

				arg_143_1.text_.text = var_146_27
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182035", "story_v_out_410182.awb") ~= 0 then
					local var_146_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182035", "story_v_out_410182.awb") / 1000

					if var_146_31 + var_146_23 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_31 + var_146_23
					end

					if var_146_26.prefab_name ~= "" and arg_143_1.actors_[var_146_26.prefab_name] ~= nil then
						local var_146_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_26.prefab_name].transform, "story_v_out_410182", "410182035", "story_v_out_410182.awb")

						arg_143_1:RecordAudio("410182035", var_146_32)
						arg_143_1:RecordAudio("410182035", var_146_32)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410182", "410182035", "story_v_out_410182.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410182", "410182035", "story_v_out_410182.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_33 = math.max(var_146_24, arg_143_1.talkMaxDuration)

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_33 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_23) / var_146_33

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_23 + var_146_33 and arg_143_1.time_ < var_146_23 + var_146_33 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play410182036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410182036
		arg_147_1.duration_ = 11.67

		local var_147_0 = {
			ja = 11.666,
			CriLanguages = 7.233,
			zh = 7.233
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
				arg_147_0:Play410182037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1061"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1061 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1061", 4)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "split_5" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(390, -490, 18)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1061, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_150_7 = arg_147_1.actors_["1061"]
			local var_150_8 = 0

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps1061 == nil then
				arg_147_1.var_.actorSpriteComps1061 = var_150_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_9 = 0.034

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 and not isNil(var_150_7) then
				local var_150_10 = (arg_147_1.time_ - var_150_8) / var_150_9

				if arg_147_1.var_.actorSpriteComps1061 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.actorSpriteComps1061 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_150_4 then
						if arg_147_1.isInRecall_ then
							iter_150_4.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1061 = nil
			end

			local var_150_15 = 0
			local var_150_16 = 0.85

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[612].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(410182036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182036", "story_v_out_410182.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182036", "story_v_out_410182.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_out_410182", "410182036", "story_v_out_410182.awb")

						arg_147_1:RecordAudio("410182036", var_150_24)
						arg_147_1:RecordAudio("410182036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410182", "410182036", "story_v_out_410182.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410182", "410182036", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410182037
		arg_151_1.duration_ = 10.8

		local var_151_0 = {
			ja = 4.333,
			CriLanguages = 10.8,
			zh = 1.7
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
				arg_151_0:Play410182038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10059"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10059 = var_154_0.localPosition
				var_154_0.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10059", 2)

				local var_154_2 = var_154_0.childCount

				for iter_154_0 = 0, var_154_2 - 1 do
					local var_154_3 = var_154_0:GetChild(iter_154_0)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_4 then
				local var_154_5 = (arg_151_1.time_ - var_154_1) / var_154_4
				local var_154_6 = Vector3.New(-390, -530, 35)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10059, var_154_6, var_154_5)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_4 and arg_151_1.time_ < var_154_1 + var_154_4 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_154_7 = arg_151_1.actors_["10059"]
			local var_154_8 = 0

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps10059 == nil then
				arg_151_1.var_.actorSpriteComps10059 = var_154_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_9 = 0.034

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_9 and not isNil(var_154_7) then
				local var_154_10 = (arg_151_1.time_ - var_154_8) / var_154_9

				if arg_151_1.var_.actorSpriteComps10059 then
					for iter_154_1, iter_154_2 in pairs(arg_151_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_151_1.time_ >= var_154_8 + var_154_9 and arg_151_1.time_ < var_154_8 + var_154_9 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.actorSpriteComps10059 then
				for iter_154_3, iter_154_4 in pairs(arg_151_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_154_4 then
						if arg_151_1.isInRecall_ then
							iter_154_4.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10059 = nil
			end

			local var_154_15 = arg_151_1.actors_["1061"]
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.actorSpriteComps1061 == nil then
				arg_151_1.var_.actorSpriteComps1061 = var_154_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_17 = 0.034

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 and not isNil(var_154_15) then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17

				if arg_151_1.var_.actorSpriteComps1061 then
					for iter_154_5, iter_154_6 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.actorSpriteComps1061 then
				for iter_154_7, iter_154_8 in pairs(arg_151_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_154_8 then
						if arg_151_1.isInRecall_ then
							iter_154_8.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps1061 = nil
			end

			local var_154_23 = 0
			local var_154_24 = 0.225

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_25 = arg_151_1:FormatText(StoryNameCfg[596].name)

				arg_151_1.leftNameTxt_.text = var_154_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_26 = arg_151_1:GetWordFromCfg(410182037)
				local var_154_27 = arg_151_1:FormatText(var_154_26.content)

				arg_151_1.text_.text = var_154_27

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_28 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182037", "story_v_out_410182.awb") ~= 0 then
					local var_154_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182037", "story_v_out_410182.awb") / 1000

					if var_154_31 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_23
					end

					if var_154_26.prefab_name ~= "" and arg_151_1.actors_[var_154_26.prefab_name] ~= nil then
						local var_154_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_26.prefab_name].transform, "story_v_out_410182", "410182037", "story_v_out_410182.awb")

						arg_151_1:RecordAudio("410182037", var_154_32)
						arg_151_1:RecordAudio("410182037", var_154_32)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410182", "410182037", "story_v_out_410182.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410182", "410182037", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410182038
		arg_155_1.duration_ = 3.5

		local var_155_0 = {
			ja = 3.5,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_155_0:Play410182039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1061"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1061 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1061", 4)

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
				local var_158_6 = Vector3.New(390, -490, 18)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1061, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_158_7 = arg_155_1.actors_["10059"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10059 == nil then
				arg_155_1.var_.actorSpriteComps10059 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.034

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10059 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor2.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor2.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor2.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 0.5, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10059 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_158_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10059 = nil
			end

			local var_158_15 = arg_155_1.actors_["1061"]
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.actorSpriteComps1061 == nil then
				arg_155_1.var_.actorSpriteComps1061 = var_158_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_17 = 0.034

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_17 and not isNil(var_158_15) then
				local var_158_18 = (arg_155_1.time_ - var_158_16) / var_158_17

				if arg_155_1.var_.actorSpriteComps1061 then
					for iter_158_5, iter_158_6 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_158_6 then
							if arg_155_1.isInRecall_ then
								local var_158_19 = Mathf.Lerp(iter_158_6.color.r, arg_155_1.hightColor1.r, var_158_18)
								local var_158_20 = Mathf.Lerp(iter_158_6.color.g, arg_155_1.hightColor1.g, var_158_18)
								local var_158_21 = Mathf.Lerp(iter_158_6.color.b, arg_155_1.hightColor1.b, var_158_18)

								iter_158_6.color = Color.New(var_158_19, var_158_20, var_158_21)
							else
								local var_158_22 = Mathf.Lerp(iter_158_6.color.r, 1, var_158_18)

								iter_158_6.color = Color.New(var_158_22, var_158_22, var_158_22)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_16 + var_158_17 and arg_155_1.time_ < var_158_16 + var_158_17 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.actorSpriteComps1061 then
				for iter_158_7, iter_158_8 in pairs(arg_155_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_158_8 then
						if arg_155_1.isInRecall_ then
							iter_158_8.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps1061 = nil
			end

			local var_158_23 = 0
			local var_158_24 = 0.175

			if var_158_23 < arg_155_1.time_ and arg_155_1.time_ <= var_158_23 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_25 = arg_155_1:FormatText(StoryNameCfg[612].name)

				arg_155_1.leftNameTxt_.text = var_158_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_26 = arg_155_1:GetWordFromCfg(410182038)
				local var_158_27 = arg_155_1:FormatText(var_158_26.content)

				arg_155_1.text_.text = var_158_27

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_28 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182038", "story_v_out_410182.awb") ~= 0 then
					local var_158_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182038", "story_v_out_410182.awb") / 1000

					if var_158_31 + var_158_23 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_31 + var_158_23
					end

					if var_158_26.prefab_name ~= "" and arg_155_1.actors_[var_158_26.prefab_name] ~= nil then
						local var_158_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_26.prefab_name].transform, "story_v_out_410182", "410182038", "story_v_out_410182.awb")

						arg_155_1:RecordAudio("410182038", var_158_32)
						arg_155_1:RecordAudio("410182038", var_158_32)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410182", "410182038", "story_v_out_410182.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410182", "410182038", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410182039
		arg_159_1.duration_ = 1.67

		local var_159_0 = {
			ja = 1.566,
			CriLanguages = 1.666,
			zh = 1.5
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
				arg_159_0:Play410182040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10059"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10059 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10059", 2)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(-390, -530, 35)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10059, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_162_7 = arg_159_1.actors_["10059"]
			local var_162_8 = 0

			if var_162_8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10059 == nil then
				arg_159_1.var_.actorSpriteComps10059 = var_162_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_9 = 0.034

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_9 and not isNil(var_162_7) then
				local var_162_10 = (arg_159_1.time_ - var_162_8) / var_162_9

				if arg_159_1.var_.actorSpriteComps10059 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_159_1.time_ >= var_162_8 + var_162_9 and arg_159_1.time_ < var_162_8 + var_162_9 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.actorSpriteComps10059 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_162_4 then
						if arg_159_1.isInRecall_ then
							iter_162_4.color = arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_162_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps10059 = nil
			end

			local var_162_15 = arg_159_1.actors_["1061"]
			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps1061 == nil then
				arg_159_1.var_.actorSpriteComps1061 = var_162_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_17 = 0.034

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 and not isNil(var_162_15) then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17

				if arg_159_1.var_.actorSpriteComps1061 then
					for iter_162_5, iter_162_6 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.actorSpriteComps1061 then
				for iter_162_7, iter_162_8 in pairs(arg_159_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_162_8 then
						if arg_159_1.isInRecall_ then
							iter_162_8.color = arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_162_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_159_1.var_.actorSpriteComps1061 = nil
			end

			local var_162_23 = 0
			local var_162_24 = 0.125

			if var_162_23 < arg_159_1.time_ and arg_159_1.time_ <= var_162_23 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_25 = arg_159_1:FormatText(StoryNameCfg[596].name)

				arg_159_1.leftNameTxt_.text = var_162_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_26 = arg_159_1:GetWordFromCfg(410182039)
				local var_162_27 = arg_159_1:FormatText(var_162_26.content)

				arg_159_1.text_.text = var_162_27

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182039", "story_v_out_410182.awb") ~= 0 then
					local var_162_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182039", "story_v_out_410182.awb") / 1000

					if var_162_31 + var_162_23 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_31 + var_162_23
					end

					if var_162_26.prefab_name ~= "" and arg_159_1.actors_[var_162_26.prefab_name] ~= nil then
						local var_162_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_26.prefab_name].transform, "story_v_out_410182", "410182039", "story_v_out_410182.awb")

						arg_159_1:RecordAudio("410182039", var_162_32)
						arg_159_1:RecordAudio("410182039", var_162_32)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410182", "410182039", "story_v_out_410182.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410182", "410182039", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410182040
		arg_163_1.duration_ = 5.27

		local var_163_0 = {
			ja = 5.266,
			CriLanguages = 4.533,
			zh = 4.533
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
				arg_163_0:Play410182041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1061"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1061 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1061", 4)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(390, -490, 18)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1061, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_166_7 = arg_163_1.actors_["10059"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10059 == nil then
				arg_163_1.var_.actorSpriteComps10059 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 0.034

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10059 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor2.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor2.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor2.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 0.5, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10059 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10059 = nil
			end

			local var_166_15 = arg_163_1.actors_["1061"]
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps1061 == nil then
				arg_163_1.var_.actorSpriteComps1061 = var_166_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_17 = 0.034

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 and not isNil(var_166_15) then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17

				if arg_163_1.var_.actorSpriteComps1061 then
					for iter_166_5, iter_166_6 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_166_6 then
							if arg_163_1.isInRecall_ then
								local var_166_19 = Mathf.Lerp(iter_166_6.color.r, arg_163_1.hightColor1.r, var_166_18)
								local var_166_20 = Mathf.Lerp(iter_166_6.color.g, arg_163_1.hightColor1.g, var_166_18)
								local var_166_21 = Mathf.Lerp(iter_166_6.color.b, arg_163_1.hightColor1.b, var_166_18)

								iter_166_6.color = Color.New(var_166_19, var_166_20, var_166_21)
							else
								local var_166_22 = Mathf.Lerp(iter_166_6.color.r, 1, var_166_18)

								iter_166_6.color = Color.New(var_166_22, var_166_22, var_166_22)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 and not isNil(var_166_15) and arg_163_1.var_.actorSpriteComps1061 then
				for iter_166_7, iter_166_8 in pairs(arg_163_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_166_8 then
						if arg_163_1.isInRecall_ then
							iter_166_8.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps1061 = nil
			end

			local var_166_23 = 0
			local var_166_24 = 0.575

			if var_166_23 < arg_163_1.time_ and arg_163_1.time_ <= var_166_23 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_25 = arg_163_1:FormatText(StoryNameCfg[612].name)

				arg_163_1.leftNameTxt_.text = var_166_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_26 = arg_163_1:GetWordFromCfg(410182040)
				local var_166_27 = arg_163_1:FormatText(var_166_26.content)

				arg_163_1.text_.text = var_166_27

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_28 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182040", "story_v_out_410182.awb") ~= 0 then
					local var_166_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182040", "story_v_out_410182.awb") / 1000

					if var_166_31 + var_166_23 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_31 + var_166_23
					end

					if var_166_26.prefab_name ~= "" and arg_163_1.actors_[var_166_26.prefab_name] ~= nil then
						local var_166_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_26.prefab_name].transform, "story_v_out_410182", "410182040", "story_v_out_410182.awb")

						arg_163_1:RecordAudio("410182040", var_166_32)
						arg_163_1:RecordAudio("410182040", var_166_32)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410182", "410182040", "story_v_out_410182.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410182", "410182040", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410182041
		arg_167_1.duration_ = 1.5

		local var_167_0 = {
			ja = 1.4,
			CriLanguages = 1.5,
			zh = 1.366
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
				arg_167_0:Play410182042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10059"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10059 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10059", 2)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(-390, -530, 35)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10059, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_170_7 = arg_167_1.actors_["10059"]
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10059 == nil then
				arg_167_1.var_.actorSpriteComps10059 = var_170_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 0.034

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 and not isNil(var_170_7) then
				local var_170_10 = (arg_167_1.time_ - var_170_8) / var_170_9

				if arg_167_1.var_.actorSpriteComps10059 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10059:ToTable()) do
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

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.actorSpriteComps10059 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_170_4 then
						if arg_167_1.isInRecall_ then
							iter_170_4.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10059 = nil
			end

			local var_170_15 = arg_167_1.actors_["1061"]
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.actorSpriteComps1061 == nil then
				arg_167_1.var_.actorSpriteComps1061 = var_170_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_17 = 0.034

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_17 and not isNil(var_170_15) then
				local var_170_18 = (arg_167_1.time_ - var_170_16) / var_170_17

				if arg_167_1.var_.actorSpriteComps1061 then
					for iter_170_5, iter_170_6 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_167_1.time_ >= var_170_16 + var_170_17 and arg_167_1.time_ < var_170_16 + var_170_17 + arg_170_0 and not isNil(var_170_15) and arg_167_1.var_.actorSpriteComps1061 then
				for iter_170_7, iter_170_8 in pairs(arg_167_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_170_8 then
						if arg_167_1.isInRecall_ then
							iter_170_8.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps1061 = nil
			end

			local var_170_23 = 0
			local var_170_24 = 0.125

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_25 = arg_167_1:FormatText(StoryNameCfg[596].name)

				arg_167_1.leftNameTxt_.text = var_170_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_26 = arg_167_1:GetWordFromCfg(410182041)
				local var_170_27 = arg_167_1:FormatText(var_170_26.content)

				arg_167_1.text_.text = var_170_27

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_28 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182041", "story_v_out_410182.awb") ~= 0 then
					local var_170_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182041", "story_v_out_410182.awb") / 1000

					if var_170_31 + var_170_23 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_31 + var_170_23
					end

					if var_170_26.prefab_name ~= "" and arg_167_1.actors_[var_170_26.prefab_name] ~= nil then
						local var_170_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_26.prefab_name].transform, "story_v_out_410182", "410182041", "story_v_out_410182.awb")

						arg_167_1:RecordAudio("410182041", var_170_32)
						arg_167_1:RecordAudio("410182041", var_170_32)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410182", "410182041", "story_v_out_410182.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410182", "410182041", "story_v_out_410182.awb")
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
				actorName = "10059",
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
	Play410182042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410182042
		arg_171_1.duration_ = 11.33

		local var_171_0 = {
			ja = 11.333,
			CriLanguages = 6.8,
			zh = 6.8
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
				arg_171_0:Play410182043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1061"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1061", 4)

				local var_174_2 = var_174_0.childCount

				for iter_174_0 = 0, var_174_2 - 1 do
					local var_174_3 = var_174_0:GetChild(iter_174_0)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_4 then
				local var_174_5 = (arg_171_1.time_ - var_174_1) / var_174_4
				local var_174_6 = Vector3.New(390, -490, 18)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_174_7 = arg_171_1.actors_["10059"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps10059 == nil then
				arg_171_1.var_.actorSpriteComps10059 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.034

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps10059 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor2.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor2.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor2.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 0.5, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps10059 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_174_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps10059 = nil
			end

			local var_174_15 = arg_171_1.actors_["1061"]
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.actorSpriteComps1061 == nil then
				arg_171_1.var_.actorSpriteComps1061 = var_174_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_17 = 0.034

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 and not isNil(var_174_15) then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17

				if arg_171_1.var_.actorSpriteComps1061 then
					for iter_174_5, iter_174_6 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_174_6 then
							if arg_171_1.isInRecall_ then
								local var_174_19 = Mathf.Lerp(iter_174_6.color.r, arg_171_1.hightColor1.r, var_174_18)
								local var_174_20 = Mathf.Lerp(iter_174_6.color.g, arg_171_1.hightColor1.g, var_174_18)
								local var_174_21 = Mathf.Lerp(iter_174_6.color.b, arg_171_1.hightColor1.b, var_174_18)

								iter_174_6.color = Color.New(var_174_19, var_174_20, var_174_21)
							else
								local var_174_22 = Mathf.Lerp(iter_174_6.color.r, 1, var_174_18)

								iter_174_6.color = Color.New(var_174_22, var_174_22, var_174_22)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.actorSpriteComps1061 then
				for iter_174_7, iter_174_8 in pairs(arg_171_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_174_8 then
						if arg_171_1.isInRecall_ then
							iter_174_8.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1061 = nil
			end

			local var_174_23 = 0
			local var_174_24 = 0.85

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_25 = arg_171_1:FormatText(StoryNameCfg[612].name)

				arg_171_1.leftNameTxt_.text = var_174_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_26 = arg_171_1:GetWordFromCfg(410182042)
				local var_174_27 = arg_171_1:FormatText(var_174_26.content)

				arg_171_1.text_.text = var_174_27

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_28 = 34
				local var_174_29 = utf8.len(var_174_27)
				local var_174_30 = var_174_28 <= 0 and var_174_24 or var_174_24 * (var_174_29 / var_174_28)

				if var_174_30 > 0 and var_174_24 < var_174_30 then
					arg_171_1.talkMaxDuration = var_174_30

					if var_174_30 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_30 + var_174_23
					end
				end

				arg_171_1.text_.text = var_174_27
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182042", "story_v_out_410182.awb") ~= 0 then
					local var_174_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182042", "story_v_out_410182.awb") / 1000

					if var_174_31 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_31 + var_174_23
					end

					if var_174_26.prefab_name ~= "" and arg_171_1.actors_[var_174_26.prefab_name] ~= nil then
						local var_174_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_26.prefab_name].transform, "story_v_out_410182", "410182042", "story_v_out_410182.awb")

						arg_171_1:RecordAudio("410182042", var_174_32)
						arg_171_1:RecordAudio("410182042", var_174_32)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410182", "410182042", "story_v_out_410182.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410182", "410182042", "story_v_out_410182.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_33 = math.max(var_174_24, arg_171_1.talkMaxDuration)

			if var_174_23 <= arg_171_1.time_ and arg_171_1.time_ < var_174_23 + var_174_33 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_23) / var_174_33

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_23 + var_174_33 and arg_171_1.time_ < var_174_23 + var_174_33 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410182043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410182043
		arg_175_1.duration_ = 11.53

		local var_175_0 = {
			ja = 11.533,
			CriLanguages = 9.566,
			zh = 9.566
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
				arg_175_0:Play410182044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1061"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061 = var_178_0.localPosition
				var_178_0.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1061", 4)

				local var_178_2 = var_178_0.childCount

				for iter_178_0 = 0, var_178_2 - 1 do
					local var_178_3 = var_178_0:GetChild(iter_178_0)

					if var_178_3.name == "" or not string.find(var_178_3.name, "split") then
						var_178_3.gameObject:SetActive(true)
					else
						var_178_3.gameObject:SetActive(false)
					end
				end
			end

			local var_178_4 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_4 then
				local var_178_5 = (arg_175_1.time_ - var_178_1) / var_178_4
				local var_178_6 = Vector3.New(390, -490, 18)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061, var_178_6, var_178_5)
			end

			if arg_175_1.time_ >= var_178_1 + var_178_4 and arg_175_1.time_ < var_178_1 + var_178_4 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_178_7 = arg_175_1.actors_["1061"]
			local var_178_8 = 0

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps1061 == nil then
				arg_175_1.var_.actorSpriteComps1061 = var_178_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_9 = 0.034

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 and not isNil(var_178_7) then
				local var_178_10 = (arg_175_1.time_ - var_178_8) / var_178_9

				if arg_175_1.var_.actorSpriteComps1061 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								local var_178_11 = Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor1.r, var_178_10)
								local var_178_12 = Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor1.g, var_178_10)
								local var_178_13 = Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor1.b, var_178_10)

								iter_178_2.color = Color.New(var_178_11, var_178_12, var_178_13)
							else
								local var_178_14 = Mathf.Lerp(iter_178_2.color.r, 1, var_178_10)

								iter_178_2.color = Color.New(var_178_14, var_178_14, var_178_14)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 and not isNil(var_178_7) and arg_175_1.var_.actorSpriteComps1061 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_178_4 then
						if arg_175_1.isInRecall_ then
							iter_178_4.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_178_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_175_1.var_.actorSpriteComps1061 = nil
			end

			local var_178_15 = 0
			local var_178_16 = 1.2

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[612].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(410182043)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 48
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182043", "story_v_out_410182.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182043", "story_v_out_410182.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_out_410182", "410182043", "story_v_out_410182.awb")

						arg_175_1:RecordAudio("410182043", var_178_24)
						arg_175_1:RecordAudio("410182043", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410182", "410182043", "story_v_out_410182.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410182", "410182043", "story_v_out_410182.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play410182044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410182044
		arg_179_1.duration_ = 4.1

		local var_179_0 = {
			ja = 4.1,
			CriLanguages = 1.4,
			zh = 2.433
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
				arg_179_0:Play410182045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10059"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos10059 = var_182_0.localPosition
				var_182_0.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10059", 2)

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
				local var_182_6 = Vector3.New(-390, -530, 35)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10059, var_182_6, var_182_5)
			end

			if arg_179_1.time_ >= var_182_1 + var_182_4 and arg_179_1.time_ < var_182_1 + var_182_4 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_182_7 = arg_179_1.actors_["10059"]
			local var_182_8 = 0

			if var_182_8 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10059 == nil then
				arg_179_1.var_.actorSpriteComps10059 = var_182_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_9 = 0.034

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_9 and not isNil(var_182_7) then
				local var_182_10 = (arg_179_1.time_ - var_182_8) / var_182_9

				if arg_179_1.var_.actorSpriteComps10059 then
					for iter_182_1, iter_182_2 in pairs(arg_179_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_182_2 then
							if arg_179_1.isInRecall_ then
								local var_182_11 = Mathf.Lerp(iter_182_2.color.r, arg_179_1.hightColor1.r, var_182_10)
								local var_182_12 = Mathf.Lerp(iter_182_2.color.g, arg_179_1.hightColor1.g, var_182_10)
								local var_182_13 = Mathf.Lerp(iter_182_2.color.b, arg_179_1.hightColor1.b, var_182_10)

								iter_182_2.color = Color.New(var_182_11, var_182_12, var_182_13)
							else
								local var_182_14 = Mathf.Lerp(iter_182_2.color.r, 1, var_182_10)

								iter_182_2.color = Color.New(var_182_14, var_182_14, var_182_14)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_8 + var_182_9 and arg_179_1.time_ < var_182_8 + var_182_9 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.actorSpriteComps10059 then
				for iter_182_3, iter_182_4 in pairs(arg_179_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_182_4 then
						if arg_179_1.isInRecall_ then
							iter_182_4.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps10059 = nil
			end

			local var_182_15 = arg_179_1.actors_["1061"]
			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.actorSpriteComps1061 == nil then
				arg_179_1.var_.actorSpriteComps1061 = var_182_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_17 = 0.034

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 and not isNil(var_182_15) then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17

				if arg_179_1.var_.actorSpriteComps1061 then
					for iter_182_5, iter_182_6 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_182_6 then
							if arg_179_1.isInRecall_ then
								local var_182_19 = Mathf.Lerp(iter_182_6.color.r, arg_179_1.hightColor2.r, var_182_18)
								local var_182_20 = Mathf.Lerp(iter_182_6.color.g, arg_179_1.hightColor2.g, var_182_18)
								local var_182_21 = Mathf.Lerp(iter_182_6.color.b, arg_179_1.hightColor2.b, var_182_18)

								iter_182_6.color = Color.New(var_182_19, var_182_20, var_182_21)
							else
								local var_182_22 = Mathf.Lerp(iter_182_6.color.r, 0.5, var_182_18)

								iter_182_6.color = Color.New(var_182_22, var_182_22, var_182_22)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 and not isNil(var_182_15) and arg_179_1.var_.actorSpriteComps1061 then
				for iter_182_7, iter_182_8 in pairs(arg_179_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_182_8 then
						if arg_179_1.isInRecall_ then
							iter_182_8.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps1061 = nil
			end

			local var_182_23 = 0
			local var_182_24 = 0.3

			if var_182_23 < arg_179_1.time_ and arg_179_1.time_ <= var_182_23 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_25 = arg_179_1:FormatText(StoryNameCfg[596].name)

				arg_179_1.leftNameTxt_.text = var_182_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_26 = arg_179_1:GetWordFromCfg(410182044)
				local var_182_27 = arg_179_1:FormatText(var_182_26.content)

				arg_179_1.text_.text = var_182_27

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_28 = 12
				local var_182_29 = utf8.len(var_182_27)
				local var_182_30 = var_182_28 <= 0 and var_182_24 or var_182_24 * (var_182_29 / var_182_28)

				if var_182_30 > 0 and var_182_24 < var_182_30 then
					arg_179_1.talkMaxDuration = var_182_30

					if var_182_30 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_30 + var_182_23
					end
				end

				arg_179_1.text_.text = var_182_27
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182044", "story_v_out_410182.awb") ~= 0 then
					local var_182_31 = manager.audio:GetVoiceLength("story_v_out_410182", "410182044", "story_v_out_410182.awb") / 1000

					if var_182_31 + var_182_23 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_23
					end

					if var_182_26.prefab_name ~= "" and arg_179_1.actors_[var_182_26.prefab_name] ~= nil then
						local var_182_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_26.prefab_name].transform, "story_v_out_410182", "410182044", "story_v_out_410182.awb")

						arg_179_1:RecordAudio("410182044", var_182_32)
						arg_179_1:RecordAudio("410182044", var_182_32)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410182", "410182044", "story_v_out_410182.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410182", "410182044", "story_v_out_410182.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_33 = math.max(var_182_24, arg_179_1.talkMaxDuration)

			if var_182_23 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_33 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_33

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_33 and arg_179_1.time_ < var_182_23 + var_182_33 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
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
	Play410182045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410182045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play410182046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10059"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10059 == nil then
				arg_183_1.var_.actorSpriteComps10059 = var_186_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_2 = 0.034

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.actorSpriteComps10059 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								local var_186_4 = Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, var_186_3)
								local var_186_5 = Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, var_186_3)
								local var_186_6 = Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, var_186_3)

								iter_186_1.color = Color.New(var_186_4, var_186_5, var_186_6)
							else
								local var_186_7 = Mathf.Lerp(iter_186_1.color.r, 0.5, var_186_3)

								iter_186_1.color = Color.New(var_186_7, var_186_7, var_186_7)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.actorSpriteComps10059 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_186_3 then
						if arg_183_1.isInRecall_ then
							iter_186_3.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10059 = nil
			end

			local var_186_8 = 0
			local var_186_9 = 0.475

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(410182045)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_12 = 19
				local var_186_13 = utf8.len(var_186_11)
				local var_186_14 = var_186_12 <= 0 and var_186_9 or var_186_9 * (var_186_13 / var_186_12)

				if var_186_14 > 0 and var_186_9 < var_186_14 then
					arg_183_1.talkMaxDuration = var_186_14

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_15 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_15 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_15

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_15 and arg_183_1.time_ < var_186_8 + var_186_15 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play410182046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410182046
		arg_187_1.duration_ = 3.23

		local var_187_0 = {
			ja = 2.866,
			CriLanguages = 3.233,
			zh = 3.233
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
				arg_187_0:Play410182047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1061"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos1061 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1061", 4)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(390, -490, 18)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1061, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(390, -490, 18)
			end

			local var_190_7 = arg_187_1.actors_["1061"]
			local var_190_8 = 0

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps1061 == nil then
				arg_187_1.var_.actorSpriteComps1061 = var_190_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 0.034

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 and not isNil(var_190_7) then
				local var_190_10 = (arg_187_1.time_ - var_190_8) / var_190_9

				if arg_187_1.var_.actorSpriteComps1061 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								local var_190_11 = Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor1.r, var_190_10)
								local var_190_12 = Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor1.g, var_190_10)
								local var_190_13 = Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor1.b, var_190_10)

								iter_190_2.color = Color.New(var_190_11, var_190_12, var_190_13)
							else
								local var_190_14 = Mathf.Lerp(iter_190_2.color.r, 1, var_190_10)

								iter_190_2.color = Color.New(var_190_14, var_190_14, var_190_14)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps1061 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_190_4 then
						if arg_187_1.isInRecall_ then
							iter_190_4.color = arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_190_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps1061 = nil
			end

			local var_190_15 = 0
			local var_190_16 = 0.3

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[612].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(410182046)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 12
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182046", "story_v_out_410182.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182046", "story_v_out_410182.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_410182", "410182046", "story_v_out_410182.awb")

						arg_187_1:RecordAudio("410182046", var_190_24)
						arg_187_1:RecordAudio("410182046", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410182", "410182046", "story_v_out_410182.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410182", "410182046", "story_v_out_410182.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play410182047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410182047
		arg_191_1.duration_ = 9

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play410182048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = "ST64a"

			if arg_191_1.bgs_[var_194_0] == nil then
				local var_194_1 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_194_0)
				var_194_1.name = var_194_0
				var_194_1.transform.parent = arg_191_1.stage_.transform
				var_194_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_[var_194_0] = var_194_1
			end

			local var_194_2 = 2

			if var_194_2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				local var_194_3 = manager.ui.mainCamera.transform.localPosition
				local var_194_4 = Vector3.New(0, 0, 10) + Vector3.New(var_194_3.x, var_194_3.y, 0)
				local var_194_5 = arg_191_1.bgs_.ST64a

				var_194_5.transform.localPosition = var_194_4
				var_194_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_6 = var_194_5:GetComponent("SpriteRenderer")

				if var_194_6 and var_194_6.sprite then
					local var_194_7 = (var_194_5.transform.localPosition - var_194_3).z
					local var_194_8 = manager.ui.mainCameraCom_
					local var_194_9 = 2 * var_194_7 * Mathf.Tan(var_194_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_194_10 = var_194_9 * var_194_8.aspect
					local var_194_11 = var_194_6.sprite.bounds.size.x
					local var_194_12 = var_194_6.sprite.bounds.size.y
					local var_194_13 = var_194_10 / var_194_11
					local var_194_14 = var_194_9 / var_194_12
					local var_194_15 = var_194_14 < var_194_13 and var_194_13 or var_194_14

					var_194_5.transform.localScale = Vector3.New(var_194_15, var_194_15, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST64a" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_17 = 2

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17
				local var_194_19 = Color.New(0, 0, 0)

				var_194_19.a = Mathf.Lerp(0, 1, var_194_18)
				arg_191_1.mask_.color = var_194_19
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 then
				local var_194_20 = Color.New(0, 0, 0)

				var_194_20.a = 1
				arg_191_1.mask_.color = var_194_20
			end

			local var_194_21 = 2

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_22 = 2

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_22 then
				local var_194_23 = (arg_191_1.time_ - var_194_21) / var_194_22
				local var_194_24 = Color.New(0, 0, 0)

				var_194_24.a = Mathf.Lerp(1, 0, var_194_23)
				arg_191_1.mask_.color = var_194_24
			end

			if arg_191_1.time_ >= var_194_21 + var_194_22 and arg_191_1.time_ < var_194_21 + var_194_22 + arg_194_0 then
				local var_194_25 = Color.New(0, 0, 0)
				local var_194_26 = 0

				arg_191_1.mask_.enabled = false
				var_194_25.a = var_194_26
				arg_191_1.mask_.color = var_194_25
			end

			local var_194_27 = arg_191_1.actors_["10059"].transform
			local var_194_28 = 2

			if var_194_28 < arg_191_1.time_ and arg_191_1.time_ <= var_194_28 + arg_194_0 then
				arg_191_1.var_.moveOldPos10059 = var_194_27.localPosition
				var_194_27.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10059", 7)

				local var_194_29 = var_194_27.childCount

				for iter_194_2 = 0, var_194_29 - 1 do
					local var_194_30 = var_194_27:GetChild(iter_194_2)

					if var_194_30.name == "" or not string.find(var_194_30.name, "split") then
						var_194_30.gameObject:SetActive(true)
					else
						var_194_30.gameObject:SetActive(false)
					end
				end
			end

			local var_194_31 = 0.001

			if var_194_28 <= arg_191_1.time_ and arg_191_1.time_ < var_194_28 + var_194_31 then
				local var_194_32 = (arg_191_1.time_ - var_194_28) / var_194_31
				local var_194_33 = Vector3.New(0, -2000, 35)

				var_194_27.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10059, var_194_33, var_194_32)
			end

			if arg_191_1.time_ >= var_194_28 + var_194_31 and arg_191_1.time_ < var_194_28 + var_194_31 + arg_194_0 then
				var_194_27.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_194_34 = arg_191_1.actors_["1061"].transform
			local var_194_35 = 2

			if var_194_35 < arg_191_1.time_ and arg_191_1.time_ <= var_194_35 + arg_194_0 then
				arg_191_1.var_.moveOldPos1061 = var_194_34.localPosition
				var_194_34.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1061", 7)

				local var_194_36 = var_194_34.childCount

				for iter_194_3 = 0, var_194_36 - 1 do
					local var_194_37 = var_194_34:GetChild(iter_194_3)

					if var_194_37.name == "" or not string.find(var_194_37.name, "split") then
						var_194_37.gameObject:SetActive(true)
					else
						var_194_37.gameObject:SetActive(false)
					end
				end
			end

			local var_194_38 = 0.001

			if var_194_35 <= arg_191_1.time_ and arg_191_1.time_ < var_194_35 + var_194_38 then
				local var_194_39 = (arg_191_1.time_ - var_194_35) / var_194_38
				local var_194_40 = Vector3.New(0, -2000, 18)

				var_194_34.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1061, var_194_40, var_194_39)
			end

			if arg_191_1.time_ >= var_194_35 + var_194_38 and arg_191_1.time_ < var_194_35 + var_194_38 + arg_194_0 then
				var_194_34.localPosition = Vector3.New(0, -2000, 18)
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_41 = 4
			local var_194_42 = 0.975

			if var_194_41 < arg_191_1.time_ and arg_191_1.time_ <= var_194_41 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_43 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_43:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_44 = arg_191_1:GetWordFromCfg(410182047)
				local var_194_45 = arg_191_1:FormatText(var_194_44.content)

				arg_191_1.text_.text = var_194_45

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_46 = 39
				local var_194_47 = utf8.len(var_194_45)
				local var_194_48 = var_194_46 <= 0 and var_194_42 or var_194_42 * (var_194_47 / var_194_46)

				if var_194_48 > 0 and var_194_42 < var_194_48 then
					arg_191_1.talkMaxDuration = var_194_48
					var_194_41 = var_194_41 + 0.3

					if var_194_48 + var_194_41 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_48 + var_194_41
					end
				end

				arg_191_1.text_.text = var_194_45
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_49 = var_194_41 + 0.3
			local var_194_50 = math.max(var_194_42, arg_191_1.talkMaxDuration)

			if var_194_49 <= arg_191_1.time_ and arg_191_1.time_ < var_194_49 + var_194_50 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_49) / var_194_50

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_49 + var_194_50 and arg_191_1.time_ < var_194_49 + var_194_50 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play410182048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 410182048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play410182049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.15

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

				local var_200_2 = arg_197_1:GetWordFromCfg(410182048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 46
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
	Play410182049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 410182049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play410182050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.725

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(410182049)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 69
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play410182050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 410182050
		arg_205_1.duration_ = 4.13

		local var_205_0 = {
			ja = 4.133,
			CriLanguages = 2.466,
			zh = 2.466
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
				arg_205_0:Play410182051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1061"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1061 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1061", 3)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_7" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(0, -490, 18)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1061, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_208_7 = arg_205_1.actors_["1061"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1061 == nil then
				arg_205_1.var_.actorSpriteComps1061 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 0.034

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps1061 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps1061 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1061 = nil
			end

			local var_208_15 = 0
			local var_208_16 = 0.175

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[612].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(410182050)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 7
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182050", "story_v_out_410182.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182050", "story_v_out_410182.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_410182", "410182050", "story_v_out_410182.awb")

						arg_205_1:RecordAudio("410182050", var_208_24)
						arg_205_1:RecordAudio("410182050", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_410182", "410182050", "story_v_out_410182.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_410182", "410182050", "story_v_out_410182.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play410182051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 410182051
		arg_209_1.duration_ = 14.5

		local var_209_0 = {
			ja = 14.5,
			CriLanguages = 6.233,
			zh = 6.233
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
				arg_209_0:Play410182052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1061"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1061 == nil then
				arg_209_1.var_.actorSpriteComps1061 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.034

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1061 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 0.5, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1061 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1061 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.725

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_10 = arg_209_1:FormatText(StoryNameCfg[609].name)

				arg_209_1.leftNameTxt_.text = var_212_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_11 = arg_209_1:GetWordFromCfg(410182051)
				local var_212_12 = arg_209_1:FormatText(var_212_11.content)

				arg_209_1.text_.text = var_212_12

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182051", "story_v_out_410182.awb") ~= 0 then
					local var_212_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182051", "story_v_out_410182.awb") / 1000

					if var_212_16 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_16 + var_212_8
					end

					if var_212_11.prefab_name ~= "" and arg_209_1.actors_[var_212_11.prefab_name] ~= nil then
						local var_212_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_11.prefab_name].transform, "story_v_out_410182", "410182051", "story_v_out_410182.awb")

						arg_209_1:RecordAudio("410182051", var_212_17)
						arg_209_1:RecordAudio("410182051", var_212_17)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_410182", "410182051", "story_v_out_410182.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_410182", "410182051", "story_v_out_410182.awb")
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
	Play410182052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 410182052
		arg_213_1.duration_ = 10.8

		local var_213_0 = {
			ja = 10.8,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_213_0:Play410182053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1061"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1061 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1061", 3)

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
				local var_216_6 = Vector3.New(0, -490, 18)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1061, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_216_7 = arg_213_1.actors_["1061"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps1061 == nil then
				arg_213_1.var_.actorSpriteComps1061 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 0.034

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 and not isNil(var_216_7) then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps1061 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps1061 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1061 = nil
			end

			local var_216_15 = 0
			local var_216_16 = 0.575

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[612].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(410182052)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182052", "story_v_out_410182.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182052", "story_v_out_410182.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_410182", "410182052", "story_v_out_410182.awb")

						arg_213_1:RecordAudio("410182052", var_216_24)
						arg_213_1:RecordAudio("410182052", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_410182", "410182052", "story_v_out_410182.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_410182", "410182052", "story_v_out_410182.awb")
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
				actorName = "1061",
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
	Play410182053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 410182053
		arg_217_1.duration_ = 11.37

		local var_217_0 = {
			ja = 11.366,
			CriLanguages = 8.133,
			zh = 8.133
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
				arg_217_0:Play410182054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1061"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1061 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("1061", 3)

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
				local var_220_6 = Vector3.New(0, -490, 18)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1061, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_220_7 = arg_217_1.actors_["1061"]
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1061 == nil then
				arg_217_1.var_.actorSpriteComps1061 = var_220_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_9 = 0.034

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_9 and not isNil(var_220_7) then
				local var_220_10 = (arg_217_1.time_ - var_220_8) / var_220_9

				if arg_217_1.var_.actorSpriteComps1061 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_217_1.time_ >= var_220_8 + var_220_9 and arg_217_1.time_ < var_220_8 + var_220_9 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.actorSpriteComps1061 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_220_4 then
						if arg_217_1.isInRecall_ then
							iter_220_4.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1061 = nil
			end

			local var_220_15 = 0
			local var_220_16 = 0.925

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[612].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(410182053)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 37
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182053", "story_v_out_410182.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182053", "story_v_out_410182.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_410182", "410182053", "story_v_out_410182.awb")

						arg_217_1:RecordAudio("410182053", var_220_24)
						arg_217_1:RecordAudio("410182053", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_410182", "410182053", "story_v_out_410182.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_410182", "410182053", "story_v_out_410182.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play410182054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 410182054
		arg_221_1.duration_ = 12.53

		local var_221_0 = {
			ja = 12.533,
			CriLanguages = 4.3,
			zh = 4.3
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
				arg_221_0:Play410182055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1061"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1061 == nil then
				arg_221_1.var_.actorSpriteComps1061 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.034

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1061 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1061 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1061 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.45

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_10 = arg_221_1:FormatText(StoryNameCfg[609].name)

				arg_221_1.leftNameTxt_.text = var_224_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_11 = arg_221_1:GetWordFromCfg(410182054)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 18
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_9 or var_224_9 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_9 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182054", "story_v_out_410182.awb") ~= 0 then
					local var_224_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182054", "story_v_out_410182.awb") / 1000

					if var_224_16 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_16 + var_224_8
					end

					if var_224_11.prefab_name ~= "" and arg_221_1.actors_[var_224_11.prefab_name] ~= nil then
						local var_224_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_11.prefab_name].transform, "story_v_out_410182", "410182054", "story_v_out_410182.awb")

						arg_221_1:RecordAudio("410182054", var_224_17)
						arg_221_1:RecordAudio("410182054", var_224_17)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_410182", "410182054", "story_v_out_410182.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_410182", "410182054", "story_v_out_410182.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_18 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_18 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_18

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_18 and arg_221_1.time_ < var_224_8 + var_224_18 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play410182055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 410182055
		arg_225_1.duration_ = 8.9

		local var_225_0 = {
			ja = 8.9,
			CriLanguages = 4.233,
			zh = 4.233
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
				arg_225_0:Play410182056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.425

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[608].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(410182055)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182055", "story_v_out_410182.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182055", "story_v_out_410182.awb") / 1000

					if var_228_8 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_0
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_410182", "410182055", "story_v_out_410182.awb")

						arg_225_1:RecordAudio("410182055", var_228_9)
						arg_225_1:RecordAudio("410182055", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_410182", "410182055", "story_v_out_410182.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_410182", "410182055", "story_v_out_410182.awb")
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
	Play410182056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 410182056
		arg_229_1.duration_ = 12.2

		local var_229_0 = {
			ja = 12.2,
			CriLanguages = 7.333,
			zh = 7.333
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
				arg_229_0:Play410182057(arg_229_1)
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

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[609].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(410182056)
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182056", "story_v_out_410182.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182056", "story_v_out_410182.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_410182", "410182056", "story_v_out_410182.awb")

						arg_229_1:RecordAudio("410182056", var_232_9)
						arg_229_1:RecordAudio("410182056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_410182", "410182056", "story_v_out_410182.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_410182", "410182056", "story_v_out_410182.awb")
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
	Play410182057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 410182057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play410182058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.825

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(410182057)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 33
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play410182058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 410182058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play410182059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1061"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1061 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1061", 7)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "split_7" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(0, -2000, 18)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1061, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_240_7 = manager.ui.mainCamera.transform
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_7.localPosition
			end

			local var_240_9 = 0.5

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_9 then
				local var_240_10 = (arg_237_1.time_ - var_240_8) / 0.066
				local var_240_11, var_240_12 = math.modf(var_240_10)

				var_240_7.localPosition = Vector3.New(var_240_12 * 0.13, var_240_12 * 0.13, var_240_12 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= var_240_8 + var_240_9 and arg_237_1.time_ < var_240_8 + var_240_9 + arg_240_0 then
				var_240_7.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1.allBtn_.enabled = false
			end

			local var_240_14 = 0.5

			if arg_237_1.time_ >= var_240_13 + var_240_14 and arg_237_1.time_ < var_240_13 + var_240_14 + arg_240_0 then
				arg_237_1.allBtn_.enabled = true
			end

			local var_240_15 = 0
			local var_240_16 = 1.075

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_17 = arg_237_1:GetWordFromCfg(410182058)
				local var_240_18 = arg_237_1:FormatText(var_240_17.content)

				arg_237_1.text_.text = var_240_18

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_19 = 43
				local var_240_20 = utf8.len(var_240_18)
				local var_240_21 = var_240_19 <= 0 and var_240_16 or var_240_16 * (var_240_20 / var_240_19)

				if var_240_21 > 0 and var_240_16 < var_240_21 then
					arg_237_1.talkMaxDuration = var_240_21

					if var_240_21 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_18
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_22 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_22 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_22

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_22 and arg_237_1.time_ < var_240_15 + var_240_22 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play410182059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 410182059
		arg_241_1.duration_ = 3.47

		local var_241_0 = {
			ja = 3.466,
			CriLanguages = 2.6,
			zh = 2.6
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
				arg_241_0:Play410182060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.2

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[608].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_a")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(410182059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182059", "story_v_out_410182.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182059", "story_v_out_410182.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_410182", "410182059", "story_v_out_410182.awb")

						arg_241_1:RecordAudio("410182059", var_244_9)
						arg_241_1:RecordAudio("410182059", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_410182", "410182059", "story_v_out_410182.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_410182", "410182059", "story_v_out_410182.awb")
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
	Play410182060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 410182060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play410182061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.05

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(410182060)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 42
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play410182061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 410182061
		arg_249_1.duration_ = 11.53

		local var_249_0 = {
			ja = 11.533,
			CriLanguages = 5.666,
			zh = 5.666
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
				arg_249_0:Play410182062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1061"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1061 = var_252_0.localPosition
				var_252_0.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1061", 3)

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
				local var_252_6 = Vector3.New(0, -490, 18)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1061, var_252_6, var_252_5)
			end

			if arg_249_1.time_ >= var_252_1 + var_252_4 and arg_249_1.time_ < var_252_1 + var_252_4 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_252_7 = arg_249_1.actors_["1061"]
			local var_252_8 = 0

			if var_252_8 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1061 == nil then
				arg_249_1.var_.actorSpriteComps1061 = var_252_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 0.034

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 and not isNil(var_252_7) then
				local var_252_10 = (arg_249_1.time_ - var_252_8) / var_252_9

				if arg_249_1.var_.actorSpriteComps1061 then
					for iter_252_1, iter_252_2 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_252_2 then
							if arg_249_1.isInRecall_ then
								local var_252_11 = Mathf.Lerp(iter_252_2.color.r, arg_249_1.hightColor1.r, var_252_10)
								local var_252_12 = Mathf.Lerp(iter_252_2.color.g, arg_249_1.hightColor1.g, var_252_10)
								local var_252_13 = Mathf.Lerp(iter_252_2.color.b, arg_249_1.hightColor1.b, var_252_10)

								iter_252_2.color = Color.New(var_252_11, var_252_12, var_252_13)
							else
								local var_252_14 = Mathf.Lerp(iter_252_2.color.r, 1, var_252_10)

								iter_252_2.color = Color.New(var_252_14, var_252_14, var_252_14)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 and not isNil(var_252_7) and arg_249_1.var_.actorSpriteComps1061 then
				for iter_252_3, iter_252_4 in pairs(arg_249_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_252_4 then
						if arg_249_1.isInRecall_ then
							iter_252_4.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1061 = nil
			end

			local var_252_15 = 0
			local var_252_16 = 0.575

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[612].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(410182061)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 23
				local var_252_21 = utf8.len(var_252_19)
				local var_252_22 = var_252_20 <= 0 and var_252_16 or var_252_16 * (var_252_21 / var_252_20)

				if var_252_22 > 0 and var_252_16 < var_252_22 then
					arg_249_1.talkMaxDuration = var_252_22

					if var_252_22 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_22 + var_252_15
					end
				end

				arg_249_1.text_.text = var_252_19
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182061", "story_v_out_410182.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182061", "story_v_out_410182.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_410182", "410182061", "story_v_out_410182.awb")

						arg_249_1:RecordAudio("410182061", var_252_24)
						arg_249_1:RecordAudio("410182061", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_410182", "410182061", "story_v_out_410182.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_410182", "410182061", "story_v_out_410182.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_25 = math.max(var_252_16, arg_249_1.talkMaxDuration)

			if var_252_15 <= arg_249_1.time_ and arg_249_1.time_ < var_252_15 + var_252_25 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_15) / var_252_25

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_15 + var_252_25 and arg_249_1.time_ < var_252_15 + var_252_25 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play410182062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 410182062
		arg_253_1.duration_ = 14.8

		local var_253_0 = {
			ja = 14.8,
			CriLanguages = 11.1,
			zh = 11.1
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
				arg_253_0:Play410182063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1061"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1061 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1061", 3)

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
				local var_256_6 = Vector3.New(0, -490, 18)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1061, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_256_7 = arg_253_1.actors_["1061"]
			local var_256_8 = 0

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1061 == nil then
				arg_253_1.var_.actorSpriteComps1061 = var_256_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_9 = 0.034

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_9 and not isNil(var_256_7) then
				local var_256_10 = (arg_253_1.time_ - var_256_8) / var_256_9

				if arg_253_1.var_.actorSpriteComps1061 then
					for iter_256_1, iter_256_2 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_253_1.time_ >= var_256_8 + var_256_9 and arg_253_1.time_ < var_256_8 + var_256_9 + arg_256_0 and not isNil(var_256_7) and arg_253_1.var_.actorSpriteComps1061 then
				for iter_256_3, iter_256_4 in pairs(arg_253_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_256_4 then
						if arg_253_1.isInRecall_ then
							iter_256_4.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1061 = nil
			end

			local var_256_15 = 0
			local var_256_16 = 1.225

			if var_256_15 < arg_253_1.time_ and arg_253_1.time_ <= var_256_15 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_17 = arg_253_1:FormatText(StoryNameCfg[612].name)

				arg_253_1.leftNameTxt_.text = var_256_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_18 = arg_253_1:GetWordFromCfg(410182062)
				local var_256_19 = arg_253_1:FormatText(var_256_18.content)

				arg_253_1.text_.text = var_256_19

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_20 = 49
				local var_256_21 = utf8.len(var_256_19)
				local var_256_22 = var_256_20 <= 0 and var_256_16 or var_256_16 * (var_256_21 / var_256_20)

				if var_256_22 > 0 and var_256_16 < var_256_22 then
					arg_253_1.talkMaxDuration = var_256_22

					if var_256_22 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_22 + var_256_15
					end
				end

				arg_253_1.text_.text = var_256_19
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182062", "story_v_out_410182.awb") ~= 0 then
					local var_256_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182062", "story_v_out_410182.awb") / 1000

					if var_256_23 + var_256_15 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_23 + var_256_15
					end

					if var_256_18.prefab_name ~= "" and arg_253_1.actors_[var_256_18.prefab_name] ~= nil then
						local var_256_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_18.prefab_name].transform, "story_v_out_410182", "410182062", "story_v_out_410182.awb")

						arg_253_1:RecordAudio("410182062", var_256_24)
						arg_253_1:RecordAudio("410182062", var_256_24)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_410182", "410182062", "story_v_out_410182.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_410182", "410182062", "story_v_out_410182.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_25 = math.max(var_256_16, arg_253_1.talkMaxDuration)

			if var_256_15 <= arg_253_1.time_ and arg_253_1.time_ < var_256_15 + var_256_25 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_15) / var_256_25

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_15 + var_256_25 and arg_253_1.time_ < var_256_15 + var_256_25 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play410182063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 410182063
		arg_257_1.duration_ = 16.4

		local var_257_0 = {
			ja = 16.4,
			CriLanguages = 10.666,
			zh = 10.666
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
				arg_257_0:Play410182064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1061"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1061 = var_260_0.localPosition
				var_260_0.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1061", 3)

				local var_260_2 = var_260_0.childCount

				for iter_260_0 = 0, var_260_2 - 1 do
					local var_260_3 = var_260_0:GetChild(iter_260_0)

					if var_260_3.name == "" or not string.find(var_260_3.name, "split") then
						var_260_3.gameObject:SetActive(true)
					else
						var_260_3.gameObject:SetActive(false)
					end
				end
			end

			local var_260_4 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_4 then
				local var_260_5 = (arg_257_1.time_ - var_260_1) / var_260_4
				local var_260_6 = Vector3.New(0, -490, 18)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1061, var_260_6, var_260_5)
			end

			if arg_257_1.time_ >= var_260_1 + var_260_4 and arg_257_1.time_ < var_260_1 + var_260_4 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_260_7 = arg_257_1.actors_["1061"]
			local var_260_8 = 0

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1061 == nil then
				arg_257_1.var_.actorSpriteComps1061 = var_260_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_9 = 0.034

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_9 and not isNil(var_260_7) then
				local var_260_10 = (arg_257_1.time_ - var_260_8) / var_260_9

				if arg_257_1.var_.actorSpriteComps1061 then
					for iter_260_1, iter_260_2 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_260_2 then
							if arg_257_1.isInRecall_ then
								local var_260_11 = Mathf.Lerp(iter_260_2.color.r, arg_257_1.hightColor1.r, var_260_10)
								local var_260_12 = Mathf.Lerp(iter_260_2.color.g, arg_257_1.hightColor1.g, var_260_10)
								local var_260_13 = Mathf.Lerp(iter_260_2.color.b, arg_257_1.hightColor1.b, var_260_10)

								iter_260_2.color = Color.New(var_260_11, var_260_12, var_260_13)
							else
								local var_260_14 = Mathf.Lerp(iter_260_2.color.r, 1, var_260_10)

								iter_260_2.color = Color.New(var_260_14, var_260_14, var_260_14)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_8 + var_260_9 and arg_257_1.time_ < var_260_8 + var_260_9 + arg_260_0 and not isNil(var_260_7) and arg_257_1.var_.actorSpriteComps1061 then
				for iter_260_3, iter_260_4 in pairs(arg_257_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_260_4 then
						if arg_257_1.isInRecall_ then
							iter_260_4.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1061 = nil
			end

			local var_260_15 = 0
			local var_260_16 = 1.2

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[612].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(410182063)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 49
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182063", "story_v_out_410182.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182063", "story_v_out_410182.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_410182", "410182063", "story_v_out_410182.awb")

						arg_257_1:RecordAudio("410182063", var_260_24)
						arg_257_1:RecordAudio("410182063", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_410182", "410182063", "story_v_out_410182.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_410182", "410182063", "story_v_out_410182.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play410182064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 410182064
		arg_261_1.duration_ = 7.47

		local var_261_0 = {
			ja = 6.066,
			CriLanguages = 7.466,
			zh = 7.466
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
				arg_261_0:Play410182065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1061"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1061 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1061", 3)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(0, -490, 18)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1061, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_264_7 = arg_261_1.actors_["1061"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1061 == nil then
				arg_261_1.var_.actorSpriteComps1061 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 0.034

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps1061 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 1, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps1061 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1061 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 0.925

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[612].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(410182064)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 37
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182064", "story_v_out_410182.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182064", "story_v_out_410182.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_410182", "410182064", "story_v_out_410182.awb")

						arg_261_1:RecordAudio("410182064", var_264_24)
						arg_261_1:RecordAudio("410182064", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_410182", "410182064", "story_v_out_410182.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_410182", "410182064", "story_v_out_410182.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play410182065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 410182065
		arg_265_1.duration_ = 5.93

		local var_265_0 = {
			ja = 5.933,
			CriLanguages = 5.733,
			zh = 5.733
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
				arg_265_0:Play410182066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1061"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1061 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1061", 3)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(0, -490, 18)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1061, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_268_7 = arg_265_1.actors_["1061"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1061 == nil then
				arg_265_1.var_.actorSpriteComps1061 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 0.034

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps1061 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
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

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps1061 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1061 = nil
			end

			local var_268_15 = 0
			local var_268_16 = 0.5

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[612].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(410182065)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 20
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182065", "story_v_out_410182.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182065", "story_v_out_410182.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_410182", "410182065", "story_v_out_410182.awb")

						arg_265_1:RecordAudio("410182065", var_268_24)
						arg_265_1:RecordAudio("410182065", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_410182", "410182065", "story_v_out_410182.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_410182", "410182065", "story_v_out_410182.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play410182066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 410182066
		arg_269_1.duration_ = 8.93

		local var_269_0 = {
			ja = 8.933,
			CriLanguages = 2.5,
			zh = 2.5
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
				arg_269_0:Play410182067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1061"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1061 == nil then
				arg_269_1.var_.actorSpriteComps1061 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.034

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps1061 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 0.5, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps1061 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps1061 = nil
			end

			local var_272_8 = 0
			local var_272_9 = 0.35

			if var_272_8 < arg_269_1.time_ and arg_269_1.time_ <= var_272_8 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_10 = arg_269_1:FormatText(StoryNameCfg[609].name)

				arg_269_1.leftNameTxt_.text = var_272_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_11 = arg_269_1:GetWordFromCfg(410182066)
				local var_272_12 = arg_269_1:FormatText(var_272_11.content)

				arg_269_1.text_.text = var_272_12

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_13 = 14
				local var_272_14 = utf8.len(var_272_12)
				local var_272_15 = var_272_13 <= 0 and var_272_9 or var_272_9 * (var_272_14 / var_272_13)

				if var_272_15 > 0 and var_272_9 < var_272_15 then
					arg_269_1.talkMaxDuration = var_272_15

					if var_272_15 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_8
					end
				end

				arg_269_1.text_.text = var_272_12
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182066", "story_v_out_410182.awb") ~= 0 then
					local var_272_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182066", "story_v_out_410182.awb") / 1000

					if var_272_16 + var_272_8 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_16 + var_272_8
					end

					if var_272_11.prefab_name ~= "" and arg_269_1.actors_[var_272_11.prefab_name] ~= nil then
						local var_272_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_11.prefab_name].transform, "story_v_out_410182", "410182066", "story_v_out_410182.awb")

						arg_269_1:RecordAudio("410182066", var_272_17)
						arg_269_1:RecordAudio("410182066", var_272_17)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_410182", "410182066", "story_v_out_410182.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_410182", "410182066", "story_v_out_410182.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_18 = math.max(var_272_9, arg_269_1.talkMaxDuration)

			if var_272_8 <= arg_269_1.time_ and arg_269_1.time_ < var_272_8 + var_272_18 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_8) / var_272_18

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_8 + var_272_18 and arg_269_1.time_ < var_272_8 + var_272_18 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play410182067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 410182067
		arg_273_1.duration_ = 5.47

		local var_273_0 = {
			ja = 5.466,
			CriLanguages = 2.766,
			zh = 2.766
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
				arg_273_0:Play410182068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1061"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1061", 3)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(0, -490, 18)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_276_7 = arg_273_1.actors_["1061"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 == nil then
				arg_273_1.var_.actorSpriteComps1061 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 0.034

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps1061 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 1, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps1061 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1061 = nil
			end

			local var_276_15 = 0
			local var_276_16 = 0.225

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_17 = arg_273_1:FormatText(StoryNameCfg[612].name)

				arg_273_1.leftNameTxt_.text = var_276_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_18 = arg_273_1:GetWordFromCfg(410182067)
				local var_276_19 = arg_273_1:FormatText(var_276_18.content)

				arg_273_1.text_.text = var_276_19

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_20 = 9
				local var_276_21 = utf8.len(var_276_19)
				local var_276_22 = var_276_20 <= 0 and var_276_16 or var_276_16 * (var_276_21 / var_276_20)

				if var_276_22 > 0 and var_276_16 < var_276_22 then
					arg_273_1.talkMaxDuration = var_276_22

					if var_276_22 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_22 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_19
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182067", "story_v_out_410182.awb") ~= 0 then
					local var_276_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182067", "story_v_out_410182.awb") / 1000

					if var_276_23 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_23 + var_276_15
					end

					if var_276_18.prefab_name ~= "" and arg_273_1.actors_[var_276_18.prefab_name] ~= nil then
						local var_276_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_18.prefab_name].transform, "story_v_out_410182", "410182067", "story_v_out_410182.awb")

						arg_273_1:RecordAudio("410182067", var_276_24)
						arg_273_1:RecordAudio("410182067", var_276_24)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_410182", "410182067", "story_v_out_410182.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_410182", "410182067", "story_v_out_410182.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_25 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_25 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_25

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_25 and arg_273_1.time_ < var_276_15 + var_276_25 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play410182068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 410182068
		arg_277_1.duration_ = 13.53

		local var_277_0 = {
			ja = 13.533,
			CriLanguages = 10.533,
			zh = 10.533
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
				arg_277_0:Play410182069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1061"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1061 = var_280_0.localPosition
				var_280_0.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1061", 3)

				local var_280_2 = var_280_0.childCount

				for iter_280_0 = 0, var_280_2 - 1 do
					local var_280_3 = var_280_0:GetChild(iter_280_0)

					if var_280_3.name == "" or not string.find(var_280_3.name, "split") then
						var_280_3.gameObject:SetActive(true)
					else
						var_280_3.gameObject:SetActive(false)
					end
				end
			end

			local var_280_4 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_4 then
				local var_280_5 = (arg_277_1.time_ - var_280_1) / var_280_4
				local var_280_6 = Vector3.New(0, -490, 18)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1061, var_280_6, var_280_5)
			end

			if arg_277_1.time_ >= var_280_1 + var_280_4 and arg_277_1.time_ < var_280_1 + var_280_4 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_280_7 = arg_277_1.actors_["1061"]
			local var_280_8 = 0

			if var_280_8 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 == nil then
				arg_277_1.var_.actorSpriteComps1061 = var_280_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_9 = 0.034

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_9 and not isNil(var_280_7) then
				local var_280_10 = (arg_277_1.time_ - var_280_8) / var_280_9

				if arg_277_1.var_.actorSpriteComps1061 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								local var_280_11 = Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, var_280_10)
								local var_280_12 = Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, var_280_10)
								local var_280_13 = Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, var_280_10)

								iter_280_2.color = Color.New(var_280_11, var_280_12, var_280_13)
							else
								local var_280_14 = Mathf.Lerp(iter_280_2.color.r, 1, var_280_10)

								iter_280_2.color = Color.New(var_280_14, var_280_14, var_280_14)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_8 + var_280_9 and arg_277_1.time_ < var_280_8 + var_280_9 + arg_280_0 and not isNil(var_280_7) and arg_277_1.var_.actorSpriteComps1061 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_280_4 then
						if arg_277_1.isInRecall_ then
							iter_280_4.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1061 = nil
			end

			local var_280_15 = 0
			local var_280_16 = 1.225

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_17 = arg_277_1:FormatText(StoryNameCfg[612].name)

				arg_277_1.leftNameTxt_.text = var_280_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_18 = arg_277_1:GetWordFromCfg(410182068)
				local var_280_19 = arg_277_1:FormatText(var_280_18.content)

				arg_277_1.text_.text = var_280_19

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_20 = 49
				local var_280_21 = utf8.len(var_280_19)
				local var_280_22 = var_280_20 <= 0 and var_280_16 or var_280_16 * (var_280_21 / var_280_20)

				if var_280_22 > 0 and var_280_16 < var_280_22 then
					arg_277_1.talkMaxDuration = var_280_22

					if var_280_22 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_22 + var_280_15
					end
				end

				arg_277_1.text_.text = var_280_19
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182068", "story_v_out_410182.awb") ~= 0 then
					local var_280_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182068", "story_v_out_410182.awb") / 1000

					if var_280_23 + var_280_15 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_15
					end

					if var_280_18.prefab_name ~= "" and arg_277_1.actors_[var_280_18.prefab_name] ~= nil then
						local var_280_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_18.prefab_name].transform, "story_v_out_410182", "410182068", "story_v_out_410182.awb")

						arg_277_1:RecordAudio("410182068", var_280_24)
						arg_277_1:RecordAudio("410182068", var_280_24)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_410182", "410182068", "story_v_out_410182.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_410182", "410182068", "story_v_out_410182.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_25 = math.max(var_280_16, arg_277_1.talkMaxDuration)

			if var_280_15 <= arg_277_1.time_ and arg_277_1.time_ < var_280_15 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_15) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_15 + var_280_25 and arg_277_1.time_ < var_280_15 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play410182069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 410182069
		arg_281_1.duration_ = 3.8

		local var_281_0 = {
			ja = 3.8,
			CriLanguages = 3.6,
			zh = 3.6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play410182070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1061"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1061 == nil then
				arg_281_1.var_.actorSpriteComps1061 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.034

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps1061 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor2.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor2.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor2.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 0.5, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1061 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1061 = nil
			end

			local var_284_8 = 0
			local var_284_9 = 0.075

			if var_284_8 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_10 = arg_281_1:FormatText(StoryNameCfg[609].name)

				arg_281_1.leftNameTxt_.text = var_284_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_11 = arg_281_1:GetWordFromCfg(410182069)
				local var_284_12 = arg_281_1:FormatText(var_284_11.content)

				arg_281_1.text_.text = var_284_12

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 3
				local var_284_14 = utf8.len(var_284_12)
				local var_284_15 = var_284_13 <= 0 and var_284_9 or var_284_9 * (var_284_14 / var_284_13)

				if var_284_15 > 0 and var_284_9 < var_284_15 then
					arg_281_1.talkMaxDuration = var_284_15

					if var_284_15 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_15 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_12
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182069", "story_v_out_410182.awb") ~= 0 then
					local var_284_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182069", "story_v_out_410182.awb") / 1000

					if var_284_16 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_16 + var_284_8
					end

					if var_284_11.prefab_name ~= "" and arg_281_1.actors_[var_284_11.prefab_name] ~= nil then
						local var_284_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_11.prefab_name].transform, "story_v_out_410182", "410182069", "story_v_out_410182.awb")

						arg_281_1:RecordAudio("410182069", var_284_17)
						arg_281_1:RecordAudio("410182069", var_284_17)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_410182", "410182069", "story_v_out_410182.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_410182", "410182069", "story_v_out_410182.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_18 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_18 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_18

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_18 and arg_281_1.time_ < var_284_8 + var_284_18 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play410182070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 410182070
		arg_285_1.duration_ = 11.3

		local var_285_0 = {
			ja = 11.3,
			CriLanguages = 8.2,
			zh = 8.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play410182071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1061"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1061 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1061", 3)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(0, -490, 18)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1061, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_288_7 = arg_285_1.actors_["1061"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1061 == nil then
				arg_285_1.var_.actorSpriteComps1061 = var_288_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_9 = 0.034

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_9 and not isNil(var_288_7) then
				local var_288_10 = (arg_285_1.time_ - var_288_8) / var_288_9

				if arg_285_1.var_.actorSpriteComps1061 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								local var_288_11 = Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, var_288_10)
								local var_288_12 = Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, var_288_10)
								local var_288_13 = Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, var_288_10)

								iter_288_2.color = Color.New(var_288_11, var_288_12, var_288_13)
							else
								local var_288_14 = Mathf.Lerp(iter_288_2.color.r, 1, var_288_10)

								iter_288_2.color = Color.New(var_288_14, var_288_14, var_288_14)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_9 and arg_285_1.time_ < var_288_8 + var_288_9 + arg_288_0 and not isNil(var_288_7) and arg_285_1.var_.actorSpriteComps1061 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_288_4 then
						if arg_285_1.isInRecall_ then
							iter_288_4.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps1061 = nil
			end

			local var_288_15 = 0
			local var_288_16 = 1.025

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[612].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(410182070)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 41
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182070", "story_v_out_410182.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182070", "story_v_out_410182.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_410182", "410182070", "story_v_out_410182.awb")

						arg_285_1:RecordAudio("410182070", var_288_24)
						arg_285_1:RecordAudio("410182070", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_410182", "410182070", "story_v_out_410182.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_410182", "410182070", "story_v_out_410182.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play410182071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 410182071
		arg_289_1.duration_ = 11.4

		local var_289_0 = {
			ja = 10.5,
			CriLanguages = 11.4,
			zh = 11.4
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play410182072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1061"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1061 = var_292_0.localPosition
				var_292_0.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1061", 3)

				local var_292_2 = var_292_0.childCount

				for iter_292_0 = 0, var_292_2 - 1 do
					local var_292_3 = var_292_0:GetChild(iter_292_0)

					if var_292_3.name == "" or not string.find(var_292_3.name, "split") then
						var_292_3.gameObject:SetActive(true)
					else
						var_292_3.gameObject:SetActive(false)
					end
				end
			end

			local var_292_4 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_4 then
				local var_292_5 = (arg_289_1.time_ - var_292_1) / var_292_4
				local var_292_6 = Vector3.New(0, -490, 18)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1061, var_292_6, var_292_5)
			end

			if arg_289_1.time_ >= var_292_1 + var_292_4 and arg_289_1.time_ < var_292_1 + var_292_4 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_292_7 = arg_289_1.actors_["1061"]
			local var_292_8 = 0

			if var_292_8 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1061 == nil then
				arg_289_1.var_.actorSpriteComps1061 = var_292_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_9 = 0.034

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 and not isNil(var_292_7) then
				local var_292_10 = (arg_289_1.time_ - var_292_8) / var_292_9

				if arg_289_1.var_.actorSpriteComps1061 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								local var_292_11 = Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor1.r, var_292_10)
								local var_292_12 = Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor1.g, var_292_10)
								local var_292_13 = Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor1.b, var_292_10)

								iter_292_2.color = Color.New(var_292_11, var_292_12, var_292_13)
							else
								local var_292_14 = Mathf.Lerp(iter_292_2.color.r, 1, var_292_10)

								iter_292_2.color = Color.New(var_292_14, var_292_14, var_292_14)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 and not isNil(var_292_7) and arg_289_1.var_.actorSpriteComps1061 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_292_4 then
						if arg_289_1.isInRecall_ then
							iter_292_4.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1061 = nil
			end

			local var_292_15 = 0
			local var_292_16 = 1.35

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[612].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(410182071)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 54
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182071", "story_v_out_410182.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182071", "story_v_out_410182.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_410182", "410182071", "story_v_out_410182.awb")

						arg_289_1:RecordAudio("410182071", var_292_24)
						arg_289_1:RecordAudio("410182071", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_410182", "410182071", "story_v_out_410182.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_410182", "410182071", "story_v_out_410182.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play410182072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 410182072
		arg_293_1.duration_ = 9.57

		local var_293_0 = {
			ja = 9.566,
			CriLanguages = 9.5,
			zh = 9.5
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play410182073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1061"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1061 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1061", 3)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(0, -490, 18)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1061, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_296_7 = arg_293_1.actors_["1061"]
			local var_296_8 = 0

			if var_296_8 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1061 == nil then
				arg_293_1.var_.actorSpriteComps1061 = var_296_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_9 = 0.034

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_9 and not isNil(var_296_7) then
				local var_296_10 = (arg_293_1.time_ - var_296_8) / var_296_9

				if arg_293_1.var_.actorSpriteComps1061 then
					for iter_296_1, iter_296_2 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_296_2 then
							if arg_293_1.isInRecall_ then
								local var_296_11 = Mathf.Lerp(iter_296_2.color.r, arg_293_1.hightColor1.r, var_296_10)
								local var_296_12 = Mathf.Lerp(iter_296_2.color.g, arg_293_1.hightColor1.g, var_296_10)
								local var_296_13 = Mathf.Lerp(iter_296_2.color.b, arg_293_1.hightColor1.b, var_296_10)

								iter_296_2.color = Color.New(var_296_11, var_296_12, var_296_13)
							else
								local var_296_14 = Mathf.Lerp(iter_296_2.color.r, 1, var_296_10)

								iter_296_2.color = Color.New(var_296_14, var_296_14, var_296_14)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_8 + var_296_9 and arg_293_1.time_ < var_296_8 + var_296_9 + arg_296_0 and not isNil(var_296_7) and arg_293_1.var_.actorSpriteComps1061 then
				for iter_296_3, iter_296_4 in pairs(arg_293_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_296_4 then
						if arg_293_1.isInRecall_ then
							iter_296_4.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1061 = nil
			end

			local var_296_15 = 0
			local var_296_16 = 1.125

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[612].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(410182072)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 45
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182072", "story_v_out_410182.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182072", "story_v_out_410182.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_410182", "410182072", "story_v_out_410182.awb")

						arg_293_1:RecordAudio("410182072", var_296_24)
						arg_293_1:RecordAudio("410182072", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_410182", "410182072", "story_v_out_410182.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_410182", "410182072", "story_v_out_410182.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play410182073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 410182073
		arg_297_1.duration_ = 10.47

		local var_297_0 = {
			ja = 10.466,
			CriLanguages = 8.6,
			zh = 8.6
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play410182074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1061"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1061 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1061", 3)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "split_5" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(0, -490, 18)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1061, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_300_7 = arg_297_1.actors_["1061"]
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1061 == nil then
				arg_297_1.var_.actorSpriteComps1061 = var_300_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_9 = 0.034

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 and not isNil(var_300_7) then
				local var_300_10 = (arg_297_1.time_ - var_300_8) / var_300_9

				if arg_297_1.var_.actorSpriteComps1061 then
					for iter_300_1, iter_300_2 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_300_2 then
							if arg_297_1.isInRecall_ then
								local var_300_11 = Mathf.Lerp(iter_300_2.color.r, arg_297_1.hightColor1.r, var_300_10)
								local var_300_12 = Mathf.Lerp(iter_300_2.color.g, arg_297_1.hightColor1.g, var_300_10)
								local var_300_13 = Mathf.Lerp(iter_300_2.color.b, arg_297_1.hightColor1.b, var_300_10)

								iter_300_2.color = Color.New(var_300_11, var_300_12, var_300_13)
							else
								local var_300_14 = Mathf.Lerp(iter_300_2.color.r, 1, var_300_10)

								iter_300_2.color = Color.New(var_300_14, var_300_14, var_300_14)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 and not isNil(var_300_7) and arg_297_1.var_.actorSpriteComps1061 then
				for iter_300_3, iter_300_4 in pairs(arg_297_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_300_4 then
						if arg_297_1.isInRecall_ then
							iter_300_4.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1061 = nil
			end

			local var_300_15 = 0
			local var_300_16 = 0.975

			if var_300_15 < arg_297_1.time_ and arg_297_1.time_ <= var_300_15 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_17 = arg_297_1:FormatText(StoryNameCfg[612].name)

				arg_297_1.leftNameTxt_.text = var_300_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_18 = arg_297_1:GetWordFromCfg(410182073)
				local var_300_19 = arg_297_1:FormatText(var_300_18.content)

				arg_297_1.text_.text = var_300_19

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_20 = 39
				local var_300_21 = utf8.len(var_300_19)
				local var_300_22 = var_300_20 <= 0 and var_300_16 or var_300_16 * (var_300_21 / var_300_20)

				if var_300_22 > 0 and var_300_16 < var_300_22 then
					arg_297_1.talkMaxDuration = var_300_22

					if var_300_22 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_22 + var_300_15
					end
				end

				arg_297_1.text_.text = var_300_19
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182073", "story_v_out_410182.awb") ~= 0 then
					local var_300_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182073", "story_v_out_410182.awb") / 1000

					if var_300_23 + var_300_15 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_23 + var_300_15
					end

					if var_300_18.prefab_name ~= "" and arg_297_1.actors_[var_300_18.prefab_name] ~= nil then
						local var_300_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_18.prefab_name].transform, "story_v_out_410182", "410182073", "story_v_out_410182.awb")

						arg_297_1:RecordAudio("410182073", var_300_24)
						arg_297_1:RecordAudio("410182073", var_300_24)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_410182", "410182073", "story_v_out_410182.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_410182", "410182073", "story_v_out_410182.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_16, arg_297_1.talkMaxDuration)

			if var_300_15 <= arg_297_1.time_ and arg_297_1.time_ < var_300_15 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_15) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_15 + var_300_25 and arg_297_1.time_ < var_300_15 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play410182074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 410182074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play410182075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1061"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1061 == nil then
				arg_301_1.var_.actorSpriteComps1061 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.034

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1061 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 0.5, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1061 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_304_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1061 = nil
			end

			local var_304_8 = 0
			local var_304_9 = 1.475

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(410182074)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_12 = 59
				local var_304_13 = utf8.len(var_304_11)
				local var_304_14 = var_304_12 <= 0 and var_304_9 or var_304_9 * (var_304_13 / var_304_12)

				if var_304_14 > 0 and var_304_9 < var_304_14 then
					arg_301_1.talkMaxDuration = var_304_14

					if var_304_14 + var_304_8 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_8
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_15 = math.max(var_304_9, arg_301_1.talkMaxDuration)

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_15 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_8) / var_304_15

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_8 + var_304_15 and arg_301_1.time_ < var_304_8 + var_304_15 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play410182075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 410182075
		arg_305_1.duration_ = 14

		local var_305_0 = {
			ja = 14,
			CriLanguages = 8.2,
			zh = 8.2
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play410182076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 1.1

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[609].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(410182075)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 44
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182075", "story_v_out_410182.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182075", "story_v_out_410182.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_410182", "410182075", "story_v_out_410182.awb")

						arg_305_1:RecordAudio("410182075", var_308_9)
						arg_305_1:RecordAudio("410182075", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_410182", "410182075", "story_v_out_410182.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_410182", "410182075", "story_v_out_410182.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play410182076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 410182076
		arg_309_1.duration_ = 4.73

		local var_309_0 = {
			ja = 4.733,
			CriLanguages = 3.133,
			zh = 3.133
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play410182077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.475

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[609].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(410182076)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 19
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182076", "story_v_out_410182.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_410182", "410182076", "story_v_out_410182.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_410182", "410182076", "story_v_out_410182.awb")

						arg_309_1:RecordAudio("410182076", var_312_9)
						arg_309_1:RecordAudio("410182076", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_410182", "410182076", "story_v_out_410182.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_410182", "410182076", "story_v_out_410182.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play410182077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 410182077
		arg_313_1.duration_ = 5.33

		local var_313_0 = {
			ja = 5.333,
			CriLanguages = 2.766,
			zh = 2.766
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play410182078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1061"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1061 = var_316_0.localPosition
				var_316_0.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1061", 3)

				local var_316_2 = var_316_0.childCount

				for iter_316_0 = 0, var_316_2 - 1 do
					local var_316_3 = var_316_0:GetChild(iter_316_0)

					if var_316_3.name == "split_5" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_4 then
				local var_316_5 = (arg_313_1.time_ - var_316_1) / var_316_4
				local var_316_6 = Vector3.New(0, -490, 18)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1061, var_316_6, var_316_5)
			end

			if arg_313_1.time_ >= var_316_1 + var_316_4 and arg_313_1.time_ < var_316_1 + var_316_4 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_316_7 = arg_313_1.actors_["1061"]
			local var_316_8 = 0

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps1061 == nil then
				arg_313_1.var_.actorSpriteComps1061 = var_316_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_9 = 0.034

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_9 and not isNil(var_316_7) then
				local var_316_10 = (arg_313_1.time_ - var_316_8) / var_316_9

				if arg_313_1.var_.actorSpriteComps1061 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								local var_316_11 = Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, var_316_10)
								local var_316_12 = Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, var_316_10)
								local var_316_13 = Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, var_316_10)

								iter_316_2.color = Color.New(var_316_11, var_316_12, var_316_13)
							else
								local var_316_14 = Mathf.Lerp(iter_316_2.color.r, 1, var_316_10)

								iter_316_2.color = Color.New(var_316_14, var_316_14, var_316_14)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_8 + var_316_9 and arg_313_1.time_ < var_316_8 + var_316_9 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps1061 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_316_4 then
						if arg_313_1.isInRecall_ then
							iter_316_4.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1061 = nil
			end

			local var_316_15 = 0
			local var_316_16 = 0.3

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[612].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(410182077)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 12
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182077", "story_v_out_410182.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182077", "story_v_out_410182.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_out_410182", "410182077", "story_v_out_410182.awb")

						arg_313_1:RecordAudio("410182077", var_316_24)
						arg_313_1:RecordAudio("410182077", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_410182", "410182077", "story_v_out_410182.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_410182", "410182077", "story_v_out_410182.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play410182078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 410182078
		arg_317_1.duration_ = 2.07

		local var_317_0 = {
			ja = 2.066,
			CriLanguages = 1.433,
			zh = 1.433
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
				arg_317_0:Play410182079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1061"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1061 == nil then
				arg_317_1.var_.actorSpriteComps1061 = var_320_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_2 = 0.034

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.actorSpriteComps1061 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								local var_320_4 = Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor2.r, var_320_3)
								local var_320_5 = Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor2.g, var_320_3)
								local var_320_6 = Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor2.b, var_320_3)

								iter_320_1.color = Color.New(var_320_4, var_320_5, var_320_6)
							else
								local var_320_7 = Mathf.Lerp(iter_320_1.color.r, 0.5, var_320_3)

								iter_320_1.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1061 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_320_3 then
						if arg_317_1.isInRecall_ then
							iter_320_3.color = arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_320_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1061 = nil
			end

			local var_320_8 = 0
			local var_320_9 = 0.15

			if var_320_8 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_10 = arg_317_1:FormatText(StoryNameCfg[609].name)

				arg_317_1.leftNameTxt_.text = var_320_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_11 = arg_317_1:GetWordFromCfg(410182078)
				local var_320_12 = arg_317_1:FormatText(var_320_11.content)

				arg_317_1.text_.text = var_320_12

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_13 = 6
				local var_320_14 = utf8.len(var_320_12)
				local var_320_15 = var_320_13 <= 0 and var_320_9 or var_320_9 * (var_320_14 / var_320_13)

				if var_320_15 > 0 and var_320_9 < var_320_15 then
					arg_317_1.talkMaxDuration = var_320_15

					if var_320_15 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_15 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_12
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182078", "story_v_out_410182.awb") ~= 0 then
					local var_320_16 = manager.audio:GetVoiceLength("story_v_out_410182", "410182078", "story_v_out_410182.awb") / 1000

					if var_320_16 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_16 + var_320_8
					end

					if var_320_11.prefab_name ~= "" and arg_317_1.actors_[var_320_11.prefab_name] ~= nil then
						local var_320_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_11.prefab_name].transform, "story_v_out_410182", "410182078", "story_v_out_410182.awb")

						arg_317_1:RecordAudio("410182078", var_320_17)
						arg_317_1:RecordAudio("410182078", var_320_17)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_410182", "410182078", "story_v_out_410182.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_410182", "410182078", "story_v_out_410182.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_18 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_18 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_18

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_18 and arg_317_1.time_ < var_320_8 + var_320_18 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play410182079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 410182079
		arg_321_1.duration_ = 16.47

		local var_321_0 = {
			ja = 16.466,
			CriLanguages = 13.266,
			zh = 13.266
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
				arg_321_0:Play410182080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1061"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1061 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1061", 3)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "split_5" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(0, -490, 18)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1061, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_324_7 = arg_321_1.actors_["1061"]
			local var_324_8 = 0

			if var_324_8 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps1061 == nil then
				arg_321_1.var_.actorSpriteComps1061 = var_324_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_9 = 0.034

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_9 and not isNil(var_324_7) then
				local var_324_10 = (arg_321_1.time_ - var_324_8) / var_324_9

				if arg_321_1.var_.actorSpriteComps1061 then
					for iter_324_1, iter_324_2 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_324_2 then
							if arg_321_1.isInRecall_ then
								local var_324_11 = Mathf.Lerp(iter_324_2.color.r, arg_321_1.hightColor1.r, var_324_10)
								local var_324_12 = Mathf.Lerp(iter_324_2.color.g, arg_321_1.hightColor1.g, var_324_10)
								local var_324_13 = Mathf.Lerp(iter_324_2.color.b, arg_321_1.hightColor1.b, var_324_10)

								iter_324_2.color = Color.New(var_324_11, var_324_12, var_324_13)
							else
								local var_324_14 = Mathf.Lerp(iter_324_2.color.r, 1, var_324_10)

								iter_324_2.color = Color.New(var_324_14, var_324_14, var_324_14)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_8 + var_324_9 and arg_321_1.time_ < var_324_8 + var_324_9 + arg_324_0 and not isNil(var_324_7) and arg_321_1.var_.actorSpriteComps1061 then
				for iter_324_3, iter_324_4 in pairs(arg_321_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_324_4 then
						if arg_321_1.isInRecall_ then
							iter_324_4.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps1061 = nil
			end

			local var_324_15 = 0
			local var_324_16 = 1.45

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[612].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(410182079)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 58
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182079", "story_v_out_410182.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182079", "story_v_out_410182.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_410182", "410182079", "story_v_out_410182.awb")

						arg_321_1:RecordAudio("410182079", var_324_24)
						arg_321_1:RecordAudio("410182079", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_410182", "410182079", "story_v_out_410182.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_410182", "410182079", "story_v_out_410182.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play410182080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 410182080
		arg_325_1.duration_ = 17.97

		local var_325_0 = {
			ja = 17.966,
			CriLanguages = 13.7,
			zh = 13.7
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
				arg_325_0:Play410182081(arg_325_1)
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
			local var_328_16 = 1.675

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

				local var_328_18 = arg_325_1:GetWordFromCfg(410182080)
				local var_328_19 = arg_325_1:FormatText(var_328_18.content)

				arg_325_1.text_.text = var_328_19

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_20 = 69
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

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182080", "story_v_out_410182.awb") ~= 0 then
					local var_328_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182080", "story_v_out_410182.awb") / 1000

					if var_328_23 + var_328_15 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_15
					end

					if var_328_18.prefab_name ~= "" and arg_325_1.actors_[var_328_18.prefab_name] ~= nil then
						local var_328_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_18.prefab_name].transform, "story_v_out_410182", "410182080", "story_v_out_410182.awb")

						arg_325_1:RecordAudio("410182080", var_328_24)
						arg_325_1:RecordAudio("410182080", var_328_24)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_410182", "410182080", "story_v_out_410182.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_410182", "410182080", "story_v_out_410182.awb")
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
	Play410182081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 410182081
		arg_329_1.duration_ = 18.87

		local var_329_0 = {
			ja = 18.866,
			CriLanguages = 12.366,
			zh = 12.366
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
				arg_329_0:Play410182082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1061"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos1061 = var_332_0.localPosition
				var_332_0.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1061", 3)

				local var_332_2 = var_332_0.childCount

				for iter_332_0 = 0, var_332_2 - 1 do
					local var_332_3 = var_332_0:GetChild(iter_332_0)

					if var_332_3.name == "split_5" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_4 then
				local var_332_5 = (arg_329_1.time_ - var_332_1) / var_332_4
				local var_332_6 = Vector3.New(0, -490, 18)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1061, var_332_6, var_332_5)
			end

			if arg_329_1.time_ >= var_332_1 + var_332_4 and arg_329_1.time_ < var_332_1 + var_332_4 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_332_7 = arg_329_1.actors_["1061"]
			local var_332_8 = 0

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 and not isNil(var_332_7) and arg_329_1.var_.actorSpriteComps1061 == nil then
				arg_329_1.var_.actorSpriteComps1061 = var_332_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_9 = 0.034

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_9 and not isNil(var_332_7) then
				local var_332_10 = (arg_329_1.time_ - var_332_8) / var_332_9

				if arg_329_1.var_.actorSpriteComps1061 then
					for iter_332_1, iter_332_2 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_332_2 then
							if arg_329_1.isInRecall_ then
								local var_332_11 = Mathf.Lerp(iter_332_2.color.r, arg_329_1.hightColor1.r, var_332_10)
								local var_332_12 = Mathf.Lerp(iter_332_2.color.g, arg_329_1.hightColor1.g, var_332_10)
								local var_332_13 = Mathf.Lerp(iter_332_2.color.b, arg_329_1.hightColor1.b, var_332_10)

								iter_332_2.color = Color.New(var_332_11, var_332_12, var_332_13)
							else
								local var_332_14 = Mathf.Lerp(iter_332_2.color.r, 1, var_332_10)

								iter_332_2.color = Color.New(var_332_14, var_332_14, var_332_14)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_8 + var_332_9 and arg_329_1.time_ < var_332_8 + var_332_9 + arg_332_0 and not isNil(var_332_7) and arg_329_1.var_.actorSpriteComps1061 then
				for iter_332_3, iter_332_4 in pairs(arg_329_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_332_4 then
						if arg_329_1.isInRecall_ then
							iter_332_4.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1061 = nil
			end

			local var_332_15 = 0
			local var_332_16 = 1.425

			if var_332_15 < arg_329_1.time_ and arg_329_1.time_ <= var_332_15 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_17 = arg_329_1:FormatText(StoryNameCfg[612].name)

				arg_329_1.leftNameTxt_.text = var_332_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_18 = arg_329_1:GetWordFromCfg(410182081)
				local var_332_19 = arg_329_1:FormatText(var_332_18.content)

				arg_329_1.text_.text = var_332_19

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_20 = 57
				local var_332_21 = utf8.len(var_332_19)
				local var_332_22 = var_332_20 <= 0 and var_332_16 or var_332_16 * (var_332_21 / var_332_20)

				if var_332_22 > 0 and var_332_16 < var_332_22 then
					arg_329_1.talkMaxDuration = var_332_22

					if var_332_22 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_22 + var_332_15
					end
				end

				arg_329_1.text_.text = var_332_19
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182081", "story_v_out_410182.awb") ~= 0 then
					local var_332_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182081", "story_v_out_410182.awb") / 1000

					if var_332_23 + var_332_15 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_23 + var_332_15
					end

					if var_332_18.prefab_name ~= "" and arg_329_1.actors_[var_332_18.prefab_name] ~= nil then
						local var_332_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_18.prefab_name].transform, "story_v_out_410182", "410182081", "story_v_out_410182.awb")

						arg_329_1:RecordAudio("410182081", var_332_24)
						arg_329_1:RecordAudio("410182081", var_332_24)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_410182", "410182081", "story_v_out_410182.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_410182", "410182081", "story_v_out_410182.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_25 = math.max(var_332_16, arg_329_1.talkMaxDuration)

			if var_332_15 <= arg_329_1.time_ and arg_329_1.time_ < var_332_15 + var_332_25 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_15) / var_332_25

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_15 + var_332_25 and arg_329_1.time_ < var_332_15 + var_332_25 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play410182082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 410182082
		arg_333_1.duration_ = 13.63

		local var_333_0 = {
			ja = 13.633,
			CriLanguages = 8.033,
			zh = 8.033
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
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play410182083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1061"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1061 = var_336_0.localPosition
				var_336_0.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1061", 3)

				local var_336_2 = var_336_0.childCount

				for iter_336_0 = 0, var_336_2 - 1 do
					local var_336_3 = var_336_0:GetChild(iter_336_0)

					if var_336_3.name == "split_5" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_4 then
				local var_336_5 = (arg_333_1.time_ - var_336_1) / var_336_4
				local var_336_6 = Vector3.New(0, -490, 18)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1061, var_336_6, var_336_5)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_4 and arg_333_1.time_ < var_336_1 + var_336_4 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -490, 18)
			end

			local var_336_7 = arg_333_1.actors_["1061"]
			local var_336_8 = 0

			if var_336_8 < arg_333_1.time_ and arg_333_1.time_ <= var_336_8 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.actorSpriteComps1061 == nil then
				arg_333_1.var_.actorSpriteComps1061 = var_336_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_9 = 0.034

			if var_336_8 <= arg_333_1.time_ and arg_333_1.time_ < var_336_8 + var_336_9 and not isNil(var_336_7) then
				local var_336_10 = (arg_333_1.time_ - var_336_8) / var_336_9

				if arg_333_1.var_.actorSpriteComps1061 then
					for iter_336_1, iter_336_2 in pairs(arg_333_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_336_2 then
							if arg_333_1.isInRecall_ then
								local var_336_11 = Mathf.Lerp(iter_336_2.color.r, arg_333_1.hightColor1.r, var_336_10)
								local var_336_12 = Mathf.Lerp(iter_336_2.color.g, arg_333_1.hightColor1.g, var_336_10)
								local var_336_13 = Mathf.Lerp(iter_336_2.color.b, arg_333_1.hightColor1.b, var_336_10)

								iter_336_2.color = Color.New(var_336_11, var_336_12, var_336_13)
							else
								local var_336_14 = Mathf.Lerp(iter_336_2.color.r, 1, var_336_10)

								iter_336_2.color = Color.New(var_336_14, var_336_14, var_336_14)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_8 + var_336_9 and arg_333_1.time_ < var_336_8 + var_336_9 + arg_336_0 and not isNil(var_336_7) and arg_333_1.var_.actorSpriteComps1061 then
				for iter_336_3, iter_336_4 in pairs(arg_333_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_336_4 then
						if arg_333_1.isInRecall_ then
							iter_336_4.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps1061 = nil
			end

			local var_336_15 = 0
			local var_336_16 = 0.7

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_17 = arg_333_1:FormatText(StoryNameCfg[612].name)

				arg_333_1.leftNameTxt_.text = var_336_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:GetWordFromCfg(410182082)
				local var_336_19 = arg_333_1:FormatText(var_336_18.content)

				arg_333_1.text_.text = var_336_19

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 28
				local var_336_21 = utf8.len(var_336_19)
				local var_336_22 = var_336_20 <= 0 and var_336_16 or var_336_16 * (var_336_21 / var_336_20)

				if var_336_22 > 0 and var_336_16 < var_336_22 then
					arg_333_1.talkMaxDuration = var_336_22

					if var_336_22 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_22 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_19
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182082", "story_v_out_410182.awb") ~= 0 then
					local var_336_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182082", "story_v_out_410182.awb") / 1000

					if var_336_23 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_15
					end

					if var_336_18.prefab_name ~= "" and arg_333_1.actors_[var_336_18.prefab_name] ~= nil then
						local var_336_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_18.prefab_name].transform, "story_v_out_410182", "410182082", "story_v_out_410182.awb")

						arg_333_1:RecordAudio("410182082", var_336_24)
						arg_333_1:RecordAudio("410182082", var_336_24)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_410182", "410182082", "story_v_out_410182.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_410182", "410182082", "story_v_out_410182.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_25 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_25 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_25

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_25 and arg_333_1.time_ < var_336_15 + var_336_25 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play410182083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 410182083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play410182084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 1

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				local var_340_2 = "play"
				local var_340_3 = "effect"

				arg_337_1:AudioAction(var_340_2, var_340_3, "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_340_4 = arg_337_1.actors_["1061"]
			local var_340_5 = 0

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.actorSpriteComps1061 == nil then
				arg_337_1.var_.actorSpriteComps1061 = var_340_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_6 = 0.034

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_6 and not isNil(var_340_4) then
				local var_340_7 = (arg_337_1.time_ - var_340_5) / var_340_6

				if arg_337_1.var_.actorSpriteComps1061 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_8 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor2.r, var_340_7)
								local var_340_9 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor2.g, var_340_7)
								local var_340_10 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor2.b, var_340_7)

								iter_340_1.color = Color.New(var_340_8, var_340_9, var_340_10)
							else
								local var_340_11 = Mathf.Lerp(iter_340_1.color.r, 0.5, var_340_7)

								iter_340_1.color = Color.New(var_340_11, var_340_11, var_340_11)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_5 + var_340_6 and arg_337_1.time_ < var_340_5 + var_340_6 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.actorSpriteComps1061 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1061 = nil
			end

			local var_340_12 = 0
			local var_340_13 = 1.075

			if var_340_12 < arg_337_1.time_ and arg_337_1.time_ <= var_340_12 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_14 = arg_337_1:GetWordFromCfg(410182083)
				local var_340_15 = arg_337_1:FormatText(var_340_14.content)

				arg_337_1.text_.text = var_340_15

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_16 = 43
				local var_340_17 = utf8.len(var_340_15)
				local var_340_18 = var_340_16 <= 0 and var_340_13 or var_340_13 * (var_340_17 / var_340_16)

				if var_340_18 > 0 and var_340_13 < var_340_18 then
					arg_337_1.talkMaxDuration = var_340_18

					if var_340_18 + var_340_12 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_18 + var_340_12
					end
				end

				arg_337_1.text_.text = var_340_15
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_19 = math.max(var_340_13, arg_337_1.talkMaxDuration)

			if var_340_12 <= arg_337_1.time_ and arg_337_1.time_ < var_340_12 + var_340_19 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_12) / var_340_19

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_12 + var_340_19 and arg_337_1.time_ < var_340_12 + var_340_19 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play410182084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 410182084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play410182085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10061"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10061 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10061", 2)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(-390, -517.5, -100)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10061, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_344_7 = arg_341_1.actors_["1061"].transform
			local var_344_8 = 0

			if var_344_8 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.var_.moveOldPos1061 = var_344_7.localPosition
				var_344_7.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1061", 4)

				local var_344_9 = var_344_7.childCount

				for iter_344_1 = 0, var_344_9 - 1 do
					local var_344_10 = var_344_7:GetChild(iter_344_1)

					if var_344_10.name == "" or not string.find(var_344_10.name, "split") then
						var_344_10.gameObject:SetActive(true)
					else
						var_344_10.gameObject:SetActive(false)
					end
				end
			end

			local var_344_11 = 0.001

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_11 then
				local var_344_12 = (arg_341_1.time_ - var_344_8) / var_344_11
				local var_344_13 = Vector3.New(390, -490, 18)

				var_344_7.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1061, var_344_13, var_344_12)
			end

			if arg_341_1.time_ >= var_344_8 + var_344_11 and arg_341_1.time_ < var_344_8 + var_344_11 + arg_344_0 then
				var_344_7.localPosition = Vector3.New(390, -490, 18)
			end

			local var_344_14 = arg_341_1.actors_["10061"]
			local var_344_15 = 0

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 and not isNil(var_344_14) and arg_341_1.var_.actorSpriteComps10061 == nil then
				arg_341_1.var_.actorSpriteComps10061 = var_344_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_16 = 0.034

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_16 and not isNil(var_344_14) then
				local var_344_17 = (arg_341_1.time_ - var_344_15) / var_344_16

				if arg_341_1.var_.actorSpriteComps10061 then
					for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_344_3 then
							if arg_341_1.isInRecall_ then
								local var_344_18 = Mathf.Lerp(iter_344_3.color.r, arg_341_1.hightColor2.r, var_344_17)
								local var_344_19 = Mathf.Lerp(iter_344_3.color.g, arg_341_1.hightColor2.g, var_344_17)
								local var_344_20 = Mathf.Lerp(iter_344_3.color.b, arg_341_1.hightColor2.b, var_344_17)

								iter_344_3.color = Color.New(var_344_18, var_344_19, var_344_20)
							else
								local var_344_21 = Mathf.Lerp(iter_344_3.color.r, 0.5, var_344_17)

								iter_344_3.color = Color.New(var_344_21, var_344_21, var_344_21)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_15 + var_344_16 and arg_341_1.time_ < var_344_15 + var_344_16 + arg_344_0 and not isNil(var_344_14) and arg_341_1.var_.actorSpriteComps10061 then
				for iter_344_4, iter_344_5 in pairs(arg_341_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_344_5 then
						if arg_341_1.isInRecall_ then
							iter_344_5.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps10061 = nil
			end

			local var_344_22 = arg_341_1.actors_["1061"]
			local var_344_23 = 0

			if var_344_23 < arg_341_1.time_ and arg_341_1.time_ <= var_344_23 + arg_344_0 and not isNil(var_344_22) and arg_341_1.var_.actorSpriteComps1061 == nil then
				arg_341_1.var_.actorSpriteComps1061 = var_344_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_24 = 0.034

			if var_344_23 <= arg_341_1.time_ and arg_341_1.time_ < var_344_23 + var_344_24 and not isNil(var_344_22) then
				local var_344_25 = (arg_341_1.time_ - var_344_23) / var_344_24

				if arg_341_1.var_.actorSpriteComps1061 then
					for iter_344_6, iter_344_7 in pairs(arg_341_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_344_7 then
							if arg_341_1.isInRecall_ then
								local var_344_26 = Mathf.Lerp(iter_344_7.color.r, arg_341_1.hightColor2.r, var_344_25)
								local var_344_27 = Mathf.Lerp(iter_344_7.color.g, arg_341_1.hightColor2.g, var_344_25)
								local var_344_28 = Mathf.Lerp(iter_344_7.color.b, arg_341_1.hightColor2.b, var_344_25)

								iter_344_7.color = Color.New(var_344_26, var_344_27, var_344_28)
							else
								local var_344_29 = Mathf.Lerp(iter_344_7.color.r, 0.5, var_344_25)

								iter_344_7.color = Color.New(var_344_29, var_344_29, var_344_29)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= var_344_23 + var_344_24 and arg_341_1.time_ < var_344_23 + var_344_24 + arg_344_0 and not isNil(var_344_22) and arg_341_1.var_.actorSpriteComps1061 then
				for iter_344_8, iter_344_9 in pairs(arg_341_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_344_9 then
						if arg_341_1.isInRecall_ then
							iter_344_9.color = arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_344_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_341_1.var_.actorSpriteComps1061 = nil
			end

			local var_344_30 = 0
			local var_344_31 = 1.2

			if var_344_30 < arg_341_1.time_ and arg_341_1.time_ <= var_344_30 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_32 = arg_341_1:GetWordFromCfg(410182084)
				local var_344_33 = arg_341_1:FormatText(var_344_32.content)

				arg_341_1.text_.text = var_344_33

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_34 = 48
				local var_344_35 = utf8.len(var_344_33)
				local var_344_36 = var_344_34 <= 0 and var_344_31 or var_344_31 * (var_344_35 / var_344_34)

				if var_344_36 > 0 and var_344_31 < var_344_36 then
					arg_341_1.talkMaxDuration = var_344_36

					if var_344_36 + var_344_30 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_36 + var_344_30
					end
				end

				arg_341_1.text_.text = var_344_33
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_37 = math.max(var_344_31, arg_341_1.talkMaxDuration)

			if var_344_30 <= arg_341_1.time_ and arg_341_1.time_ < var_344_30 + var_344_37 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_30) / var_344_37

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_30 + var_344_37 and arg_341_1.time_ < var_344_30 + var_344_37 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_341_1:InitPlayNodeList()
	end,
	Play410182085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 410182085
		arg_345_1.duration_ = 3.67

		local var_345_0 = {
			ja = 3.666,
			CriLanguages = 3.266,
			zh = 3.266
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play410182086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10061"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10061 = var_348_0.localPosition
				var_348_0.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10061", 2)

				local var_348_2 = var_348_0.childCount

				for iter_348_0 = 0, var_348_2 - 1 do
					local var_348_3 = var_348_0:GetChild(iter_348_0)

					if var_348_3.name == "" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_4 then
				local var_348_5 = (arg_345_1.time_ - var_348_1) / var_348_4
				local var_348_6 = Vector3.New(-390, -517.5, -100)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10061, var_348_6, var_348_5)
			end

			if arg_345_1.time_ >= var_348_1 + var_348_4 and arg_345_1.time_ < var_348_1 + var_348_4 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_348_7 = arg_345_1.actors_["10061"]
			local var_348_8 = 0

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps10061 == nil then
				arg_345_1.var_.actorSpriteComps10061 = var_348_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_9 = 0.034

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_9 and not isNil(var_348_7) then
				local var_348_10 = (arg_345_1.time_ - var_348_8) / var_348_9

				if arg_345_1.var_.actorSpriteComps10061 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_348_2 then
							if arg_345_1.isInRecall_ then
								local var_348_11 = Mathf.Lerp(iter_348_2.color.r, arg_345_1.hightColor1.r, var_348_10)
								local var_348_12 = Mathf.Lerp(iter_348_2.color.g, arg_345_1.hightColor1.g, var_348_10)
								local var_348_13 = Mathf.Lerp(iter_348_2.color.b, arg_345_1.hightColor1.b, var_348_10)

								iter_348_2.color = Color.New(var_348_11, var_348_12, var_348_13)
							else
								local var_348_14 = Mathf.Lerp(iter_348_2.color.r, 1, var_348_10)

								iter_348_2.color = Color.New(var_348_14, var_348_14, var_348_14)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= var_348_8 + var_348_9 and arg_345_1.time_ < var_348_8 + var_348_9 + arg_348_0 and not isNil(var_348_7) and arg_345_1.var_.actorSpriteComps10061 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_348_4 then
						if arg_345_1.isInRecall_ then
							iter_348_4.color = arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_348_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_345_1.var_.actorSpriteComps10061 = nil
			end

			local var_348_15 = 0
			local var_348_16 = 0.1

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[591].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(410182085)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 4
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182085", "story_v_out_410182.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182085", "story_v_out_410182.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_out_410182", "410182085", "story_v_out_410182.awb")

						arg_345_1:RecordAudio("410182085", var_348_24)
						arg_345_1:RecordAudio("410182085", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_410182", "410182085", "story_v_out_410182.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_410182", "410182085", "story_v_out_410182.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play410182086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 410182086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play410182087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10061"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10061 == nil then
				arg_349_1.var_.actorSpriteComps10061 = var_352_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_2 = 0.034

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.actorSpriteComps10061 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								local var_352_4 = Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor2.r, var_352_3)
								local var_352_5 = Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor2.g, var_352_3)
								local var_352_6 = Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor2.b, var_352_3)

								iter_352_1.color = Color.New(var_352_4, var_352_5, var_352_6)
							else
								local var_352_7 = Mathf.Lerp(iter_352_1.color.r, 0.5, var_352_3)

								iter_352_1.color = Color.New(var_352_7, var_352_7, var_352_7)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.actorSpriteComps10061 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_352_3 then
						if arg_349_1.isInRecall_ then
							iter_352_3.color = arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_352_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_349_1.var_.actorSpriteComps10061 = nil
			end

			local var_352_8 = 0
			local var_352_9 = 1.275

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(410182086)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_12 = 51
				local var_352_13 = utf8.len(var_352_11)
				local var_352_14 = var_352_12 <= 0 and var_352_9 or var_352_9 * (var_352_13 / var_352_12)

				if var_352_14 > 0 and var_352_9 < var_352_14 then
					arg_349_1.talkMaxDuration = var_352_14

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_15 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_15 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_15

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_15 and arg_349_1.time_ < var_352_8 + var_352_15 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play410182087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 410182087
		arg_353_1.duration_ = 3.73

		local var_353_0 = {
			ja = 3.633,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10061"].transform
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.var_.moveOldPos10061 = var_356_0.localPosition
				var_356_0.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10061", 2)

				local var_356_2 = var_356_0.childCount

				for iter_356_0 = 0, var_356_2 - 1 do
					local var_356_3 = var_356_0:GetChild(iter_356_0)

					if var_356_3.name == "" or not string.find(var_356_3.name, "split") then
						var_356_3.gameObject:SetActive(true)
					else
						var_356_3.gameObject:SetActive(false)
					end
				end
			end

			local var_356_4 = 0.001

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_4 then
				local var_356_5 = (arg_353_1.time_ - var_356_1) / var_356_4
				local var_356_6 = Vector3.New(-390, -517.5, -100)

				var_356_0.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10061, var_356_6, var_356_5)
			end

			if arg_353_1.time_ >= var_356_1 + var_356_4 and arg_353_1.time_ < var_356_1 + var_356_4 + arg_356_0 then
				var_356_0.localPosition = Vector3.New(-390, -517.5, -100)
			end

			local var_356_7 = arg_353_1.actors_["10061"]
			local var_356_8 = 0

			if var_356_8 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10061 == nil then
				arg_353_1.var_.actorSpriteComps10061 = var_356_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_9 = 0.034

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_9 and not isNil(var_356_7) then
				local var_356_10 = (arg_353_1.time_ - var_356_8) / var_356_9

				if arg_353_1.var_.actorSpriteComps10061 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								local var_356_11 = Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, var_356_10)
								local var_356_12 = Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, var_356_10)
								local var_356_13 = Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, var_356_10)

								iter_356_2.color = Color.New(var_356_11, var_356_12, var_356_13)
							else
								local var_356_14 = Mathf.Lerp(iter_356_2.color.r, 1, var_356_10)

								iter_356_2.color = Color.New(var_356_14, var_356_14, var_356_14)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_8 + var_356_9 and arg_353_1.time_ < var_356_8 + var_356_9 + arg_356_0 and not isNil(var_356_7) and arg_353_1.var_.actorSpriteComps10061 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10061:ToTable()) do
					if iter_356_4 then
						if arg_353_1.isInRecall_ then
							iter_356_4.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10061 = nil
			end

			local var_356_15 = 0
			local var_356_16 = 0.2

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_17 = arg_353_1:FormatText(StoryNameCfg[591].name)

				arg_353_1.leftNameTxt_.text = var_356_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:GetWordFromCfg(410182087)
				local var_356_19 = arg_353_1:FormatText(var_356_18.content)

				arg_353_1.text_.text = var_356_19

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 8
				local var_356_21 = utf8.len(var_356_19)
				local var_356_22 = var_356_20 <= 0 and var_356_16 or var_356_16 * (var_356_21 / var_356_20)

				if var_356_22 > 0 and var_356_16 < var_356_22 then
					arg_353_1.talkMaxDuration = var_356_22

					if var_356_22 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_22 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_19
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410182", "410182087", "story_v_out_410182.awb") ~= 0 then
					local var_356_23 = manager.audio:GetVoiceLength("story_v_out_410182", "410182087", "story_v_out_410182.awb") / 1000

					if var_356_23 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_15
					end

					if var_356_18.prefab_name ~= "" and arg_353_1.actors_[var_356_18.prefab_name] ~= nil then
						local var_356_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_18.prefab_name].transform, "story_v_out_410182", "410182087", "story_v_out_410182.awb")

						arg_353_1:RecordAudio("410182087", var_356_24)
						arg_353_1:RecordAudio("410182087", var_356_24)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_410182", "410182087", "story_v_out_410182.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_410182", "410182087", "story_v_out_410182.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_25 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_25 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_25

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_25 and arg_353_1.time_ < var_356_15 + var_356_25 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L04g",
		"TextureConfig/Background/ST63",
		"TextureConfig/Background/ST64a"
	},
	voices = {
		"story_v_out_410182.awb"
	}
}
