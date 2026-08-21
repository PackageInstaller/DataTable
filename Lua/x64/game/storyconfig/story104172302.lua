return {
	Play417232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417232001
		arg_1_1.duration_ = 3.27

		local var_1_0 = {
			zh = 2.966,
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
				arg_1_0:Play417232002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2102"

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
				local var_4_5 = arg_1_1.bgs_.ST2102

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
					if iter_4_0 ~= "ST2102" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.00008890058234e-12

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

			local var_4_22 = "10111"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

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

			local var_4_26 = arg_1_1.actors_["10111"]
			local var_4_27 = 1.66666666666667

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 and not isNil(var_4_26) and arg_1_1.var_.actorSpriteComps10111 == nil then
				arg_1_1.var_.actorSpriteComps10111 = var_4_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_28 = 0.2

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 and not isNil(var_4_26) then
				local var_4_29 = (arg_1_1.time_ - var_4_27) / var_4_28

				if arg_1_1.var_.actorSpriteComps10111 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_30 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_29)
								local var_4_31 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_29)
								local var_4_32 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_29)

								iter_4_5.color = Color.New(var_4_30, var_4_31, var_4_32)
							else
								local var_4_33 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_29)

								iter_4_5.color = Color.New(var_4_33, var_4_33, var_4_33)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 and not isNil(var_4_26) and arg_1_1.var_.actorSpriteComps10111 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10111 = nil
			end

			local var_4_34 = arg_1_1.actors_["10111"].transform
			local var_4_35 = 1.66666666666667

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.var_.moveOldPos10111 = var_4_34.localPosition
				var_4_34.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10111", 3)

				local var_4_36 = var_4_34.childCount

				for iter_4_8 = 0, var_4_36 - 1 do
					local var_4_37 = var_4_34:GetChild(iter_4_8)

					if var_4_37.name == "" or not string.find(var_4_37.name, "split") then
						var_4_37.gameObject:SetActive(true)
					else
						var_4_37.gameObject:SetActive(false)
					end
				end
			end

			local var_4_38 = 0.001

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_35) / var_4_38
				local var_4_40 = Vector3.New(0, -361.1, -274.6)

				var_4_34.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10111, var_4_40, var_4_39)
			end

			if arg_1_1.time_ >= var_4_35 + var_4_38 and arg_1_1.time_ < var_4_35 + var_4_38 + arg_4_0 then
				var_4_34.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_4_41 = arg_1_1.actors_["10111"]
			local var_4_42 = 1.66666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_43 then
					arg_1_1.var_.alphaOldValue10111 = var_4_43.alpha
					arg_1_1.var_.characterEffect10111 = var_4_43
				end

				arg_1_1.var_.alphaOldValue10111 = 0
			end

			local var_4_44 = 0.333333333333333

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10111, 1, var_4_45)

				if arg_1_1.var_.characterEffect10111 then
					arg_1_1.var_.characterEffect10111.alpha = var_4_46
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.characterEffect10111 then
				arg_1_1.var_.characterEffect10111.alpha = 1
			end

			local var_4_47 = 0

			arg_1_1.isInRecall_ = true

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					local var_4_48 = iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_11, iter_4_12 in ipairs(var_4_48) do
						if iter_4_12.color.r > 0.51 then
							iter_4_12.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_4_12.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_4_49 = 0.333333333333333

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_49 then
				local var_4_50 = (arg_1_1.time_ - var_4_47) / var_4_49

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_50)
			end

			if arg_1_1.time_ >= var_4_47 + var_4_49 and arg_1_1.time_ < var_4_47 + var_4_49 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_51 = 0
			local var_4_52 = 0.2

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_57 = 0.4
			local var_4_58 = 1

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "music"

				arg_1_1:AudioAction(var_4_59, var_4_60, "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_4_61 = ""
				local var_4_62 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if var_4_62 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_62 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_62

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_62
						arg_1_1.bgmTxt2_.text = var_4_62
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

			local var_4_63 = 0.4
			local var_4_64 = 1

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				local var_4_65 = "play"
				local var_4_66 = "effect"

				arg_1_1:AudioAction(var_4_65, var_4_66, "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_67 = 2
			local var_4_68 = 0.133333333333332

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

				local var_4_70 = arg_1_1:FormatText(StoryNameCfg[1125].name)

				arg_1_1.leftNameTxt_.text = var_4_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_71 = arg_1_1:GetWordFromCfg(417232001)
				local var_4_72 = arg_1_1:FormatText(var_4_71.content)

				arg_1_1.text_.text = var_4_72

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_73 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232001", "story_v_out_417232.awb") ~= 0 then
					local var_4_76 = manager.audio:GetVoiceLength("story_v_out_417232", "417232001", "story_v_out_417232.awb") / 1000

					if var_4_76 + var_4_67 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_67
					end

					if var_4_71.prefab_name ~= "" and arg_1_1.actors_[var_4_71.prefab_name] ~= nil then
						local var_4_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_71.prefab_name].transform, "story_v_out_417232", "417232001", "story_v_out_417232.awb")

						arg_1_1:RecordAudio("417232001", var_4_77)
						arg_1_1:RecordAudio("417232001", var_4_77)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417232", "417232001", "story_v_out_417232.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417232", "417232001", "story_v_out_417232.awb")
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
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 417232002
		arg_9_1.duration_ = 3.27

		local var_9_0 = {
			zh = 2.166,
			ja = 3.266
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
				arg_9_0:Play417232003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10111"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10111 == nil then
				arg_9_1.var_.actorSpriteComps10111 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps10111 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10111 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10111 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.2

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[468].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_9_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_12_11 = arg_9_1:GetWordFromCfg(417232002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232002", "story_v_out_417232.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232002", "story_v_out_417232.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_417232", "417232002", "story_v_out_417232.awb")

						arg_9_1:RecordAudio("417232002", var_12_17)
						arg_9_1:RecordAudio("417232002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_417232", "417232002", "story_v_out_417232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_417232", "417232002", "story_v_out_417232.awb")
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
	Play417232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 417232003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play417232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.499999999999
			local var_16_1 = 1

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				local var_16_2 = "play"
				local var_16_3 = "effect"

				arg_13_1:AudioAction(var_16_2, var_16_3, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_16_4 = 0
			local var_16_5 = 0.75

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(417232003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_8 = 30
				local var_16_9 = utf8.len(var_16_7)
				local var_16_10 = var_16_8 <= 0 and var_16_5 or var_16_5 * (var_16_9 / var_16_8)

				if var_16_10 > 0 and var_16_5 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_11 and arg_13_1.time_ < var_16_4 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play417232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 417232004
		arg_17_1.duration_ = 2.03

		local var_17_0 = {
			zh = 1.566,
			ja = 2.033
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
				arg_17_0:Play417232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10111"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10111 == nil then
				arg_17_1.var_.actorSpriteComps10111 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10111 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 1, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10111 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10111 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.125

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[1125].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(417232004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232004", "story_v_out_417232.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232004", "story_v_out_417232.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_417232", "417232004", "story_v_out_417232.awb")

						arg_17_1:RecordAudio("417232004", var_20_17)
						arg_17_1:RecordAudio("417232004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_417232", "417232004", "story_v_out_417232.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_417232", "417232004", "story_v_out_417232.awb")
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
	Play417232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 417232005
		arg_21_1.duration_ = 6.97

		local var_21_0 = {
			zh = 6.966,
			ja = 5.6
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
				arg_21_0:Play417232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10111"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10111 == nil then
				arg_21_1.var_.actorSpriteComps10111 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10111 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10111 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10111 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.425

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[468].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_21_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_24_11 = arg_21_1:GetWordFromCfg(417232005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232005", "story_v_out_417232.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232005", "story_v_out_417232.awb") / 1000

					if var_24_16 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_8
					end

					if var_24_11.prefab_name ~= "" and arg_21_1.actors_[var_24_11.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_11.prefab_name].transform, "story_v_out_417232", "417232005", "story_v_out_417232.awb")

						arg_21_1:RecordAudio("417232005", var_24_17)
						arg_21_1:RecordAudio("417232005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_417232", "417232005", "story_v_out_417232.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_417232", "417232005", "story_v_out_417232.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_18 and arg_21_1.time_ < var_24_8 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play417232006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 417232006
		arg_25_1.duration_ = 4.17

		local var_25_0 = {
			zh = 2.633,
			ja = 4.166
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
				arg_25_0:Play417232007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.25

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[468].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_25_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_28_3 = arg_25_1:GetWordFromCfg(417232006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 10
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232006", "story_v_out_417232.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232006", "story_v_out_417232.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_417232", "417232006", "story_v_out_417232.awb")

						arg_25_1:RecordAudio("417232006", var_28_9)
						arg_25_1:RecordAudio("417232006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_417232", "417232006", "story_v_out_417232.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_417232", "417232006", "story_v_out_417232.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play417232007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 417232007
		arg_29_1.duration_ = 3.97

		local var_29_0 = {
			zh = 2.1,
			ja = 3.966
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
				arg_29_0:Play417232008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10111"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10111 == nil then
				arg_29_1.var_.actorSpriteComps10111 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10111 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 1, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10111 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10111 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.25

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[1125].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_11 = arg_29_1:GetWordFromCfg(417232007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 10
				local var_32_14 = utf8.len(var_32_12)
				local var_32_15 = var_32_13 <= 0 and var_32_9 or var_32_9 * (var_32_14 / var_32_13)

				if var_32_15 > 0 and var_32_9 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232007", "story_v_out_417232.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232007", "story_v_out_417232.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_417232", "417232007", "story_v_out_417232.awb")

						arg_29_1:RecordAudio("417232007", var_32_17)
						arg_29_1:RecordAudio("417232007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_417232", "417232007", "story_v_out_417232.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_417232", "417232007", "story_v_out_417232.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_18 and arg_29_1.time_ < var_32_8 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play417232008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 417232008
		arg_33_1.duration_ = 9.3

		local var_33_0 = {
			zh = 7.2,
			ja = 9.3
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
				arg_33_0:Play417232009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10111"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10111 == nil then
				arg_33_1.var_.actorSpriteComps10111 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10111 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								local var_36_4 = Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, var_36_3)
								local var_36_5 = Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, var_36_3)
								local var_36_6 = Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, var_36_3)

								iter_36_1.color = Color.New(var_36_4, var_36_5, var_36_6)
							else
								local var_36_7 = Mathf.Lerp(iter_36_1.color.r, 0.5, var_36_3)

								iter_36_1.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10111 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10111 = nil
			end

			local var_36_8 = 0
			local var_36_9 = 0.7

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_10 = arg_33_1:FormatText(StoryNameCfg[468].name)

				arg_33_1.leftNameTxt_.text = var_36_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_33_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_36_11 = arg_33_1:GetWordFromCfg(417232008)
				local var_36_12 = arg_33_1:FormatText(var_36_11.content)

				arg_33_1.text_.text = var_36_12

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 28
				local var_36_14 = utf8.len(var_36_12)
				local var_36_15 = var_36_13 <= 0 and var_36_9 or var_36_9 * (var_36_14 / var_36_13)

				if var_36_15 > 0 and var_36_9 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_12
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232008", "story_v_out_417232.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232008", "story_v_out_417232.awb") / 1000

					if var_36_16 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_8
					end

					if var_36_11.prefab_name ~= "" and arg_33_1.actors_[var_36_11.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_11.prefab_name].transform, "story_v_out_417232", "417232008", "story_v_out_417232.awb")

						arg_33_1:RecordAudio("417232008", var_36_17)
						arg_33_1:RecordAudio("417232008", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_417232", "417232008", "story_v_out_417232.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_417232", "417232008", "story_v_out_417232.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_18 and arg_33_1.time_ < var_36_8 + var_36_18 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play417232009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 417232009
		arg_37_1.duration_ = 6.7

		local var_37_0 = {
			zh = 5.966,
			ja = 6.7
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
				arg_37_0:Play417232010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.6

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[468].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_37_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_40_3 = arg_37_1:GetWordFromCfg(417232009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 24
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232009", "story_v_out_417232.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232009", "story_v_out_417232.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_417232", "417232009", "story_v_out_417232.awb")

						arg_37_1:RecordAudio("417232009", var_40_9)
						arg_37_1:RecordAudio("417232009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_417232", "417232009", "story_v_out_417232.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_417232", "417232009", "story_v_out_417232.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play417232010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 417232010
		arg_41_1.duration_ = 7.53

		local var_41_0 = {
			zh = 5,
			ja = 7.533
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
				arg_41_0:Play417232011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10111"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10111 == nil then
				arg_41_1.var_.actorSpriteComps10111 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10111 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10111 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10111 = nil
			end

			local var_44_8 = 0
			local var_44_9 = 0.45

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_10 = arg_41_1:FormatText(StoryNameCfg[1125].name)

				arg_41_1.leftNameTxt_.text = var_44_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_11 = arg_41_1:GetWordFromCfg(417232010)
				local var_44_12 = arg_41_1:FormatText(var_44_11.content)

				arg_41_1.text_.text = var_44_12

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 18
				local var_44_14 = utf8.len(var_44_12)
				local var_44_15 = var_44_13 <= 0 and var_44_9 or var_44_9 * (var_44_14 / var_44_13)

				if var_44_15 > 0 and var_44_9 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_12
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232010", "story_v_out_417232.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232010", "story_v_out_417232.awb") / 1000

					if var_44_16 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_8
					end

					if var_44_11.prefab_name ~= "" and arg_41_1.actors_[var_44_11.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_11.prefab_name].transform, "story_v_out_417232", "417232010", "story_v_out_417232.awb")

						arg_41_1:RecordAudio("417232010", var_44_17)
						arg_41_1:RecordAudio("417232010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_417232", "417232010", "story_v_out_417232.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_417232", "417232010", "story_v_out_417232.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_18 and arg_41_1.time_ < var_44_8 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play417232011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 417232011
		arg_45_1.duration_ = 6.53

		local var_45_0 = {
			zh = 5.666,
			ja = 6.533
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
				arg_45_0:Play417232012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "10049"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10049")

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

			local var_48_4 = arg_45_1.actors_["10049"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps10049 == nil then
				arg_45_1.var_.actorSpriteComps10049 = var_48_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_6 = 0.2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.actorSpriteComps10049 then
					for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10049:ToTable()) do
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

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.actorSpriteComps10049 then
				for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps10049:ToTable()) do
					if iter_48_5 then
						if arg_45_1.isInRecall_ then
							iter_48_5.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10049 = nil
			end

			local var_48_12 = arg_45_1.actors_["10111"]
			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps10111 == nil then
				arg_45_1.var_.actorSpriteComps10111 = var_48_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_14 = 0.2

			if var_48_13 <= arg_45_1.time_ and arg_45_1.time_ < var_48_13 + var_48_14 and not isNil(var_48_12) then
				local var_48_15 = (arg_45_1.time_ - var_48_13) / var_48_14

				if arg_45_1.var_.actorSpriteComps10111 then
					for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_45_1.time_ >= var_48_13 + var_48_14 and arg_45_1.time_ < var_48_13 + var_48_14 + arg_48_0 and not isNil(var_48_12) and arg_45_1.var_.actorSpriteComps10111 then
				for iter_48_8, iter_48_9 in pairs(arg_45_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_48_9 then
						if arg_45_1.isInRecall_ then
							iter_48_9.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10111 = nil
			end

			local var_48_20 = 0
			local var_48_21 = 0.35

			if var_48_20 < arg_45_1.time_ and arg_45_1.time_ <= var_48_20 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_22 = arg_45_1:FormatText(StoryNameCfg[468].name)

				arg_45_1.leftNameTxt_.text = var_48_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_45_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_48_23 = arg_45_1:GetWordFromCfg(417232011)
				local var_48_24 = arg_45_1:FormatText(var_48_23.content)

				arg_45_1.text_.text = var_48_24

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_25 = 14
				local var_48_26 = utf8.len(var_48_24)
				local var_48_27 = var_48_25 <= 0 and var_48_21 or var_48_21 * (var_48_26 / var_48_25)

				if var_48_27 > 0 and var_48_21 < var_48_27 then
					arg_45_1.talkMaxDuration = var_48_27

					if var_48_27 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_27 + var_48_20
					end
				end

				arg_45_1.text_.text = var_48_24
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232011", "story_v_out_417232.awb") ~= 0 then
					local var_48_28 = manager.audio:GetVoiceLength("story_v_out_417232", "417232011", "story_v_out_417232.awb") / 1000

					if var_48_28 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_28 + var_48_20
					end

					if var_48_23.prefab_name ~= "" and arg_45_1.actors_[var_48_23.prefab_name] ~= nil then
						local var_48_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_23.prefab_name].transform, "story_v_out_417232", "417232011", "story_v_out_417232.awb")

						arg_45_1:RecordAudio("417232011", var_48_29)
						arg_45_1:RecordAudio("417232011", var_48_29)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_417232", "417232011", "story_v_out_417232.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_417232", "417232011", "story_v_out_417232.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_30 = math.max(var_48_21, arg_45_1.talkMaxDuration)

			if var_48_20 <= arg_45_1.time_ and arg_45_1.time_ < var_48_20 + var_48_30 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_20) / var_48_30

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_20 + var_48_30 and arg_45_1.time_ < var_48_20 + var_48_30 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play417232012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 417232012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play417232013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10111"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10111 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10111", 7)

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
				local var_52_6 = Vector3.New(0, -2000, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10111, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_7 = 0
			local var_52_8 = 0.4

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(417232012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 16
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_8 or var_52_8 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_8 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_14 and arg_49_1.time_ < var_52_7 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 417232013
		arg_53_1.duration_ = 13.6

		local var_53_0 = {
			zh = 12.733,
			ja = 13.6
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
				arg_53_0:Play417232014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.3

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[468].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_53_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_56_3 = arg_53_1:GetWordFromCfg(417232013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 52
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232013", "story_v_out_417232.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232013", "story_v_out_417232.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_417232", "417232013", "story_v_out_417232.awb")

						arg_53_1:RecordAudio("417232013", var_56_9)
						arg_53_1:RecordAudio("417232013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_417232", "417232013", "story_v_out_417232.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_417232", "417232013", "story_v_out_417232.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play417232014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 417232014
		arg_57_1.duration_ = 8.23

		local var_57_0 = {
			zh = 7.4,
			ja = 8.233
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
				arg_57_0:Play417232015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10111"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10111 == nil then
				arg_57_1.var_.actorSpriteComps10111 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10111 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 1, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10111 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10111 = nil
			end

			local var_60_8 = arg_57_1.actors_["10111"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos10111 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10111", 3)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "split_6" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(0, -361.1, -274.6)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10111, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_60_15 = 0
			local var_60_16 = 0.825

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_17 = arg_57_1:FormatText(StoryNameCfg[1125].name)

				arg_57_1.leftNameTxt_.text = var_60_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_18 = arg_57_1:GetWordFromCfg(417232014)
				local var_60_19 = arg_57_1:FormatText(var_60_18.content)

				arg_57_1.text_.text = var_60_19

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_20 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232014", "story_v_out_417232.awb") ~= 0 then
					local var_60_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232014", "story_v_out_417232.awb") / 1000

					if var_60_23 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_15
					end

					if var_60_18.prefab_name ~= "" and arg_57_1.actors_[var_60_18.prefab_name] ~= nil then
						local var_60_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_18.prefab_name].transform, "story_v_out_417232", "417232014", "story_v_out_417232.awb")

						arg_57_1:RecordAudio("417232014", var_60_24)
						arg_57_1:RecordAudio("417232014", var_60_24)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_417232", "417232014", "story_v_out_417232.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_417232", "417232014", "story_v_out_417232.awb")
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
				actorName = "10111",
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
	Play417232015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 417232015
		arg_61_1.duration_ = 9.27

		local var_61_0 = {
			zh = 7.433,
			ja = 9.266
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
				arg_61_0:Play417232016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10111"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10111 == nil then
				arg_61_1.var_.actorSpriteComps10111 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10111 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10111 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10111 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 0.75

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[468].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_61_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_64_11 = arg_61_1:GetWordFromCfg(417232015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232015", "story_v_out_417232.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232015", "story_v_out_417232.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_417232", "417232015", "story_v_out_417232.awb")

						arg_61_1:RecordAudio("417232015", var_64_17)
						arg_61_1:RecordAudio("417232015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_417232", "417232015", "story_v_out_417232.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_417232", "417232015", "story_v_out_417232.awb")
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
	Play417232016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 417232016
		arg_65_1.duration_ = 10.6

		local var_65_0 = {
			zh = 8.4,
			ja = 10.6
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
				arg_65_0:Play417232017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.975

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[468].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_65_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_68_3 = arg_65_1:GetWordFromCfg(417232016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232016", "story_v_out_417232.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232016", "story_v_out_417232.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_417232", "417232016", "story_v_out_417232.awb")

						arg_65_1:RecordAudio("417232016", var_68_9)
						arg_65_1:RecordAudio("417232016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_417232", "417232016", "story_v_out_417232.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_417232", "417232016", "story_v_out_417232.awb")
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
	Play417232017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 417232017
		arg_69_1.duration_ = 11.13

		local var_69_0 = {
			zh = 7.633,
			ja = 11.133
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
				arg_69_0:Play417232018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10111"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10111 == nil then
				arg_69_1.var_.actorSpriteComps10111 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10111 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10111 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10111 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 0.825

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_10 = arg_69_1:FormatText(StoryNameCfg[1125].name)

				arg_69_1.leftNameTxt_.text = var_72_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:GetWordFromCfg(417232017)
				local var_72_12 = arg_69_1:FormatText(var_72_11.content)

				arg_69_1.text_.text = var_72_12

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 33
				local var_72_14 = utf8.len(var_72_12)
				local var_72_15 = var_72_13 <= 0 and var_72_9 or var_72_9 * (var_72_14 / var_72_13)

				if var_72_15 > 0 and var_72_9 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_12
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232017", "story_v_out_417232.awb") ~= 0 then
					local var_72_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232017", "story_v_out_417232.awb") / 1000

					if var_72_16 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_8
					end

					if var_72_11.prefab_name ~= "" and arg_69_1.actors_[var_72_11.prefab_name] ~= nil then
						local var_72_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_11.prefab_name].transform, "story_v_out_417232", "417232017", "story_v_out_417232.awb")

						arg_69_1:RecordAudio("417232017", var_72_17)
						arg_69_1:RecordAudio("417232017", var_72_17)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_417232", "417232017", "story_v_out_417232.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_417232", "417232017", "story_v_out_417232.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_18 and arg_69_1.time_ < var_72_8 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play417232018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 417232018
		arg_73_1.duration_ = 4.73

		local var_73_0 = {
			zh = 4.733,
			ja = 4.633
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
				arg_73_0:Play417232019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10111"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10111 == nil then
				arg_73_1.var_.actorSpriteComps10111 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10111 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10111 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10111 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.5

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[468].name)

				arg_73_1.leftNameTxt_.text = var_76_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_73_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_76_11 = arg_73_1:GetWordFromCfg(417232018)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232018", "story_v_out_417232.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232018", "story_v_out_417232.awb") / 1000

					if var_76_16 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_8
					end

					if var_76_11.prefab_name ~= "" and arg_73_1.actors_[var_76_11.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_11.prefab_name].transform, "story_v_out_417232", "417232018", "story_v_out_417232.awb")

						arg_73_1:RecordAudio("417232018", var_76_17)
						arg_73_1:RecordAudio("417232018", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_417232", "417232018", "story_v_out_417232.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_417232", "417232018", "story_v_out_417232.awb")
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
	Play417232019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 417232019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play417232020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10049"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10049 == nil then
				arg_77_1.var_.actorSpriteComps10049 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10049 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10049:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 0.5, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10049 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10049:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10049 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.625

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(417232019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_12 = 25
				local var_80_13 = utf8.len(var_80_11)
				local var_80_14 = var_80_12 <= 0 and var_80_9 or var_80_9 * (var_80_13 / var_80_12)

				if var_80_14 > 0 and var_80_9 < var_80_14 then
					arg_77_1.talkMaxDuration = var_80_14

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_15 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_15 and arg_77_1.time_ < var_80_8 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play417232020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 417232020
		arg_81_1.duration_ = 7.1

		local var_81_0 = {
			zh = 6.3,
			ja = 7.1
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
				arg_81_0:Play417232021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10049"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10049 == nil then
				arg_81_1.var_.actorSpriteComps10049 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10049 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10049:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10049 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10049:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10049 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.625

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_10 = arg_81_1:FormatText(StoryNameCfg[468].name)

				arg_81_1.leftNameTxt_.text = var_84_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_81_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_84_11 = arg_81_1:GetWordFromCfg(417232020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 25
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_9 or var_84_9 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_9 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232020", "story_v_out_417232.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232020", "story_v_out_417232.awb") / 1000

					if var_84_16 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_8
					end

					if var_84_11.prefab_name ~= "" and arg_81_1.actors_[var_84_11.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_11.prefab_name].transform, "story_v_out_417232", "417232020", "story_v_out_417232.awb")

						arg_81_1:RecordAudio("417232020", var_84_17)
						arg_81_1:RecordAudio("417232020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_417232", "417232020", "story_v_out_417232.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_417232", "417232020", "story_v_out_417232.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_18 and arg_81_1.time_ < var_84_8 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play417232021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 417232021
		arg_85_1.duration_ = 8.17

		local var_85_0 = {
			zh = 7.033,
			ja = 8.166
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
				arg_85_0:Play417232022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.725

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[468].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_85_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_88_3 = arg_85_1:GetWordFromCfg(417232021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232021", "story_v_out_417232.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232021", "story_v_out_417232.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_417232", "417232021", "story_v_out_417232.awb")

						arg_85_1:RecordAudio("417232021", var_88_9)
						arg_85_1:RecordAudio("417232021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_417232", "417232021", "story_v_out_417232.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_417232", "417232021", "story_v_out_417232.awb")
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
	Play417232022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 417232022
		arg_89_1.duration_ = 15.13

		local var_89_0 = {
			zh = 12.666,
			ja = 15.133
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
				arg_89_0:Play417232023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.25

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[468].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_89_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_92_3 = arg_89_1:GetWordFromCfg(417232022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232022", "story_v_out_417232.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232022", "story_v_out_417232.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_417232", "417232022", "story_v_out_417232.awb")

						arg_89_1:RecordAudio("417232022", var_92_9)
						arg_89_1:RecordAudio("417232022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_417232", "417232022", "story_v_out_417232.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_417232", "417232022", "story_v_out_417232.awb")
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
	Play417232023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 417232023
		arg_93_1.duration_ = 10.13

		local var_93_0 = {
			zh = 7.633,
			ja = 10.133
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
				arg_93_0:Play417232024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10111"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10111 == nil then
				arg_93_1.var_.actorSpriteComps10111 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10111 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10111 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10111 = nil
			end

			local var_96_8 = arg_93_1.actors_["10111"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos10111 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10111", 3)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "split_1" or not string.find(var_96_11.name, "split") then
						var_96_11.gameObject:SetActive(true)
					else
						var_96_11.gameObject:SetActive(false)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(0, -361.1, -274.6)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10111, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_96_15 = 0
			local var_96_16 = 0.825

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[1125].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(417232023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 33
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232023", "story_v_out_417232.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232023", "story_v_out_417232.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_417232", "417232023", "story_v_out_417232.awb")

						arg_93_1:RecordAudio("417232023", var_96_24)
						arg_93_1:RecordAudio("417232023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_417232", "417232023", "story_v_out_417232.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_417232", "417232023", "story_v_out_417232.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 417232024
		arg_97_1.duration_ = 8.1

		local var_97_0 = {
			zh = 4.566,
			ja = 8.1
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
				arg_97_0:Play417232025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10111"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10111 == nil then
				arg_97_1.var_.actorSpriteComps10111 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10111 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10111 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10111 = nil
			end

			local var_100_8 = 0
			local var_100_9 = 0.375

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_10 = arg_97_1:FormatText(StoryNameCfg[468].name)

				arg_97_1.leftNameTxt_.text = var_100_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_97_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_100_11 = arg_97_1:GetWordFromCfg(417232024)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 15
				local var_100_14 = utf8.len(var_100_12)
				local var_100_15 = var_100_13 <= 0 and var_100_9 or var_100_9 * (var_100_14 / var_100_13)

				if var_100_15 > 0 and var_100_9 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232024", "story_v_out_417232.awb") ~= 0 then
					local var_100_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232024", "story_v_out_417232.awb") / 1000

					if var_100_16 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_8
					end

					if var_100_11.prefab_name ~= "" and arg_97_1.actors_[var_100_11.prefab_name] ~= nil then
						local var_100_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_11.prefab_name].transform, "story_v_out_417232", "417232024", "story_v_out_417232.awb")

						arg_97_1:RecordAudio("417232024", var_100_17)
						arg_97_1:RecordAudio("417232024", var_100_17)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_417232", "417232024", "story_v_out_417232.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_417232", "417232024", "story_v_out_417232.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_18 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_18 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_18

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_18 and arg_97_1.time_ < var_100_8 + var_100_18 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play417232025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 417232025
		arg_101_1.duration_ = 12.9

		local var_101_0 = {
			zh = 12.5,
			ja = 12.9
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play417232026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.075

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[468].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_101_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_104_3 = arg_101_1:GetWordFromCfg(417232025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 43
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232025", "story_v_out_417232.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232025", "story_v_out_417232.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_417232", "417232025", "story_v_out_417232.awb")

						arg_101_1:RecordAudio("417232025", var_104_9)
						arg_101_1:RecordAudio("417232025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_417232", "417232025", "story_v_out_417232.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_417232", "417232025", "story_v_out_417232.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play417232026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 417232026
		arg_105_1.duration_ = 16.07

		local var_105_0 = {
			zh = 16.066,
			ja = 11.933
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
				arg_105_0:Play417232027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.35

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[468].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_105_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_108_3 = arg_105_1:GetWordFromCfg(417232026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 54
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232026", "story_v_out_417232.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232026", "story_v_out_417232.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_417232", "417232026", "story_v_out_417232.awb")

						arg_105_1:RecordAudio("417232026", var_108_9)
						arg_105_1:RecordAudio("417232026", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_417232", "417232026", "story_v_out_417232.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_417232", "417232026", "story_v_out_417232.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_10 and arg_105_1.time_ < var_108_0 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play417232027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 417232027
		arg_109_1.duration_ = 7.47

		local var_109_0 = {
			zh = 6.333,
			ja = 7.466
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
				arg_109_0:Play417232028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.525

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[468].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_109_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_112_3 = arg_109_1:GetWordFromCfg(417232027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232027", "story_v_out_417232.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232027", "story_v_out_417232.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_417232", "417232027", "story_v_out_417232.awb")

						arg_109_1:RecordAudio("417232027", var_112_9)
						arg_109_1:RecordAudio("417232027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_417232", "417232027", "story_v_out_417232.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_417232", "417232027", "story_v_out_417232.awb")
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
	Play417232028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 417232028
		arg_113_1.duration_ = 12.57

		local var_113_0 = {
			zh = 12.566,
			ja = 10.7
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
				arg_113_0:Play417232029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.075

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[468].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_113_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_116_3 = arg_113_1:GetWordFromCfg(417232028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 42
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232028", "story_v_out_417232.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232028", "story_v_out_417232.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_417232", "417232028", "story_v_out_417232.awb")

						arg_113_1:RecordAudio("417232028", var_116_9)
						arg_113_1:RecordAudio("417232028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_417232", "417232028", "story_v_out_417232.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_417232", "417232028", "story_v_out_417232.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play417232029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 417232029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play417232030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10111"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10111 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10111", 7)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(0, -2000, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10111, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_7 = 0.02
			local var_120_8 = 1

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				local var_120_9 = "play"
				local var_120_10 = "effect"

				arg_117_1:AudioAction(var_120_9, var_120_10, "se_story_1310", "se_story_1310_fish", "")
			end

			local var_120_11 = 0
			local var_120_12 = 1.225

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:GetWordFromCfg(417232029)
				local var_120_14 = arg_117_1:FormatText(var_120_13.content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_15 = 49
				local var_120_16 = utf8.len(var_120_14)
				local var_120_17 = var_120_15 <= 0 and var_120_12 or var_120_12 * (var_120_16 / var_120_15)

				if var_120_17 > 0 and var_120_12 < var_120_17 then
					arg_117_1.talkMaxDuration = var_120_17

					if var_120_17 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_18 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_18 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_18

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_18 and arg_117_1.time_ < var_120_11 + var_120_18 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play417232030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 417232030
		arg_121_1.duration_ = 9.83

		local var_121_0 = {
			zh = 5.233,
			ja = 9.833
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play417232031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10111"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10111 == nil then
				arg_121_1.var_.actorSpriteComps10111 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10111 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor1.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor1.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor1.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 1, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10111 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10111 = nil
			end

			local var_124_8 = arg_121_1.actors_["10111"].transform
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.var_.moveOldPos10111 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10111", 3)

				local var_124_10 = var_124_8.childCount

				for iter_124_4 = 0, var_124_10 - 1 do
					local var_124_11 = var_124_8:GetChild(iter_124_4)

					if var_124_11.name == "split_2" or not string.find(var_124_11.name, "split") then
						var_124_11.gameObject:SetActive(true)
					else
						var_124_11.gameObject:SetActive(false)
					end
				end
			end

			local var_124_12 = 0.001

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_12 then
				local var_124_13 = (arg_121_1.time_ - var_124_9) / var_124_12
				local var_124_14 = Vector3.New(0, -361.1, -274.6)

				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10111, var_124_14, var_124_13)
			end

			if arg_121_1.time_ >= var_124_9 + var_124_12 and arg_121_1.time_ < var_124_9 + var_124_12 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_124_15 = 0
			local var_124_16 = 0.475

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[1125].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(417232030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 19
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232030", "story_v_out_417232.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232030", "story_v_out_417232.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_417232", "417232030", "story_v_out_417232.awb")

						arg_121_1:RecordAudio("417232030", var_124_24)
						arg_121_1:RecordAudio("417232030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_417232", "417232030", "story_v_out_417232.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_417232", "417232030", "story_v_out_417232.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play417232031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 417232031
		arg_125_1.duration_ = 15.23

		local var_125_0 = {
			zh = 11.266,
			ja = 15.233
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play417232032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10049"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10049 == nil then
				arg_125_1.var_.actorSpriteComps10049 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10049 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10049:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor1.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor1.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor1.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 1, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10049 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10049:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10049 = nil
			end

			local var_128_8 = arg_125_1.actors_["10111"]
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10111 == nil then
				arg_125_1.var_.actorSpriteComps10111 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_10 = 0.2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 and not isNil(var_128_8) then
				local var_128_11 = (arg_125_1.time_ - var_128_9) / var_128_10

				if arg_125_1.var_.actorSpriteComps10111 then
					for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_128_5 then
							if arg_125_1.isInRecall_ then
								local var_128_12 = Mathf.Lerp(iter_128_5.color.r, arg_125_1.hightColor2.r, var_128_11)
								local var_128_13 = Mathf.Lerp(iter_128_5.color.g, arg_125_1.hightColor2.g, var_128_11)
								local var_128_14 = Mathf.Lerp(iter_128_5.color.b, arg_125_1.hightColor2.b, var_128_11)

								iter_128_5.color = Color.New(var_128_12, var_128_13, var_128_14)
							else
								local var_128_15 = Mathf.Lerp(iter_128_5.color.r, 0.5, var_128_11)

								iter_128_5.color = Color.New(var_128_15, var_128_15, var_128_15)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10111 then
				for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_128_7 then
						if arg_125_1.isInRecall_ then
							iter_128_7.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10111 = nil
			end

			local var_128_16 = 0
			local var_128_17 = 0.925

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_18 = arg_125_1:FormatText(StoryNameCfg[468].name)

				arg_125_1.leftNameTxt_.text = var_128_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_125_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_128_19 = arg_125_1:GetWordFromCfg(417232031)
				local var_128_20 = arg_125_1:FormatText(var_128_19.content)

				arg_125_1.text_.text = var_128_20

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_21 = 37
				local var_128_22 = utf8.len(var_128_20)
				local var_128_23 = var_128_21 <= 0 and var_128_17 or var_128_17 * (var_128_22 / var_128_21)

				if var_128_23 > 0 and var_128_17 < var_128_23 then
					arg_125_1.talkMaxDuration = var_128_23

					if var_128_23 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_16
					end
				end

				arg_125_1.text_.text = var_128_20
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232031", "story_v_out_417232.awb") ~= 0 then
					local var_128_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232031", "story_v_out_417232.awb") / 1000

					if var_128_24 + var_128_16 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_16
					end

					if var_128_19.prefab_name ~= "" and arg_125_1.actors_[var_128_19.prefab_name] ~= nil then
						local var_128_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_19.prefab_name].transform, "story_v_out_417232", "417232031", "story_v_out_417232.awb")

						arg_125_1:RecordAudio("417232031", var_128_25)
						arg_125_1:RecordAudio("417232031", var_128_25)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_417232", "417232031", "story_v_out_417232.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_417232", "417232031", "story_v_out_417232.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_26 = math.max(var_128_17, arg_125_1.talkMaxDuration)

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_26 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_16) / var_128_26

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_16 + var_128_26 and arg_125_1.time_ < var_128_16 + var_128_26 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play417232032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 417232032
		arg_129_1.duration_ = 18.4

		local var_129_0 = {
			zh = 14.666,
			ja = 18.4
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play417232033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.225

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[468].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_129_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_132_3 = arg_129_1:GetWordFromCfg(417232032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 49
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232032", "story_v_out_417232.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232032", "story_v_out_417232.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_417232", "417232032", "story_v_out_417232.awb")

						arg_129_1:RecordAudio("417232032", var_132_9)
						arg_129_1:RecordAudio("417232032", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_417232", "417232032", "story_v_out_417232.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_417232", "417232032", "story_v_out_417232.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play417232033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 417232033
		arg_133_1.duration_ = 11.07

		local var_133_0 = {
			zh = 10.2,
			ja = 11.066
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play417232034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.75

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[468].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_133_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_136_3 = arg_133_1:GetWordFromCfg(417232033)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 30
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232033", "story_v_out_417232.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232033", "story_v_out_417232.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_417232", "417232033", "story_v_out_417232.awb")

						arg_133_1:RecordAudio("417232033", var_136_9)
						arg_133_1:RecordAudio("417232033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_417232", "417232033", "story_v_out_417232.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_417232", "417232033", "story_v_out_417232.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play417232034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 417232034
		arg_137_1.duration_ = 13.6

		local var_137_0 = {
			zh = 10.366,
			ja = 13.6
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
				arg_137_0:Play417232035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.725

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[468].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_137_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_140_3 = arg_137_1:GetWordFromCfg(417232034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232034", "story_v_out_417232.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232034", "story_v_out_417232.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_417232", "417232034", "story_v_out_417232.awb")

						arg_137_1:RecordAudio("417232034", var_140_9)
						arg_137_1:RecordAudio("417232034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_417232", "417232034", "story_v_out_417232.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_417232", "417232034", "story_v_out_417232.awb")
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
	Play417232035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 417232035
		arg_141_1.duration_ = 8.4

		local var_141_0 = {
			zh = 5.76666666666667,
			ja = 8.39966666666667
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
				arg_141_0:Play417232036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 3.96666666666667

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_1 = 0.133333333333333

			if arg_141_1.time_ >= var_144_0 + var_144_1 and arg_141_1.time_ < var_144_0 + var_144_1 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_2 = "ST01"

			if arg_141_1.bgs_[var_144_2] == nil then
				local var_144_3 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_2)
				var_144_3.name = var_144_2
				var_144_3.transform.parent = arg_141_1.stage_.transform
				var_144_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_2] = var_144_3
			end

			local var_144_4 = 2

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				local var_144_5 = manager.ui.mainCamera.transform.localPosition
				local var_144_6 = Vector3.New(0, 0, 10) + Vector3.New(var_144_5.x, var_144_5.y, 0)
				local var_144_7 = arg_141_1.bgs_.ST01

				var_144_7.transform.localPosition = var_144_6
				var_144_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_8 = var_144_7:GetComponent("SpriteRenderer")

				if var_144_8 and var_144_8.sprite then
					local var_144_9 = (var_144_7.transform.localPosition - var_144_5).z
					local var_144_10 = manager.ui.mainCameraCom_
					local var_144_11 = 2 * var_144_9 * Mathf.Tan(var_144_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_12 = var_144_11 * var_144_10.aspect
					local var_144_13 = var_144_8.sprite.bounds.size.x
					local var_144_14 = var_144_8.sprite.bounds.size.y
					local var_144_15 = var_144_12 / var_144_13
					local var_144_16 = var_144_11 / var_144_14
					local var_144_17 = var_144_16 < var_144_15 and var_144_15 or var_144_16

					var_144_7.transform.localScale = Vector3.New(var_144_17, var_144_17, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "ST01" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_18 = 0

			if var_144_18 < arg_141_1.time_ and arg_141_1.time_ <= var_144_18 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_19 = 2

			if var_144_18 <= arg_141_1.time_ and arg_141_1.time_ < var_144_18 + var_144_19 then
				local var_144_20 = (arg_141_1.time_ - var_144_18) / var_144_19
				local var_144_21 = Color.New(0, 0, 0)

				var_144_21.a = Mathf.Lerp(0, 1, var_144_20)
				arg_141_1.mask_.color = var_144_21
			end

			if arg_141_1.time_ >= var_144_18 + var_144_19 and arg_141_1.time_ < var_144_18 + var_144_19 + arg_144_0 then
				local var_144_22 = Color.New(0, 0, 0)

				var_144_22.a = 1
				arg_141_1.mask_.color = var_144_22
			end

			local var_144_23 = 2

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_24 = 2

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_24 then
				local var_144_25 = (arg_141_1.time_ - var_144_23) / var_144_24
				local var_144_26 = Color.New(0, 0, 0)

				var_144_26.a = Mathf.Lerp(1, 0, var_144_25)
				arg_141_1.mask_.color = var_144_26
			end

			if arg_141_1.time_ >= var_144_23 + var_144_24 and arg_141_1.time_ < var_144_23 + var_144_24 + arg_144_0 then
				local var_144_27 = Color.New(0, 0, 0)
				local var_144_28 = 0

				arg_141_1.mask_.enabled = false
				var_144_27.a = var_144_28
				arg_141_1.mask_.color = var_144_27
			end

			local var_144_29 = arg_141_1.actors_["10111"]
			local var_144_30 = 3.63333333333333

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 and not isNil(var_144_29) and arg_141_1.var_.actorSpriteComps10111 == nil then
				arg_141_1.var_.actorSpriteComps10111 = var_144_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_31 = 0.2

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_31 and not isNil(var_144_29) then
				local var_144_32 = (arg_141_1.time_ - var_144_30) / var_144_31

				if arg_141_1.var_.actorSpriteComps10111 then
					for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_144_3 then
							if arg_141_1.isInRecall_ then
								local var_144_33 = Mathf.Lerp(iter_144_3.color.r, arg_141_1.hightColor1.r, var_144_32)
								local var_144_34 = Mathf.Lerp(iter_144_3.color.g, arg_141_1.hightColor1.g, var_144_32)
								local var_144_35 = Mathf.Lerp(iter_144_3.color.b, arg_141_1.hightColor1.b, var_144_32)

								iter_144_3.color = Color.New(var_144_33, var_144_34, var_144_35)
							else
								local var_144_36 = Mathf.Lerp(iter_144_3.color.r, 1, var_144_32)

								iter_144_3.color = Color.New(var_144_36, var_144_36, var_144_36)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_30 + var_144_31 and arg_141_1.time_ < var_144_30 + var_144_31 + arg_144_0 and not isNil(var_144_29) and arg_141_1.var_.actorSpriteComps10111 then
				for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_144_5 then
						if arg_141_1.isInRecall_ then
							iter_144_5.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10111 = nil
			end

			local var_144_37 = arg_141_1.actors_["10111"].transform
			local var_144_38 = 1.96666666666667

			if var_144_38 < arg_141_1.time_ and arg_141_1.time_ <= var_144_38 + arg_144_0 then
				arg_141_1.var_.moveOldPos10111 = var_144_37.localPosition
				var_144_37.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10111", 7)

				local var_144_39 = var_144_37.childCount

				for iter_144_6 = 0, var_144_39 - 1 do
					local var_144_40 = var_144_37:GetChild(iter_144_6)

					if var_144_40.name == "" or not string.find(var_144_40.name, "split") then
						var_144_40.gameObject:SetActive(true)
					else
						var_144_40.gameObject:SetActive(false)
					end
				end
			end

			local var_144_41 = 0.001

			if var_144_38 <= arg_141_1.time_ and arg_141_1.time_ < var_144_38 + var_144_41 then
				local var_144_42 = (arg_141_1.time_ - var_144_38) / var_144_41
				local var_144_43 = Vector3.New(0, -2000, 0)

				var_144_37.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10111, var_144_43, var_144_42)
			end

			if arg_141_1.time_ >= var_144_38 + var_144_41 and arg_141_1.time_ < var_144_38 + var_144_41 + arg_144_0 then
				var_144_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_44 = arg_141_1.actors_["10111"].transform
			local var_144_45 = 3.63333333333333

			if var_144_45 < arg_141_1.time_ and arg_141_1.time_ <= var_144_45 + arg_144_0 then
				arg_141_1.var_.moveOldPos10111 = var_144_44.localPosition
				var_144_44.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10111", 3)

				local var_144_46 = var_144_44.childCount

				for iter_144_7 = 0, var_144_46 - 1 do
					local var_144_47 = var_144_44:GetChild(iter_144_7)

					if var_144_47.name == "" or not string.find(var_144_47.name, "split") then
						var_144_47.gameObject:SetActive(true)
					else
						var_144_47.gameObject:SetActive(false)
					end
				end
			end

			local var_144_48 = 0.001

			if var_144_45 <= arg_141_1.time_ and arg_141_1.time_ < var_144_45 + var_144_48 then
				local var_144_49 = (arg_141_1.time_ - var_144_45) / var_144_48
				local var_144_50 = Vector3.New(0, -361.1, -274.6)

				var_144_44.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10111, var_144_50, var_144_49)
			end

			if arg_141_1.time_ >= var_144_45 + var_144_48 and arg_141_1.time_ < var_144_45 + var_144_48 + arg_144_0 then
				var_144_44.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_144_51 = arg_141_1.actors_["10111"]
			local var_144_52 = 3.63333333333333

			if var_144_52 < arg_141_1.time_ and arg_141_1.time_ <= var_144_52 + arg_144_0 then
				local var_144_53 = var_144_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_144_53 then
					arg_141_1.var_.alphaOldValue10111 = var_144_53.alpha
					arg_141_1.var_.characterEffect10111 = var_144_53
				end

				arg_141_1.var_.alphaOldValue10111 = 0
			end

			local var_144_54 = 0.333333333333333

			if var_144_52 <= arg_141_1.time_ and arg_141_1.time_ < var_144_52 + var_144_54 then
				local var_144_55 = (arg_141_1.time_ - var_144_52) / var_144_54
				local var_144_56 = Mathf.Lerp(arg_141_1.var_.alphaOldValue10111, 1, var_144_55)

				if arg_141_1.var_.characterEffect10111 then
					arg_141_1.var_.characterEffect10111.alpha = var_144_56
				end
			end

			if arg_141_1.time_ >= var_144_52 + var_144_54 and arg_141_1.time_ < var_144_52 + var_144_54 + arg_144_0 and arg_141_1.var_.characterEffect10111 then
				arg_141_1.var_.characterEffect10111.alpha = 1
			end

			local var_144_57 = 1.93333333333333

			arg_141_1.isInRecall_ = false

			if var_144_57 < arg_141_1.time_ and arg_141_1.time_ <= var_144_57 + arg_144_0 then
				arg_141_1.screenFilterGo_:SetActive(false)

				for iter_144_8, iter_144_9 in pairs(arg_141_1.actors_) do
					local var_144_58 = iter_144_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_144_10, iter_144_11 in ipairs(var_144_58) do
						if iter_144_11.color.r > 0.51 then
							iter_144_11.color = Color.New(1, 1, 1)
						else
							iter_144_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_144_59 = 0.0666666666666665

			if var_144_57 <= arg_141_1.time_ and arg_141_1.time_ < var_144_57 + var_144_59 then
				local var_144_60 = (arg_141_1.time_ - var_144_57) / var_144_59

				arg_141_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_144_60)
			end

			if arg_141_1.time_ >= var_144_57 + var_144_59 and arg_141_1.time_ < var_144_57 + var_144_59 + arg_144_0 then
				arg_141_1.screenFilterEffect_.weight = 0
			end

			local var_144_61 = 0.366666666666667
			local var_144_62 = 1

			if var_144_61 < arg_141_1.time_ and arg_141_1.time_ <= var_144_61 + arg_144_0 then
				local var_144_63 = "stop"
				local var_144_64 = "effect"

				arg_141_1:AudioAction(var_144_63, var_144_64, "se_story_1311", "se_story_1311_wind", "")
			end

			local var_144_65 = 0
			local var_144_66 = 0.2

			if var_144_65 < arg_141_1.time_ and arg_141_1.time_ <= var_144_65 + arg_144_0 then
				local var_144_67 = "play"
				local var_144_68 = "music"

				arg_141_1:AudioAction(var_144_67, var_144_68, "ui_battle", "ui_battle_stopbgm", "")

				local var_144_69 = ""
				local var_144_70 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_144_70 ~= "" then
					if arg_141_1.bgmTxt_.text ~= var_144_70 and arg_141_1.bgmTxt_.text ~= "" then
						if arg_141_1.bgmTxt2_.text ~= "" then
							arg_141_1.bgmTxt_.text = arg_141_1.bgmTxt2_.text
						end

						arg_141_1.bgmTxt2_.text = var_144_70

						arg_141_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_141_1.bgmTxt_.text = var_144_70
						arg_141_1.bgmTxt2_.text = var_144_70
					end

					if arg_141_1.bgmTimer then
						arg_141_1.bgmTimer:Stop()

						arg_141_1.bgmTimer = nil
					end

					if arg_141_1.settingData.show_music_name == 1 then
						arg_141_1.musicController:SetSelectedState("show")
						arg_141_1.musicAnimator_:Play("open", 0, 0)

						if arg_141_1.settingData.music_time ~= 0 then
							arg_141_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_141_1.settingData.music_time), function()
								if arg_141_1 == nil or isNil(arg_141_1.bgmTxt_) then
									return
								end

								arg_141_1.musicController:SetSelectedState("hide")
								arg_141_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_144_71 = 1.36666666666667
			local var_144_72 = 1

			if var_144_71 < arg_141_1.time_ and arg_141_1.time_ <= var_144_71 + arg_144_0 then
				local var_144_73 = "play"
				local var_144_74 = "music"

				arg_141_1:AudioAction(var_144_73, var_144_74, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_144_75 = ""
				local var_144_76 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_144_76 ~= "" then
					if arg_141_1.bgmTxt_.text ~= var_144_76 and arg_141_1.bgmTxt_.text ~= "" then
						if arg_141_1.bgmTxt2_.text ~= "" then
							arg_141_1.bgmTxt_.text = arg_141_1.bgmTxt2_.text
						end

						arg_141_1.bgmTxt2_.text = var_144_76

						arg_141_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_141_1.bgmTxt_.text = var_144_76
						arg_141_1.bgmTxt2_.text = var_144_76
					end

					if arg_141_1.bgmTimer then
						arg_141_1.bgmTimer:Stop()

						arg_141_1.bgmTimer = nil
					end

					if arg_141_1.settingData.show_music_name == 1 then
						arg_141_1.musicController:SetSelectedState("show")
						arg_141_1.musicAnimator_:Play("open", 0, 0)

						if arg_141_1.settingData.music_time ~= 0 then
							arg_141_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_141_1.settingData.music_time), function()
								if arg_141_1 == nil or isNil(arg_141_1.bgmTxt_) then
									return
								end

								arg_141_1.musicController:SetSelectedState("hide")
								arg_141_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_77 = 3.96666666666667
			local var_144_78 = 0.25

			if var_144_77 < arg_141_1.time_ and arg_141_1.time_ <= var_144_77 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_79 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_79:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_141_1.dialogCg_.alpha = arg_147_0
				end))
				var_144_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_80 = arg_141_1:FormatText(StoryNameCfg[1125].name)

				arg_141_1.leftNameTxt_.text = var_144_80

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_81 = arg_141_1:GetWordFromCfg(417232035)
				local var_144_82 = arg_141_1:FormatText(var_144_81.content)

				arg_141_1.text_.text = var_144_82

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_83 = 10
				local var_144_84 = utf8.len(var_144_82)
				local var_144_85 = var_144_83 <= 0 and var_144_78 or var_144_78 * (var_144_84 / var_144_83)

				if var_144_85 > 0 and var_144_78 < var_144_85 then
					arg_141_1.talkMaxDuration = var_144_85
					var_144_77 = var_144_77 + 0.3

					if var_144_85 + var_144_77 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_85 + var_144_77
					end
				end

				arg_141_1.text_.text = var_144_82
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232035", "story_v_out_417232.awb") ~= 0 then
					local var_144_86 = manager.audio:GetVoiceLength("story_v_out_417232", "417232035", "story_v_out_417232.awb") / 1000

					if var_144_86 + var_144_77 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_86 + var_144_77
					end

					if var_144_81.prefab_name ~= "" and arg_141_1.actors_[var_144_81.prefab_name] ~= nil then
						local var_144_87 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_81.prefab_name].transform, "story_v_out_417232", "417232035", "story_v_out_417232.awb")

						arg_141_1:RecordAudio("417232035", var_144_87)
						arg_141_1:RecordAudio("417232035", var_144_87)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_417232", "417232035", "story_v_out_417232.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_417232", "417232035", "story_v_out_417232.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_88 = var_144_77 + 0.3
			local var_144_89 = math.max(var_144_78, arg_141_1.talkMaxDuration)

			if var_144_88 <= arg_141_1.time_ and arg_141_1.time_ < var_144_88 + var_144_89 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_88) / var_144_89

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_88 + var_144_89 and arg_141_1.time_ < var_144_88 + var_144_89 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play417232036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 417232036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play417232037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10111"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10111 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10111", 7)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(0, -2000, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10111, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_7 = 0.833333333333333
			local var_152_8 = 1

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				local var_152_9 = "play"
				local var_152_10 = "effect"

				arg_149_1:AudioAction(var_152_9, var_152_10, "se_story_1311", "se_story_1311_clap02", "")
			end

			local var_152_11 = 0
			local var_152_12 = 1.175

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_13 = arg_149_1:GetWordFromCfg(417232036)
				local var_152_14 = arg_149_1:FormatText(var_152_13.content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 47
				local var_152_16 = utf8.len(var_152_14)
				local var_152_17 = var_152_15 <= 0 and var_152_12 or var_152_12 * (var_152_16 / var_152_15)

				if var_152_17 > 0 and var_152_12 < var_152_17 then
					arg_149_1.talkMaxDuration = var_152_17

					if var_152_17 + var_152_11 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_17 + var_152_11
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_12, arg_149_1.talkMaxDuration)

			if var_152_11 <= arg_149_1.time_ and arg_149_1.time_ < var_152_11 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_11) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_11 + var_152_18 and arg_149_1.time_ < var_152_11 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play417232037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 417232037
		arg_153_1.duration_ = 4.23

		local var_153_0 = {
			zh = 3.8,
			ja = 4.233
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
				arg_153_0:Play417232038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = "1015"

			if arg_153_1.actors_[var_156_0] == nil then
				local var_156_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1015")

				if not isNil(var_156_1) then
					local var_156_2 = Object.Instantiate(var_156_1, arg_153_1.canvasGo_.transform)

					var_156_2.transform:SetSiblingIndex(1)

					var_156_2.name = var_156_0
					var_156_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_153_1.actors_[var_156_0] = var_156_2

					local var_156_3 = var_156_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_153_1.isInRecall_ then
						for iter_156_0, iter_156_1 in ipairs(var_156_3) do
							iter_156_1.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_156_4 = arg_153_1.actors_["1015"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.actorSpriteComps1015 == nil then
				arg_153_1.var_.actorSpriteComps1015 = var_156_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.2

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.actorSpriteComps1015 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								local var_156_8 = Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, var_156_7)
								local var_156_9 = Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, var_156_7)
								local var_156_10 = Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, var_156_7)

								iter_156_3.color = Color.New(var_156_8, var_156_9, var_156_10)
							else
								local var_156_11 = Mathf.Lerp(iter_156_3.color.r, 1, var_156_7)

								iter_156_3.color = Color.New(var_156_11, var_156_11, var_156_11)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.actorSpriteComps1015 then
				for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_156_5 then
						if arg_153_1.isInRecall_ then
							iter_156_5.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1015 = nil
			end

			local var_156_12 = arg_153_1.actors_["1015"].transform
			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1.var_.moveOldPos1015 = var_156_12.localPosition
				var_156_12.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1015", 3)

				local var_156_14 = var_156_12.childCount

				for iter_156_6 = 0, var_156_14 - 1 do
					local var_156_15 = var_156_12:GetChild(iter_156_6)

					if var_156_15.name == "split_1" or not string.find(var_156_15.name, "split") then
						var_156_15.gameObject:SetActive(true)
					else
						var_156_15.gameObject:SetActive(false)
					end
				end
			end

			local var_156_16 = 0.001

			if var_156_13 <= arg_153_1.time_ and arg_153_1.time_ < var_156_13 + var_156_16 then
				local var_156_17 = (arg_153_1.time_ - var_156_13) / var_156_16
				local var_156_18 = Vector3.New(0, -340, -288)

				var_156_12.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1015, var_156_18, var_156_17)
			end

			if arg_153_1.time_ >= var_156_13 + var_156_16 and arg_153_1.time_ < var_156_13 + var_156_16 + arg_156_0 then
				var_156_12.localPosition = Vector3.New(0, -340, -288)
			end

			local var_156_19 = 0
			local var_156_20 = 0.325

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_21 = arg_153_1:FormatText(StoryNameCfg[479].name)

				arg_153_1.leftNameTxt_.text = var_156_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_22 = arg_153_1:GetWordFromCfg(417232037)
				local var_156_23 = arg_153_1:FormatText(var_156_22.content)

				arg_153_1.text_.text = var_156_23

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_24 = 13
				local var_156_25 = utf8.len(var_156_23)
				local var_156_26 = var_156_24 <= 0 and var_156_20 or var_156_20 * (var_156_25 / var_156_24)

				if var_156_26 > 0 and var_156_20 < var_156_26 then
					arg_153_1.talkMaxDuration = var_156_26

					if var_156_26 + var_156_19 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_26 + var_156_19
					end
				end

				arg_153_1.text_.text = var_156_23
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232037", "story_v_out_417232.awb") ~= 0 then
					local var_156_27 = manager.audio:GetVoiceLength("story_v_out_417232", "417232037", "story_v_out_417232.awb") / 1000

					if var_156_27 + var_156_19 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_27 + var_156_19
					end

					if var_156_22.prefab_name ~= "" and arg_153_1.actors_[var_156_22.prefab_name] ~= nil then
						local var_156_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_22.prefab_name].transform, "story_v_out_417232", "417232037", "story_v_out_417232.awb")

						arg_153_1:RecordAudio("417232037", var_156_28)
						arg_153_1:RecordAudio("417232037", var_156_28)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_417232", "417232037", "story_v_out_417232.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_417232", "417232037", "story_v_out_417232.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_29 = math.max(var_156_20, arg_153_1.talkMaxDuration)

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_29 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_19) / var_156_29

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_19 + var_156_29 and arg_153_1.time_ < var_156_19 + var_156_29 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play417232038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 417232038
		arg_157_1.duration_ = 12.33

		local var_157_0 = {
			zh = 9.166,
			ja = 12.333
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play417232039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10111"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10111 == nil then
				arg_157_1.var_.actorSpriteComps10111 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10111 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 1, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10111 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10111 = nil
			end

			local var_160_8 = arg_157_1.actors_["10111"].transform
			local var_160_9 = 0

			if var_160_9 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.var_.moveOldPos10111 = var_160_8.localPosition
				var_160_8.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10111", 3)

				local var_160_10 = var_160_8.childCount

				for iter_160_4 = 0, var_160_10 - 1 do
					local var_160_11 = var_160_8:GetChild(iter_160_4)

					if var_160_11.name == "" or not string.find(var_160_11.name, "split") then
						var_160_11.gameObject:SetActive(true)
					else
						var_160_11.gameObject:SetActive(false)
					end
				end
			end

			local var_160_12 = 0.001

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_12 then
				local var_160_13 = (arg_157_1.time_ - var_160_9) / var_160_12
				local var_160_14 = Vector3.New(0, -361.1, -274.6)

				var_160_8.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10111, var_160_14, var_160_13)
			end

			if arg_157_1.time_ >= var_160_9 + var_160_12 and arg_157_1.time_ < var_160_9 + var_160_12 + arg_160_0 then
				var_160_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_160_15 = arg_157_1.actors_["1015"].transform
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.var_.moveOldPos1015 = var_160_15.localPosition
				var_160_15.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1015", 7)

				local var_160_17 = var_160_15.childCount

				for iter_160_5 = 0, var_160_17 - 1 do
					local var_160_18 = var_160_15:GetChild(iter_160_5)

					if var_160_18.name == "" or not string.find(var_160_18.name, "split") then
						var_160_18.gameObject:SetActive(true)
					else
						var_160_18.gameObject:SetActive(false)
					end
				end
			end

			local var_160_19 = 0.001

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_19 then
				local var_160_20 = (arg_157_1.time_ - var_160_16) / var_160_19
				local var_160_21 = Vector3.New(0, -2000, 0)

				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1015, var_160_21, var_160_20)
			end

			if arg_157_1.time_ >= var_160_16 + var_160_19 and arg_157_1.time_ < var_160_16 + var_160_19 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_22 = 0
			local var_160_23 = 1.125

			if var_160_22 < arg_157_1.time_ and arg_157_1.time_ <= var_160_22 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_24 = arg_157_1:FormatText(StoryNameCfg[1125].name)

				arg_157_1.leftNameTxt_.text = var_160_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_25 = arg_157_1:GetWordFromCfg(417232038)
				local var_160_26 = arg_157_1:FormatText(var_160_25.content)

				arg_157_1.text_.text = var_160_26

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_27 = 45
				local var_160_28 = utf8.len(var_160_26)
				local var_160_29 = var_160_27 <= 0 and var_160_23 or var_160_23 * (var_160_28 / var_160_27)

				if var_160_29 > 0 and var_160_23 < var_160_29 then
					arg_157_1.talkMaxDuration = var_160_29

					if var_160_29 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_22
					end
				end

				arg_157_1.text_.text = var_160_26
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232038", "story_v_out_417232.awb") ~= 0 then
					local var_160_30 = manager.audio:GetVoiceLength("story_v_out_417232", "417232038", "story_v_out_417232.awb") / 1000

					if var_160_30 + var_160_22 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_30 + var_160_22
					end

					if var_160_25.prefab_name ~= "" and arg_157_1.actors_[var_160_25.prefab_name] ~= nil then
						local var_160_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_25.prefab_name].transform, "story_v_out_417232", "417232038", "story_v_out_417232.awb")

						arg_157_1:RecordAudio("417232038", var_160_31)
						arg_157_1:RecordAudio("417232038", var_160_31)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_417232", "417232038", "story_v_out_417232.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_417232", "417232038", "story_v_out_417232.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_32 = math.max(var_160_23, arg_157_1.talkMaxDuration)

			if var_160_22 <= arg_157_1.time_ and arg_157_1.time_ < var_160_22 + var_160_32 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_22) / var_160_32

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_22 + var_160_32 and arg_157_1.time_ < var_160_22 + var_160_32 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play417232039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 417232039
		arg_161_1.duration_ = 6.27

		local var_161_0 = {
			zh = 6.266,
			ja = 6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play417232040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.7

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[1125].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(417232039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 28
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232039", "story_v_out_417232.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232039", "story_v_out_417232.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_417232", "417232039", "story_v_out_417232.awb")

						arg_161_1:RecordAudio("417232039", var_164_9)
						arg_161_1:RecordAudio("417232039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_417232", "417232039", "story_v_out_417232.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_417232", "417232039", "story_v_out_417232.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play417232040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 417232040
		arg_165_1.duration_ = 8.63

		local var_165_0 = {
			zh = 8.4,
			ja = 8.633
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play417232041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 1.1

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1125].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(417232040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 44
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232040", "story_v_out_417232.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232040", "story_v_out_417232.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_417232", "417232040", "story_v_out_417232.awb")

						arg_165_1:RecordAudio("417232040", var_168_9)
						arg_165_1:RecordAudio("417232040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_417232", "417232040", "story_v_out_417232.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_417232", "417232040", "story_v_out_417232.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play417232041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 417232041
		arg_169_1.duration_ = 6.5

		local var_169_0 = {
			zh = 6.3,
			ja = 6.5
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play417232042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.7

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_2 = arg_169_1:FormatText(StoryNameCfg[1125].name)

				arg_169_1.leftNameTxt_.text = var_172_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(417232041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 28
				local var_172_6 = utf8.len(var_172_4)
				local var_172_7 = var_172_5 <= 0 and var_172_1 or var_172_1 * (var_172_6 / var_172_5)

				if var_172_7 > 0 and var_172_1 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232041", "story_v_out_417232.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232041", "story_v_out_417232.awb") / 1000

					if var_172_8 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_0
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_417232", "417232041", "story_v_out_417232.awb")

						arg_169_1:RecordAudio("417232041", var_172_9)
						arg_169_1:RecordAudio("417232041", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_417232", "417232041", "story_v_out_417232.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_417232", "417232041", "story_v_out_417232.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_10 and arg_169_1.time_ < var_172_0 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play417232042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 417232042
		arg_173_1.duration_ = 7.33

		local var_173_0 = {
			zh = 5.7,
			ja = 7.333
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play417232043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = "10128"

			if arg_173_1.actors_[var_176_0] == nil then
				local var_176_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_176_1) then
					local var_176_2 = Object.Instantiate(var_176_1, arg_173_1.canvasGo_.transform)

					var_176_2.transform:SetSiblingIndex(1)

					var_176_2.name = var_176_0
					var_176_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_173_1.actors_[var_176_0] = var_176_2

					local var_176_3 = var_176_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_173_1.isInRecall_ then
						for iter_176_0, iter_176_1 in ipairs(var_176_3) do
							iter_176_1.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_176_4 = arg_173_1.actors_["10128"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.actorSpriteComps10128 == nil then
				arg_173_1.var_.actorSpriteComps10128 = var_176_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 0.2

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.actorSpriteComps10128 then
					for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_176_3 then
							if arg_173_1.isInRecall_ then
								local var_176_8 = Mathf.Lerp(iter_176_3.color.r, arg_173_1.hightColor1.r, var_176_7)
								local var_176_9 = Mathf.Lerp(iter_176_3.color.g, arg_173_1.hightColor1.g, var_176_7)
								local var_176_10 = Mathf.Lerp(iter_176_3.color.b, arg_173_1.hightColor1.b, var_176_7)

								iter_176_3.color = Color.New(var_176_8, var_176_9, var_176_10)
							else
								local var_176_11 = Mathf.Lerp(iter_176_3.color.r, 1, var_176_7)

								iter_176_3.color = Color.New(var_176_11, var_176_11, var_176_11)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.actorSpriteComps10128 then
				for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_176_5 then
						if arg_173_1.isInRecall_ then
							iter_176_5.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10128 = nil
			end

			local var_176_12 = arg_173_1.actors_["10111"]
			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 and not isNil(var_176_12) and arg_173_1.var_.actorSpriteComps10111 == nil then
				arg_173_1.var_.actorSpriteComps10111 = var_176_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_14 = 0.2

			if var_176_13 <= arg_173_1.time_ and arg_173_1.time_ < var_176_13 + var_176_14 and not isNil(var_176_12) then
				local var_176_15 = (arg_173_1.time_ - var_176_13) / var_176_14

				if arg_173_1.var_.actorSpriteComps10111 then
					for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_176_7 then
							if arg_173_1.isInRecall_ then
								local var_176_16 = Mathf.Lerp(iter_176_7.color.r, arg_173_1.hightColor2.r, var_176_15)
								local var_176_17 = Mathf.Lerp(iter_176_7.color.g, arg_173_1.hightColor2.g, var_176_15)
								local var_176_18 = Mathf.Lerp(iter_176_7.color.b, arg_173_1.hightColor2.b, var_176_15)

								iter_176_7.color = Color.New(var_176_16, var_176_17, var_176_18)
							else
								local var_176_19 = Mathf.Lerp(iter_176_7.color.r, 0.5, var_176_15)

								iter_176_7.color = Color.New(var_176_19, var_176_19, var_176_19)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_13 + var_176_14 and arg_173_1.time_ < var_176_13 + var_176_14 + arg_176_0 and not isNil(var_176_12) and arg_173_1.var_.actorSpriteComps10111 then
				for iter_176_8, iter_176_9 in pairs(arg_173_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_176_9 then
						if arg_173_1.isInRecall_ then
							iter_176_9.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10111 = nil
			end

			local var_176_20 = arg_173_1.actors_["10111"].transform
			local var_176_21 = 0

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.var_.moveOldPos10111 = var_176_20.localPosition
				var_176_20.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10111", 2)

				local var_176_22 = var_176_20.childCount

				for iter_176_10 = 0, var_176_22 - 1 do
					local var_176_23 = var_176_20:GetChild(iter_176_10)

					if var_176_23.name == "" or not string.find(var_176_23.name, "split") then
						var_176_23.gameObject:SetActive(true)
					else
						var_176_23.gameObject:SetActive(false)
					end
				end
			end

			local var_176_24 = 0.001

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_24 then
				local var_176_25 = (arg_173_1.time_ - var_176_21) / var_176_24
				local var_176_26 = Vector3.New(-390, -361.1, -274.6)

				var_176_20.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10111, var_176_26, var_176_25)
			end

			if arg_173_1.time_ >= var_176_21 + var_176_24 and arg_173_1.time_ < var_176_21 + var_176_24 + arg_176_0 then
				var_176_20.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_176_27 = arg_173_1.actors_["10128"].transform
			local var_176_28 = 0

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1.var_.moveOldPos10128 = var_176_27.localPosition
				var_176_27.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10128", 4)

				local var_176_29 = var_176_27.childCount

				for iter_176_11 = 0, var_176_29 - 1 do
					local var_176_30 = var_176_27:GetChild(iter_176_11)

					if var_176_30.name == "" or not string.find(var_176_30.name, "split") then
						var_176_30.gameObject:SetActive(true)
					else
						var_176_30.gameObject:SetActive(false)
					end
				end
			end

			local var_176_31 = 0.001

			if var_176_28 <= arg_173_1.time_ and arg_173_1.time_ < var_176_28 + var_176_31 then
				local var_176_32 = (arg_173_1.time_ - var_176_28) / var_176_31
				local var_176_33 = Vector3.New(390, -347, -300)

				var_176_27.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10128, var_176_33, var_176_32)
			end

			if arg_173_1.time_ >= var_176_28 + var_176_31 and arg_173_1.time_ < var_176_28 + var_176_31 + arg_176_0 then
				var_176_27.localPosition = Vector3.New(390, -347, -300)
			end

			local var_176_34 = 0
			local var_176_35 = 0.55

			if var_176_34 < arg_173_1.time_ and arg_173_1.time_ <= var_176_34 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_36 = arg_173_1:FormatText(StoryNameCfg[595].name)

				arg_173_1.leftNameTxt_.text = var_176_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_37 = arg_173_1:GetWordFromCfg(417232042)
				local var_176_38 = arg_173_1:FormatText(var_176_37.content)

				arg_173_1.text_.text = var_176_38

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_39 = 22
				local var_176_40 = utf8.len(var_176_38)
				local var_176_41 = var_176_39 <= 0 and var_176_35 or var_176_35 * (var_176_40 / var_176_39)

				if var_176_41 > 0 and var_176_35 < var_176_41 then
					arg_173_1.talkMaxDuration = var_176_41

					if var_176_41 + var_176_34 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_41 + var_176_34
					end
				end

				arg_173_1.text_.text = var_176_38
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232042", "story_v_out_417232.awb") ~= 0 then
					local var_176_42 = manager.audio:GetVoiceLength("story_v_out_417232", "417232042", "story_v_out_417232.awb") / 1000

					if var_176_42 + var_176_34 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_42 + var_176_34
					end

					if var_176_37.prefab_name ~= "" and arg_173_1.actors_[var_176_37.prefab_name] ~= nil then
						local var_176_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_37.prefab_name].transform, "story_v_out_417232", "417232042", "story_v_out_417232.awb")

						arg_173_1:RecordAudio("417232042", var_176_43)
						arg_173_1:RecordAudio("417232042", var_176_43)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_417232", "417232042", "story_v_out_417232.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_417232", "417232042", "story_v_out_417232.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_44 = math.max(var_176_35, arg_173_1.talkMaxDuration)

			if var_176_34 <= arg_173_1.time_ and arg_173_1.time_ < var_176_34 + var_176_44 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_34) / var_176_44

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_34 + var_176_44 and arg_173_1.time_ < var_176_34 + var_176_44 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play417232043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 417232043
		arg_177_1.duration_ = 6.63

		local var_177_0 = {
			zh = 5.3,
			ja = 6.633
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
				arg_177_0:Play417232044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10111"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10111 == nil then
				arg_177_1.var_.actorSpriteComps10111 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10111 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								local var_180_4 = Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, var_180_3)
								local var_180_5 = Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, var_180_3)
								local var_180_6 = Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, var_180_3)

								iter_180_1.color = Color.New(var_180_4, var_180_5, var_180_6)
							else
								local var_180_7 = Mathf.Lerp(iter_180_1.color.r, 1, var_180_3)

								iter_180_1.color = Color.New(var_180_7, var_180_7, var_180_7)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10111 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10111 = nil
			end

			local var_180_8 = arg_177_1.actors_["10128"]
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10128 == nil then
				arg_177_1.var_.actorSpriteComps10128 = var_180_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_10 = 0.2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 and not isNil(var_180_8) then
				local var_180_11 = (arg_177_1.time_ - var_180_9) / var_180_10

				if arg_177_1.var_.actorSpriteComps10128 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								local var_180_12 = Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, var_180_11)
								local var_180_13 = Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, var_180_11)
								local var_180_14 = Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, var_180_11)

								iter_180_5.color = Color.New(var_180_12, var_180_13, var_180_14)
							else
								local var_180_15 = Mathf.Lerp(iter_180_5.color.r, 0.5, var_180_11)

								iter_180_5.color = Color.New(var_180_15, var_180_15, var_180_15)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 and not isNil(var_180_8) and arg_177_1.var_.actorSpriteComps10128 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_180_7 then
						if arg_177_1.isInRecall_ then
							iter_180_7.color = arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_180_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10128 = nil
			end

			local var_180_16 = 0
			local var_180_17 = 0.65

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_18 = arg_177_1:FormatText(StoryNameCfg[1125].name)

				arg_177_1.leftNameTxt_.text = var_180_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:GetWordFromCfg(417232043)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 26
				local var_180_22 = utf8.len(var_180_20)
				local var_180_23 = var_180_21 <= 0 and var_180_17 or var_180_17 * (var_180_22 / var_180_21)

				if var_180_23 > 0 and var_180_17 < var_180_23 then
					arg_177_1.talkMaxDuration = var_180_23

					if var_180_23 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232043", "story_v_out_417232.awb") ~= 0 then
					local var_180_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232043", "story_v_out_417232.awb") / 1000

					if var_180_24 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_24 + var_180_16
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_417232", "417232043", "story_v_out_417232.awb")

						arg_177_1:RecordAudio("417232043", var_180_25)
						arg_177_1:RecordAudio("417232043", var_180_25)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_417232", "417232043", "story_v_out_417232.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_417232", "417232043", "story_v_out_417232.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_26 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_26 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_16) / var_180_26

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_16 + var_180_26 and arg_177_1.time_ < var_180_16 + var_180_26 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play417232044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 417232044
		arg_181_1.duration_ = 4.9

		local var_181_0 = {
			zh = 2.166,
			ja = 4.9
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
				arg_181_0:Play417232045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10128"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10128 == nil then
				arg_181_1.var_.actorSpriteComps10128 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps10128 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 1, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps10128 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10128 = nil
			end

			local var_184_8 = arg_181_1.actors_["10111"]
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10111 == nil then
				arg_181_1.var_.actorSpriteComps10111 = var_184_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_10 = 0.2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 and not isNil(var_184_8) then
				local var_184_11 = (arg_181_1.time_ - var_184_9) / var_184_10

				if arg_181_1.var_.actorSpriteComps10111 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								local var_184_12 = Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, var_184_11)
								local var_184_13 = Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, var_184_11)
								local var_184_14 = Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, var_184_11)

								iter_184_5.color = Color.New(var_184_12, var_184_13, var_184_14)
							else
								local var_184_15 = Mathf.Lerp(iter_184_5.color.r, 0.5, var_184_11)

								iter_184_5.color = Color.New(var_184_15, var_184_15, var_184_15)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 and not isNil(var_184_8) and arg_181_1.var_.actorSpriteComps10111 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_184_7 then
						if arg_181_1.isInRecall_ then
							iter_184_7.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10111 = nil
			end

			local var_184_16 = 0
			local var_184_17 = 0.275

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_18 = arg_181_1:FormatText(StoryNameCfg[595].name)

				arg_181_1.leftNameTxt_.text = var_184_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:GetWordFromCfg(417232044)
				local var_184_20 = arg_181_1:FormatText(var_184_19.content)

				arg_181_1.text_.text = var_184_20

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 11
				local var_184_22 = utf8.len(var_184_20)
				local var_184_23 = var_184_21 <= 0 and var_184_17 or var_184_17 * (var_184_22 / var_184_21)

				if var_184_23 > 0 and var_184_17 < var_184_23 then
					arg_181_1.talkMaxDuration = var_184_23

					if var_184_23 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_23 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_20
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232044", "story_v_out_417232.awb") ~= 0 then
					local var_184_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232044", "story_v_out_417232.awb") / 1000

					if var_184_24 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_24 + var_184_16
					end

					if var_184_19.prefab_name ~= "" and arg_181_1.actors_[var_184_19.prefab_name] ~= nil then
						local var_184_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_19.prefab_name].transform, "story_v_out_417232", "417232044", "story_v_out_417232.awb")

						arg_181_1:RecordAudio("417232044", var_184_25)
						arg_181_1:RecordAudio("417232044", var_184_25)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_417232", "417232044", "story_v_out_417232.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_417232", "417232044", "story_v_out_417232.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_16) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_16 + var_184_26 and arg_181_1.time_ < var_184_16 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play417232045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 417232045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play417232046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10128"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10128 == nil then
				arg_185_1.var_.actorSpriteComps10128 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps10128 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 0.5, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps10128 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10128 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 1.05

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(417232045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_12 = 42
				local var_188_13 = utf8.len(var_188_11)
				local var_188_14 = var_188_12 <= 0 and var_188_9 or var_188_9 * (var_188_13 / var_188_12)

				if var_188_14 > 0 and var_188_9 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_15 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_15 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_15

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_15 and arg_185_1.time_ < var_188_8 + var_188_15 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play417232046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 417232046
		arg_189_1.duration_ = 8.6

		local var_189_0 = {
			zh = 7.4,
			ja = 8.6
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
				arg_189_0:Play417232047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10128"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10128 == nil then
				arg_189_1.var_.actorSpriteComps10128 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10128 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 1, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10128 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10128 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.9

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_10 = arg_189_1:FormatText(StoryNameCfg[595].name)

				arg_189_1.leftNameTxt_.text = var_192_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(417232046)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 36
				local var_192_14 = utf8.len(var_192_12)
				local var_192_15 = var_192_13 <= 0 and var_192_9 or var_192_9 * (var_192_14 / var_192_13)

				if var_192_15 > 0 and var_192_9 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232046", "story_v_out_417232.awb") ~= 0 then
					local var_192_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232046", "story_v_out_417232.awb") / 1000

					if var_192_16 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_8
					end

					if var_192_11.prefab_name ~= "" and arg_189_1.actors_[var_192_11.prefab_name] ~= nil then
						local var_192_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_11.prefab_name].transform, "story_v_out_417232", "417232046", "story_v_out_417232.awb")

						arg_189_1:RecordAudio("417232046", var_192_17)
						arg_189_1:RecordAudio("417232046", var_192_17)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_417232", "417232046", "story_v_out_417232.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_417232", "417232046", "story_v_out_417232.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_18 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_18 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_18

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_18 and arg_189_1.time_ < var_192_8 + var_192_18 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play417232047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 417232047
		arg_193_1.duration_ = 7.47

		local var_193_0 = {
			zh = 6.2,
			ja = 7.466
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
				arg_193_0:Play417232048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10111"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10111 == nil then
				arg_193_1.var_.actorSpriteComps10111 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10111 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 1, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10111 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10111 = nil
			end

			local var_196_8 = arg_193_1.actors_["10128"]
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10128 == nil then
				arg_193_1.var_.actorSpriteComps10128 = var_196_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_10 = 0.2

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_10 and not isNil(var_196_8) then
				local var_196_11 = (arg_193_1.time_ - var_196_9) / var_196_10

				if arg_193_1.var_.actorSpriteComps10128 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								local var_196_12 = Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, var_196_11)
								local var_196_13 = Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, var_196_11)
								local var_196_14 = Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, var_196_11)

								iter_196_5.color = Color.New(var_196_12, var_196_13, var_196_14)
							else
								local var_196_15 = Mathf.Lerp(iter_196_5.color.r, 0.5, var_196_11)

								iter_196_5.color = Color.New(var_196_15, var_196_15, var_196_15)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_9 + var_196_10 and arg_193_1.time_ < var_196_9 + var_196_10 + arg_196_0 and not isNil(var_196_8) and arg_193_1.var_.actorSpriteComps10128 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_196_7 then
						if arg_193_1.isInRecall_ then
							iter_196_7.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10128 = nil
			end

			local var_196_16 = 0
			local var_196_17 = 0.7

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_18 = arg_193_1:FormatText(StoryNameCfg[1125].name)

				arg_193_1.leftNameTxt_.text = var_196_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_19 = arg_193_1:GetWordFromCfg(417232047)
				local var_196_20 = arg_193_1:FormatText(var_196_19.content)

				arg_193_1.text_.text = var_196_20

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_21 = 28
				local var_196_22 = utf8.len(var_196_20)
				local var_196_23 = var_196_21 <= 0 and var_196_17 or var_196_17 * (var_196_22 / var_196_21)

				if var_196_23 > 0 and var_196_17 < var_196_23 then
					arg_193_1.talkMaxDuration = var_196_23

					if var_196_23 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_16
					end
				end

				arg_193_1.text_.text = var_196_20
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232047", "story_v_out_417232.awb") ~= 0 then
					local var_196_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232047", "story_v_out_417232.awb") / 1000

					if var_196_24 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_24 + var_196_16
					end

					if var_196_19.prefab_name ~= "" and arg_193_1.actors_[var_196_19.prefab_name] ~= nil then
						local var_196_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_19.prefab_name].transform, "story_v_out_417232", "417232047", "story_v_out_417232.awb")

						arg_193_1:RecordAudio("417232047", var_196_25)
						arg_193_1:RecordAudio("417232047", var_196_25)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_417232", "417232047", "story_v_out_417232.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_417232", "417232047", "story_v_out_417232.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_26 = math.max(var_196_17, arg_193_1.talkMaxDuration)

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_26 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_16) / var_196_26

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_16 + var_196_26 and arg_193_1.time_ < var_196_16 + var_196_26 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play417232048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 417232048
		arg_197_1.duration_ = 3.6

		local var_197_0 = {
			zh = 0.999999999999,
			ja = 3.6
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
				arg_197_0:Play417232049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10128"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10128 == nil then
				arg_197_1.var_.actorSpriteComps10128 = var_200_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.actorSpriteComps10128 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								local var_200_4 = Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, var_200_3)
								local var_200_5 = Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, var_200_3)
								local var_200_6 = Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, var_200_3)

								iter_200_1.color = Color.New(var_200_4, var_200_5, var_200_6)
							else
								local var_200_7 = Mathf.Lerp(iter_200_1.color.r, 1, var_200_3)

								iter_200_1.color = Color.New(var_200_7, var_200_7, var_200_7)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.actorSpriteComps10128 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_200_3 then
						if arg_197_1.isInRecall_ then
							iter_200_3.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10128 = nil
			end

			local var_200_8 = arg_197_1.actors_["10111"]
			local var_200_9 = 0

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10111 == nil then
				arg_197_1.var_.actorSpriteComps10111 = var_200_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_10 = 0.2

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_10 and not isNil(var_200_8) then
				local var_200_11 = (arg_197_1.time_ - var_200_9) / var_200_10

				if arg_197_1.var_.actorSpriteComps10111 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								local var_200_12 = Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, var_200_11)
								local var_200_13 = Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, var_200_11)
								local var_200_14 = Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, var_200_11)

								iter_200_5.color = Color.New(var_200_12, var_200_13, var_200_14)
							else
								local var_200_15 = Mathf.Lerp(iter_200_5.color.r, 0.5, var_200_11)

								iter_200_5.color = Color.New(var_200_15, var_200_15, var_200_15)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_9 + var_200_10 and arg_197_1.time_ < var_200_9 + var_200_10 + arg_200_0 and not isNil(var_200_8) and arg_197_1.var_.actorSpriteComps10111 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_200_7 then
						if arg_197_1.isInRecall_ then
							iter_200_7.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10111 = nil
			end

			local var_200_16 = 0
			local var_200_17 = 0.125

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_18 = arg_197_1:FormatText(StoryNameCfg[595].name)

				arg_197_1.leftNameTxt_.text = var_200_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_19 = arg_197_1:GetWordFromCfg(417232048)
				local var_200_20 = arg_197_1:FormatText(var_200_19.content)

				arg_197_1.text_.text = var_200_20

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_21 = 5
				local var_200_22 = utf8.len(var_200_20)
				local var_200_23 = var_200_21 <= 0 and var_200_17 or var_200_17 * (var_200_22 / var_200_21)

				if var_200_23 > 0 and var_200_17 < var_200_23 then
					arg_197_1.talkMaxDuration = var_200_23

					if var_200_23 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_23 + var_200_16
					end
				end

				arg_197_1.text_.text = var_200_20
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232048", "story_v_out_417232.awb") ~= 0 then
					local var_200_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232048", "story_v_out_417232.awb") / 1000

					if var_200_24 + var_200_16 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_24 + var_200_16
					end

					if var_200_19.prefab_name ~= "" and arg_197_1.actors_[var_200_19.prefab_name] ~= nil then
						local var_200_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_19.prefab_name].transform, "story_v_out_417232", "417232048", "story_v_out_417232.awb")

						arg_197_1:RecordAudio("417232048", var_200_25)
						arg_197_1:RecordAudio("417232048", var_200_25)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_417232", "417232048", "story_v_out_417232.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_417232", "417232048", "story_v_out_417232.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_26 = math.max(var_200_17, arg_197_1.talkMaxDuration)

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_26 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_16) / var_200_26

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_16 + var_200_26 and arg_197_1.time_ < var_200_16 + var_200_26 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play417232049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 417232049
		arg_201_1.duration_ = 13.8

		local var_201_0 = {
			zh = 8.4,
			ja = 13.8
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
				arg_201_0:Play417232050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10111"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10111 == nil then
				arg_201_1.var_.actorSpriteComps10111 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps10111 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 1, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10111 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10111 = nil
			end

			local var_204_8 = arg_201_1.actors_["10128"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10128 == nil then
				arg_201_1.var_.actorSpriteComps10128 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 0.2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps10128 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								local var_204_12 = Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, var_204_11)
								local var_204_13 = Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, var_204_11)
								local var_204_14 = Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, var_204_11)

								iter_204_5.color = Color.New(var_204_12, var_204_13, var_204_14)
							else
								local var_204_15 = Mathf.Lerp(iter_204_5.color.r, 0.5, var_204_11)

								iter_204_5.color = Color.New(var_204_15, var_204_15, var_204_15)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10128 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10128 = nil
			end

			local var_204_16 = 0
			local var_204_17 = 1.05

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_18 = arg_201_1:FormatText(StoryNameCfg[1125].name)

				arg_201_1.leftNameTxt_.text = var_204_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_19 = arg_201_1:GetWordFromCfg(417232049)
				local var_204_20 = arg_201_1:FormatText(var_204_19.content)

				arg_201_1.text_.text = var_204_20

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_21 = 42
				local var_204_22 = utf8.len(var_204_20)
				local var_204_23 = var_204_21 <= 0 and var_204_17 or var_204_17 * (var_204_22 / var_204_21)

				if var_204_23 > 0 and var_204_17 < var_204_23 then
					arg_201_1.talkMaxDuration = var_204_23

					if var_204_23 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_16
					end
				end

				arg_201_1.text_.text = var_204_20
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232049", "story_v_out_417232.awb") ~= 0 then
					local var_204_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232049", "story_v_out_417232.awb") / 1000

					if var_204_24 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_16
					end

					if var_204_19.prefab_name ~= "" and arg_201_1.actors_[var_204_19.prefab_name] ~= nil then
						local var_204_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_19.prefab_name].transform, "story_v_out_417232", "417232049", "story_v_out_417232.awb")

						arg_201_1:RecordAudio("417232049", var_204_25)
						arg_201_1:RecordAudio("417232049", var_204_25)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_417232", "417232049", "story_v_out_417232.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_417232", "417232049", "story_v_out_417232.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_26 = math.max(var_204_17, arg_201_1.talkMaxDuration)

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_26 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_16) / var_204_26

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_16 + var_204_26 and arg_201_1.time_ < var_204_16 + var_204_26 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play417232050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 417232050
		arg_205_1.duration_ = 3.9

		local var_205_0 = {
			zh = 3.633,
			ja = 3.9
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
				arg_205_0:Play417232051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10111"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10111 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10111", 2)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_2" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(-390, -361.1, -274.6)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10111, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_208_7 = 0
			local var_208_8 = 0.35

			if var_208_7 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_9 = arg_205_1:FormatText(StoryNameCfg[1125].name)

				arg_205_1.leftNameTxt_.text = var_208_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(417232050)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 14
				local var_208_13 = utf8.len(var_208_11)
				local var_208_14 = var_208_12 <= 0 and var_208_8 or var_208_8 * (var_208_13 / var_208_12)

				if var_208_14 > 0 and var_208_8 < var_208_14 then
					arg_205_1.talkMaxDuration = var_208_14

					if var_208_14 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_7
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232050", "story_v_out_417232.awb") ~= 0 then
					local var_208_15 = manager.audio:GetVoiceLength("story_v_out_417232", "417232050", "story_v_out_417232.awb") / 1000

					if var_208_15 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_15 + var_208_7
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_417232", "417232050", "story_v_out_417232.awb")

						arg_205_1:RecordAudio("417232050", var_208_16)
						arg_205_1:RecordAudio("417232050", var_208_16)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_417232", "417232050", "story_v_out_417232.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_417232", "417232050", "story_v_out_417232.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_17 = math.max(var_208_8, arg_205_1.talkMaxDuration)

			if var_208_7 <= arg_205_1.time_ and arg_205_1.time_ < var_208_7 + var_208_17 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_7) / var_208_17

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_7 + var_208_17 and arg_205_1.time_ < var_208_7 + var_208_17 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 417232051
		arg_209_1.duration_ = 8.57

		local var_209_0 = {
			zh = 7.4,
			ja = 8.566
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
				arg_209_0:Play417232052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 3

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			local var_212_1 = 0.3

			if arg_209_1.time_ >= var_212_0 + var_212_1 and arg_209_1.time_ < var_212_0 + var_212_1 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_2 = "ST69a"

			if arg_209_1.bgs_[var_212_2] == nil then
				local var_212_3 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_2)
				var_212_3.name = var_212_2
				var_212_3.transform.parent = arg_209_1.stage_.transform
				var_212_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_2] = var_212_3
			end

			local var_212_4 = 1

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				local var_212_5 = manager.ui.mainCamera.transform.localPosition
				local var_212_6 = Vector3.New(0, 0, 10) + Vector3.New(var_212_5.x, var_212_5.y, 0)
				local var_212_7 = arg_209_1.bgs_.ST69a

				var_212_7.transform.localPosition = var_212_6
				var_212_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_8 = var_212_7:GetComponent("SpriteRenderer")

				if var_212_8 and var_212_8.sprite then
					local var_212_9 = (var_212_7.transform.localPosition - var_212_5).z
					local var_212_10 = manager.ui.mainCameraCom_
					local var_212_11 = 2 * var_212_9 * Mathf.Tan(var_212_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_12 = var_212_11 * var_212_10.aspect
					local var_212_13 = var_212_8.sprite.bounds.size.x
					local var_212_14 = var_212_8.sprite.bounds.size.y
					local var_212_15 = var_212_12 / var_212_13
					local var_212_16 = var_212_11 / var_212_14
					local var_212_17 = var_212_16 < var_212_15 and var_212_15 or var_212_16

					var_212_7.transform.localScale = Vector3.New(var_212_17, var_212_17, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "ST69a" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_18 = 0

			if var_212_18 < arg_209_1.time_ and arg_209_1.time_ <= var_212_18 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_19 = 1

			if var_212_18 <= arg_209_1.time_ and arg_209_1.time_ < var_212_18 + var_212_19 then
				local var_212_20 = (arg_209_1.time_ - var_212_18) / var_212_19
				local var_212_21 = Color.New(0, 0, 0)

				var_212_21.a = Mathf.Lerp(0, 1, var_212_20)
				arg_209_1.mask_.color = var_212_21
			end

			if arg_209_1.time_ >= var_212_18 + var_212_19 and arg_209_1.time_ < var_212_18 + var_212_19 + arg_212_0 then
				local var_212_22 = Color.New(0, 0, 0)

				var_212_22.a = 1
				arg_209_1.mask_.color = var_212_22
			end

			local var_212_23 = 1

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_24 = 2

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24
				local var_212_26 = Color.New(0, 0, 0)

				var_212_26.a = Mathf.Lerp(1, 0, var_212_25)
				arg_209_1.mask_.color = var_212_26
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 then
				local var_212_27 = Color.New(0, 0, 0)
				local var_212_28 = 0

				arg_209_1.mask_.enabled = false
				var_212_27.a = var_212_28
				arg_209_1.mask_.color = var_212_27
			end

			local var_212_29 = arg_209_1.actors_["10111"].transform
			local var_212_30 = 1

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.var_.moveOldPos10111 = var_212_29.localPosition
				var_212_29.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10111", 7)

				local var_212_31 = var_212_29.childCount

				for iter_212_2 = 0, var_212_31 - 1 do
					local var_212_32 = var_212_29:GetChild(iter_212_2)

					if var_212_32.name == "" or not string.find(var_212_32.name, "split") then
						var_212_32.gameObject:SetActive(true)
					else
						var_212_32.gameObject:SetActive(false)
					end
				end
			end

			local var_212_33 = 0.001

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_33 then
				local var_212_34 = (arg_209_1.time_ - var_212_30) / var_212_33
				local var_212_35 = Vector3.New(0, -2000, 0)

				var_212_29.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10111, var_212_35, var_212_34)
			end

			if arg_209_1.time_ >= var_212_30 + var_212_33 and arg_209_1.time_ < var_212_30 + var_212_33 + arg_212_0 then
				var_212_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_36 = arg_209_1.actors_["10128"].transform
			local var_212_37 = 1

			if var_212_37 < arg_209_1.time_ and arg_209_1.time_ <= var_212_37 + arg_212_0 then
				arg_209_1.var_.moveOldPos10128 = var_212_36.localPosition
				var_212_36.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10128", 7)

				local var_212_38 = var_212_36.childCount

				for iter_212_3 = 0, var_212_38 - 1 do
					local var_212_39 = var_212_36:GetChild(iter_212_3)

					if var_212_39.name == "" or not string.find(var_212_39.name, "split") then
						var_212_39.gameObject:SetActive(true)
					else
						var_212_39.gameObject:SetActive(false)
					end
				end
			end

			local var_212_40 = 0.001

			if var_212_37 <= arg_209_1.time_ and arg_209_1.time_ < var_212_37 + var_212_40 then
				local var_212_41 = (arg_209_1.time_ - var_212_37) / var_212_40
				local var_212_42 = Vector3.New(0, -2000, -300)

				var_212_36.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10128, var_212_42, var_212_41)
			end

			if arg_209_1.time_ >= var_212_37 + var_212_40 and arg_209_1.time_ < var_212_37 + var_212_40 + arg_212_0 then
				var_212_36.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_212_43 = arg_209_1.actors_["10128"]
			local var_212_44 = 2.66666666666667

			if var_212_44 < arg_209_1.time_ and arg_209_1.time_ <= var_212_44 + arg_212_0 and not isNil(var_212_43) and arg_209_1.var_.actorSpriteComps10128 == nil then
				arg_209_1.var_.actorSpriteComps10128 = var_212_43:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_45 = 0.2

			if var_212_44 <= arg_209_1.time_ and arg_209_1.time_ < var_212_44 + var_212_45 and not isNil(var_212_43) then
				local var_212_46 = (arg_209_1.time_ - var_212_44) / var_212_45

				if arg_209_1.var_.actorSpriteComps10128 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								local var_212_47 = Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor1.r, var_212_46)
								local var_212_48 = Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor1.g, var_212_46)
								local var_212_49 = Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor1.b, var_212_46)

								iter_212_5.color = Color.New(var_212_47, var_212_48, var_212_49)
							else
								local var_212_50 = Mathf.Lerp(iter_212_5.color.r, 1, var_212_46)

								iter_212_5.color = Color.New(var_212_50, var_212_50, var_212_50)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_44 + var_212_45 and arg_209_1.time_ < var_212_44 + var_212_45 + arg_212_0 and not isNil(var_212_43) and arg_209_1.var_.actorSpriteComps10128 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10128 = nil
			end

			local var_212_51 = arg_209_1.actors_["10128"].transform
			local var_212_52 = 2.66666666666667

			if var_212_52 < arg_209_1.time_ and arg_209_1.time_ <= var_212_52 + arg_212_0 then
				arg_209_1.var_.moveOldPos10128 = var_212_51.localPosition
				var_212_51.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10128", 3)

				local var_212_53 = var_212_51.childCount

				for iter_212_8 = 0, var_212_53 - 1 do
					local var_212_54 = var_212_51:GetChild(iter_212_8)

					if var_212_54.name == "" or not string.find(var_212_54.name, "split") then
						var_212_54.gameObject:SetActive(true)
					else
						var_212_54.gameObject:SetActive(false)
					end
				end
			end

			local var_212_55 = 0.001

			if var_212_52 <= arg_209_1.time_ and arg_209_1.time_ < var_212_52 + var_212_55 then
				local var_212_56 = (arg_209_1.time_ - var_212_52) / var_212_55
				local var_212_57 = Vector3.New(0, -347, -300)

				var_212_51.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10128, var_212_57, var_212_56)
			end

			if arg_209_1.time_ >= var_212_52 + var_212_55 and arg_209_1.time_ < var_212_52 + var_212_55 + arg_212_0 then
				var_212_51.localPosition = Vector3.New(0, -347, -300)
			end

			local var_212_58 = arg_209_1.actors_["10128"]
			local var_212_59 = 2.66666666666667

			if var_212_59 < arg_209_1.time_ and arg_209_1.time_ <= var_212_59 + arg_212_0 then
				local var_212_60 = var_212_58:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_60 then
					arg_209_1.var_.alphaOldValue10128 = var_212_60.alpha
					arg_209_1.var_.characterEffect10128 = var_212_60
				end

				arg_209_1.var_.alphaOldValue10128 = 0
			end

			local var_212_61 = 0.333333333333333

			if var_212_59 <= arg_209_1.time_ and arg_209_1.time_ < var_212_59 + var_212_61 then
				local var_212_62 = (arg_209_1.time_ - var_212_59) / var_212_61
				local var_212_63 = Mathf.Lerp(arg_209_1.var_.alphaOldValue10128, 1, var_212_62)

				if arg_209_1.var_.characterEffect10128 then
					arg_209_1.var_.characterEffect10128.alpha = var_212_63
				end
			end

			if arg_209_1.time_ >= var_212_59 + var_212_61 and arg_209_1.time_ < var_212_59 + var_212_61 + arg_212_0 and arg_209_1.var_.characterEffect10128 then
				arg_209_1.var_.characterEffect10128.alpha = 1
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_64 = 3
			local var_212_65 = 0.6

			if var_212_64 < arg_209_1.time_ and arg_209_1.time_ <= var_212_64 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_66 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_66:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_67 = arg_209_1:FormatText(StoryNameCfg[595].name)

				arg_209_1.leftNameTxt_.text = var_212_67

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_68 = arg_209_1:GetWordFromCfg(417232051)
				local var_212_69 = arg_209_1:FormatText(var_212_68.content)

				arg_209_1.text_.text = var_212_69

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_70 = 24
				local var_212_71 = utf8.len(var_212_69)
				local var_212_72 = var_212_70 <= 0 and var_212_65 or var_212_65 * (var_212_71 / var_212_70)

				if var_212_72 > 0 and var_212_65 < var_212_72 then
					arg_209_1.talkMaxDuration = var_212_72
					var_212_64 = var_212_64 + 0.3

					if var_212_72 + var_212_64 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_72 + var_212_64
					end
				end

				arg_209_1.text_.text = var_212_69
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232051", "story_v_out_417232.awb") ~= 0 then
					local var_212_73 = manager.audio:GetVoiceLength("story_v_out_417232", "417232051", "story_v_out_417232.awb") / 1000

					if var_212_73 + var_212_64 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_73 + var_212_64
					end

					if var_212_68.prefab_name ~= "" and arg_209_1.actors_[var_212_68.prefab_name] ~= nil then
						local var_212_74 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_68.prefab_name].transform, "story_v_out_417232", "417232051", "story_v_out_417232.awb")

						arg_209_1:RecordAudio("417232051", var_212_74)
						arg_209_1:RecordAudio("417232051", var_212_74)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_417232", "417232051", "story_v_out_417232.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_417232", "417232051", "story_v_out_417232.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_75 = var_212_64 + 0.3
			local var_212_76 = math.max(var_212_65, arg_209_1.talkMaxDuration)

			if var_212_75 <= arg_209_1.time_ and arg_209_1.time_ < var_212_75 + var_212_76 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_75) / var_212_76

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_75 + var_212_76 and arg_209_1.time_ < var_212_75 + var_212_76 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play417232052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 417232052
		arg_215_1.duration_ = 5.8

		local var_215_0 = {
			zh = 5.8,
			ja = 5.733
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
				arg_215_0:Play417232053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = "1034"

			if arg_215_1.actors_[var_218_0] == nil then
				local var_218_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_218_1) then
					local var_218_2 = Object.Instantiate(var_218_1, arg_215_1.canvasGo_.transform)

					var_218_2.transform:SetSiblingIndex(1)

					var_218_2.name = var_218_0
					var_218_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_215_1.actors_[var_218_0] = var_218_2

					local var_218_3 = var_218_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_215_1.isInRecall_ then
						for iter_218_0, iter_218_1 in ipairs(var_218_3) do
							iter_218_1.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_218_4 = arg_215_1.actors_["1034"]
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.actorSpriteComps1034 == nil then
				arg_215_1.var_.actorSpriteComps1034 = var_218_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_6 = 0.2

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 and not isNil(var_218_4) then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6

				if arg_215_1.var_.actorSpriteComps1034 then
					for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_218_3 then
							if arg_215_1.isInRecall_ then
								local var_218_8 = Mathf.Lerp(iter_218_3.color.r, arg_215_1.hightColor1.r, var_218_7)
								local var_218_9 = Mathf.Lerp(iter_218_3.color.g, arg_215_1.hightColor1.g, var_218_7)
								local var_218_10 = Mathf.Lerp(iter_218_3.color.b, arg_215_1.hightColor1.b, var_218_7)

								iter_218_3.color = Color.New(var_218_8, var_218_9, var_218_10)
							else
								local var_218_11 = Mathf.Lerp(iter_218_3.color.r, 1, var_218_7)

								iter_218_3.color = Color.New(var_218_11, var_218_11, var_218_11)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.actorSpriteComps1034 then
				for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_218_5 then
						if arg_215_1.isInRecall_ then
							iter_218_5.color = arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_218_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps1034 = nil
			end

			local var_218_12 = arg_215_1.actors_["10128"]
			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 and not isNil(var_218_12) and arg_215_1.var_.actorSpriteComps10128 == nil then
				arg_215_1.var_.actorSpriteComps10128 = var_218_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_14 = 0.2

			if var_218_13 <= arg_215_1.time_ and arg_215_1.time_ < var_218_13 + var_218_14 and not isNil(var_218_12) then
				local var_218_15 = (arg_215_1.time_ - var_218_13) / var_218_14

				if arg_215_1.var_.actorSpriteComps10128 then
					for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_218_7 then
							if arg_215_1.isInRecall_ then
								local var_218_16 = Mathf.Lerp(iter_218_7.color.r, arg_215_1.hightColor2.r, var_218_15)
								local var_218_17 = Mathf.Lerp(iter_218_7.color.g, arg_215_1.hightColor2.g, var_218_15)
								local var_218_18 = Mathf.Lerp(iter_218_7.color.b, arg_215_1.hightColor2.b, var_218_15)

								iter_218_7.color = Color.New(var_218_16, var_218_17, var_218_18)
							else
								local var_218_19 = Mathf.Lerp(iter_218_7.color.r, 0.5, var_218_15)

								iter_218_7.color = Color.New(var_218_19, var_218_19, var_218_19)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_13 + var_218_14 and arg_215_1.time_ < var_218_13 + var_218_14 + arg_218_0 and not isNil(var_218_12) and arg_215_1.var_.actorSpriteComps10128 then
				for iter_218_8, iter_218_9 in pairs(arg_215_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_218_9 then
						if arg_215_1.isInRecall_ then
							iter_218_9.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10128 = nil
			end

			local var_218_20 = arg_215_1.actors_["1034"].transform
			local var_218_21 = 0

			if var_218_21 < arg_215_1.time_ and arg_215_1.time_ <= var_218_21 + arg_218_0 then
				arg_215_1.var_.moveOldPos1034 = var_218_20.localPosition
				var_218_20.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1034", 4)

				local var_218_22 = var_218_20.childCount

				for iter_218_10 = 0, var_218_22 - 1 do
					local var_218_23 = var_218_20:GetChild(iter_218_10)

					if var_218_23.name == "" or not string.find(var_218_23.name, "split") then
						var_218_23.gameObject:SetActive(true)
					else
						var_218_23.gameObject:SetActive(false)
					end
				end
			end

			local var_218_24 = 0.001

			if var_218_21 <= arg_215_1.time_ and arg_215_1.time_ < var_218_21 + var_218_24 then
				local var_218_25 = (arg_215_1.time_ - var_218_21) / var_218_24
				local var_218_26 = Vector3.New(373.7, -331.9, -324)

				var_218_20.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1034, var_218_26, var_218_25)
			end

			if arg_215_1.time_ >= var_218_21 + var_218_24 and arg_215_1.time_ < var_218_21 + var_218_24 + arg_218_0 then
				var_218_20.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_218_27 = arg_215_1.actors_["10128"].transform
			local var_218_28 = 0

			if var_218_28 < arg_215_1.time_ and arg_215_1.time_ <= var_218_28 + arg_218_0 then
				arg_215_1.var_.moveOldPos10128 = var_218_27.localPosition
				var_218_27.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10128", 2)

				local var_218_29 = var_218_27.childCount

				for iter_218_11 = 0, var_218_29 - 1 do
					local var_218_30 = var_218_27:GetChild(iter_218_11)

					if var_218_30.name == "" or not string.find(var_218_30.name, "split") then
						var_218_30.gameObject:SetActive(true)
					else
						var_218_30.gameObject:SetActive(false)
					end
				end
			end

			local var_218_31 = 0.001

			if var_218_28 <= arg_215_1.time_ and arg_215_1.time_ < var_218_28 + var_218_31 then
				local var_218_32 = (arg_215_1.time_ - var_218_28) / var_218_31
				local var_218_33 = Vector3.New(-390, -347, -300)

				var_218_27.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10128, var_218_33, var_218_32)
			end

			if arg_215_1.time_ >= var_218_28 + var_218_31 and arg_215_1.time_ < var_218_28 + var_218_31 + arg_218_0 then
				var_218_27.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_218_34 = 0
			local var_218_35 = 0.825

			if var_218_34 < arg_215_1.time_ and arg_215_1.time_ <= var_218_34 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_36 = arg_215_1:FormatText(StoryNameCfg[1109].name)

				arg_215_1.leftNameTxt_.text = var_218_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_37 = arg_215_1:GetWordFromCfg(417232052)
				local var_218_38 = arg_215_1:FormatText(var_218_37.content)

				arg_215_1.text_.text = var_218_38

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_39 = 33
				local var_218_40 = utf8.len(var_218_38)
				local var_218_41 = var_218_39 <= 0 and var_218_35 or var_218_35 * (var_218_40 / var_218_39)

				if var_218_41 > 0 and var_218_35 < var_218_41 then
					arg_215_1.talkMaxDuration = var_218_41

					if var_218_41 + var_218_34 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_41 + var_218_34
					end
				end

				arg_215_1.text_.text = var_218_38
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232052", "story_v_out_417232.awb") ~= 0 then
					local var_218_42 = manager.audio:GetVoiceLength("story_v_out_417232", "417232052", "story_v_out_417232.awb") / 1000

					if var_218_42 + var_218_34 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_42 + var_218_34
					end

					if var_218_37.prefab_name ~= "" and arg_215_1.actors_[var_218_37.prefab_name] ~= nil then
						local var_218_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_37.prefab_name].transform, "story_v_out_417232", "417232052", "story_v_out_417232.awb")

						arg_215_1:RecordAudio("417232052", var_218_43)
						arg_215_1:RecordAudio("417232052", var_218_43)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_417232", "417232052", "story_v_out_417232.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_417232", "417232052", "story_v_out_417232.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_44 = math.max(var_218_35, arg_215_1.talkMaxDuration)

			if var_218_34 <= arg_215_1.time_ and arg_215_1.time_ < var_218_34 + var_218_44 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_34) / var_218_44

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_34 + var_218_44 and arg_215_1.time_ < var_218_34 + var_218_44 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
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
	Play417232053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 417232053
		arg_219_1.duration_ = 4.83

		local var_219_0 = {
			zh = 3.133,
			ja = 4.833
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
				arg_219_0:Play417232054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10111"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10111 == nil then
				arg_219_1.var_.actorSpriteComps10111 = var_222_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_2 = 0.2

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.actorSpriteComps10111 then
					for iter_222_0, iter_222_1 in pairs(arg_219_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_222_1 then
							if arg_219_1.isInRecall_ then
								local var_222_4 = Mathf.Lerp(iter_222_1.color.r, arg_219_1.hightColor1.r, var_222_3)
								local var_222_5 = Mathf.Lerp(iter_222_1.color.g, arg_219_1.hightColor1.g, var_222_3)
								local var_222_6 = Mathf.Lerp(iter_222_1.color.b, arg_219_1.hightColor1.b, var_222_3)

								iter_222_1.color = Color.New(var_222_4, var_222_5, var_222_6)
							else
								local var_222_7 = Mathf.Lerp(iter_222_1.color.r, 1, var_222_3)

								iter_222_1.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.actorSpriteComps10111 then
				for iter_222_2, iter_222_3 in pairs(arg_219_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_222_3 then
						if arg_219_1.isInRecall_ then
							iter_222_3.color = arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_222_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_219_1.var_.actorSpriteComps10111 = nil
			end

			local var_222_8 = arg_219_1.actors_["1034"].transform
			local var_222_9 = 0

			if var_222_9 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.var_.moveOldPos1034 = var_222_8.localPosition
				var_222_8.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1034", 7)

				local var_222_10 = var_222_8.childCount

				for iter_222_4 = 0, var_222_10 - 1 do
					local var_222_11 = var_222_8:GetChild(iter_222_4)

					if var_222_11.name == "" or not string.find(var_222_11.name, "split") then
						var_222_11.gameObject:SetActive(true)
					else
						var_222_11.gameObject:SetActive(false)
					end
				end
			end

			local var_222_12 = 0.001

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_12 then
				local var_222_13 = (arg_219_1.time_ - var_222_9) / var_222_12
				local var_222_14 = Vector3.New(0, -2000, 0)

				var_222_8.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1034, var_222_14, var_222_13)
			end

			if arg_219_1.time_ >= var_222_9 + var_222_12 and arg_219_1.time_ < var_222_9 + var_222_12 + arg_222_0 then
				var_222_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_222_15 = arg_219_1.actors_["10128"].transform
			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.var_.moveOldPos10128 = var_222_15.localPosition
				var_222_15.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10128", 7)

				local var_222_17 = var_222_15.childCount

				for iter_222_5 = 0, var_222_17 - 1 do
					local var_222_18 = var_222_15:GetChild(iter_222_5)

					if var_222_18.name == "" or not string.find(var_222_18.name, "split") then
						var_222_18.gameObject:SetActive(true)
					else
						var_222_18.gameObject:SetActive(false)
					end
				end
			end

			local var_222_19 = 0.001

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_19 then
				local var_222_20 = (arg_219_1.time_ - var_222_16) / var_222_19
				local var_222_21 = Vector3.New(0, -2000, -300)

				var_222_15.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10128, var_222_21, var_222_20)
			end

			if arg_219_1.time_ >= var_222_16 + var_222_19 and arg_219_1.time_ < var_222_16 + var_222_19 + arg_222_0 then
				var_222_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_222_22 = arg_219_1.actors_["10111"].transform
			local var_222_23 = 0

			if var_222_23 < arg_219_1.time_ and arg_219_1.time_ <= var_222_23 + arg_222_0 then
				arg_219_1.var_.moveOldPos10111 = var_222_22.localPosition
				var_222_22.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10111", 3)

				local var_222_24 = var_222_22.childCount

				for iter_222_6 = 0, var_222_24 - 1 do
					local var_222_25 = var_222_22:GetChild(iter_222_6)

					if var_222_25.name == "" or not string.find(var_222_25.name, "split") then
						var_222_25.gameObject:SetActive(true)
					else
						var_222_25.gameObject:SetActive(false)
					end
				end
			end

			local var_222_26 = 0.001

			if var_222_23 <= arg_219_1.time_ and arg_219_1.time_ < var_222_23 + var_222_26 then
				local var_222_27 = (arg_219_1.time_ - var_222_23) / var_222_26
				local var_222_28 = Vector3.New(0, -361.1, -274.6)

				var_222_22.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10111, var_222_28, var_222_27)
			end

			if arg_219_1.time_ >= var_222_23 + var_222_26 and arg_219_1.time_ < var_222_23 + var_222_26 + arg_222_0 then
				var_222_22.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_222_29 = 0
			local var_222_30 = 0.375

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_31 = arg_219_1:FormatText(StoryNameCfg[1125].name)

				arg_219_1.leftNameTxt_.text = var_222_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_32 = arg_219_1:GetWordFromCfg(417232053)
				local var_222_33 = arg_219_1:FormatText(var_222_32.content)

				arg_219_1.text_.text = var_222_33

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_34 = 15
				local var_222_35 = utf8.len(var_222_33)
				local var_222_36 = var_222_34 <= 0 and var_222_30 or var_222_30 * (var_222_35 / var_222_34)

				if var_222_36 > 0 and var_222_30 < var_222_36 then
					arg_219_1.talkMaxDuration = var_222_36

					if var_222_36 + var_222_29 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_36 + var_222_29
					end
				end

				arg_219_1.text_.text = var_222_33
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232053", "story_v_out_417232.awb") ~= 0 then
					local var_222_37 = manager.audio:GetVoiceLength("story_v_out_417232", "417232053", "story_v_out_417232.awb") / 1000

					if var_222_37 + var_222_29 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_37 + var_222_29
					end

					if var_222_32.prefab_name ~= "" and arg_219_1.actors_[var_222_32.prefab_name] ~= nil then
						local var_222_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_32.prefab_name].transform, "story_v_out_417232", "417232053", "story_v_out_417232.awb")

						arg_219_1:RecordAudio("417232053", var_222_38)
						arg_219_1:RecordAudio("417232053", var_222_38)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_417232", "417232053", "story_v_out_417232.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_417232", "417232053", "story_v_out_417232.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_39 = math.max(var_222_30, arg_219_1.talkMaxDuration)

			if var_222_29 <= arg_219_1.time_ and arg_219_1.time_ < var_222_29 + var_222_39 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_29) / var_222_39

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_29 + var_222_39 and arg_219_1.time_ < var_222_29 + var_222_39 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play417232054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 417232054
		arg_223_1.duration_ = 6.1

		local var_223_0 = {
			zh = 4.466,
			ja = 6.1
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
				arg_223_0:Play417232055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10111"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10111 = var_226_0.localPosition
				var_226_0.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10111", 3)

				local var_226_2 = var_226_0.childCount

				for iter_226_0 = 0, var_226_2 - 1 do
					local var_226_3 = var_226_0:GetChild(iter_226_0)

					if var_226_3.name == "split_2" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_4 then
				local var_226_5 = (arg_223_1.time_ - var_226_1) / var_226_4
				local var_226_6 = Vector3.New(0, -361.1, -274.6)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10111, var_226_6, var_226_5)
			end

			if arg_223_1.time_ >= var_226_1 + var_226_4 and arg_223_1.time_ < var_226_1 + var_226_4 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_226_7 = 0
			local var_226_8 = 0.55

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_9 = arg_223_1:FormatText(StoryNameCfg[1125].name)

				arg_223_1.leftNameTxt_.text = var_226_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(417232054)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_12 = 22
				local var_226_13 = utf8.len(var_226_11)
				local var_226_14 = var_226_12 <= 0 and var_226_8 or var_226_8 * (var_226_13 / var_226_12)

				if var_226_14 > 0 and var_226_8 < var_226_14 then
					arg_223_1.talkMaxDuration = var_226_14

					if var_226_14 + var_226_7 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_7
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232054", "story_v_out_417232.awb") ~= 0 then
					local var_226_15 = manager.audio:GetVoiceLength("story_v_out_417232", "417232054", "story_v_out_417232.awb") / 1000

					if var_226_15 + var_226_7 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_7
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_417232", "417232054", "story_v_out_417232.awb")

						arg_223_1:RecordAudio("417232054", var_226_16)
						arg_223_1:RecordAudio("417232054", var_226_16)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_417232", "417232054", "story_v_out_417232.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_417232", "417232054", "story_v_out_417232.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_17 = math.max(var_226_8, arg_223_1.talkMaxDuration)

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_17 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_7) / var_226_17

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_7 + var_226_17 and arg_223_1.time_ < var_226_7 + var_226_17 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 417232055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play417232056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10111"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos10111 = var_230_0.localPosition
				var_230_0.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10111", 7)

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
				local var_230_6 = Vector3.New(0, -2000, 0)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10111, var_230_6, var_230_5)
			end

			if arg_227_1.time_ >= var_230_1 + var_230_4 and arg_227_1.time_ < var_230_1 + var_230_4 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_7 = 0.02
			local var_230_8 = 1

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				local var_230_9 = "play"
				local var_230_10 = "effect"

				arg_227_1:AudioAction(var_230_9, var_230_10, "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_230_11 = 0
			local var_230_12 = 1.275

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_13 = arg_227_1:GetWordFromCfg(417232055)
				local var_230_14 = arg_227_1:FormatText(var_230_13.content)

				arg_227_1.text_.text = var_230_14

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_15 = 51
				local var_230_16 = utf8.len(var_230_14)
				local var_230_17 = var_230_15 <= 0 and var_230_12 or var_230_12 * (var_230_16 / var_230_15)

				if var_230_17 > 0 and var_230_12 < var_230_17 then
					arg_227_1.talkMaxDuration = var_230_17

					if var_230_17 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_11
					end
				end

				arg_227_1.text_.text = var_230_14
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_18 = math.max(var_230_12, arg_227_1.talkMaxDuration)

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_18 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_11) / var_230_18

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_11 + var_230_18 and arg_227_1.time_ < var_230_11 + var_230_18 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 417232056
		arg_231_1.duration_ = 2.37

		local var_231_0 = {
			zh = 1.766,
			ja = 2.366
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play417232057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.125

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[1110].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:GetWordFromCfg(417232056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 5
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232056", "story_v_out_417232.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232056", "story_v_out_417232.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_417232", "417232056", "story_v_out_417232.awb")

						arg_231_1:RecordAudio("417232056", var_234_9)
						arg_231_1:RecordAudio("417232056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_417232", "417232056", "story_v_out_417232.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_417232", "417232056", "story_v_out_417232.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play417232057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 417232057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play417232058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.1

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(417232057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 44
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play417232058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 417232058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play417232059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.775

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(417232058)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 31
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play417232059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 417232059
		arg_243_1.duration_ = 7.47

		local var_243_0 = {
			zh = 3.1,
			ja = 7.466
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
				arg_243_0:Play417232060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["10128"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10128 == nil then
				arg_243_1.var_.actorSpriteComps10128 = var_246_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_2 = 0.2

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.actorSpriteComps10128 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								local var_246_4 = Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, var_246_3)
								local var_246_5 = Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, var_246_3)
								local var_246_6 = Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, var_246_3)

								iter_246_1.color = Color.New(var_246_4, var_246_5, var_246_6)
							else
								local var_246_7 = Mathf.Lerp(iter_246_1.color.r, 1, var_246_3)

								iter_246_1.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.actorSpriteComps10128 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_246_3 then
						if arg_243_1.isInRecall_ then
							iter_246_3.color = arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_246_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_243_1.var_.actorSpriteComps10128 = nil
			end

			local var_246_8 = arg_243_1.actors_["10128"].transform
			local var_246_9 = 0

			if var_246_9 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.var_.moveOldPos10128 = var_246_8.localPosition
				var_246_8.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10128", 3)

				local var_246_10 = var_246_8.childCount

				for iter_246_4 = 0, var_246_10 - 1 do
					local var_246_11 = var_246_8:GetChild(iter_246_4)

					if var_246_11.name == "" or not string.find(var_246_11.name, "split") then
						var_246_11.gameObject:SetActive(true)
					else
						var_246_11.gameObject:SetActive(false)
					end
				end
			end

			local var_246_12 = 0.001

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_12 then
				local var_246_13 = (arg_243_1.time_ - var_246_9) / var_246_12
				local var_246_14 = Vector3.New(0, -347, -300)

				var_246_8.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10128, var_246_14, var_246_13)
			end

			if arg_243_1.time_ >= var_246_9 + var_246_12 and arg_243_1.time_ < var_246_9 + var_246_12 + arg_246_0 then
				var_246_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_246_15 = 0
			local var_246_16 = 0.4

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[595].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(417232059)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 16
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232059", "story_v_out_417232.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232059", "story_v_out_417232.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_417232", "417232059", "story_v_out_417232.awb")

						arg_243_1:RecordAudio("417232059", var_246_24)
						arg_243_1:RecordAudio("417232059", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_417232", "417232059", "story_v_out_417232.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_417232", "417232059", "story_v_out_417232.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play417232060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417232060
		arg_247_1.duration_ = 6.1

		local var_247_0 = {
			zh = 6.1,
			ja = 5.9
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
				arg_247_0:Play417232061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10128"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10128 == nil then
				arg_247_1.var_.actorSpriteComps10128 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 0.2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10128 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 0.5, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10128 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10128 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.55

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_10 = arg_247_1:FormatText(StoryNameCfg[471].name)

				arg_247_1.leftNameTxt_.text = var_250_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_split_2")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_11 = arg_247_1:GetWordFromCfg(417232060)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 22
				local var_250_14 = utf8.len(var_250_12)
				local var_250_15 = var_250_13 <= 0 and var_250_9 or var_250_9 * (var_250_14 / var_250_13)

				if var_250_15 > 0 and var_250_9 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_12
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232060", "story_v_out_417232.awb") ~= 0 then
					local var_250_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232060", "story_v_out_417232.awb") / 1000

					if var_250_16 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_16 + var_250_8
					end

					if var_250_11.prefab_name ~= "" and arg_247_1.actors_[var_250_11.prefab_name] ~= nil then
						local var_250_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_11.prefab_name].transform, "story_v_out_417232", "417232060", "story_v_out_417232.awb")

						arg_247_1:RecordAudio("417232060", var_250_17)
						arg_247_1:RecordAudio("417232060", var_250_17)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_417232", "417232060", "story_v_out_417232.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_417232", "417232060", "story_v_out_417232.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_18 and arg_247_1.time_ < var_250_8 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play417232061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 417232061
		arg_251_1.duration_ = 2.83

		local var_251_0 = {
			zh = 1.966,
			ja = 2.833
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
				arg_251_0:Play417232062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.2

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[471].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_split_2")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(417232061)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 8
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232061", "story_v_out_417232.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232061", "story_v_out_417232.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_417232", "417232061", "story_v_out_417232.awb")

						arg_251_1:RecordAudio("417232061", var_254_9)
						arg_251_1:RecordAudio("417232061", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_417232", "417232061", "story_v_out_417232.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_417232", "417232061", "story_v_out_417232.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play417232062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 417232062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play417232063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = "1095"

			if arg_255_1.actors_[var_258_0] == nil then
				local var_258_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

				if not isNil(var_258_1) then
					local var_258_2 = Object.Instantiate(var_258_1, arg_255_1.canvasGo_.transform)

					var_258_2.transform:SetSiblingIndex(1)

					var_258_2.name = var_258_0
					var_258_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_255_1.actors_[var_258_0] = var_258_2

					local var_258_3 = var_258_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_255_1.isInRecall_ then
						for iter_258_0, iter_258_1 in ipairs(var_258_3) do
							iter_258_1.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_258_4 = arg_255_1.actors_["1095"].transform
			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.var_.moveOldPos1095 = var_258_4.localPosition
				var_258_4.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1095", 7)

				local var_258_6 = var_258_4.childCount

				for iter_258_2 = 0, var_258_6 - 1 do
					local var_258_7 = var_258_4:GetChild(iter_258_2)

					if var_258_7.name == "" or not string.find(var_258_7.name, "split") then
						var_258_7.gameObject:SetActive(true)
					else
						var_258_7.gameObject:SetActive(false)
					end
				end
			end

			local var_258_8 = 0.001

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_8 then
				local var_258_9 = (arg_255_1.time_ - var_258_5) / var_258_8
				local var_258_10 = Vector3.New(0, -2000, 0)

				var_258_4.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1095, var_258_10, var_258_9)
			end

			if arg_255_1.time_ >= var_258_5 + var_258_8 and arg_255_1.time_ < var_258_5 + var_258_8 + arg_258_0 then
				var_258_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_258_11 = 0
			local var_258_12 = 1.475

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(417232062)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 59
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_12 or var_258_12 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_12 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_11 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_11
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_18 = math.max(var_258_12, arg_255_1.talkMaxDuration)

			if var_258_11 <= arg_255_1.time_ and arg_255_1.time_ < var_258_11 + var_258_18 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_11) / var_258_18

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_11 + var_258_18 and arg_255_1.time_ < var_258_11 + var_258_18 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play417232063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 417232063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play417232064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 1.25

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(417232063)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 50
				local var_262_5 = utf8.len(var_262_3)
				local var_262_6 = var_262_4 <= 0 and var_262_1 or var_262_1 * (var_262_5 / var_262_4)

				if var_262_6 > 0 and var_262_1 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_7 and arg_259_1.time_ < var_262_0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play417232064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417232064
		arg_263_1.duration_ = 4.97

		local var_263_0 = {
			zh = 2.5,
			ja = 4.966
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
				arg_263_0:Play417232065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10111"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10111 == nil then
				arg_263_1.var_.actorSpriteComps10111 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps10111 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								local var_266_4 = Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, var_266_3)
								local var_266_5 = Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, var_266_3)
								local var_266_6 = Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, var_266_3)

								iter_266_1.color = Color.New(var_266_4, var_266_5, var_266_6)
							else
								local var_266_7 = Mathf.Lerp(iter_266_1.color.r, 1, var_266_3)

								iter_266_1.color = Color.New(var_266_7, var_266_7, var_266_7)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps10111 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps10111 = nil
			end

			local var_266_8 = arg_263_1.actors_["10111"].transform
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.var_.moveOldPos10111 = var_266_8.localPosition
				var_266_8.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10111", 3)

				local var_266_10 = var_266_8.childCount

				for iter_266_4 = 0, var_266_10 - 1 do
					local var_266_11 = var_266_8:GetChild(iter_266_4)

					if var_266_11.name == "split_2" or not string.find(var_266_11.name, "split") then
						var_266_11.gameObject:SetActive(true)
					else
						var_266_11.gameObject:SetActive(false)
					end
				end
			end

			local var_266_12 = 0.001

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_12 then
				local var_266_13 = (arg_263_1.time_ - var_266_9) / var_266_12
				local var_266_14 = Vector3.New(0, -361.1, -274.6)

				var_266_8.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10111, var_266_14, var_266_13)
			end

			if arg_263_1.time_ >= var_266_9 + var_266_12 and arg_263_1.time_ < var_266_9 + var_266_12 + arg_266_0 then
				var_266_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_266_15 = 0
			local var_266_16 = 0.3

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[1125].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(417232064)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 12
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232064", "story_v_out_417232.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232064", "story_v_out_417232.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_417232", "417232064", "story_v_out_417232.awb")

						arg_263_1:RecordAudio("417232064", var_266_24)
						arg_263_1:RecordAudio("417232064", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_417232", "417232064", "story_v_out_417232.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_417232", "417232064", "story_v_out_417232.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417232065
		arg_267_1.duration_ = 7.6

		local var_267_0 = {
			zh = 5.3,
			ja = 7.6
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
				arg_267_0:Play417232066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = "1060"

			if arg_267_1.actors_[var_270_0] == nil then
				local var_270_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_270_1) then
					local var_270_2 = Object.Instantiate(var_270_1, arg_267_1.canvasGo_.transform)

					var_270_2.transform:SetSiblingIndex(1)

					var_270_2.name = var_270_0
					var_270_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_267_1.actors_[var_270_0] = var_270_2

					local var_270_3 = var_270_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_267_1.isInRecall_ then
						for iter_270_0, iter_270_1 in ipairs(var_270_3) do
							iter_270_1.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_270_4 = arg_267_1.actors_["1060"]
			local var_270_5 = 0

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.actorSpriteComps1060 == nil then
				arg_267_1.var_.actorSpriteComps1060 = var_270_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_6 = 0.2

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 and not isNil(var_270_4) then
				local var_270_7 = (arg_267_1.time_ - var_270_5) / var_270_6

				if arg_267_1.var_.actorSpriteComps1060 then
					for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_270_3 then
							if arg_267_1.isInRecall_ then
								local var_270_8 = Mathf.Lerp(iter_270_3.color.r, arg_267_1.hightColor1.r, var_270_7)
								local var_270_9 = Mathf.Lerp(iter_270_3.color.g, arg_267_1.hightColor1.g, var_270_7)
								local var_270_10 = Mathf.Lerp(iter_270_3.color.b, arg_267_1.hightColor1.b, var_270_7)

								iter_270_3.color = Color.New(var_270_8, var_270_9, var_270_10)
							else
								local var_270_11 = Mathf.Lerp(iter_270_3.color.r, 1, var_270_7)

								iter_270_3.color = Color.New(var_270_11, var_270_11, var_270_11)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.actorSpriteComps1060 then
				for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_270_5 then
						if arg_267_1.isInRecall_ then
							iter_270_5.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1060 = nil
			end

			local var_270_12 = arg_267_1.actors_["10111"]
			local var_270_13 = 0

			if var_270_13 < arg_267_1.time_ and arg_267_1.time_ <= var_270_13 + arg_270_0 and not isNil(var_270_12) and arg_267_1.var_.actorSpriteComps10111 == nil then
				arg_267_1.var_.actorSpriteComps10111 = var_270_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_14 = 0.2

			if var_270_13 <= arg_267_1.time_ and arg_267_1.time_ < var_270_13 + var_270_14 and not isNil(var_270_12) then
				local var_270_15 = (arg_267_1.time_ - var_270_13) / var_270_14

				if arg_267_1.var_.actorSpriteComps10111 then
					for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_270_7 then
							if arg_267_1.isInRecall_ then
								local var_270_16 = Mathf.Lerp(iter_270_7.color.r, arg_267_1.hightColor2.r, var_270_15)
								local var_270_17 = Mathf.Lerp(iter_270_7.color.g, arg_267_1.hightColor2.g, var_270_15)
								local var_270_18 = Mathf.Lerp(iter_270_7.color.b, arg_267_1.hightColor2.b, var_270_15)

								iter_270_7.color = Color.New(var_270_16, var_270_17, var_270_18)
							else
								local var_270_19 = Mathf.Lerp(iter_270_7.color.r, 0.5, var_270_15)

								iter_270_7.color = Color.New(var_270_19, var_270_19, var_270_19)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_13 + var_270_14 and arg_267_1.time_ < var_270_13 + var_270_14 + arg_270_0 and not isNil(var_270_12) and arg_267_1.var_.actorSpriteComps10111 then
				for iter_270_8, iter_270_9 in pairs(arg_267_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_270_9 then
						if arg_267_1.isInRecall_ then
							iter_270_9.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10111 = nil
			end

			local var_270_20 = arg_267_1.actors_["10111"].transform
			local var_270_21 = 0

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.var_.moveOldPos10111 = var_270_20.localPosition
				var_270_20.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10111", 2)

				local var_270_22 = var_270_20.childCount

				for iter_270_10 = 0, var_270_22 - 1 do
					local var_270_23 = var_270_20:GetChild(iter_270_10)

					if var_270_23.name == "" or not string.find(var_270_23.name, "split") then
						var_270_23.gameObject:SetActive(true)
					else
						var_270_23.gameObject:SetActive(false)
					end
				end
			end

			local var_270_24 = 0.001

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_24 then
				local var_270_25 = (arg_267_1.time_ - var_270_21) / var_270_24
				local var_270_26 = Vector3.New(-390, -361.1, -274.6)

				var_270_20.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10111, var_270_26, var_270_25)
			end

			if arg_267_1.time_ >= var_270_21 + var_270_24 and arg_267_1.time_ < var_270_21 + var_270_24 + arg_270_0 then
				var_270_20.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_270_27 = arg_267_1.actors_["1060"].transform
			local var_270_28 = 0

			if var_270_28 < arg_267_1.time_ and arg_267_1.time_ <= var_270_28 + arg_270_0 then
				arg_267_1.var_.moveOldPos1060 = var_270_27.localPosition
				var_270_27.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1060", 4)

				local var_270_29 = var_270_27.childCount

				for iter_270_11 = 0, var_270_29 - 1 do
					local var_270_30 = var_270_27:GetChild(iter_270_11)

					if var_270_30.name == "" or not string.find(var_270_30.name, "split") then
						var_270_30.gameObject:SetActive(true)
					else
						var_270_30.gameObject:SetActive(false)
					end
				end
			end

			local var_270_31 = 0.001

			if var_270_28 <= arg_267_1.time_ and arg_267_1.time_ < var_270_28 + var_270_31 then
				local var_270_32 = (arg_267_1.time_ - var_270_28) / var_270_31
				local var_270_33 = Vector3.New(420.9, -430.8, 6.9)

				var_270_27.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1060, var_270_33, var_270_32)
			end

			if arg_267_1.time_ >= var_270_28 + var_270_31 and arg_267_1.time_ < var_270_28 + var_270_31 + arg_270_0 then
				var_270_27.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_270_34 = 0
			local var_270_35 = 0.55

			if var_270_34 < arg_267_1.time_ and arg_267_1.time_ <= var_270_34 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_36 = arg_267_1:FormatText(StoryNameCfg[584].name)

				arg_267_1.leftNameTxt_.text = var_270_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_37 = arg_267_1:GetWordFromCfg(417232065)
				local var_270_38 = arg_267_1:FormatText(var_270_37.content)

				arg_267_1.text_.text = var_270_38

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_39 = 22
				local var_270_40 = utf8.len(var_270_38)
				local var_270_41 = var_270_39 <= 0 and var_270_35 or var_270_35 * (var_270_40 / var_270_39)

				if var_270_41 > 0 and var_270_35 < var_270_41 then
					arg_267_1.talkMaxDuration = var_270_41

					if var_270_41 + var_270_34 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_41 + var_270_34
					end
				end

				arg_267_1.text_.text = var_270_38
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232065", "story_v_out_417232.awb") ~= 0 then
					local var_270_42 = manager.audio:GetVoiceLength("story_v_out_417232", "417232065", "story_v_out_417232.awb") / 1000

					if var_270_42 + var_270_34 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_42 + var_270_34
					end

					if var_270_37.prefab_name ~= "" and arg_267_1.actors_[var_270_37.prefab_name] ~= nil then
						local var_270_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_37.prefab_name].transform, "story_v_out_417232", "417232065", "story_v_out_417232.awb")

						arg_267_1:RecordAudio("417232065", var_270_43)
						arg_267_1:RecordAudio("417232065", var_270_43)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_417232", "417232065", "story_v_out_417232.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_417232", "417232065", "story_v_out_417232.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_44 = math.max(var_270_35, arg_267_1.talkMaxDuration)

			if var_270_34 <= arg_267_1.time_ and arg_267_1.time_ < var_270_34 + var_270_44 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_34) / var_270_44

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_34 + var_270_44 and arg_267_1.time_ < var_270_34 + var_270_44 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417232066
		arg_271_1.duration_ = 4.4

		local var_271_0 = {
			zh = 4.4,
			ja = 4.1
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
				arg_271_0:Play417232067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10111"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10111 == nil then
				arg_271_1.var_.actorSpriteComps10111 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps10111 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								local var_274_4 = Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, var_274_3)
								local var_274_5 = Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, var_274_3)
								local var_274_6 = Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, var_274_3)

								iter_274_1.color = Color.New(var_274_4, var_274_5, var_274_6)
							else
								local var_274_7 = Mathf.Lerp(iter_274_1.color.r, 1, var_274_3)

								iter_274_1.color = Color.New(var_274_7, var_274_7, var_274_7)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps10111 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10111 = nil
			end

			local var_274_8 = arg_271_1.actors_["1060"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1060 == nil then
				arg_271_1.var_.actorSpriteComps1060 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps1060 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								local var_274_12 = Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor2.r, var_274_11)
								local var_274_13 = Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor2.g, var_274_11)
								local var_274_14 = Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor2.b, var_274_11)

								iter_274_5.color = Color.New(var_274_12, var_274_13, var_274_14)
							else
								local var_274_15 = Mathf.Lerp(iter_274_5.color.r, 0.5, var_274_11)

								iter_274_5.color = Color.New(var_274_15, var_274_15, var_274_15)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1060 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1060 = nil
			end

			local var_274_16 = 0
			local var_274_17 = 0.425

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_18 = arg_271_1:FormatText(StoryNameCfg[1125].name)

				arg_271_1.leftNameTxt_.text = var_274_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(417232066)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 17
				local var_274_22 = utf8.len(var_274_20)
				local var_274_23 = var_274_21 <= 0 and var_274_17 or var_274_17 * (var_274_22 / var_274_21)

				if var_274_23 > 0 and var_274_17 < var_274_23 then
					arg_271_1.talkMaxDuration = var_274_23

					if var_274_23 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_23 + var_274_16
					end
				end

				arg_271_1.text_.text = var_274_20
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232066", "story_v_out_417232.awb") ~= 0 then
					local var_274_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232066", "story_v_out_417232.awb") / 1000

					if var_274_24 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_16
					end

					if var_274_19.prefab_name ~= "" and arg_271_1.actors_[var_274_19.prefab_name] ~= nil then
						local var_274_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_19.prefab_name].transform, "story_v_out_417232", "417232066", "story_v_out_417232.awb")

						arg_271_1:RecordAudio("417232066", var_274_25)
						arg_271_1:RecordAudio("417232066", var_274_25)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_417232", "417232066", "story_v_out_417232.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_417232", "417232066", "story_v_out_417232.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_26 = math.max(var_274_17, arg_271_1.talkMaxDuration)

			if var_274_16 <= arg_271_1.time_ and arg_271_1.time_ < var_274_16 + var_274_26 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_16) / var_274_26

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_16 + var_274_26 and arg_271_1.time_ < var_274_16 + var_274_26 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play417232067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417232067
		arg_275_1.duration_ = 7.07

		local var_275_0 = {
			zh = 7.066,
			ja = 5.4
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
				arg_275_0:Play417232068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.9

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[1125].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:GetWordFromCfg(417232067)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 36
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232067", "story_v_out_417232.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232067", "story_v_out_417232.awb") / 1000

					if var_278_8 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_0
					end

					if var_278_3.prefab_name ~= "" and arg_275_1.actors_[var_278_3.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_3.prefab_name].transform, "story_v_out_417232", "417232067", "story_v_out_417232.awb")

						arg_275_1:RecordAudio("417232067", var_278_9)
						arg_275_1:RecordAudio("417232067", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_417232", "417232067", "story_v_out_417232.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_417232", "417232067", "story_v_out_417232.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_10 and arg_275_1.time_ < var_278_0 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play417232068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417232068
		arg_279_1.duration_ = 9.17

		local var_279_0 = {
			zh = 9.166,
			ja = 8.733
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
				arg_279_0:Play417232069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 1

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_2 = arg_279_1:FormatText(StoryNameCfg[1125].name)

				arg_279_1.leftNameTxt_.text = var_282_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:GetWordFromCfg(417232068)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 40
				local var_282_6 = utf8.len(var_282_4)
				local var_282_7 = var_282_5 <= 0 and var_282_1 or var_282_1 * (var_282_6 / var_282_5)

				if var_282_7 > 0 and var_282_1 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232068", "story_v_out_417232.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232068", "story_v_out_417232.awb") / 1000

					if var_282_8 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_0
					end

					if var_282_3.prefab_name ~= "" and arg_279_1.actors_[var_282_3.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_3.prefab_name].transform, "story_v_out_417232", "417232068", "story_v_out_417232.awb")

						arg_279_1:RecordAudio("417232068", var_282_9)
						arg_279_1:RecordAudio("417232068", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417232", "417232068", "story_v_out_417232.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417232", "417232068", "story_v_out_417232.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_10 and arg_279_1.time_ < var_282_0 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play417232069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417232069
		arg_283_1.duration_ = 10

		local var_283_0 = {
			zh = 6.8,
			ja = 10
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
				arg_283_0:Play417232070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1060"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1060 == nil then
				arg_283_1.var_.actorSpriteComps1060 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps1060 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1060 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1060 = nil
			end

			local var_286_8 = arg_283_1.actors_["10111"]
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps10111 == nil then
				arg_283_1.var_.actorSpriteComps10111 = var_286_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_10 = 0.2

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_10 and not isNil(var_286_8) then
				local var_286_11 = (arg_283_1.time_ - var_286_9) / var_286_10

				if arg_283_1.var_.actorSpriteComps10111 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_283_1.time_ >= var_286_9 + var_286_10 and arg_283_1.time_ < var_286_9 + var_286_10 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps10111 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_286_7 then
						if arg_283_1.isInRecall_ then
							iter_286_7.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10111 = nil
			end

			local var_286_16 = 0
			local var_286_17 = 0.85

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_18 = arg_283_1:FormatText(StoryNameCfg[584].name)

				arg_283_1.leftNameTxt_.text = var_286_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_19 = arg_283_1:GetWordFromCfg(417232069)
				local var_286_20 = arg_283_1:FormatText(var_286_19.content)

				arg_283_1.text_.text = var_286_20

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_21 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232069", "story_v_out_417232.awb") ~= 0 then
					local var_286_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232069", "story_v_out_417232.awb") / 1000

					if var_286_24 + var_286_16 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_24 + var_286_16
					end

					if var_286_19.prefab_name ~= "" and arg_283_1.actors_[var_286_19.prefab_name] ~= nil then
						local var_286_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_19.prefab_name].transform, "story_v_out_417232", "417232069", "story_v_out_417232.awb")

						arg_283_1:RecordAudio("417232069", var_286_25)
						arg_283_1:RecordAudio("417232069", var_286_25)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_417232", "417232069", "story_v_out_417232.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_417232", "417232069", "story_v_out_417232.awb")
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
	Play417232070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417232070
		arg_287_1.duration_ = 9.37

		local var_287_0 = {
			zh = 7.266,
			ja = 9.366
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play417232071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10111"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10111 == nil then
				arg_287_1.var_.actorSpriteComps10111 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10111 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10111 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10111 = nil
			end

			local var_290_8 = arg_287_1.actors_["1060"]
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1060 == nil then
				arg_287_1.var_.actorSpriteComps1060 = var_290_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_10 = 0.2

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_10 and not isNil(var_290_8) then
				local var_290_11 = (arg_287_1.time_ - var_290_9) / var_290_10

				if arg_287_1.var_.actorSpriteComps1060 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_287_1.time_ >= var_290_9 + var_290_10 and arg_287_1.time_ < var_290_9 + var_290_10 + arg_290_0 and not isNil(var_290_8) and arg_287_1.var_.actorSpriteComps1060 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_290_7 then
						if arg_287_1.isInRecall_ then
							iter_290_7.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1060 = nil
			end

			local var_290_16 = 0
			local var_290_17 = 0.925

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_18 = arg_287_1:FormatText(StoryNameCfg[1125].name)

				arg_287_1.leftNameTxt_.text = var_290_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_19 = arg_287_1:GetWordFromCfg(417232070)
				local var_290_20 = arg_287_1:FormatText(var_290_19.content)

				arg_287_1.text_.text = var_290_20

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_21 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232070", "story_v_out_417232.awb") ~= 0 then
					local var_290_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232070", "story_v_out_417232.awb") / 1000

					if var_290_24 + var_290_16 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_24 + var_290_16
					end

					if var_290_19.prefab_name ~= "" and arg_287_1.actors_[var_290_19.prefab_name] ~= nil then
						local var_290_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_19.prefab_name].transform, "story_v_out_417232", "417232070", "story_v_out_417232.awb")

						arg_287_1:RecordAudio("417232070", var_290_25)
						arg_287_1:RecordAudio("417232070", var_290_25)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_417232", "417232070", "story_v_out_417232.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_417232", "417232070", "story_v_out_417232.awb")
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
	Play417232071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417232071
		arg_291_1.duration_ = 6.33

		local var_291_0 = {
			zh = 5.6,
			ja = 6.333
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
				arg_291_0:Play417232072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1060"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1060 == nil then
				arg_291_1.var_.actorSpriteComps1060 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1060 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1060 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1060 = nil
			end

			local var_294_8 = arg_291_1.actors_["10111"]
			local var_294_9 = 0

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10111 == nil then
				arg_291_1.var_.actorSpriteComps10111 = var_294_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_10 = 0.2

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_10 and not isNil(var_294_8) then
				local var_294_11 = (arg_291_1.time_ - var_294_9) / var_294_10

				if arg_291_1.var_.actorSpriteComps10111 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10111:ToTable()) do
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

			if arg_291_1.time_ >= var_294_9 + var_294_10 and arg_291_1.time_ < var_294_9 + var_294_10 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.actorSpriteComps10111 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_294_7 then
						if arg_291_1.isInRecall_ then
							iter_294_7.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps10111 = nil
			end

			local var_294_16 = 0
			local var_294_17 = 0.675

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_18 = arg_291_1:FormatText(StoryNameCfg[584].name)

				arg_291_1.leftNameTxt_.text = var_294_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_19 = arg_291_1:GetWordFromCfg(417232071)
				local var_294_20 = arg_291_1:FormatText(var_294_19.content)

				arg_291_1.text_.text = var_294_20

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_21 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232071", "story_v_out_417232.awb") ~= 0 then
					local var_294_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232071", "story_v_out_417232.awb") / 1000

					if var_294_24 + var_294_16 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_24 + var_294_16
					end

					if var_294_19.prefab_name ~= "" and arg_291_1.actors_[var_294_19.prefab_name] ~= nil then
						local var_294_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_19.prefab_name].transform, "story_v_out_417232", "417232071", "story_v_out_417232.awb")

						arg_291_1:RecordAudio("417232071", var_294_25)
						arg_291_1:RecordAudio("417232071", var_294_25)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_417232", "417232071", "story_v_out_417232.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_417232", "417232071", "story_v_out_417232.awb")
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
	Play417232072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417232072
		arg_295_1.duration_ = 10.97

		local var_295_0 = {
			zh = 6.033,
			ja = 10.966
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
				arg_295_0:Play417232073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10111"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10111 == nil then
				arg_295_1.var_.actorSpriteComps10111 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10111 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								local var_298_4 = Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, var_298_3)
								local var_298_5 = Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, var_298_3)
								local var_298_6 = Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, var_298_3)

								iter_298_1.color = Color.New(var_298_4, var_298_5, var_298_6)
							else
								local var_298_7 = Mathf.Lerp(iter_298_1.color.r, 1, var_298_3)

								iter_298_1.color = Color.New(var_298_7, var_298_7, var_298_7)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10111 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10111 = nil
			end

			local var_298_8 = arg_295_1.actors_["1060"]
			local var_298_9 = 0

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps1060 == nil then
				arg_295_1.var_.actorSpriteComps1060 = var_298_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_10 = 0.2

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_10 and not isNil(var_298_8) then
				local var_298_11 = (arg_295_1.time_ - var_298_9) / var_298_10

				if arg_295_1.var_.actorSpriteComps1060 then
					for iter_298_4, iter_298_5 in pairs(arg_295_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_298_5 then
							if arg_295_1.isInRecall_ then
								local var_298_12 = Mathf.Lerp(iter_298_5.color.r, arg_295_1.hightColor2.r, var_298_11)
								local var_298_13 = Mathf.Lerp(iter_298_5.color.g, arg_295_1.hightColor2.g, var_298_11)
								local var_298_14 = Mathf.Lerp(iter_298_5.color.b, arg_295_1.hightColor2.b, var_298_11)

								iter_298_5.color = Color.New(var_298_12, var_298_13, var_298_14)
							else
								local var_298_15 = Mathf.Lerp(iter_298_5.color.r, 0.5, var_298_11)

								iter_298_5.color = Color.New(var_298_15, var_298_15, var_298_15)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= var_298_9 + var_298_10 and arg_295_1.time_ < var_298_9 + var_298_10 + arg_298_0 and not isNil(var_298_8) and arg_295_1.var_.actorSpriteComps1060 then
				for iter_298_6, iter_298_7 in pairs(arg_295_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_298_7 then
						if arg_295_1.isInRecall_ then
							iter_298_7.color = arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_298_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps1060 = nil
			end

			local var_298_16 = 0
			local var_298_17 = 0.75

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_18 = arg_295_1:FormatText(StoryNameCfg[1125].name)

				arg_295_1.leftNameTxt_.text = var_298_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_19 = arg_295_1:GetWordFromCfg(417232072)
				local var_298_20 = arg_295_1:FormatText(var_298_19.content)

				arg_295_1.text_.text = var_298_20

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_21 = 30
				local var_298_22 = utf8.len(var_298_20)
				local var_298_23 = var_298_21 <= 0 and var_298_17 or var_298_17 * (var_298_22 / var_298_21)

				if var_298_23 > 0 and var_298_17 < var_298_23 then
					arg_295_1.talkMaxDuration = var_298_23

					if var_298_23 + var_298_16 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_23 + var_298_16
					end
				end

				arg_295_1.text_.text = var_298_20
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232072", "story_v_out_417232.awb") ~= 0 then
					local var_298_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232072", "story_v_out_417232.awb") / 1000

					if var_298_24 + var_298_16 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_24 + var_298_16
					end

					if var_298_19.prefab_name ~= "" and arg_295_1.actors_[var_298_19.prefab_name] ~= nil then
						local var_298_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_19.prefab_name].transform, "story_v_out_417232", "417232072", "story_v_out_417232.awb")

						arg_295_1:RecordAudio("417232072", var_298_25)
						arg_295_1:RecordAudio("417232072", var_298_25)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417232", "417232072", "story_v_out_417232.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417232", "417232072", "story_v_out_417232.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_26 = math.max(var_298_17, arg_295_1.talkMaxDuration)

			if var_298_16 <= arg_295_1.time_ and arg_295_1.time_ < var_298_16 + var_298_26 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_16) / var_298_26

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_16 + var_298_26 and arg_295_1.time_ < var_298_16 + var_298_26 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play417232073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 417232073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play417232074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["10111"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos10111 = var_302_0.localPosition
				var_302_0.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10111", 7)

				local var_302_2 = var_302_0.childCount

				for iter_302_0 = 0, var_302_2 - 1 do
					local var_302_3 = var_302_0:GetChild(iter_302_0)

					if var_302_3.name == "" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_4 then
				local var_302_5 = (arg_299_1.time_ - var_302_1) / var_302_4
				local var_302_6 = Vector3.New(0, -2000, 0)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10111, var_302_6, var_302_5)
			end

			if arg_299_1.time_ >= var_302_1 + var_302_4 and arg_299_1.time_ < var_302_1 + var_302_4 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_302_7 = arg_299_1.actors_["1060"].transform
			local var_302_8 = 0

			if var_302_8 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.var_.moveOldPos1060 = var_302_7.localPosition
				var_302_7.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1060", 7)

				local var_302_9 = var_302_7.childCount

				for iter_302_1 = 0, var_302_9 - 1 do
					local var_302_10 = var_302_7:GetChild(iter_302_1)

					if var_302_10.name == "" or not string.find(var_302_10.name, "split") then
						var_302_10.gameObject:SetActive(true)
					else
						var_302_10.gameObject:SetActive(false)
					end
				end
			end

			local var_302_11 = 0.001

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_11 then
				local var_302_12 = (arg_299_1.time_ - var_302_8) / var_302_11
				local var_302_13 = Vector3.New(0, -2000, -40)

				var_302_7.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1060, var_302_13, var_302_12)
			end

			if arg_299_1.time_ >= var_302_8 + var_302_11 and arg_299_1.time_ < var_302_8 + var_302_11 + arg_302_0 then
				var_302_7.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_302_14 = 0
			local var_302_15 = 0.775

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_16 = arg_299_1:GetWordFromCfg(417232073)
				local var_302_17 = arg_299_1:FormatText(var_302_16.content)

				arg_299_1.text_.text = var_302_17

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_18 = 31
				local var_302_19 = utf8.len(var_302_17)
				local var_302_20 = var_302_18 <= 0 and var_302_15 or var_302_15 * (var_302_19 / var_302_18)

				if var_302_20 > 0 and var_302_15 < var_302_20 then
					arg_299_1.talkMaxDuration = var_302_20

					if var_302_20 + var_302_14 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_20 + var_302_14
					end
				end

				arg_299_1.text_.text = var_302_17
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_21 = math.max(var_302_15, arg_299_1.talkMaxDuration)

			if var_302_14 <= arg_299_1.time_ and arg_299_1.time_ < var_302_14 + var_302_21 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_14) / var_302_21

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_14 + var_302_21 and arg_299_1.time_ < var_302_14 + var_302_21 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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

		arg_299_1:InitPlayNodeList()
	end,
	Play417232074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 417232074
		arg_303_1.duration_ = 7.27

		local var_303_0 = {
			zh = 7.266,
			ja = 7.166
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
				arg_303_0:Play417232075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10128"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10128 == nil then
				arg_303_1.var_.actorSpriteComps10128 = var_306_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_2 = 0.2

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.actorSpriteComps10128 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								local var_306_4 = Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, var_306_3)
								local var_306_5 = Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, var_306_3)
								local var_306_6 = Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, var_306_3)

								iter_306_1.color = Color.New(var_306_4, var_306_5, var_306_6)
							else
								local var_306_7 = Mathf.Lerp(iter_306_1.color.r, 1, var_306_3)

								iter_306_1.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.actorSpriteComps10128 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_306_3 then
						if arg_303_1.isInRecall_ then
							iter_306_3.color = arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_306_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_303_1.var_.actorSpriteComps10128 = nil
			end

			local var_306_8 = arg_303_1.actors_["10128"].transform
			local var_306_9 = 0

			if var_306_9 < arg_303_1.time_ and arg_303_1.time_ <= var_306_9 + arg_306_0 then
				arg_303_1.var_.moveOldPos10128 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10128", 3)

				local var_306_10 = var_306_8.childCount

				for iter_306_4 = 0, var_306_10 - 1 do
					local var_306_11 = var_306_8:GetChild(iter_306_4)

					if var_306_11.name == "" or not string.find(var_306_11.name, "split") then
						var_306_11.gameObject:SetActive(true)
					else
						var_306_11.gameObject:SetActive(false)
					end
				end
			end

			local var_306_12 = 0.001

			if var_306_9 <= arg_303_1.time_ and arg_303_1.time_ < var_306_9 + var_306_12 then
				local var_306_13 = (arg_303_1.time_ - var_306_9) / var_306_12
				local var_306_14 = Vector3.New(0, -347, -300)

				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10128, var_306_14, var_306_13)
			end

			if arg_303_1.time_ >= var_306_9 + var_306_12 and arg_303_1.time_ < var_306_9 + var_306_12 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_306_15 = 0
			local var_306_16 = 0.9

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[595].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(417232074)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 36
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232074", "story_v_out_417232.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232074", "story_v_out_417232.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_out_417232", "417232074", "story_v_out_417232.awb")

						arg_303_1:RecordAudio("417232074", var_306_24)
						arg_303_1:RecordAudio("417232074", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_417232", "417232074", "story_v_out_417232.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_417232", "417232074", "story_v_out_417232.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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
	Play417232075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 417232075
		arg_307_1.duration_ = 8.1

		local var_307_0 = {
			zh = 5.166,
			ja = 8.1
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
				arg_307_0:Play417232076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1060"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1060 == nil then
				arg_307_1.var_.actorSpriteComps1060 = var_310_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_2 = 0.2

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.actorSpriteComps1060 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.actorSpriteComps1060 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_310_3 then
						if arg_307_1.isInRecall_ then
							iter_310_3.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1060 = nil
			end

			local var_310_8 = arg_307_1.actors_["10128"]
			local var_310_9 = 0

			if var_310_9 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10128 == nil then
				arg_307_1.var_.actorSpriteComps10128 = var_310_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_10 = 0.2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 and not isNil(var_310_8) then
				local var_310_11 = (arg_307_1.time_ - var_310_9) / var_310_10

				if arg_307_1.var_.actorSpriteComps10128 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 and not isNil(var_310_8) and arg_307_1.var_.actorSpriteComps10128 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_310_7 then
						if arg_307_1.isInRecall_ then
							iter_310_7.color = arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_310_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps10128 = nil
			end

			local var_310_16 = arg_307_1.actors_["10128"].transform
			local var_310_17 = 0

			if var_310_17 < arg_307_1.time_ and arg_307_1.time_ <= var_310_17 + arg_310_0 then
				arg_307_1.var_.moveOldPos10128 = var_310_16.localPosition
				var_310_16.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10128", 2)

				local var_310_18 = var_310_16.childCount

				for iter_310_8 = 0, var_310_18 - 1 do
					local var_310_19 = var_310_16:GetChild(iter_310_8)

					if var_310_19.name == "" or not string.find(var_310_19.name, "split") then
						var_310_19.gameObject:SetActive(true)
					else
						var_310_19.gameObject:SetActive(false)
					end
				end
			end

			local var_310_20 = 0.001

			if var_310_17 <= arg_307_1.time_ and arg_307_1.time_ < var_310_17 + var_310_20 then
				local var_310_21 = (arg_307_1.time_ - var_310_17) / var_310_20
				local var_310_22 = Vector3.New(-390, -347, -300)

				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10128, var_310_22, var_310_21)
			end

			if arg_307_1.time_ >= var_310_17 + var_310_20 and arg_307_1.time_ < var_310_17 + var_310_20 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_310_23 = arg_307_1.actors_["1060"].transform
			local var_310_24 = 0

			if var_310_24 < arg_307_1.time_ and arg_307_1.time_ <= var_310_24 + arg_310_0 then
				arg_307_1.var_.moveOldPos1060 = var_310_23.localPosition
				var_310_23.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1060", 4)

				local var_310_25 = var_310_23.childCount

				for iter_310_9 = 0, var_310_25 - 1 do
					local var_310_26 = var_310_23:GetChild(iter_310_9)

					if var_310_26.name == "" or not string.find(var_310_26.name, "split") then
						var_310_26.gameObject:SetActive(true)
					else
						var_310_26.gameObject:SetActive(false)
					end
				end
			end

			local var_310_27 = 0.001

			if var_310_24 <= arg_307_1.time_ and arg_307_1.time_ < var_310_24 + var_310_27 then
				local var_310_28 = (arg_307_1.time_ - var_310_24) / var_310_27
				local var_310_29 = Vector3.New(420.9, -430.8, 6.9)

				var_310_23.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1060, var_310_29, var_310_28)
			end

			if arg_307_1.time_ >= var_310_24 + var_310_27 and arg_307_1.time_ < var_310_24 + var_310_27 + arg_310_0 then
				var_310_23.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_310_30 = 0
			local var_310_31 = 0.55

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_32 = arg_307_1:FormatText(StoryNameCfg[584].name)

				arg_307_1.leftNameTxt_.text = var_310_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_33 = arg_307_1:GetWordFromCfg(417232075)
				local var_310_34 = arg_307_1:FormatText(var_310_33.content)

				arg_307_1.text_.text = var_310_34

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_35 = 22
				local var_310_36 = utf8.len(var_310_34)
				local var_310_37 = var_310_35 <= 0 and var_310_31 or var_310_31 * (var_310_36 / var_310_35)

				if var_310_37 > 0 and var_310_31 < var_310_37 then
					arg_307_1.talkMaxDuration = var_310_37

					if var_310_37 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_37 + var_310_30
					end
				end

				arg_307_1.text_.text = var_310_34
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232075", "story_v_out_417232.awb") ~= 0 then
					local var_310_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232075", "story_v_out_417232.awb") / 1000

					if var_310_38 + var_310_30 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_38 + var_310_30
					end

					if var_310_33.prefab_name ~= "" and arg_307_1.actors_[var_310_33.prefab_name] ~= nil then
						local var_310_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_33.prefab_name].transform, "story_v_out_417232", "417232075", "story_v_out_417232.awb")

						arg_307_1:RecordAudio("417232075", var_310_39)
						arg_307_1:RecordAudio("417232075", var_310_39)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_417232", "417232075", "story_v_out_417232.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_417232", "417232075", "story_v_out_417232.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_40 = math.max(var_310_31, arg_307_1.talkMaxDuration)

			if var_310_30 <= arg_307_1.time_ and arg_307_1.time_ < var_310_30 + var_310_40 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_30) / var_310_40

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_30 + var_310_40 and arg_307_1.time_ < var_310_30 + var_310_40 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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

		arg_307_1:InitPlayNodeList()
	end,
	Play417232076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 417232076
		arg_311_1.duration_ = 5.63

		local var_311_0 = {
			zh = 3.733,
			ja = 5.633
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
				arg_311_0:Play417232077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10128"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10128 == nil then
				arg_311_1.var_.actorSpriteComps10128 = var_314_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_2 = 0.2

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.actorSpriteComps10128 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								local var_314_4 = Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, var_314_3)
								local var_314_5 = Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, var_314_3)
								local var_314_6 = Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, var_314_3)

								iter_314_1.color = Color.New(var_314_4, var_314_5, var_314_6)
							else
								local var_314_7 = Mathf.Lerp(iter_314_1.color.r, 1, var_314_3)

								iter_314_1.color = Color.New(var_314_7, var_314_7, var_314_7)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.actorSpriteComps10128 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_314_3 then
						if arg_311_1.isInRecall_ then
							iter_314_3.color = arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_314_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps10128 = nil
			end

			local var_314_8 = arg_311_1.actors_["1060"]
			local var_314_9 = 0

			if var_314_9 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1060 == nil then
				arg_311_1.var_.actorSpriteComps1060 = var_314_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_10 = 0.2

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 and not isNil(var_314_8) then
				local var_314_11 = (arg_311_1.time_ - var_314_9) / var_314_10

				if arg_311_1.var_.actorSpriteComps1060 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								local var_314_12 = Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, var_314_11)
								local var_314_13 = Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, var_314_11)
								local var_314_14 = Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, var_314_11)

								iter_314_5.color = Color.New(var_314_12, var_314_13, var_314_14)
							else
								local var_314_15 = Mathf.Lerp(iter_314_5.color.r, 0.5, var_314_11)

								iter_314_5.color = Color.New(var_314_15, var_314_15, var_314_15)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 and not isNil(var_314_8) and arg_311_1.var_.actorSpriteComps1060 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_314_7 then
						if arg_311_1.isInRecall_ then
							iter_314_7.color = arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_314_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_311_1.var_.actorSpriteComps1060 = nil
			end

			local var_314_16 = 0
			local var_314_17 = 0.5

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_18 = arg_311_1:FormatText(StoryNameCfg[595].name)

				arg_311_1.leftNameTxt_.text = var_314_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_19 = arg_311_1:GetWordFromCfg(417232076)
				local var_314_20 = arg_311_1:FormatText(var_314_19.content)

				arg_311_1.text_.text = var_314_20

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_21 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232076", "story_v_out_417232.awb") ~= 0 then
					local var_314_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232076", "story_v_out_417232.awb") / 1000

					if var_314_24 + var_314_16 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_24 + var_314_16
					end

					if var_314_19.prefab_name ~= "" and arg_311_1.actors_[var_314_19.prefab_name] ~= nil then
						local var_314_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_19.prefab_name].transform, "story_v_out_417232", "417232076", "story_v_out_417232.awb")

						arg_311_1:RecordAudio("417232076", var_314_25)
						arg_311_1:RecordAudio("417232076", var_314_25)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_417232", "417232076", "story_v_out_417232.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_417232", "417232076", "story_v_out_417232.awb")
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
	Play417232077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 417232077
		arg_315_1.duration_ = 2.63

		local var_315_0 = {
			zh = 1.7,
			ja = 2.633
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
				arg_315_0:Play417232078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1060"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1060 == nil then
				arg_315_1.var_.actorSpriteComps1060 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1060 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1060 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_318_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1060 = nil
			end

			local var_318_8 = arg_315_1.actors_["10128"]
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10128 == nil then
				arg_315_1.var_.actorSpriteComps10128 = var_318_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_10 = 0.2

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_10 and not isNil(var_318_8) then
				local var_318_11 = (arg_315_1.time_ - var_318_9) / var_318_10

				if arg_315_1.var_.actorSpriteComps10128 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_315_1.time_ >= var_318_9 + var_318_10 and arg_315_1.time_ < var_318_9 + var_318_10 + arg_318_0 and not isNil(var_318_8) and arg_315_1.var_.actorSpriteComps10128 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_318_7 then
						if arg_315_1.isInRecall_ then
							iter_318_7.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps10128 = nil
			end

			local var_318_16 = 0
			local var_318_17 = 0.2

			if var_318_16 < arg_315_1.time_ and arg_315_1.time_ <= var_318_16 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_18 = arg_315_1:FormatText(StoryNameCfg[584].name)

				arg_315_1.leftNameTxt_.text = var_318_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_19 = arg_315_1:GetWordFromCfg(417232077)
				local var_318_20 = arg_315_1:FormatText(var_318_19.content)

				arg_315_1.text_.text = var_318_20

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_21 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232077", "story_v_out_417232.awb") ~= 0 then
					local var_318_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232077", "story_v_out_417232.awb") / 1000

					if var_318_24 + var_318_16 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_24 + var_318_16
					end

					if var_318_19.prefab_name ~= "" and arg_315_1.actors_[var_318_19.prefab_name] ~= nil then
						local var_318_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_19.prefab_name].transform, "story_v_out_417232", "417232077", "story_v_out_417232.awb")

						arg_315_1:RecordAudio("417232077", var_318_25)
						arg_315_1:RecordAudio("417232077", var_318_25)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_417232", "417232077", "story_v_out_417232.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_417232", "417232077", "story_v_out_417232.awb")
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
	Play417232078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 417232078
		arg_319_1.duration_ = 5.83

		local var_319_0 = {
			zh = 5.2,
			ja = 5.833
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
				arg_319_0:Play417232079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["10128"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10128 == nil then
				arg_319_1.var_.actorSpriteComps10128 = var_322_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_2 = 0.2

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.actorSpriteComps10128 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								local var_322_4 = Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, var_322_3)
								local var_322_5 = Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, var_322_3)
								local var_322_6 = Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, var_322_3)

								iter_322_1.color = Color.New(var_322_4, var_322_5, var_322_6)
							else
								local var_322_7 = Mathf.Lerp(iter_322_1.color.r, 1, var_322_3)

								iter_322_1.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.actorSpriteComps10128 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_322_3 then
						if arg_319_1.isInRecall_ then
							iter_322_3.color = arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_322_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps10128 = nil
			end

			local var_322_8 = arg_319_1.actors_["1060"]
			local var_322_9 = 0

			if var_322_9 < arg_319_1.time_ and arg_319_1.time_ <= var_322_9 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps1060 == nil then
				arg_319_1.var_.actorSpriteComps1060 = var_322_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_10 = 0.2

			if var_322_9 <= arg_319_1.time_ and arg_319_1.time_ < var_322_9 + var_322_10 and not isNil(var_322_8) then
				local var_322_11 = (arg_319_1.time_ - var_322_9) / var_322_10

				if arg_319_1.var_.actorSpriteComps1060 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								local var_322_12 = Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor2.r, var_322_11)
								local var_322_13 = Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor2.g, var_322_11)
								local var_322_14 = Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor2.b, var_322_11)

								iter_322_5.color = Color.New(var_322_12, var_322_13, var_322_14)
							else
								local var_322_15 = Mathf.Lerp(iter_322_5.color.r, 0.5, var_322_11)

								iter_322_5.color = Color.New(var_322_15, var_322_15, var_322_15)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= var_322_9 + var_322_10 and arg_319_1.time_ < var_322_9 + var_322_10 + arg_322_0 and not isNil(var_322_8) and arg_319_1.var_.actorSpriteComps1060 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_322_7 then
						if arg_319_1.isInRecall_ then
							iter_322_7.color = arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_322_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_319_1.var_.actorSpriteComps1060 = nil
			end

			local var_322_16 = 0
			local var_322_17 = 0.475

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_18 = arg_319_1:FormatText(StoryNameCfg[595].name)

				arg_319_1.leftNameTxt_.text = var_322_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_19 = arg_319_1:GetWordFromCfg(417232078)
				local var_322_20 = arg_319_1:FormatText(var_322_19.content)

				arg_319_1.text_.text = var_322_20

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_21 = 19
				local var_322_22 = utf8.len(var_322_20)
				local var_322_23 = var_322_21 <= 0 and var_322_17 or var_322_17 * (var_322_22 / var_322_21)

				if var_322_23 > 0 and var_322_17 < var_322_23 then
					arg_319_1.talkMaxDuration = var_322_23

					if var_322_23 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_23 + var_322_16
					end
				end

				arg_319_1.text_.text = var_322_20
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232078", "story_v_out_417232.awb") ~= 0 then
					local var_322_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232078", "story_v_out_417232.awb") / 1000

					if var_322_24 + var_322_16 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_24 + var_322_16
					end

					if var_322_19.prefab_name ~= "" and arg_319_1.actors_[var_322_19.prefab_name] ~= nil then
						local var_322_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_19.prefab_name].transform, "story_v_out_417232", "417232078", "story_v_out_417232.awb")

						arg_319_1:RecordAudio("417232078", var_322_25)
						arg_319_1:RecordAudio("417232078", var_322_25)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_417232", "417232078", "story_v_out_417232.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_417232", "417232078", "story_v_out_417232.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_26 = math.max(var_322_17, arg_319_1.talkMaxDuration)

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_26 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_16) / var_322_26

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_16 + var_322_26 and arg_319_1.time_ < var_322_16 + var_322_26 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play417232079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 417232079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play417232080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["10128"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10128 == nil then
				arg_323_1.var_.actorSpriteComps10128 = var_326_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_2 = 0.2

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.actorSpriteComps10128 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								local var_326_4 = Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, var_326_3)
								local var_326_5 = Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, var_326_3)
								local var_326_6 = Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, var_326_3)

								iter_326_1.color = Color.New(var_326_4, var_326_5, var_326_6)
							else
								local var_326_7 = Mathf.Lerp(iter_326_1.color.r, 0.5, var_326_3)

								iter_326_1.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.actorSpriteComps10128 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_326_3 then
						if arg_323_1.isInRecall_ then
							iter_326_3.color = arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_326_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_323_1.var_.actorSpriteComps10128 = nil
			end

			local var_326_8 = arg_323_1.actors_["10128"].transform
			local var_326_9 = 0

			if var_326_9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.var_.moveOldPos10128 = var_326_8.localPosition
				var_326_8.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10128", 7)

				local var_326_10 = var_326_8.childCount

				for iter_326_4 = 0, var_326_10 - 1 do
					local var_326_11 = var_326_8:GetChild(iter_326_4)

					if var_326_11.name == "" or not string.find(var_326_11.name, "split") then
						var_326_11.gameObject:SetActive(true)
					else
						var_326_11.gameObject:SetActive(false)
					end
				end
			end

			local var_326_12 = 0.001

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_12 then
				local var_326_13 = (arg_323_1.time_ - var_326_9) / var_326_12
				local var_326_14 = Vector3.New(0, -2000, -300)

				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10128, var_326_14, var_326_13)
			end

			if arg_323_1.time_ >= var_326_9 + var_326_12 and arg_323_1.time_ < var_326_9 + var_326_12 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_326_15 = arg_323_1.actors_["1060"].transform
			local var_326_16 = 0

			if var_326_16 < arg_323_1.time_ and arg_323_1.time_ <= var_326_16 + arg_326_0 then
				arg_323_1.var_.moveOldPos1060 = var_326_15.localPosition
				var_326_15.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1060", 7)

				local var_326_17 = var_326_15.childCount

				for iter_326_5 = 0, var_326_17 - 1 do
					local var_326_18 = var_326_15:GetChild(iter_326_5)

					if var_326_18.name == "" or not string.find(var_326_18.name, "split") then
						var_326_18.gameObject:SetActive(true)
					else
						var_326_18.gameObject:SetActive(false)
					end
				end
			end

			local var_326_19 = 0.001

			if var_326_16 <= arg_323_1.time_ and arg_323_1.time_ < var_326_16 + var_326_19 then
				local var_326_20 = (arg_323_1.time_ - var_326_16) / var_326_19
				local var_326_21 = Vector3.New(0, -2000, -40)

				var_326_15.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1060, var_326_21, var_326_20)
			end

			if arg_323_1.time_ >= var_326_16 + var_326_19 and arg_323_1.time_ < var_326_16 + var_326_19 + arg_326_0 then
				var_326_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_326_22 = 1
			local var_326_23 = 1

			if var_326_22 < arg_323_1.time_ and arg_323_1.time_ <= var_326_22 + arg_326_0 then
				local var_326_24 = "play"
				local var_326_25 = "effect"

				arg_323_1:AudioAction(var_326_24, var_326_25, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_326_26 = 0
			local var_326_27 = 1.175

			if var_326_26 < arg_323_1.time_ and arg_323_1.time_ <= var_326_26 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_28 = arg_323_1:GetWordFromCfg(417232079)
				local var_326_29 = arg_323_1:FormatText(var_326_28.content)

				arg_323_1.text_.text = var_326_29

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_30 = 47
				local var_326_31 = utf8.len(var_326_29)
				local var_326_32 = var_326_30 <= 0 and var_326_27 or var_326_27 * (var_326_31 / var_326_30)

				if var_326_32 > 0 and var_326_27 < var_326_32 then
					arg_323_1.talkMaxDuration = var_326_32

					if var_326_32 + var_326_26 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_32 + var_326_26
					end
				end

				arg_323_1.text_.text = var_326_29
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_33 = math.max(var_326_27, arg_323_1.talkMaxDuration)

			if var_326_26 <= arg_323_1.time_ and arg_323_1.time_ < var_326_26 + var_326_33 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_26) / var_326_33

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_26 + var_326_33 and arg_323_1.time_ < var_326_26 + var_326_33 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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

		arg_323_1:InitPlayNodeList()
	end,
	Play417232080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 417232080
		arg_327_1.duration_ = 1.97

		local var_327_0 = {
			zh = 1.433,
			ja = 1.966
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
				arg_327_0:Play417232081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10128"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10128 == nil then
				arg_327_1.var_.actorSpriteComps10128 = var_330_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_2 = 0.2

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.actorSpriteComps10128 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								local var_330_4 = Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, var_330_3)
								local var_330_5 = Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, var_330_3)
								local var_330_6 = Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, var_330_3)

								iter_330_1.color = Color.New(var_330_4, var_330_5, var_330_6)
							else
								local var_330_7 = Mathf.Lerp(iter_330_1.color.r, 1, var_330_3)

								iter_330_1.color = Color.New(var_330_7, var_330_7, var_330_7)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.actorSpriteComps10128 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_330_3 then
						if arg_327_1.isInRecall_ then
							iter_330_3.color = arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_330_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_327_1.var_.actorSpriteComps10128 = nil
			end

			local var_330_8 = arg_327_1.actors_["10128"].transform
			local var_330_9 = 0

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.var_.moveOldPos10128 = var_330_8.localPosition
				var_330_8.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10128", 3)

				local var_330_10 = var_330_8.childCount

				for iter_330_4 = 0, var_330_10 - 1 do
					local var_330_11 = var_330_8:GetChild(iter_330_4)

					if var_330_11.name == "" or not string.find(var_330_11.name, "split") then
						var_330_11.gameObject:SetActive(true)
					else
						var_330_11.gameObject:SetActive(false)
					end
				end
			end

			local var_330_12 = 0.001

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_12 then
				local var_330_13 = (arg_327_1.time_ - var_330_9) / var_330_12
				local var_330_14 = Vector3.New(0, -347, -300)

				var_330_8.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10128, var_330_14, var_330_13)
			end

			if arg_327_1.time_ >= var_330_9 + var_330_12 and arg_327_1.time_ < var_330_9 + var_330_12 + arg_330_0 then
				var_330_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_330_15 = 0
			local var_330_16 = 0.15

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_17 = arg_327_1:FormatText(StoryNameCfg[595].name)

				arg_327_1.leftNameTxt_.text = var_330_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_18 = arg_327_1:GetWordFromCfg(417232080)
				local var_330_19 = arg_327_1:FormatText(var_330_18.content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_20 = 6
				local var_330_21 = utf8.len(var_330_19)
				local var_330_22 = var_330_20 <= 0 and var_330_16 or var_330_16 * (var_330_21 / var_330_20)

				if var_330_22 > 0 and var_330_16 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22

					if var_330_22 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232080", "story_v_out_417232.awb") ~= 0 then
					local var_330_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232080", "story_v_out_417232.awb") / 1000

					if var_330_23 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_23 + var_330_15
					end

					if var_330_18.prefab_name ~= "" and arg_327_1.actors_[var_330_18.prefab_name] ~= nil then
						local var_330_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_18.prefab_name].transform, "story_v_out_417232", "417232080", "story_v_out_417232.awb")

						arg_327_1:RecordAudio("417232080", var_330_24)
						arg_327_1:RecordAudio("417232080", var_330_24)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_417232", "417232080", "story_v_out_417232.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_417232", "417232080", "story_v_out_417232.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_25 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_25 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_25

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_25 and arg_327_1.time_ < var_330_15 + var_330_25 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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
	Play417232081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 417232081
		arg_331_1.duration_ = 5.5

		local var_331_0 = {
			zh = 3.6,
			ja = 5.5
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
				arg_331_0:Play417232082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1060"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1060 == nil then
				arg_331_1.var_.actorSpriteComps1060 = var_334_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_2 = 0.2

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.actorSpriteComps1060 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								local var_334_4 = Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, var_334_3)
								local var_334_5 = Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, var_334_3)
								local var_334_6 = Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, var_334_3)

								iter_334_1.color = Color.New(var_334_4, var_334_5, var_334_6)
							else
								local var_334_7 = Mathf.Lerp(iter_334_1.color.r, 1, var_334_3)

								iter_334_1.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.actorSpriteComps1060 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_334_3 then
						if arg_331_1.isInRecall_ then
							iter_334_3.color = arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_334_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps1060 = nil
			end

			local var_334_8 = arg_331_1.actors_["10128"]
			local var_334_9 = 0

			if var_334_9 < arg_331_1.time_ and arg_331_1.time_ <= var_334_9 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10128 == nil then
				arg_331_1.var_.actorSpriteComps10128 = var_334_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_10 = 0.2

			if var_334_9 <= arg_331_1.time_ and arg_331_1.time_ < var_334_9 + var_334_10 and not isNil(var_334_8) then
				local var_334_11 = (arg_331_1.time_ - var_334_9) / var_334_10

				if arg_331_1.var_.actorSpriteComps10128 then
					for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_334_5 then
							if arg_331_1.isInRecall_ then
								local var_334_12 = Mathf.Lerp(iter_334_5.color.r, arg_331_1.hightColor2.r, var_334_11)
								local var_334_13 = Mathf.Lerp(iter_334_5.color.g, arg_331_1.hightColor2.g, var_334_11)
								local var_334_14 = Mathf.Lerp(iter_334_5.color.b, arg_331_1.hightColor2.b, var_334_11)

								iter_334_5.color = Color.New(var_334_12, var_334_13, var_334_14)
							else
								local var_334_15 = Mathf.Lerp(iter_334_5.color.r, 0.5, var_334_11)

								iter_334_5.color = Color.New(var_334_15, var_334_15, var_334_15)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= var_334_9 + var_334_10 and arg_331_1.time_ < var_334_9 + var_334_10 + arg_334_0 and not isNil(var_334_8) and arg_331_1.var_.actorSpriteComps10128 then
				for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_334_7 then
						if arg_331_1.isInRecall_ then
							iter_334_7.color = arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_334_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_331_1.var_.actorSpriteComps10128 = nil
			end

			local var_334_16 = arg_331_1.actors_["10128"].transform
			local var_334_17 = 0

			if var_334_17 < arg_331_1.time_ and arg_331_1.time_ <= var_334_17 + arg_334_0 then
				arg_331_1.var_.moveOldPos10128 = var_334_16.localPosition
				var_334_16.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10128", 2)

				local var_334_18 = var_334_16.childCount

				for iter_334_8 = 0, var_334_18 - 1 do
					local var_334_19 = var_334_16:GetChild(iter_334_8)

					if var_334_19.name == "" or not string.find(var_334_19.name, "split") then
						var_334_19.gameObject:SetActive(true)
					else
						var_334_19.gameObject:SetActive(false)
					end
				end
			end

			local var_334_20 = 0.001

			if var_334_17 <= arg_331_1.time_ and arg_331_1.time_ < var_334_17 + var_334_20 then
				local var_334_21 = (arg_331_1.time_ - var_334_17) / var_334_20
				local var_334_22 = Vector3.New(-390, -347, -300)

				var_334_16.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10128, var_334_22, var_334_21)
			end

			if arg_331_1.time_ >= var_334_17 + var_334_20 and arg_331_1.time_ < var_334_17 + var_334_20 + arg_334_0 then
				var_334_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_334_23 = arg_331_1.actors_["1060"].transform
			local var_334_24 = 0

			if var_334_24 < arg_331_1.time_ and arg_331_1.time_ <= var_334_24 + arg_334_0 then
				arg_331_1.var_.moveOldPos1060 = var_334_23.localPosition
				var_334_23.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1060", 4)

				local var_334_25 = var_334_23.childCount

				for iter_334_9 = 0, var_334_25 - 1 do
					local var_334_26 = var_334_23:GetChild(iter_334_9)

					if var_334_26.name == "" or not string.find(var_334_26.name, "split") then
						var_334_26.gameObject:SetActive(true)
					else
						var_334_26.gameObject:SetActive(false)
					end
				end
			end

			local var_334_27 = 0.001

			if var_334_24 <= arg_331_1.time_ and arg_331_1.time_ < var_334_24 + var_334_27 then
				local var_334_28 = (arg_331_1.time_ - var_334_24) / var_334_27
				local var_334_29 = Vector3.New(420.9, -430.8, 6.9)

				var_334_23.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1060, var_334_29, var_334_28)
			end

			if arg_331_1.time_ >= var_334_24 + var_334_27 and arg_331_1.time_ < var_334_24 + var_334_27 + arg_334_0 then
				var_334_23.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_334_30 = 0
			local var_334_31 = 0.375

			if var_334_30 < arg_331_1.time_ and arg_331_1.time_ <= var_334_30 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_32 = arg_331_1:FormatText(StoryNameCfg[584].name)

				arg_331_1.leftNameTxt_.text = var_334_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_33 = arg_331_1:GetWordFromCfg(417232081)
				local var_334_34 = arg_331_1:FormatText(var_334_33.content)

				arg_331_1.text_.text = var_334_34

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_35 = 15
				local var_334_36 = utf8.len(var_334_34)
				local var_334_37 = var_334_35 <= 0 and var_334_31 or var_334_31 * (var_334_36 / var_334_35)

				if var_334_37 > 0 and var_334_31 < var_334_37 then
					arg_331_1.talkMaxDuration = var_334_37

					if var_334_37 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_37 + var_334_30
					end
				end

				arg_331_1.text_.text = var_334_34
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232081", "story_v_out_417232.awb") ~= 0 then
					local var_334_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232081", "story_v_out_417232.awb") / 1000

					if var_334_38 + var_334_30 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_38 + var_334_30
					end

					if var_334_33.prefab_name ~= "" and arg_331_1.actors_[var_334_33.prefab_name] ~= nil then
						local var_334_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_33.prefab_name].transform, "story_v_out_417232", "417232081", "story_v_out_417232.awb")

						arg_331_1:RecordAudio("417232081", var_334_39)
						arg_331_1:RecordAudio("417232081", var_334_39)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_417232", "417232081", "story_v_out_417232.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_417232", "417232081", "story_v_out_417232.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_40 = math.max(var_334_31, arg_331_1.talkMaxDuration)

			if var_334_30 <= arg_331_1.time_ and arg_331_1.time_ < var_334_30 + var_334_40 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_30) / var_334_40

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_30 + var_334_40 and arg_331_1.time_ < var_334_30 + var_334_40 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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

		arg_331_1:InitPlayNodeList()
	end,
	Play417232082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 417232082
		arg_335_1.duration_ = 2.4

		local var_335_0 = {
			zh = 0.999999999999,
			ja = 2.4
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
				arg_335_0:Play417232083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.075

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[584].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(417232082)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 3
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232082", "story_v_out_417232.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232082", "story_v_out_417232.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_417232", "417232082", "story_v_out_417232.awb")

						arg_335_1:RecordAudio("417232082", var_338_9)
						arg_335_1:RecordAudio("417232082", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_417232", "417232082", "story_v_out_417232.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_417232", "417232082", "story_v_out_417232.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play417232083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 417232083
		arg_339_1.duration_ = 6.6

		local var_339_0 = {
			zh = 4.533,
			ja = 6.6
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
				arg_339_0:Play417232084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.6

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[584].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:GetWordFromCfg(417232083)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232083", "story_v_out_417232.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232083", "story_v_out_417232.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_out_417232", "417232083", "story_v_out_417232.awb")

						arg_339_1:RecordAudio("417232083", var_342_9)
						arg_339_1:RecordAudio("417232083", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_417232", "417232083", "story_v_out_417232.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_417232", "417232083", "story_v_out_417232.awb")
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
	Play417232084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 417232084
		arg_343_1.duration_ = 3.47

		local var_343_0 = {
			zh = 2.866,
			ja = 3.466
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
				arg_343_0:Play417232085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10128"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10128 == nil then
				arg_343_1.var_.actorSpriteComps10128 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 0.2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps10128 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 1, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10128 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10128 = nil
			end

			local var_346_8 = arg_343_1.actors_["1060"]
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps1060 == nil then
				arg_343_1.var_.actorSpriteComps1060 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_10 = 0.2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 and not isNil(var_346_8) then
				local var_346_11 = (arg_343_1.time_ - var_346_9) / var_346_10

				if arg_343_1.var_.actorSpriteComps1060 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								local var_346_12 = Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor2.r, var_346_11)
								local var_346_13 = Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor2.g, var_346_11)
								local var_346_14 = Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor2.b, var_346_11)

								iter_346_5.color = Color.New(var_346_12, var_346_13, var_346_14)
							else
								local var_346_15 = Mathf.Lerp(iter_346_5.color.r, 0.5, var_346_11)

								iter_346_5.color = Color.New(var_346_15, var_346_15, var_346_15)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps1060 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_346_7 then
						if arg_343_1.isInRecall_ then
							iter_346_7.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps1060 = nil
			end

			local var_346_16 = 0
			local var_346_17 = 0.325

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_18 = arg_343_1:FormatText(StoryNameCfg[595].name)

				arg_343_1.leftNameTxt_.text = var_346_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_19 = arg_343_1:GetWordFromCfg(417232084)
				local var_346_20 = arg_343_1:FormatText(var_346_19.content)

				arg_343_1.text_.text = var_346_20

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 13
				local var_346_22 = utf8.len(var_346_20)
				local var_346_23 = var_346_21 <= 0 and var_346_17 or var_346_17 * (var_346_22 / var_346_21)

				if var_346_23 > 0 and var_346_17 < var_346_23 then
					arg_343_1.talkMaxDuration = var_346_23

					if var_346_23 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_16
					end
				end

				arg_343_1.text_.text = var_346_20
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232084", "story_v_out_417232.awb") ~= 0 then
					local var_346_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232084", "story_v_out_417232.awb") / 1000

					if var_346_24 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_24 + var_346_16
					end

					if var_346_19.prefab_name ~= "" and arg_343_1.actors_[var_346_19.prefab_name] ~= nil then
						local var_346_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_19.prefab_name].transform, "story_v_out_417232", "417232084", "story_v_out_417232.awb")

						arg_343_1:RecordAudio("417232084", var_346_25)
						arg_343_1:RecordAudio("417232084", var_346_25)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_417232", "417232084", "story_v_out_417232.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_417232", "417232084", "story_v_out_417232.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_26 = math.max(var_346_17, arg_343_1.talkMaxDuration)

			if var_346_16 <= arg_343_1.time_ and arg_343_1.time_ < var_346_16 + var_346_26 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_16) / var_346_26

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_16 + var_346_26 and arg_343_1.time_ < var_346_16 + var_346_26 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play417232085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 417232085
		arg_347_1.duration_ = 6.97

		local var_347_0 = {
			zh = 5.433,
			ja = 6.966
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
				arg_347_0:Play417232086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1060"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps1060 == nil then
				arg_347_1.var_.actorSpriteComps1060 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps1060 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 1, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps1060 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps1060 = nil
			end

			local var_350_8 = arg_347_1.actors_["10128"]
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10128 == nil then
				arg_347_1.var_.actorSpriteComps10128 = var_350_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_10 = 0.2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 and not isNil(var_350_8) then
				local var_350_11 = (arg_347_1.time_ - var_350_9) / var_350_10

				if arg_347_1.var_.actorSpriteComps10128 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								local var_350_12 = Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, var_350_11)
								local var_350_13 = Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, var_350_11)
								local var_350_14 = Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, var_350_11)

								iter_350_5.color = Color.New(var_350_12, var_350_13, var_350_14)
							else
								local var_350_15 = Mathf.Lerp(iter_350_5.color.r, 0.5, var_350_11)

								iter_350_5.color = Color.New(var_350_15, var_350_15, var_350_15)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10128 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_350_7 then
						if arg_347_1.isInRecall_ then
							iter_350_7.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10128 = nil
			end

			local var_350_16 = 0
			local var_350_17 = 0.65

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_18 = arg_347_1:FormatText(StoryNameCfg[584].name)

				arg_347_1.leftNameTxt_.text = var_350_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_19 = arg_347_1:GetWordFromCfg(417232085)
				local var_350_20 = arg_347_1:FormatText(var_350_19.content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_21 = 26
				local var_350_22 = utf8.len(var_350_20)
				local var_350_23 = var_350_21 <= 0 and var_350_17 or var_350_17 * (var_350_22 / var_350_21)

				if var_350_23 > 0 and var_350_17 < var_350_23 then
					arg_347_1.talkMaxDuration = var_350_23

					if var_350_23 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_16
					end
				end

				arg_347_1.text_.text = var_350_20
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232085", "story_v_out_417232.awb") ~= 0 then
					local var_350_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232085", "story_v_out_417232.awb") / 1000

					if var_350_24 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_16
					end

					if var_350_19.prefab_name ~= "" and arg_347_1.actors_[var_350_19.prefab_name] ~= nil then
						local var_350_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_19.prefab_name].transform, "story_v_out_417232", "417232085", "story_v_out_417232.awb")

						arg_347_1:RecordAudio("417232085", var_350_25)
						arg_347_1:RecordAudio("417232085", var_350_25)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_417232", "417232085", "story_v_out_417232.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_417232", "417232085", "story_v_out_417232.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_26 = math.max(var_350_17, arg_347_1.talkMaxDuration)

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_26 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_16) / var_350_26

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_16 + var_350_26 and arg_347_1.time_ < var_350_16 + var_350_26 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play417232086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 417232086
		arg_351_1.duration_ = 1.97

		local var_351_0 = {
			zh = 1.866,
			ja = 1.966
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
				arg_351_0:Play417232087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10128"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10128 == nil then
				arg_351_1.var_.actorSpriteComps10128 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10128 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 1, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10128 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_354_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10128 = nil
			end

			local var_354_8 = arg_351_1.actors_["1060"]
			local var_354_9 = 0

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps1060 == nil then
				arg_351_1.var_.actorSpriteComps1060 = var_354_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_10 = 0.2

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_10 and not isNil(var_354_8) then
				local var_354_11 = (arg_351_1.time_ - var_354_9) / var_354_10

				if arg_351_1.var_.actorSpriteComps1060 then
					for iter_354_4, iter_354_5 in pairs(arg_351_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_354_5 then
							if arg_351_1.isInRecall_ then
								local var_354_12 = Mathf.Lerp(iter_354_5.color.r, arg_351_1.hightColor2.r, var_354_11)
								local var_354_13 = Mathf.Lerp(iter_354_5.color.g, arg_351_1.hightColor2.g, var_354_11)
								local var_354_14 = Mathf.Lerp(iter_354_5.color.b, arg_351_1.hightColor2.b, var_354_11)

								iter_354_5.color = Color.New(var_354_12, var_354_13, var_354_14)
							else
								local var_354_15 = Mathf.Lerp(iter_354_5.color.r, 0.5, var_354_11)

								iter_354_5.color = Color.New(var_354_15, var_354_15, var_354_15)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_9 + var_354_10 and arg_351_1.time_ < var_354_9 + var_354_10 + arg_354_0 and not isNil(var_354_8) and arg_351_1.var_.actorSpriteComps1060 then
				for iter_354_6, iter_354_7 in pairs(arg_351_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_354_7 then
						if arg_351_1.isInRecall_ then
							iter_354_7.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps1060 = nil
			end

			local var_354_16 = 0
			local var_354_17 = 0.075

			if var_354_16 < arg_351_1.time_ and arg_351_1.time_ <= var_354_16 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_18 = arg_351_1:FormatText(StoryNameCfg[595].name)

				arg_351_1.leftNameTxt_.text = var_354_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_19 = arg_351_1:GetWordFromCfg(417232086)
				local var_354_20 = arg_351_1:FormatText(var_354_19.content)

				arg_351_1.text_.text = var_354_20

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_21 = 3
				local var_354_22 = utf8.len(var_354_20)
				local var_354_23 = var_354_21 <= 0 and var_354_17 or var_354_17 * (var_354_22 / var_354_21)

				if var_354_23 > 0 and var_354_17 < var_354_23 then
					arg_351_1.talkMaxDuration = var_354_23

					if var_354_23 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_23 + var_354_16
					end
				end

				arg_351_1.text_.text = var_354_20
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232086", "story_v_out_417232.awb") ~= 0 then
					local var_354_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232086", "story_v_out_417232.awb") / 1000

					if var_354_24 + var_354_16 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_24 + var_354_16
					end

					if var_354_19.prefab_name ~= "" and arg_351_1.actors_[var_354_19.prefab_name] ~= nil then
						local var_354_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_19.prefab_name].transform, "story_v_out_417232", "417232086", "story_v_out_417232.awb")

						arg_351_1:RecordAudio("417232086", var_354_25)
						arg_351_1:RecordAudio("417232086", var_354_25)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_417232", "417232086", "story_v_out_417232.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_417232", "417232086", "story_v_out_417232.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_26 = math.max(var_354_17, arg_351_1.talkMaxDuration)

			if var_354_16 <= arg_351_1.time_ and arg_351_1.time_ < var_354_16 + var_354_26 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_16) / var_354_26

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_16 + var_354_26 and arg_351_1.time_ < var_354_16 + var_354_26 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play417232087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 417232087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play417232088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10128"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10128 == nil then
				arg_355_1.var_.actorSpriteComps10128 = var_358_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_2 = 0.2

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.actorSpriteComps10128 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								local var_358_4 = Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, var_358_3)
								local var_358_5 = Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, var_358_3)
								local var_358_6 = Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, var_358_3)

								iter_358_1.color = Color.New(var_358_4, var_358_5, var_358_6)
							else
								local var_358_7 = Mathf.Lerp(iter_358_1.color.r, 0.5, var_358_3)

								iter_358_1.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.actorSpriteComps10128 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_358_3 then
						if arg_355_1.isInRecall_ then
							iter_358_3.color = arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_358_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_355_1.var_.actorSpriteComps10128 = nil
			end

			local var_358_8 = arg_355_1.actors_["10128"].transform
			local var_358_9 = 0

			if var_358_9 < arg_355_1.time_ and arg_355_1.time_ <= var_358_9 + arg_358_0 then
				arg_355_1.var_.moveOldPos10128 = var_358_8.localPosition
				var_358_8.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10128", 7)

				local var_358_10 = var_358_8.childCount

				for iter_358_4 = 0, var_358_10 - 1 do
					local var_358_11 = var_358_8:GetChild(iter_358_4)

					if var_358_11.name == "" or not string.find(var_358_11.name, "split") then
						var_358_11.gameObject:SetActive(true)
					else
						var_358_11.gameObject:SetActive(false)
					end
				end
			end

			local var_358_12 = 0.001

			if var_358_9 <= arg_355_1.time_ and arg_355_1.time_ < var_358_9 + var_358_12 then
				local var_358_13 = (arg_355_1.time_ - var_358_9) / var_358_12
				local var_358_14 = Vector3.New(0, -2000, -300)

				var_358_8.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10128, var_358_14, var_358_13)
			end

			if arg_355_1.time_ >= var_358_9 + var_358_12 and arg_355_1.time_ < var_358_9 + var_358_12 + arg_358_0 then
				var_358_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_358_15 = arg_355_1.actors_["1060"].transform
			local var_358_16 = 0

			if var_358_16 < arg_355_1.time_ and arg_355_1.time_ <= var_358_16 + arg_358_0 then
				arg_355_1.var_.moveOldPos1060 = var_358_15.localPosition
				var_358_15.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("1060", 7)

				local var_358_17 = var_358_15.childCount

				for iter_358_5 = 0, var_358_17 - 1 do
					local var_358_18 = var_358_15:GetChild(iter_358_5)

					if var_358_18.name == "" or not string.find(var_358_18.name, "split") then
						var_358_18.gameObject:SetActive(true)
					else
						var_358_18.gameObject:SetActive(false)
					end
				end
			end

			local var_358_19 = 0.001

			if var_358_16 <= arg_355_1.time_ and arg_355_1.time_ < var_358_16 + var_358_19 then
				local var_358_20 = (arg_355_1.time_ - var_358_16) / var_358_19
				local var_358_21 = Vector3.New(0, -2000, -40)

				var_358_15.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1060, var_358_21, var_358_20)
			end

			if arg_355_1.time_ >= var_358_16 + var_358_19 and arg_355_1.time_ < var_358_16 + var_358_19 + arg_358_0 then
				var_358_15.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_358_22 = 0
			local var_358_23 = 1.225

			if var_358_22 < arg_355_1.time_ and arg_355_1.time_ <= var_358_22 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_24 = arg_355_1:GetWordFromCfg(417232087)
				local var_358_25 = arg_355_1:FormatText(var_358_24.content)

				arg_355_1.text_.text = var_358_25

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_26 = 49
				local var_358_27 = utf8.len(var_358_25)
				local var_358_28 = var_358_26 <= 0 and var_358_23 or var_358_23 * (var_358_27 / var_358_26)

				if var_358_28 > 0 and var_358_23 < var_358_28 then
					arg_355_1.talkMaxDuration = var_358_28

					if var_358_28 + var_358_22 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_28 + var_358_22
					end
				end

				arg_355_1.text_.text = var_358_25
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_29 = math.max(var_358_23, arg_355_1.talkMaxDuration)

			if var_358_22 <= arg_355_1.time_ and arg_355_1.time_ < var_358_22 + var_358_29 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_22) / var_358_29

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_22 + var_358_29 and arg_355_1.time_ < var_358_22 + var_358_29 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
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

		arg_355_1:InitPlayNodeList()
	end,
	Play417232088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 417232088
		arg_359_1.duration_ = 10.97

		local var_359_0 = {
			zh = 9.766,
			ja = 10.966
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play417232089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 4

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			local var_362_1 = 0.3

			if arg_359_1.time_ >= var_362_0 + var_362_1 and arg_359_1.time_ < var_362_0 + var_362_1 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_2 = 2

			if var_362_2 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				local var_362_3 = manager.ui.mainCamera.transform.localPosition
				local var_362_4 = Vector3.New(0, 0, 10) + Vector3.New(var_362_3.x, var_362_3.y, 0)
				local var_362_5 = arg_359_1.bgs_.ST69a

				var_362_5.transform.localPosition = var_362_4
				var_362_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_362_6 = var_362_5:GetComponent("SpriteRenderer")

				if var_362_6 and var_362_6.sprite then
					local var_362_7 = (var_362_5.transform.localPosition - var_362_3).z
					local var_362_8 = manager.ui.mainCameraCom_
					local var_362_9 = 2 * var_362_7 * Mathf.Tan(var_362_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_362_10 = var_362_9 * var_362_8.aspect
					local var_362_11 = var_362_6.sprite.bounds.size.x
					local var_362_12 = var_362_6.sprite.bounds.size.y
					local var_362_13 = var_362_10 / var_362_11
					local var_362_14 = var_362_9 / var_362_12
					local var_362_15 = var_362_14 < var_362_13 and var_362_13 or var_362_14

					var_362_5.transform.localScale = Vector3.New(var_362_15, var_362_15, 0)
				end

				for iter_362_0, iter_362_1 in pairs(arg_359_1.bgs_) do
					if iter_362_0 ~= "ST69a" then
						iter_362_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_362_16 = 0

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_17 = 2

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_17 then
				local var_362_18 = (arg_359_1.time_ - var_362_16) / var_362_17
				local var_362_19 = Color.New(0, 0, 0)

				var_362_19.a = Mathf.Lerp(0, 1, var_362_18)
				arg_359_1.mask_.color = var_362_19
			end

			if arg_359_1.time_ >= var_362_16 + var_362_17 and arg_359_1.time_ < var_362_16 + var_362_17 + arg_362_0 then
				local var_362_20 = Color.New(0, 0, 0)

				var_362_20.a = 1
				arg_359_1.mask_.color = var_362_20
			end

			local var_362_21 = 2

			if var_362_21 < arg_359_1.time_ and arg_359_1.time_ <= var_362_21 + arg_362_0 then
				arg_359_1.mask_.enabled = true
				arg_359_1.mask_.raycastTarget = true

				arg_359_1:SetGaussion(false)
			end

			local var_362_22 = 2

			if var_362_21 <= arg_359_1.time_ and arg_359_1.time_ < var_362_21 + var_362_22 then
				local var_362_23 = (arg_359_1.time_ - var_362_21) / var_362_22
				local var_362_24 = Color.New(0, 0, 0)

				var_362_24.a = Mathf.Lerp(1, 0, var_362_23)
				arg_359_1.mask_.color = var_362_24
			end

			if arg_359_1.time_ >= var_362_21 + var_362_22 and arg_359_1.time_ < var_362_21 + var_362_22 + arg_362_0 then
				local var_362_25 = Color.New(0, 0, 0)
				local var_362_26 = 0

				arg_359_1.mask_.enabled = false
				var_362_25.a = var_362_26
				arg_359_1.mask_.color = var_362_25
			end

			local var_362_27 = arg_359_1.actors_["10111"]
			local var_362_28 = 3.66666666666667

			if var_362_28 < arg_359_1.time_ and arg_359_1.time_ <= var_362_28 + arg_362_0 and not isNil(var_362_27) and arg_359_1.var_.actorSpriteComps10111 == nil then
				arg_359_1.var_.actorSpriteComps10111 = var_362_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_29 = 0.2

			if var_362_28 <= arg_359_1.time_ and arg_359_1.time_ < var_362_28 + var_362_29 and not isNil(var_362_27) then
				local var_362_30 = (arg_359_1.time_ - var_362_28) / var_362_29

				if arg_359_1.var_.actorSpriteComps10111 then
					for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_362_3 then
							if arg_359_1.isInRecall_ then
								local var_362_31 = Mathf.Lerp(iter_362_3.color.r, arg_359_1.hightColor1.r, var_362_30)
								local var_362_32 = Mathf.Lerp(iter_362_3.color.g, arg_359_1.hightColor1.g, var_362_30)
								local var_362_33 = Mathf.Lerp(iter_362_3.color.b, arg_359_1.hightColor1.b, var_362_30)

								iter_362_3.color = Color.New(var_362_31, var_362_32, var_362_33)
							else
								local var_362_34 = Mathf.Lerp(iter_362_3.color.r, 1, var_362_30)

								iter_362_3.color = Color.New(var_362_34, var_362_34, var_362_34)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_28 + var_362_29 and arg_359_1.time_ < var_362_28 + var_362_29 + arg_362_0 and not isNil(var_362_27) and arg_359_1.var_.actorSpriteComps10111 then
				for iter_362_4, iter_362_5 in pairs(arg_359_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_362_5 then
						if arg_359_1.isInRecall_ then
							iter_362_5.color = arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_362_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10111 = nil
			end

			local var_362_35 = arg_359_1.actors_["10111"].transform
			local var_362_36 = 3.66666666666667

			if var_362_36 < arg_359_1.time_ and arg_359_1.time_ <= var_362_36 + arg_362_0 then
				arg_359_1.var_.moveOldPos10111 = var_362_35.localPosition
				var_362_35.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10111", 3)

				local var_362_37 = var_362_35.childCount

				for iter_362_6 = 0, var_362_37 - 1 do
					local var_362_38 = var_362_35:GetChild(iter_362_6)

					if var_362_38.name == "" or not string.find(var_362_38.name, "split") then
						var_362_38.gameObject:SetActive(true)
					else
						var_362_38.gameObject:SetActive(false)
					end
				end
			end

			local var_362_39 = 0.001

			if var_362_36 <= arg_359_1.time_ and arg_359_1.time_ < var_362_36 + var_362_39 then
				local var_362_40 = (arg_359_1.time_ - var_362_36) / var_362_39
				local var_362_41 = Vector3.New(0, -361.1, -274.6)

				var_362_35.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10111, var_362_41, var_362_40)
			end

			if arg_359_1.time_ >= var_362_36 + var_362_39 and arg_359_1.time_ < var_362_36 + var_362_39 + arg_362_0 then
				var_362_35.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_362_42 = arg_359_1.actors_["10111"]
			local var_362_43 = 3.66666666666667

			if var_362_43 < arg_359_1.time_ and arg_359_1.time_ <= var_362_43 + arg_362_0 then
				local var_362_44 = var_362_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_362_44 then
					arg_359_1.var_.alphaOldValue10111 = var_362_44.alpha
					arg_359_1.var_.characterEffect10111 = var_362_44
				end

				arg_359_1.var_.alphaOldValue10111 = 0
			end

			local var_362_45 = 0.333333333333333

			if var_362_43 <= arg_359_1.time_ and arg_359_1.time_ < var_362_43 + var_362_45 then
				local var_362_46 = (arg_359_1.time_ - var_362_43) / var_362_45
				local var_362_47 = Mathf.Lerp(arg_359_1.var_.alphaOldValue10111, 1, var_362_46)

				if arg_359_1.var_.characterEffect10111 then
					arg_359_1.var_.characterEffect10111.alpha = var_362_47
				end
			end

			if arg_359_1.time_ >= var_362_43 + var_362_45 and arg_359_1.time_ < var_362_43 + var_362_45 + arg_362_0 and arg_359_1.var_.characterEffect10111 then
				arg_359_1.var_.characterEffect10111.alpha = 1
			end

			if arg_359_1.frameCnt_ <= 1 then
				arg_359_1.dialog_:SetActive(false)
			end

			local var_362_48 = 4
			local var_362_49 = 0.775

			if var_362_48 < arg_359_1.time_ and arg_359_1.time_ <= var_362_48 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0

				arg_359_1.dialog_:SetActive(true)

				arg_359_1.dialogCg_.alpha = 0

				local var_362_50 = LeanTween.value(arg_359_1.dialog_, 0, 1, 0.3)

				var_362_50:setOnUpdate(LuaHelper.FloatAction(function(arg_363_0)
					arg_359_1.dialogCg_.alpha = arg_363_0
				end))
				var_362_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_359_1.dialog_)
					var_362_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_359_1.duration_ = arg_359_1.duration_ + 0.3

				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_51 = arg_359_1:FormatText(StoryNameCfg[1125].name)

				arg_359_1.leftNameTxt_.text = var_362_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_52 = arg_359_1:GetWordFromCfg(417232088)
				local var_362_53 = arg_359_1:FormatText(var_362_52.content)

				arg_359_1.text_.text = var_362_53

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_54 = 31
				local var_362_55 = utf8.len(var_362_53)
				local var_362_56 = var_362_54 <= 0 and var_362_49 or var_362_49 * (var_362_55 / var_362_54)

				if var_362_56 > 0 and var_362_49 < var_362_56 then
					arg_359_1.talkMaxDuration = var_362_56
					var_362_48 = var_362_48 + 0.3

					if var_362_56 + var_362_48 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_56 + var_362_48
					end
				end

				arg_359_1.text_.text = var_362_53
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232088", "story_v_out_417232.awb") ~= 0 then
					local var_362_57 = manager.audio:GetVoiceLength("story_v_out_417232", "417232088", "story_v_out_417232.awb") / 1000

					if var_362_57 + var_362_48 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_57 + var_362_48
					end

					if var_362_52.prefab_name ~= "" and arg_359_1.actors_[var_362_52.prefab_name] ~= nil then
						local var_362_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_52.prefab_name].transform, "story_v_out_417232", "417232088", "story_v_out_417232.awb")

						arg_359_1:RecordAudio("417232088", var_362_58)
						arg_359_1:RecordAudio("417232088", var_362_58)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_417232", "417232088", "story_v_out_417232.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_417232", "417232088", "story_v_out_417232.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_59 = var_362_48 + 0.3
			local var_362_60 = math.max(var_362_49, arg_359_1.talkMaxDuration)

			if var_362_59 <= arg_359_1.time_ and arg_359_1.time_ < var_362_59 + var_362_60 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_59) / var_362_60

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_59 + var_362_60 and arg_359_1.time_ < var_362_59 + var_362_60 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play417232089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 417232089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play417232090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10111"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps10111 == nil then
				arg_365_1.var_.actorSpriteComps10111 = var_368_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_2 = 0.2

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.actorSpriteComps10111 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								local var_368_4 = Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor2.r, var_368_3)
								local var_368_5 = Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor2.g, var_368_3)
								local var_368_6 = Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor2.b, var_368_3)

								iter_368_1.color = Color.New(var_368_4, var_368_5, var_368_6)
							else
								local var_368_7 = Mathf.Lerp(iter_368_1.color.r, 0.5, var_368_3)

								iter_368_1.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps10111 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_368_3 then
						if arg_365_1.isInRecall_ then
							iter_368_3.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10111 = nil
			end

			local var_368_8 = 0
			local var_368_9 = 1.5

			if var_368_8 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:GetWordFromCfg(417232089)
				local var_368_11 = arg_365_1:FormatText(var_368_10.content)

				arg_365_1.text_.text = var_368_11

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_12 = 60
				local var_368_13 = utf8.len(var_368_11)
				local var_368_14 = var_368_12 <= 0 and var_368_9 or var_368_9 * (var_368_13 / var_368_12)

				if var_368_14 > 0 and var_368_9 < var_368_14 then
					arg_365_1.talkMaxDuration = var_368_14

					if var_368_14 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_11
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_15 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_15 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_15

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_15 and arg_365_1.time_ < var_368_8 + var_368_15 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play417232090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 417232090
		arg_369_1.duration_ = 14.27

		local var_369_0 = {
			zh = 10.4,
			ja = 14.266
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
				arg_369_0:Play417232091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10111"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10111 == nil then
				arg_369_1.var_.actorSpriteComps10111 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps10111 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 1, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10111 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10111 = nil
			end

			local var_372_8 = arg_369_1.actors_["10111"].transform
			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.var_.moveOldPos10111 = var_372_8.localPosition
				var_372_8.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10111", 3)

				local var_372_10 = var_372_8.childCount

				for iter_372_4 = 0, var_372_10 - 1 do
					local var_372_11 = var_372_8:GetChild(iter_372_4)

					if var_372_11.name == "split_6" or not string.find(var_372_11.name, "split") then
						var_372_11.gameObject:SetActive(true)
					else
						var_372_11.gameObject:SetActive(false)
					end
				end
			end

			local var_372_12 = 0.001

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_12 then
				local var_372_13 = (arg_369_1.time_ - var_372_9) / var_372_12
				local var_372_14 = Vector3.New(0, -361.1, -274.6)

				var_372_8.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10111, var_372_14, var_372_13)
			end

			if arg_369_1.time_ >= var_372_9 + var_372_12 and arg_369_1.time_ < var_372_9 + var_372_12 + arg_372_0 then
				var_372_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_372_15 = 0
			local var_372_16 = 1.25

			if var_372_15 < arg_369_1.time_ and arg_369_1.time_ <= var_372_15 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_17 = arg_369_1:FormatText(StoryNameCfg[1125].name)

				arg_369_1.leftNameTxt_.text = var_372_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_18 = arg_369_1:GetWordFromCfg(417232090)
				local var_372_19 = arg_369_1:FormatText(var_372_18.content)

				arg_369_1.text_.text = var_372_19

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_20 = 50
				local var_372_21 = utf8.len(var_372_19)
				local var_372_22 = var_372_20 <= 0 and var_372_16 or var_372_16 * (var_372_21 / var_372_20)

				if var_372_22 > 0 and var_372_16 < var_372_22 then
					arg_369_1.talkMaxDuration = var_372_22

					if var_372_22 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_22 + var_372_15
					end
				end

				arg_369_1.text_.text = var_372_19
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232090", "story_v_out_417232.awb") ~= 0 then
					local var_372_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232090", "story_v_out_417232.awb") / 1000

					if var_372_23 + var_372_15 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_15
					end

					if var_372_18.prefab_name ~= "" and arg_369_1.actors_[var_372_18.prefab_name] ~= nil then
						local var_372_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_18.prefab_name].transform, "story_v_out_417232", "417232090", "story_v_out_417232.awb")

						arg_369_1:RecordAudio("417232090", var_372_24)
						arg_369_1:RecordAudio("417232090", var_372_24)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_417232", "417232090", "story_v_out_417232.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_417232", "417232090", "story_v_out_417232.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_25 = math.max(var_372_16, arg_369_1.talkMaxDuration)

			if var_372_15 <= arg_369_1.time_ and arg_369_1.time_ < var_372_15 + var_372_25 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_15) / var_372_25

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_15 + var_372_25 and arg_369_1.time_ < var_372_15 + var_372_25 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
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
	Play417232091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 417232091
		arg_373_1.duration_ = 9.8

		local var_373_0 = {
			zh = 8.4,
			ja = 9.8
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
				arg_373_0:Play417232092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 1.075

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[1125].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_3 = arg_373_1:GetWordFromCfg(417232091)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 43
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232091", "story_v_out_417232.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232091", "story_v_out_417232.awb") / 1000

					if var_376_8 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_0
					end

					if var_376_3.prefab_name ~= "" and arg_373_1.actors_[var_376_3.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_3.prefab_name].transform, "story_v_out_417232", "417232091", "story_v_out_417232.awb")

						arg_373_1:RecordAudio("417232091", var_376_9)
						arg_373_1:RecordAudio("417232091", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_417232", "417232091", "story_v_out_417232.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_417232", "417232091", "story_v_out_417232.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_10 and arg_373_1.time_ < var_376_0 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play417232092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 417232092
		arg_377_1.duration_ = 14.27

		local var_377_0 = {
			zh = 12.5,
			ja = 14.266
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
				arg_377_0:Play417232093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 1.525

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[1125].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_3 = arg_377_1:GetWordFromCfg(417232092)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 61
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232092", "story_v_out_417232.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232092", "story_v_out_417232.awb") / 1000

					if var_380_8 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_0
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_417232", "417232092", "story_v_out_417232.awb")

						arg_377_1:RecordAudio("417232092", var_380_9)
						arg_377_1:RecordAudio("417232092", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_417232", "417232092", "story_v_out_417232.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_417232", "417232092", "story_v_out_417232.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_10 and arg_377_1.time_ < var_380_0 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play417232093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 417232093
		arg_381_1.duration_ = 14.1

		local var_381_0 = {
			zh = 14.1,
			ja = 13.9
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
				arg_381_0:Play417232094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 1.675

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[1125].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_3 = arg_381_1:GetWordFromCfg(417232093)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 67
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232093", "story_v_out_417232.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232093", "story_v_out_417232.awb") / 1000

					if var_384_8 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_0
					end

					if var_384_3.prefab_name ~= "" and arg_381_1.actors_[var_384_3.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_3.prefab_name].transform, "story_v_out_417232", "417232093", "story_v_out_417232.awb")

						arg_381_1:RecordAudio("417232093", var_384_9)
						arg_381_1:RecordAudio("417232093", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_417232", "417232093", "story_v_out_417232.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_417232", "417232093", "story_v_out_417232.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_10 and arg_381_1.time_ < var_384_0 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play417232094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 417232094
		arg_385_1.duration_ = 5.33

		local var_385_0 = {
			zh = 2.166,
			ja = 5.333
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play417232095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1034"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps1034 == nil then
				arg_385_1.var_.actorSpriteComps1034 = var_388_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_2 = 0.2

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.actorSpriteComps1034 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								local var_388_4 = Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, var_388_3)
								local var_388_5 = Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, var_388_3)
								local var_388_6 = Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, var_388_3)

								iter_388_1.color = Color.New(var_388_4, var_388_5, var_388_6)
							else
								local var_388_7 = Mathf.Lerp(iter_388_1.color.r, 1, var_388_3)

								iter_388_1.color = Color.New(var_388_7, var_388_7, var_388_7)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps1034 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_388_3 then
						if arg_385_1.isInRecall_ then
							iter_388_3.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1034 = nil
			end

			local var_388_8 = arg_385_1.actors_["10111"]
			local var_388_9 = 0

			if var_388_9 < arg_385_1.time_ and arg_385_1.time_ <= var_388_9 + arg_388_0 and not isNil(var_388_8) and arg_385_1.var_.actorSpriteComps10111 == nil then
				arg_385_1.var_.actorSpriteComps10111 = var_388_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_10 = 0.2

			if var_388_9 <= arg_385_1.time_ and arg_385_1.time_ < var_388_9 + var_388_10 and not isNil(var_388_8) then
				local var_388_11 = (arg_385_1.time_ - var_388_9) / var_388_10

				if arg_385_1.var_.actorSpriteComps10111 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								local var_388_12 = Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor2.r, var_388_11)
								local var_388_13 = Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor2.g, var_388_11)
								local var_388_14 = Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor2.b, var_388_11)

								iter_388_5.color = Color.New(var_388_12, var_388_13, var_388_14)
							else
								local var_388_15 = Mathf.Lerp(iter_388_5.color.r, 0.5, var_388_11)

								iter_388_5.color = Color.New(var_388_15, var_388_15, var_388_15)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_9 + var_388_10 and arg_385_1.time_ < var_388_9 + var_388_10 + arg_388_0 and not isNil(var_388_8) and arg_385_1.var_.actorSpriteComps10111 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_388_7 then
						if arg_385_1.isInRecall_ then
							iter_388_7.color = arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_388_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps10111 = nil
			end

			local var_388_16 = arg_385_1.actors_["10111"].transform
			local var_388_17 = 0

			if var_388_17 < arg_385_1.time_ and arg_385_1.time_ <= var_388_17 + arg_388_0 then
				arg_385_1.var_.moveOldPos10111 = var_388_16.localPosition
				var_388_16.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10111", 2)

				local var_388_18 = var_388_16.childCount

				for iter_388_8 = 0, var_388_18 - 1 do
					local var_388_19 = var_388_16:GetChild(iter_388_8)

					if var_388_19.name == "" or not string.find(var_388_19.name, "split") then
						var_388_19.gameObject:SetActive(true)
					else
						var_388_19.gameObject:SetActive(false)
					end
				end
			end

			local var_388_20 = 0.001

			if var_388_17 <= arg_385_1.time_ and arg_385_1.time_ < var_388_17 + var_388_20 then
				local var_388_21 = (arg_385_1.time_ - var_388_17) / var_388_20
				local var_388_22 = Vector3.New(-390, -361.1, -274.6)

				var_388_16.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10111, var_388_22, var_388_21)
			end

			if arg_385_1.time_ >= var_388_17 + var_388_20 and arg_385_1.time_ < var_388_17 + var_388_20 + arg_388_0 then
				var_388_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_388_23 = arg_385_1.actors_["1034"].transform
			local var_388_24 = 0

			if var_388_24 < arg_385_1.time_ and arg_385_1.time_ <= var_388_24 + arg_388_0 then
				arg_385_1.var_.moveOldPos1034 = var_388_23.localPosition
				var_388_23.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("1034", 4)

				local var_388_25 = var_388_23.childCount

				for iter_388_9 = 0, var_388_25 - 1 do
					local var_388_26 = var_388_23:GetChild(iter_388_9)

					if var_388_26.name == "" or not string.find(var_388_26.name, "split") then
						var_388_26.gameObject:SetActive(true)
					else
						var_388_26.gameObject:SetActive(false)
					end
				end
			end

			local var_388_27 = 0.001

			if var_388_24 <= arg_385_1.time_ and arg_385_1.time_ < var_388_24 + var_388_27 then
				local var_388_28 = (arg_385_1.time_ - var_388_24) / var_388_27
				local var_388_29 = Vector3.New(373.7, -331.9, -324)

				var_388_23.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1034, var_388_29, var_388_28)
			end

			if arg_385_1.time_ >= var_388_24 + var_388_27 and arg_385_1.time_ < var_388_24 + var_388_27 + arg_388_0 then
				var_388_23.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_388_30 = 0
			local var_388_31 = 0.275

			if var_388_30 < arg_385_1.time_ and arg_385_1.time_ <= var_388_30 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_32 = arg_385_1:FormatText(StoryNameCfg[1109].name)

				arg_385_1.leftNameTxt_.text = var_388_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_33 = arg_385_1:GetWordFromCfg(417232094)
				local var_388_34 = arg_385_1:FormatText(var_388_33.content)

				arg_385_1.text_.text = var_388_34

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_35 = 11
				local var_388_36 = utf8.len(var_388_34)
				local var_388_37 = var_388_35 <= 0 and var_388_31 or var_388_31 * (var_388_36 / var_388_35)

				if var_388_37 > 0 and var_388_31 < var_388_37 then
					arg_385_1.talkMaxDuration = var_388_37

					if var_388_37 + var_388_30 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_37 + var_388_30
					end
				end

				arg_385_1.text_.text = var_388_34
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232094", "story_v_out_417232.awb") ~= 0 then
					local var_388_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232094", "story_v_out_417232.awb") / 1000

					if var_388_38 + var_388_30 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_38 + var_388_30
					end

					if var_388_33.prefab_name ~= "" and arg_385_1.actors_[var_388_33.prefab_name] ~= nil then
						local var_388_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_33.prefab_name].transform, "story_v_out_417232", "417232094", "story_v_out_417232.awb")

						arg_385_1:RecordAudio("417232094", var_388_39)
						arg_385_1:RecordAudio("417232094", var_388_39)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_417232", "417232094", "story_v_out_417232.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_417232", "417232094", "story_v_out_417232.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_40 = math.max(var_388_31, arg_385_1.talkMaxDuration)

			if var_388_30 <= arg_385_1.time_ and arg_385_1.time_ < var_388_30 + var_388_40 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_30) / var_388_40

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_30 + var_388_40 and arg_385_1.time_ < var_388_30 + var_388_40 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
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
	Play417232095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 417232095
		arg_389_1.duration_ = 1.5

		local var_389_0 = {
			zh = 1,
			ja = 1.5
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
				arg_389_0:Play417232096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10111"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10111 == nil then
				arg_389_1.var_.actorSpriteComps10111 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps10111 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								local var_392_4 = Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, var_392_3)
								local var_392_5 = Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, var_392_3)
								local var_392_6 = Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, var_392_3)

								iter_392_1.color = Color.New(var_392_4, var_392_5, var_392_6)
							else
								local var_392_7 = Mathf.Lerp(iter_392_1.color.r, 1, var_392_3)

								iter_392_1.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10111 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_392_3 then
						if arg_389_1.isInRecall_ then
							iter_392_3.color = arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_392_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10111 = nil
			end

			local var_392_8 = arg_389_1.actors_["1034"]
			local var_392_9 = 0

			if var_392_9 < arg_389_1.time_ and arg_389_1.time_ <= var_392_9 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps1034 == nil then
				arg_389_1.var_.actorSpriteComps1034 = var_392_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_10 = 0.2

			if var_392_9 <= arg_389_1.time_ and arg_389_1.time_ < var_392_9 + var_392_10 and not isNil(var_392_8) then
				local var_392_11 = (arg_389_1.time_ - var_392_9) / var_392_10

				if arg_389_1.var_.actorSpriteComps1034 then
					for iter_392_4, iter_392_5 in pairs(arg_389_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_392_5 then
							if arg_389_1.isInRecall_ then
								local var_392_12 = Mathf.Lerp(iter_392_5.color.r, arg_389_1.hightColor2.r, var_392_11)
								local var_392_13 = Mathf.Lerp(iter_392_5.color.g, arg_389_1.hightColor2.g, var_392_11)
								local var_392_14 = Mathf.Lerp(iter_392_5.color.b, arg_389_1.hightColor2.b, var_392_11)

								iter_392_5.color = Color.New(var_392_12, var_392_13, var_392_14)
							else
								local var_392_15 = Mathf.Lerp(iter_392_5.color.r, 0.5, var_392_11)

								iter_392_5.color = Color.New(var_392_15, var_392_15, var_392_15)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_9 + var_392_10 and arg_389_1.time_ < var_392_9 + var_392_10 + arg_392_0 and not isNil(var_392_8) and arg_389_1.var_.actorSpriteComps1034 then
				for iter_392_6, iter_392_7 in pairs(arg_389_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_392_7 then
						if arg_389_1.isInRecall_ then
							iter_392_7.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps1034 = nil
			end

			local var_392_16 = 0
			local var_392_17 = 0.1

			if var_392_16 < arg_389_1.time_ and arg_389_1.time_ <= var_392_16 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_18 = arg_389_1:FormatText(StoryNameCfg[1125].name)

				arg_389_1.leftNameTxt_.text = var_392_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_19 = arg_389_1:GetWordFromCfg(417232095)
				local var_392_20 = arg_389_1:FormatText(var_392_19.content)

				arg_389_1.text_.text = var_392_20

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_21 = 4
				local var_392_22 = utf8.len(var_392_20)
				local var_392_23 = var_392_21 <= 0 and var_392_17 or var_392_17 * (var_392_22 / var_392_21)

				if var_392_23 > 0 and var_392_17 < var_392_23 then
					arg_389_1.talkMaxDuration = var_392_23

					if var_392_23 + var_392_16 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_16
					end
				end

				arg_389_1.text_.text = var_392_20
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232095", "story_v_out_417232.awb") ~= 0 then
					local var_392_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232095", "story_v_out_417232.awb") / 1000

					if var_392_24 + var_392_16 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_24 + var_392_16
					end

					if var_392_19.prefab_name ~= "" and arg_389_1.actors_[var_392_19.prefab_name] ~= nil then
						local var_392_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_19.prefab_name].transform, "story_v_out_417232", "417232095", "story_v_out_417232.awb")

						arg_389_1:RecordAudio("417232095", var_392_25)
						arg_389_1:RecordAudio("417232095", var_392_25)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_417232", "417232095", "story_v_out_417232.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_417232", "417232095", "story_v_out_417232.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_26 = math.max(var_392_17, arg_389_1.talkMaxDuration)

			if var_392_16 <= arg_389_1.time_ and arg_389_1.time_ < var_392_16 + var_392_26 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_16) / var_392_26

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_16 + var_392_26 and arg_389_1.time_ < var_392_16 + var_392_26 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play417232096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 417232096
		arg_393_1.duration_ = 10.6

		local var_393_0 = {
			zh = 7.866,
			ja = 10.6
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play417232097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1034"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps1034 == nil then
				arg_393_1.var_.actorSpriteComps1034 = var_396_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_2 = 0.2

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.actorSpriteComps1034 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								local var_396_4 = Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, var_396_3)
								local var_396_5 = Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, var_396_3)
								local var_396_6 = Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, var_396_3)

								iter_396_1.color = Color.New(var_396_4, var_396_5, var_396_6)
							else
								local var_396_7 = Mathf.Lerp(iter_396_1.color.r, 1, var_396_3)

								iter_396_1.color = Color.New(var_396_7, var_396_7, var_396_7)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps1034 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_396_3 then
						if arg_393_1.isInRecall_ then
							iter_396_3.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1034 = nil
			end

			local var_396_8 = arg_393_1.actors_["10111"]
			local var_396_9 = 0

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 and not isNil(var_396_8) and arg_393_1.var_.actorSpriteComps10111 == nil then
				arg_393_1.var_.actorSpriteComps10111 = var_396_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_10 = 0.2

			if var_396_9 <= arg_393_1.time_ and arg_393_1.time_ < var_396_9 + var_396_10 and not isNil(var_396_8) then
				local var_396_11 = (arg_393_1.time_ - var_396_9) / var_396_10

				if arg_393_1.var_.actorSpriteComps10111 then
					for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_396_5 then
							if arg_393_1.isInRecall_ then
								local var_396_12 = Mathf.Lerp(iter_396_5.color.r, arg_393_1.hightColor2.r, var_396_11)
								local var_396_13 = Mathf.Lerp(iter_396_5.color.g, arg_393_1.hightColor2.g, var_396_11)
								local var_396_14 = Mathf.Lerp(iter_396_5.color.b, arg_393_1.hightColor2.b, var_396_11)

								iter_396_5.color = Color.New(var_396_12, var_396_13, var_396_14)
							else
								local var_396_15 = Mathf.Lerp(iter_396_5.color.r, 0.5, var_396_11)

								iter_396_5.color = Color.New(var_396_15, var_396_15, var_396_15)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_9 + var_396_10 and arg_393_1.time_ < var_396_9 + var_396_10 + arg_396_0 and not isNil(var_396_8) and arg_393_1.var_.actorSpriteComps10111 then
				for iter_396_6, iter_396_7 in pairs(arg_393_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_396_7 then
						if arg_393_1.isInRecall_ then
							iter_396_7.color = arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_396_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps10111 = nil
			end

			local var_396_16 = 0
			local var_396_17 = 1

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_18 = arg_393_1:FormatText(StoryNameCfg[1109].name)

				arg_393_1.leftNameTxt_.text = var_396_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_19 = arg_393_1:GetWordFromCfg(417232096)
				local var_396_20 = arg_393_1:FormatText(var_396_19.content)

				arg_393_1.text_.text = var_396_20

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_21 = 40
				local var_396_22 = utf8.len(var_396_20)
				local var_396_23 = var_396_21 <= 0 and var_396_17 or var_396_17 * (var_396_22 / var_396_21)

				if var_396_23 > 0 and var_396_17 < var_396_23 then
					arg_393_1.talkMaxDuration = var_396_23

					if var_396_23 + var_396_16 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_16
					end
				end

				arg_393_1.text_.text = var_396_20
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232096", "story_v_out_417232.awb") ~= 0 then
					local var_396_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232096", "story_v_out_417232.awb") / 1000

					if var_396_24 + var_396_16 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_24 + var_396_16
					end

					if var_396_19.prefab_name ~= "" and arg_393_1.actors_[var_396_19.prefab_name] ~= nil then
						local var_396_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_19.prefab_name].transform, "story_v_out_417232", "417232096", "story_v_out_417232.awb")

						arg_393_1:RecordAudio("417232096", var_396_25)
						arg_393_1:RecordAudio("417232096", var_396_25)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_417232", "417232096", "story_v_out_417232.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_417232", "417232096", "story_v_out_417232.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_26 = math.max(var_396_17, arg_393_1.talkMaxDuration)

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_26 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_16) / var_396_26

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_16 + var_396_26 and arg_393_1.time_ < var_396_16 + var_396_26 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play417232097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 417232097
		arg_397_1.duration_ = 5.47

		local var_397_0 = {
			zh = 5.1,
			ja = 5.466
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play417232098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.7

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[1109].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:GetWordFromCfg(417232097)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 28
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232097", "story_v_out_417232.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232097", "story_v_out_417232.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_out_417232", "417232097", "story_v_out_417232.awb")

						arg_397_1:RecordAudio("417232097", var_400_9)
						arg_397_1:RecordAudio("417232097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_417232", "417232097", "story_v_out_417232.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_417232", "417232097", "story_v_out_417232.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play417232098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 417232098
		arg_401_1.duration_ = 1.83

		local var_401_0 = {
			zh = 1.366,
			ja = 1.833
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play417232099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10128"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10128 == nil then
				arg_401_1.var_.actorSpriteComps10128 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps10128 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								local var_404_4 = Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor1.r, var_404_3)
								local var_404_5 = Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor1.g, var_404_3)
								local var_404_6 = Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor1.b, var_404_3)

								iter_404_1.color = Color.New(var_404_4, var_404_5, var_404_6)
							else
								local var_404_7 = Mathf.Lerp(iter_404_1.color.r, 1, var_404_3)

								iter_404_1.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10128 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_404_3 then
						if arg_401_1.isInRecall_ then
							iter_404_3.color = arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_404_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10128 = nil
			end

			local var_404_8 = arg_401_1.actors_["1034"]
			local var_404_9 = 0

			if var_404_9 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 and not isNil(var_404_8) and arg_401_1.var_.actorSpriteComps1034 == nil then
				arg_401_1.var_.actorSpriteComps1034 = var_404_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_10 = 0.2

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_10 and not isNil(var_404_8) then
				local var_404_11 = (arg_401_1.time_ - var_404_9) / var_404_10

				if arg_401_1.var_.actorSpriteComps1034 then
					for iter_404_4, iter_404_5 in pairs(arg_401_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_404_5 then
							if arg_401_1.isInRecall_ then
								local var_404_12 = Mathf.Lerp(iter_404_5.color.r, arg_401_1.hightColor2.r, var_404_11)
								local var_404_13 = Mathf.Lerp(iter_404_5.color.g, arg_401_1.hightColor2.g, var_404_11)
								local var_404_14 = Mathf.Lerp(iter_404_5.color.b, arg_401_1.hightColor2.b, var_404_11)

								iter_404_5.color = Color.New(var_404_12, var_404_13, var_404_14)
							else
								local var_404_15 = Mathf.Lerp(iter_404_5.color.r, 0.5, var_404_11)

								iter_404_5.color = Color.New(var_404_15, var_404_15, var_404_15)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_9 + var_404_10 and arg_401_1.time_ < var_404_9 + var_404_10 + arg_404_0 and not isNil(var_404_8) and arg_401_1.var_.actorSpriteComps1034 then
				for iter_404_6, iter_404_7 in pairs(arg_401_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_404_7 then
						if arg_401_1.isInRecall_ then
							iter_404_7.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps1034 = nil
			end

			local var_404_16 = arg_401_1.actors_["1034"].transform
			local var_404_17 = 0

			if var_404_17 < arg_401_1.time_ and arg_401_1.time_ <= var_404_17 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034 = var_404_16.localPosition
				var_404_16.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1034", 7)

				local var_404_18 = var_404_16.childCount

				for iter_404_8 = 0, var_404_18 - 1 do
					local var_404_19 = var_404_16:GetChild(iter_404_8)

					if var_404_19.name == "" or not string.find(var_404_19.name, "split") then
						var_404_19.gameObject:SetActive(true)
					else
						var_404_19.gameObject:SetActive(false)
					end
				end
			end

			local var_404_20 = 0.001

			if var_404_17 <= arg_401_1.time_ and arg_401_1.time_ < var_404_17 + var_404_20 then
				local var_404_21 = (arg_401_1.time_ - var_404_17) / var_404_20
				local var_404_22 = Vector3.New(0, -2000, 0)

				var_404_16.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034, var_404_22, var_404_21)
			end

			if arg_401_1.time_ >= var_404_17 + var_404_20 and arg_401_1.time_ < var_404_17 + var_404_20 + arg_404_0 then
				var_404_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_404_23 = arg_401_1.actors_["10128"].transform
			local var_404_24 = 0

			if var_404_24 < arg_401_1.time_ and arg_401_1.time_ <= var_404_24 + arg_404_0 then
				arg_401_1.var_.moveOldPos10128 = var_404_23.localPosition
				var_404_23.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10128", 4)

				local var_404_25 = var_404_23.childCount

				for iter_404_9 = 0, var_404_25 - 1 do
					local var_404_26 = var_404_23:GetChild(iter_404_9)

					if var_404_26.name == "" or not string.find(var_404_26.name, "split") then
						var_404_26.gameObject:SetActive(true)
					else
						var_404_26.gameObject:SetActive(false)
					end
				end
			end

			local var_404_27 = 0.001

			if var_404_24 <= arg_401_1.time_ and arg_401_1.time_ < var_404_24 + var_404_27 then
				local var_404_28 = (arg_401_1.time_ - var_404_24) / var_404_27
				local var_404_29 = Vector3.New(390, -347, -300)

				var_404_23.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10128, var_404_29, var_404_28)
			end

			if arg_401_1.time_ >= var_404_24 + var_404_27 and arg_401_1.time_ < var_404_24 + var_404_27 + arg_404_0 then
				var_404_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_404_30 = 0
			local var_404_31 = 0.125

			if var_404_30 < arg_401_1.time_ and arg_401_1.time_ <= var_404_30 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_32 = arg_401_1:FormatText(StoryNameCfg[595].name)

				arg_401_1.leftNameTxt_.text = var_404_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_33 = arg_401_1:GetWordFromCfg(417232098)
				local var_404_34 = arg_401_1:FormatText(var_404_33.content)

				arg_401_1.text_.text = var_404_34

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_35 = 5
				local var_404_36 = utf8.len(var_404_34)
				local var_404_37 = var_404_35 <= 0 and var_404_31 or var_404_31 * (var_404_36 / var_404_35)

				if var_404_37 > 0 and var_404_31 < var_404_37 then
					arg_401_1.talkMaxDuration = var_404_37

					if var_404_37 + var_404_30 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_37 + var_404_30
					end
				end

				arg_401_1.text_.text = var_404_34
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232098", "story_v_out_417232.awb") ~= 0 then
					local var_404_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232098", "story_v_out_417232.awb") / 1000

					if var_404_38 + var_404_30 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_38 + var_404_30
					end

					if var_404_33.prefab_name ~= "" and arg_401_1.actors_[var_404_33.prefab_name] ~= nil then
						local var_404_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_33.prefab_name].transform, "story_v_out_417232", "417232098", "story_v_out_417232.awb")

						arg_401_1:RecordAudio("417232098", var_404_39)
						arg_401_1:RecordAudio("417232098", var_404_39)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_417232", "417232098", "story_v_out_417232.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_417232", "417232098", "story_v_out_417232.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_40 = math.max(var_404_31, arg_401_1.talkMaxDuration)

			if var_404_30 <= arg_401_1.time_ and arg_401_1.time_ < var_404_30 + var_404_40 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_30) / var_404_40

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_30 + var_404_40 and arg_401_1.time_ < var_404_30 + var_404_40 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play417232099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 417232099
		arg_405_1.duration_ = 8.5

		local var_405_0 = {
			zh = 6.5,
			ja = 8.5
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play417232100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10111"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10111 == nil then
				arg_405_1.var_.actorSpriteComps10111 = var_408_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.actorSpriteComps10111 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								local var_408_4 = Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor1.r, var_408_3)
								local var_408_5 = Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor1.g, var_408_3)
								local var_408_6 = Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor1.b, var_408_3)

								iter_408_1.color = Color.New(var_408_4, var_408_5, var_408_6)
							else
								local var_408_7 = Mathf.Lerp(iter_408_1.color.r, 1, var_408_3)

								iter_408_1.color = Color.New(var_408_7, var_408_7, var_408_7)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.actorSpriteComps10111 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_408_3 then
						if arg_405_1.isInRecall_ then
							iter_408_3.color = arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_408_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps10111 = nil
			end

			local var_408_8 = arg_405_1.actors_["10128"]
			local var_408_9 = 0

			if var_408_9 < arg_405_1.time_ and arg_405_1.time_ <= var_408_9 + arg_408_0 and not isNil(var_408_8) and arg_405_1.var_.actorSpriteComps10128 == nil then
				arg_405_1.var_.actorSpriteComps10128 = var_408_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_10 = 0.2

			if var_408_9 <= arg_405_1.time_ and arg_405_1.time_ < var_408_9 + var_408_10 and not isNil(var_408_8) then
				local var_408_11 = (arg_405_1.time_ - var_408_9) / var_408_10

				if arg_405_1.var_.actorSpriteComps10128 then
					for iter_408_4, iter_408_5 in pairs(arg_405_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_408_5 then
							if arg_405_1.isInRecall_ then
								local var_408_12 = Mathf.Lerp(iter_408_5.color.r, arg_405_1.hightColor2.r, var_408_11)
								local var_408_13 = Mathf.Lerp(iter_408_5.color.g, arg_405_1.hightColor2.g, var_408_11)
								local var_408_14 = Mathf.Lerp(iter_408_5.color.b, arg_405_1.hightColor2.b, var_408_11)

								iter_408_5.color = Color.New(var_408_12, var_408_13, var_408_14)
							else
								local var_408_15 = Mathf.Lerp(iter_408_5.color.r, 0.5, var_408_11)

								iter_408_5.color = Color.New(var_408_15, var_408_15, var_408_15)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= var_408_9 + var_408_10 and arg_405_1.time_ < var_408_9 + var_408_10 + arg_408_0 and not isNil(var_408_8) and arg_405_1.var_.actorSpriteComps10128 then
				for iter_408_6, iter_408_7 in pairs(arg_405_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_408_7 then
						if arg_405_1.isInRecall_ then
							iter_408_7.color = arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_408_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_405_1.var_.actorSpriteComps10128 = nil
			end

			local var_408_16 = arg_405_1.actors_["10111"].transform
			local var_408_17 = 0

			if var_408_17 < arg_405_1.time_ and arg_405_1.time_ <= var_408_17 + arg_408_0 then
				arg_405_1.var_.moveOldPos10111 = var_408_16.localPosition
				var_408_16.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10111", 2)

				local var_408_18 = var_408_16.childCount

				for iter_408_8 = 0, var_408_18 - 1 do
					local var_408_19 = var_408_16:GetChild(iter_408_8)

					if var_408_19.name == "split_1" or not string.find(var_408_19.name, "split") then
						var_408_19.gameObject:SetActive(true)
					else
						var_408_19.gameObject:SetActive(false)
					end
				end
			end

			local var_408_20 = 0.001

			if var_408_17 <= arg_405_1.time_ and arg_405_1.time_ < var_408_17 + var_408_20 then
				local var_408_21 = (arg_405_1.time_ - var_408_17) / var_408_20
				local var_408_22 = Vector3.New(-390, -361.1, -274.6)

				var_408_16.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10111, var_408_22, var_408_21)
			end

			if arg_405_1.time_ >= var_408_17 + var_408_20 and arg_405_1.time_ < var_408_17 + var_408_20 + arg_408_0 then
				var_408_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_408_23 = 0
			local var_408_24 = 0.75

			if var_408_23 < arg_405_1.time_ and arg_405_1.time_ <= var_408_23 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_25 = arg_405_1:FormatText(StoryNameCfg[1125].name)

				arg_405_1.leftNameTxt_.text = var_408_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_26 = arg_405_1:GetWordFromCfg(417232099)
				local var_408_27 = arg_405_1:FormatText(var_408_26.content)

				arg_405_1.text_.text = var_408_27

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_28 = 30
				local var_408_29 = utf8.len(var_408_27)
				local var_408_30 = var_408_28 <= 0 and var_408_24 or var_408_24 * (var_408_29 / var_408_28)

				if var_408_30 > 0 and var_408_24 < var_408_30 then
					arg_405_1.talkMaxDuration = var_408_30

					if var_408_30 + var_408_23 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_30 + var_408_23
					end
				end

				arg_405_1.text_.text = var_408_27
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232099", "story_v_out_417232.awb") ~= 0 then
					local var_408_31 = manager.audio:GetVoiceLength("story_v_out_417232", "417232099", "story_v_out_417232.awb") / 1000

					if var_408_31 + var_408_23 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_31 + var_408_23
					end

					if var_408_26.prefab_name ~= "" and arg_405_1.actors_[var_408_26.prefab_name] ~= nil then
						local var_408_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_26.prefab_name].transform, "story_v_out_417232", "417232099", "story_v_out_417232.awb")

						arg_405_1:RecordAudio("417232099", var_408_32)
						arg_405_1:RecordAudio("417232099", var_408_32)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_417232", "417232099", "story_v_out_417232.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_417232", "417232099", "story_v_out_417232.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_33 = math.max(var_408_24, arg_405_1.talkMaxDuration)

			if var_408_23 <= arg_405_1.time_ and arg_405_1.time_ < var_408_23 + var_408_33 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_23) / var_408_33

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_23 + var_408_33 and arg_405_1.time_ < var_408_23 + var_408_33 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play417232100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 417232100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play417232101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10111"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps10111 == nil then
				arg_409_1.var_.actorSpriteComps10111 = var_412_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.actorSpriteComps10111 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								local var_412_4 = Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor2.r, var_412_3)
								local var_412_5 = Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor2.g, var_412_3)
								local var_412_6 = Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor2.b, var_412_3)

								iter_412_1.color = Color.New(var_412_4, var_412_5, var_412_6)
							else
								local var_412_7 = Mathf.Lerp(iter_412_1.color.r, 0.5, var_412_3)

								iter_412_1.color = Color.New(var_412_7, var_412_7, var_412_7)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.actorSpriteComps10111 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_412_3 then
						if arg_409_1.isInRecall_ then
							iter_412_3.color = arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_412_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps10111 = nil
			end

			local var_412_8 = arg_409_1.actors_["10111"].transform
			local var_412_9 = 0

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.var_.moveOldPos10111 = var_412_8.localPosition
				var_412_8.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10111", 7)

				local var_412_10 = var_412_8.childCount

				for iter_412_4 = 0, var_412_10 - 1 do
					local var_412_11 = var_412_8:GetChild(iter_412_4)

					if var_412_11.name == "" or not string.find(var_412_11.name, "split") then
						var_412_11.gameObject:SetActive(true)
					else
						var_412_11.gameObject:SetActive(false)
					end
				end
			end

			local var_412_12 = 0.001

			if var_412_9 <= arg_409_1.time_ and arg_409_1.time_ < var_412_9 + var_412_12 then
				local var_412_13 = (arg_409_1.time_ - var_412_9) / var_412_12
				local var_412_14 = Vector3.New(0, -2000, 0)

				var_412_8.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10111, var_412_14, var_412_13)
			end

			if arg_409_1.time_ >= var_412_9 + var_412_12 and arg_409_1.time_ < var_412_9 + var_412_12 + arg_412_0 then
				var_412_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_412_15 = arg_409_1.actors_["10128"].transform
			local var_412_16 = 0

			if var_412_16 < arg_409_1.time_ and arg_409_1.time_ <= var_412_16 + arg_412_0 then
				arg_409_1.var_.moveOldPos10128 = var_412_15.localPosition
				var_412_15.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10128", 7)

				local var_412_17 = var_412_15.childCount

				for iter_412_5 = 0, var_412_17 - 1 do
					local var_412_18 = var_412_15:GetChild(iter_412_5)

					if var_412_18.name == "" or not string.find(var_412_18.name, "split") then
						var_412_18.gameObject:SetActive(true)
					else
						var_412_18.gameObject:SetActive(false)
					end
				end
			end

			local var_412_19 = 0.001

			if var_412_16 <= arg_409_1.time_ and arg_409_1.time_ < var_412_16 + var_412_19 then
				local var_412_20 = (arg_409_1.time_ - var_412_16) / var_412_19
				local var_412_21 = Vector3.New(0, -2000, -300)

				var_412_15.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10128, var_412_21, var_412_20)
			end

			if arg_409_1.time_ >= var_412_16 + var_412_19 and arg_409_1.time_ < var_412_16 + var_412_19 + arg_412_0 then
				var_412_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_412_22 = 0
			local var_412_23 = 0.75

			if var_412_22 < arg_409_1.time_ and arg_409_1.time_ <= var_412_22 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_24 = arg_409_1:GetWordFromCfg(417232100)
				local var_412_25 = arg_409_1:FormatText(var_412_24.content)

				arg_409_1.text_.text = var_412_25

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_26 = 30
				local var_412_27 = utf8.len(var_412_25)
				local var_412_28 = var_412_26 <= 0 and var_412_23 or var_412_23 * (var_412_27 / var_412_26)

				if var_412_28 > 0 and var_412_23 < var_412_28 then
					arg_409_1.talkMaxDuration = var_412_28

					if var_412_28 + var_412_22 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_28 + var_412_22
					end
				end

				arg_409_1.text_.text = var_412_25
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_29 = math.max(var_412_23, arg_409_1.talkMaxDuration)

			if var_412_22 <= arg_409_1.time_ and arg_409_1.time_ < var_412_22 + var_412_29 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_22) / var_412_29

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_22 + var_412_29 and arg_409_1.time_ < var_412_22 + var_412_29 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play417232101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 417232101
		arg_413_1.duration_ = 12.13

		local var_413_0 = {
			zh = 6.7,
			ja = 12.133
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play417232102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10111"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10111 == nil then
				arg_413_1.var_.actorSpriteComps10111 = var_416_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.actorSpriteComps10111 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								local var_416_4 = Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor1.r, var_416_3)
								local var_416_5 = Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor1.g, var_416_3)
								local var_416_6 = Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor1.b, var_416_3)

								iter_416_1.color = Color.New(var_416_4, var_416_5, var_416_6)
							else
								local var_416_7 = Mathf.Lerp(iter_416_1.color.r, 1, var_416_3)

								iter_416_1.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps10111 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_416_3 then
						if arg_413_1.isInRecall_ then
							iter_416_3.color = arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_416_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps10111 = nil
			end

			local var_416_8 = arg_413_1.actors_["10111"].transform
			local var_416_9 = 0

			if var_416_9 < arg_413_1.time_ and arg_413_1.time_ <= var_416_9 + arg_416_0 then
				arg_413_1.var_.moveOldPos10111 = var_416_8.localPosition
				var_416_8.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("10111", 3)

				local var_416_10 = var_416_8.childCount

				for iter_416_4 = 0, var_416_10 - 1 do
					local var_416_11 = var_416_8:GetChild(iter_416_4)

					if var_416_11.name == "" or not string.find(var_416_11.name, "split") then
						var_416_11.gameObject:SetActive(true)
					else
						var_416_11.gameObject:SetActive(false)
					end
				end
			end

			local var_416_12 = 0.001

			if var_416_9 <= arg_413_1.time_ and arg_413_1.time_ < var_416_9 + var_416_12 then
				local var_416_13 = (arg_413_1.time_ - var_416_9) / var_416_12
				local var_416_14 = Vector3.New(0, -361.1, -274.6)

				var_416_8.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10111, var_416_14, var_416_13)
			end

			if arg_413_1.time_ >= var_416_9 + var_416_12 and arg_413_1.time_ < var_416_9 + var_416_12 + arg_416_0 then
				var_416_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_416_15 = 0
			local var_416_16 = 0.8

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_17 = arg_413_1:FormatText(StoryNameCfg[1125].name)

				arg_413_1.leftNameTxt_.text = var_416_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_18 = arg_413_1:GetWordFromCfg(417232101)
				local var_416_19 = arg_413_1:FormatText(var_416_18.content)

				arg_413_1.text_.text = var_416_19

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_20 = 32
				local var_416_21 = utf8.len(var_416_19)
				local var_416_22 = var_416_20 <= 0 and var_416_16 or var_416_16 * (var_416_21 / var_416_20)

				if var_416_22 > 0 and var_416_16 < var_416_22 then
					arg_413_1.talkMaxDuration = var_416_22

					if var_416_22 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_15
					end
				end

				arg_413_1.text_.text = var_416_19
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232101", "story_v_out_417232.awb") ~= 0 then
					local var_416_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232101", "story_v_out_417232.awb") / 1000

					if var_416_23 + var_416_15 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_23 + var_416_15
					end

					if var_416_18.prefab_name ~= "" and arg_413_1.actors_[var_416_18.prefab_name] ~= nil then
						local var_416_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_18.prefab_name].transform, "story_v_out_417232", "417232101", "story_v_out_417232.awb")

						arg_413_1:RecordAudio("417232101", var_416_24)
						arg_413_1:RecordAudio("417232101", var_416_24)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_417232", "417232101", "story_v_out_417232.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_417232", "417232101", "story_v_out_417232.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_25 = math.max(var_416_16, arg_413_1.talkMaxDuration)

			if var_416_15 <= arg_413_1.time_ and arg_413_1.time_ < var_416_15 + var_416_25 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_15) / var_416_25

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_15 + var_416_25 and arg_413_1.time_ < var_416_15 + var_416_25 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play417232102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 417232102
		arg_417_1.duration_ = 15.17

		local var_417_0 = {
			zh = 10.266,
			ja = 15.166
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play417232103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 1.35

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[1125].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_3 = arg_417_1:GetWordFromCfg(417232102)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 54
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232102", "story_v_out_417232.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232102", "story_v_out_417232.awb") / 1000

					if var_420_8 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_0
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_out_417232", "417232102", "story_v_out_417232.awb")

						arg_417_1:RecordAudio("417232102", var_420_9)
						arg_417_1:RecordAudio("417232102", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_417232", "417232102", "story_v_out_417232.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_417232", "417232102", "story_v_out_417232.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_10 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_10 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_10

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_10 and arg_417_1.time_ < var_420_0 + var_420_10 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play417232103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 417232103
		arg_421_1.duration_ = 4.43

		local var_421_0 = {
			zh = 2.7,
			ja = 4.433
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play417232104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 0.325

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_2 = arg_421_1:FormatText(StoryNameCfg[1125].name)

				arg_421_1.leftNameTxt_.text = var_424_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_3 = arg_421_1:GetWordFromCfg(417232103)
				local var_424_4 = arg_421_1:FormatText(var_424_3.content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 13
				local var_424_6 = utf8.len(var_424_4)
				local var_424_7 = var_424_5 <= 0 and var_424_1 or var_424_1 * (var_424_6 / var_424_5)

				if var_424_7 > 0 and var_424_1 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232103", "story_v_out_417232.awb") ~= 0 then
					local var_424_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232103", "story_v_out_417232.awb") / 1000

					if var_424_8 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_0
					end

					if var_424_3.prefab_name ~= "" and arg_421_1.actors_[var_424_3.prefab_name] ~= nil then
						local var_424_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_3.prefab_name].transform, "story_v_out_417232", "417232103", "story_v_out_417232.awb")

						arg_421_1:RecordAudio("417232103", var_424_9)
						arg_421_1:RecordAudio("417232103", var_424_9)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_417232", "417232103", "story_v_out_417232.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_417232", "417232103", "story_v_out_417232.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_10 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_10 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_10

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_10 and arg_421_1.time_ < var_424_0 + var_424_10 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play417232104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 417232104
		arg_425_1.duration_ = 6.3

		local var_425_0 = {
			zh = 5.433,
			ja = 6.3
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play417232105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10128"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10128 == nil then
				arg_425_1.var_.actorSpriteComps10128 = var_428_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.actorSpriteComps10128 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								local var_428_4 = Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor1.r, var_428_3)
								local var_428_5 = Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor1.g, var_428_3)
								local var_428_6 = Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor1.b, var_428_3)

								iter_428_1.color = Color.New(var_428_4, var_428_5, var_428_6)
							else
								local var_428_7 = Mathf.Lerp(iter_428_1.color.r, 1, var_428_3)

								iter_428_1.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10128 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_428_3 then
						if arg_425_1.isInRecall_ then
							iter_428_3.color = arg_425_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_428_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10128 = nil
			end

			local var_428_8 = arg_425_1.actors_["10111"]
			local var_428_9 = 0

			if var_428_9 < arg_425_1.time_ and arg_425_1.time_ <= var_428_9 + arg_428_0 and not isNil(var_428_8) and arg_425_1.var_.actorSpriteComps10111 == nil then
				arg_425_1.var_.actorSpriteComps10111 = var_428_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_10 = 0.2

			if var_428_9 <= arg_425_1.time_ and arg_425_1.time_ < var_428_9 + var_428_10 and not isNil(var_428_8) then
				local var_428_11 = (arg_425_1.time_ - var_428_9) / var_428_10

				if arg_425_1.var_.actorSpriteComps10111 then
					for iter_428_4, iter_428_5 in pairs(arg_425_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_428_5 then
							if arg_425_1.isInRecall_ then
								local var_428_12 = Mathf.Lerp(iter_428_5.color.r, arg_425_1.hightColor2.r, var_428_11)
								local var_428_13 = Mathf.Lerp(iter_428_5.color.g, arg_425_1.hightColor2.g, var_428_11)
								local var_428_14 = Mathf.Lerp(iter_428_5.color.b, arg_425_1.hightColor2.b, var_428_11)

								iter_428_5.color = Color.New(var_428_12, var_428_13, var_428_14)
							else
								local var_428_15 = Mathf.Lerp(iter_428_5.color.r, 0.5, var_428_11)

								iter_428_5.color = Color.New(var_428_15, var_428_15, var_428_15)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_9 + var_428_10 and arg_425_1.time_ < var_428_9 + var_428_10 + arg_428_0 and not isNil(var_428_8) and arg_425_1.var_.actorSpriteComps10111 then
				for iter_428_6, iter_428_7 in pairs(arg_425_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_428_7 then
						if arg_425_1.isInRecall_ then
							iter_428_7.color = arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_428_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10111 = nil
			end

			local var_428_16 = arg_425_1.actors_["10111"].transform
			local var_428_17 = 0

			if var_428_17 < arg_425_1.time_ and arg_425_1.time_ <= var_428_17 + arg_428_0 then
				arg_425_1.var_.moveOldPos10111 = var_428_16.localPosition
				var_428_16.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10111", 7)

				local var_428_18 = var_428_16.childCount

				for iter_428_8 = 0, var_428_18 - 1 do
					local var_428_19 = var_428_16:GetChild(iter_428_8)

					if var_428_19.name == "" or not string.find(var_428_19.name, "split") then
						var_428_19.gameObject:SetActive(true)
					else
						var_428_19.gameObject:SetActive(false)
					end
				end
			end

			local var_428_20 = 0.001

			if var_428_17 <= arg_425_1.time_ and arg_425_1.time_ < var_428_17 + var_428_20 then
				local var_428_21 = (arg_425_1.time_ - var_428_17) / var_428_20
				local var_428_22 = Vector3.New(0, -2000, 0)

				var_428_16.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10111, var_428_22, var_428_21)
			end

			if arg_425_1.time_ >= var_428_17 + var_428_20 and arg_425_1.time_ < var_428_17 + var_428_20 + arg_428_0 then
				var_428_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_428_23 = arg_425_1.actors_["10128"].transform
			local var_428_24 = 0

			if var_428_24 < arg_425_1.time_ and arg_425_1.time_ <= var_428_24 + arg_428_0 then
				arg_425_1.var_.moveOldPos10128 = var_428_23.localPosition
				var_428_23.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("10128", 3)

				local var_428_25 = var_428_23.childCount

				for iter_428_9 = 0, var_428_25 - 1 do
					local var_428_26 = var_428_23:GetChild(iter_428_9)

					if var_428_26.name == "" or not string.find(var_428_26.name, "split") then
						var_428_26.gameObject:SetActive(true)
					else
						var_428_26.gameObject:SetActive(false)
					end
				end
			end

			local var_428_27 = 0.001

			if var_428_24 <= arg_425_1.time_ and arg_425_1.time_ < var_428_24 + var_428_27 then
				local var_428_28 = (arg_425_1.time_ - var_428_24) / var_428_27
				local var_428_29 = Vector3.New(0, -347, -300)

				var_428_23.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10128, var_428_29, var_428_28)
			end

			if arg_425_1.time_ >= var_428_24 + var_428_27 and arg_425_1.time_ < var_428_24 + var_428_27 + arg_428_0 then
				var_428_23.localPosition = Vector3.New(0, -347, -300)
			end

			local var_428_30 = 0
			local var_428_31 = 0.625

			if var_428_30 < arg_425_1.time_ and arg_425_1.time_ <= var_428_30 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_32 = arg_425_1:FormatText(StoryNameCfg[595].name)

				arg_425_1.leftNameTxt_.text = var_428_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_33 = arg_425_1:GetWordFromCfg(417232104)
				local var_428_34 = arg_425_1:FormatText(var_428_33.content)

				arg_425_1.text_.text = var_428_34

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_35 = 25
				local var_428_36 = utf8.len(var_428_34)
				local var_428_37 = var_428_35 <= 0 and var_428_31 or var_428_31 * (var_428_36 / var_428_35)

				if var_428_37 > 0 and var_428_31 < var_428_37 then
					arg_425_1.talkMaxDuration = var_428_37

					if var_428_37 + var_428_30 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_37 + var_428_30
					end
				end

				arg_425_1.text_.text = var_428_34
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232104", "story_v_out_417232.awb") ~= 0 then
					local var_428_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232104", "story_v_out_417232.awb") / 1000

					if var_428_38 + var_428_30 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_38 + var_428_30
					end

					if var_428_33.prefab_name ~= "" and arg_425_1.actors_[var_428_33.prefab_name] ~= nil then
						local var_428_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_33.prefab_name].transform, "story_v_out_417232", "417232104", "story_v_out_417232.awb")

						arg_425_1:RecordAudio("417232104", var_428_39)
						arg_425_1:RecordAudio("417232104", var_428_39)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_417232", "417232104", "story_v_out_417232.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_417232", "417232104", "story_v_out_417232.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_40 = math.max(var_428_31, arg_425_1.talkMaxDuration)

			if var_428_30 <= arg_425_1.time_ and arg_425_1.time_ < var_428_30 + var_428_40 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_30) / var_428_40

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_30 + var_428_40 and arg_425_1.time_ < var_428_30 + var_428_40 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play417232105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 417232105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play417232106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10128"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10128 == nil then
				arg_429_1.var_.actorSpriteComps10128 = var_432_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_2 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.actorSpriteComps10128 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								local var_432_4 = Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor2.r, var_432_3)
								local var_432_5 = Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor2.g, var_432_3)
								local var_432_6 = Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor2.b, var_432_3)

								iter_432_1.color = Color.New(var_432_4, var_432_5, var_432_6)
							else
								local var_432_7 = Mathf.Lerp(iter_432_1.color.r, 0.5, var_432_3)

								iter_432_1.color = Color.New(var_432_7, var_432_7, var_432_7)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.actorSpriteComps10128 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_432_3 then
						if arg_429_1.isInRecall_ then
							iter_432_3.color = arg_429_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_432_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_429_1.var_.actorSpriteComps10128 = nil
			end

			local var_432_8 = 0.02
			local var_432_9 = 1

			if var_432_8 < arg_429_1.time_ and arg_429_1.time_ <= var_432_8 + arg_432_0 then
				local var_432_10 = "play"
				local var_432_11 = "effect"

				arg_429_1:AudioAction(var_432_10, var_432_11, "se_story_1310", "se_story_1310_uimap", "")
			end

			local var_432_12 = 0
			local var_432_13 = 1

			if var_432_12 < arg_429_1.time_ and arg_429_1.time_ <= var_432_12 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_14 = arg_429_1:GetWordFromCfg(417232105)
				local var_432_15 = arg_429_1:FormatText(var_432_14.content)

				arg_429_1.text_.text = var_432_15

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_16 = 40
				local var_432_17 = utf8.len(var_432_15)
				local var_432_18 = var_432_16 <= 0 and var_432_13 or var_432_13 * (var_432_17 / var_432_16)

				if var_432_18 > 0 and var_432_13 < var_432_18 then
					arg_429_1.talkMaxDuration = var_432_18

					if var_432_18 + var_432_12 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_18 + var_432_12
					end
				end

				arg_429_1.text_.text = var_432_15
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_19 = math.max(var_432_13, arg_429_1.talkMaxDuration)

			if var_432_12 <= arg_429_1.time_ and arg_429_1.time_ < var_432_12 + var_432_19 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_12) / var_432_19

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_12 + var_432_19 and arg_429_1.time_ < var_432_12 + var_432_19 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play417232106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 417232106
		arg_433_1.duration_ = 15.27

		local var_433_0 = {
			zh = 10.1,
			ja = 15.266
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play417232107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["10128"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10128 == nil then
				arg_433_1.var_.actorSpriteComps10128 = var_436_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_2 = 0.2

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.actorSpriteComps10128 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								local var_436_4 = Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor1.r, var_436_3)
								local var_436_5 = Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor1.g, var_436_3)
								local var_436_6 = Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor1.b, var_436_3)

								iter_436_1.color = Color.New(var_436_4, var_436_5, var_436_6)
							else
								local var_436_7 = Mathf.Lerp(iter_436_1.color.r, 1, var_436_3)

								iter_436_1.color = Color.New(var_436_7, var_436_7, var_436_7)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.actorSpriteComps10128 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_436_3 then
						if arg_433_1.isInRecall_ then
							iter_436_3.color = arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_436_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_433_1.var_.actorSpriteComps10128 = nil
			end

			local var_436_8 = 0
			local var_436_9 = 1.275

			if var_436_8 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_10 = arg_433_1:FormatText(StoryNameCfg[595].name)

				arg_433_1.leftNameTxt_.text = var_436_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_11 = arg_433_1:GetWordFromCfg(417232106)
				local var_436_12 = arg_433_1:FormatText(var_436_11.content)

				arg_433_1.text_.text = var_436_12

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_13 = 51
				local var_436_14 = utf8.len(var_436_12)
				local var_436_15 = var_436_13 <= 0 and var_436_9 or var_436_9 * (var_436_14 / var_436_13)

				if var_436_15 > 0 and var_436_9 < var_436_15 then
					arg_433_1.talkMaxDuration = var_436_15

					if var_436_15 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_15 + var_436_8
					end
				end

				arg_433_1.text_.text = var_436_12
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232106", "story_v_out_417232.awb") ~= 0 then
					local var_436_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232106", "story_v_out_417232.awb") / 1000

					if var_436_16 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_16 + var_436_8
					end

					if var_436_11.prefab_name ~= "" and arg_433_1.actors_[var_436_11.prefab_name] ~= nil then
						local var_436_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_11.prefab_name].transform, "story_v_out_417232", "417232106", "story_v_out_417232.awb")

						arg_433_1:RecordAudio("417232106", var_436_17)
						arg_433_1:RecordAudio("417232106", var_436_17)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_417232", "417232106", "story_v_out_417232.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_417232", "417232106", "story_v_out_417232.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_18 = math.max(var_436_9, arg_433_1.talkMaxDuration)

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_18 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_8) / var_436_18

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_8 + var_436_18 and arg_433_1.time_ < var_436_8 + var_436_18 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play417232107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 417232107
		arg_437_1.duration_ = 3.5

		local var_437_0 = {
			zh = 3.5,
			ja = 1.966
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play417232108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["10128"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10128 == nil then
				arg_437_1.var_.actorSpriteComps10128 = var_440_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_2 = 0.2

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.actorSpriteComps10128 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								local var_440_4 = Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor2.r, var_440_3)
								local var_440_5 = Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor2.g, var_440_3)
								local var_440_6 = Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor2.b, var_440_3)

								iter_440_1.color = Color.New(var_440_4, var_440_5, var_440_6)
							else
								local var_440_7 = Mathf.Lerp(iter_440_1.color.r, 0.5, var_440_3)

								iter_440_1.color = Color.New(var_440_7, var_440_7, var_440_7)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.actorSpriteComps10128 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_440_3 then
						if arg_437_1.isInRecall_ then
							iter_440_3.color = arg_437_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_440_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_437_1.var_.actorSpriteComps10128 = nil
			end

			local var_440_8 = 0
			local var_440_9 = 0.3

			if var_440_8 < arg_437_1.time_ and arg_437_1.time_ <= var_440_8 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_10 = arg_437_1:FormatText(StoryNameCfg[1110].name)

				arg_437_1.leftNameTxt_.text = var_440_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_11 = arg_437_1:GetWordFromCfg(417232107)
				local var_440_12 = arg_437_1:FormatText(var_440_11.content)

				arg_437_1.text_.text = var_440_12

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_13 = 12
				local var_440_14 = utf8.len(var_440_12)
				local var_440_15 = var_440_13 <= 0 and var_440_9 or var_440_9 * (var_440_14 / var_440_13)

				if var_440_15 > 0 and var_440_9 < var_440_15 then
					arg_437_1.talkMaxDuration = var_440_15

					if var_440_15 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_15 + var_440_8
					end
				end

				arg_437_1.text_.text = var_440_12
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232107", "story_v_out_417232.awb") ~= 0 then
					local var_440_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232107", "story_v_out_417232.awb") / 1000

					if var_440_16 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_16 + var_440_8
					end

					if var_440_11.prefab_name ~= "" and arg_437_1.actors_[var_440_11.prefab_name] ~= nil then
						local var_440_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_11.prefab_name].transform, "story_v_out_417232", "417232107", "story_v_out_417232.awb")

						arg_437_1:RecordAudio("417232107", var_440_17)
						arg_437_1:RecordAudio("417232107", var_440_17)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_417232", "417232107", "story_v_out_417232.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_417232", "417232107", "story_v_out_417232.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_18 = math.max(var_440_9, arg_437_1.talkMaxDuration)

			if var_440_8 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_18 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_18

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_18 and arg_437_1.time_ < var_440_8 + var_440_18 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play417232108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 417232108
		arg_441_1.duration_ = 12

		local var_441_0 = {
			zh = 9.1,
			ja = 12
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play417232109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = "I17f"

			if arg_441_1.bgs_[var_444_0] == nil then
				local var_444_1 = Object.Instantiate(arg_441_1.paintGo_)

				var_444_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_444_0)
				var_444_1.name = var_444_0
				var_444_1.transform.parent = arg_441_1.stage_.transform
				var_444_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_441_1.bgs_[var_444_0] = var_444_1
			end

			local var_444_2 = 2

			if var_444_2 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				local var_444_3 = manager.ui.mainCamera.transform.localPosition
				local var_444_4 = Vector3.New(0, 0, 10) + Vector3.New(var_444_3.x, var_444_3.y, 0)
				local var_444_5 = arg_441_1.bgs_.I17f

				var_444_5.transform.localPosition = var_444_4
				var_444_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_444_6 = var_444_5:GetComponent("SpriteRenderer")

				if var_444_6 and var_444_6.sprite then
					local var_444_7 = (var_444_5.transform.localPosition - var_444_3).z
					local var_444_8 = manager.ui.mainCameraCom_
					local var_444_9 = 2 * var_444_7 * Mathf.Tan(var_444_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_444_10 = var_444_9 * var_444_8.aspect
					local var_444_11 = var_444_6.sprite.bounds.size.x
					local var_444_12 = var_444_6.sprite.bounds.size.y
					local var_444_13 = var_444_10 / var_444_11
					local var_444_14 = var_444_9 / var_444_12
					local var_444_15 = var_444_14 < var_444_13 and var_444_13 or var_444_14

					var_444_5.transform.localScale = Vector3.New(var_444_15, var_444_15, 0)
				end

				for iter_444_0, iter_444_1 in pairs(arg_441_1.bgs_) do
					if iter_444_0 ~= "I17f" then
						iter_444_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_444_16 = 4

			if var_444_16 < arg_441_1.time_ and arg_441_1.time_ <= var_444_16 + arg_444_0 then
				arg_441_1.allBtn_.enabled = false
			end

			local var_444_17 = 0.4

			if arg_441_1.time_ >= var_444_16 + var_444_17 and arg_441_1.time_ < var_444_16 + var_444_17 + arg_444_0 then
				arg_441_1.allBtn_.enabled = true
			end

			local var_444_18 = 0

			if var_444_18 < arg_441_1.time_ and arg_441_1.time_ <= var_444_18 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = true

				arg_441_1:SetGaussion(false)
			end

			local var_444_19 = 2

			if var_444_18 <= arg_441_1.time_ and arg_441_1.time_ < var_444_18 + var_444_19 then
				local var_444_20 = (arg_441_1.time_ - var_444_18) / var_444_19
				local var_444_21 = Color.New(0, 0, 0)

				var_444_21.a = Mathf.Lerp(0, 1, var_444_20)
				arg_441_1.mask_.color = var_444_21
			end

			if arg_441_1.time_ >= var_444_18 + var_444_19 and arg_441_1.time_ < var_444_18 + var_444_19 + arg_444_0 then
				local var_444_22 = Color.New(0, 0, 0)

				var_444_22.a = 1
				arg_441_1.mask_.color = var_444_22
			end

			local var_444_23 = 2

			if var_444_23 < arg_441_1.time_ and arg_441_1.time_ <= var_444_23 + arg_444_0 then
				arg_441_1.mask_.enabled = true
				arg_441_1.mask_.raycastTarget = true

				arg_441_1:SetGaussion(false)
			end

			local var_444_24 = 2

			if var_444_23 <= arg_441_1.time_ and arg_441_1.time_ < var_444_23 + var_444_24 then
				local var_444_25 = (arg_441_1.time_ - var_444_23) / var_444_24
				local var_444_26 = Color.New(0, 0, 0)

				var_444_26.a = Mathf.Lerp(1, 0, var_444_25)
				arg_441_1.mask_.color = var_444_26
			end

			if arg_441_1.time_ >= var_444_23 + var_444_24 and arg_441_1.time_ < var_444_23 + var_444_24 + arg_444_0 then
				local var_444_27 = Color.New(0, 0, 0)
				local var_444_28 = 0

				arg_441_1.mask_.enabled = false
				var_444_27.a = var_444_28
				arg_441_1.mask_.color = var_444_27
			end

			local var_444_29 = arg_441_1.actors_["10128"].transform
			local var_444_30 = 1.966

			if var_444_30 < arg_441_1.time_ and arg_441_1.time_ <= var_444_30 + arg_444_0 then
				arg_441_1.var_.moveOldPos10128 = var_444_29.localPosition
				var_444_29.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10128", 7)

				local var_444_31 = var_444_29.childCount

				for iter_444_2 = 0, var_444_31 - 1 do
					local var_444_32 = var_444_29:GetChild(iter_444_2)

					if var_444_32.name == "" or not string.find(var_444_32.name, "split") then
						var_444_32.gameObject:SetActive(true)
					else
						var_444_32.gameObject:SetActive(false)
					end
				end
			end

			local var_444_33 = 0.001

			if var_444_30 <= arg_441_1.time_ and arg_441_1.time_ < var_444_30 + var_444_33 then
				local var_444_34 = (arg_441_1.time_ - var_444_30) / var_444_33
				local var_444_35 = Vector3.New(0, -2000, -300)

				var_444_29.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10128, var_444_35, var_444_34)
			end

			if arg_441_1.time_ >= var_444_30 + var_444_33 and arg_441_1.time_ < var_444_30 + var_444_33 + arg_444_0 then
				var_444_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_444_36 = 2

			arg_441_1.isInRecall_ = true

			if var_444_36 < arg_441_1.time_ and arg_441_1.time_ <= var_444_36 + arg_444_0 then
				arg_441_1.screenFilterGo_:SetActive(true)

				arg_441_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_441_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_441_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_444_3, iter_444_4 in pairs(arg_441_1.actors_) do
					local var_444_37 = iter_444_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_444_5, iter_444_6 in ipairs(var_444_37) do
						if iter_444_6.color.r > 0.51 then
							iter_444_6.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_444_6.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_444_38 = 0.1

			if var_444_36 <= arg_441_1.time_ and arg_441_1.time_ < var_444_36 + var_444_38 then
				local var_444_39 = (arg_441_1.time_ - var_444_36) / var_444_38

				arg_441_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_444_39)
			end

			if arg_441_1.time_ >= var_444_36 + var_444_38 and arg_441_1.time_ < var_444_36 + var_444_38 + arg_444_0 then
				arg_441_1.screenFilterEffect_.weight = 1
			end

			if arg_441_1.frameCnt_ <= 1 then
				arg_441_1.dialog_:SetActive(false)
			end

			local var_444_40 = 4
			local var_444_41 = 0.7

			if var_444_40 < arg_441_1.time_ and arg_441_1.time_ <= var_444_40 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0

				arg_441_1.dialog_:SetActive(true)

				arg_441_1.dialogCg_.alpha = 0

				local var_444_42 = LeanTween.value(arg_441_1.dialog_, 0, 1, 0.3)

				var_444_42:setOnUpdate(LuaHelper.FloatAction(function(arg_445_0)
					arg_441_1.dialogCg_.alpha = arg_445_0
				end))
				var_444_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_441_1.dialog_)
					var_444_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_441_1.duration_ = arg_441_1.duration_ + 0.3

				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_43 = arg_441_1:FormatText(StoryNameCfg[1110].name)

				arg_441_1.leftNameTxt_.text = var_444_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_441_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_444_44 = arg_441_1:GetWordFromCfg(417232108)
				local var_444_45 = arg_441_1:FormatText(var_444_44.content)

				arg_441_1.text_.text = var_444_45

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_46 = 28
				local var_444_47 = utf8.len(var_444_45)
				local var_444_48 = var_444_46 <= 0 and var_444_41 or var_444_41 * (var_444_47 / var_444_46)

				if var_444_48 > 0 and var_444_41 < var_444_48 then
					arg_441_1.talkMaxDuration = var_444_48
					var_444_40 = var_444_40 + 0.3

					if var_444_48 + var_444_40 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_48 + var_444_40
					end
				end

				arg_441_1.text_.text = var_444_45
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232108", "story_v_out_417232.awb") ~= 0 then
					local var_444_49 = manager.audio:GetVoiceLength("story_v_out_417232", "417232108", "story_v_out_417232.awb") / 1000

					if var_444_49 + var_444_40 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_49 + var_444_40
					end

					if var_444_44.prefab_name ~= "" and arg_441_1.actors_[var_444_44.prefab_name] ~= nil then
						local var_444_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_44.prefab_name].transform, "story_v_out_417232", "417232108", "story_v_out_417232.awb")

						arg_441_1:RecordAudio("417232108", var_444_50)
						arg_441_1:RecordAudio("417232108", var_444_50)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_417232", "417232108", "story_v_out_417232.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_417232", "417232108", "story_v_out_417232.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_51 = var_444_40 + 0.3
			local var_444_52 = math.max(var_444_41, arg_441_1.talkMaxDuration)

			if var_444_51 <= arg_441_1.time_ and arg_441_1.time_ < var_444_51 + var_444_52 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_51) / var_444_52

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_51 + var_444_52 and arg_441_1.time_ < var_444_51 + var_444_52 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play417232109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 417232109
		arg_447_1.duration_ = 1.53

		local var_447_0 = {
			zh = 0.999999999999,
			ja = 1.533
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play417232110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["10128"]
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.actorSpriteComps10128 == nil then
				arg_447_1.var_.actorSpriteComps10128 = var_450_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_2 = 0.2

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 and not isNil(var_450_0) then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2

				if arg_447_1.var_.actorSpriteComps10128 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								local var_450_4 = Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor1.r, var_450_3)
								local var_450_5 = Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor1.g, var_450_3)
								local var_450_6 = Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor1.b, var_450_3)

								iter_450_1.color = Color.New(var_450_4, var_450_5, var_450_6)
							else
								local var_450_7 = Mathf.Lerp(iter_450_1.color.r, 1, var_450_3)

								iter_450_1.color = Color.New(var_450_7, var_450_7, var_450_7)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 and not isNil(var_450_0) and arg_447_1.var_.actorSpriteComps10128 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_450_3 then
						if arg_447_1.isInRecall_ then
							iter_450_3.color = arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_450_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_447_1.var_.actorSpriteComps10128 = nil
			end

			local var_450_8 = arg_447_1.actors_["10128"].transform
			local var_450_9 = 0

			if var_450_9 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				arg_447_1.var_.moveOldPos10128 = var_450_8.localPosition
				var_450_8.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10128", 3)

				local var_450_10 = var_450_8.childCount

				for iter_450_4 = 0, var_450_10 - 1 do
					local var_450_11 = var_450_8:GetChild(iter_450_4)

					if var_450_11.name == "" or not string.find(var_450_11.name, "split") then
						var_450_11.gameObject:SetActive(true)
					else
						var_450_11.gameObject:SetActive(false)
					end
				end
			end

			local var_450_12 = 0.001

			if var_450_9 <= arg_447_1.time_ and arg_447_1.time_ < var_450_9 + var_450_12 then
				local var_450_13 = (arg_447_1.time_ - var_450_9) / var_450_12
				local var_450_14 = Vector3.New(0, -347, -300)

				var_450_8.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10128, var_450_14, var_450_13)
			end

			if arg_447_1.time_ >= var_450_9 + var_450_12 and arg_447_1.time_ < var_450_9 + var_450_12 + arg_450_0 then
				var_450_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_450_15 = 0
			local var_450_16 = 0.125

			if var_450_15 < arg_447_1.time_ and arg_447_1.time_ <= var_450_15 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_17 = arg_447_1:FormatText(StoryNameCfg[595].name)

				arg_447_1.leftNameTxt_.text = var_450_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_18 = arg_447_1:GetWordFromCfg(417232109)
				local var_450_19 = arg_447_1:FormatText(var_450_18.content)

				arg_447_1.text_.text = var_450_19

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_20 = 5
				local var_450_21 = utf8.len(var_450_19)
				local var_450_22 = var_450_20 <= 0 and var_450_16 or var_450_16 * (var_450_21 / var_450_20)

				if var_450_22 > 0 and var_450_16 < var_450_22 then
					arg_447_1.talkMaxDuration = var_450_22

					if var_450_22 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_22 + var_450_15
					end
				end

				arg_447_1.text_.text = var_450_19
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232109", "story_v_out_417232.awb") ~= 0 then
					local var_450_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232109", "story_v_out_417232.awb") / 1000

					if var_450_23 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_23 + var_450_15
					end

					if var_450_18.prefab_name ~= "" and arg_447_1.actors_[var_450_18.prefab_name] ~= nil then
						local var_450_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_18.prefab_name].transform, "story_v_out_417232", "417232109", "story_v_out_417232.awb")

						arg_447_1:RecordAudio("417232109", var_450_24)
						arg_447_1:RecordAudio("417232109", var_450_24)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_417232", "417232109", "story_v_out_417232.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_417232", "417232109", "story_v_out_417232.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_25 = math.max(var_450_16, arg_447_1.talkMaxDuration)

			if var_450_15 <= arg_447_1.time_ and arg_447_1.time_ < var_450_15 + var_450_25 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_15) / var_450_25

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_15 + var_450_25 and arg_447_1.time_ < var_450_15 + var_450_25 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play417232110 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 417232110
		arg_451_1.duration_ = 8.83

		local var_451_0 = {
			zh = 6.8,
			ja = 8.833
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play417232111(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["10128"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps10128 == nil then
				arg_451_1.var_.actorSpriteComps10128 = var_454_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.actorSpriteComps10128 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_454_1 then
							if arg_451_1.isInRecall_ then
								local var_454_4 = Mathf.Lerp(iter_454_1.color.r, arg_451_1.hightColor2.r, var_454_3)
								local var_454_5 = Mathf.Lerp(iter_454_1.color.g, arg_451_1.hightColor2.g, var_454_3)
								local var_454_6 = Mathf.Lerp(iter_454_1.color.b, arg_451_1.hightColor2.b, var_454_3)

								iter_454_1.color = Color.New(var_454_4, var_454_5, var_454_6)
							else
								local var_454_7 = Mathf.Lerp(iter_454_1.color.r, 0.5, var_454_3)

								iter_454_1.color = Color.New(var_454_7, var_454_7, var_454_7)
							end
						end
					end
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps10128 then
				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_454_3 then
						if arg_451_1.isInRecall_ then
							iter_454_3.color = arg_451_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_454_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_451_1.var_.actorSpriteComps10128 = nil
			end

			local var_454_8 = 0
			local var_454_9 = 0.925

			if var_454_8 < arg_451_1.time_ and arg_451_1.time_ <= var_454_8 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_10 = arg_451_1:FormatText(StoryNameCfg[1110].name)

				arg_451_1.leftNameTxt_.text = var_454_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_451_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_454_11 = arg_451_1:GetWordFromCfg(417232110)
				local var_454_12 = arg_451_1:FormatText(var_454_11.content)

				arg_451_1.text_.text = var_454_12

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_13 = 37
				local var_454_14 = utf8.len(var_454_12)
				local var_454_15 = var_454_13 <= 0 and var_454_9 or var_454_9 * (var_454_14 / var_454_13)

				if var_454_15 > 0 and var_454_9 < var_454_15 then
					arg_451_1.talkMaxDuration = var_454_15

					if var_454_15 + var_454_8 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_15 + var_454_8
					end
				end

				arg_451_1.text_.text = var_454_12
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232110", "story_v_out_417232.awb") ~= 0 then
					local var_454_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232110", "story_v_out_417232.awb") / 1000

					if var_454_16 + var_454_8 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_16 + var_454_8
					end

					if var_454_11.prefab_name ~= "" and arg_451_1.actors_[var_454_11.prefab_name] ~= nil then
						local var_454_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_11.prefab_name].transform, "story_v_out_417232", "417232110", "story_v_out_417232.awb")

						arg_451_1:RecordAudio("417232110", var_454_17)
						arg_451_1:RecordAudio("417232110", var_454_17)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_417232", "417232110", "story_v_out_417232.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_417232", "417232110", "story_v_out_417232.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_18 = math.max(var_454_9, arg_451_1.talkMaxDuration)

			if var_454_8 <= arg_451_1.time_ and arg_451_1.time_ < var_454_8 + var_454_18 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_8) / var_454_18

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_8 + var_454_18 and arg_451_1.time_ < var_454_8 + var_454_18 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play417232111 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 417232111
		arg_455_1.duration_ = 2.63

		local var_455_0 = {
			zh = 1.766,
			ja = 2.633
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play417232112(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["10128"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps10128 == nil then
				arg_455_1.var_.actorSpriteComps10128 = var_458_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_2 = 0.2

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.actorSpriteComps10128 then
					for iter_458_0, iter_458_1 in pairs(arg_455_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_458_1 then
							if arg_455_1.isInRecall_ then
								local var_458_4 = Mathf.Lerp(iter_458_1.color.r, arg_455_1.hightColor1.r, var_458_3)
								local var_458_5 = Mathf.Lerp(iter_458_1.color.g, arg_455_1.hightColor1.g, var_458_3)
								local var_458_6 = Mathf.Lerp(iter_458_1.color.b, arg_455_1.hightColor1.b, var_458_3)

								iter_458_1.color = Color.New(var_458_4, var_458_5, var_458_6)
							else
								local var_458_7 = Mathf.Lerp(iter_458_1.color.r, 1, var_458_3)

								iter_458_1.color = Color.New(var_458_7, var_458_7, var_458_7)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps10128 then
				for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_458_3 then
						if arg_455_1.isInRecall_ then
							iter_458_3.color = arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_458_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_455_1.var_.actorSpriteComps10128 = nil
			end

			local var_458_8 = 0
			local var_458_9 = 0.225

			if var_458_8 < arg_455_1.time_ and arg_455_1.time_ <= var_458_8 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_10 = arg_455_1:FormatText(StoryNameCfg[595].name)

				arg_455_1.leftNameTxt_.text = var_458_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_11 = arg_455_1:GetWordFromCfg(417232111)
				local var_458_12 = arg_455_1:FormatText(var_458_11.content)

				arg_455_1.text_.text = var_458_12

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_13 = 9
				local var_458_14 = utf8.len(var_458_12)
				local var_458_15 = var_458_13 <= 0 and var_458_9 or var_458_9 * (var_458_14 / var_458_13)

				if var_458_15 > 0 and var_458_9 < var_458_15 then
					arg_455_1.talkMaxDuration = var_458_15

					if var_458_15 + var_458_8 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_15 + var_458_8
					end
				end

				arg_455_1.text_.text = var_458_12
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232111", "story_v_out_417232.awb") ~= 0 then
					local var_458_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232111", "story_v_out_417232.awb") / 1000

					if var_458_16 + var_458_8 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_16 + var_458_8
					end

					if var_458_11.prefab_name ~= "" and arg_455_1.actors_[var_458_11.prefab_name] ~= nil then
						local var_458_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_11.prefab_name].transform, "story_v_out_417232", "417232111", "story_v_out_417232.awb")

						arg_455_1:RecordAudio("417232111", var_458_17)
						arg_455_1:RecordAudio("417232111", var_458_17)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_417232", "417232111", "story_v_out_417232.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_417232", "417232111", "story_v_out_417232.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_18 = math.max(var_458_9, arg_455_1.talkMaxDuration)

			if var_458_8 <= arg_455_1.time_ and arg_455_1.time_ < var_458_8 + var_458_18 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_8) / var_458_18

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_8 + var_458_18 and arg_455_1.time_ < var_458_8 + var_458_18 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play417232112 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 417232112
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play417232113(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["10128"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.actorSpriteComps10128 == nil then
				arg_459_1.var_.actorSpriteComps10128 = var_462_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_2 = 0.2

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.actorSpriteComps10128 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_462_1 then
							if arg_459_1.isInRecall_ then
								local var_462_4 = Mathf.Lerp(iter_462_1.color.r, arg_459_1.hightColor2.r, var_462_3)
								local var_462_5 = Mathf.Lerp(iter_462_1.color.g, arg_459_1.hightColor2.g, var_462_3)
								local var_462_6 = Mathf.Lerp(iter_462_1.color.b, arg_459_1.hightColor2.b, var_462_3)

								iter_462_1.color = Color.New(var_462_4, var_462_5, var_462_6)
							else
								local var_462_7 = Mathf.Lerp(iter_462_1.color.r, 0.5, var_462_3)

								iter_462_1.color = Color.New(var_462_7, var_462_7, var_462_7)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.actorSpriteComps10128 then
				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_462_3 then
						if arg_459_1.isInRecall_ then
							iter_462_3.color = arg_459_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_462_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_459_1.var_.actorSpriteComps10128 = nil
			end

			local var_462_8 = 0
			local var_462_9 = 1.325

			if var_462_8 < arg_459_1.time_ and arg_459_1.time_ <= var_462_8 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_10 = arg_459_1:GetWordFromCfg(417232112)
				local var_462_11 = arg_459_1:FormatText(var_462_10.content)

				arg_459_1.text_.text = var_462_11

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_12 = 53
				local var_462_13 = utf8.len(var_462_11)
				local var_462_14 = var_462_12 <= 0 and var_462_9 or var_462_9 * (var_462_13 / var_462_12)

				if var_462_14 > 0 and var_462_9 < var_462_14 then
					arg_459_1.talkMaxDuration = var_462_14

					if var_462_14 + var_462_8 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_14 + var_462_8
					end
				end

				arg_459_1.text_.text = var_462_11
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_15 = math.max(var_462_9, arg_459_1.talkMaxDuration)

			if var_462_8 <= arg_459_1.time_ and arg_459_1.time_ < var_462_8 + var_462_15 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_8) / var_462_15

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_8 + var_462_15 and arg_459_1.time_ < var_462_8 + var_462_15 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play417232113 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 417232113
		arg_463_1.duration_ = 7.93

		local var_463_0 = {
			zh = 5.666,
			ja = 7.933
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play417232114(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["10128"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.actorSpriteComps10128 == nil then
				arg_463_1.var_.actorSpriteComps10128 = var_466_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_2 = 0.2

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.actorSpriteComps10128 then
					for iter_466_0, iter_466_1 in pairs(arg_463_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_466_1 then
							if arg_463_1.isInRecall_ then
								local var_466_4 = Mathf.Lerp(iter_466_1.color.r, arg_463_1.hightColor1.r, var_466_3)
								local var_466_5 = Mathf.Lerp(iter_466_1.color.g, arg_463_1.hightColor1.g, var_466_3)
								local var_466_6 = Mathf.Lerp(iter_466_1.color.b, arg_463_1.hightColor1.b, var_466_3)

								iter_466_1.color = Color.New(var_466_4, var_466_5, var_466_6)
							else
								local var_466_7 = Mathf.Lerp(iter_466_1.color.r, 1, var_466_3)

								iter_466_1.color = Color.New(var_466_7, var_466_7, var_466_7)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.actorSpriteComps10128 then
				for iter_466_2, iter_466_3 in pairs(arg_463_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_466_3 then
						if arg_463_1.isInRecall_ then
							iter_466_3.color = arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_466_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_463_1.var_.actorSpriteComps10128 = nil
			end

			local var_466_8 = 0
			local var_466_9 = 0.6

			if var_466_8 < arg_463_1.time_ and arg_463_1.time_ <= var_466_8 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_10 = arg_463_1:FormatText(StoryNameCfg[595].name)

				arg_463_1.leftNameTxt_.text = var_466_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_11 = arg_463_1:GetWordFromCfg(417232113)
				local var_466_12 = arg_463_1:FormatText(var_466_11.content)

				arg_463_1.text_.text = var_466_12

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_13 = 24
				local var_466_14 = utf8.len(var_466_12)
				local var_466_15 = var_466_13 <= 0 and var_466_9 or var_466_9 * (var_466_14 / var_466_13)

				if var_466_15 > 0 and var_466_9 < var_466_15 then
					arg_463_1.talkMaxDuration = var_466_15

					if var_466_15 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_15 + var_466_8
					end
				end

				arg_463_1.text_.text = var_466_12
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232113", "story_v_out_417232.awb") ~= 0 then
					local var_466_16 = manager.audio:GetVoiceLength("story_v_out_417232", "417232113", "story_v_out_417232.awb") / 1000

					if var_466_16 + var_466_8 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_16 + var_466_8
					end

					if var_466_11.prefab_name ~= "" and arg_463_1.actors_[var_466_11.prefab_name] ~= nil then
						local var_466_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_11.prefab_name].transform, "story_v_out_417232", "417232113", "story_v_out_417232.awb")

						arg_463_1:RecordAudio("417232113", var_466_17)
						arg_463_1:RecordAudio("417232113", var_466_17)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_417232", "417232113", "story_v_out_417232.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_417232", "417232113", "story_v_out_417232.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_18 = math.max(var_466_9, arg_463_1.talkMaxDuration)

			if var_466_8 <= arg_463_1.time_ and arg_463_1.time_ < var_466_8 + var_466_18 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_8) / var_466_18

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_8 + var_466_18 and arg_463_1.time_ < var_466_8 + var_466_18 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play417232114 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 417232114
		arg_467_1.duration_ = 14.7

		local var_467_0 = {
			zh = 10.699999999999,
			ja = 14.699999999999
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play417232115(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 1

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				local var_470_1 = manager.ui.mainCamera.transform.localPosition
				local var_470_2 = Vector3.New(0, 0, 10) + Vector3.New(var_470_1.x, var_470_1.y, 0)
				local var_470_3 = arg_467_1.bgs_.ST69a

				var_470_3.transform.localPosition = var_470_2
				var_470_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_470_4 = var_470_3:GetComponent("SpriteRenderer")

				if var_470_4 and var_470_4.sprite then
					local var_470_5 = (var_470_3.transform.localPosition - var_470_1).z
					local var_470_6 = manager.ui.mainCameraCom_
					local var_470_7 = 2 * var_470_5 * Mathf.Tan(var_470_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_470_8 = var_470_7 * var_470_6.aspect
					local var_470_9 = var_470_4.sprite.bounds.size.x
					local var_470_10 = var_470_4.sprite.bounds.size.y
					local var_470_11 = var_470_8 / var_470_9
					local var_470_12 = var_470_7 / var_470_10
					local var_470_13 = var_470_12 < var_470_11 and var_470_11 or var_470_12

					var_470_3.transform.localScale = Vector3.New(var_470_13, var_470_13, 0)
				end

				for iter_470_0, iter_470_1 in pairs(arg_467_1.bgs_) do
					if iter_470_0 ~= "ST69a" then
						iter_470_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_470_14 = 2.999999999999

			if var_470_14 < arg_467_1.time_ and arg_467_1.time_ <= var_470_14 + arg_470_0 then
				arg_467_1.allBtn_.enabled = false
			end

			local var_470_15 = 0.533333333334333

			if arg_467_1.time_ >= var_470_14 + var_470_15 and arg_467_1.time_ < var_470_14 + var_470_15 + arg_470_0 then
				arg_467_1.allBtn_.enabled = true
			end

			local var_470_16 = 0

			if var_470_16 < arg_467_1.time_ and arg_467_1.time_ <= var_470_16 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_17 = 1

			if var_470_16 <= arg_467_1.time_ and arg_467_1.time_ < var_470_16 + var_470_17 then
				local var_470_18 = (arg_467_1.time_ - var_470_16) / var_470_17
				local var_470_19 = Color.New(0, 0, 0)

				var_470_19.a = Mathf.Lerp(0, 1, var_470_18)
				arg_467_1.mask_.color = var_470_19
			end

			if arg_467_1.time_ >= var_470_16 + var_470_17 and arg_467_1.time_ < var_470_16 + var_470_17 + arg_470_0 then
				local var_470_20 = Color.New(0, 0, 0)

				var_470_20.a = 1
				arg_467_1.mask_.color = var_470_20
			end

			local var_470_21 = 1

			if var_470_21 < arg_467_1.time_ and arg_467_1.time_ <= var_470_21 + arg_470_0 then
				arg_467_1.mask_.enabled = true
				arg_467_1.mask_.raycastTarget = true

				arg_467_1:SetGaussion(false)
			end

			local var_470_22 = 2

			if var_470_21 <= arg_467_1.time_ and arg_467_1.time_ < var_470_21 + var_470_22 then
				local var_470_23 = (arg_467_1.time_ - var_470_21) / var_470_22
				local var_470_24 = Color.New(0, 0, 0)

				var_470_24.a = Mathf.Lerp(1, 0, var_470_23)
				arg_467_1.mask_.color = var_470_24
			end

			if arg_467_1.time_ >= var_470_21 + var_470_22 and arg_467_1.time_ < var_470_21 + var_470_22 + arg_470_0 then
				local var_470_25 = Color.New(0, 0, 0)
				local var_470_26 = 0

				arg_467_1.mask_.enabled = false
				var_470_25.a = var_470_26
				arg_467_1.mask_.color = var_470_25
			end

			local var_470_27 = arg_467_1.actors_["10128"].transform
			local var_470_28 = 0.966666666666667

			if var_470_28 < arg_467_1.time_ and arg_467_1.time_ <= var_470_28 + arg_470_0 then
				arg_467_1.var_.moveOldPos10128 = var_470_27.localPosition
				var_470_27.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10128", 7)

				local var_470_29 = var_470_27.childCount

				for iter_470_2 = 0, var_470_29 - 1 do
					local var_470_30 = var_470_27:GetChild(iter_470_2)

					if var_470_30.name == "" or not string.find(var_470_30.name, "split") then
						var_470_30.gameObject:SetActive(true)
					else
						var_470_30.gameObject:SetActive(false)
					end
				end
			end

			local var_470_31 = 0.001

			if var_470_28 <= arg_467_1.time_ and arg_467_1.time_ < var_470_28 + var_470_31 then
				local var_470_32 = (arg_467_1.time_ - var_470_28) / var_470_31
				local var_470_33 = Vector3.New(0, -2000, -300)

				var_470_27.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10128, var_470_33, var_470_32)
			end

			if arg_467_1.time_ >= var_470_28 + var_470_31 and arg_467_1.time_ < var_470_28 + var_470_31 + arg_470_0 then
				var_470_27.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_470_34 = arg_467_1.actors_["10128"].transform
			local var_470_35 = 2.66666666666667

			if var_470_35 < arg_467_1.time_ and arg_467_1.time_ <= var_470_35 + arg_470_0 then
				arg_467_1.var_.moveOldPos10128 = var_470_34.localPosition
				var_470_34.localScale = Vector3.New(1, 1, 1)

				arg_467_1:CheckSpriteTmpPos("10128", 3)

				local var_470_36 = var_470_34.childCount

				for iter_470_3 = 0, var_470_36 - 1 do
					local var_470_37 = var_470_34:GetChild(iter_470_3)

					if var_470_37.name == "" or not string.find(var_470_37.name, "split") then
						var_470_37.gameObject:SetActive(true)
					else
						var_470_37.gameObject:SetActive(false)
					end
				end
			end

			local var_470_38 = 0.001

			if var_470_35 <= arg_467_1.time_ and arg_467_1.time_ < var_470_35 + var_470_38 then
				local var_470_39 = (arg_467_1.time_ - var_470_35) / var_470_38
				local var_470_40 = Vector3.New(0, -347, -300)

				var_470_34.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10128, var_470_40, var_470_39)
			end

			if arg_467_1.time_ >= var_470_35 + var_470_38 and arg_467_1.time_ < var_470_35 + var_470_38 + arg_470_0 then
				var_470_34.localPosition = Vector3.New(0, -347, -300)
			end

			local var_470_41 = arg_467_1.actors_["10128"]
			local var_470_42 = 2.66666666666667

			if var_470_42 < arg_467_1.time_ and arg_467_1.time_ <= var_470_42 + arg_470_0 then
				local var_470_43 = var_470_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_470_43 then
					arg_467_1.var_.alphaOldValue10128 = var_470_43.alpha
					arg_467_1.var_.characterEffect10128 = var_470_43
				end

				arg_467_1.var_.alphaOldValue10128 = 0
			end

			local var_470_44 = 0.333333333333333

			if var_470_42 <= arg_467_1.time_ and arg_467_1.time_ < var_470_42 + var_470_44 then
				local var_470_45 = (arg_467_1.time_ - var_470_42) / var_470_44
				local var_470_46 = Mathf.Lerp(arg_467_1.var_.alphaOldValue10128, 1, var_470_45)

				if arg_467_1.var_.characterEffect10128 then
					arg_467_1.var_.characterEffect10128.alpha = var_470_46
				end
			end

			if arg_467_1.time_ >= var_470_42 + var_470_44 and arg_467_1.time_ < var_470_42 + var_470_44 + arg_470_0 and arg_467_1.var_.characterEffect10128 then
				arg_467_1.var_.characterEffect10128.alpha = 1
			end

			local var_470_47 = arg_467_1.actors_["10128"]
			local var_470_48 = 2.66666666666667

			if var_470_48 < arg_467_1.time_ and arg_467_1.time_ <= var_470_48 + arg_470_0 and not isNil(var_470_47) and arg_467_1.var_.actorSpriteComps10128 == nil then
				arg_467_1.var_.actorSpriteComps10128 = var_470_47:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_49 = 0.2

			if var_470_48 <= arg_467_1.time_ and arg_467_1.time_ < var_470_48 + var_470_49 and not isNil(var_470_47) then
				local var_470_50 = (arg_467_1.time_ - var_470_48) / var_470_49

				if arg_467_1.var_.actorSpriteComps10128 then
					for iter_470_4, iter_470_5 in pairs(arg_467_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_470_5 then
							if arg_467_1.isInRecall_ then
								local var_470_51 = Mathf.Lerp(iter_470_5.color.r, arg_467_1.hightColor1.r, var_470_50)
								local var_470_52 = Mathf.Lerp(iter_470_5.color.g, arg_467_1.hightColor1.g, var_470_50)
								local var_470_53 = Mathf.Lerp(iter_470_5.color.b, arg_467_1.hightColor1.b, var_470_50)

								iter_470_5.color = Color.New(var_470_51, var_470_52, var_470_53)
							else
								local var_470_54 = Mathf.Lerp(iter_470_5.color.r, 1, var_470_50)

								iter_470_5.color = Color.New(var_470_54, var_470_54, var_470_54)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= var_470_48 + var_470_49 and arg_467_1.time_ < var_470_48 + var_470_49 + arg_470_0 and not isNil(var_470_47) and arg_467_1.var_.actorSpriteComps10128 then
				for iter_470_6, iter_470_7 in pairs(arg_467_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_470_7 then
						if arg_467_1.isInRecall_ then
							iter_470_7.color = arg_467_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_470_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_467_1.var_.actorSpriteComps10128 = nil
			end

			local var_470_55 = 0.966666666666667

			arg_467_1.isInRecall_ = false

			if var_470_55 < arg_467_1.time_ and arg_467_1.time_ <= var_470_55 + arg_470_0 then
				arg_467_1.screenFilterGo_:SetActive(false)

				for iter_470_8, iter_470_9 in pairs(arg_467_1.actors_) do
					local var_470_56 = iter_470_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_470_10, iter_470_11 in ipairs(var_470_56) do
						if iter_470_11.color.r > 0.51 then
							iter_470_11.color = Color.New(1, 1, 1)
						else
							iter_470_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_470_57 = 0.0339999999999999

			if var_470_55 <= arg_467_1.time_ and arg_467_1.time_ < var_470_55 + var_470_57 then
				local var_470_58 = (arg_467_1.time_ - var_470_55) / var_470_57

				arg_467_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_470_58)
			end

			if arg_467_1.time_ >= var_470_55 + var_470_57 and arg_467_1.time_ < var_470_55 + var_470_57 + arg_470_0 then
				arg_467_1.screenFilterEffect_.weight = 0
			end

			if arg_467_1.frameCnt_ <= 1 then
				arg_467_1.dialog_:SetActive(false)
			end

			local var_470_59 = 2.999999999999
			local var_470_60 = 1.075

			if var_470_59 < arg_467_1.time_ and arg_467_1.time_ <= var_470_59 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				arg_467_1.dialog_:SetActive(true)

				arg_467_1.dialogCg_.alpha = 0

				local var_470_61 = LeanTween.value(arg_467_1.dialog_, 0, 1, 0.3)

				var_470_61:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_467_1.dialogCg_.alpha = arg_471_0
				end))
				var_470_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_467_1.dialog_)
					var_470_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_467_1.duration_ = arg_467_1.duration_ + 0.3

				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_62 = arg_467_1:FormatText(StoryNameCfg[595].name)

				arg_467_1.leftNameTxt_.text = var_470_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_63 = arg_467_1:GetWordFromCfg(417232114)
				local var_470_64 = arg_467_1:FormatText(var_470_63.content)

				arg_467_1.text_.text = var_470_64

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_65 = 43
				local var_470_66 = utf8.len(var_470_64)
				local var_470_67 = var_470_65 <= 0 and var_470_60 or var_470_60 * (var_470_66 / var_470_65)

				if var_470_67 > 0 and var_470_60 < var_470_67 then
					arg_467_1.talkMaxDuration = var_470_67
					var_470_59 = var_470_59 + 0.3

					if var_470_67 + var_470_59 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_67 + var_470_59
					end
				end

				arg_467_1.text_.text = var_470_64
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232114", "story_v_out_417232.awb") ~= 0 then
					local var_470_68 = manager.audio:GetVoiceLength("story_v_out_417232", "417232114", "story_v_out_417232.awb") / 1000

					if var_470_68 + var_470_59 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_68 + var_470_59
					end

					if var_470_63.prefab_name ~= "" and arg_467_1.actors_[var_470_63.prefab_name] ~= nil then
						local var_470_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_63.prefab_name].transform, "story_v_out_417232", "417232114", "story_v_out_417232.awb")

						arg_467_1:RecordAudio("417232114", var_470_69)
						arg_467_1:RecordAudio("417232114", var_470_69)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_417232", "417232114", "story_v_out_417232.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_417232", "417232114", "story_v_out_417232.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_70 = var_470_59 + 0.3
			local var_470_71 = math.max(var_470_60, arg_467_1.talkMaxDuration)

			if var_470_70 <= arg_467_1.time_ and arg_467_1.time_ < var_470_70 + var_470_71 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_70) / var_470_71

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_70 + var_470_71 and arg_467_1.time_ < var_470_70 + var_470_71 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play417232115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 417232115
		arg_473_1.duration_ = 11.67

		local var_473_0 = {
			zh = 8.9,
			ja = 11.666
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play417232116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.975

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[595].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_3 = arg_473_1:GetWordFromCfg(417232115)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 39
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232115", "story_v_out_417232.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232115", "story_v_out_417232.awb") / 1000

					if var_476_8 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_0
					end

					if var_476_3.prefab_name ~= "" and arg_473_1.actors_[var_476_3.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_3.prefab_name].transform, "story_v_out_417232", "417232115", "story_v_out_417232.awb")

						arg_473_1:RecordAudio("417232115", var_476_9)
						arg_473_1:RecordAudio("417232115", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_417232", "417232115", "story_v_out_417232.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_417232", "417232115", "story_v_out_417232.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_10 and arg_473_1.time_ < var_476_0 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play417232116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 417232116
		arg_477_1.duration_ = 2.67

		local var_477_0 = {
			zh = 1.233,
			ja = 2.666
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play417232117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["10111"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10111 == nil then
				arg_477_1.var_.actorSpriteComps10111 = var_480_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.actorSpriteComps10111 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_480_1 then
							if arg_477_1.isInRecall_ then
								local var_480_4 = Mathf.Lerp(iter_480_1.color.r, arg_477_1.hightColor1.r, var_480_3)
								local var_480_5 = Mathf.Lerp(iter_480_1.color.g, arg_477_1.hightColor1.g, var_480_3)
								local var_480_6 = Mathf.Lerp(iter_480_1.color.b, arg_477_1.hightColor1.b, var_480_3)

								iter_480_1.color = Color.New(var_480_4, var_480_5, var_480_6)
							else
								local var_480_7 = Mathf.Lerp(iter_480_1.color.r, 1, var_480_3)

								iter_480_1.color = Color.New(var_480_7, var_480_7, var_480_7)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.actorSpriteComps10111 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_480_3 then
						if arg_477_1.isInRecall_ then
							iter_480_3.color = arg_477_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_480_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_477_1.var_.actorSpriteComps10111 = nil
			end

			local var_480_8 = arg_477_1.actors_["10128"]
			local var_480_9 = 0

			if var_480_9 < arg_477_1.time_ and arg_477_1.time_ <= var_480_9 + arg_480_0 and not isNil(var_480_8) and arg_477_1.var_.actorSpriteComps10128 == nil then
				arg_477_1.var_.actorSpriteComps10128 = var_480_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_10 = 0.2

			if var_480_9 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_10 and not isNil(var_480_8) then
				local var_480_11 = (arg_477_1.time_ - var_480_9) / var_480_10

				if arg_477_1.var_.actorSpriteComps10128 then
					for iter_480_4, iter_480_5 in pairs(arg_477_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_480_5 then
							if arg_477_1.isInRecall_ then
								local var_480_12 = Mathf.Lerp(iter_480_5.color.r, arg_477_1.hightColor2.r, var_480_11)
								local var_480_13 = Mathf.Lerp(iter_480_5.color.g, arg_477_1.hightColor2.g, var_480_11)
								local var_480_14 = Mathf.Lerp(iter_480_5.color.b, arg_477_1.hightColor2.b, var_480_11)

								iter_480_5.color = Color.New(var_480_12, var_480_13, var_480_14)
							else
								local var_480_15 = Mathf.Lerp(iter_480_5.color.r, 0.5, var_480_11)

								iter_480_5.color = Color.New(var_480_15, var_480_15, var_480_15)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= var_480_9 + var_480_10 and arg_477_1.time_ < var_480_9 + var_480_10 + arg_480_0 and not isNil(var_480_8) and arg_477_1.var_.actorSpriteComps10128 then
				for iter_480_6, iter_480_7 in pairs(arg_477_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_480_7 then
						if arg_477_1.isInRecall_ then
							iter_480_7.color = arg_477_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_480_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_477_1.var_.actorSpriteComps10128 = nil
			end

			local var_480_16 = arg_477_1.actors_["10111"].transform
			local var_480_17 = 0

			if var_480_17 < arg_477_1.time_ and arg_477_1.time_ <= var_480_17 + arg_480_0 then
				arg_477_1.var_.moveOldPos10111 = var_480_16.localPosition
				var_480_16.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10111", 3)

				local var_480_18 = var_480_16.childCount

				for iter_480_8 = 0, var_480_18 - 1 do
					local var_480_19 = var_480_16:GetChild(iter_480_8)

					if var_480_19.name == "" or not string.find(var_480_19.name, "split") then
						var_480_19.gameObject:SetActive(true)
					else
						var_480_19.gameObject:SetActive(false)
					end
				end
			end

			local var_480_20 = 0.001

			if var_480_17 <= arg_477_1.time_ and arg_477_1.time_ < var_480_17 + var_480_20 then
				local var_480_21 = (arg_477_1.time_ - var_480_17) / var_480_20
				local var_480_22 = Vector3.New(0, -361.1, -274.6)

				var_480_16.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10111, var_480_22, var_480_21)
			end

			if arg_477_1.time_ >= var_480_17 + var_480_20 and arg_477_1.time_ < var_480_17 + var_480_20 + arg_480_0 then
				var_480_16.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_480_23 = arg_477_1.actors_["10128"].transform
			local var_480_24 = 0

			if var_480_24 < arg_477_1.time_ and arg_477_1.time_ <= var_480_24 + arg_480_0 then
				arg_477_1.var_.moveOldPos10128 = var_480_23.localPosition
				var_480_23.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10128", 7)

				local var_480_25 = var_480_23.childCount

				for iter_480_9 = 0, var_480_25 - 1 do
					local var_480_26 = var_480_23:GetChild(iter_480_9)

					if var_480_26.name == "" or not string.find(var_480_26.name, "split") then
						var_480_26.gameObject:SetActive(true)
					else
						var_480_26.gameObject:SetActive(false)
					end
				end
			end

			local var_480_27 = 0.001

			if var_480_24 <= arg_477_1.time_ and arg_477_1.time_ < var_480_24 + var_480_27 then
				local var_480_28 = (arg_477_1.time_ - var_480_24) / var_480_27
				local var_480_29 = Vector3.New(0, -2000, -300)

				var_480_23.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10128, var_480_29, var_480_28)
			end

			if arg_477_1.time_ >= var_480_24 + var_480_27 and arg_477_1.time_ < var_480_24 + var_480_27 + arg_480_0 then
				var_480_23.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_480_30 = 0
			local var_480_31 = 0.125

			if var_480_30 < arg_477_1.time_ and arg_477_1.time_ <= var_480_30 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_32 = arg_477_1:FormatText(StoryNameCfg[1125].name)

				arg_477_1.leftNameTxt_.text = var_480_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_33 = arg_477_1:GetWordFromCfg(417232116)
				local var_480_34 = arg_477_1:FormatText(var_480_33.content)

				arg_477_1.text_.text = var_480_34

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_35 = 5
				local var_480_36 = utf8.len(var_480_34)
				local var_480_37 = var_480_35 <= 0 and var_480_31 or var_480_31 * (var_480_36 / var_480_35)

				if var_480_37 > 0 and var_480_31 < var_480_37 then
					arg_477_1.talkMaxDuration = var_480_37

					if var_480_37 + var_480_30 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_37 + var_480_30
					end
				end

				arg_477_1.text_.text = var_480_34
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232116", "story_v_out_417232.awb") ~= 0 then
					local var_480_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232116", "story_v_out_417232.awb") / 1000

					if var_480_38 + var_480_30 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_38 + var_480_30
					end

					if var_480_33.prefab_name ~= "" and arg_477_1.actors_[var_480_33.prefab_name] ~= nil then
						local var_480_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_33.prefab_name].transform, "story_v_out_417232", "417232116", "story_v_out_417232.awb")

						arg_477_1:RecordAudio("417232116", var_480_39)
						arg_477_1:RecordAudio("417232116", var_480_39)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_417232", "417232116", "story_v_out_417232.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_417232", "417232116", "story_v_out_417232.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_40 = math.max(var_480_31, arg_477_1.talkMaxDuration)

			if var_480_30 <= arg_477_1.time_ and arg_477_1.time_ < var_480_30 + var_480_40 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_30) / var_480_40

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_30 + var_480_40 and arg_477_1.time_ < var_480_30 + var_480_40 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play417232117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 417232117
		arg_481_1.duration_ = 5.7

		local var_481_0 = {
			zh = 4.933,
			ja = 5.7
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play417232118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["10128"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.actorSpriteComps10128 == nil then
				arg_481_1.var_.actorSpriteComps10128 = var_484_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_2 = 0.2

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.actorSpriteComps10128 then
					for iter_484_0, iter_484_1 in pairs(arg_481_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_484_1 then
							if arg_481_1.isInRecall_ then
								local var_484_4 = Mathf.Lerp(iter_484_1.color.r, arg_481_1.hightColor1.r, var_484_3)
								local var_484_5 = Mathf.Lerp(iter_484_1.color.g, arg_481_1.hightColor1.g, var_484_3)
								local var_484_6 = Mathf.Lerp(iter_484_1.color.b, arg_481_1.hightColor1.b, var_484_3)

								iter_484_1.color = Color.New(var_484_4, var_484_5, var_484_6)
							else
								local var_484_7 = Mathf.Lerp(iter_484_1.color.r, 1, var_484_3)

								iter_484_1.color = Color.New(var_484_7, var_484_7, var_484_7)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.actorSpriteComps10128 then
				for iter_484_2, iter_484_3 in pairs(arg_481_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_484_3 then
						if arg_481_1.isInRecall_ then
							iter_484_3.color = arg_481_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_484_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_481_1.var_.actorSpriteComps10128 = nil
			end

			local var_484_8 = arg_481_1.actors_["10111"]
			local var_484_9 = 0

			if var_484_9 < arg_481_1.time_ and arg_481_1.time_ <= var_484_9 + arg_484_0 and not isNil(var_484_8) and arg_481_1.var_.actorSpriteComps10111 == nil then
				arg_481_1.var_.actorSpriteComps10111 = var_484_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_10 = 0.2

			if var_484_9 <= arg_481_1.time_ and arg_481_1.time_ < var_484_9 + var_484_10 and not isNil(var_484_8) then
				local var_484_11 = (arg_481_1.time_ - var_484_9) / var_484_10

				if arg_481_1.var_.actorSpriteComps10111 then
					for iter_484_4, iter_484_5 in pairs(arg_481_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_484_5 then
							if arg_481_1.isInRecall_ then
								local var_484_12 = Mathf.Lerp(iter_484_5.color.r, arg_481_1.hightColor2.r, var_484_11)
								local var_484_13 = Mathf.Lerp(iter_484_5.color.g, arg_481_1.hightColor2.g, var_484_11)
								local var_484_14 = Mathf.Lerp(iter_484_5.color.b, arg_481_1.hightColor2.b, var_484_11)

								iter_484_5.color = Color.New(var_484_12, var_484_13, var_484_14)
							else
								local var_484_15 = Mathf.Lerp(iter_484_5.color.r, 0.5, var_484_11)

								iter_484_5.color = Color.New(var_484_15, var_484_15, var_484_15)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= var_484_9 + var_484_10 and arg_481_1.time_ < var_484_9 + var_484_10 + arg_484_0 and not isNil(var_484_8) and arg_481_1.var_.actorSpriteComps10111 then
				for iter_484_6, iter_484_7 in pairs(arg_481_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_484_7 then
						if arg_481_1.isInRecall_ then
							iter_484_7.color = arg_481_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_484_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_481_1.var_.actorSpriteComps10111 = nil
			end

			local var_484_16 = arg_481_1.actors_["10111"].transform
			local var_484_17 = 0

			if var_484_17 < arg_481_1.time_ and arg_481_1.time_ <= var_484_17 + arg_484_0 then
				arg_481_1.var_.moveOldPos10111 = var_484_16.localPosition
				var_484_16.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10111", 2)

				local var_484_18 = var_484_16.childCount

				for iter_484_8 = 0, var_484_18 - 1 do
					local var_484_19 = var_484_16:GetChild(iter_484_8)

					if var_484_19.name == "" or not string.find(var_484_19.name, "split") then
						var_484_19.gameObject:SetActive(true)
					else
						var_484_19.gameObject:SetActive(false)
					end
				end
			end

			local var_484_20 = 0.001

			if var_484_17 <= arg_481_1.time_ and arg_481_1.time_ < var_484_17 + var_484_20 then
				local var_484_21 = (arg_481_1.time_ - var_484_17) / var_484_20
				local var_484_22 = Vector3.New(-390, -361.1, -274.6)

				var_484_16.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10111, var_484_22, var_484_21)
			end

			if arg_481_1.time_ >= var_484_17 + var_484_20 and arg_481_1.time_ < var_484_17 + var_484_20 + arg_484_0 then
				var_484_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_484_23 = arg_481_1.actors_["10128"].transform
			local var_484_24 = 0

			if var_484_24 < arg_481_1.time_ and arg_481_1.time_ <= var_484_24 + arg_484_0 then
				arg_481_1.var_.moveOldPos10128 = var_484_23.localPosition
				var_484_23.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10128", 4)

				local var_484_25 = var_484_23.childCount

				for iter_484_9 = 0, var_484_25 - 1 do
					local var_484_26 = var_484_23:GetChild(iter_484_9)

					if var_484_26.name == "" or not string.find(var_484_26.name, "split") then
						var_484_26.gameObject:SetActive(true)
					else
						var_484_26.gameObject:SetActive(false)
					end
				end
			end

			local var_484_27 = 0.001

			if var_484_24 <= arg_481_1.time_ and arg_481_1.time_ < var_484_24 + var_484_27 then
				local var_484_28 = (arg_481_1.time_ - var_484_24) / var_484_27
				local var_484_29 = Vector3.New(390, -347, -300)

				var_484_23.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10128, var_484_29, var_484_28)
			end

			if arg_481_1.time_ >= var_484_24 + var_484_27 and arg_481_1.time_ < var_484_24 + var_484_27 + arg_484_0 then
				var_484_23.localPosition = Vector3.New(390, -347, -300)
			end

			local var_484_30 = 0
			local var_484_31 = 0.475

			if var_484_30 < arg_481_1.time_ and arg_481_1.time_ <= var_484_30 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_32 = arg_481_1:FormatText(StoryNameCfg[595].name)

				arg_481_1.leftNameTxt_.text = var_484_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_33 = arg_481_1:GetWordFromCfg(417232117)
				local var_484_34 = arg_481_1:FormatText(var_484_33.content)

				arg_481_1.text_.text = var_484_34

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_35 = 19
				local var_484_36 = utf8.len(var_484_34)
				local var_484_37 = var_484_35 <= 0 and var_484_31 or var_484_31 * (var_484_36 / var_484_35)

				if var_484_37 > 0 and var_484_31 < var_484_37 then
					arg_481_1.talkMaxDuration = var_484_37

					if var_484_37 + var_484_30 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_37 + var_484_30
					end
				end

				arg_481_1.text_.text = var_484_34
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232117", "story_v_out_417232.awb") ~= 0 then
					local var_484_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232117", "story_v_out_417232.awb") / 1000

					if var_484_38 + var_484_30 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_38 + var_484_30
					end

					if var_484_33.prefab_name ~= "" and arg_481_1.actors_[var_484_33.prefab_name] ~= nil then
						local var_484_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_33.prefab_name].transform, "story_v_out_417232", "417232117", "story_v_out_417232.awb")

						arg_481_1:RecordAudio("417232117", var_484_39)
						arg_481_1:RecordAudio("417232117", var_484_39)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_417232", "417232117", "story_v_out_417232.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_417232", "417232117", "story_v_out_417232.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_40 = math.max(var_484_31, arg_481_1.talkMaxDuration)

			if var_484_30 <= arg_481_1.time_ and arg_481_1.time_ < var_484_30 + var_484_40 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_30) / var_484_40

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_30 + var_484_40 and arg_481_1.time_ < var_484_30 + var_484_40 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play417232118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 417232118
		arg_485_1.duration_ = 5.23

		local var_485_0 = {
			zh = 3.166,
			ja = 5.233
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play417232119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["10111"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.actorSpriteComps10111 == nil then
				arg_485_1.var_.actorSpriteComps10111 = var_488_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_488_2 = 0.2

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.actorSpriteComps10111 then
					for iter_488_0, iter_488_1 in pairs(arg_485_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_488_1 then
							if arg_485_1.isInRecall_ then
								local var_488_4 = Mathf.Lerp(iter_488_1.color.r, arg_485_1.hightColor1.r, var_488_3)
								local var_488_5 = Mathf.Lerp(iter_488_1.color.g, arg_485_1.hightColor1.g, var_488_3)
								local var_488_6 = Mathf.Lerp(iter_488_1.color.b, arg_485_1.hightColor1.b, var_488_3)

								iter_488_1.color = Color.New(var_488_4, var_488_5, var_488_6)
							else
								local var_488_7 = Mathf.Lerp(iter_488_1.color.r, 1, var_488_3)

								iter_488_1.color = Color.New(var_488_7, var_488_7, var_488_7)
							end
						end
					end
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.actorSpriteComps10111 then
				for iter_488_2, iter_488_3 in pairs(arg_485_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_488_3 then
						if arg_485_1.isInRecall_ then
							iter_488_3.color = arg_485_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_488_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_485_1.var_.actorSpriteComps10111 = nil
			end

			local var_488_8 = arg_485_1.actors_["10128"]
			local var_488_9 = 0

			if var_488_9 < arg_485_1.time_ and arg_485_1.time_ <= var_488_9 + arg_488_0 and not isNil(var_488_8) and arg_485_1.var_.actorSpriteComps10128 == nil then
				arg_485_1.var_.actorSpriteComps10128 = var_488_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_488_10 = 0.2

			if var_488_9 <= arg_485_1.time_ and arg_485_1.time_ < var_488_9 + var_488_10 and not isNil(var_488_8) then
				local var_488_11 = (arg_485_1.time_ - var_488_9) / var_488_10

				if arg_485_1.var_.actorSpriteComps10128 then
					for iter_488_4, iter_488_5 in pairs(arg_485_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_488_5 then
							if arg_485_1.isInRecall_ then
								local var_488_12 = Mathf.Lerp(iter_488_5.color.r, arg_485_1.hightColor2.r, var_488_11)
								local var_488_13 = Mathf.Lerp(iter_488_5.color.g, arg_485_1.hightColor2.g, var_488_11)
								local var_488_14 = Mathf.Lerp(iter_488_5.color.b, arg_485_1.hightColor2.b, var_488_11)

								iter_488_5.color = Color.New(var_488_12, var_488_13, var_488_14)
							else
								local var_488_15 = Mathf.Lerp(iter_488_5.color.r, 0.5, var_488_11)

								iter_488_5.color = Color.New(var_488_15, var_488_15, var_488_15)
							end
						end
					end
				end
			end

			if arg_485_1.time_ >= var_488_9 + var_488_10 and arg_485_1.time_ < var_488_9 + var_488_10 + arg_488_0 and not isNil(var_488_8) and arg_485_1.var_.actorSpriteComps10128 then
				for iter_488_6, iter_488_7 in pairs(arg_485_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_488_7 then
						if arg_485_1.isInRecall_ then
							iter_488_7.color = arg_485_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_488_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_485_1.var_.actorSpriteComps10128 = nil
			end

			local var_488_16 = 0
			local var_488_17 = 0.4

			if var_488_16 < arg_485_1.time_ and arg_485_1.time_ <= var_488_16 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_18 = arg_485_1:FormatText(StoryNameCfg[1125].name)

				arg_485_1.leftNameTxt_.text = var_488_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_19 = arg_485_1:GetWordFromCfg(417232118)
				local var_488_20 = arg_485_1:FormatText(var_488_19.content)

				arg_485_1.text_.text = var_488_20

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_21 = 16
				local var_488_22 = utf8.len(var_488_20)
				local var_488_23 = var_488_21 <= 0 and var_488_17 or var_488_17 * (var_488_22 / var_488_21)

				if var_488_23 > 0 and var_488_17 < var_488_23 then
					arg_485_1.talkMaxDuration = var_488_23

					if var_488_23 + var_488_16 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_23 + var_488_16
					end
				end

				arg_485_1.text_.text = var_488_20
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232118", "story_v_out_417232.awb") ~= 0 then
					local var_488_24 = manager.audio:GetVoiceLength("story_v_out_417232", "417232118", "story_v_out_417232.awb") / 1000

					if var_488_24 + var_488_16 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_24 + var_488_16
					end

					if var_488_19.prefab_name ~= "" and arg_485_1.actors_[var_488_19.prefab_name] ~= nil then
						local var_488_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_19.prefab_name].transform, "story_v_out_417232", "417232118", "story_v_out_417232.awb")

						arg_485_1:RecordAudio("417232118", var_488_25)
						arg_485_1:RecordAudio("417232118", var_488_25)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_417232", "417232118", "story_v_out_417232.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_417232", "417232118", "story_v_out_417232.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_26 = math.max(var_488_17, arg_485_1.talkMaxDuration)

			if var_488_16 <= arg_485_1.time_ and arg_485_1.time_ < var_488_16 + var_488_26 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_16) / var_488_26

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_16 + var_488_26 and arg_485_1.time_ < var_488_16 + var_488_26 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play417232119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 417232119
		arg_489_1.duration_ = 5.03

		local var_489_0 = {
			zh = 2.033,
			ja = 5.033
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play417232120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1034"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.actorSpriteComps1034 == nil then
				arg_489_1.var_.actorSpriteComps1034 = var_492_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_2 = 0.2

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.actorSpriteComps1034 then
					for iter_492_0, iter_492_1 in pairs(arg_489_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_492_1 then
							if arg_489_1.isInRecall_ then
								local var_492_4 = Mathf.Lerp(iter_492_1.color.r, arg_489_1.hightColor1.r, var_492_3)
								local var_492_5 = Mathf.Lerp(iter_492_1.color.g, arg_489_1.hightColor1.g, var_492_3)
								local var_492_6 = Mathf.Lerp(iter_492_1.color.b, arg_489_1.hightColor1.b, var_492_3)

								iter_492_1.color = Color.New(var_492_4, var_492_5, var_492_6)
							else
								local var_492_7 = Mathf.Lerp(iter_492_1.color.r, 1, var_492_3)

								iter_492_1.color = Color.New(var_492_7, var_492_7, var_492_7)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.actorSpriteComps1034 then
				for iter_492_2, iter_492_3 in pairs(arg_489_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_492_3 then
						if arg_489_1.isInRecall_ then
							iter_492_3.color = arg_489_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_492_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_489_1.var_.actorSpriteComps1034 = nil
			end

			local var_492_8 = arg_489_1.actors_["10111"]
			local var_492_9 = 0

			if var_492_9 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 and not isNil(var_492_8) and arg_489_1.var_.actorSpriteComps10111 == nil then
				arg_489_1.var_.actorSpriteComps10111 = var_492_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_10 = 0.2

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_10 and not isNil(var_492_8) then
				local var_492_11 = (arg_489_1.time_ - var_492_9) / var_492_10

				if arg_489_1.var_.actorSpriteComps10111 then
					for iter_492_4, iter_492_5 in pairs(arg_489_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_492_5 then
							if arg_489_1.isInRecall_ then
								local var_492_12 = Mathf.Lerp(iter_492_5.color.r, arg_489_1.hightColor2.r, var_492_11)
								local var_492_13 = Mathf.Lerp(iter_492_5.color.g, arg_489_1.hightColor2.g, var_492_11)
								local var_492_14 = Mathf.Lerp(iter_492_5.color.b, arg_489_1.hightColor2.b, var_492_11)

								iter_492_5.color = Color.New(var_492_12, var_492_13, var_492_14)
							else
								local var_492_15 = Mathf.Lerp(iter_492_5.color.r, 0.5, var_492_11)

								iter_492_5.color = Color.New(var_492_15, var_492_15, var_492_15)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= var_492_9 + var_492_10 and arg_489_1.time_ < var_492_9 + var_492_10 + arg_492_0 and not isNil(var_492_8) and arg_489_1.var_.actorSpriteComps10111 then
				for iter_492_6, iter_492_7 in pairs(arg_489_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_492_7 then
						if arg_489_1.isInRecall_ then
							iter_492_7.color = arg_489_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_492_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_489_1.var_.actorSpriteComps10111 = nil
			end

			local var_492_16 = arg_489_1.actors_["10128"].transform
			local var_492_17 = 0

			if var_492_17 < arg_489_1.time_ and arg_489_1.time_ <= var_492_17 + arg_492_0 then
				arg_489_1.var_.moveOldPos10128 = var_492_16.localPosition
				var_492_16.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10128", 7)

				local var_492_18 = var_492_16.childCount

				for iter_492_8 = 0, var_492_18 - 1 do
					local var_492_19 = var_492_16:GetChild(iter_492_8)

					if var_492_19.name == "" or not string.find(var_492_19.name, "split") then
						var_492_19.gameObject:SetActive(true)
					else
						var_492_19.gameObject:SetActive(false)
					end
				end
			end

			local var_492_20 = 0.001

			if var_492_17 <= arg_489_1.time_ and arg_489_1.time_ < var_492_17 + var_492_20 then
				local var_492_21 = (arg_489_1.time_ - var_492_17) / var_492_20
				local var_492_22 = Vector3.New(0, -2000, -300)

				var_492_16.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10128, var_492_22, var_492_21)
			end

			if arg_489_1.time_ >= var_492_17 + var_492_20 and arg_489_1.time_ < var_492_17 + var_492_20 + arg_492_0 then
				var_492_16.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_492_23 = arg_489_1.actors_["1034"].transform
			local var_492_24 = 0

			if var_492_24 < arg_489_1.time_ and arg_489_1.time_ <= var_492_24 + arg_492_0 then
				arg_489_1.var_.moveOldPos1034 = var_492_23.localPosition
				var_492_23.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("1034", 4)

				local var_492_25 = var_492_23.childCount

				for iter_492_9 = 0, var_492_25 - 1 do
					local var_492_26 = var_492_23:GetChild(iter_492_9)

					if var_492_26.name == "split_5" or not string.find(var_492_26.name, "split") then
						var_492_26.gameObject:SetActive(true)
					else
						var_492_26.gameObject:SetActive(false)
					end
				end
			end

			local var_492_27 = 0.001

			if var_492_24 <= arg_489_1.time_ and arg_489_1.time_ < var_492_24 + var_492_27 then
				local var_492_28 = (arg_489_1.time_ - var_492_24) / var_492_27
				local var_492_29 = Vector3.New(373.7, -331.9, -324)

				var_492_23.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1034, var_492_29, var_492_28)
			end

			if arg_489_1.time_ >= var_492_24 + var_492_27 and arg_489_1.time_ < var_492_24 + var_492_27 + arg_492_0 then
				var_492_23.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_492_30 = 0
			local var_492_31 = 0.25

			if var_492_30 < arg_489_1.time_ and arg_489_1.time_ <= var_492_30 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_32 = arg_489_1:FormatText(StoryNameCfg[1109].name)

				arg_489_1.leftNameTxt_.text = var_492_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_33 = arg_489_1:GetWordFromCfg(417232119)
				local var_492_34 = arg_489_1:FormatText(var_492_33.content)

				arg_489_1.text_.text = var_492_34

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_35 = 10
				local var_492_36 = utf8.len(var_492_34)
				local var_492_37 = var_492_35 <= 0 and var_492_31 or var_492_31 * (var_492_36 / var_492_35)

				if var_492_37 > 0 and var_492_31 < var_492_37 then
					arg_489_1.talkMaxDuration = var_492_37

					if var_492_37 + var_492_30 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_37 + var_492_30
					end
				end

				arg_489_1.text_.text = var_492_34
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232119", "story_v_out_417232.awb") ~= 0 then
					local var_492_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232119", "story_v_out_417232.awb") / 1000

					if var_492_38 + var_492_30 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_38 + var_492_30
					end

					if var_492_33.prefab_name ~= "" and arg_489_1.actors_[var_492_33.prefab_name] ~= nil then
						local var_492_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_33.prefab_name].transform, "story_v_out_417232", "417232119", "story_v_out_417232.awb")

						arg_489_1:RecordAudio("417232119", var_492_39)
						arg_489_1:RecordAudio("417232119", var_492_39)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_417232", "417232119", "story_v_out_417232.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_417232", "417232119", "story_v_out_417232.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_40 = math.max(var_492_31, arg_489_1.talkMaxDuration)

			if var_492_30 <= arg_489_1.time_ and arg_489_1.time_ < var_492_30 + var_492_40 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_30) / var_492_40

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_30 + var_492_40 and arg_489_1.time_ < var_492_30 + var_492_40 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play417232120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 417232120
		arg_493_1.duration_ = 12.47

		local var_493_0 = {
			zh = 8.2,
			ja = 12.466
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play417232121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["10111"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.actorSpriteComps10111 == nil then
				arg_493_1.var_.actorSpriteComps10111 = var_496_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.actorSpriteComps10111 then
					for iter_496_0, iter_496_1 in pairs(arg_493_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_496_1 then
							if arg_493_1.isInRecall_ then
								local var_496_4 = Mathf.Lerp(iter_496_1.color.r, arg_493_1.hightColor1.r, var_496_3)
								local var_496_5 = Mathf.Lerp(iter_496_1.color.g, arg_493_1.hightColor1.g, var_496_3)
								local var_496_6 = Mathf.Lerp(iter_496_1.color.b, arg_493_1.hightColor1.b, var_496_3)

								iter_496_1.color = Color.New(var_496_4, var_496_5, var_496_6)
							else
								local var_496_7 = Mathf.Lerp(iter_496_1.color.r, 1, var_496_3)

								iter_496_1.color = Color.New(var_496_7, var_496_7, var_496_7)
							end
						end
					end
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.actorSpriteComps10111 then
				for iter_496_2, iter_496_3 in pairs(arg_493_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_496_3 then
						if arg_493_1.isInRecall_ then
							iter_496_3.color = arg_493_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_496_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_493_1.var_.actorSpriteComps10111 = nil
			end

			local var_496_8 = arg_493_1.actors_["1034"]
			local var_496_9 = 0

			if var_496_9 < arg_493_1.time_ and arg_493_1.time_ <= var_496_9 + arg_496_0 and not isNil(var_496_8) and arg_493_1.var_.actorSpriteComps1034 == nil then
				arg_493_1.var_.actorSpriteComps1034 = var_496_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_496_10 = 0.2

			if var_496_9 <= arg_493_1.time_ and arg_493_1.time_ < var_496_9 + var_496_10 and not isNil(var_496_8) then
				local var_496_11 = (arg_493_1.time_ - var_496_9) / var_496_10

				if arg_493_1.var_.actorSpriteComps1034 then
					for iter_496_4, iter_496_5 in pairs(arg_493_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_496_5 then
							if arg_493_1.isInRecall_ then
								local var_496_12 = Mathf.Lerp(iter_496_5.color.r, arg_493_1.hightColor2.r, var_496_11)
								local var_496_13 = Mathf.Lerp(iter_496_5.color.g, arg_493_1.hightColor2.g, var_496_11)
								local var_496_14 = Mathf.Lerp(iter_496_5.color.b, arg_493_1.hightColor2.b, var_496_11)

								iter_496_5.color = Color.New(var_496_12, var_496_13, var_496_14)
							else
								local var_496_15 = Mathf.Lerp(iter_496_5.color.r, 0.5, var_496_11)

								iter_496_5.color = Color.New(var_496_15, var_496_15, var_496_15)
							end
						end
					end
				end
			end

			if arg_493_1.time_ >= var_496_9 + var_496_10 and arg_493_1.time_ < var_496_9 + var_496_10 + arg_496_0 and not isNil(var_496_8) and arg_493_1.var_.actorSpriteComps1034 then
				for iter_496_6, iter_496_7 in pairs(arg_493_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_496_7 then
						if arg_493_1.isInRecall_ then
							iter_496_7.color = arg_493_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_496_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_493_1.var_.actorSpriteComps1034 = nil
			end

			local var_496_16 = arg_493_1.actors_["10111"].transform
			local var_496_17 = 0

			if var_496_17 < arg_493_1.time_ and arg_493_1.time_ <= var_496_17 + arg_496_0 then
				arg_493_1.var_.moveOldPos10111 = var_496_16.localPosition
				var_496_16.localScale = Vector3.New(1, 1, 1)

				arg_493_1:CheckSpriteTmpPos("10111", 2)

				local var_496_18 = var_496_16.childCount

				for iter_496_8 = 0, var_496_18 - 1 do
					local var_496_19 = var_496_16:GetChild(iter_496_8)

					if var_496_19.name == "split_2" or not string.find(var_496_19.name, "split") then
						var_496_19.gameObject:SetActive(true)
					else
						var_496_19.gameObject:SetActive(false)
					end
				end
			end

			local var_496_20 = 0.001

			if var_496_17 <= arg_493_1.time_ and arg_493_1.time_ < var_496_17 + var_496_20 then
				local var_496_21 = (arg_493_1.time_ - var_496_17) / var_496_20
				local var_496_22 = Vector3.New(-390, -361.1, -274.6)

				var_496_16.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10111, var_496_22, var_496_21)
			end

			if arg_493_1.time_ >= var_496_17 + var_496_20 and arg_493_1.time_ < var_496_17 + var_496_20 + arg_496_0 then
				var_496_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_496_23 = 0
			local var_496_24 = 0.95

			if var_496_23 < arg_493_1.time_ and arg_493_1.time_ <= var_496_23 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_25 = arg_493_1:FormatText(StoryNameCfg[1125].name)

				arg_493_1.leftNameTxt_.text = var_496_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_26 = arg_493_1:GetWordFromCfg(417232120)
				local var_496_27 = arg_493_1:FormatText(var_496_26.content)

				arg_493_1.text_.text = var_496_27

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_28 = 38
				local var_496_29 = utf8.len(var_496_27)
				local var_496_30 = var_496_28 <= 0 and var_496_24 or var_496_24 * (var_496_29 / var_496_28)

				if var_496_30 > 0 and var_496_24 < var_496_30 then
					arg_493_1.talkMaxDuration = var_496_30

					if var_496_30 + var_496_23 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_30 + var_496_23
					end
				end

				arg_493_1.text_.text = var_496_27
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232120", "story_v_out_417232.awb") ~= 0 then
					local var_496_31 = manager.audio:GetVoiceLength("story_v_out_417232", "417232120", "story_v_out_417232.awb") / 1000

					if var_496_31 + var_496_23 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_31 + var_496_23
					end

					if var_496_26.prefab_name ~= "" and arg_493_1.actors_[var_496_26.prefab_name] ~= nil then
						local var_496_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_26.prefab_name].transform, "story_v_out_417232", "417232120", "story_v_out_417232.awb")

						arg_493_1:RecordAudio("417232120", var_496_32)
						arg_493_1:RecordAudio("417232120", var_496_32)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_417232", "417232120", "story_v_out_417232.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_417232", "417232120", "story_v_out_417232.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_33 = math.max(var_496_24, arg_493_1.talkMaxDuration)

			if var_496_23 <= arg_493_1.time_ and arg_493_1.time_ < var_496_23 + var_496_33 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_23) / var_496_33

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_23 + var_496_33 and arg_493_1.time_ < var_496_23 + var_496_33 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play417232121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 417232121
		arg_497_1.duration_ = 9.37

		local var_497_0 = {
			zh = 7.5,
			ja = 9.366
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play417232122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = arg_497_1.actors_["10128"]
			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.actorSpriteComps10128 == nil then
				arg_497_1.var_.actorSpriteComps10128 = var_500_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_500_2 = 0.2

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_2 and not isNil(var_500_0) then
				local var_500_3 = (arg_497_1.time_ - var_500_1) / var_500_2

				if arg_497_1.var_.actorSpriteComps10128 then
					for iter_500_0, iter_500_1 in pairs(arg_497_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_500_1 then
							if arg_497_1.isInRecall_ then
								local var_500_4 = Mathf.Lerp(iter_500_1.color.r, arg_497_1.hightColor1.r, var_500_3)
								local var_500_5 = Mathf.Lerp(iter_500_1.color.g, arg_497_1.hightColor1.g, var_500_3)
								local var_500_6 = Mathf.Lerp(iter_500_1.color.b, arg_497_1.hightColor1.b, var_500_3)

								iter_500_1.color = Color.New(var_500_4, var_500_5, var_500_6)
							else
								local var_500_7 = Mathf.Lerp(iter_500_1.color.r, 1, var_500_3)

								iter_500_1.color = Color.New(var_500_7, var_500_7, var_500_7)
							end
						end
					end
				end
			end

			if arg_497_1.time_ >= var_500_1 + var_500_2 and arg_497_1.time_ < var_500_1 + var_500_2 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.actorSpriteComps10128 then
				for iter_500_2, iter_500_3 in pairs(arg_497_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_500_3 then
						if arg_497_1.isInRecall_ then
							iter_500_3.color = arg_497_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_500_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_497_1.var_.actorSpriteComps10128 = nil
			end

			local var_500_8 = arg_497_1.actors_["10111"]
			local var_500_9 = 0

			if var_500_9 < arg_497_1.time_ and arg_497_1.time_ <= var_500_9 + arg_500_0 and not isNil(var_500_8) and arg_497_1.var_.actorSpriteComps10111 == nil then
				arg_497_1.var_.actorSpriteComps10111 = var_500_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_500_10 = 0.2

			if var_500_9 <= arg_497_1.time_ and arg_497_1.time_ < var_500_9 + var_500_10 and not isNil(var_500_8) then
				local var_500_11 = (arg_497_1.time_ - var_500_9) / var_500_10

				if arg_497_1.var_.actorSpriteComps10111 then
					for iter_500_4, iter_500_5 in pairs(arg_497_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_500_5 then
							if arg_497_1.isInRecall_ then
								local var_500_12 = Mathf.Lerp(iter_500_5.color.r, arg_497_1.hightColor2.r, var_500_11)
								local var_500_13 = Mathf.Lerp(iter_500_5.color.g, arg_497_1.hightColor2.g, var_500_11)
								local var_500_14 = Mathf.Lerp(iter_500_5.color.b, arg_497_1.hightColor2.b, var_500_11)

								iter_500_5.color = Color.New(var_500_12, var_500_13, var_500_14)
							else
								local var_500_15 = Mathf.Lerp(iter_500_5.color.r, 0.5, var_500_11)

								iter_500_5.color = Color.New(var_500_15, var_500_15, var_500_15)
							end
						end
					end
				end
			end

			if arg_497_1.time_ >= var_500_9 + var_500_10 and arg_497_1.time_ < var_500_9 + var_500_10 + arg_500_0 and not isNil(var_500_8) and arg_497_1.var_.actorSpriteComps10111 then
				for iter_500_6, iter_500_7 in pairs(arg_497_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_500_7 then
						if arg_497_1.isInRecall_ then
							iter_500_7.color = arg_497_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_500_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_497_1.var_.actorSpriteComps10111 = nil
			end

			local var_500_16 = arg_497_1.actors_["10128"].transform
			local var_500_17 = 0

			if var_500_17 < arg_497_1.time_ and arg_497_1.time_ <= var_500_17 + arg_500_0 then
				arg_497_1.var_.moveOldPos10128 = var_500_16.localPosition
				var_500_16.localScale = Vector3.New(1, 1, 1)

				arg_497_1:CheckSpriteTmpPos("10128", 4)

				local var_500_18 = var_500_16.childCount

				for iter_500_8 = 0, var_500_18 - 1 do
					local var_500_19 = var_500_16:GetChild(iter_500_8)

					if var_500_19.name == "" or not string.find(var_500_19.name, "split") then
						var_500_19.gameObject:SetActive(true)
					else
						var_500_19.gameObject:SetActive(false)
					end
				end
			end

			local var_500_20 = 0.001

			if var_500_17 <= arg_497_1.time_ and arg_497_1.time_ < var_500_17 + var_500_20 then
				local var_500_21 = (arg_497_1.time_ - var_500_17) / var_500_20
				local var_500_22 = Vector3.New(390, -347, -300)

				var_500_16.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10128, var_500_22, var_500_21)
			end

			if arg_497_1.time_ >= var_500_17 + var_500_20 and arg_497_1.time_ < var_500_17 + var_500_20 + arg_500_0 then
				var_500_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_500_23 = 0
			local var_500_24 = 0.975

			if var_500_23 < arg_497_1.time_ and arg_497_1.time_ <= var_500_23 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_25 = arg_497_1:FormatText(StoryNameCfg[595].name)

				arg_497_1.leftNameTxt_.text = var_500_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_26 = arg_497_1:GetWordFromCfg(417232121)
				local var_500_27 = arg_497_1:FormatText(var_500_26.content)

				arg_497_1.text_.text = var_500_27

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_28 = 39
				local var_500_29 = utf8.len(var_500_27)
				local var_500_30 = var_500_28 <= 0 and var_500_24 or var_500_24 * (var_500_29 / var_500_28)

				if var_500_30 > 0 and var_500_24 < var_500_30 then
					arg_497_1.talkMaxDuration = var_500_30

					if var_500_30 + var_500_23 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_30 + var_500_23
					end
				end

				arg_497_1.text_.text = var_500_27
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232121", "story_v_out_417232.awb") ~= 0 then
					local var_500_31 = manager.audio:GetVoiceLength("story_v_out_417232", "417232121", "story_v_out_417232.awb") / 1000

					if var_500_31 + var_500_23 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_31 + var_500_23
					end

					if var_500_26.prefab_name ~= "" and arg_497_1.actors_[var_500_26.prefab_name] ~= nil then
						local var_500_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_26.prefab_name].transform, "story_v_out_417232", "417232121", "story_v_out_417232.awb")

						arg_497_1:RecordAudio("417232121", var_500_32)
						arg_497_1:RecordAudio("417232121", var_500_32)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_417232", "417232121", "story_v_out_417232.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_417232", "417232121", "story_v_out_417232.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_33 = math.max(var_500_24, arg_497_1.talkMaxDuration)

			if var_500_23 <= arg_497_1.time_ and arg_497_1.time_ < var_500_23 + var_500_33 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_23) / var_500_33

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_23 + var_500_33 and arg_497_1.time_ < var_500_23 + var_500_33 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play417232122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 417232122
		arg_501_1.duration_ = 6.97

		local var_501_0 = {
			zh = 5.733,
			ja = 6.966
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play417232123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["10111"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10111 == nil then
				arg_501_1.var_.actorSpriteComps10111 = var_504_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_2 = 0.2

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.actorSpriteComps10111 then
					for iter_504_0, iter_504_1 in pairs(arg_501_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_504_1 then
							if arg_501_1.isInRecall_ then
								local var_504_4 = Mathf.Lerp(iter_504_1.color.r, arg_501_1.hightColor1.r, var_504_3)
								local var_504_5 = Mathf.Lerp(iter_504_1.color.g, arg_501_1.hightColor1.g, var_504_3)
								local var_504_6 = Mathf.Lerp(iter_504_1.color.b, arg_501_1.hightColor1.b, var_504_3)

								iter_504_1.color = Color.New(var_504_4, var_504_5, var_504_6)
							else
								local var_504_7 = Mathf.Lerp(iter_504_1.color.r, 1, var_504_3)

								iter_504_1.color = Color.New(var_504_7, var_504_7, var_504_7)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.actorSpriteComps10111 then
				for iter_504_2, iter_504_3 in pairs(arg_501_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_504_3 then
						if arg_501_1.isInRecall_ then
							iter_504_3.color = arg_501_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_504_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_501_1.var_.actorSpriteComps10111 = nil
			end

			local var_504_8 = arg_501_1.actors_["10111"].transform
			local var_504_9 = 0

			if var_504_9 < arg_501_1.time_ and arg_501_1.time_ <= var_504_9 + arg_504_0 then
				arg_501_1.var_.moveOldPos10111 = var_504_8.localPosition
				var_504_8.localScale = Vector3.New(1, 1, 1)

				arg_501_1:CheckSpriteTmpPos("10111", 3)

				local var_504_10 = var_504_8.childCount

				for iter_504_4 = 0, var_504_10 - 1 do
					local var_504_11 = var_504_8:GetChild(iter_504_4)

					if var_504_11.name == "split_6" or not string.find(var_504_11.name, "split") then
						var_504_11.gameObject:SetActive(true)
					else
						var_504_11.gameObject:SetActive(false)
					end
				end
			end

			local var_504_12 = 0.001

			if var_504_9 <= arg_501_1.time_ and arg_501_1.time_ < var_504_9 + var_504_12 then
				local var_504_13 = (arg_501_1.time_ - var_504_9) / var_504_12
				local var_504_14 = Vector3.New(0, -361.1, -274.6)

				var_504_8.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos10111, var_504_14, var_504_13)
			end

			if arg_501_1.time_ >= var_504_9 + var_504_12 and arg_501_1.time_ < var_504_9 + var_504_12 + arg_504_0 then
				var_504_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_504_15 = arg_501_1.actors_["10128"].transform
			local var_504_16 = 0

			if var_504_16 < arg_501_1.time_ and arg_501_1.time_ <= var_504_16 + arg_504_0 then
				arg_501_1.var_.moveOldPos10128 = var_504_15.localPosition
				var_504_15.localScale = Vector3.New(1, 1, 1)

				arg_501_1:CheckSpriteTmpPos("10128", 7)

				local var_504_17 = var_504_15.childCount

				for iter_504_5 = 0, var_504_17 - 1 do
					local var_504_18 = var_504_15:GetChild(iter_504_5)

					if var_504_18.name == "" or not string.find(var_504_18.name, "split") then
						var_504_18.gameObject:SetActive(true)
					else
						var_504_18.gameObject:SetActive(false)
					end
				end
			end

			local var_504_19 = 0.001

			if var_504_16 <= arg_501_1.time_ and arg_501_1.time_ < var_504_16 + var_504_19 then
				local var_504_20 = (arg_501_1.time_ - var_504_16) / var_504_19
				local var_504_21 = Vector3.New(0, -2000, -300)

				var_504_15.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos10128, var_504_21, var_504_20)
			end

			if arg_501_1.time_ >= var_504_16 + var_504_19 and arg_501_1.time_ < var_504_16 + var_504_19 + arg_504_0 then
				var_504_15.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_504_22 = 0
			local var_504_23 = 0.575

			if var_504_22 < arg_501_1.time_ and arg_501_1.time_ <= var_504_22 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_24 = arg_501_1:FormatText(StoryNameCfg[1125].name)

				arg_501_1.leftNameTxt_.text = var_504_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_25 = arg_501_1:GetWordFromCfg(417232122)
				local var_504_26 = arg_501_1:FormatText(var_504_25.content)

				arg_501_1.text_.text = var_504_26

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_27 = 23
				local var_504_28 = utf8.len(var_504_26)
				local var_504_29 = var_504_27 <= 0 and var_504_23 or var_504_23 * (var_504_28 / var_504_27)

				if var_504_29 > 0 and var_504_23 < var_504_29 then
					arg_501_1.talkMaxDuration = var_504_29

					if var_504_29 + var_504_22 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_29 + var_504_22
					end
				end

				arg_501_1.text_.text = var_504_26
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232122", "story_v_out_417232.awb") ~= 0 then
					local var_504_30 = manager.audio:GetVoiceLength("story_v_out_417232", "417232122", "story_v_out_417232.awb") / 1000

					if var_504_30 + var_504_22 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_30 + var_504_22
					end

					if var_504_25.prefab_name ~= "" and arg_501_1.actors_[var_504_25.prefab_name] ~= nil then
						local var_504_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_25.prefab_name].transform, "story_v_out_417232", "417232122", "story_v_out_417232.awb")

						arg_501_1:RecordAudio("417232122", var_504_31)
						arg_501_1:RecordAudio("417232122", var_504_31)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_417232", "417232122", "story_v_out_417232.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_417232", "417232122", "story_v_out_417232.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_32 = math.max(var_504_23, arg_501_1.talkMaxDuration)

			if var_504_22 <= arg_501_1.time_ and arg_501_1.time_ < var_504_22 + var_504_32 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_22) / var_504_32

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_22 + var_504_32 and arg_501_1.time_ < var_504_22 + var_504_32 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play417232123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 417232123
		arg_505_1.duration_ = 11.43

		local var_505_0 = {
			zh = 8.7,
			ja = 11.433
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play417232124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1034"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.actorSpriteComps1034 == nil then
				arg_505_1.var_.actorSpriteComps1034 = var_508_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.actorSpriteComps1034 then
					for iter_508_0, iter_508_1 in pairs(arg_505_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_508_1 then
							if arg_505_1.isInRecall_ then
								local var_508_4 = Mathf.Lerp(iter_508_1.color.r, arg_505_1.hightColor1.r, var_508_3)
								local var_508_5 = Mathf.Lerp(iter_508_1.color.g, arg_505_1.hightColor1.g, var_508_3)
								local var_508_6 = Mathf.Lerp(iter_508_1.color.b, arg_505_1.hightColor1.b, var_508_3)

								iter_508_1.color = Color.New(var_508_4, var_508_5, var_508_6)
							else
								local var_508_7 = Mathf.Lerp(iter_508_1.color.r, 1, var_508_3)

								iter_508_1.color = Color.New(var_508_7, var_508_7, var_508_7)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.actorSpriteComps1034 then
				for iter_508_2, iter_508_3 in pairs(arg_505_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_508_3 then
						if arg_505_1.isInRecall_ then
							iter_508_3.color = arg_505_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_508_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_505_1.var_.actorSpriteComps1034 = nil
			end

			local var_508_8 = arg_505_1.actors_["10111"]
			local var_508_9 = 0

			if var_508_9 < arg_505_1.time_ and arg_505_1.time_ <= var_508_9 + arg_508_0 and not isNil(var_508_8) and arg_505_1.var_.actorSpriteComps10111 == nil then
				arg_505_1.var_.actorSpriteComps10111 = var_508_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_10 = 0.2

			if var_508_9 <= arg_505_1.time_ and arg_505_1.time_ < var_508_9 + var_508_10 and not isNil(var_508_8) then
				local var_508_11 = (arg_505_1.time_ - var_508_9) / var_508_10

				if arg_505_1.var_.actorSpriteComps10111 then
					for iter_508_4, iter_508_5 in pairs(arg_505_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_508_5 then
							if arg_505_1.isInRecall_ then
								local var_508_12 = Mathf.Lerp(iter_508_5.color.r, arg_505_1.hightColor2.r, var_508_11)
								local var_508_13 = Mathf.Lerp(iter_508_5.color.g, arg_505_1.hightColor2.g, var_508_11)
								local var_508_14 = Mathf.Lerp(iter_508_5.color.b, arg_505_1.hightColor2.b, var_508_11)

								iter_508_5.color = Color.New(var_508_12, var_508_13, var_508_14)
							else
								local var_508_15 = Mathf.Lerp(iter_508_5.color.r, 0.5, var_508_11)

								iter_508_5.color = Color.New(var_508_15, var_508_15, var_508_15)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= var_508_9 + var_508_10 and arg_505_1.time_ < var_508_9 + var_508_10 + arg_508_0 and not isNil(var_508_8) and arg_505_1.var_.actorSpriteComps10111 then
				for iter_508_6, iter_508_7 in pairs(arg_505_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_508_7 then
						if arg_505_1.isInRecall_ then
							iter_508_7.color = arg_505_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_508_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_505_1.var_.actorSpriteComps10111 = nil
			end

			local var_508_16 = arg_505_1.actors_["1034"].transform
			local var_508_17 = 0

			if var_508_17 < arg_505_1.time_ and arg_505_1.time_ <= var_508_17 + arg_508_0 then
				arg_505_1.var_.moveOldPos1034 = var_508_16.localPosition
				var_508_16.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("1034", 4)

				local var_508_18 = var_508_16.childCount

				for iter_508_8 = 0, var_508_18 - 1 do
					local var_508_19 = var_508_16:GetChild(iter_508_8)

					if var_508_19.name == "split_1" or not string.find(var_508_19.name, "split") then
						var_508_19.gameObject:SetActive(true)
					else
						var_508_19.gameObject:SetActive(false)
					end
				end
			end

			local var_508_20 = 0.001

			if var_508_17 <= arg_505_1.time_ and arg_505_1.time_ < var_508_17 + var_508_20 then
				local var_508_21 = (arg_505_1.time_ - var_508_17) / var_508_20
				local var_508_22 = Vector3.New(373.7, -331.9, -324)

				var_508_16.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1034, var_508_22, var_508_21)
			end

			if arg_505_1.time_ >= var_508_17 + var_508_20 and arg_505_1.time_ < var_508_17 + var_508_20 + arg_508_0 then
				var_508_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_508_23 = arg_505_1.actors_["10111"].transform
			local var_508_24 = 0

			if var_508_24 < arg_505_1.time_ and arg_505_1.time_ <= var_508_24 + arg_508_0 then
				arg_505_1.var_.moveOldPos10111 = var_508_23.localPosition
				var_508_23.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("10111", 2)

				local var_508_25 = var_508_23.childCount

				for iter_508_9 = 0, var_508_25 - 1 do
					local var_508_26 = var_508_23:GetChild(iter_508_9)

					if var_508_26.name == "split_6" or not string.find(var_508_26.name, "split") then
						var_508_26.gameObject:SetActive(true)
					else
						var_508_26.gameObject:SetActive(false)
					end
				end
			end

			local var_508_27 = 0.001

			if var_508_24 <= arg_505_1.time_ and arg_505_1.time_ < var_508_24 + var_508_27 then
				local var_508_28 = (arg_505_1.time_ - var_508_24) / var_508_27
				local var_508_29 = Vector3.New(-390, -361.1, -274.6)

				var_508_23.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos10111, var_508_29, var_508_28)
			end

			if arg_505_1.time_ >= var_508_24 + var_508_27 and arg_505_1.time_ < var_508_24 + var_508_27 + arg_508_0 then
				var_508_23.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_508_30 = 0
			local var_508_31 = 1.275

			if var_508_30 < arg_505_1.time_ and arg_505_1.time_ <= var_508_30 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_32 = arg_505_1:FormatText(StoryNameCfg[1109].name)

				arg_505_1.leftNameTxt_.text = var_508_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_33 = arg_505_1:GetWordFromCfg(417232123)
				local var_508_34 = arg_505_1:FormatText(var_508_33.content)

				arg_505_1.text_.text = var_508_34

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_35 = 51
				local var_508_36 = utf8.len(var_508_34)
				local var_508_37 = var_508_35 <= 0 and var_508_31 or var_508_31 * (var_508_36 / var_508_35)

				if var_508_37 > 0 and var_508_31 < var_508_37 then
					arg_505_1.talkMaxDuration = var_508_37

					if var_508_37 + var_508_30 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_37 + var_508_30
					end
				end

				arg_505_1.text_.text = var_508_34
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232123", "story_v_out_417232.awb") ~= 0 then
					local var_508_38 = manager.audio:GetVoiceLength("story_v_out_417232", "417232123", "story_v_out_417232.awb") / 1000

					if var_508_38 + var_508_30 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_38 + var_508_30
					end

					if var_508_33.prefab_name ~= "" and arg_505_1.actors_[var_508_33.prefab_name] ~= nil then
						local var_508_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_33.prefab_name].transform, "story_v_out_417232", "417232123", "story_v_out_417232.awb")

						arg_505_1:RecordAudio("417232123", var_508_39)
						arg_505_1:RecordAudio("417232123", var_508_39)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_417232", "417232123", "story_v_out_417232.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_417232", "417232123", "story_v_out_417232.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_40 = math.max(var_508_31, arg_505_1.talkMaxDuration)

			if var_508_30 <= arg_505_1.time_ and arg_505_1.time_ < var_508_30 + var_508_40 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_30) / var_508_40

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_30 + var_508_40 and arg_505_1.time_ < var_508_30 + var_508_40 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play417232124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 417232124
		arg_509_1.duration_ = 9.6

		local var_509_0 = {
			zh = 9.6,
			ja = 8.733
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play417232125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["10111"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps10111 == nil then
				arg_509_1.var_.actorSpriteComps10111 = var_512_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_2 = 0.2

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.actorSpriteComps10111 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_512_1 then
							if arg_509_1.isInRecall_ then
								local var_512_4 = Mathf.Lerp(iter_512_1.color.r, arg_509_1.hightColor1.r, var_512_3)
								local var_512_5 = Mathf.Lerp(iter_512_1.color.g, arg_509_1.hightColor1.g, var_512_3)
								local var_512_6 = Mathf.Lerp(iter_512_1.color.b, arg_509_1.hightColor1.b, var_512_3)

								iter_512_1.color = Color.New(var_512_4, var_512_5, var_512_6)
							else
								local var_512_7 = Mathf.Lerp(iter_512_1.color.r, 1, var_512_3)

								iter_512_1.color = Color.New(var_512_7, var_512_7, var_512_7)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps10111 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_512_3 then
						if arg_509_1.isInRecall_ then
							iter_512_3.color = arg_509_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_512_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_509_1.var_.actorSpriteComps10111 = nil
			end

			local var_512_8 = arg_509_1.actors_["1034"]
			local var_512_9 = 0

			if var_512_9 < arg_509_1.time_ and arg_509_1.time_ <= var_512_9 + arg_512_0 and not isNil(var_512_8) and arg_509_1.var_.actorSpriteComps1034 == nil then
				arg_509_1.var_.actorSpriteComps1034 = var_512_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_10 = 0.2

			if var_512_9 <= arg_509_1.time_ and arg_509_1.time_ < var_512_9 + var_512_10 and not isNil(var_512_8) then
				local var_512_11 = (arg_509_1.time_ - var_512_9) / var_512_10

				if arg_509_1.var_.actorSpriteComps1034 then
					for iter_512_4, iter_512_5 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_512_5 then
							if arg_509_1.isInRecall_ then
								local var_512_12 = Mathf.Lerp(iter_512_5.color.r, arg_509_1.hightColor2.r, var_512_11)
								local var_512_13 = Mathf.Lerp(iter_512_5.color.g, arg_509_1.hightColor2.g, var_512_11)
								local var_512_14 = Mathf.Lerp(iter_512_5.color.b, arg_509_1.hightColor2.b, var_512_11)

								iter_512_5.color = Color.New(var_512_12, var_512_13, var_512_14)
							else
								local var_512_15 = Mathf.Lerp(iter_512_5.color.r, 0.5, var_512_11)

								iter_512_5.color = Color.New(var_512_15, var_512_15, var_512_15)
							end
						end
					end
				end
			end

			if arg_509_1.time_ >= var_512_9 + var_512_10 and arg_509_1.time_ < var_512_9 + var_512_10 + arg_512_0 and not isNil(var_512_8) and arg_509_1.var_.actorSpriteComps1034 then
				for iter_512_6, iter_512_7 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_512_7 then
						if arg_509_1.isInRecall_ then
							iter_512_7.color = arg_509_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_512_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_509_1.var_.actorSpriteComps1034 = nil
			end

			local var_512_16 = arg_509_1.actors_["10111"].transform
			local var_512_17 = 0

			if var_512_17 < arg_509_1.time_ and arg_509_1.time_ <= var_512_17 + arg_512_0 then
				arg_509_1.var_.moveOldPos10111 = var_512_16.localPosition
				var_512_16.localScale = Vector3.New(1, 1, 1)

				arg_509_1:CheckSpriteTmpPos("10111", 2)

				local var_512_18 = var_512_16.childCount

				for iter_512_8 = 0, var_512_18 - 1 do
					local var_512_19 = var_512_16:GetChild(iter_512_8)

					if var_512_19.name == "split_1" or not string.find(var_512_19.name, "split") then
						var_512_19.gameObject:SetActive(true)
					else
						var_512_19.gameObject:SetActive(false)
					end
				end
			end

			local var_512_20 = 0.001

			if var_512_17 <= arg_509_1.time_ and arg_509_1.time_ < var_512_17 + var_512_20 then
				local var_512_21 = (arg_509_1.time_ - var_512_17) / var_512_20
				local var_512_22 = Vector3.New(-390, -361.1, -274.6)

				var_512_16.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos10111, var_512_22, var_512_21)
			end

			if arg_509_1.time_ >= var_512_17 + var_512_20 and arg_509_1.time_ < var_512_17 + var_512_20 + arg_512_0 then
				var_512_16.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_512_23 = 0
			local var_512_24 = 1

			if var_512_23 < arg_509_1.time_ and arg_509_1.time_ <= var_512_23 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_25 = arg_509_1:FormatText(StoryNameCfg[1125].name)

				arg_509_1.leftNameTxt_.text = var_512_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_26 = arg_509_1:GetWordFromCfg(417232124)
				local var_512_27 = arg_509_1:FormatText(var_512_26.content)

				arg_509_1.text_.text = var_512_27

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_28 = 40
				local var_512_29 = utf8.len(var_512_27)
				local var_512_30 = var_512_28 <= 0 and var_512_24 or var_512_24 * (var_512_29 / var_512_28)

				if var_512_30 > 0 and var_512_24 < var_512_30 then
					arg_509_1.talkMaxDuration = var_512_30

					if var_512_30 + var_512_23 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_30 + var_512_23
					end
				end

				arg_509_1.text_.text = var_512_27
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232124", "story_v_out_417232.awb") ~= 0 then
					local var_512_31 = manager.audio:GetVoiceLength("story_v_out_417232", "417232124", "story_v_out_417232.awb") / 1000

					if var_512_31 + var_512_23 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_31 + var_512_23
					end

					if var_512_26.prefab_name ~= "" and arg_509_1.actors_[var_512_26.prefab_name] ~= nil then
						local var_512_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_26.prefab_name].transform, "story_v_out_417232", "417232124", "story_v_out_417232.awb")

						arg_509_1:RecordAudio("417232124", var_512_32)
						arg_509_1:RecordAudio("417232124", var_512_32)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_417232", "417232124", "story_v_out_417232.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_417232", "417232124", "story_v_out_417232.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_33 = math.max(var_512_24, arg_509_1.talkMaxDuration)

			if var_512_23 <= arg_509_1.time_ and arg_509_1.time_ < var_512_23 + var_512_33 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_23) / var_512_33

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_23 + var_512_33 and arg_509_1.time_ < var_512_23 + var_512_33 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play417232125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 417232125
		arg_513_1.duration_ = 5.93

		local var_513_0 = {
			zh = 5.866,
			ja = 5.933
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play417232126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.7

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[1125].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:GetWordFromCfg(417232125)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 28
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232125", "story_v_out_417232.awb") ~= 0 then
					local var_516_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232125", "story_v_out_417232.awb") / 1000

					if var_516_8 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_8 + var_516_0
					end

					if var_516_3.prefab_name ~= "" and arg_513_1.actors_[var_516_3.prefab_name] ~= nil then
						local var_516_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_3.prefab_name].transform, "story_v_out_417232", "417232125", "story_v_out_417232.awb")

						arg_513_1:RecordAudio("417232125", var_516_9)
						arg_513_1:RecordAudio("417232125", var_516_9)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_417232", "417232125", "story_v_out_417232.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_417232", "417232125", "story_v_out_417232.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_10 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_10

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_10 and arg_513_1.time_ < var_516_0 + var_516_10 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play417232126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 417232126
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play417232127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["10111"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps10111 == nil then
				arg_517_1.var_.actorSpriteComps10111 = var_520_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_520_2 = 0.2

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.actorSpriteComps10111 then
					for iter_520_0, iter_520_1 in pairs(arg_517_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_520_1 then
							if arg_517_1.isInRecall_ then
								local var_520_4 = Mathf.Lerp(iter_520_1.color.r, arg_517_1.hightColor2.r, var_520_3)
								local var_520_5 = Mathf.Lerp(iter_520_1.color.g, arg_517_1.hightColor2.g, var_520_3)
								local var_520_6 = Mathf.Lerp(iter_520_1.color.b, arg_517_1.hightColor2.b, var_520_3)

								iter_520_1.color = Color.New(var_520_4, var_520_5, var_520_6)
							else
								local var_520_7 = Mathf.Lerp(iter_520_1.color.r, 0.5, var_520_3)

								iter_520_1.color = Color.New(var_520_7, var_520_7, var_520_7)
							end
						end
					end
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.actorSpriteComps10111 then
				for iter_520_2, iter_520_3 in pairs(arg_517_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_520_3 then
						if arg_517_1.isInRecall_ then
							iter_520_3.color = arg_517_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_520_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_517_1.var_.actorSpriteComps10111 = nil
			end

			local var_520_8 = arg_517_1.actors_["10111"].transform
			local var_520_9 = 0

			if var_520_9 < arg_517_1.time_ and arg_517_1.time_ <= var_520_9 + arg_520_0 then
				arg_517_1.var_.moveOldPos10111 = var_520_8.localPosition
				var_520_8.localScale = Vector3.New(1, 1, 1)

				arg_517_1:CheckSpriteTmpPos("10111", 7)

				local var_520_10 = var_520_8.childCount

				for iter_520_4 = 0, var_520_10 - 1 do
					local var_520_11 = var_520_8:GetChild(iter_520_4)

					if var_520_11.name == "" or not string.find(var_520_11.name, "split") then
						var_520_11.gameObject:SetActive(true)
					else
						var_520_11.gameObject:SetActive(false)
					end
				end
			end

			local var_520_12 = 0.001

			if var_520_9 <= arg_517_1.time_ and arg_517_1.time_ < var_520_9 + var_520_12 then
				local var_520_13 = (arg_517_1.time_ - var_520_9) / var_520_12
				local var_520_14 = Vector3.New(0, -2000, 0)

				var_520_8.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos10111, var_520_14, var_520_13)
			end

			if arg_517_1.time_ >= var_520_9 + var_520_12 and arg_517_1.time_ < var_520_9 + var_520_12 + arg_520_0 then
				var_520_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_520_15 = arg_517_1.actors_["1034"].transform
			local var_520_16 = 0

			if var_520_16 < arg_517_1.time_ and arg_517_1.time_ <= var_520_16 + arg_520_0 then
				arg_517_1.var_.moveOldPos1034 = var_520_15.localPosition
				var_520_15.localScale = Vector3.New(1, 1, 1)

				arg_517_1:CheckSpriteTmpPos("1034", 7)

				local var_520_17 = var_520_15.childCount

				for iter_520_5 = 0, var_520_17 - 1 do
					local var_520_18 = var_520_15:GetChild(iter_520_5)

					if var_520_18.name == "" or not string.find(var_520_18.name, "split") then
						var_520_18.gameObject:SetActive(true)
					else
						var_520_18.gameObject:SetActive(false)
					end
				end
			end

			local var_520_19 = 0.001

			if var_520_16 <= arg_517_1.time_ and arg_517_1.time_ < var_520_16 + var_520_19 then
				local var_520_20 = (arg_517_1.time_ - var_520_16) / var_520_19
				local var_520_21 = Vector3.New(0, -2000, 0)

				var_520_15.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1034, var_520_21, var_520_20)
			end

			if arg_517_1.time_ >= var_520_16 + var_520_19 and arg_517_1.time_ < var_520_16 + var_520_19 + arg_520_0 then
				var_520_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_520_22 = 0
			local var_520_23 = 0.725

			if var_520_22 < arg_517_1.time_ and arg_517_1.time_ <= var_520_22 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_24 = arg_517_1:GetWordFromCfg(417232126)
				local var_520_25 = arg_517_1:FormatText(var_520_24.content)

				arg_517_1.text_.text = var_520_25

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_26 = 29
				local var_520_27 = utf8.len(var_520_25)
				local var_520_28 = var_520_26 <= 0 and var_520_23 or var_520_23 * (var_520_27 / var_520_26)

				if var_520_28 > 0 and var_520_23 < var_520_28 then
					arg_517_1.talkMaxDuration = var_520_28

					if var_520_28 + var_520_22 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_28 + var_520_22
					end
				end

				arg_517_1.text_.text = var_520_25
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_29 = math.max(var_520_23, arg_517_1.talkMaxDuration)

			if var_520_22 <= arg_517_1.time_ and arg_517_1.time_ < var_520_22 + var_520_29 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_22) / var_520_29

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_22 + var_520_29 and arg_517_1.time_ < var_520_22 + var_520_29 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play417232127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 417232127
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play417232128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.766666666666667
			local var_524_1 = 1

			if var_524_0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				local var_524_2 = "play"
				local var_524_3 = "effect"

				arg_521_1:AudioAction(var_524_2, var_524_3, "se_story_1311", "se_story_1311_hittable02", "")
			end

			local var_524_4 = 0
			local var_524_5 = 0.475

			if var_524_4 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(417232127)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_8 = 19
				local var_524_9 = utf8.len(var_524_7)
				local var_524_10 = var_524_8 <= 0 and var_524_5 or var_524_5 * (var_524_9 / var_524_8)

				if var_524_10 > 0 and var_524_5 < var_524_10 then
					arg_521_1.talkMaxDuration = var_524_10

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_11 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_11 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_11

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_11 and arg_521_1.time_ < var_524_4 + var_524_11 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play417232128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 417232128
		arg_525_1.duration_ = 7.53

		local var_525_0 = {
			zh = 5.566,
			ja = 7.533
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play417232129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1034"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps1034 == nil then
				arg_525_1.var_.actorSpriteComps1034 = var_528_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_528_2 = 0.2

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.actorSpriteComps1034 then
					for iter_528_0, iter_528_1 in pairs(arg_525_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_528_1 then
							if arg_525_1.isInRecall_ then
								local var_528_4 = Mathf.Lerp(iter_528_1.color.r, arg_525_1.hightColor1.r, var_528_3)
								local var_528_5 = Mathf.Lerp(iter_528_1.color.g, arg_525_1.hightColor1.g, var_528_3)
								local var_528_6 = Mathf.Lerp(iter_528_1.color.b, arg_525_1.hightColor1.b, var_528_3)

								iter_528_1.color = Color.New(var_528_4, var_528_5, var_528_6)
							else
								local var_528_7 = Mathf.Lerp(iter_528_1.color.r, 1, var_528_3)

								iter_528_1.color = Color.New(var_528_7, var_528_7, var_528_7)
							end
						end
					end
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.actorSpriteComps1034 then
				for iter_528_2, iter_528_3 in pairs(arg_525_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_528_3 then
						if arg_525_1.isInRecall_ then
							iter_528_3.color = arg_525_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_528_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_525_1.var_.actorSpriteComps1034 = nil
			end

			local var_528_8 = arg_525_1.actors_["1034"].transform
			local var_528_9 = 0

			if var_528_9 < arg_525_1.time_ and arg_525_1.time_ <= var_528_9 + arg_528_0 then
				arg_525_1.var_.moveOldPos1034 = var_528_8.localPosition
				var_528_8.localScale = Vector3.New(1, 1, 1)

				arg_525_1:CheckSpriteTmpPos("1034", 3)

				local var_528_10 = var_528_8.childCount

				for iter_528_4 = 0, var_528_10 - 1 do
					local var_528_11 = var_528_8:GetChild(iter_528_4)

					if var_528_11.name == "split_5" or not string.find(var_528_11.name, "split") then
						var_528_11.gameObject:SetActive(true)
					else
						var_528_11.gameObject:SetActive(false)
					end
				end
			end

			local var_528_12 = 0.001

			if var_528_9 <= arg_525_1.time_ and arg_525_1.time_ < var_528_9 + var_528_12 then
				local var_528_13 = (arg_525_1.time_ - var_528_9) / var_528_12
				local var_528_14 = Vector3.New(0, -331.9, -324)

				var_528_8.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1034, var_528_14, var_528_13)
			end

			if arg_525_1.time_ >= var_528_9 + var_528_12 and arg_525_1.time_ < var_528_9 + var_528_12 + arg_528_0 then
				var_528_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_528_15 = 0
			local var_528_16 = 0.75

			if var_528_15 < arg_525_1.time_ and arg_525_1.time_ <= var_528_15 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_17 = arg_525_1:FormatText(StoryNameCfg[1109].name)

				arg_525_1.leftNameTxt_.text = var_528_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_18 = arg_525_1:GetWordFromCfg(417232128)
				local var_528_19 = arg_525_1:FormatText(var_528_18.content)

				arg_525_1.text_.text = var_528_19

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_20 = 30
				local var_528_21 = utf8.len(var_528_19)
				local var_528_22 = var_528_20 <= 0 and var_528_16 or var_528_16 * (var_528_21 / var_528_20)

				if var_528_22 > 0 and var_528_16 < var_528_22 then
					arg_525_1.talkMaxDuration = var_528_22

					if var_528_22 + var_528_15 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_22 + var_528_15
					end
				end

				arg_525_1.text_.text = var_528_19
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232128", "story_v_out_417232.awb") ~= 0 then
					local var_528_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232128", "story_v_out_417232.awb") / 1000

					if var_528_23 + var_528_15 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_23 + var_528_15
					end

					if var_528_18.prefab_name ~= "" and arg_525_1.actors_[var_528_18.prefab_name] ~= nil then
						local var_528_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_18.prefab_name].transform, "story_v_out_417232", "417232128", "story_v_out_417232.awb")

						arg_525_1:RecordAudio("417232128", var_528_24)
						arg_525_1:RecordAudio("417232128", var_528_24)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_417232", "417232128", "story_v_out_417232.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_417232", "417232128", "story_v_out_417232.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_25 = math.max(var_528_16, arg_525_1.talkMaxDuration)

			if var_528_15 <= arg_525_1.time_ and arg_525_1.time_ < var_528_15 + var_528_25 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_15) / var_528_25

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_15 + var_528_25 and arg_525_1.time_ < var_528_15 + var_528_25 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play417232129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 417232129
		arg_529_1.duration_ = 9.57

		local var_529_0 = {
			zh = 7.2,
			ja = 9.566
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play417232130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1015"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps1015 == nil then
				arg_529_1.var_.actorSpriteComps1015 = var_532_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.actorSpriteComps1015 then
					for iter_532_0, iter_532_1 in pairs(arg_529_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_532_1 then
							if arg_529_1.isInRecall_ then
								local var_532_4 = Mathf.Lerp(iter_532_1.color.r, arg_529_1.hightColor1.r, var_532_3)
								local var_532_5 = Mathf.Lerp(iter_532_1.color.g, arg_529_1.hightColor1.g, var_532_3)
								local var_532_6 = Mathf.Lerp(iter_532_1.color.b, arg_529_1.hightColor1.b, var_532_3)

								iter_532_1.color = Color.New(var_532_4, var_532_5, var_532_6)
							else
								local var_532_7 = Mathf.Lerp(iter_532_1.color.r, 1, var_532_3)

								iter_532_1.color = Color.New(var_532_7, var_532_7, var_532_7)
							end
						end
					end
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.actorSpriteComps1015 then
				for iter_532_2, iter_532_3 in pairs(arg_529_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_532_3 then
						if arg_529_1.isInRecall_ then
							iter_532_3.color = arg_529_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_532_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_529_1.var_.actorSpriteComps1015 = nil
			end

			local var_532_8 = arg_529_1.actors_["1015"].transform
			local var_532_9 = 0

			if var_532_9 < arg_529_1.time_ and arg_529_1.time_ <= var_532_9 + arg_532_0 then
				arg_529_1.var_.moveOldPos1015 = var_532_8.localPosition
				var_532_8.localScale = Vector3.New(1, 1, 1)

				arg_529_1:CheckSpriteTmpPos("1015", 3)

				local var_532_10 = var_532_8.childCount

				for iter_532_4 = 0, var_532_10 - 1 do
					local var_532_11 = var_532_8:GetChild(iter_532_4)

					if var_532_11.name == "split_1" or not string.find(var_532_11.name, "split") then
						var_532_11.gameObject:SetActive(true)
					else
						var_532_11.gameObject:SetActive(false)
					end
				end
			end

			local var_532_12 = 0.001

			if var_532_9 <= arg_529_1.time_ and arg_529_1.time_ < var_532_9 + var_532_12 then
				local var_532_13 = (arg_529_1.time_ - var_532_9) / var_532_12
				local var_532_14 = Vector3.New(0, -340, -288)

				var_532_8.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1015, var_532_14, var_532_13)
			end

			if arg_529_1.time_ >= var_532_9 + var_532_12 and arg_529_1.time_ < var_532_9 + var_532_12 + arg_532_0 then
				var_532_8.localPosition = Vector3.New(0, -340, -288)
			end

			local var_532_15 = 0
			local var_532_16 = 0.75

			if var_532_15 < arg_529_1.time_ and arg_529_1.time_ <= var_532_15 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_17 = arg_529_1:FormatText(StoryNameCfg[479].name)

				arg_529_1.leftNameTxt_.text = var_532_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_18 = arg_529_1:GetWordFromCfg(417232129)
				local var_532_19 = arg_529_1:FormatText(var_532_18.content)

				arg_529_1.text_.text = var_532_19

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_20 = 30
				local var_532_21 = utf8.len(var_532_19)
				local var_532_22 = var_532_20 <= 0 and var_532_16 or var_532_16 * (var_532_21 / var_532_20)

				if var_532_22 > 0 and var_532_16 < var_532_22 then
					arg_529_1.talkMaxDuration = var_532_22

					if var_532_22 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_22 + var_532_15
					end
				end

				arg_529_1.text_.text = var_532_19
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232129", "story_v_out_417232.awb") ~= 0 then
					local var_532_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232129", "story_v_out_417232.awb") / 1000

					if var_532_23 + var_532_15 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_23 + var_532_15
					end

					if var_532_18.prefab_name ~= "" and arg_529_1.actors_[var_532_18.prefab_name] ~= nil then
						local var_532_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_18.prefab_name].transform, "story_v_out_417232", "417232129", "story_v_out_417232.awb")

						arg_529_1:RecordAudio("417232129", var_532_24)
						arg_529_1:RecordAudio("417232129", var_532_24)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_417232", "417232129", "story_v_out_417232.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_417232", "417232129", "story_v_out_417232.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_25 = math.max(var_532_16, arg_529_1.talkMaxDuration)

			if var_532_15 <= arg_529_1.time_ and arg_529_1.time_ < var_532_15 + var_532_25 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_15) / var_532_25

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_15 + var_532_25 and arg_529_1.time_ < var_532_15 + var_532_25 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play417232130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 417232130
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play417232131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1015"].transform
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.var_.moveOldPos1015 = var_536_0.localPosition
				var_536_0.localScale = Vector3.New(1, 1, 1)

				arg_533_1:CheckSpriteTmpPos("1015", 7)

				local var_536_2 = var_536_0.childCount

				for iter_536_0 = 0, var_536_2 - 1 do
					local var_536_3 = var_536_0:GetChild(iter_536_0)

					if var_536_3.name == "" or not string.find(var_536_3.name, "split") then
						var_536_3.gameObject:SetActive(true)
					else
						var_536_3.gameObject:SetActive(false)
					end
				end
			end

			local var_536_4 = 0.001

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_4 then
				local var_536_5 = (arg_533_1.time_ - var_536_1) / var_536_4
				local var_536_6 = Vector3.New(0, -2000, 0)

				var_536_0.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1015, var_536_6, var_536_5)
			end

			if arg_533_1.time_ >= var_536_1 + var_536_4 and arg_533_1.time_ < var_536_1 + var_536_4 + arg_536_0 then
				var_536_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_536_7 = 0
			local var_536_8 = 1.225

			if var_536_7 < arg_533_1.time_ and arg_533_1.time_ <= var_536_7 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_9 = arg_533_1:GetWordFromCfg(417232130)
				local var_536_10 = arg_533_1:FormatText(var_536_9.content)

				arg_533_1.text_.text = var_536_10

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_11 = 49
				local var_536_12 = utf8.len(var_536_10)
				local var_536_13 = var_536_11 <= 0 and var_536_8 or var_536_8 * (var_536_12 / var_536_11)

				if var_536_13 > 0 and var_536_8 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_7 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_7
					end
				end

				arg_533_1.text_.text = var_536_10
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_14 = math.max(var_536_8, arg_533_1.talkMaxDuration)

			if var_536_7 <= arg_533_1.time_ and arg_533_1.time_ < var_536_7 + var_536_14 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_7) / var_536_14

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_7 + var_536_14 and arg_533_1.time_ < var_536_7 + var_536_14 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play417232131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 417232131
		arg_537_1.duration_ = 6.8

		local var_537_0 = {
			zh = 5.333,
			ja = 6.8
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play417232132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = arg_537_1.actors_["10111"]
			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps10111 == nil then
				arg_537_1.var_.actorSpriteComps10111 = var_540_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_2 = 0.2

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_2 and not isNil(var_540_0) then
				local var_540_3 = (arg_537_1.time_ - var_540_1) / var_540_2

				if arg_537_1.var_.actorSpriteComps10111 then
					for iter_540_0, iter_540_1 in pairs(arg_537_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_540_1 then
							if arg_537_1.isInRecall_ then
								local var_540_4 = Mathf.Lerp(iter_540_1.color.r, arg_537_1.hightColor1.r, var_540_3)
								local var_540_5 = Mathf.Lerp(iter_540_1.color.g, arg_537_1.hightColor1.g, var_540_3)
								local var_540_6 = Mathf.Lerp(iter_540_1.color.b, arg_537_1.hightColor1.b, var_540_3)

								iter_540_1.color = Color.New(var_540_4, var_540_5, var_540_6)
							else
								local var_540_7 = Mathf.Lerp(iter_540_1.color.r, 1, var_540_3)

								iter_540_1.color = Color.New(var_540_7, var_540_7, var_540_7)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= var_540_1 + var_540_2 and arg_537_1.time_ < var_540_1 + var_540_2 + arg_540_0 and not isNil(var_540_0) and arg_537_1.var_.actorSpriteComps10111 then
				for iter_540_2, iter_540_3 in pairs(arg_537_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_540_3 then
						if arg_537_1.isInRecall_ then
							iter_540_3.color = arg_537_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_540_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_537_1.var_.actorSpriteComps10111 = nil
			end

			local var_540_8 = arg_537_1.actors_["10111"].transform
			local var_540_9 = 0

			if var_540_9 < arg_537_1.time_ and arg_537_1.time_ <= var_540_9 + arg_540_0 then
				arg_537_1.var_.moveOldPos10111 = var_540_8.localPosition
				var_540_8.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("10111", 3)

				local var_540_10 = var_540_8.childCount

				for iter_540_4 = 0, var_540_10 - 1 do
					local var_540_11 = var_540_8:GetChild(iter_540_4)

					if var_540_11.name == "" or not string.find(var_540_11.name, "split") then
						var_540_11.gameObject:SetActive(true)
					else
						var_540_11.gameObject:SetActive(false)
					end
				end
			end

			local var_540_12 = 0.001

			if var_540_9 <= arg_537_1.time_ and arg_537_1.time_ < var_540_9 + var_540_12 then
				local var_540_13 = (arg_537_1.time_ - var_540_9) / var_540_12
				local var_540_14 = Vector3.New(0, -361.1, -274.6)

				var_540_8.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos10111, var_540_14, var_540_13)
			end

			if arg_537_1.time_ >= var_540_9 + var_540_12 and arg_537_1.time_ < var_540_9 + var_540_12 + arg_540_0 then
				var_540_8.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_540_15 = 0
			local var_540_16 = 0.575

			if var_540_15 < arg_537_1.time_ and arg_537_1.time_ <= var_540_15 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_17 = arg_537_1:FormatText(StoryNameCfg[1125].name)

				arg_537_1.leftNameTxt_.text = var_540_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_18 = arg_537_1:GetWordFromCfg(417232131)
				local var_540_19 = arg_537_1:FormatText(var_540_18.content)

				arg_537_1.text_.text = var_540_19

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_20 = 23
				local var_540_21 = utf8.len(var_540_19)
				local var_540_22 = var_540_20 <= 0 and var_540_16 or var_540_16 * (var_540_21 / var_540_20)

				if var_540_22 > 0 and var_540_16 < var_540_22 then
					arg_537_1.talkMaxDuration = var_540_22

					if var_540_22 + var_540_15 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_22 + var_540_15
					end
				end

				arg_537_1.text_.text = var_540_19
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232131", "story_v_out_417232.awb") ~= 0 then
					local var_540_23 = manager.audio:GetVoiceLength("story_v_out_417232", "417232131", "story_v_out_417232.awb") / 1000

					if var_540_23 + var_540_15 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_23 + var_540_15
					end

					if var_540_18.prefab_name ~= "" and arg_537_1.actors_[var_540_18.prefab_name] ~= nil then
						local var_540_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_18.prefab_name].transform, "story_v_out_417232", "417232131", "story_v_out_417232.awb")

						arg_537_1:RecordAudio("417232131", var_540_24)
						arg_537_1:RecordAudio("417232131", var_540_24)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_417232", "417232131", "story_v_out_417232.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_417232", "417232131", "story_v_out_417232.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_25 = math.max(var_540_16, arg_537_1.talkMaxDuration)

			if var_540_15 <= arg_537_1.time_ and arg_537_1.time_ < var_540_15 + var_540_25 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_15) / var_540_25

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_15 + var_540_25 and arg_537_1.time_ < var_540_15 + var_540_25 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play417232132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 417232132
		arg_541_1.duration_ = 9.03

		local var_541_0 = {
			zh = 7.733,
			ja = 9.033
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play417232133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["10111"].transform
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.var_.moveOldPos10111 = var_544_0.localPosition
				var_544_0.localScale = Vector3.New(1, 1, 1)

				arg_541_1:CheckSpriteTmpPos("10111", 3)

				local var_544_2 = var_544_0.childCount

				for iter_544_0 = 0, var_544_2 - 1 do
					local var_544_3 = var_544_0:GetChild(iter_544_0)

					if var_544_3.name == "split_2" or not string.find(var_544_3.name, "split") then
						var_544_3.gameObject:SetActive(true)
					else
						var_544_3.gameObject:SetActive(false)
					end
				end
			end

			local var_544_4 = 0.001

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_4 then
				local var_544_5 = (arg_541_1.time_ - var_544_1) / var_544_4
				local var_544_6 = Vector3.New(0, -361.1, -274.6)

				var_544_0.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10111, var_544_6, var_544_5)
			end

			if arg_541_1.time_ >= var_544_1 + var_544_4 and arg_541_1.time_ < var_544_1 + var_544_4 + arg_544_0 then
				var_544_0.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_544_7 = 0
			local var_544_8 = 0.975

			if var_544_7 < arg_541_1.time_ and arg_541_1.time_ <= var_544_7 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_9 = arg_541_1:FormatText(StoryNameCfg[1125].name)

				arg_541_1.leftNameTxt_.text = var_544_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_10 = arg_541_1:GetWordFromCfg(417232132)
				local var_544_11 = arg_541_1:FormatText(var_544_10.content)

				arg_541_1.text_.text = var_544_11

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_12 = 39
				local var_544_13 = utf8.len(var_544_11)
				local var_544_14 = var_544_12 <= 0 and var_544_8 or var_544_8 * (var_544_13 / var_544_12)

				if var_544_14 > 0 and var_544_8 < var_544_14 then
					arg_541_1.talkMaxDuration = var_544_14

					if var_544_14 + var_544_7 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_14 + var_544_7
					end
				end

				arg_541_1.text_.text = var_544_11
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232132", "story_v_out_417232.awb") ~= 0 then
					local var_544_15 = manager.audio:GetVoiceLength("story_v_out_417232", "417232132", "story_v_out_417232.awb") / 1000

					if var_544_15 + var_544_7 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_15 + var_544_7
					end

					if var_544_10.prefab_name ~= "" and arg_541_1.actors_[var_544_10.prefab_name] ~= nil then
						local var_544_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_10.prefab_name].transform, "story_v_out_417232", "417232132", "story_v_out_417232.awb")

						arg_541_1:RecordAudio("417232132", var_544_16)
						arg_541_1:RecordAudio("417232132", var_544_16)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_417232", "417232132", "story_v_out_417232.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_417232", "417232132", "story_v_out_417232.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_17 = math.max(var_544_8, arg_541_1.talkMaxDuration)

			if var_544_7 <= arg_541_1.time_ and arg_541_1.time_ < var_544_7 + var_544_17 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_7) / var_544_17

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_7 + var_544_17 and arg_541_1.time_ < var_544_7 + var_544_17 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play417232133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 417232133
		arg_545_1.duration_ = 8.17

		local var_545_0 = {
			zh = 5.2,
			ja = 8.166
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play417232134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.575

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[1125].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_3 = arg_545_1:GetWordFromCfg(417232133)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 23
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232133", "story_v_out_417232.awb") ~= 0 then
					local var_548_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232133", "story_v_out_417232.awb") / 1000

					if var_548_8 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_8 + var_548_0
					end

					if var_548_3.prefab_name ~= "" and arg_545_1.actors_[var_548_3.prefab_name] ~= nil then
						local var_548_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_3.prefab_name].transform, "story_v_out_417232", "417232133", "story_v_out_417232.awb")

						arg_545_1:RecordAudio("417232133", var_548_9)
						arg_545_1:RecordAudio("417232133", var_548_9)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_417232", "417232133", "story_v_out_417232.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_417232", "417232133", "story_v_out_417232.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_10 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_10 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_10

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_10 and arg_545_1.time_ < var_548_0 + var_548_10 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play417232134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 417232134
		arg_549_1.duration_ = 8.07

		local var_549_0 = {
			zh = 6.133,
			ja = 8.066
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play417232135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.475

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[1125].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(417232134)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 19
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232134", "story_v_out_417232.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_out_417232", "417232134", "story_v_out_417232.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_out_417232", "417232134", "story_v_out_417232.awb")

						arg_549_1:RecordAudio("417232134", var_552_9)
						arg_549_1:RecordAudio("417232134", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_417232", "417232134", "story_v_out_417232.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_417232", "417232134", "story_v_out_417232.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play417232135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 417232135
		arg_553_1.duration_ = 4.63

		local var_553_0 = {
			zh = 3.1,
			ja = 4.633
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
			arg_553_1.auto_ = false
		end

		function arg_553_1.playNext_(arg_555_0)
			arg_553_1.onStoryFinished_()
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1034"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps1034 == nil then
				arg_553_1.var_.actorSpriteComps1034 = var_556_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.actorSpriteComps1034 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								local var_556_4 = Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, var_556_3)
								local var_556_5 = Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, var_556_3)
								local var_556_6 = Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, var_556_3)

								iter_556_1.color = Color.New(var_556_4, var_556_5, var_556_6)
							else
								local var_556_7 = Mathf.Lerp(iter_556_1.color.r, 1, var_556_3)

								iter_556_1.color = Color.New(var_556_7, var_556_7, var_556_7)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.actorSpriteComps1034 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_556_3 then
						if arg_553_1.isInRecall_ then
							iter_556_3.color = arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_556_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_553_1.var_.actorSpriteComps1034 = nil
			end

			local var_556_8 = arg_553_1.actors_["10111"].transform
			local var_556_9 = 0

			if var_556_9 < arg_553_1.time_ and arg_553_1.time_ <= var_556_9 + arg_556_0 then
				arg_553_1.var_.moveOldPos10111 = var_556_8.localPosition
				var_556_8.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10111", 7)

				local var_556_10 = var_556_8.childCount

				for iter_556_4 = 0, var_556_10 - 1 do
					local var_556_11 = var_556_8:GetChild(iter_556_4)

					if var_556_11.name == "" or not string.find(var_556_11.name, "split") then
						var_556_11.gameObject:SetActive(true)
					else
						var_556_11.gameObject:SetActive(false)
					end
				end
			end

			local var_556_12 = 0.001

			if var_556_9 <= arg_553_1.time_ and arg_553_1.time_ < var_556_9 + var_556_12 then
				local var_556_13 = (arg_553_1.time_ - var_556_9) / var_556_12
				local var_556_14 = Vector3.New(0, -2000, 0)

				var_556_8.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10111, var_556_14, var_556_13)
			end

			if arg_553_1.time_ >= var_556_9 + var_556_12 and arg_553_1.time_ < var_556_9 + var_556_12 + arg_556_0 then
				var_556_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_556_15 = arg_553_1.actors_["1034"].transform
			local var_556_16 = 0

			if var_556_16 < arg_553_1.time_ and arg_553_1.time_ <= var_556_16 + arg_556_0 then
				arg_553_1.var_.moveOldPos1034 = var_556_15.localPosition
				var_556_15.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("1034", 3)

				local var_556_17 = var_556_15.childCount

				for iter_556_5 = 0, var_556_17 - 1 do
					local var_556_18 = var_556_15:GetChild(iter_556_5)

					if var_556_18.name == "" or not string.find(var_556_18.name, "split") then
						var_556_18.gameObject:SetActive(true)
					else
						var_556_18.gameObject:SetActive(false)
					end
				end
			end

			local var_556_19 = 0.001

			if var_556_16 <= arg_553_1.time_ and arg_553_1.time_ < var_556_16 + var_556_19 then
				local var_556_20 = (arg_553_1.time_ - var_556_16) / var_556_19
				local var_556_21 = Vector3.New(0, -331.9, -324)

				var_556_15.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1034, var_556_21, var_556_20)
			end

			if arg_553_1.time_ >= var_556_16 + var_556_19 and arg_553_1.time_ < var_556_16 + var_556_19 + arg_556_0 then
				var_556_15.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_556_22 = 0
			local var_556_23 = 0.25

			if var_556_22 < arg_553_1.time_ and arg_553_1.time_ <= var_556_22 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_24 = arg_553_1:FormatText(StoryNameCfg[1109].name)

				arg_553_1.leftNameTxt_.text = var_556_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_25 = arg_553_1:GetWordFromCfg(417232135)
				local var_556_26 = arg_553_1:FormatText(var_556_25.content)

				arg_553_1.text_.text = var_556_26

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_27 = 10
				local var_556_28 = utf8.len(var_556_26)
				local var_556_29 = var_556_27 <= 0 and var_556_23 or var_556_23 * (var_556_28 / var_556_27)

				if var_556_29 > 0 and var_556_23 < var_556_29 then
					arg_553_1.talkMaxDuration = var_556_29

					if var_556_29 + var_556_22 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_29 + var_556_22
					end
				end

				arg_553_1.text_.text = var_556_26
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417232", "417232135", "story_v_out_417232.awb") ~= 0 then
					local var_556_30 = manager.audio:GetVoiceLength("story_v_out_417232", "417232135", "story_v_out_417232.awb") / 1000

					if var_556_30 + var_556_22 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_30 + var_556_22
					end

					if var_556_25.prefab_name ~= "" and arg_553_1.actors_[var_556_25.prefab_name] ~= nil then
						local var_556_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_25.prefab_name].transform, "story_v_out_417232", "417232135", "story_v_out_417232.awb")

						arg_553_1:RecordAudio("417232135", var_556_31)
						arg_553_1:RecordAudio("417232135", var_556_31)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_417232", "417232135", "story_v_out_417232.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_417232", "417232135", "story_v_out_417232.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_32 = math.max(var_556_23, arg_553_1.talkMaxDuration)

			if var_556_22 <= arg_553_1.time_ and arg_553_1.time_ < var_556_22 + var_556_32 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_22) / var_556_32

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_22 + var_556_32 and arg_553_1.time_ < var_556_22 + var_556_32 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2102",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST69a",
		"TextureConfig/Background/I17f"
	},
	voices = {
		"story_v_out_417232.awb"
	}
}
