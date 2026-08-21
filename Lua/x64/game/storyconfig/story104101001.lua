return {
	Play410101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410101001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.5,
			ja = 4.1
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
				arg_1_0:Play410101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J02c"

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
				local var_4_5 = arg_1_1.bgs_.J02c

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
					if iter_4_0 ~= "J02c" then
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

			local var_4_22 = "10064"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10064")

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

			local var_4_26 = arg_1_1.actors_["10064"].transform
			local var_4_27 = 2

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10064 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10064", 3)

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
				local var_4_32 = Vector3.New(0, -570, 192.5)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10064, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_4_33 = arg_1_1.actors_["10064"]
			local var_4_34 = 2

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10064 == nil then
				arg_1_1.var_.actorSpriteComps10064 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps10064 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10064 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10064 = nil
			end

			local var_4_41 = 0

			arg_1_1.isInRecall_ = false

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					local var_4_42 = iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_11, iter_4_12 in ipairs(var_4_42) do
						if iter_4_12.color.r > 0.51 then
							iter_4_12.color = Color.New(1, 1, 1)
						else
							iter_4_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_43 = 0.0339999999999998

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_41) / var_4_43

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_44)
			end

			if arg_1_1.time_ >= var_4_41 + var_4_43 and arg_1_1.time_ < var_4_41 + var_4_43 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_45 = 0
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "music"

				arg_1_1:AudioAction(var_4_47, var_4_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_49 = ""
				local var_4_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_50 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_50 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_50

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_50
						arg_1_1.bgmTxt2_.text = var_4_50
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

			local var_4_51 = 1.56666666666667
			local var_4_52 = 1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if var_4_56 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_56 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_56

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_56
						arg_1_1.bgmTxt2_.text = var_4_56
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

			local var_4_57 = 2
			local var_4_58 = 0.25

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[584].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(410101001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 10
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101001", "story_v_out_410101.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_410101", "410101001", "story_v_out_410101.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_410101", "410101001", "story_v_out_410101.awb")

						arg_1_1:RecordAudio("410101001", var_4_67)
						arg_1_1:RecordAudio("410101001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410101", "410101001", "story_v_out_410101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410101", "410101001", "story_v_out_410101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_57 + 0.3
			local var_4_69 = math.max(var_4_58, arg_1_1.talkMaxDuration)

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
				actorName = "10064",
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
	Play410101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410101002
		arg_9_1.duration_ = 6.27

		local var_9_0 = {
			zh = 3.633,
			ja = 6.266
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
				arg_9_0:Play410101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10064"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10064 == nil then
				arg_9_1.var_.actorSpriteComps10064 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.034

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps10064 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10064 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10064 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.475

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[595].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_1")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(410101002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101002", "story_v_out_410101.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_410101", "410101002", "story_v_out_410101.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_410101", "410101002", "story_v_out_410101.awb")

						arg_9_1:RecordAudio("410101002", var_12_17)
						arg_9_1:RecordAudio("410101002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410101", "410101002", "story_v_out_410101.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410101", "410101002", "story_v_out_410101.awb")
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
	Play410101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410101003
		arg_13_1.duration_ = 6.93

		local var_13_0 = {
			zh = 5.333,
			ja = 6.933
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
				arg_13_0:Play410101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10064"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10064 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10064", 3)

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
				local var_16_6 = Vector3.New(0, -570, 192.5)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10064, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_16_7 = arg_13_1.actors_["10064"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10064 == nil then
				arg_13_1.var_.actorSpriteComps10064 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10064 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10064 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10064 = nil
			end

			local var_16_15 = 0
			local var_16_16 = 0.725

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

				local var_16_18 = arg_13_1:GetWordFromCfg(410101003)
				local var_16_19 = arg_13_1:FormatText(var_16_18.content)

				arg_13_1.text_.text = var_16_19

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101003", "story_v_out_410101.awb") ~= 0 then
					local var_16_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101003", "story_v_out_410101.awb") / 1000

					if var_16_23 + var_16_15 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_23 + var_16_15
					end

					if var_16_18.prefab_name ~= "" and arg_13_1.actors_[var_16_18.prefab_name] ~= nil then
						local var_16_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_18.prefab_name].transform, "story_v_out_410101", "410101003", "story_v_out_410101.awb")

						arg_13_1:RecordAudio("410101003", var_16_24)
						arg_13_1:RecordAudio("410101003", var_16_24)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_410101", "410101003", "story_v_out_410101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_410101", "410101003", "story_v_out_410101.awb")
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
				actorName = "10064",
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
	Play410101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410101004
		arg_17_1.duration_ = 10.33

		local var_17_0 = {
			zh = 6.033,
			ja = 10.333
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
				arg_17_0:Play410101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10064"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10064 == nil then
				arg_17_1.var_.actorSpriteComps10064 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.034

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10064 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10064 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10064 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.875

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[595].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_3")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(410101004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101004", "story_v_out_410101.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_410101", "410101004", "story_v_out_410101.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_410101", "410101004", "story_v_out_410101.awb")

						arg_17_1:RecordAudio("410101004", var_20_17)
						arg_17_1:RecordAudio("410101004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410101", "410101004", "story_v_out_410101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410101", "410101004", "story_v_out_410101.awb")
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
	Play410101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410101005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play410101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10064"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10064 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10064", 7)

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
				local var_24_6 = Vector3.New(0, -2000, 192.5)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10064, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_24_7 = arg_21_1.actors_["10064"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10064 == nil then
				arg_21_1.var_.actorSpriteComps10064 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps10064 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps10064 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10064 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 1.6

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_17 = arg_21_1:GetWordFromCfg(410101005)
				local var_24_18 = arg_21_1:FormatText(var_24_17.content)

				arg_21_1.text_.text = var_24_18

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 64
				local var_24_20 = utf8.len(var_24_18)
				local var_24_21 = var_24_19 <= 0 and var_24_16 or var_24_16 * (var_24_20 / var_24_19)

				if var_24_21 > 0 and var_24_16 < var_24_21 then
					arg_21_1.talkMaxDuration = var_24_21

					if var_24_21 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_21 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_18
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_22 and arg_21_1.time_ < var_24_15 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play410101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "1060"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

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

			local var_28_4 = arg_25_1.actors_["1060"].transform
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.var_.moveOldPos1060 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1060", 7)

				local var_28_6 = var_28_4.childCount

				for iter_28_2 = 0, var_28_6 - 1 do
					local var_28_7 = var_28_4:GetChild(iter_28_2)

					if var_28_7.name == "" or not string.find(var_28_7.name, "split") then
						var_28_7.gameObject:SetActive(true)
					else
						var_28_7.gameObject:SetActive(false)
					end
				end
			end

			local var_28_8 = 0.001

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_5) / var_28_8
				local var_28_10 = Vector3.New(0, -2000, -40)

				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1060, var_28_10, var_28_9)
			end

			if arg_25_1.time_ >= var_28_5 + var_28_8 and arg_25_1.time_ < var_28_5 + var_28_8 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_28_11 = 0
			local var_28_12 = 1.525

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(410101006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 61
				local var_28_16 = utf8.len(var_28_14)
				local var_28_17 = var_28_15 <= 0 and var_28_12 or var_28_12 * (var_28_16 / var_28_15)

				if var_28_17 > 0 and var_28_12 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_18 and arg_25_1.time_ < var_28_11 + var_28_18 + arg_28_0 then
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
	Play410101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410101007
		arg_29_1.duration_ = 4.27

		local var_29_0 = {
			zh = 1.833,
			ja = 4.266
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
				arg_29_0:Play410101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10064"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10064 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10064", 3)

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
				local var_32_6 = Vector3.New(0, -570, 192.5)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10064, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_32_7 = arg_29_1.actors_["10064"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10064 == nil then
				arg_29_1.var_.actorSpriteComps10064 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps10064 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps10064 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10064 = nil
			end

			local var_32_15 = 0
			local var_32_16 = 0.275

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[584].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(410101007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101007", "story_v_out_410101.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101007", "story_v_out_410101.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_410101", "410101007", "story_v_out_410101.awb")

						arg_29_1:RecordAudio("410101007", var_32_24)
						arg_29_1:RecordAudio("410101007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410101", "410101007", "story_v_out_410101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410101", "410101007", "story_v_out_410101.awb")
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
				actorName = "10064",
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
	Play410101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10064"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10064 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10064", 7)

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
				local var_36_6 = Vector3.New(0, -2000, 192.5)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10064, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_36_7 = 0
			local var_36_8 = 0.35

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(410101008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 14
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_8 or var_36_8 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_8 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_14 and arg_33_1.time_ < var_36_7 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410101009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = "STblack"

			if arg_37_1.bgs_[var_40_0] == nil then
				local var_40_1 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_40_0)
				var_40_1.name = var_40_0
				var_40_1.transform.parent = arg_37_1.stage_.transform
				var_40_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_[var_40_0] = var_40_1
			end

			local var_40_2 = 2

			if var_40_2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				local var_40_3 = manager.ui.mainCamera.transform.localPosition
				local var_40_4 = Vector3.New(0, 0, 10) + Vector3.New(var_40_3.x, var_40_3.y, 0)
				local var_40_5 = arg_37_1.bgs_.STblack

				var_40_5.transform.localPosition = var_40_4
				var_40_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_6 = var_40_5:GetComponent("SpriteRenderer")

				if var_40_6 and var_40_6.sprite then
					local var_40_7 = (var_40_5.transform.localPosition - var_40_3).z
					local var_40_8 = manager.ui.mainCameraCom_
					local var_40_9 = 2 * var_40_7 * Mathf.Tan(var_40_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_40_10 = var_40_9 * var_40_8.aspect
					local var_40_11 = var_40_6.sprite.bounds.size.x
					local var_40_12 = var_40_6.sprite.bounds.size.y
					local var_40_13 = var_40_10 / var_40_11
					local var_40_14 = var_40_9 / var_40_12
					local var_40_15 = var_40_14 < var_40_13 and var_40_13 or var_40_14

					var_40_5.transform.localScale = Vector3.New(var_40_15, var_40_15, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "STblack" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_17 = 2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17
				local var_40_19 = Color.New(0, 0, 0)

				var_40_19.a = Mathf.Lerp(0, 1, var_40_18)
				arg_37_1.mask_.color = var_40_19
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				local var_40_20 = Color.New(0, 0, 0)

				var_40_20.a = 1
				arg_37_1.mask_.color = var_40_20
			end

			local var_40_21 = 2

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_22 = 2

			if var_40_21 <= arg_37_1.time_ and arg_37_1.time_ < var_40_21 + var_40_22 then
				local var_40_23 = (arg_37_1.time_ - var_40_21) / var_40_22
				local var_40_24 = Color.New(0, 0, 0)

				var_40_24.a = Mathf.Lerp(1, 0, var_40_23)
				arg_37_1.mask_.color = var_40_24
			end

			if arg_37_1.time_ >= var_40_21 + var_40_22 and arg_37_1.time_ < var_40_21 + var_40_22 + arg_40_0 then
				local var_40_25 = Color.New(0, 0, 0)
				local var_40_26 = 0

				arg_37_1.mask_.enabled = false
				var_40_25.a = var_40_26
				arg_37_1.mask_.color = var_40_25
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_27 = 4
			local var_40_28 = 1.65

			if var_40_27 < arg_37_1.time_ and arg_37_1.time_ <= var_40_27 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_29 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_29:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_30 = arg_37_1:GetWordFromCfg(410101009)
				local var_40_31 = arg_37_1:FormatText(var_40_30.content)

				arg_37_1.text_.text = var_40_31

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_32 = 66
				local var_40_33 = utf8.len(var_40_31)
				local var_40_34 = var_40_32 <= 0 and var_40_28 or var_40_28 * (var_40_33 / var_40_32)

				if var_40_34 > 0 and var_40_28 < var_40_34 then
					arg_37_1.talkMaxDuration = var_40_34
					var_40_27 = var_40_27 + 0.3

					if var_40_34 + var_40_27 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_34 + var_40_27
					end
				end

				arg_37_1.text_.text = var_40_31
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_35 = var_40_27 + 0.3
			local var_40_36 = math.max(var_40_28, arg_37_1.talkMaxDuration)

			if var_40_35 <= arg_37_1.time_ and arg_37_1.time_ < var_40_35 + var_40_36 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_35) / var_40_36

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_35 + var_40_36 and arg_37_1.time_ < var_40_35 + var_40_36 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play410101010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 410101010
		arg_43_1.duration_ = 8.5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play410101011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "ST31a"

			if arg_43_1.bgs_[var_46_0] == nil then
				local var_46_1 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_46_0)
				var_46_1.name = var_46_0
				var_46_1.transform.parent = arg_43_1.stage_.transform
				var_46_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_[var_46_0] = var_46_1
			end

			local var_46_2 = 0

			if var_46_2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				local var_46_3 = manager.ui.mainCamera.transform.localPosition
				local var_46_4 = Vector3.New(0, 0, 10) + Vector3.New(var_46_3.x, var_46_3.y, 0)
				local var_46_5 = arg_43_1.bgs_.ST31a

				var_46_5.transform.localPosition = var_46_4
				var_46_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_6 = var_46_5:GetComponent("SpriteRenderer")

				if var_46_6 and var_46_6.sprite then
					local var_46_7 = (var_46_5.transform.localPosition - var_46_3).z
					local var_46_8 = manager.ui.mainCameraCom_
					local var_46_9 = 2 * var_46_7 * Mathf.Tan(var_46_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_10 = var_46_9 * var_46_8.aspect
					local var_46_11 = var_46_6.sprite.bounds.size.x
					local var_46_12 = var_46_6.sprite.bounds.size.y
					local var_46_13 = var_46_10 / var_46_11
					local var_46_14 = var_46_9 / var_46_12
					local var_46_15 = var_46_14 < var_46_13 and var_46_13 or var_46_14

					var_46_5.transform.localScale = Vector3.New(var_46_15, var_46_15, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST31a" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_17 = 3.5

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17
				local var_46_19 = Color.New(0, 0, 0)

				var_46_19.a = Mathf.Lerp(1, 0, var_46_18)
				arg_43_1.mask_.color = var_46_19
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				local var_46_20 = Color.New(0, 0, 0)
				local var_46_21 = 0

				arg_43_1.mask_.enabled = false
				var_46_20.a = var_46_21
				arg_43_1.mask_.color = var_46_20
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_22 = 3.5
			local var_46_23 = 0.625

			if var_46_22 < arg_43_1.time_ and arg_43_1.time_ <= var_46_22 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_24 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_24:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_25 = arg_43_1:GetWordFromCfg(410101010)
				local var_46_26 = arg_43_1:FormatText(var_46_25.content)

				arg_43_1.text_.text = var_46_26

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_27 = 25
				local var_46_28 = utf8.len(var_46_26)
				local var_46_29 = var_46_27 <= 0 and var_46_23 or var_46_23 * (var_46_28 / var_46_27)

				if var_46_29 > 0 and var_46_23 < var_46_29 then
					arg_43_1.talkMaxDuration = var_46_29
					var_46_22 = var_46_22 + 0.3

					if var_46_29 + var_46_22 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_29 + var_46_22
					end
				end

				arg_43_1.text_.text = var_46_26
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_30 = var_46_22 + 0.3
			local var_46_31 = math.max(var_46_23, arg_43_1.talkMaxDuration)

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_31 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_30) / var_46_31

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_30 + var_46_31 and arg_43_1.time_ < var_46_30 + var_46_31 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play410101011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410101011
		arg_49_1.duration_ = 1.3

		local var_49_0 = {
			zh = 1.3,
			ja = 1.266
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
				arg_49_0:Play410101012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "1012"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

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

			local var_52_4 = arg_49_1.actors_["1012"].transform
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.var_.moveOldPos1012 = var_52_4.localPosition
				var_52_4.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1012", 3)

				local var_52_6 = var_52_4.childCount

				for iter_52_2 = 0, var_52_6 - 1 do
					local var_52_7 = var_52_4:GetChild(iter_52_2)

					if var_52_7.name == "split_3" or not string.find(var_52_7.name, "split") then
						var_52_7.gameObject:SetActive(true)
					else
						var_52_7.gameObject:SetActive(false)
					end
				end
			end

			local var_52_8 = 0.001

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_8 then
				local var_52_9 = (arg_49_1.time_ - var_52_5) / var_52_8
				local var_52_10 = Vector3.New(0, -465, 300)

				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1012, var_52_10, var_52_9)
			end

			if arg_49_1.time_ >= var_52_5 + var_52_8 and arg_49_1.time_ < var_52_5 + var_52_8 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(0, -465, 300)
			end

			local var_52_11 = arg_49_1.actors_["1012"]
			local var_52_12 = 0

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.actorSpriteComps1012 == nil then
				arg_49_1.var_.actorSpriteComps1012 = var_52_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_13 = 0.034

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_13 and not isNil(var_52_11) then
				local var_52_14 = (arg_49_1.time_ - var_52_12) / var_52_13

				if arg_49_1.var_.actorSpriteComps1012 then
					for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_52_4 then
							if arg_49_1.isInRecall_ then
								local var_52_15 = Mathf.Lerp(iter_52_4.color.r, arg_49_1.hightColor1.r, var_52_14)
								local var_52_16 = Mathf.Lerp(iter_52_4.color.g, arg_49_1.hightColor1.g, var_52_14)
								local var_52_17 = Mathf.Lerp(iter_52_4.color.b, arg_49_1.hightColor1.b, var_52_14)

								iter_52_4.color = Color.New(var_52_15, var_52_16, var_52_17)
							else
								local var_52_18 = Mathf.Lerp(iter_52_4.color.r, 1, var_52_14)

								iter_52_4.color = Color.New(var_52_18, var_52_18, var_52_18)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_12 + var_52_13 and arg_49_1.time_ < var_52_12 + var_52_13 + arg_52_0 and not isNil(var_52_11) and arg_49_1.var_.actorSpriteComps1012 then
				for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_52_6 then
						if arg_49_1.isInRecall_ then
							iter_52_6.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1012 = nil
			end

			local var_52_19 = manager.ui.mainCamera.transform
			local var_52_20 = 0

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1.var_.shakeOldPos = var_52_19.localPosition
			end

			local var_52_21 = 0.5

			if var_52_20 <= arg_49_1.time_ and arg_49_1.time_ < var_52_20 + var_52_21 then
				local var_52_22 = (arg_49_1.time_ - var_52_20) / 0.066
				local var_52_23, var_52_24 = math.modf(var_52_22)

				var_52_19.localPosition = Vector3.New(var_52_24 * 0.13, var_52_24 * 0.13, var_52_24 * 0.13) + arg_49_1.var_.shakeOldPos
			end

			if arg_49_1.time_ >= var_52_20 + var_52_21 and arg_49_1.time_ < var_52_20 + var_52_21 + arg_52_0 then
				var_52_19.localPosition = arg_49_1.var_.shakeOldPos
			end

			local var_52_25 = 0
			local var_52_26 = 1

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 then
				local var_52_27 = "play"
				local var_52_28 = "effect"

				arg_49_1:AudioAction(var_52_27, var_52_28, "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_52_29 = 0
			local var_52_30 = 0.075

			if var_52_29 < arg_49_1.time_ and arg_49_1.time_ <= var_52_29 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_31 = arg_49_1:FormatText(StoryNameCfg[595].name)

				arg_49_1.leftNameTxt_.text = var_52_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_32 = arg_49_1:GetWordFromCfg(410101011)
				local var_52_33 = arg_49_1:FormatText(var_52_32.content)

				arg_49_1.text_.text = var_52_33

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_34 = 3
				local var_52_35 = utf8.len(var_52_33)
				local var_52_36 = var_52_34 <= 0 and var_52_30 or var_52_30 * (var_52_35 / var_52_34)

				if var_52_36 > 0 and var_52_30 < var_52_36 then
					arg_49_1.talkMaxDuration = var_52_36

					if var_52_36 + var_52_29 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_36 + var_52_29
					end
				end

				arg_49_1.text_.text = var_52_33
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101011", "story_v_out_410101.awb") ~= 0 then
					local var_52_37 = manager.audio:GetVoiceLength("story_v_out_410101", "410101011", "story_v_out_410101.awb") / 1000

					if var_52_37 + var_52_29 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_29
					end

					if var_52_32.prefab_name ~= "" and arg_49_1.actors_[var_52_32.prefab_name] ~= nil then
						local var_52_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_32.prefab_name].transform, "story_v_out_410101", "410101011", "story_v_out_410101.awb")

						arg_49_1:RecordAudio("410101011", var_52_38)
						arg_49_1:RecordAudio("410101011", var_52_38)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410101", "410101011", "story_v_out_410101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410101", "410101011", "story_v_out_410101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_39 = math.max(var_52_30, arg_49_1.talkMaxDuration)

			if var_52_29 <= arg_49_1.time_ and arg_49_1.time_ < var_52_29 + var_52_39 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_29) / var_52_39

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_29 + var_52_39 and arg_49_1.time_ < var_52_29 + var_52_39 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play410101012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410101012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410101013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1012"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1012 == nil then
				arg_53_1.var_.actorSpriteComps1012 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.034

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps1012 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps1012 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps1012 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 1.1

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(410101012)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 44
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_9 or var_56_9 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_9 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_15 and arg_53_1.time_ < var_56_8 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410101013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410101013
		arg_57_1.duration_ = 12

		local var_57_0 = {
			zh = 10.2,
			ja = 12
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
				arg_57_0:Play410101014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1012"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1012 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1012", 2)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_3" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(-390, -465, 300)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1012, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_60_7 = arg_57_1.actors_["1012"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1012 == nil then
				arg_57_1.var_.actorSpriteComps1012 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps1012 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps1012 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps1012 = nil
			end

			local var_60_15 = arg_57_1.actors_["10064"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos10064 = var_60_15.localPosition
				var_60_15.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10064", 4)

				local var_60_17 = var_60_15.childCount

				for iter_60_5 = 0, var_60_17 - 1 do
					local var_60_18 = var_60_15:GetChild(iter_60_5)

					if var_60_18.name == "" or not string.find(var_60_18.name, "split") then
						var_60_18.gameObject:SetActive(true)
					else
						var_60_18.gameObject:SetActive(false)
					end
				end
			end

			local var_60_19 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_19 then
				local var_60_20 = (arg_57_1.time_ - var_60_16) / var_60_19
				local var_60_21 = Vector3.New(390, -570, 192.5)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10064, var_60_21, var_60_20)
			end

			if arg_57_1.time_ >= var_60_16 + var_60_19 and arg_57_1.time_ < var_60_16 + var_60_19 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_60_22 = arg_57_1.actors_["10064"]
			local var_60_23 = 0

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps10064 == nil then
				arg_57_1.var_.actorSpriteComps10064 = var_60_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_24 = 0.034

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 and not isNil(var_60_22) then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24

				if arg_57_1.var_.actorSpriteComps10064 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								local var_60_26 = Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, var_60_25)
								local var_60_27 = Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, var_60_25)
								local var_60_28 = Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, var_60_25)

								iter_60_7.color = Color.New(var_60_26, var_60_27, var_60_28)
							else
								local var_60_29 = Mathf.Lerp(iter_60_7.color.r, 0.5, var_60_25)

								iter_60_7.color = Color.New(var_60_29, var_60_29, var_60_29)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.actorSpriteComps10064 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_60_9 then
						if arg_57_1.isInRecall_ then
							iter_60_9.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10064 = nil
			end

			local var_60_30 = 0
			local var_60_31 = 1

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_32 = arg_57_1:FormatText(StoryNameCfg[595].name)

				arg_57_1.leftNameTxt_.text = var_60_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_33 = arg_57_1:GetWordFromCfg(410101013)
				local var_60_34 = arg_57_1:FormatText(var_60_33.content)

				arg_57_1.text_.text = var_60_34

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_35 = 40
				local var_60_36 = utf8.len(var_60_34)
				local var_60_37 = var_60_35 <= 0 and var_60_31 or var_60_31 * (var_60_36 / var_60_35)

				if var_60_37 > 0 and var_60_31 < var_60_37 then
					arg_57_1.talkMaxDuration = var_60_37

					if var_60_37 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_37 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_34
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101013", "story_v_out_410101.awb") ~= 0 then
					local var_60_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101013", "story_v_out_410101.awb") / 1000

					if var_60_38 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_38 + var_60_30
					end

					if var_60_33.prefab_name ~= "" and arg_57_1.actors_[var_60_33.prefab_name] ~= nil then
						local var_60_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_33.prefab_name].transform, "story_v_out_410101", "410101013", "story_v_out_410101.awb")

						arg_57_1:RecordAudio("410101013", var_60_39)
						arg_57_1:RecordAudio("410101013", var_60_39)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_410101", "410101013", "story_v_out_410101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_410101", "410101013", "story_v_out_410101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_40 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_40 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_40

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_40 and arg_57_1.time_ < var_60_30 + var_60_40 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410101014
		arg_61_1.duration_ = 17.17

		local var_61_0 = {
			zh = 9.666,
			ja = 17.166
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
				arg_61_0:Play410101015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.05

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[595].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(410101014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101014", "story_v_out_410101.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101014", "story_v_out_410101.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_410101", "410101014", "story_v_out_410101.awb")

						arg_61_1:RecordAudio("410101014", var_64_9)
						arg_61_1:RecordAudio("410101014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410101", "410101014", "story_v_out_410101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410101", "410101014", "story_v_out_410101.awb")
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
	Play410101015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410101015
		arg_65_1.duration_ = 15.63

		local var_65_0 = {
			zh = 12.5,
			ja = 15.633
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
				arg_65_0:Play410101016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.25

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[595].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(410101015)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101015", "story_v_out_410101.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101015", "story_v_out_410101.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_410101", "410101015", "story_v_out_410101.awb")

						arg_65_1:RecordAudio("410101015", var_68_9)
						arg_65_1:RecordAudio("410101015", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410101", "410101015", "story_v_out_410101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410101", "410101015", "story_v_out_410101.awb")
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
	Play410101016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410101016
		arg_69_1.duration_ = 11.23

		local var_69_0 = {
			zh = 6.1,
			ja = 11.233
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
				arg_69_0:Play410101017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1012"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1012 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1012", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-390, -465, 300)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1012, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_72_7 = arg_69_1.actors_["1012"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1012 == nil then
				arg_69_1.var_.actorSpriteComps1012 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1012 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor2.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor2.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor2.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 0.5, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1012 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1012 = nil
			end

			local var_72_15 = arg_69_1.actors_["10064"].transform
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.var_.moveOldPos10064 = var_72_15.localPosition
				var_72_15.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10064", 4)

				local var_72_17 = var_72_15.childCount

				for iter_72_5 = 0, var_72_17 - 1 do
					local var_72_18 = var_72_15:GetChild(iter_72_5)

					if var_72_18.name == "" or not string.find(var_72_18.name, "split") then
						var_72_18.gameObject:SetActive(true)
					else
						var_72_18.gameObject:SetActive(false)
					end
				end
			end

			local var_72_19 = 0.001

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_19 then
				local var_72_20 = (arg_69_1.time_ - var_72_16) / var_72_19
				local var_72_21 = Vector3.New(390, -570, 192.5)

				var_72_15.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10064, var_72_21, var_72_20)
			end

			if arg_69_1.time_ >= var_72_16 + var_72_19 and arg_69_1.time_ < var_72_16 + var_72_19 + arg_72_0 then
				var_72_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_72_22 = arg_69_1.actors_["10064"]
			local var_72_23 = 0

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10064 == nil then
				arg_69_1.var_.actorSpriteComps10064 = var_72_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_24 = 0.034

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 and not isNil(var_72_22) then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24

				if arg_69_1.var_.actorSpriteComps10064 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								local var_72_26 = Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor1.r, var_72_25)
								local var_72_27 = Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor1.g, var_72_25)
								local var_72_28 = Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor1.b, var_72_25)

								iter_72_7.color = Color.New(var_72_26, var_72_27, var_72_28)
							else
								local var_72_29 = Mathf.Lerp(iter_72_7.color.r, 1, var_72_25)

								iter_72_7.color = Color.New(var_72_29, var_72_29, var_72_29)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10064 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_72_9 then
						if arg_69_1.isInRecall_ then
							iter_72_9.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10064 = nil
			end

			local var_72_30 = 0
			local var_72_31 = 0.65

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[584].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(410101016)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 26
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101016", "story_v_out_410101.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101016", "story_v_out_410101.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_410101", "410101016", "story_v_out_410101.awb")

						arg_69_1:RecordAudio("410101016", var_72_39)
						arg_69_1:RecordAudio("410101016", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410101", "410101016", "story_v_out_410101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410101", "410101016", "story_v_out_410101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410101017
		arg_73_1.duration_ = 11.73

		local var_73_0 = {
			zh = 4,
			ja = 11.733
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
				arg_73_0:Play410101018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1012"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1012", 2)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(-390, -465, 300)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_76_7 = arg_73_1.actors_["1012"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1012 == nil then
				arg_73_1.var_.actorSpriteComps1012 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 0.034

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps1012 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 1, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps1012 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1012 = nil
			end

			local var_76_15 = arg_73_1.actors_["10064"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10064 == nil then
				arg_73_1.var_.actorSpriteComps10064 = var_76_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_17 = 0.034

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.actorSpriteComps10064 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								local var_76_19 = Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor2.r, var_76_18)
								local var_76_20 = Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor2.g, var_76_18)
								local var_76_21 = Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor2.b, var_76_18)

								iter_76_6.color = Color.New(var_76_19, var_76_20, var_76_21)
							else
								local var_76_22 = Mathf.Lerp(iter_76_6.color.r, 0.5, var_76_18)

								iter_76_6.color = Color.New(var_76_22, var_76_22, var_76_22)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10064 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_76_8 then
						if arg_73_1.isInRecall_ then
							iter_76_8.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10064 = nil
			end

			local var_76_23 = 0
			local var_76_24 = 0.475

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[595].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(410101017)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 19
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_24 or var_76_24 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_24 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_23
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101017", "story_v_out_410101.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101017", "story_v_out_410101.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_410101", "410101017", "story_v_out_410101.awb")

						arg_73_1:RecordAudio("410101017", var_76_32)
						arg_73_1:RecordAudio("410101017", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_410101", "410101017", "story_v_out_410101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_410101", "410101017", "story_v_out_410101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = math.max(var_76_24, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_33 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_33

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_33 and arg_73_1.time_ < var_76_23 + var_76_33 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play410101018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410101018
		arg_77_1.duration_ = 20.77

		local var_77_0 = {
			zh = 8.433,
			ja = 20.766
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
				arg_77_0:Play410101019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1012"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1012 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1012", 2)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_1" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(-390, -465, 300)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1012, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_80_7 = arg_77_1.actors_["1012"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps1012 == nil then
				arg_77_1.var_.actorSpriteComps1012 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps1012 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor2.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor2.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor2.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 0.5, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps1012 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1012 = nil
			end

			local var_80_15 = arg_77_1.actors_["10064"].transform
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.var_.moveOldPos10064 = var_80_15.localPosition
				var_80_15.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10064", 4)

				local var_80_17 = var_80_15.childCount

				for iter_80_5 = 0, var_80_17 - 1 do
					local var_80_18 = var_80_15:GetChild(iter_80_5)

					if var_80_18.name == "" or not string.find(var_80_18.name, "split") then
						var_80_18.gameObject:SetActive(true)
					else
						var_80_18.gameObject:SetActive(false)
					end
				end
			end

			local var_80_19 = 0.001

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_19 then
				local var_80_20 = (arg_77_1.time_ - var_80_16) / var_80_19
				local var_80_21 = Vector3.New(390, -570, 192.5)

				var_80_15.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10064, var_80_21, var_80_20)
			end

			if arg_77_1.time_ >= var_80_16 + var_80_19 and arg_77_1.time_ < var_80_16 + var_80_19 + arg_80_0 then
				var_80_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_80_22 = arg_77_1.actors_["10064"]
			local var_80_23 = 0

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.actorSpriteComps10064 == nil then
				arg_77_1.var_.actorSpriteComps10064 = var_80_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_24 = 0.034

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_24 and not isNil(var_80_22) then
				local var_80_25 = (arg_77_1.time_ - var_80_23) / var_80_24

				if arg_77_1.var_.actorSpriteComps10064 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								local var_80_26 = Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor1.r, var_80_25)
								local var_80_27 = Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor1.g, var_80_25)
								local var_80_28 = Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor1.b, var_80_25)

								iter_80_7.color = Color.New(var_80_26, var_80_27, var_80_28)
							else
								local var_80_29 = Mathf.Lerp(iter_80_7.color.r, 1, var_80_25)

								iter_80_7.color = Color.New(var_80_29, var_80_29, var_80_29)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_23 + var_80_24 and arg_77_1.time_ < var_80_23 + var_80_24 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.actorSpriteComps10064 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_80_9 then
						if arg_77_1.isInRecall_ then
							iter_80_9.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10064 = nil
			end

			local var_80_30 = 0
			local var_80_31 = 1.025

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_32 = arg_77_1:FormatText(StoryNameCfg[584].name)

				arg_77_1.leftNameTxt_.text = var_80_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_33 = arg_77_1:GetWordFromCfg(410101018)
				local var_80_34 = arg_77_1:FormatText(var_80_33.content)

				arg_77_1.text_.text = var_80_34

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_35 = 41
				local var_80_36 = utf8.len(var_80_34)
				local var_80_37 = var_80_35 <= 0 and var_80_31 or var_80_31 * (var_80_36 / var_80_35)

				if var_80_37 > 0 and var_80_31 < var_80_37 then
					arg_77_1.talkMaxDuration = var_80_37

					if var_80_37 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_30
					end
				end

				arg_77_1.text_.text = var_80_34
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101018", "story_v_out_410101.awb") ~= 0 then
					local var_80_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101018", "story_v_out_410101.awb") / 1000

					if var_80_38 + var_80_30 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_38 + var_80_30
					end

					if var_80_33.prefab_name ~= "" and arg_77_1.actors_[var_80_33.prefab_name] ~= nil then
						local var_80_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_33.prefab_name].transform, "story_v_out_410101", "410101018", "story_v_out_410101.awb")

						arg_77_1:RecordAudio("410101018", var_80_39)
						arg_77_1:RecordAudio("410101018", var_80_39)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410101", "410101018", "story_v_out_410101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410101", "410101018", "story_v_out_410101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_40 = math.max(var_80_31, arg_77_1.talkMaxDuration)

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_40 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_30) / var_80_40

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_30 + var_80_40 and arg_77_1.time_ < var_80_30 + var_80_40 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410101019
		arg_81_1.duration_ = 13

		local var_81_0 = {
			zh = 5.2,
			ja = 13
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play410101020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.675

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[584].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(410101019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 27
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101019", "story_v_out_410101.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101019", "story_v_out_410101.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_410101", "410101019", "story_v_out_410101.awb")

						arg_81_1:RecordAudio("410101019", var_84_9)
						arg_81_1:RecordAudio("410101019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410101", "410101019", "story_v_out_410101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410101", "410101019", "story_v_out_410101.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play410101020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410101020
		arg_85_1.duration_ = 6.63

		local var_85_0 = {
			zh = 6.633,
			ja = 4.966
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
				arg_85_0:Play410101021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1012"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1012 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1012", 2)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_1" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(-390, -465, 300)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1012, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_88_7 = arg_85_1.actors_["1012"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1012 == nil then
				arg_85_1.var_.actorSpriteComps1012 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps1012 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps1012 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1012 = nil
			end

			local var_88_15 = arg_85_1.actors_["10064"].transform
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.var_.moveOldPos10064 = var_88_15.localPosition
				var_88_15.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10064", 4)

				local var_88_17 = var_88_15.childCount

				for iter_88_5 = 0, var_88_17 - 1 do
					local var_88_18 = var_88_15:GetChild(iter_88_5)

					if var_88_18.name == "" or not string.find(var_88_18.name, "split") then
						var_88_18.gameObject:SetActive(true)
					else
						var_88_18.gameObject:SetActive(false)
					end
				end
			end

			local var_88_19 = 0.001

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_19 then
				local var_88_20 = (arg_85_1.time_ - var_88_16) / var_88_19
				local var_88_21 = Vector3.New(390, -570, 192.5)

				var_88_15.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10064, var_88_21, var_88_20)
			end

			if arg_85_1.time_ >= var_88_16 + var_88_19 and arg_85_1.time_ < var_88_16 + var_88_19 + arg_88_0 then
				var_88_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_88_22 = arg_85_1.actors_["10064"]
			local var_88_23 = 0

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 and not isNil(var_88_22) and arg_85_1.var_.actorSpriteComps10064 == nil then
				arg_85_1.var_.actorSpriteComps10064 = var_88_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_24 = 0.034

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_24 and not isNil(var_88_22) then
				local var_88_25 = (arg_85_1.time_ - var_88_23) / var_88_24

				if arg_85_1.var_.actorSpriteComps10064 then
					for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_88_7 then
							if arg_85_1.isInRecall_ then
								local var_88_26 = Mathf.Lerp(iter_88_7.color.r, arg_85_1.hightColor2.r, var_88_25)
								local var_88_27 = Mathf.Lerp(iter_88_7.color.g, arg_85_1.hightColor2.g, var_88_25)
								local var_88_28 = Mathf.Lerp(iter_88_7.color.b, arg_85_1.hightColor2.b, var_88_25)

								iter_88_7.color = Color.New(var_88_26, var_88_27, var_88_28)
							else
								local var_88_29 = Mathf.Lerp(iter_88_7.color.r, 0.5, var_88_25)

								iter_88_7.color = Color.New(var_88_29, var_88_29, var_88_29)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_23 + var_88_24 and arg_85_1.time_ < var_88_23 + var_88_24 + arg_88_0 and not isNil(var_88_22) and arg_85_1.var_.actorSpriteComps10064 then
				for iter_88_8, iter_88_9 in pairs(arg_85_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_88_9 then
						if arg_85_1.isInRecall_ then
							iter_88_9.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10064 = nil
			end

			local var_88_30 = 0
			local var_88_31 = 0.725

			if var_88_30 < arg_85_1.time_ and arg_85_1.time_ <= var_88_30 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_32 = arg_85_1:FormatText(StoryNameCfg[595].name)

				arg_85_1.leftNameTxt_.text = var_88_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_33 = arg_85_1:GetWordFromCfg(410101020)
				local var_88_34 = arg_85_1:FormatText(var_88_33.content)

				arg_85_1.text_.text = var_88_34

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_35 = 29
				local var_88_36 = utf8.len(var_88_34)
				local var_88_37 = var_88_35 <= 0 and var_88_31 or var_88_31 * (var_88_36 / var_88_35)

				if var_88_37 > 0 and var_88_31 < var_88_37 then
					arg_85_1.talkMaxDuration = var_88_37

					if var_88_37 + var_88_30 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_37 + var_88_30
					end
				end

				arg_85_1.text_.text = var_88_34
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101020", "story_v_out_410101.awb") ~= 0 then
					local var_88_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101020", "story_v_out_410101.awb") / 1000

					if var_88_38 + var_88_30 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_38 + var_88_30
					end

					if var_88_33.prefab_name ~= "" and arg_85_1.actors_[var_88_33.prefab_name] ~= nil then
						local var_88_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_33.prefab_name].transform, "story_v_out_410101", "410101020", "story_v_out_410101.awb")

						arg_85_1:RecordAudio("410101020", var_88_39)
						arg_85_1:RecordAudio("410101020", var_88_39)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410101", "410101020", "story_v_out_410101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410101", "410101020", "story_v_out_410101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_40 = math.max(var_88_31, arg_85_1.talkMaxDuration)

			if var_88_30 <= arg_85_1.time_ and arg_85_1.time_ < var_88_30 + var_88_40 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_30) / var_88_40

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_30 + var_88_40 and arg_85_1.time_ < var_88_30 + var_88_40 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play410101021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410101021
		arg_89_1.duration_ = 11.07

		local var_89_0 = {
			zh = 5.5,
			ja = 11.066
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
				arg_89_0:Play410101022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.575

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[595].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:GetWordFromCfg(410101021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 23
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101021", "story_v_out_410101.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101021", "story_v_out_410101.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_410101", "410101021", "story_v_out_410101.awb")

						arg_89_1:RecordAudio("410101021", var_92_9)
						arg_89_1:RecordAudio("410101021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410101", "410101021", "story_v_out_410101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410101", "410101021", "story_v_out_410101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play410101022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410101022
		arg_93_1.duration_ = 13.57

		local var_93_0 = {
			zh = 3.2,
			ja = 13.566
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
				arg_93_0:Play410101023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1012"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1012", 2)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_1" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(-390, -465, 300)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_96_7 = arg_93_1.actors_["1012"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps1012 == nil then
				arg_93_1.var_.actorSpriteComps1012 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 0.034

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps1012 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps1012 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1012 = nil
			end

			local var_96_15 = arg_93_1.actors_["10064"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos10064 = var_96_15.localPosition
				var_96_15.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10064", 4)

				local var_96_17 = var_96_15.childCount

				for iter_96_5 = 0, var_96_17 - 1 do
					local var_96_18 = var_96_15:GetChild(iter_96_5)

					if var_96_18.name == "" or not string.find(var_96_18.name, "split") then
						var_96_18.gameObject:SetActive(true)
					else
						var_96_18.gameObject:SetActive(false)
					end
				end
			end

			local var_96_19 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_19 then
				local var_96_20 = (arg_93_1.time_ - var_96_16) / var_96_19
				local var_96_21 = Vector3.New(390, -570, 192.5)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10064, var_96_21, var_96_20)
			end

			if arg_93_1.time_ >= var_96_16 + var_96_19 and arg_93_1.time_ < var_96_16 + var_96_19 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_96_22 = arg_93_1.actors_["10064"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10064 == nil then
				arg_93_1.var_.actorSpriteComps10064 = var_96_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_24 = 0.034

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.actorSpriteComps10064 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								local var_96_26 = Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor1.r, var_96_25)
								local var_96_27 = Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor1.g, var_96_25)
								local var_96_28 = Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor1.b, var_96_25)

								iter_96_7.color = Color.New(var_96_26, var_96_27, var_96_28)
							else
								local var_96_29 = Mathf.Lerp(iter_96_7.color.r, 1, var_96_25)

								iter_96_7.color = Color.New(var_96_29, var_96_29, var_96_29)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10064 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_96_9 then
						if arg_93_1.isInRecall_ then
							iter_96_9.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10064 = nil
			end

			local var_96_30 = 0
			local var_96_31 = 0.45

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[584].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(410101022)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 18
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101022", "story_v_out_410101.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101022", "story_v_out_410101.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_410101", "410101022", "story_v_out_410101.awb")

						arg_93_1:RecordAudio("410101022", var_96_39)
						arg_93_1:RecordAudio("410101022", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410101", "410101022", "story_v_out_410101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410101", "410101022", "story_v_out_410101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410101023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play410101024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_1 = 0.5

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_1 then
				local var_100_2 = (arg_97_1.time_ - var_100_0) / var_100_1
				local var_100_3 = Color.New(1, 1, 1)

				var_100_3.a = Mathf.Lerp(1, 0, var_100_2)
				arg_97_1.mask_.color = var_100_3
			end

			if arg_97_1.time_ >= var_100_0 + var_100_1 and arg_97_1.time_ < var_100_0 + var_100_1 + arg_100_0 then
				local var_100_4 = Color.New(1, 1, 1)
				local var_100_5 = 0

				arg_97_1.mask_.enabled = false
				var_100_4.a = var_100_5
				arg_97_1.mask_.color = var_100_4
			end

			local var_100_6 = arg_97_1.actors_["1012"].transform
			local var_100_7 = 0

			if var_100_7 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.var_.moveOldPos1012 = var_100_6.localPosition
				var_100_6.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1012", 7)

				local var_100_8 = var_100_6.childCount

				for iter_100_0 = 0, var_100_8 - 1 do
					local var_100_9 = var_100_6:GetChild(iter_100_0)

					if var_100_9.name == "split_1" or not string.find(var_100_9.name, "split") then
						var_100_9.gameObject:SetActive(true)
					else
						var_100_9.gameObject:SetActive(false)
					end
				end
			end

			local var_100_10 = 0.001

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_10 then
				local var_100_11 = (arg_97_1.time_ - var_100_7) / var_100_10
				local var_100_12 = Vector3.New(0, -2000, 300)

				var_100_6.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1012, var_100_12, var_100_11)
			end

			if arg_97_1.time_ >= var_100_7 + var_100_10 and arg_97_1.time_ < var_100_7 + var_100_10 + arg_100_0 then
				var_100_6.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_100_13 = arg_97_1.actors_["10064"].transform
			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1.var_.moveOldPos10064 = var_100_13.localPosition
				var_100_13.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10064", 7)

				local var_100_15 = var_100_13.childCount

				for iter_100_1 = 0, var_100_15 - 1 do
					local var_100_16 = var_100_13:GetChild(iter_100_1)

					if var_100_16.name == "" or not string.find(var_100_16.name, "split") then
						var_100_16.gameObject:SetActive(true)
					else
						var_100_16.gameObject:SetActive(false)
					end
				end
			end

			local var_100_17 = 0.001

			if var_100_14 <= arg_97_1.time_ and arg_97_1.time_ < var_100_14 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_14) / var_100_17
				local var_100_19 = Vector3.New(0, -2000, 192.5)

				var_100_13.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10064, var_100_19, var_100_18)
			end

			if arg_97_1.time_ >= var_100_14 + var_100_17 and arg_97_1.time_ < var_100_14 + var_100_17 + arg_100_0 then
				var_100_13.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_100_20 = 0
			local var_100_21 = 1.2

			if var_100_20 < arg_97_1.time_ and arg_97_1.time_ <= var_100_20 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_22 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_22:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_23 = arg_97_1:GetWordFromCfg(410101023)
				local var_100_24 = arg_97_1:FormatText(var_100_23.content)

				arg_97_1.text_.text = var_100_24

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_25 = 48
				local var_100_26 = utf8.len(var_100_24)
				local var_100_27 = var_100_25 <= 0 and var_100_21 or var_100_21 * (var_100_26 / var_100_25)

				if var_100_27 > 0 and var_100_21 < var_100_27 then
					arg_97_1.talkMaxDuration = var_100_27
					var_100_20 = var_100_20 + 0.3

					if var_100_27 + var_100_20 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_27 + var_100_20
					end
				end

				arg_97_1.text_.text = var_100_24
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_28 = var_100_20 + 0.3
			local var_100_29 = math.max(var_100_21, arg_97_1.talkMaxDuration)

			if var_100_28 <= arg_97_1.time_ and arg_97_1.time_ < var_100_28 + var_100_29 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_28) / var_100_29

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_28 + var_100_29 and arg_97_1.time_ < var_100_28 + var_100_29 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410101024
		arg_103_1.duration_ = 5.23

		local var_103_0 = {
			zh = 2.266,
			ja = 5.233
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
				arg_103_0:Play410101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1012"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1012 = var_106_0.localPosition
				var_106_0.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1012", 2)

				local var_106_2 = var_106_0.childCount

				for iter_106_0 = 0, var_106_2 - 1 do
					local var_106_3 = var_106_0:GetChild(iter_106_0)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_4 then
				local var_106_5 = (arg_103_1.time_ - var_106_1) / var_106_4
				local var_106_6 = Vector3.New(-390, -465, 300)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1012, var_106_6, var_106_5)
			end

			if arg_103_1.time_ >= var_106_1 + var_106_4 and arg_103_1.time_ < var_106_1 + var_106_4 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_106_7 = arg_103_1.actors_["1012"]
			local var_106_8 = 0

			if var_106_8 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1012 == nil then
				arg_103_1.var_.actorSpriteComps1012 = var_106_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 0.034

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 and not isNil(var_106_7) then
				local var_106_10 = (arg_103_1.time_ - var_106_8) / var_106_9

				if arg_103_1.var_.actorSpriteComps1012 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								local var_106_11 = Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor1.r, var_106_10)
								local var_106_12 = Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor1.g, var_106_10)
								local var_106_13 = Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor1.b, var_106_10)

								iter_106_2.color = Color.New(var_106_11, var_106_12, var_106_13)
							else
								local var_106_14 = Mathf.Lerp(iter_106_2.color.r, 1, var_106_10)

								iter_106_2.color = Color.New(var_106_14, var_106_14, var_106_14)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 and not isNil(var_106_7) and arg_103_1.var_.actorSpriteComps1012 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_106_4 then
						if arg_103_1.isInRecall_ then
							iter_106_4.color = arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_106_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_103_1.var_.actorSpriteComps1012 = nil
			end

			local var_106_15 = 0
			local var_106_16 = 0.125

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[595].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(410101024)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 5
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101024", "story_v_out_410101.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101024", "story_v_out_410101.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_out_410101", "410101024", "story_v_out_410101.awb")

						arg_103_1:RecordAudio("410101024", var_106_24)
						arg_103_1:RecordAudio("410101024", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410101", "410101024", "story_v_out_410101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410101", "410101024", "story_v_out_410101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play410101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410101025
		arg_107_1.duration_ = 4.8

		local var_107_0 = {
			zh = 2.366,
			ja = 4.8
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
				arg_107_0:Play410101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1012"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1012 = var_110_0.localPosition
				var_110_0.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1012", 2)

				local var_110_2 = var_110_0.childCount

				for iter_110_0 = 0, var_110_2 - 1 do
					local var_110_3 = var_110_0:GetChild(iter_110_0)

					if var_110_3.name == "split_1" or not string.find(var_110_3.name, "split") then
						var_110_3.gameObject:SetActive(true)
					else
						var_110_3.gameObject:SetActive(false)
					end
				end
			end

			local var_110_4 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_4 then
				local var_110_5 = (arg_107_1.time_ - var_110_1) / var_110_4
				local var_110_6 = Vector3.New(-390, -465, 300)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1012, var_110_6, var_110_5)
			end

			if arg_107_1.time_ >= var_110_1 + var_110_4 and arg_107_1.time_ < var_110_1 + var_110_4 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_110_7 = arg_107_1.actors_["1012"]
			local var_110_8 = 0

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps1012 == nil then
				arg_107_1.var_.actorSpriteComps1012 = var_110_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_9 = 0.034

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_9 and not isNil(var_110_7) then
				local var_110_10 = (arg_107_1.time_ - var_110_8) / var_110_9

				if arg_107_1.var_.actorSpriteComps1012 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								local var_110_11 = Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor2.r, var_110_10)
								local var_110_12 = Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor2.g, var_110_10)
								local var_110_13 = Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor2.b, var_110_10)

								iter_110_2.color = Color.New(var_110_11, var_110_12, var_110_13)
							else
								local var_110_14 = Mathf.Lerp(iter_110_2.color.r, 0.5, var_110_10)

								iter_110_2.color = Color.New(var_110_14, var_110_14, var_110_14)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_8 + var_110_9 and arg_107_1.time_ < var_110_8 + var_110_9 + arg_110_0 and not isNil(var_110_7) and arg_107_1.var_.actorSpriteComps1012 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_110_4 then
						if arg_107_1.isInRecall_ then
							iter_110_4.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps1012 = nil
			end

			local var_110_15 = arg_107_1.actors_["10064"].transform
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 then
				arg_107_1.var_.moveOldPos10064 = var_110_15.localPosition
				var_110_15.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10064", 4)

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
				local var_110_21 = Vector3.New(390, -570, 192.5)

				var_110_15.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10064, var_110_21, var_110_20)
			end

			if arg_107_1.time_ >= var_110_16 + var_110_19 and arg_107_1.time_ < var_110_16 + var_110_19 + arg_110_0 then
				var_110_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_110_22 = arg_107_1.actors_["10064"]
			local var_110_23 = 0

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps10064 == nil then
				arg_107_1.var_.actorSpriteComps10064 = var_110_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_24 = 0.034

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_24 and not isNil(var_110_22) then
				local var_110_25 = (arg_107_1.time_ - var_110_23) / var_110_24

				if arg_107_1.var_.actorSpriteComps10064 then
					for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_110_7 then
							if arg_107_1.isInRecall_ then
								local var_110_26 = Mathf.Lerp(iter_110_7.color.r, arg_107_1.hightColor1.r, var_110_25)
								local var_110_27 = Mathf.Lerp(iter_110_7.color.g, arg_107_1.hightColor1.g, var_110_25)
								local var_110_28 = Mathf.Lerp(iter_110_7.color.b, arg_107_1.hightColor1.b, var_110_25)

								iter_110_7.color = Color.New(var_110_26, var_110_27, var_110_28)
							else
								local var_110_29 = Mathf.Lerp(iter_110_7.color.r, 1, var_110_25)

								iter_110_7.color = Color.New(var_110_29, var_110_29, var_110_29)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_23 + var_110_24 and arg_107_1.time_ < var_110_23 + var_110_24 + arg_110_0 and not isNil(var_110_22) and arg_107_1.var_.actorSpriteComps10064 then
				for iter_110_8, iter_110_9 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_110_9 then
						if arg_107_1.isInRecall_ then
							iter_110_9.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps10064 = nil
			end

			local var_110_30 = 0
			local var_110_31 = 0.3

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[584].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(410101025)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101025", "story_v_out_410101.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101025", "story_v_out_410101.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_410101", "410101025", "story_v_out_410101.awb")

						arg_107_1:RecordAudio("410101025", var_110_39)
						arg_107_1:RecordAudio("410101025", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_410101", "410101025", "story_v_out_410101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_410101", "410101025", "story_v_out_410101.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410101026
		arg_111_1.duration_ = 12.37

		local var_111_0 = {
			zh = 2.566,
			ja = 12.366
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
				arg_111_0:Play410101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1012"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1012 = var_114_0.localPosition
				var_114_0.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1012", 2)

				local var_114_2 = var_114_0.childCount

				for iter_114_0 = 0, var_114_2 - 1 do
					local var_114_3 = var_114_0:GetChild(iter_114_0)

					if var_114_3.name == "split_1" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_4 then
				local var_114_5 = (arg_111_1.time_ - var_114_1) / var_114_4
				local var_114_6 = Vector3.New(-390, -465, 300)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1012, var_114_6, var_114_5)
			end

			if arg_111_1.time_ >= var_114_1 + var_114_4 and arg_111_1.time_ < var_114_1 + var_114_4 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_114_7 = arg_111_1.actors_["1012"]
			local var_114_8 = 0

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1012 == nil then
				arg_111_1.var_.actorSpriteComps1012 = var_114_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_9 = 0.034

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_9 and not isNil(var_114_7) then
				local var_114_10 = (arg_111_1.time_ - var_114_8) / var_114_9

				if arg_111_1.var_.actorSpriteComps1012 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_111_1.time_ >= var_114_8 + var_114_9 and arg_111_1.time_ < var_114_8 + var_114_9 + arg_114_0 and not isNil(var_114_7) and arg_111_1.var_.actorSpriteComps1012 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_114_4 then
						if arg_111_1.isInRecall_ then
							iter_114_4.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps1012 = nil
			end

			local var_114_15 = arg_111_1.actors_["10064"].transform
			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.var_.moveOldPos10064 = var_114_15.localPosition
				var_114_15.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10064", 4)

				local var_114_17 = var_114_15.childCount

				for iter_114_5 = 0, var_114_17 - 1 do
					local var_114_18 = var_114_15:GetChild(iter_114_5)

					if var_114_18.name == "" or not string.find(var_114_18.name, "split") then
						var_114_18.gameObject:SetActive(true)
					else
						var_114_18.gameObject:SetActive(false)
					end
				end
			end

			local var_114_19 = 0.001

			if var_114_16 <= arg_111_1.time_ and arg_111_1.time_ < var_114_16 + var_114_19 then
				local var_114_20 = (arg_111_1.time_ - var_114_16) / var_114_19
				local var_114_21 = Vector3.New(390, -570, 192.5)

				var_114_15.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10064, var_114_21, var_114_20)
			end

			if arg_111_1.time_ >= var_114_16 + var_114_19 and arg_111_1.time_ < var_114_16 + var_114_19 + arg_114_0 then
				var_114_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_114_22 = arg_111_1.actors_["10064"]
			local var_114_23 = 0

			if var_114_23 < arg_111_1.time_ and arg_111_1.time_ <= var_114_23 + arg_114_0 and not isNil(var_114_22) and arg_111_1.var_.actorSpriteComps10064 == nil then
				arg_111_1.var_.actorSpriteComps10064 = var_114_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_24 = 0.034

			if var_114_23 <= arg_111_1.time_ and arg_111_1.time_ < var_114_23 + var_114_24 and not isNil(var_114_22) then
				local var_114_25 = (arg_111_1.time_ - var_114_23) / var_114_24

				if arg_111_1.var_.actorSpriteComps10064 then
					for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_114_7 then
							if arg_111_1.isInRecall_ then
								local var_114_26 = Mathf.Lerp(iter_114_7.color.r, arg_111_1.hightColor2.r, var_114_25)
								local var_114_27 = Mathf.Lerp(iter_114_7.color.g, arg_111_1.hightColor2.g, var_114_25)
								local var_114_28 = Mathf.Lerp(iter_114_7.color.b, arg_111_1.hightColor2.b, var_114_25)

								iter_114_7.color = Color.New(var_114_26, var_114_27, var_114_28)
							else
								local var_114_29 = Mathf.Lerp(iter_114_7.color.r, 0.5, var_114_25)

								iter_114_7.color = Color.New(var_114_29, var_114_29, var_114_29)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_23 + var_114_24 and arg_111_1.time_ < var_114_23 + var_114_24 + arg_114_0 and not isNil(var_114_22) and arg_111_1.var_.actorSpriteComps10064 then
				for iter_114_8, iter_114_9 in pairs(arg_111_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_114_9 then
						if arg_111_1.isInRecall_ then
							iter_114_9.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10064 = nil
			end

			local var_114_30 = 0
			local var_114_31 = 0.325

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_32 = arg_111_1:FormatText(StoryNameCfg[595].name)

				arg_111_1.leftNameTxt_.text = var_114_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(410101026)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 13
				local var_114_36 = utf8.len(var_114_34)
				local var_114_37 = var_114_35 <= 0 and var_114_31 or var_114_31 * (var_114_36 / var_114_35)

				if var_114_37 > 0 and var_114_31 < var_114_37 then
					arg_111_1.talkMaxDuration = var_114_37

					if var_114_37 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_37 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_34
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101026", "story_v_out_410101.awb") ~= 0 then
					local var_114_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101026", "story_v_out_410101.awb") / 1000

					if var_114_38 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_38 + var_114_30
					end

					if var_114_33.prefab_name ~= "" and arg_111_1.actors_[var_114_33.prefab_name] ~= nil then
						local var_114_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_33.prefab_name].transform, "story_v_out_410101", "410101026", "story_v_out_410101.awb")

						arg_111_1:RecordAudio("410101026", var_114_39)
						arg_111_1:RecordAudio("410101026", var_114_39)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410101", "410101026", "story_v_out_410101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410101", "410101026", "story_v_out_410101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_40 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_40 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_40

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_40 and arg_111_1.time_ < var_114_30 + var_114_40 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410101027
		arg_115_1.duration_ = 23.7

		local var_115_0 = {
			zh = 14.833,
			ja = 23.7
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
				arg_115_0:Play410101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 1.6

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[595].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(410101027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 64
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101027", "story_v_out_410101.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101027", "story_v_out_410101.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_410101", "410101027", "story_v_out_410101.awb")

						arg_115_1:RecordAudio("410101027", var_118_9)
						arg_115_1:RecordAudio("410101027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410101", "410101027", "story_v_out_410101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410101", "410101027", "story_v_out_410101.awb")
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
	Play410101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410101028
		arg_119_1.duration_ = 14.9

		local var_119_0 = {
			zh = 9.6,
			ja = 14.9
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
				arg_119_0:Play410101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.075

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_2 = arg_119_1:FormatText(StoryNameCfg[595].name)

				arg_119_1.leftNameTxt_.text = var_122_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:GetWordFromCfg(410101028)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101028", "story_v_out_410101.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101028", "story_v_out_410101.awb") / 1000

					if var_122_8 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_0
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_410101", "410101028", "story_v_out_410101.awb")

						arg_119_1:RecordAudio("410101028", var_122_9)
						arg_119_1:RecordAudio("410101028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410101", "410101028", "story_v_out_410101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410101", "410101028", "story_v_out_410101.awb")
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
	Play410101029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410101029
		arg_123_1.duration_ = 20.77

		local var_123_0 = {
			zh = 11.933,
			ja = 20.766
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
				arg_123_0:Play410101030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.475

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[595].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(410101029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 59
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101029", "story_v_out_410101.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101029", "story_v_out_410101.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_410101", "410101029", "story_v_out_410101.awb")

						arg_123_1:RecordAudio("410101029", var_126_9)
						arg_123_1:RecordAudio("410101029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410101", "410101029", "story_v_out_410101.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410101", "410101029", "story_v_out_410101.awb")
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
	Play410101030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410101030
		arg_127_1.duration_ = 7.97

		local var_127_0 = {
			zh = 7.966,
			ja = 7.8
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
				arg_127_0:Play410101031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1012"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos1012 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1012", 2)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "split_1" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(-390, -465, 300)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1012, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_130_7 = arg_127_1.actors_["1012"]
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps1012 == nil then
				arg_127_1.var_.actorSpriteComps1012 = var_130_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 and not isNil(var_130_7) then
				local var_130_10 = (arg_127_1.time_ - var_130_8) / var_130_9

				if arg_127_1.var_.actorSpriteComps1012 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								local var_130_11 = Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor2.r, var_130_10)
								local var_130_12 = Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor2.g, var_130_10)
								local var_130_13 = Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor2.b, var_130_10)

								iter_130_2.color = Color.New(var_130_11, var_130_12, var_130_13)
							else
								local var_130_14 = Mathf.Lerp(iter_130_2.color.r, 0.5, var_130_10)

								iter_130_2.color = Color.New(var_130_14, var_130_14, var_130_14)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.actorSpriteComps1012 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_130_4 then
						if arg_127_1.isInRecall_ then
							iter_130_4.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps1012 = nil
			end

			local var_130_15 = arg_127_1.actors_["10064"].transform
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.var_.moveOldPos10064 = var_130_15.localPosition
				var_130_15.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10064", 4)

				local var_130_17 = var_130_15.childCount

				for iter_130_5 = 0, var_130_17 - 1 do
					local var_130_18 = var_130_15:GetChild(iter_130_5)

					if var_130_18.name == "" or not string.find(var_130_18.name, "split") then
						var_130_18.gameObject:SetActive(true)
					else
						var_130_18.gameObject:SetActive(false)
					end
				end
			end

			local var_130_19 = 0.001

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_16) / var_130_19
				local var_130_21 = Vector3.New(390, -570, 192.5)

				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10064, var_130_21, var_130_20)
			end

			if arg_127_1.time_ >= var_130_16 + var_130_19 and arg_127_1.time_ < var_130_16 + var_130_19 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_130_22 = arg_127_1.actors_["10064"]
			local var_130_23 = 0

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.actorSpriteComps10064 == nil then
				arg_127_1.var_.actorSpriteComps10064 = var_130_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_24 = 0.034

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 and not isNil(var_130_22) then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24

				if arg_127_1.var_.actorSpriteComps10064 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								local var_130_26 = Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor1.r, var_130_25)
								local var_130_27 = Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor1.g, var_130_25)
								local var_130_28 = Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor1.b, var_130_25)

								iter_130_7.color = Color.New(var_130_26, var_130_27, var_130_28)
							else
								local var_130_29 = Mathf.Lerp(iter_130_7.color.r, 1, var_130_25)

								iter_130_7.color = Color.New(var_130_29, var_130_29, var_130_29)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.actorSpriteComps10064 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_130_9 then
						if arg_127_1.isInRecall_ then
							iter_130_9.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10064 = nil
			end

			local var_130_30 = 0
			local var_130_31 = 0.725

			if var_130_30 < arg_127_1.time_ and arg_127_1.time_ <= var_130_30 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_32 = arg_127_1:FormatText(StoryNameCfg[584].name)

				arg_127_1.leftNameTxt_.text = var_130_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_33 = arg_127_1:GetWordFromCfg(410101030)
				local var_130_34 = arg_127_1:FormatText(var_130_33.content)

				arg_127_1.text_.text = var_130_34

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_35 = 29
				local var_130_36 = utf8.len(var_130_34)
				local var_130_37 = var_130_35 <= 0 and var_130_31 or var_130_31 * (var_130_36 / var_130_35)

				if var_130_37 > 0 and var_130_31 < var_130_37 then
					arg_127_1.talkMaxDuration = var_130_37

					if var_130_37 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_37 + var_130_30
					end
				end

				arg_127_1.text_.text = var_130_34
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101030", "story_v_out_410101.awb") ~= 0 then
					local var_130_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101030", "story_v_out_410101.awb") / 1000

					if var_130_38 + var_130_30 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_38 + var_130_30
					end

					if var_130_33.prefab_name ~= "" and arg_127_1.actors_[var_130_33.prefab_name] ~= nil then
						local var_130_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_33.prefab_name].transform, "story_v_out_410101", "410101030", "story_v_out_410101.awb")

						arg_127_1:RecordAudio("410101030", var_130_39)
						arg_127_1:RecordAudio("410101030", var_130_39)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410101", "410101030", "story_v_out_410101.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410101", "410101030", "story_v_out_410101.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_40 = math.max(var_130_31, arg_127_1.talkMaxDuration)

			if var_130_30 <= arg_127_1.time_ and arg_127_1.time_ < var_130_30 + var_130_40 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_30) / var_130_40

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_30 + var_130_40 and arg_127_1.time_ < var_130_30 + var_130_40 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410101031
		arg_131_1.duration_ = 5.27

		local var_131_0 = {
			zh = 5.266,
			ja = 3.766
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
				arg_131_0:Play410101032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.55

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[584].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(410101031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 22
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101031", "story_v_out_410101.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101031", "story_v_out_410101.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_410101", "410101031", "story_v_out_410101.awb")

						arg_131_1:RecordAudio("410101031", var_134_9)
						arg_131_1:RecordAudio("410101031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410101", "410101031", "story_v_out_410101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410101", "410101031", "story_v_out_410101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play410101032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410101032
		arg_135_1.duration_ = 8.9

		local var_135_0 = {
			zh = 1.733,
			ja = 8.9
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
				arg_135_0:Play410101033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1012"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1012 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1012", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_3" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -465, 300)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1012, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_138_7 = arg_135_1.actors_["1012"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1012 == nil then
				arg_135_1.var_.actorSpriteComps1012 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 0.034

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps1012 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps1012 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps1012 = nil
			end

			local var_138_15 = arg_135_1.actors_["10064"].transform
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.var_.moveOldPos10064 = var_138_15.localPosition
				var_138_15.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10064", 4)

				local var_138_17 = var_138_15.childCount

				for iter_138_5 = 0, var_138_17 - 1 do
					local var_138_18 = var_138_15:GetChild(iter_138_5)

					if var_138_18.name == "" or not string.find(var_138_18.name, "split") then
						var_138_18.gameObject:SetActive(true)
					else
						var_138_18.gameObject:SetActive(false)
					end
				end
			end

			local var_138_19 = 0.001

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_19 then
				local var_138_20 = (arg_135_1.time_ - var_138_16) / var_138_19
				local var_138_21 = Vector3.New(390, -570, 192.5)

				var_138_15.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10064, var_138_21, var_138_20)
			end

			if arg_135_1.time_ >= var_138_16 + var_138_19 and arg_135_1.time_ < var_138_16 + var_138_19 + arg_138_0 then
				var_138_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_138_22 = arg_135_1.actors_["10064"]
			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10064 == nil then
				arg_135_1.var_.actorSpriteComps10064 = var_138_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_24 = 0.034

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 and not isNil(var_138_22) then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24

				if arg_135_1.var_.actorSpriteComps10064 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								local var_138_26 = Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, var_138_25)
								local var_138_27 = Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, var_138_25)
								local var_138_28 = Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, var_138_25)

								iter_138_7.color = Color.New(var_138_26, var_138_27, var_138_28)
							else
								local var_138_29 = Mathf.Lerp(iter_138_7.color.r, 0.5, var_138_25)

								iter_138_7.color = Color.New(var_138_29, var_138_29, var_138_29)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10064 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_138_9 then
						if arg_135_1.isInRecall_ then
							iter_138_9.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10064 = nil
			end

			local var_138_30 = 0
			local var_138_31 = 0.2

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_32 = arg_135_1:FormatText(StoryNameCfg[595].name)

				arg_135_1.leftNameTxt_.text = var_138_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_33 = arg_135_1:GetWordFromCfg(410101032)
				local var_138_34 = arg_135_1:FormatText(var_138_33.content)

				arg_135_1.text_.text = var_138_34

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_35 = 8
				local var_138_36 = utf8.len(var_138_34)
				local var_138_37 = var_138_35 <= 0 and var_138_31 or var_138_31 * (var_138_36 / var_138_35)

				if var_138_37 > 0 and var_138_31 < var_138_37 then
					arg_135_1.talkMaxDuration = var_138_37

					if var_138_37 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_37 + var_138_30
					end
				end

				arg_135_1.text_.text = var_138_34
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101032", "story_v_out_410101.awb") ~= 0 then
					local var_138_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101032", "story_v_out_410101.awb") / 1000

					if var_138_38 + var_138_30 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_38 + var_138_30
					end

					if var_138_33.prefab_name ~= "" and arg_135_1.actors_[var_138_33.prefab_name] ~= nil then
						local var_138_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_33.prefab_name].transform, "story_v_out_410101", "410101032", "story_v_out_410101.awb")

						arg_135_1:RecordAudio("410101032", var_138_39)
						arg_135_1:RecordAudio("410101032", var_138_39)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410101", "410101032", "story_v_out_410101.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410101", "410101032", "story_v_out_410101.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_40 = math.max(var_138_31, arg_135_1.talkMaxDuration)

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_40 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_30) / var_138_40

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_30 + var_138_40 and arg_135_1.time_ < var_138_30 + var_138_40 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410101033
		arg_139_1.duration_ = 2.73

		local var_139_0 = {
			zh = 1.3,
			ja = 2.733
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
				arg_139_0:Play410101034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1012"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1012 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1012", 2)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "split_1" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(-390, -465, 300)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1012, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_142_7 = arg_139_1.actors_["1012"]
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1012 == nil then
				arg_139_1.var_.actorSpriteComps1012 = var_142_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_9 = 0.034

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 and not isNil(var_142_7) then
				local var_142_10 = (arg_139_1.time_ - var_142_8) / var_142_9

				if arg_139_1.var_.actorSpriteComps1012 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								local var_142_11 = Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor2.r, var_142_10)
								local var_142_12 = Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor2.g, var_142_10)
								local var_142_13 = Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor2.b, var_142_10)

								iter_142_2.color = Color.New(var_142_11, var_142_12, var_142_13)
							else
								local var_142_14 = Mathf.Lerp(iter_142_2.color.r, 0.5, var_142_10)

								iter_142_2.color = Color.New(var_142_14, var_142_14, var_142_14)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 and not isNil(var_142_7) and arg_139_1.var_.actorSpriteComps1012 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_142_4 then
						if arg_139_1.isInRecall_ then
							iter_142_4.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps1012 = nil
			end

			local var_142_15 = arg_139_1.actors_["10064"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos10064 = var_142_15.localPosition
				var_142_15.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10064", 4)

				local var_142_17 = var_142_15.childCount

				for iter_142_5 = 0, var_142_17 - 1 do
					local var_142_18 = var_142_15:GetChild(iter_142_5)

					if var_142_18.name == "" or not string.find(var_142_18.name, "split") then
						var_142_18.gameObject:SetActive(true)
					else
						var_142_18.gameObject:SetActive(false)
					end
				end
			end

			local var_142_19 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_19 then
				local var_142_20 = (arg_139_1.time_ - var_142_16) / var_142_19
				local var_142_21 = Vector3.New(390, -570, 192.5)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10064, var_142_21, var_142_20)
			end

			if arg_139_1.time_ >= var_142_16 + var_142_19 and arg_139_1.time_ < var_142_16 + var_142_19 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_142_22 = arg_139_1.actors_["10064"]
			local var_142_23 = 0

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.actorSpriteComps10064 == nil then
				arg_139_1.var_.actorSpriteComps10064 = var_142_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_24 = 0.034

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_24 and not isNil(var_142_22) then
				local var_142_25 = (arg_139_1.time_ - var_142_23) / var_142_24

				if arg_139_1.var_.actorSpriteComps10064 then
					for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_142_7 then
							if arg_139_1.isInRecall_ then
								local var_142_26 = Mathf.Lerp(iter_142_7.color.r, arg_139_1.hightColor1.r, var_142_25)
								local var_142_27 = Mathf.Lerp(iter_142_7.color.g, arg_139_1.hightColor1.g, var_142_25)
								local var_142_28 = Mathf.Lerp(iter_142_7.color.b, arg_139_1.hightColor1.b, var_142_25)

								iter_142_7.color = Color.New(var_142_26, var_142_27, var_142_28)
							else
								local var_142_29 = Mathf.Lerp(iter_142_7.color.r, 1, var_142_25)

								iter_142_7.color = Color.New(var_142_29, var_142_29, var_142_29)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_23 + var_142_24 and arg_139_1.time_ < var_142_23 + var_142_24 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.actorSpriteComps10064 then
				for iter_142_8, iter_142_9 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_142_9 then
						if arg_139_1.isInRecall_ then
							iter_142_9.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10064 = nil
			end

			local var_142_30 = 0
			local var_142_31 = 0.125

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[584].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(410101033)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 5
				local var_142_36 = utf8.len(var_142_34)
				local var_142_37 = var_142_35 <= 0 and var_142_31 or var_142_31 * (var_142_36 / var_142_35)

				if var_142_37 > 0 and var_142_31 < var_142_37 then
					arg_139_1.talkMaxDuration = var_142_37

					if var_142_37 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_34
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101033", "story_v_out_410101.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101033", "story_v_out_410101.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_410101", "410101033", "story_v_out_410101.awb")

						arg_139_1:RecordAudio("410101033", var_142_39)
						arg_139_1:RecordAudio("410101033", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_410101", "410101033", "story_v_out_410101.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_410101", "410101033", "story_v_out_410101.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_40 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_40 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_40

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_40 and arg_139_1.time_ < var_142_30 + var_142_40 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410101034
		arg_143_1.duration_ = 12.9

		local var_143_0 = {
			zh = 5.6,
			ja = 12.9
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
				arg_143_0:Play410101035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1012"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1012 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1012", 2)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "split_1" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(-390, -465, 300)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1012, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_146_7 = arg_143_1.actors_["1012"]
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1012 == nil then
				arg_143_1.var_.actorSpriteComps1012 = var_146_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_9 = 0.034

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_9 and not isNil(var_146_7) then
				local var_146_10 = (arg_143_1.time_ - var_146_8) / var_146_9

				if arg_143_1.var_.actorSpriteComps1012 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_143_1.time_ >= var_146_8 + var_146_9 and arg_143_1.time_ < var_146_8 + var_146_9 + arg_146_0 and not isNil(var_146_7) and arg_143_1.var_.actorSpriteComps1012 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_146_4 then
						if arg_143_1.isInRecall_ then
							iter_146_4.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps1012 = nil
			end

			local var_146_15 = arg_143_1.actors_["10064"].transform
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.var_.moveOldPos10064 = var_146_15.localPosition
				var_146_15.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10064", 4)

				local var_146_17 = var_146_15.childCount

				for iter_146_5 = 0, var_146_17 - 1 do
					local var_146_18 = var_146_15:GetChild(iter_146_5)

					if var_146_18.name == "" or not string.find(var_146_18.name, "split") then
						var_146_18.gameObject:SetActive(true)
					else
						var_146_18.gameObject:SetActive(false)
					end
				end
			end

			local var_146_19 = 0.001

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_19 then
				local var_146_20 = (arg_143_1.time_ - var_146_16) / var_146_19
				local var_146_21 = Vector3.New(390, -570, 192.5)

				var_146_15.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10064, var_146_21, var_146_20)
			end

			if arg_143_1.time_ >= var_146_16 + var_146_19 and arg_143_1.time_ < var_146_16 + var_146_19 + arg_146_0 then
				var_146_15.localPosition = Vector3.New(390, -570, 192.5)
			end

			local var_146_22 = arg_143_1.actors_["10064"]
			local var_146_23 = 0

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10064 == nil then
				arg_143_1.var_.actorSpriteComps10064 = var_146_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_24 = 0.034

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 and not isNil(var_146_22) then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24

				if arg_143_1.var_.actorSpriteComps10064 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10064 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_146_9 then
						if arg_143_1.isInRecall_ then
							iter_146_9.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10064 = nil
			end

			local var_146_30 = 0
			local var_146_31 = 0.7

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[595].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(410101034)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101034", "story_v_out_410101.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101034", "story_v_out_410101.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_410101", "410101034", "story_v_out_410101.awb")

						arg_143_1:RecordAudio("410101034", var_146_39)
						arg_143_1:RecordAudio("410101034", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410101", "410101034", "story_v_out_410101.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410101", "410101034", "story_v_out_410101.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410101035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410101035
		arg_147_1.duration_ = 12.67

		local var_147_0 = {
			zh = 9.2,
			ja = 12.666
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
				arg_147_0:Play410101036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.05

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[595].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(410101035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101035", "story_v_out_410101.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101035", "story_v_out_410101.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_410101", "410101035", "story_v_out_410101.awb")

						arg_147_1:RecordAudio("410101035", var_150_9)
						arg_147_1:RecordAudio("410101035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410101", "410101035", "story_v_out_410101.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410101", "410101035", "story_v_out_410101.awb")
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
	Play410101036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410101036
		arg_151_1.duration_ = 15.3

		local var_151_0 = {
			zh = 5.8,
			ja = 15.3
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
				arg_151_0:Play410101037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.8

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[595].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(410101036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101036", "story_v_out_410101.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101036", "story_v_out_410101.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_410101", "410101036", "story_v_out_410101.awb")

						arg_151_1:RecordAudio("410101036", var_154_9)
						arg_151_1:RecordAudio("410101036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410101", "410101036", "story_v_out_410101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410101", "410101036", "story_v_out_410101.awb")
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
	Play410101037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410101037
		arg_155_1.duration_ = 18.87

		local var_155_0 = {
			zh = 10.833,
			ja = 18.866
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
				arg_155_0:Play410101038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.15

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[595].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(410101037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101037", "story_v_out_410101.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101037", "story_v_out_410101.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_410101", "410101037", "story_v_out_410101.awb")

						arg_155_1:RecordAudio("410101037", var_158_9)
						arg_155_1:RecordAudio("410101037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410101", "410101037", "story_v_out_410101.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410101", "410101037", "story_v_out_410101.awb")
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
	Play410101038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410101038
		arg_159_1.duration_ = 15.3

		local var_159_0 = {
			zh = 6.766,
			ja = 15.3
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
				arg_159_0:Play410101039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.775

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[595].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(410101038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101038", "story_v_out_410101.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101038", "story_v_out_410101.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_410101", "410101038", "story_v_out_410101.awb")

						arg_159_1:RecordAudio("410101038", var_162_9)
						arg_159_1:RecordAudio("410101038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_410101", "410101038", "story_v_out_410101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_410101", "410101038", "story_v_out_410101.awb")
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
	Play410101039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410101039
		arg_163_1.duration_ = 9

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play410101040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "L02g"

			if arg_163_1.bgs_[var_166_0] == nil then
				local var_166_1 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_166_0)
				var_166_1.name = var_166_0
				var_166_1.transform.parent = arg_163_1.stage_.transform
				var_166_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_[var_166_0] = var_166_1
			end

			local var_166_2 = 2

			if var_166_2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				local var_166_3 = manager.ui.mainCamera.transform.localPosition
				local var_166_4 = Vector3.New(0, 0, 10) + Vector3.New(var_166_3.x, var_166_3.y, 0)
				local var_166_5 = arg_163_1.bgs_.L02g

				var_166_5.transform.localPosition = var_166_4
				var_166_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_6 = var_166_5:GetComponent("SpriteRenderer")

				if var_166_6 and var_166_6.sprite then
					local var_166_7 = (var_166_5.transform.localPosition - var_166_3).z
					local var_166_8 = manager.ui.mainCameraCom_
					local var_166_9 = 2 * var_166_7 * Mathf.Tan(var_166_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_10 = var_166_9 * var_166_8.aspect
					local var_166_11 = var_166_6.sprite.bounds.size.x
					local var_166_12 = var_166_6.sprite.bounds.size.y
					local var_166_13 = var_166_10 / var_166_11
					local var_166_14 = var_166_9 / var_166_12
					local var_166_15 = var_166_14 < var_166_13 and var_166_13 or var_166_14

					var_166_5.transform.localScale = Vector3.New(var_166_15, var_166_15, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "L02g" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_17 = 2

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17
				local var_166_19 = Color.New(0, 0, 0)

				var_166_19.a = Mathf.Lerp(0, 1, var_166_18)
				arg_163_1.mask_.color = var_166_19
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				local var_166_20 = Color.New(0, 0, 0)

				var_166_20.a = 1
				arg_163_1.mask_.color = var_166_20
			end

			local var_166_21 = 2

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_22 = 2

			if var_166_21 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_22 then
				local var_166_23 = (arg_163_1.time_ - var_166_21) / var_166_22
				local var_166_24 = Color.New(0, 0, 0)

				var_166_24.a = Mathf.Lerp(1, 0, var_166_23)
				arg_163_1.mask_.color = var_166_24
			end

			if arg_163_1.time_ >= var_166_21 + var_166_22 and arg_163_1.time_ < var_166_21 + var_166_22 + arg_166_0 then
				local var_166_25 = Color.New(0, 0, 0)
				local var_166_26 = 0

				arg_163_1.mask_.enabled = false
				var_166_25.a = var_166_26
				arg_163_1.mask_.color = var_166_25
			end

			local var_166_27 = arg_163_1.actors_["1012"].transform
			local var_166_28 = 2

			if var_166_28 < arg_163_1.time_ and arg_163_1.time_ <= var_166_28 + arg_166_0 then
				arg_163_1.var_.moveOldPos1012 = var_166_27.localPosition
				var_166_27.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1012", 7)

				local var_166_29 = var_166_27.childCount

				for iter_166_2 = 0, var_166_29 - 1 do
					local var_166_30 = var_166_27:GetChild(iter_166_2)

					if var_166_30.name == "" or not string.find(var_166_30.name, "split") then
						var_166_30.gameObject:SetActive(true)
					else
						var_166_30.gameObject:SetActive(false)
					end
				end
			end

			local var_166_31 = 0.001

			if var_166_28 <= arg_163_1.time_ and arg_163_1.time_ < var_166_28 + var_166_31 then
				local var_166_32 = (arg_163_1.time_ - var_166_28) / var_166_31
				local var_166_33 = Vector3.New(0, -2000, 300)

				var_166_27.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1012, var_166_33, var_166_32)
			end

			if arg_163_1.time_ >= var_166_28 + var_166_31 and arg_163_1.time_ < var_166_28 + var_166_31 + arg_166_0 then
				var_166_27.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_166_34 = arg_163_1.actors_["10064"].transform
			local var_166_35 = 2

			if var_166_35 < arg_163_1.time_ and arg_163_1.time_ <= var_166_35 + arg_166_0 then
				arg_163_1.var_.moveOldPos10064 = var_166_34.localPosition
				var_166_34.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10064", 7)

				local var_166_36 = var_166_34.childCount

				for iter_166_3 = 0, var_166_36 - 1 do
					local var_166_37 = var_166_34:GetChild(iter_166_3)

					if var_166_37.name == "" or not string.find(var_166_37.name, "split") then
						var_166_37.gameObject:SetActive(true)
					else
						var_166_37.gameObject:SetActive(false)
					end
				end
			end

			local var_166_38 = 0.001

			if var_166_35 <= arg_163_1.time_ and arg_163_1.time_ < var_166_35 + var_166_38 then
				local var_166_39 = (arg_163_1.time_ - var_166_35) / var_166_38
				local var_166_40 = Vector3.New(0, -2000, 192.5)

				var_166_34.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10064, var_166_40, var_166_39)
			end

			if arg_163_1.time_ >= var_166_35 + var_166_38 and arg_163_1.time_ < var_166_35 + var_166_38 + arg_166_0 then
				var_166_34.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_166_41 = 2

			arg_163_1.isInRecall_ = false

			if var_166_41 < arg_163_1.time_ and arg_163_1.time_ <= var_166_41 + arg_166_0 then
				arg_163_1.screenFilterGo_:SetActive(false)

				for iter_166_4, iter_166_5 in pairs(arg_163_1.actors_) do
					local var_166_42 = iter_166_5:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_166_6, iter_166_7 in ipairs(var_166_42) do
						if iter_166_7.color.r > 0.51 then
							iter_166_7.color = Color.New(1, 1, 1)
						else
							iter_166_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_166_43 = 0.0339999999999998

			if var_166_41 <= arg_163_1.time_ and arg_163_1.time_ < var_166_41 + var_166_43 then
				local var_166_44 = (arg_163_1.time_ - var_166_41) / var_166_43

				arg_163_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_166_44)
			end

			if arg_163_1.time_ >= var_166_41 + var_166_43 and arg_163_1.time_ < var_166_41 + var_166_43 + arg_166_0 then
				arg_163_1.screenFilterEffect_.weight = 0
			end

			local var_166_45 = 0
			local var_166_46 = 0.133333333333333

			if var_166_45 < arg_163_1.time_ and arg_163_1.time_ <= var_166_45 + arg_166_0 then
				local var_166_47 = "play"
				local var_166_48 = "music"

				arg_163_1:AudioAction(var_166_47, var_166_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_166_49 = ""
				local var_166_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_166_50 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_50 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_50

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_50
						arg_163_1.bgmTxt2_.text = var_166_50
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_51 = 0.3
			local var_166_52 = 1

			if var_166_51 < arg_163_1.time_ and arg_163_1.time_ <= var_166_51 + arg_166_0 then
				local var_166_53 = "play"
				local var_166_54 = "music"

				arg_163_1:AudioAction(var_166_53, var_166_54, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_166_55 = ""
				local var_166_56 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if var_166_56 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_56 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_56

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_56
						arg_163_1.bgmTxt2_.text = var_166_56
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_57 = 4
			local var_166_58 = 1.25

			if var_166_57 < arg_163_1.time_ and arg_163_1.time_ <= var_166_57 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_59 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_59:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_163_1.dialogCg_.alpha = arg_169_0
				end))
				var_166_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_60 = arg_163_1:GetWordFromCfg(410101039)
				local var_166_61 = arg_163_1:FormatText(var_166_60.content)

				arg_163_1.text_.text = var_166_61

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_62 = 50
				local var_166_63 = utf8.len(var_166_61)
				local var_166_64 = var_166_62 <= 0 and var_166_58 or var_166_58 * (var_166_63 / var_166_62)

				if var_166_64 > 0 and var_166_58 < var_166_64 then
					arg_163_1.talkMaxDuration = var_166_64
					var_166_57 = var_166_57 + 0.3

					if var_166_64 + var_166_57 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_64 + var_166_57
					end
				end

				arg_163_1.text_.text = var_166_61
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_65 = var_166_57 + 0.3
			local var_166_66 = math.max(var_166_58, arg_163_1.talkMaxDuration)

			if var_166_65 <= arg_163_1.time_ and arg_163_1.time_ < var_166_65 + var_166_66 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_65) / var_166_66

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_65 + var_166_66 and arg_163_1.time_ < var_166_65 + var_166_66 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play410101040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 410101040
		arg_171_1.duration_ = 13.2

		local var_171_0 = {
			zh = 9,
			ja = 13.2
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
				arg_171_0:Play410101041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1060"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1060 = var_174_0.localPosition
				var_174_0.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1060", 3)

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
				local var_174_6 = Vector3.New(33.4, -430.8, 6.9)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1060, var_174_6, var_174_5)
			end

			if arg_171_1.time_ >= var_174_1 + var_174_4 and arg_171_1.time_ < var_174_1 + var_174_4 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_174_7 = arg_171_1.actors_["1060"]
			local var_174_8 = 0

			if var_174_8 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1060 == nil then
				arg_171_1.var_.actorSpriteComps1060 = var_174_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 0.034

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 and not isNil(var_174_7) then
				local var_174_10 = (arg_171_1.time_ - var_174_8) / var_174_9

				if arg_171_1.var_.actorSpriteComps1060 then
					for iter_174_1, iter_174_2 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_174_2 then
							if arg_171_1.isInRecall_ then
								local var_174_11 = Mathf.Lerp(iter_174_2.color.r, arg_171_1.hightColor1.r, var_174_10)
								local var_174_12 = Mathf.Lerp(iter_174_2.color.g, arg_171_1.hightColor1.g, var_174_10)
								local var_174_13 = Mathf.Lerp(iter_174_2.color.b, arg_171_1.hightColor1.b, var_174_10)

								iter_174_2.color = Color.New(var_174_11, var_174_12, var_174_13)
							else
								local var_174_14 = Mathf.Lerp(iter_174_2.color.r, 1, var_174_10)

								iter_174_2.color = Color.New(var_174_14, var_174_14, var_174_14)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.actorSpriteComps1060 then
				for iter_174_3, iter_174_4 in pairs(arg_171_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_174_4 then
						if arg_171_1.isInRecall_ then
							iter_174_4.color = arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_174_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_171_1.var_.actorSpriteComps1060 = nil
			end

			local var_174_15 = 0
			local var_174_16 = 1.05

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[584].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(410101040)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 42
				local var_174_21 = utf8.len(var_174_19)
				local var_174_22 = var_174_20 <= 0 and var_174_16 or var_174_16 * (var_174_21 / var_174_20)

				if var_174_22 > 0 and var_174_16 < var_174_22 then
					arg_171_1.talkMaxDuration = var_174_22

					if var_174_22 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_22 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_19
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101040", "story_v_out_410101.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101040", "story_v_out_410101.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_410101", "410101040", "story_v_out_410101.awb")

						arg_171_1:RecordAudio("410101040", var_174_24)
						arg_171_1:RecordAudio("410101040", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_410101", "410101040", "story_v_out_410101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_410101", "410101040", "story_v_out_410101.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_25 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_25 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_25

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_25 and arg_171_1.time_ < var_174_15 + var_174_25 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play410101041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410101041
		arg_175_1.duration_ = 16.77

		local var_175_0 = {
			zh = 13.533,
			ja = 16.766
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
				arg_175_0:Play410101042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 1.6

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

				local var_178_3 = arg_175_1:GetWordFromCfg(410101041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 64
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101041", "story_v_out_410101.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101041", "story_v_out_410101.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_410101", "410101041", "story_v_out_410101.awb")

						arg_175_1:RecordAudio("410101041", var_178_9)
						arg_175_1:RecordAudio("410101041", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410101", "410101041", "story_v_out_410101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410101", "410101041", "story_v_out_410101.awb")
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
	Play410101042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410101042
		arg_179_1.duration_ = 14.13

		local var_179_0 = {
			zh = 6.133,
			ja = 14.133
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
				arg_179_0:Play410101043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.725

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[584].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(410101042)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101042", "story_v_out_410101.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101042", "story_v_out_410101.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_410101", "410101042", "story_v_out_410101.awb")

						arg_179_1:RecordAudio("410101042", var_182_9)
						arg_179_1:RecordAudio("410101042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_410101", "410101042", "story_v_out_410101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_410101", "410101042", "story_v_out_410101.awb")
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
	Play410101043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410101043
		arg_183_1.duration_ = 18.07

		local var_183_0 = {
			zh = 10.7,
			ja = 18.066
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
				arg_183_0:Play410101044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 1.125

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[584].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(410101043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101043", "story_v_out_410101.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101043", "story_v_out_410101.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_410101", "410101043", "story_v_out_410101.awb")

						arg_183_1:RecordAudio("410101043", var_186_9)
						arg_183_1:RecordAudio("410101043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410101", "410101043", "story_v_out_410101.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410101", "410101043", "story_v_out_410101.awb")
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
	Play410101044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410101044
		arg_187_1.duration_ = 13.4

		local var_187_0 = {
			zh = 7.5,
			ja = 13.4
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
				arg_187_0:Play410101045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.75

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[584].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(410101044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101044", "story_v_out_410101.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101044", "story_v_out_410101.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_410101", "410101044", "story_v_out_410101.awb")

						arg_187_1:RecordAudio("410101044", var_190_9)
						arg_187_1:RecordAudio("410101044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410101", "410101044", "story_v_out_410101.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410101", "410101044", "story_v_out_410101.awb")
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
	Play410101045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410101045
		arg_191_1.duration_ = 14.33

		local var_191_0 = {
			zh = 7.766,
			ja = 14.333
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
				arg_191_0:Play410101046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.75

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[584].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(410101045)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 30
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101045", "story_v_out_410101.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101045", "story_v_out_410101.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_410101", "410101045", "story_v_out_410101.awb")

						arg_191_1:RecordAudio("410101045", var_194_9)
						arg_191_1:RecordAudio("410101045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_410101", "410101045", "story_v_out_410101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_410101", "410101045", "story_v_out_410101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play410101046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410101046
		arg_195_1.duration_ = 4.83

		local var_195_0 = {
			zh = 2.466,
			ja = 4.833
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
				arg_195_0:Play410101047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1060"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1060 = var_198_0.localPosition
				var_198_0.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1060", 2)

				local var_198_2 = var_198_0.childCount

				for iter_198_0 = 0, var_198_2 - 1 do
					local var_198_3 = var_198_0:GetChild(iter_198_0)

					if var_198_3.name == "" or not string.find(var_198_3.name, "split") then
						var_198_3.gameObject:SetActive(true)
					else
						var_198_3.gameObject:SetActive(false)
					end
				end
			end

			local var_198_4 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_4 then
				local var_198_5 = (arg_195_1.time_ - var_198_1) / var_198_4
				local var_198_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1060, var_198_6, var_198_5)
			end

			if arg_195_1.time_ >= var_198_1 + var_198_4 and arg_195_1.time_ < var_198_1 + var_198_4 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_198_7 = arg_195_1.actors_["1012"].transform
			local var_198_8 = 0

			if var_198_8 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.var_.moveOldPos1012 = var_198_7.localPosition
				var_198_7.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1012", 4)

				local var_198_9 = var_198_7.childCount

				for iter_198_1 = 0, var_198_9 - 1 do
					local var_198_10 = var_198_7:GetChild(iter_198_1)

					if var_198_10.name == "" or not string.find(var_198_10.name, "split") then
						var_198_10.gameObject:SetActive(true)
					else
						var_198_10.gameObject:SetActive(false)
					end
				end
			end

			local var_198_11 = 0.001

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_11 then
				local var_198_12 = (arg_195_1.time_ - var_198_8) / var_198_11
				local var_198_13 = Vector3.New(390, -465, 300)

				var_198_7.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1012, var_198_13, var_198_12)
			end

			if arg_195_1.time_ >= var_198_8 + var_198_11 and arg_195_1.time_ < var_198_8 + var_198_11 + arg_198_0 then
				var_198_7.localPosition = Vector3.New(390, -465, 300)
			end

			local var_198_14 = arg_195_1.actors_["1060"]
			local var_198_15 = 0

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.actorSpriteComps1060 == nil then
				arg_195_1.var_.actorSpriteComps1060 = var_198_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_16 = 0.034

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_16 and not isNil(var_198_14) then
				local var_198_17 = (arg_195_1.time_ - var_198_15) / var_198_16

				if arg_195_1.var_.actorSpriteComps1060 then
					for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_198_3 then
							if arg_195_1.isInRecall_ then
								local var_198_18 = Mathf.Lerp(iter_198_3.color.r, arg_195_1.hightColor2.r, var_198_17)
								local var_198_19 = Mathf.Lerp(iter_198_3.color.g, arg_195_1.hightColor2.g, var_198_17)
								local var_198_20 = Mathf.Lerp(iter_198_3.color.b, arg_195_1.hightColor2.b, var_198_17)

								iter_198_3.color = Color.New(var_198_18, var_198_19, var_198_20)
							else
								local var_198_21 = Mathf.Lerp(iter_198_3.color.r, 0.5, var_198_17)

								iter_198_3.color = Color.New(var_198_21, var_198_21, var_198_21)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_15 + var_198_16 and arg_195_1.time_ < var_198_15 + var_198_16 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.actorSpriteComps1060 then
				for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_198_5 then
						if arg_195_1.isInRecall_ then
							iter_198_5.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1060 = nil
			end

			local var_198_22 = arg_195_1.actors_["1012"]
			local var_198_23 = 0

			if var_198_23 < arg_195_1.time_ and arg_195_1.time_ <= var_198_23 + arg_198_0 and not isNil(var_198_22) and arg_195_1.var_.actorSpriteComps1012 == nil then
				arg_195_1.var_.actorSpriteComps1012 = var_198_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_24 = 0.034

			if var_198_23 <= arg_195_1.time_ and arg_195_1.time_ < var_198_23 + var_198_24 and not isNil(var_198_22) then
				local var_198_25 = (arg_195_1.time_ - var_198_23) / var_198_24

				if arg_195_1.var_.actorSpriteComps1012 then
					for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_198_7 then
							if arg_195_1.isInRecall_ then
								local var_198_26 = Mathf.Lerp(iter_198_7.color.r, arg_195_1.hightColor1.r, var_198_25)
								local var_198_27 = Mathf.Lerp(iter_198_7.color.g, arg_195_1.hightColor1.g, var_198_25)
								local var_198_28 = Mathf.Lerp(iter_198_7.color.b, arg_195_1.hightColor1.b, var_198_25)

								iter_198_7.color = Color.New(var_198_26, var_198_27, var_198_28)
							else
								local var_198_29 = Mathf.Lerp(iter_198_7.color.r, 1, var_198_25)

								iter_198_7.color = Color.New(var_198_29, var_198_29, var_198_29)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_23 + var_198_24 and arg_195_1.time_ < var_198_23 + var_198_24 + arg_198_0 and not isNil(var_198_22) and arg_195_1.var_.actorSpriteComps1012 then
				for iter_198_8, iter_198_9 in pairs(arg_195_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_198_9 then
						if arg_195_1.isInRecall_ then
							iter_198_9.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps1012 = nil
			end

			local var_198_30 = 0
			local var_198_31 = 0.175

			if var_198_30 < arg_195_1.time_ and arg_195_1.time_ <= var_198_30 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_32 = arg_195_1:FormatText(StoryNameCfg[595].name)

				arg_195_1.leftNameTxt_.text = var_198_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_33 = arg_195_1:GetWordFromCfg(410101046)
				local var_198_34 = arg_195_1:FormatText(var_198_33.content)

				arg_195_1.text_.text = var_198_34

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_35 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101046", "story_v_out_410101.awb") ~= 0 then
					local var_198_38 = manager.audio:GetVoiceLength("story_v_out_410101", "410101046", "story_v_out_410101.awb") / 1000

					if var_198_38 + var_198_30 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_38 + var_198_30
					end

					if var_198_33.prefab_name ~= "" and arg_195_1.actors_[var_198_33.prefab_name] ~= nil then
						local var_198_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_33.prefab_name].transform, "story_v_out_410101", "410101046", "story_v_out_410101.awb")

						arg_195_1:RecordAudio("410101046", var_198_39)
						arg_195_1:RecordAudio("410101046", var_198_39)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_410101", "410101046", "story_v_out_410101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_410101", "410101046", "story_v_out_410101.awb")
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

		arg_195_1:InitPlayNodeList()
	end,
	Play410101047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410101047
		arg_199_1.duration_ = 10.63

		local var_199_0 = {
			zh = 3.233,
			ja = 10.633
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
				arg_199_0:Play410101048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1060"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1060 = var_202_0.localPosition
				var_202_0.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1060", 2)

				local var_202_2 = var_202_0.childCount

				for iter_202_0 = 0, var_202_2 - 1 do
					local var_202_3 = var_202_0:GetChild(iter_202_0)

					if var_202_3.name == "" or not string.find(var_202_3.name, "split") then
						var_202_3.gameObject:SetActive(true)
					else
						var_202_3.gameObject:SetActive(false)
					end
				end
			end

			local var_202_4 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_4 then
				local var_202_5 = (arg_199_1.time_ - var_202_1) / var_202_4
				local var_202_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1060, var_202_6, var_202_5)
			end

			if arg_199_1.time_ >= var_202_1 + var_202_4 and arg_199_1.time_ < var_202_1 + var_202_4 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_202_7 = arg_199_1.actors_["1060"]
			local var_202_8 = 0

			if var_202_8 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps1060 == nil then
				arg_199_1.var_.actorSpriteComps1060 = var_202_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_9 = 0.034

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 and not isNil(var_202_7) then
				local var_202_10 = (arg_199_1.time_ - var_202_8) / var_202_9

				if arg_199_1.var_.actorSpriteComps1060 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 and not isNil(var_202_7) and arg_199_1.var_.actorSpriteComps1060 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_202_4 then
						if arg_199_1.isInRecall_ then
							iter_202_4.color = arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_202_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1060 = nil
			end

			local var_202_15 = arg_199_1.actors_["1012"]
			local var_202_16 = 0

			if var_202_16 < arg_199_1.time_ and arg_199_1.time_ <= var_202_16 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.actorSpriteComps1012 == nil then
				arg_199_1.var_.actorSpriteComps1012 = var_202_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_17 = 0.034

			if var_202_16 <= arg_199_1.time_ and arg_199_1.time_ < var_202_16 + var_202_17 and not isNil(var_202_15) then
				local var_202_18 = (arg_199_1.time_ - var_202_16) / var_202_17

				if arg_199_1.var_.actorSpriteComps1012 then
					for iter_202_5, iter_202_6 in pairs(arg_199_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_199_1.time_ >= var_202_16 + var_202_17 and arg_199_1.time_ < var_202_16 + var_202_17 + arg_202_0 and not isNil(var_202_15) and arg_199_1.var_.actorSpriteComps1012 then
				for iter_202_7, iter_202_8 in pairs(arg_199_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_202_8 then
						if arg_199_1.isInRecall_ then
							iter_202_8.color = arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_202_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_199_1.var_.actorSpriteComps1012 = nil
			end

			local var_202_23 = 0
			local var_202_24 = 0.425

			if var_202_23 < arg_199_1.time_ and arg_199_1.time_ <= var_202_23 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_25 = arg_199_1:FormatText(StoryNameCfg[584].name)

				arg_199_1.leftNameTxt_.text = var_202_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_26 = arg_199_1:GetWordFromCfg(410101047)
				local var_202_27 = arg_199_1:FormatText(var_202_26.content)

				arg_199_1.text_.text = var_202_27

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_28 = 17
				local var_202_29 = utf8.len(var_202_27)
				local var_202_30 = var_202_28 <= 0 and var_202_24 or var_202_24 * (var_202_29 / var_202_28)

				if var_202_30 > 0 and var_202_24 < var_202_30 then
					arg_199_1.talkMaxDuration = var_202_30

					if var_202_30 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_30 + var_202_23
					end
				end

				arg_199_1.text_.text = var_202_27
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101047", "story_v_out_410101.awb") ~= 0 then
					local var_202_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101047", "story_v_out_410101.awb") / 1000

					if var_202_31 + var_202_23 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_31 + var_202_23
					end

					if var_202_26.prefab_name ~= "" and arg_199_1.actors_[var_202_26.prefab_name] ~= nil then
						local var_202_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_26.prefab_name].transform, "story_v_out_410101", "410101047", "story_v_out_410101.awb")

						arg_199_1:RecordAudio("410101047", var_202_32)
						arg_199_1:RecordAudio("410101047", var_202_32)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410101", "410101047", "story_v_out_410101.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410101", "410101047", "story_v_out_410101.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_33 = math.max(var_202_24, arg_199_1.talkMaxDuration)

			if var_202_23 <= arg_199_1.time_ and arg_199_1.time_ < var_202_23 + var_202_33 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_23) / var_202_33

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_23 + var_202_33 and arg_199_1.time_ < var_202_23 + var_202_33 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play410101048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410101048
		arg_203_1.duration_ = 9.3

		local var_203_0 = {
			zh = 4.4,
			ja = 9.3
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play410101049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1012"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1012 = var_206_0.localPosition
				var_206_0.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1012", 4)

				local var_206_2 = var_206_0.childCount

				for iter_206_0 = 0, var_206_2 - 1 do
					local var_206_3 = var_206_0:GetChild(iter_206_0)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_4 then
				local var_206_5 = (arg_203_1.time_ - var_206_1) / var_206_4
				local var_206_6 = Vector3.New(390, -465, 300)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1012, var_206_6, var_206_5)
			end

			if arg_203_1.time_ >= var_206_1 + var_206_4 and arg_203_1.time_ < var_206_1 + var_206_4 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_206_7 = arg_203_1.actors_["1012"]
			local var_206_8 = 0

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps1012 == nil then
				arg_203_1.var_.actorSpriteComps1012 = var_206_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_9 = 0.034

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 and not isNil(var_206_7) then
				local var_206_10 = (arg_203_1.time_ - var_206_8) / var_206_9

				if arg_203_1.var_.actorSpriteComps1012 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								local var_206_11 = Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, var_206_10)
								local var_206_12 = Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, var_206_10)
								local var_206_13 = Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, var_206_10)

								iter_206_2.color = Color.New(var_206_11, var_206_12, var_206_13)
							else
								local var_206_14 = Mathf.Lerp(iter_206_2.color.r, 1, var_206_10)

								iter_206_2.color = Color.New(var_206_14, var_206_14, var_206_14)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 and not isNil(var_206_7) and arg_203_1.var_.actorSpriteComps1012 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_206_4 then
						if arg_203_1.isInRecall_ then
							iter_206_4.color = arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_206_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1012 = nil
			end

			local var_206_15 = arg_203_1.actors_["1060"]
			local var_206_16 = 0

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.actorSpriteComps1060 == nil then
				arg_203_1.var_.actorSpriteComps1060 = var_206_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_17 = 0.034

			if var_206_16 <= arg_203_1.time_ and arg_203_1.time_ < var_206_16 + var_206_17 and not isNil(var_206_15) then
				local var_206_18 = (arg_203_1.time_ - var_206_16) / var_206_17

				if arg_203_1.var_.actorSpriteComps1060 then
					for iter_206_5, iter_206_6 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_206_6 then
							if arg_203_1.isInRecall_ then
								local var_206_19 = Mathf.Lerp(iter_206_6.color.r, arg_203_1.hightColor2.r, var_206_18)
								local var_206_20 = Mathf.Lerp(iter_206_6.color.g, arg_203_1.hightColor2.g, var_206_18)
								local var_206_21 = Mathf.Lerp(iter_206_6.color.b, arg_203_1.hightColor2.b, var_206_18)

								iter_206_6.color = Color.New(var_206_19, var_206_20, var_206_21)
							else
								local var_206_22 = Mathf.Lerp(iter_206_6.color.r, 0.5, var_206_18)

								iter_206_6.color = Color.New(var_206_22, var_206_22, var_206_22)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 and not isNil(var_206_15) and arg_203_1.var_.actorSpriteComps1060 then
				for iter_206_7, iter_206_8 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_206_8 then
						if arg_203_1.isInRecall_ then
							iter_206_8.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps1060 = nil
			end

			local var_206_23 = 0
			local var_206_24 = 0.5

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_25 = arg_203_1:FormatText(StoryNameCfg[595].name)

				arg_203_1.leftNameTxt_.text = var_206_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_26 = arg_203_1:GetWordFromCfg(410101048)
				local var_206_27 = arg_203_1:FormatText(var_206_26.content)

				arg_203_1.text_.text = var_206_27

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_28 = 20
				local var_206_29 = utf8.len(var_206_27)
				local var_206_30 = var_206_28 <= 0 and var_206_24 or var_206_24 * (var_206_29 / var_206_28)

				if var_206_30 > 0 and var_206_24 < var_206_30 then
					arg_203_1.talkMaxDuration = var_206_30

					if var_206_30 + var_206_23 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_30 + var_206_23
					end
				end

				arg_203_1.text_.text = var_206_27
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101048", "story_v_out_410101.awb") ~= 0 then
					local var_206_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101048", "story_v_out_410101.awb") / 1000

					if var_206_31 + var_206_23 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_31 + var_206_23
					end

					if var_206_26.prefab_name ~= "" and arg_203_1.actors_[var_206_26.prefab_name] ~= nil then
						local var_206_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_26.prefab_name].transform, "story_v_out_410101", "410101048", "story_v_out_410101.awb")

						arg_203_1:RecordAudio("410101048", var_206_32)
						arg_203_1:RecordAudio("410101048", var_206_32)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_410101", "410101048", "story_v_out_410101.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_410101", "410101048", "story_v_out_410101.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_33 = math.max(var_206_24, arg_203_1.talkMaxDuration)

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_33 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_23) / var_206_33

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_23 + var_206_33 and arg_203_1.time_ < var_206_23 + var_206_33 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play410101049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410101049
		arg_207_1.duration_ = 13.93

		local var_207_0 = {
			zh = 5.7,
			ja = 13.933
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
				arg_207_0:Play410101050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.7

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[595].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(410101049)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 28
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101049", "story_v_out_410101.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101049", "story_v_out_410101.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_410101", "410101049", "story_v_out_410101.awb")

						arg_207_1:RecordAudio("410101049", var_210_9)
						arg_207_1:RecordAudio("410101049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_410101", "410101049", "story_v_out_410101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_410101", "410101049", "story_v_out_410101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play410101050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410101050
		arg_211_1.duration_ = 2.03

		local var_211_0 = {
			zh = 2.033,
			ja = 1.833
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
				arg_211_0:Play410101051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1060"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1060 = var_214_0.localPosition
				var_214_0.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1060", 2)

				local var_214_2 = var_214_0.childCount

				for iter_214_0 = 0, var_214_2 - 1 do
					local var_214_3 = var_214_0:GetChild(iter_214_0)

					if var_214_3.name == "" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_4 then
				local var_214_5 = (arg_211_1.time_ - var_214_1) / var_214_4
				local var_214_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1060, var_214_6, var_214_5)
			end

			if arg_211_1.time_ >= var_214_1 + var_214_4 and arg_211_1.time_ < var_214_1 + var_214_4 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_214_7 = arg_211_1.actors_["1060"]
			local var_214_8 = 0

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps1060 == nil then
				arg_211_1.var_.actorSpriteComps1060 = var_214_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_9 = 0.034

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_9 and not isNil(var_214_7) then
				local var_214_10 = (arg_211_1.time_ - var_214_8) / var_214_9

				if arg_211_1.var_.actorSpriteComps1060 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								local var_214_11 = Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, var_214_10)
								local var_214_12 = Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, var_214_10)
								local var_214_13 = Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, var_214_10)

								iter_214_2.color = Color.New(var_214_11, var_214_12, var_214_13)
							else
								local var_214_14 = Mathf.Lerp(iter_214_2.color.r, 1, var_214_10)

								iter_214_2.color = Color.New(var_214_14, var_214_14, var_214_14)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_8 + var_214_9 and arg_211_1.time_ < var_214_8 + var_214_9 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.actorSpriteComps1060 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_214_4 then
						if arg_211_1.isInRecall_ then
							iter_214_4.color = arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_214_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1060 = nil
			end

			local var_214_15 = arg_211_1.actors_["1012"]
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.actorSpriteComps1012 == nil then
				arg_211_1.var_.actorSpriteComps1012 = var_214_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_17 = 0.034

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 and not isNil(var_214_15) then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17

				if arg_211_1.var_.actorSpriteComps1012 then
					for iter_214_5, iter_214_6 in pairs(arg_211_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_214_6 then
							if arg_211_1.isInRecall_ then
								local var_214_19 = Mathf.Lerp(iter_214_6.color.r, arg_211_1.hightColor2.r, var_214_18)
								local var_214_20 = Mathf.Lerp(iter_214_6.color.g, arg_211_1.hightColor2.g, var_214_18)
								local var_214_21 = Mathf.Lerp(iter_214_6.color.b, arg_211_1.hightColor2.b, var_214_18)

								iter_214_6.color = Color.New(var_214_19, var_214_20, var_214_21)
							else
								local var_214_22 = Mathf.Lerp(iter_214_6.color.r, 0.5, var_214_18)

								iter_214_6.color = Color.New(var_214_22, var_214_22, var_214_22)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 and not isNil(var_214_15) and arg_211_1.var_.actorSpriteComps1012 then
				for iter_214_7, iter_214_8 in pairs(arg_211_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_214_8 then
						if arg_211_1.isInRecall_ then
							iter_214_8.color = arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_214_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_211_1.var_.actorSpriteComps1012 = nil
			end

			local var_214_23 = 0
			local var_214_24 = 0.2

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_25 = arg_211_1:FormatText(StoryNameCfg[584].name)

				arg_211_1.leftNameTxt_.text = var_214_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_26 = arg_211_1:GetWordFromCfg(410101050)
				local var_214_27 = arg_211_1:FormatText(var_214_26.content)

				arg_211_1.text_.text = var_214_27

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_28 = 8
				local var_214_29 = utf8.len(var_214_27)
				local var_214_30 = var_214_28 <= 0 and var_214_24 or var_214_24 * (var_214_29 / var_214_28)

				if var_214_30 > 0 and var_214_24 < var_214_30 then
					arg_211_1.talkMaxDuration = var_214_30

					if var_214_30 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_30 + var_214_23
					end
				end

				arg_211_1.text_.text = var_214_27
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101050", "story_v_out_410101.awb") ~= 0 then
					local var_214_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101050", "story_v_out_410101.awb") / 1000

					if var_214_31 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_31 + var_214_23
					end

					if var_214_26.prefab_name ~= "" and arg_211_1.actors_[var_214_26.prefab_name] ~= nil then
						local var_214_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_26.prefab_name].transform, "story_v_out_410101", "410101050", "story_v_out_410101.awb")

						arg_211_1:RecordAudio("410101050", var_214_32)
						arg_211_1:RecordAudio("410101050", var_214_32)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410101", "410101050", "story_v_out_410101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410101", "410101050", "story_v_out_410101.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_33 = math.max(var_214_24, arg_211_1.talkMaxDuration)

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_33 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_23) / var_214_33

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_23 + var_214_33 and arg_211_1.time_ < var_214_23 + var_214_33 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play410101051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410101051
		arg_215_1.duration_ = 15.5

		local var_215_0 = {
			zh = 10.9,
			ja = 15.5
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
				arg_215_0:Play410101052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1012"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos1012 = var_218_0.localPosition
				var_218_0.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1012", 4)

				local var_218_2 = var_218_0.childCount

				for iter_218_0 = 0, var_218_2 - 1 do
					local var_218_3 = var_218_0:GetChild(iter_218_0)

					if var_218_3.name == "" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_4 then
				local var_218_5 = (arg_215_1.time_ - var_218_1) / var_218_4
				local var_218_6 = Vector3.New(390, -465, 300)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1012, var_218_6, var_218_5)
			end

			if arg_215_1.time_ >= var_218_1 + var_218_4 and arg_215_1.time_ < var_218_1 + var_218_4 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_218_7 = arg_215_1.actors_["1012"]
			local var_218_8 = 0

			if var_218_8 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1012 == nil then
				arg_215_1.var_.actorSpriteComps1012 = var_218_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_9 = 0.034

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_9 and not isNil(var_218_7) then
				local var_218_10 = (arg_215_1.time_ - var_218_8) / var_218_9

				if arg_215_1.var_.actorSpriteComps1012 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								local var_218_11 = Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, var_218_10)
								local var_218_12 = Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, var_218_10)
								local var_218_13 = Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, var_218_10)

								iter_218_2.color = Color.New(var_218_11, var_218_12, var_218_13)
							else
								local var_218_14 = Mathf.Lerp(iter_218_2.color.r, 1, var_218_10)

								iter_218_2.color = Color.New(var_218_14, var_218_14, var_218_14)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_8 + var_218_9 and arg_215_1.time_ < var_218_8 + var_218_9 + arg_218_0 and not isNil(var_218_7) and arg_215_1.var_.actorSpriteComps1012 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_218_4 then
						if arg_215_1.isInRecall_ then
							iter_218_4.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1012 = nil
			end

			local var_218_15 = arg_215_1.actors_["1060"]
			local var_218_16 = 0

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.actorSpriteComps1060 == nil then
				arg_215_1.var_.actorSpriteComps1060 = var_218_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_17 = 0.034

			if var_218_16 <= arg_215_1.time_ and arg_215_1.time_ < var_218_16 + var_218_17 and not isNil(var_218_15) then
				local var_218_18 = (arg_215_1.time_ - var_218_16) / var_218_17

				if arg_215_1.var_.actorSpriteComps1060 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								local var_218_19 = Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, var_218_18)
								local var_218_20 = Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, var_218_18)
								local var_218_21 = Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, var_218_18)

								iter_218_6.color = Color.New(var_218_19, var_218_20, var_218_21)
							else
								local var_218_22 = Mathf.Lerp(iter_218_6.color.r, 0.5, var_218_18)

								iter_218_6.color = Color.New(var_218_22, var_218_22, var_218_22)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.actorSpriteComps1060 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_218_8 then
						if arg_215_1.isInRecall_ then
							iter_218_8.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1060 = nil
			end

			local var_218_23 = 0
			local var_218_24 = 1.15

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_25 = arg_215_1:FormatText(StoryNameCfg[595].name)

				arg_215_1.leftNameTxt_.text = var_218_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_26 = arg_215_1:GetWordFromCfg(410101051)
				local var_218_27 = arg_215_1:FormatText(var_218_26.content)

				arg_215_1.text_.text = var_218_27

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_28 = 46
				local var_218_29 = utf8.len(var_218_27)
				local var_218_30 = var_218_28 <= 0 and var_218_24 or var_218_24 * (var_218_29 / var_218_28)

				if var_218_30 > 0 and var_218_24 < var_218_30 then
					arg_215_1.talkMaxDuration = var_218_30

					if var_218_30 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_30 + var_218_23
					end
				end

				arg_215_1.text_.text = var_218_27
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101051", "story_v_out_410101.awb") ~= 0 then
					local var_218_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101051", "story_v_out_410101.awb") / 1000

					if var_218_31 + var_218_23 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_31 + var_218_23
					end

					if var_218_26.prefab_name ~= "" and arg_215_1.actors_[var_218_26.prefab_name] ~= nil then
						local var_218_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_26.prefab_name].transform, "story_v_out_410101", "410101051", "story_v_out_410101.awb")

						arg_215_1:RecordAudio("410101051", var_218_32)
						arg_215_1:RecordAudio("410101051", var_218_32)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410101", "410101051", "story_v_out_410101.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410101", "410101051", "story_v_out_410101.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_33 = math.max(var_218_24, arg_215_1.talkMaxDuration)

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_33 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_33

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_33 and arg_215_1.time_ < var_218_23 + var_218_33 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play410101052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410101052
		arg_219_1.duration_ = 4.6

		local var_219_0 = {
			zh = 4.366,
			ja = 4.6
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
				arg_219_0:Play410101053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.3

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[595].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:GetWordFromCfg(410101052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 12
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101052", "story_v_out_410101.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101052", "story_v_out_410101.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_410101", "410101052", "story_v_out_410101.awb")

						arg_219_1:RecordAudio("410101052", var_222_9)
						arg_219_1:RecordAudio("410101052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_410101", "410101052", "story_v_out_410101.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_410101", "410101052", "story_v_out_410101.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play410101053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410101053
		arg_223_1.duration_ = 5.53

		local var_223_0 = {
			zh = 1.9,
			ja = 5.533
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play410101054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1060"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1060 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1060", 2)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1060, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_226_7 = arg_223_1.actors_["1060"]
			local var_226_8 = 0

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1060 == nil then
				arg_223_1.var_.actorSpriteComps1060 = var_226_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_9 = 0.034

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_9 and not isNil(var_226_7) then
				local var_226_10 = (arg_223_1.time_ - var_226_8) / var_226_9

				if arg_223_1.var_.actorSpriteComps1060 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								local var_226_11 = Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, var_226_10)
								local var_226_12 = Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, var_226_10)
								local var_226_13 = Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, var_226_10)

								iter_226_2.color = Color.New(var_226_11, var_226_12, var_226_13)
							else
								local var_226_14 = Mathf.Lerp(iter_226_2.color.r, 1, var_226_10)

								iter_226_2.color = Color.New(var_226_14, var_226_14, var_226_14)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_8 + var_226_9 and arg_223_1.time_ < var_226_8 + var_226_9 + arg_226_0 and not isNil(var_226_7) and arg_223_1.var_.actorSpriteComps1060 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_226_4 then
						if arg_223_1.isInRecall_ then
							iter_226_4.color = arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_226_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1060 = nil
			end

			local var_226_15 = arg_223_1.actors_["1012"]
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.actorSpriteComps1012 == nil then
				arg_223_1.var_.actorSpriteComps1012 = var_226_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_17 = 0.034

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 and not isNil(var_226_15) then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17

				if arg_223_1.var_.actorSpriteComps1012 then
					for iter_226_5, iter_226_6 in pairs(arg_223_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_226_6 then
							if arg_223_1.isInRecall_ then
								local var_226_19 = Mathf.Lerp(iter_226_6.color.r, arg_223_1.hightColor2.r, var_226_18)
								local var_226_20 = Mathf.Lerp(iter_226_6.color.g, arg_223_1.hightColor2.g, var_226_18)
								local var_226_21 = Mathf.Lerp(iter_226_6.color.b, arg_223_1.hightColor2.b, var_226_18)

								iter_226_6.color = Color.New(var_226_19, var_226_20, var_226_21)
							else
								local var_226_22 = Mathf.Lerp(iter_226_6.color.r, 0.5, var_226_18)

								iter_226_6.color = Color.New(var_226_22, var_226_22, var_226_22)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 and not isNil(var_226_15) and arg_223_1.var_.actorSpriteComps1012 then
				for iter_226_7, iter_226_8 in pairs(arg_223_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_226_8 then
						if arg_223_1.isInRecall_ then
							iter_226_8.color = arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_226_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_223_1.var_.actorSpriteComps1012 = nil
			end

			local var_226_23 = 0
			local var_226_24 = 0.125

			if var_226_23 < arg_223_1.time_ and arg_223_1.time_ <= var_226_23 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_25 = arg_223_1:FormatText(StoryNameCfg[584].name)

				arg_223_1.leftNameTxt_.text = var_226_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_26 = arg_223_1:GetWordFromCfg(410101053)
				local var_226_27 = arg_223_1:FormatText(var_226_26.content)

				arg_223_1.text_.text = var_226_27

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_28 = 5
				local var_226_29 = utf8.len(var_226_27)
				local var_226_30 = var_226_28 <= 0 and var_226_24 or var_226_24 * (var_226_29 / var_226_28)

				if var_226_30 > 0 and var_226_24 < var_226_30 then
					arg_223_1.talkMaxDuration = var_226_30

					if var_226_30 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_30 + var_226_23
					end
				end

				arg_223_1.text_.text = var_226_27
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101053", "story_v_out_410101.awb") ~= 0 then
					local var_226_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101053", "story_v_out_410101.awb") / 1000

					if var_226_31 + var_226_23 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_31 + var_226_23
					end

					if var_226_26.prefab_name ~= "" and arg_223_1.actors_[var_226_26.prefab_name] ~= nil then
						local var_226_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_26.prefab_name].transform, "story_v_out_410101", "410101053", "story_v_out_410101.awb")

						arg_223_1:RecordAudio("410101053", var_226_32)
						arg_223_1:RecordAudio("410101053", var_226_32)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410101", "410101053", "story_v_out_410101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410101", "410101053", "story_v_out_410101.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_33 = math.max(var_226_24, arg_223_1.talkMaxDuration)

			if var_226_23 <= arg_223_1.time_ and arg_223_1.time_ < var_226_23 + var_226_33 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_23) / var_226_33

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_23 + var_226_33 and arg_223_1.time_ < var_226_23 + var_226_33 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play410101054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410101054
		arg_227_1.duration_ = 8.37

		local var_227_0 = {
			zh = 1.3,
			ja = 8.366
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
				arg_227_0:Play410101055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1012"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1012 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1012", 4)

				local var_230_2 = var_230_0.childCount

				for iter_230_0 = 0, var_230_2 - 1 do
					local var_230_3 = var_230_0:GetChild(iter_230_0)

					if var_230_3.name == "" or not string.find(var_230_3.name, "split") then
						var_230_3.gameObject:SetActive(true)
					else
						var_230_3.gameObject:SetActive(false)
					end
				end
			end

			local var_230_4 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_4 then
				local var_230_5 = (arg_227_1.time_ - var_230_1) / var_230_4
				local var_230_6 = Vector3.New(390, -465, 300)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1012, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_230_7 = arg_227_1.actors_["1012"]
			local var_230_8 = 0

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1012 == nil then
				arg_227_1.var_.actorSpriteComps1012 = var_230_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_9 = 0.034

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_9 and not isNil(var_230_7) then
				local var_230_10 = (arg_227_1.time_ - var_230_8) / var_230_9

				if arg_227_1.var_.actorSpriteComps1012 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								local var_230_11 = Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, var_230_10)
								local var_230_12 = Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, var_230_10)
								local var_230_13 = Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, var_230_10)

								iter_230_2.color = Color.New(var_230_11, var_230_12, var_230_13)
							else
								local var_230_14 = Mathf.Lerp(iter_230_2.color.r, 1, var_230_10)

								iter_230_2.color = Color.New(var_230_14, var_230_14, var_230_14)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_8 + var_230_9 and arg_227_1.time_ < var_230_8 + var_230_9 + arg_230_0 and not isNil(var_230_7) and arg_227_1.var_.actorSpriteComps1012 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_230_4 then
						if arg_227_1.isInRecall_ then
							iter_230_4.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_230_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1012 = nil
			end

			local var_230_15 = arg_227_1.actors_["1060"]
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1060 == nil then
				arg_227_1.var_.actorSpriteComps1060 = var_230_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_17 = 0.034

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 and not isNil(var_230_15) then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17

				if arg_227_1.var_.actorSpriteComps1060 then
					for iter_230_5, iter_230_6 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_230_6 then
							if arg_227_1.isInRecall_ then
								local var_230_19 = Mathf.Lerp(iter_230_6.color.r, arg_227_1.hightColor2.r, var_230_18)
								local var_230_20 = Mathf.Lerp(iter_230_6.color.g, arg_227_1.hightColor2.g, var_230_18)
								local var_230_21 = Mathf.Lerp(iter_230_6.color.b, arg_227_1.hightColor2.b, var_230_18)

								iter_230_6.color = Color.New(var_230_19, var_230_20, var_230_21)
							else
								local var_230_22 = Mathf.Lerp(iter_230_6.color.r, 0.5, var_230_18)

								iter_230_6.color = Color.New(var_230_22, var_230_22, var_230_22)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 and not isNil(var_230_15) and arg_227_1.var_.actorSpriteComps1060 then
				for iter_230_7, iter_230_8 in pairs(arg_227_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_230_8 then
						if arg_227_1.isInRecall_ then
							iter_230_8.color = arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_230_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_227_1.var_.actorSpriteComps1060 = nil
			end

			local var_230_23 = 0
			local var_230_24 = 0.1

			if var_230_23 < arg_227_1.time_ and arg_227_1.time_ <= var_230_23 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_25 = arg_227_1:FormatText(StoryNameCfg[595].name)

				arg_227_1.leftNameTxt_.text = var_230_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_26 = arg_227_1:GetWordFromCfg(410101054)
				local var_230_27 = arg_227_1:FormatText(var_230_26.content)

				arg_227_1.text_.text = var_230_27

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_28 = 4
				local var_230_29 = utf8.len(var_230_27)
				local var_230_30 = var_230_28 <= 0 and var_230_24 or var_230_24 * (var_230_29 / var_230_28)

				if var_230_30 > 0 and var_230_24 < var_230_30 then
					arg_227_1.talkMaxDuration = var_230_30

					if var_230_30 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_30 + var_230_23
					end
				end

				arg_227_1.text_.text = var_230_27
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101054", "story_v_out_410101.awb") ~= 0 then
					local var_230_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101054", "story_v_out_410101.awb") / 1000

					if var_230_31 + var_230_23 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_31 + var_230_23
					end

					if var_230_26.prefab_name ~= "" and arg_227_1.actors_[var_230_26.prefab_name] ~= nil then
						local var_230_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_26.prefab_name].transform, "story_v_out_410101", "410101054", "story_v_out_410101.awb")

						arg_227_1:RecordAudio("410101054", var_230_32)
						arg_227_1:RecordAudio("410101054", var_230_32)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410101", "410101054", "story_v_out_410101.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410101", "410101054", "story_v_out_410101.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_33 = math.max(var_230_24, arg_227_1.talkMaxDuration)

			if var_230_23 <= arg_227_1.time_ and arg_227_1.time_ < var_230_23 + var_230_33 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_23) / var_230_33

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_23 + var_230_33 and arg_227_1.time_ < var_230_23 + var_230_33 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play410101055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410101055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play410101056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1012"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1012 == nil then
				arg_231_1.var_.actorSpriteComps1012 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.034

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps1012 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 0.5, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps1012 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps1012 = nil
			end

			local var_234_8 = 0
			local var_234_9 = 0.725

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(410101055)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_12 = 29
				local var_234_13 = utf8.len(var_234_11)
				local var_234_14 = var_234_12 <= 0 and var_234_9 or var_234_9 * (var_234_13 / var_234_12)

				if var_234_14 > 0 and var_234_9 < var_234_14 then
					arg_231_1.talkMaxDuration = var_234_14

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_15 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_15 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_15

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_15 and arg_231_1.time_ < var_234_8 + var_234_15 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play410101056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410101056
		arg_235_1.duration_ = 5.63

		local var_235_0 = {
			zh = 2.833,
			ja = 5.633
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
				arg_235_0:Play410101057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1012"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1012 = var_238_0.localPosition
				var_238_0.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1012", 4)

				local var_238_2 = var_238_0.childCount

				for iter_238_0 = 0, var_238_2 - 1 do
					local var_238_3 = var_238_0:GetChild(iter_238_0)

					if var_238_3.name == "" or not string.find(var_238_3.name, "split") then
						var_238_3.gameObject:SetActive(true)
					else
						var_238_3.gameObject:SetActive(false)
					end
				end
			end

			local var_238_4 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_4 then
				local var_238_5 = (arg_235_1.time_ - var_238_1) / var_238_4
				local var_238_6 = Vector3.New(390, -465, 300)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1012, var_238_6, var_238_5)
			end

			if arg_235_1.time_ >= var_238_1 + var_238_4 and arg_235_1.time_ < var_238_1 + var_238_4 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(390, -465, 300)
			end

			local var_238_7 = arg_235_1.actors_["1012"]
			local var_238_8 = 0

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps1012 == nil then
				arg_235_1.var_.actorSpriteComps1012 = var_238_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_9 = 0.034

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_9 and not isNil(var_238_7) then
				local var_238_10 = (arg_235_1.time_ - var_238_8) / var_238_9

				if arg_235_1.var_.actorSpriteComps1012 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								local var_238_11 = Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor1.r, var_238_10)
								local var_238_12 = Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor1.g, var_238_10)
								local var_238_13 = Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor1.b, var_238_10)

								iter_238_2.color = Color.New(var_238_11, var_238_12, var_238_13)
							else
								local var_238_14 = Mathf.Lerp(iter_238_2.color.r, 1, var_238_10)

								iter_238_2.color = Color.New(var_238_14, var_238_14, var_238_14)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_8 + var_238_9 and arg_235_1.time_ < var_238_8 + var_238_9 + arg_238_0 and not isNil(var_238_7) and arg_235_1.var_.actorSpriteComps1012 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_238_4 then
						if arg_235_1.isInRecall_ then
							iter_238_4.color = arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_238_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1012 = nil
			end

			local var_238_15 = 0
			local var_238_16 = 0.375

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_17 = arg_235_1:FormatText(StoryNameCfg[595].name)

				arg_235_1.leftNameTxt_.text = var_238_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_18 = arg_235_1:GetWordFromCfg(410101056)
				local var_238_19 = arg_235_1:FormatText(var_238_18.content)

				arg_235_1.text_.text = var_238_19

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_20 = 15
				local var_238_21 = utf8.len(var_238_19)
				local var_238_22 = var_238_20 <= 0 and var_238_16 or var_238_16 * (var_238_21 / var_238_20)

				if var_238_22 > 0 and var_238_16 < var_238_22 then
					arg_235_1.talkMaxDuration = var_238_22

					if var_238_22 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_22 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_19
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101056", "story_v_out_410101.awb") ~= 0 then
					local var_238_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101056", "story_v_out_410101.awb") / 1000

					if var_238_23 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_15
					end

					if var_238_18.prefab_name ~= "" and arg_235_1.actors_[var_238_18.prefab_name] ~= nil then
						local var_238_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_18.prefab_name].transform, "story_v_out_410101", "410101056", "story_v_out_410101.awb")

						arg_235_1:RecordAudio("410101056", var_238_24)
						arg_235_1:RecordAudio("410101056", var_238_24)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_410101", "410101056", "story_v_out_410101.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_410101", "410101056", "story_v_out_410101.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_25 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_25 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_25

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_25 and arg_235_1.time_ < var_238_15 + var_238_25 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play410101057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410101057
		arg_239_1.duration_ = 12.37

		local var_239_0 = {
			zh = 6.066,
			ja = 12.366
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play410101058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1060"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1060 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1060", 2)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1060, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_242_7 = arg_239_1.actors_["1060"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1060 == nil then
				arg_239_1.var_.actorSpriteComps1060 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 0.034

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps1060 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								local var_242_11 = Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, var_242_10)
								local var_242_12 = Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, var_242_10)
								local var_242_13 = Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, var_242_10)

								iter_242_2.color = Color.New(var_242_11, var_242_12, var_242_13)
							else
								local var_242_14 = Mathf.Lerp(iter_242_2.color.r, 1, var_242_10)

								iter_242_2.color = Color.New(var_242_14, var_242_14, var_242_14)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps1060 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1060 = nil
			end

			local var_242_15 = arg_239_1.actors_["1012"]
			local var_242_16 = 0

			if var_242_16 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 and not isNil(var_242_15) and arg_239_1.var_.actorSpriteComps1012 == nil then
				arg_239_1.var_.actorSpriteComps1012 = var_242_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_17 = 0.034

			if var_242_16 <= arg_239_1.time_ and arg_239_1.time_ < var_242_16 + var_242_17 and not isNil(var_242_15) then
				local var_242_18 = (arg_239_1.time_ - var_242_16) / var_242_17

				if arg_239_1.var_.actorSpriteComps1012 then
					for iter_242_5, iter_242_6 in pairs(arg_239_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_242_6 then
							if arg_239_1.isInRecall_ then
								local var_242_19 = Mathf.Lerp(iter_242_6.color.r, arg_239_1.hightColor2.r, var_242_18)
								local var_242_20 = Mathf.Lerp(iter_242_6.color.g, arg_239_1.hightColor2.g, var_242_18)
								local var_242_21 = Mathf.Lerp(iter_242_6.color.b, arg_239_1.hightColor2.b, var_242_18)

								iter_242_6.color = Color.New(var_242_19, var_242_20, var_242_21)
							else
								local var_242_22 = Mathf.Lerp(iter_242_6.color.r, 0.5, var_242_18)

								iter_242_6.color = Color.New(var_242_22, var_242_22, var_242_22)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_16 + var_242_17 and arg_239_1.time_ < var_242_16 + var_242_17 + arg_242_0 and not isNil(var_242_15) and arg_239_1.var_.actorSpriteComps1012 then
				for iter_242_7, iter_242_8 in pairs(arg_239_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_242_8 then
						if arg_239_1.isInRecall_ then
							iter_242_8.color = arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_242_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps1012 = nil
			end

			local var_242_23 = 0
			local var_242_24 = 0.725

			if var_242_23 < arg_239_1.time_ and arg_239_1.time_ <= var_242_23 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_25 = arg_239_1:FormatText(StoryNameCfg[584].name)

				arg_239_1.leftNameTxt_.text = var_242_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_26 = arg_239_1:GetWordFromCfg(410101057)
				local var_242_27 = arg_239_1:FormatText(var_242_26.content)

				arg_239_1.text_.text = var_242_27

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_28 = 29
				local var_242_29 = utf8.len(var_242_27)
				local var_242_30 = var_242_28 <= 0 and var_242_24 or var_242_24 * (var_242_29 / var_242_28)

				if var_242_30 > 0 and var_242_24 < var_242_30 then
					arg_239_1.talkMaxDuration = var_242_30

					if var_242_30 + var_242_23 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_30 + var_242_23
					end
				end

				arg_239_1.text_.text = var_242_27
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101057", "story_v_out_410101.awb") ~= 0 then
					local var_242_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101057", "story_v_out_410101.awb") / 1000

					if var_242_31 + var_242_23 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_31 + var_242_23
					end

					if var_242_26.prefab_name ~= "" and arg_239_1.actors_[var_242_26.prefab_name] ~= nil then
						local var_242_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_26.prefab_name].transform, "story_v_out_410101", "410101057", "story_v_out_410101.awb")

						arg_239_1:RecordAudio("410101057", var_242_32)
						arg_239_1:RecordAudio("410101057", var_242_32)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_410101", "410101057", "story_v_out_410101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_410101", "410101057", "story_v_out_410101.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_33 = math.max(var_242_24, arg_239_1.talkMaxDuration)

			if var_242_23 <= arg_239_1.time_ and arg_239_1.time_ < var_242_23 + var_242_33 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_23) / var_242_33

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_23 + var_242_33 and arg_239_1.time_ < var_242_23 + var_242_33 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play410101058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410101058
		arg_243_1.duration_ = 12.17

		local var_243_0 = {
			zh = 8.433,
			ja = 12.166
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
				arg_243_0:Play410101059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1060"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1060 == nil then
				arg_243_1.var_.actorSpriteComps1060 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.034

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps1060 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor2.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor2.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor2.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 0.5, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps1060 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_246_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1060 = nil
			end

			local var_246_8 = arg_243_1.actors_["1012"]
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1012 == nil then
				arg_243_1.var_.actorSpriteComps1012 = var_246_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_10 = 0.034

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 and not isNil(var_246_8) then
				local var_246_11 = (arg_243_1.time_ - var_246_9) / var_246_10

				if arg_243_1.var_.actorSpriteComps1012 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								local var_246_12 = Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor1.r, var_246_11)
								local var_246_13 = Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor1.g, var_246_11)
								local var_246_14 = Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor1.b, var_246_11)

								iter_246_5.color = Color.New(var_246_12, var_246_13, var_246_14)
							else
								local var_246_15 = Mathf.Lerp(iter_246_5.color.r, 1, var_246_11)

								iter_246_5.color = Color.New(var_246_15, var_246_15, var_246_15)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 and not isNil(var_246_8) and arg_243_1.var_.actorSpriteComps1012 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_246_7 then
						if arg_243_1.isInRecall_ then
							iter_246_7.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps1012 = nil
			end

			local var_246_16 = 0
			local var_246_17 = 1

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_18 = arg_243_1:FormatText(StoryNameCfg[595].name)

				arg_243_1.leftNameTxt_.text = var_246_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_19 = arg_243_1:GetWordFromCfg(410101058)
				local var_246_20 = arg_243_1:FormatText(var_246_19.content)

				arg_243_1.text_.text = var_246_20

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_21 = 40
				local var_246_22 = utf8.len(var_246_20)
				local var_246_23 = var_246_21 <= 0 and var_246_17 or var_246_17 * (var_246_22 / var_246_21)

				if var_246_23 > 0 and var_246_17 < var_246_23 then
					arg_243_1.talkMaxDuration = var_246_23

					if var_246_23 + var_246_16 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_16
					end
				end

				arg_243_1.text_.text = var_246_20
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101058", "story_v_out_410101.awb") ~= 0 then
					local var_246_24 = manager.audio:GetVoiceLength("story_v_out_410101", "410101058", "story_v_out_410101.awb") / 1000

					if var_246_24 + var_246_16 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_24 + var_246_16
					end

					if var_246_19.prefab_name ~= "" and arg_243_1.actors_[var_246_19.prefab_name] ~= nil then
						local var_246_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_19.prefab_name].transform, "story_v_out_410101", "410101058", "story_v_out_410101.awb")

						arg_243_1:RecordAudio("410101058", var_246_25)
						arg_243_1:RecordAudio("410101058", var_246_25)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410101", "410101058", "story_v_out_410101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410101", "410101058", "story_v_out_410101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_26 = math.max(var_246_17, arg_243_1.talkMaxDuration)

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_26 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_16) / var_246_26

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_16 + var_246_26 and arg_243_1.time_ < var_246_16 + var_246_26 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play410101059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410101059
		arg_247_1.duration_ = 12.47

		local var_247_0 = {
			zh = 8.266,
			ja = 12.466
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
				arg_247_0:Play410101060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.1

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[595].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_3 = arg_247_1:GetWordFromCfg(410101059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 44
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101059", "story_v_out_410101.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101059", "story_v_out_410101.awb") / 1000

					if var_250_8 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_0
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_410101", "410101059", "story_v_out_410101.awb")

						arg_247_1:RecordAudio("410101059", var_250_9)
						arg_247_1:RecordAudio("410101059", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_410101", "410101059", "story_v_out_410101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_410101", "410101059", "story_v_out_410101.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_10 and arg_247_1.time_ < var_250_0 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play410101060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 410101060
		arg_251_1.duration_ = 8.13

		local var_251_0 = {
			zh = 7.333,
			ja = 8.133
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
				arg_251_0:Play410101061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1060"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1060 = var_254_0.localPosition
				var_254_0.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1060", 2)

				local var_254_2 = var_254_0.childCount

				for iter_254_0 = 0, var_254_2 - 1 do
					local var_254_3 = var_254_0:GetChild(iter_254_0)

					if var_254_3.name == "" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_4 then
				local var_254_5 = (arg_251_1.time_ - var_254_1) / var_254_4
				local var_254_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1060, var_254_6, var_254_5)
			end

			if arg_251_1.time_ >= var_254_1 + var_254_4 and arg_251_1.time_ < var_254_1 + var_254_4 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_254_7 = arg_251_1.actors_["1060"]
			local var_254_8 = 0

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1060 == nil then
				arg_251_1.var_.actorSpriteComps1060 = var_254_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_9 = 0.034

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 and not isNil(var_254_7) then
				local var_254_10 = (arg_251_1.time_ - var_254_8) / var_254_9

				if arg_251_1.var_.actorSpriteComps1060 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								local var_254_11 = Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, var_254_10)
								local var_254_12 = Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, var_254_10)
								local var_254_13 = Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, var_254_10)

								iter_254_2.color = Color.New(var_254_11, var_254_12, var_254_13)
							else
								local var_254_14 = Mathf.Lerp(iter_254_2.color.r, 1, var_254_10)

								iter_254_2.color = Color.New(var_254_14, var_254_14, var_254_14)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps1060 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_254_4 then
						if arg_251_1.isInRecall_ then
							iter_254_4.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1060 = nil
			end

			local var_254_15 = arg_251_1.actors_["1012"]
			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.actorSpriteComps1012 == nil then
				arg_251_1.var_.actorSpriteComps1012 = var_254_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_17 = 0.034

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 and not isNil(var_254_15) then
				local var_254_18 = (arg_251_1.time_ - var_254_16) / var_254_17

				if arg_251_1.var_.actorSpriteComps1012 then
					for iter_254_5, iter_254_6 in pairs(arg_251_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_254_6 then
							if arg_251_1.isInRecall_ then
								local var_254_19 = Mathf.Lerp(iter_254_6.color.r, arg_251_1.hightColor2.r, var_254_18)
								local var_254_20 = Mathf.Lerp(iter_254_6.color.g, arg_251_1.hightColor2.g, var_254_18)
								local var_254_21 = Mathf.Lerp(iter_254_6.color.b, arg_251_1.hightColor2.b, var_254_18)

								iter_254_6.color = Color.New(var_254_19, var_254_20, var_254_21)
							else
								local var_254_22 = Mathf.Lerp(iter_254_6.color.r, 0.5, var_254_18)

								iter_254_6.color = Color.New(var_254_22, var_254_22, var_254_22)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.actorSpriteComps1012 then
				for iter_254_7, iter_254_8 in pairs(arg_251_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_254_8 then
						if arg_251_1.isInRecall_ then
							iter_254_8.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1012 = nil
			end

			local var_254_23 = 0
			local var_254_24 = 0.825

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_25 = arg_251_1:FormatText(StoryNameCfg[584].name)

				arg_251_1.leftNameTxt_.text = var_254_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_26 = arg_251_1:GetWordFromCfg(410101060)
				local var_254_27 = arg_251_1:FormatText(var_254_26.content)

				arg_251_1.text_.text = var_254_27

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_28 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101060", "story_v_out_410101.awb") ~= 0 then
					local var_254_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101060", "story_v_out_410101.awb") / 1000

					if var_254_31 + var_254_23 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_23
					end

					if var_254_26.prefab_name ~= "" and arg_251_1.actors_[var_254_26.prefab_name] ~= nil then
						local var_254_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_26.prefab_name].transform, "story_v_out_410101", "410101060", "story_v_out_410101.awb")

						arg_251_1:RecordAudio("410101060", var_254_32)
						arg_251_1:RecordAudio("410101060", var_254_32)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_410101", "410101060", "story_v_out_410101.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_410101", "410101060", "story_v_out_410101.awb")
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
				actorName = "1060",
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
	Play410101061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 410101061
		arg_255_1.duration_ = 11.83

		local var_255_0 = {
			zh = 6.866,
			ja = 11.833
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
				arg_255_0:Play410101062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1060"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1060 == nil then
				arg_255_1.var_.actorSpriteComps1060 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.034

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps1060 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 0.5, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps1060 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1060 = nil
			end

			local var_258_8 = arg_255_1.actors_["1012"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1012 == nil then
				arg_255_1.var_.actorSpriteComps1012 = var_258_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_10 = 0.034

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.actorSpriteComps1012 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								local var_258_12 = Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor1.r, var_258_11)
								local var_258_13 = Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor1.g, var_258_11)
								local var_258_14 = Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor1.b, var_258_11)

								iter_258_5.color = Color.New(var_258_12, var_258_13, var_258_14)
							else
								local var_258_15 = Mathf.Lerp(iter_258_5.color.r, 1, var_258_11)

								iter_258_5.color = Color.New(var_258_15, var_258_15, var_258_15)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1012 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1012 = nil
			end

			local var_258_16 = 0
			local var_258_17 = 0.875

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_18 = arg_255_1:FormatText(StoryNameCfg[595].name)

				arg_255_1.leftNameTxt_.text = var_258_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_19 = arg_255_1:GetWordFromCfg(410101061)
				local var_258_20 = arg_255_1:FormatText(var_258_19.content)

				arg_255_1.text_.text = var_258_20

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_21 = 35
				local var_258_22 = utf8.len(var_258_20)
				local var_258_23 = var_258_21 <= 0 and var_258_17 or var_258_17 * (var_258_22 / var_258_21)

				if var_258_23 > 0 and var_258_17 < var_258_23 then
					arg_255_1.talkMaxDuration = var_258_23

					if var_258_23 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_23 + var_258_16
					end
				end

				arg_255_1.text_.text = var_258_20
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101061", "story_v_out_410101.awb") ~= 0 then
					local var_258_24 = manager.audio:GetVoiceLength("story_v_out_410101", "410101061", "story_v_out_410101.awb") / 1000

					if var_258_24 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_16
					end

					if var_258_19.prefab_name ~= "" and arg_255_1.actors_[var_258_19.prefab_name] ~= nil then
						local var_258_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_19.prefab_name].transform, "story_v_out_410101", "410101061", "story_v_out_410101.awb")

						arg_255_1:RecordAudio("410101061", var_258_25)
						arg_255_1:RecordAudio("410101061", var_258_25)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_410101", "410101061", "story_v_out_410101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_410101", "410101061", "story_v_out_410101.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_26 = math.max(var_258_17, arg_255_1.talkMaxDuration)

			if var_258_16 <= arg_255_1.time_ and arg_255_1.time_ < var_258_16 + var_258_26 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_16) / var_258_26

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_16 + var_258_26 and arg_255_1.time_ < var_258_16 + var_258_26 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play410101062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 410101062
		arg_259_1.duration_ = 13.03

		local var_259_0 = {
			zh = 6.3,
			ja = 13.033
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
				arg_259_0:Play410101063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.825

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[595].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(410101062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 33
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101062", "story_v_out_410101.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_410101", "410101062", "story_v_out_410101.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_410101", "410101062", "story_v_out_410101.awb")

						arg_259_1:RecordAudio("410101062", var_262_9)
						arg_259_1:RecordAudio("410101062", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_410101", "410101062", "story_v_out_410101.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_410101", "410101062", "story_v_out_410101.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play410101063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 410101063
		arg_263_1.duration_ = 4.47

		local var_263_0 = {
			zh = 2.866,
			ja = 4.466
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
				arg_263_0:Play410101064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1060"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1060 = var_266_0.localPosition
				var_266_0.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1060", 2)

				local var_266_2 = var_266_0.childCount

				for iter_266_0 = 0, var_266_2 - 1 do
					local var_266_3 = var_266_0:GetChild(iter_266_0)

					if var_266_3.name == "" or not string.find(var_266_3.name, "split") then
						var_266_3.gameObject:SetActive(true)
					else
						var_266_3.gameObject:SetActive(false)
					end
				end
			end

			local var_266_4 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_4 then
				local var_266_5 = (arg_263_1.time_ - var_266_1) / var_266_4
				local var_266_6 = Vector3.New(-440.94, -430.8, 6.9)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1060, var_266_6, var_266_5)
			end

			if arg_263_1.time_ >= var_266_1 + var_266_4 and arg_263_1.time_ < var_266_1 + var_266_4 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_266_7 = arg_263_1.actors_["1060"]
			local var_266_8 = 0

			if var_266_8 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 and not isNil(var_266_7) and arg_263_1.var_.actorSpriteComps1060 == nil then
				arg_263_1.var_.actorSpriteComps1060 = var_266_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_9 = 0.034

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_9 and not isNil(var_266_7) then
				local var_266_10 = (arg_263_1.time_ - var_266_8) / var_266_9

				if arg_263_1.var_.actorSpriteComps1060 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								local var_266_11 = Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor1.r, var_266_10)
								local var_266_12 = Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor1.g, var_266_10)
								local var_266_13 = Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor1.b, var_266_10)

								iter_266_2.color = Color.New(var_266_11, var_266_12, var_266_13)
							else
								local var_266_14 = Mathf.Lerp(iter_266_2.color.r, 1, var_266_10)

								iter_266_2.color = Color.New(var_266_14, var_266_14, var_266_14)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_8 + var_266_9 and arg_263_1.time_ < var_266_8 + var_266_9 + arg_266_0 and not isNil(var_266_7) and arg_263_1.var_.actorSpriteComps1060 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_266_4 then
						if arg_263_1.isInRecall_ then
							iter_266_4.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1060 = nil
			end

			local var_266_15 = arg_263_1.actors_["1012"]
			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.actorSpriteComps1012 == nil then
				arg_263_1.var_.actorSpriteComps1012 = var_266_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_17 = 0.034

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_17 and not isNil(var_266_15) then
				local var_266_18 = (arg_263_1.time_ - var_266_16) / var_266_17

				if arg_263_1.var_.actorSpriteComps1012 then
					for iter_266_5, iter_266_6 in pairs(arg_263_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_266_6 then
							if arg_263_1.isInRecall_ then
								local var_266_19 = Mathf.Lerp(iter_266_6.color.r, arg_263_1.hightColor2.r, var_266_18)
								local var_266_20 = Mathf.Lerp(iter_266_6.color.g, arg_263_1.hightColor2.g, var_266_18)
								local var_266_21 = Mathf.Lerp(iter_266_6.color.b, arg_263_1.hightColor2.b, var_266_18)

								iter_266_6.color = Color.New(var_266_19, var_266_20, var_266_21)
							else
								local var_266_22 = Mathf.Lerp(iter_266_6.color.r, 0.5, var_266_18)

								iter_266_6.color = Color.New(var_266_22, var_266_22, var_266_22)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.actorSpriteComps1012 then
				for iter_266_7, iter_266_8 in pairs(arg_263_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_266_8 then
						if arg_263_1.isInRecall_ then
							iter_266_8.color = arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_266_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1012 = nil
			end

			local var_266_23 = 0
			local var_266_24 = 0.3

			if var_266_23 < arg_263_1.time_ and arg_263_1.time_ <= var_266_23 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_25 = arg_263_1:FormatText(StoryNameCfg[584].name)

				arg_263_1.leftNameTxt_.text = var_266_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_26 = arg_263_1:GetWordFromCfg(410101063)
				local var_266_27 = arg_263_1:FormatText(var_266_26.content)

				arg_263_1.text_.text = var_266_27

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_28 = 12
				local var_266_29 = utf8.len(var_266_27)
				local var_266_30 = var_266_28 <= 0 and var_266_24 or var_266_24 * (var_266_29 / var_266_28)

				if var_266_30 > 0 and var_266_24 < var_266_30 then
					arg_263_1.talkMaxDuration = var_266_30

					if var_266_30 + var_266_23 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_30 + var_266_23
					end
				end

				arg_263_1.text_.text = var_266_27
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101063", "story_v_out_410101.awb") ~= 0 then
					local var_266_31 = manager.audio:GetVoiceLength("story_v_out_410101", "410101063", "story_v_out_410101.awb") / 1000

					if var_266_31 + var_266_23 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_31 + var_266_23
					end

					if var_266_26.prefab_name ~= "" and arg_263_1.actors_[var_266_26.prefab_name] ~= nil then
						local var_266_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_26.prefab_name].transform, "story_v_out_410101", "410101063", "story_v_out_410101.awb")

						arg_263_1:RecordAudio("410101063", var_266_32)
						arg_263_1:RecordAudio("410101063", var_266_32)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_410101", "410101063", "story_v_out_410101.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_410101", "410101063", "story_v_out_410101.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_33 = math.max(var_266_24, arg_263_1.talkMaxDuration)

			if var_266_23 <= arg_263_1.time_ and arg_263_1.time_ < var_266_23 + var_266_33 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_23) / var_266_33

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_23 + var_266_33 and arg_263_1.time_ < var_266_23 + var_266_33 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play410101064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 410101064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play410101065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1012"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1012 = var_270_0.localPosition
				var_270_0.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1012", 7)

				local var_270_2 = var_270_0.childCount

				for iter_270_0 = 0, var_270_2 - 1 do
					local var_270_3 = var_270_0:GetChild(iter_270_0)

					if var_270_3.name == "" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_4 then
				local var_270_5 = (arg_267_1.time_ - var_270_1) / var_270_4
				local var_270_6 = Vector3.New(0, -2000, 300)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1012, var_270_6, var_270_5)
			end

			if arg_267_1.time_ >= var_270_1 + var_270_4 and arg_267_1.time_ < var_270_1 + var_270_4 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_270_7 = arg_267_1.actors_["1060"].transform
			local var_270_8 = 0

			if var_270_8 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.var_.moveOldPos1060 = var_270_7.localPosition
				var_270_7.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1060", 7)

				local var_270_9 = var_270_7.childCount

				for iter_270_1 = 0, var_270_9 - 1 do
					local var_270_10 = var_270_7:GetChild(iter_270_1)

					if var_270_10.name == "" or not string.find(var_270_10.name, "split") then
						var_270_10.gameObject:SetActive(true)
					else
						var_270_10.gameObject:SetActive(false)
					end
				end
			end

			local var_270_11 = 0.001

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_11 then
				local var_270_12 = (arg_267_1.time_ - var_270_8) / var_270_11
				local var_270_13 = Vector3.New(0, -2000, -40)

				var_270_7.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1060, var_270_13, var_270_12)
			end

			if arg_267_1.time_ >= var_270_8 + var_270_11 and arg_267_1.time_ < var_270_8 + var_270_11 + arg_270_0 then
				var_270_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_270_14 = 0
			local var_270_15 = 1.175

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_16 = arg_267_1:GetWordFromCfg(410101064)
				local var_270_17 = arg_267_1:FormatText(var_270_16.content)

				arg_267_1.text_.text = var_270_17

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_18 = 47
				local var_270_19 = utf8.len(var_270_17)
				local var_270_20 = var_270_18 <= 0 and var_270_15 or var_270_15 * (var_270_19 / var_270_18)

				if var_270_20 > 0 and var_270_15 < var_270_20 then
					arg_267_1.talkMaxDuration = var_270_20

					if var_270_20 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_14
					end
				end

				arg_267_1.text_.text = var_270_17
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_21 = math.max(var_270_15, arg_267_1.talkMaxDuration)

			if var_270_14 <= arg_267_1.time_ and arg_267_1.time_ < var_270_14 + var_270_21 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_14) / var_270_21

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_14 + var_270_21 and arg_267_1.time_ < var_270_14 + var_270_21 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
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

		arg_267_1:InitPlayNodeList()
	end,
	Play410101065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 410101065
		arg_271_1.duration_ = 4.67

		local var_271_0 = {
			zh = 4.666,
			ja = 3.666
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play410101066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1012"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1012 = var_274_0.localPosition
				var_274_0.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1012", 3)

				local var_274_2 = var_274_0.childCount

				for iter_274_0 = 0, var_274_2 - 1 do
					local var_274_3 = var_274_0:GetChild(iter_274_0)

					if var_274_3.name == "" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_4 then
				local var_274_5 = (arg_271_1.time_ - var_274_1) / var_274_4
				local var_274_6 = Vector3.New(0, -465, 300)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1012, var_274_6, var_274_5)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_4 and arg_271_1.time_ < var_274_1 + var_274_4 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(0, -465, 300)
			end

			local var_274_7 = arg_271_1.actors_["1012"]
			local var_274_8 = 0

			if var_274_8 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1012 == nil then
				arg_271_1.var_.actorSpriteComps1012 = var_274_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_9 = 0.034

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_9 and not isNil(var_274_7) then
				local var_274_10 = (arg_271_1.time_ - var_274_8) / var_274_9

				if arg_271_1.var_.actorSpriteComps1012 then
					for iter_274_1, iter_274_2 in pairs(arg_271_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_271_1.time_ >= var_274_8 + var_274_9 and arg_271_1.time_ < var_274_8 + var_274_9 + arg_274_0 and not isNil(var_274_7) and arg_271_1.var_.actorSpriteComps1012 then
				for iter_274_3, iter_274_4 in pairs(arg_271_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_274_4 then
						if arg_271_1.isInRecall_ then
							iter_274_4.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1012 = nil
			end

			local var_274_15 = 0
			local var_274_16 = 0.6

			if var_274_15 < arg_271_1.time_ and arg_271_1.time_ <= var_274_15 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_17 = arg_271_1:FormatText(StoryNameCfg[595].name)

				arg_271_1.leftNameTxt_.text = var_274_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_18 = arg_271_1:GetWordFromCfg(410101065)
				local var_274_19 = arg_271_1:FormatText(var_274_18.content)

				arg_271_1.text_.text = var_274_19

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_20 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101065", "story_v_out_410101.awb") ~= 0 then
					local var_274_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101065", "story_v_out_410101.awb") / 1000

					if var_274_23 + var_274_15 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_15
					end

					if var_274_18.prefab_name ~= "" and arg_271_1.actors_[var_274_18.prefab_name] ~= nil then
						local var_274_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_18.prefab_name].transform, "story_v_out_410101", "410101065", "story_v_out_410101.awb")

						arg_271_1:RecordAudio("410101065", var_274_24)
						arg_271_1:RecordAudio("410101065", var_274_24)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_410101", "410101065", "story_v_out_410101.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_410101", "410101065", "story_v_out_410101.awb")
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
				actorName = "1012",
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
	Play410101066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 410101066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play410101067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1012"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1012 == nil then
				arg_275_1.var_.actorSpriteComps1012 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.034

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1012 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor2.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor2.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor2.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 0.5, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1012 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1012 = nil
			end

			local var_278_8 = 0
			local var_278_9 = 1.05

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(410101066)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 42
				local var_278_13 = utf8.len(var_278_11)
				local var_278_14 = var_278_12 <= 0 and var_278_9 or var_278_9 * (var_278_13 / var_278_12)

				if var_278_14 > 0 and var_278_9 < var_278_14 then
					arg_275_1.talkMaxDuration = var_278_14

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_15 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_15 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_15

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_15 and arg_275_1.time_ < var_278_8 + var_278_15 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play410101067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 410101067
		arg_279_1.duration_ = 8.5

		local var_279_0 = {
			zh = 3.066,
			ja = 8.5
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
			arg_279_1.auto_ = false
		end

		function arg_279_1.playNext_(arg_281_0)
			arg_279_1.onStoryFinished_()
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1012"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1012 = var_282_0.localPosition
				var_282_0.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1012", 3)

				local var_282_2 = var_282_0.childCount

				for iter_282_0 = 0, var_282_2 - 1 do
					local var_282_3 = var_282_0:GetChild(iter_282_0)

					if var_282_3.name == "split_3" or not string.find(var_282_3.name, "split") then
						var_282_3.gameObject:SetActive(true)
					else
						var_282_3.gameObject:SetActive(false)
					end
				end
			end

			local var_282_4 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_4 then
				local var_282_5 = (arg_279_1.time_ - var_282_1) / var_282_4
				local var_282_6 = Vector3.New(0, -465, 300)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1012, var_282_6, var_282_5)
			end

			if arg_279_1.time_ >= var_282_1 + var_282_4 and arg_279_1.time_ < var_282_1 + var_282_4 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, -465, 300)
			end

			local var_282_7 = arg_279_1.actors_["1012"]
			local var_282_8 = 0

			if var_282_8 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 and not isNil(var_282_7) and arg_279_1.var_.actorSpriteComps1012 == nil then
				arg_279_1.var_.actorSpriteComps1012 = var_282_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_9 = 0.034

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_9 and not isNil(var_282_7) then
				local var_282_10 = (arg_279_1.time_ - var_282_8) / var_282_9

				if arg_279_1.var_.actorSpriteComps1012 then
					for iter_282_1, iter_282_2 in pairs(arg_279_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_282_2 then
							if arg_279_1.isInRecall_ then
								local var_282_11 = Mathf.Lerp(iter_282_2.color.r, arg_279_1.hightColor1.r, var_282_10)
								local var_282_12 = Mathf.Lerp(iter_282_2.color.g, arg_279_1.hightColor1.g, var_282_10)
								local var_282_13 = Mathf.Lerp(iter_282_2.color.b, arg_279_1.hightColor1.b, var_282_10)

								iter_282_2.color = Color.New(var_282_11, var_282_12, var_282_13)
							else
								local var_282_14 = Mathf.Lerp(iter_282_2.color.r, 1, var_282_10)

								iter_282_2.color = Color.New(var_282_14, var_282_14, var_282_14)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_8 + var_282_9 and arg_279_1.time_ < var_282_8 + var_282_9 + arg_282_0 and not isNil(var_282_7) and arg_279_1.var_.actorSpriteComps1012 then
				for iter_282_3, iter_282_4 in pairs(arg_279_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_282_4 then
						if arg_279_1.isInRecall_ then
							iter_282_4.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1012 = nil
			end

			local var_282_15 = 0
			local var_282_16 = 0.25

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[595].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(410101067)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 10
				local var_282_21 = utf8.len(var_282_19)
				local var_282_22 = var_282_20 <= 0 and var_282_16 or var_282_16 * (var_282_21 / var_282_20)

				if var_282_22 > 0 and var_282_16 < var_282_22 then
					arg_279_1.talkMaxDuration = var_282_22

					if var_282_22 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_22 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_19
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410101", "410101067", "story_v_out_410101.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_410101", "410101067", "story_v_out_410101.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_410101", "410101067", "story_v_out_410101.awb")

						arg_279_1:RecordAudio("410101067", var_282_24)
						arg_279_1:RecordAudio("410101067", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_410101", "410101067", "story_v_out_410101.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_410101", "410101067", "story_v_out_410101.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_25 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_25 and arg_279_1.time_ < var_282_15 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02c",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31a",
		"TextureConfig/Background/L02g"
	},
	voices = {
		"story_v_out_410101.awb"
	}
}
